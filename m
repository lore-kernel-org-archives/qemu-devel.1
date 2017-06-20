Received: from eggs.gnu.org ([2001:4830:134:3::10]:51703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dN7wR-0005JA-4R
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 21:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dN7wP-0008TK-Hh
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 21:26:51 -0400
Date: Tue, 20 Jun 2017 09:12:49 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170620011249.GL22449@umbus>
References: <20170608050930.2613-1-david@gibson.dropbear.id.au>
	<20170608050930.2613-7-david@gibson.dropbear.id.au>
	<149791274735.25078.4110942481519654764@loki>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V3eawNQxI9TAjvgi"
Content-Disposition: inline
In-Reply-To: <149791274735.25078.4110942481519654764@loki>
Subject: Re: [Qemu-devel] [PATCH 6/6] spapr: Clean up DRC
 set_isolation_state() path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: bharata@linux.vnet.ibm.com, sursingh@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--V3eawNQxI9TAjvgi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 19, 2017 at 05:52:27PM -0500, Michael Roth wrote:
> Quoting David Gibson (2017-06-08 00:09:30)
> > There are substantial differences in the various paths through
> > set_isolation_state(), both for setting to ISOLATED versus UNISOLATED
> > state and for logical versus physical DRCs.
> >=20
> > So, split the set_isolation_state() method into isolate() and unisolate=
()
> > methods, and give it different implementations for the two DRC types.
> >=20
> > Factor some minimal common checks, including for valid indicator values
> > (which we weren't previously checking) into rtas_set_isolation_state().
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr_drc.c         | 145 ++++++++++++++++++++++++++++++++-----=
--------
> >  include/hw/ppc/spapr_drc.h |   6 +-
> >  2 files changed, 105 insertions(+), 46 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > index 9e01d7b..90c0fde 100644
> > --- a/hw/ppc/spapr_drc.c
> > +++ b/hw/ppc/spapr_drc.c
> > @@ -46,30 +46,64 @@ uint32_t spapr_drc_index(sPAPRDRConnector *drc)
> >          | (drc->id & DRC_INDEX_ID_MASK);
> >  }
> >=20
> > -static uint32_t set_isolation_state(sPAPRDRConnector *drc,
> > -                                    sPAPRDRIsolationState state)
> > +static uint32_t drc_isolate_physical(sPAPRDRConnector *drc)
> >  {
> > -    trace_spapr_drc_set_isolation_state(spapr_drc_index(drc), state);
> > -
> >      /* if the guest is configuring a device attached to this DRC, we
> >       * should reset the configuration state at this point since it may
> >       * no longer be reliable (guest released device and needs to start
> >       * over, or unplug occurred so the FDT is no longer valid)
> >       */
> > -    if (state =3D=3D SPAPR_DR_ISOLATION_STATE_ISOLATED) {
> > -        g_free(drc->ccs);
> > -        drc->ccs =3D NULL;
> > -    }
> > +    g_free(drc->ccs);
> > +    drc->ccs =3D NULL;
> >=20
> > -    if (state =3D=3D SPAPR_DR_ISOLATION_STATE_UNISOLATED) {
> > -        /* cannot unisolate a non-existent resource, and, or resources
> > -         * which are in an 'UNUSABLE' allocation state. (PAPR 2.7, 13.=
5.3.5)
> > -         */
> > -        if (!drc->dev ||
> > -            drc->allocation_state =3D=3D SPAPR_DR_ALLOCATION_STATE_UNU=
SABLE) {
> > -            return RTAS_OUT_NO_SUCH_INDICATOR;
> > +    drc->isolation_state =3D SPAPR_DR_ISOLATION_STATE_ISOLATED;
> > +
> > +    /* if we're awaiting release, but still in an unconfigured state,
> > +     * it's likely the guest is still in the process of configuring
> > +     * the device and is transitioning the devices to an ISOLATED
> > +     * state as a part of that process. so we only complete the
> > +     * removal when this transition happens for a device in a
> > +     * configured state, as suggested by the state diagram from PAPR+
> > +     * 2.7, 13.4
> > +     */
> > +    if (drc->awaiting_release) {
> > +        uint32_t drc_index =3D spapr_drc_index(drc);
> > +        if (drc->configured) {
> > +            trace_spapr_drc_set_isolation_state_finalizing(drc_index);
> > +            spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
> > +        } else {
> > +            trace_spapr_drc_set_isolation_state_deferring(drc_index);
> >          }
> >      }
> > +    drc->configured =3D false;
> > +
> > +    return RTAS_OUT_SUCCESS;
> > +}
> > +
> > +static uint32_t drc_unisolate_physical(sPAPRDRConnector *drc)
> > +{
> > +    /* cannot unisolate a non-existent resource, and, or resources
> > +     * which are in an 'UNUSABLE' allocation state. (PAPR 2.7,
> > +     * 13.5.3.5)
> > +     */
> > +    if (!drc->dev) {
> > +        return RTAS_OUT_NO_SUCH_INDICATOR;
> > +    }
> > +
> > +    drc->isolation_state =3D SPAPR_DR_ISOLATION_STATE_UNISOLATED;
> > +
> > +    return RTAS_OUT_SUCCESS;
> > +}
> > +
> > +static uint32_t drc_isolate_logical(sPAPRDRConnector *drc)
> > +{
> > +    /* if the guest is configuring a device attached to this DRC, we
> > +     * should reset the configuration state at this point since it may
> > +     * no longer be reliable (guest released device and needs to start
> > +     * over, or unplug occurred so the FDT is no longer valid)
> > +     */
> > +    g_free(drc->ccs);
> > +    drc->ccs =3D NULL;
> >=20
> >      /*
> >       * Fail any requests to ISOLATE the LMB DRC if this LMB doesn't
> > @@ -81,35 +115,47 @@ static uint32_t set_isolation_state(sPAPRDRConnect=
or *drc,
> >       * If the LMB being removed doesn't belong to a DIMM device that is
> >       * actually being unplugged, fail the isolation request here.
> >       */
> > -    if (spapr_drc_type(drc) =3D=3D SPAPR_DR_CONNECTOR_TYPE_LMB) {
> > -        if ((state =3D=3D SPAPR_DR_ISOLATION_STATE_ISOLATED) &&
> > -             !drc->awaiting_release) {
> > -            return RTAS_OUT_HW_ERROR;
> > -        }
> > +    if (spapr_drc_type(drc) =3D=3D SPAPR_DR_CONNECTOR_TYPE_LMB
> > +        && !drc->awaiting_release) {
> > +        return RTAS_OUT_HW_ERROR;
> >      }
> >=20
> > -    drc->isolation_state =3D state;
> > +    drc->isolation_state =3D SPAPR_DR_ISOLATION_STATE_ISOLATED;
> >=20
> > -    if (drc->isolation_state =3D=3D SPAPR_DR_ISOLATION_STATE_ISOLATED)=
 {
> > -        /* if we're awaiting release, but still in an unconfigured sta=
te,
> > -         * it's likely the guest is still in the process of configuring
> > -         * the device and is transitioning the devices to an ISOLATED
> > -         * state as a part of that process. so we only complete the
> > -         * removal when this transition happens for a device in a
> > -         * configured state, as suggested by the state diagram from
> > -         * PAPR+ 2.7, 13.4
> > -         */
> > -        if (drc->awaiting_release) {
> > -            uint32_t drc_index =3D spapr_drc_index(drc);
> > -            if (drc->configured) {
> > -                trace_spapr_drc_set_isolation_state_finalizing(drc_ind=
ex);
> > -                spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
> > -            } else {
> > -                trace_spapr_drc_set_isolation_state_deferring(drc_inde=
x);
> > -            }
> > +    /* if we're awaiting release, but still in an unconfigured state,
> > +     * it's likely the guest is still in the process of configuring
> > +     * the device and is transitioning the devices to an ISOLATED
> > +     * state as a part of that process. so we only complete the
> > +     * removal when this transition happens for a device in a
> > +     * configured state, as suggested by the state diagram from PAPR+
> > +     * 2.7, 13.4
> > +     */
> > +    if (drc->awaiting_release) {
> > +        uint32_t drc_index =3D spapr_drc_index(drc);
> > +        if (drc->configured) {
> > +            trace_spapr_drc_set_isolation_state_finalizing(drc_index);
> > +            spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
> > +        } else {
> > +            trace_spapr_drc_set_isolation_state_deferring(drc_index);
>=20
> Not sure this is the right patch to do it, but this refactoring does make
> it more apparent that the if (drc->configured) checks should get pushed
> down into spapr_drc_detach() like the other deferral checks at some point.
>=20
> (There are 2 locations that do the detach without checking configured,
> but you switched out the one in reset() to use spapr_drc_release()
> already, and I don't think drc_set_unusable() without first going
> through drc_isolate_*() is a transition that PAPR would allow anyway)

Right, but no, I don't think this patch is the place to do it.

I'll see what this looks like once I've made other cleanups on my
queue.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--V3eawNQxI9TAjvgi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZSHaRAAoJEGw4ysog2bOS1IsQALP9lIiph+8iUm7rs52QEvmR
mIgNdbWMT/QDTLTZ4rwUFWdgd1WpoB+az7lQQ+3Gq9KehE+YEGBoxwf/WpzLds4t
2uS/KtJdyirCRbxvPXBLSo1fDos5R7JBu9fi3S+lsT9Zv1DK/jo7VbUODjL3aSUz
ZxjNLz2KN710X45mvavRm0/vr1scuQ4oEvk+B6bs8jDp4IEjWKNqkJbQRpbWovhv
3Iaz9u+KHP4fhRdQQRQ62btYKsUDU7N0qrtWhHAIFlC/OZ68+ISfJA9N+AN9KMs0
Ln8VcLZ+CFKzJjmkN4jGDAwEyhT6Y92sut8KKTO+wuE3i6BwoLyyBFkCcGaUPpK1
HNHfqG7YzT8JKRjXVJT4LLzynJkg0qQ1zDATix7H83Nd0NpClFWH7MaAn57M6RmM
hejb98bFqvCEDcDJCaqPE5CjeXdRl0RceGAGeihLz/Bnz2OOVyMFpsFk5/5jVHNk
S4R54ObzYJpTsqLWxvxIdK/Dv0z6phWmKyi1MtZFnW3zW/Oe1jlRAVQ6NLRSZKBz
ytMZw6opqSJ6B5eK25LLbSypCBhXx9n6t2mqwhhVkBA5uhNIvh3u48G3GAb7KzBS
NKdsDWrfPmypV9ABtSL0TIUZox8jqYycONttksb0I0lGucNOQTpPYUCeGYlVyGke
DWU3eZCLQ0w4Z8huQVS8
=QgwZ
-----END PGP SIGNATURE-----

--V3eawNQxI9TAjvgi--
