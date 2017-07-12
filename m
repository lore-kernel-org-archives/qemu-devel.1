Received: from eggs.gnu.org ([2001:4830:134:3::10]:43072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dVFoD-0008Om-So
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:27:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dVFo9-0000PI-TS
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:27:57 -0400
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:56996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dVFo9-0000Ox-Jl
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:27:53 -0400
Received: from player750.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 23F726BFAD
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 13:27:52 +0200 (CEST)
Date: Wed, 12 Jul 2017 13:27:42 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170712132742.368db8d8@bahia.lan>
In-Reply-To: <20170712110545.GN4083@umbus.fritz.box>
References: <20170712055317.26225-1-david@gibson.dropbear.id.au>
	<20170712055317.26225-3-david@gibson.dropbear.id.au>
	<20170712120001.31d858de@bahia.lan>
	<20170712110545.GN4083@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/fg8duMMSRFiv+k9/UYSTA+t";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCHv2 2/8] spapr: Remove 'awaiting_allocation'
 DRC flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: mdroth@linux.vnet.ibm.com, danielhb@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, sjitindarsingh@gmail.com, bharata@linux.vnet.ibm.com

--Sig_/fg8duMMSRFiv+k9/UYSTA+t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Jul 2017 21:05:45 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Jul 12, 2017 at 12:00:01PM +0200, Greg Kurz wrote:
> > On Wed, 12 Jul 2017 15:53:11 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > The awaiting_allocation flag in the DRC was introduced by aab9913
> > > "spapr_drc: Prevent detach racing against attach for CPU DR", alleged=
ly to
> > > prevent a guest crash on racing attach and detach.  Except.. informat=
ion
> > > from the BZ actually suggests a qemu crash, not a guest crash.  And t=
here =20
> >=20
> > Can you share an url to the BZ ? =20
>=20
> Alas, no.  I have that information second hand from.. Bharata,
> think.. and I believe the BZ is an IBM internal one.
>=20

I did some digging and I could find it in our internal bugzilla. And indeed,
it mentions QEMU crashing because of a SEGV...

> >  =20
> > > shouldn't be a problem here anyway: if the guest has already moved th=
e DRC
> > > away from UNUSABLE state, the detach would already be deferred, and i=
f it
> > > hadn't it should be safe to detach it (the guest should fail graceful=
ly
> > > when it attempts to change the allocation state).
> > >=20
> > > I think this was probably just a bandaid for some other problem in the
> > > state management.  So, remove awaiting_allocation and associated code.
> > >=20

... so I tend to agree this was a bandaid.

Reviewed-by: Greg Kurz <groug@kaod.org>

I'll re-try the scenario from the BZ with this patch applied to see if we
hit the crash again.

> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > ---
> > >  hw/ppc/spapr_drc.c         | 25 +++----------------------
> > >  include/hw/ppc/spapr_drc.h |  1 -
> > >  2 files changed, 3 insertions(+), 23 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > > index 9b07f80..89ba3d6 100644
> > > --- a/hw/ppc/spapr_drc.c
> > > +++ b/hw/ppc/spapr_drc.c
> > > @@ -170,19 +170,13 @@ static uint32_t drc_set_usable(sPAPRDRConnector=
 *drc)
> > >      if (!drc->dev) {
> > >          return RTAS_OUT_NO_SUCH_INDICATOR;
> > >      }
> > > -    if (drc->awaiting_release && drc->awaiting_allocation) {
> > > -        /* kernel is acknowledging a previous hotplug event
> > > -         * while we are already removing it.
> > > -         * it's safe to ignore awaiting_allocation here since we kno=
w the
> > > -         * situation is predicated on the guest either already havin=
g done
> > > -         * so (boot-time hotplug), or never being able to acquire in=
 the
> > > -         * first place (hotplug followed by immediate unplug).
> > > -         */
> > > +    if (drc->awaiting_release) {
> > > +        /* Don't allow the guest to move a device away from UNUSABLE
> > > +         * state when we want to unplug it */
> > >          return RTAS_OUT_NO_SUCH_INDICATOR;
> > >      }
> > > =20
> > >      drc->allocation_state =3D SPAPR_DR_ALLOCATION_STATE_USABLE;
> > > -    drc->awaiting_allocation =3D false;
> > > =20
> > >      return RTAS_OUT_SUCCESS;
> > >  }
> > > @@ -357,10 +351,6 @@ void spapr_drc_attach(sPAPRDRConnector *drc, Dev=
iceState *d, void *fdt,
> > >      drc->fdt =3D fdt;
> > >      drc->fdt_start_offset =3D fdt_start_offset;
> > > =20
> > > -    if (spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
> > > -        drc->awaiting_allocation =3D true;
> > > -    }
> > > -
> > >      object_property_add_link(OBJECT(drc), "device",
> > >                               object_get_typename(OBJECT(drc->dev)),
> > >                               (Object **)(&drc->dev),
> > > @@ -398,12 +388,6 @@ void spapr_drc_detach(sPAPRDRConnector *drc, Dev=
iceState *d, Error **errp)
> > >          return;
> > >      }
> > > =20
> > > -    if (drc->awaiting_allocation) {
> > > -        drc->awaiting_release =3D true;
> > > -        trace_spapr_drc_awaiting_allocation(spapr_drc_index(drc));
> > > -        return;
> > > -    }
> > > -
> > >      spapr_drc_release(drc);
> > >  }
> > > =20
> > > @@ -426,8 +410,6 @@ void spapr_drc_reset(sPAPRDRConnector *drc)
> > >          spapr_drc_release(drc);
> > >      }
> > > =20
> > > -    drc->awaiting_allocation =3D false;
> > > -
> > >      if (drc->dev) {
> > >          /* A device present at reset is coldplugged */
> > >          drc->isolation_state =3D SPAPR_DR_ISOLATION_STATE_UNISOLATED;
> > > @@ -493,7 +475,6 @@ static const VMStateDescription vmstate_spapr_drc=
 =3D {
> > >          VMSTATE_UINT32(dr_indicator, sPAPRDRConnector),
> > >          VMSTATE_BOOL(configured, sPAPRDRConnector),
> > >          VMSTATE_BOOL(awaiting_release, sPAPRDRConnector),
> > > -        VMSTATE_BOOL(awaiting_allocation, sPAPRDRConnector),
> > >          VMSTATE_END_OF_LIST()
> > >      }
> > >  };
> > > diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> > > index 715016b..18a196e 100644
> > > --- a/include/hw/ppc/spapr_drc.h
> > > +++ b/include/hw/ppc/spapr_drc.h
> > > @@ -200,7 +200,6 @@ typedef struct sPAPRDRConnector {
> > >      sPAPRConfigureConnectorState *ccs;
> > > =20
> > >      bool awaiting_release;
> > > -    bool awaiting_allocation;
> > > =20
> > >      /* device pointer, via link property */
> > >      DeviceState *dev; =20
> >  =20
>=20
>=20
>=20


--Sig_/fg8duMMSRFiv+k9/UYSTA+t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllmB64ACgkQAvw66wEB28JZbQCfVzDeR5rFCXGUDLrb0lPMvyML
RkQAnRacw3WZUHHNz/3LbuyEcV4C4zDQ
=eN1L
-----END PGP SIGNATURE-----

--Sig_/fg8duMMSRFiv+k9/UYSTA+t--
