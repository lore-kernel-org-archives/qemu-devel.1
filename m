Received: from eggs.gnu.org ([2001:4830:134:3::10]:32835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dMvUr-0001dc-8O
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:09:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dMvUm-0007ZI-7i
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:09:33 -0400
Received: from 8.mo179.mail-out.ovh.net ([46.105.75.26]:44558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dMvUl-0007X2-US
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:09:28 -0400
Received: from player716.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 58A6E4D932
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 14:09:26 +0200 (CEST)
Date: Mon, 19 Jun 2017 14:09:16 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170619140916.43dcea72@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170608050930.2613-6-david@gibson.dropbear.id.au>
References: <20170608050930.2613-1-david@gibson.dropbear.id.au>
	<20170608050930.2613-6-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/ykQ1ODzrPQTmkVSM=iJhN=E";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 5/6] spapr: Clean up DRC
 set_allocation_state path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, sursingh@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

--Sig_/ykQ1ODzrPQTmkVSM=iJhN=E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu,  8 Jun 2017 15:09:29 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> The allocation-state indicator should only actually be implemented for
> "logical" DRCs, not physical ones.  Factor a check for this, and also for
> valid indicator state values into rtas_set_allocation_state().  Because
> they don't exist for physical DRCs, there's no reason that we'd ever want
> more than one method implementation, so it can just be a plain function.
>=20
> In addition, the setting to USABLE and setting to UNUSABLE paths in
> set_allocation_state() don't actually have much in common.  So, split the
> method separate functions for each parameter value (drc_set_usable()
> and drc_set_unusable()).
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_drc.c         | 85 +++++++++++++++++++++++++---------------=
------
>  include/hw/ppc/spapr_drc.h |  2 --
>  2 files changed, 46 insertions(+), 41 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 7e17f34..9e01d7b 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -114,44 +114,43 @@ static uint32_t set_isolation_state(sPAPRDRConnecto=
r *drc,
>      return RTAS_OUT_SUCCESS;
>  }
> =20
> -static uint32_t set_allocation_state(sPAPRDRConnector *drc,
> -                                     sPAPRDRAllocationState state)
> +static uint32_t drc_set_usable(sPAPRDRConnector *drc)
>  {
> -    trace_spapr_drc_set_allocation_state(spapr_drc_index(drc), state);
> -
> -    if (state =3D=3D SPAPR_DR_ALLOCATION_STATE_USABLE) {
> -        /* if there's no resource/device associated with the DRC, there's
> -         * no way for us to put it in an allocation state consistent with
> -         * being 'USABLE'. PAPR 2.7, 13.5.3.4 documents that this should
> -         * result in an RTAS return code of -3 / "no such indicator"
> +    /* if there's no resource/device associated with the DRC, there's
> +     * no way for us to put it in an allocation state consistent with
> +     * being 'USABLE'. PAPR 2.7, 13.5.3.4 documents that this should
> +     * result in an RTAS return code of -3 / "no such indicator"
> +     */
> +    if (!drc->dev) {
> +        return RTAS_OUT_NO_SUCH_INDICATOR;
> +    }
> +    if (drc->awaiting_release && drc->awaiting_allocation) {
> +        /* kernel is acknowledging a previous hotplug event
> +         * while we are already removing it.
> +         * it's safe to ignore awaiting_allocation here since we know the
> +         * situation is predicated on the guest either already having do=
ne
> +         * so (boot-time hotplug), or never being able to acquire in the
> +         * first place (hotplug followed by immediate unplug).
>           */
> -        if (!drc->dev) {
> -            return RTAS_OUT_NO_SUCH_INDICATOR;
> -        }
> -        if (drc->awaiting_release && drc->awaiting_allocation) {
> -            /* kernel is acknowledging a previous hotplug event
> -             * while we are already removing it.
> -             * it's safe to ignore awaiting_allocation here since we kno=
w the
> -             * situation is predicated on the guest either already havin=
g done
> -             * so (boot-time hotplug), or never being able to acquire in=
 the
> -             * first place (hotplug followed by immediate unplug).
> -             */
> -            drc->awaiting_allocation_skippable =3D true;
> -            return RTAS_OUT_NO_SUCH_INDICATOR;
> -        }
> +        drc->awaiting_allocation_skippable =3D true;
> +        return RTAS_OUT_NO_SUCH_INDICATOR;
>      }
> =20
> -    if (spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
> -        drc->allocation_state =3D state;
> -        if (drc->awaiting_release &&
> -            drc->allocation_state =3D=3D SPAPR_DR_ALLOCATION_STATE_UNUSA=
BLE) {
> -            uint32_t drc_index =3D spapr_drc_index(drc);
> -            trace_spapr_drc_set_allocation_state_finalizing(drc_index);
> -            spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
> -        } else if (drc->allocation_state =3D=3D SPAPR_DR_ALLOCATION_STAT=
E_USABLE) {
> -            drc->awaiting_allocation =3D false;
> -        }
> +    drc->allocation_state =3D SPAPR_DR_ALLOCATION_STATE_USABLE;
> +    drc->awaiting_allocation =3D false;
> +
> +    return RTAS_OUT_SUCCESS;
> +}
> +
> +static uint32_t drc_set_unusable(sPAPRDRConnector *drc)
> +{
> +    drc->allocation_state =3D SPAPR_DR_ALLOCATION_STATE_UNUSABLE;
> +    if (drc->awaiting_release) {
> +        uint32_t drc_index =3D spapr_drc_index(drc);
> +        trace_spapr_drc_set_allocation_state_finalizing(drc_index);
> +        spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
>      }
> +
>      return RTAS_OUT_SUCCESS;
>  }
> =20
> @@ -553,7 +552,6 @@ static void spapr_dr_connector_class_init(ObjectClass=
 *k, void *data)
>      dk->realize =3D realize;
>      dk->unrealize =3D unrealize;
>      drck->set_isolation_state =3D set_isolation_state;
> -    drck->set_allocation_state =3D set_allocation_state;
>      drck->release_pending =3D release_pending;
>      /*
>       * Reason: it crashes FIXME find and document the real reason
> @@ -823,14 +821,23 @@ static uint32_t rtas_set_isolation_state(uint32_t i=
dx, uint32_t state)
>  static uint32_t rtas_set_allocation_state(uint32_t idx, uint32_t state)
>  {
>      sPAPRDRConnector *drc =3D spapr_drc_by_index(idx);
> -    sPAPRDRConnectorClass *drck;
> =20
> -    if (!drc) {
> -        return RTAS_OUT_PARAM_ERROR;
> +    if (!drc || !object_dynamic_cast(OBJECT(drc), TYPE_SPAPR_DRC_LOGICAL=
)) {
> +        return RTAS_OUT_NO_SUCH_INDICATOR;
>      }
> =20
> -    drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> -    return drck->set_allocation_state(drc, state);
> +    trace_spapr_drc_set_allocation_state(spapr_drc_index(drc), state);
> +
> +    switch (state) {
> +    case SPAPR_DR_ALLOCATION_STATE_USABLE:
> +        return drc_set_usable(drc);
> +
> +    case SPAPR_DR_ALLOCATION_STATE_UNUSABLE:
> +        return drc_set_unusable(drc);
> +
> +    default:
> +        return RTAS_OUT_PARAM_ERROR;
> +    }
>  }
> =20
>  static uint32_t rtas_set_dr_indicator(uint32_t idx, uint32_t state)
> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> index f24188d..0e09afb 100644
> --- a/include/hw/ppc/spapr_drc.h
> +++ b/include/hw/ppc/spapr_drc.h
> @@ -220,8 +220,6 @@ typedef struct sPAPRDRConnectorClass {
>      /* accessors for guest-visible (generally via RTAS) DR state */
>      uint32_t (*set_isolation_state)(sPAPRDRConnector *drc,
>                                      sPAPRDRIsolationState state);
> -    uint32_t (*set_allocation_state)(sPAPRDRConnector *drc,
> -                                     sPAPRDRAllocationState state);
> =20
>      /* QEMU interfaces for managing hotplug operations */
>      bool (*release_pending)(sPAPRDRConnector *drc);


--Sig_/ykQ1ODzrPQTmkVSM=iJhN=E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllHvuwACgkQAvw66wEB28ISQgCfRGU1MPiOo8VMnh4oyWQZwMNI
Go8AoI+6LjCqQRd6oQ54M+LsTMl0nKKS
=pvDZ
-----END PGP SIGNATURE-----

--Sig_/ykQ1ODzrPQTmkVSM=iJhN=E--
