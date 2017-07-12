Received: from eggs.gnu.org ([2001:4830:134:3::10]:36816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVFTD-0006NE-Ly
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:06:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVFTC-0008Ck-Ia
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:06:15 -0400
Date: Wed, 12 Jul 2017 21:05:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170712110545.GN4083@umbus.fritz.box>
References: <20170712055317.26225-1-david@gibson.dropbear.id.au>
	<20170712055317.26225-3-david@gibson.dropbear.id.au>
	<20170712120001.31d858de@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E0h0CbphJD8hN+Gf"
Content-Disposition: inline
In-Reply-To: <20170712120001.31d858de@bahia.lan>
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
To: Greg Kurz <groug@kaod.org>
Cc: mdroth@linux.vnet.ibm.com, danielhb@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, sjitindarsingh@gmail.com, bharata@linux.vnet.ibm.com


--E0h0CbphJD8hN+Gf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2017 at 12:00:01PM +0200, Greg Kurz wrote:
> On Wed, 12 Jul 2017 15:53:11 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > The awaiting_allocation flag in the DRC was introduced by aab9913
> > "spapr_drc: Prevent detach racing against attach for CPU DR", allegedly=
 to
> > prevent a guest crash on racing attach and detach.  Except.. information
> > from the BZ actually suggests a qemu crash, not a guest crash.  And the=
re
>=20
> Can you share an url to the BZ ?

Alas, no.  I have that information second hand from.. Bharata,
think.. and I believe the BZ is an IBM internal one.

>=20
> > shouldn't be a problem here anyway: if the guest has already moved the =
DRC
> > away from UNUSABLE state, the detach would already be deferred, and if =
it
> > hadn't it should be safe to detach it (the guest should fail gracefully
> > when it attempts to change the allocation state).
> >=20
> > I think this was probably just a bandaid for some other problem in the
> > state management.  So, remove awaiting_allocation and associated code.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr_drc.c         | 25 +++----------------------
> >  include/hw/ppc/spapr_drc.h |  1 -
> >  2 files changed, 3 insertions(+), 23 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > index 9b07f80..89ba3d6 100644
> > --- a/hw/ppc/spapr_drc.c
> > +++ b/hw/ppc/spapr_drc.c
> > @@ -170,19 +170,13 @@ static uint32_t drc_set_usable(sPAPRDRConnector *=
drc)
> >      if (!drc->dev) {
> >          return RTAS_OUT_NO_SUCH_INDICATOR;
> >      }
> > -    if (drc->awaiting_release && drc->awaiting_allocation) {
> > -        /* kernel is acknowledging a previous hotplug event
> > -         * while we are already removing it.
> > -         * it's safe to ignore awaiting_allocation here since we know =
the
> > -         * situation is predicated on the guest either already having =
done
> > -         * so (boot-time hotplug), or never being able to acquire in t=
he
> > -         * first place (hotplug followed by immediate unplug).
> > -         */
> > +    if (drc->awaiting_release) {
> > +        /* Don't allow the guest to move a device away from UNUSABLE
> > +         * state when we want to unplug it */
> >          return RTAS_OUT_NO_SUCH_INDICATOR;
> >      }
> > =20
> >      drc->allocation_state =3D SPAPR_DR_ALLOCATION_STATE_USABLE;
> > -    drc->awaiting_allocation =3D false;
> > =20
> >      return RTAS_OUT_SUCCESS;
> >  }
> > @@ -357,10 +351,6 @@ void spapr_drc_attach(sPAPRDRConnector *drc, Devic=
eState *d, void *fdt,
> >      drc->fdt =3D fdt;
> >      drc->fdt_start_offset =3D fdt_start_offset;
> > =20
> > -    if (spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
> > -        drc->awaiting_allocation =3D true;
> > -    }
> > -
> >      object_property_add_link(OBJECT(drc), "device",
> >                               object_get_typename(OBJECT(drc->dev)),
> >                               (Object **)(&drc->dev),
> > @@ -398,12 +388,6 @@ void spapr_drc_detach(sPAPRDRConnector *drc, Devic=
eState *d, Error **errp)
> >          return;
> >      }
> > =20
> > -    if (drc->awaiting_allocation) {
> > -        drc->awaiting_release =3D true;
> > -        trace_spapr_drc_awaiting_allocation(spapr_drc_index(drc));
> > -        return;
> > -    }
> > -
> >      spapr_drc_release(drc);
> >  }
> > =20
> > @@ -426,8 +410,6 @@ void spapr_drc_reset(sPAPRDRConnector *drc)
> >          spapr_drc_release(drc);
> >      }
> > =20
> > -    drc->awaiting_allocation =3D false;
> > -
> >      if (drc->dev) {
> >          /* A device present at reset is coldplugged */
> >          drc->isolation_state =3D SPAPR_DR_ISOLATION_STATE_UNISOLATED;
> > @@ -493,7 +475,6 @@ static const VMStateDescription vmstate_spapr_drc =
=3D {
> >          VMSTATE_UINT32(dr_indicator, sPAPRDRConnector),
> >          VMSTATE_BOOL(configured, sPAPRDRConnector),
> >          VMSTATE_BOOL(awaiting_release, sPAPRDRConnector),
> > -        VMSTATE_BOOL(awaiting_allocation, sPAPRDRConnector),
> >          VMSTATE_END_OF_LIST()
> >      }
> >  };
> > diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> > index 715016b..18a196e 100644
> > --- a/include/hw/ppc/spapr_drc.h
> > +++ b/include/hw/ppc/spapr_drc.h
> > @@ -200,7 +200,6 @@ typedef struct sPAPRDRConnector {
> >      sPAPRConfigureConnectorState *ccs;
> > =20
> >      bool awaiting_release;
> > -    bool awaiting_allocation;
> > =20
> >      /* device pointer, via link property */
> >      DeviceState *dev;
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--E0h0CbphJD8hN+Gf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZZgKGAAoJEGw4ysog2bOSXC0QAMVRDcuNberuRduZ4DYo/HbR
RVorR6cMxDTKvu1ShH/kan+KQuUX8ULjRpVCC+jzuMdiaRfSfqo4rvvk2WMx86nz
xazZZoiu8lkFDAPrSEfkbqknuBl7zlr4EeOTHQyowI4zj0J4W+f6WM98onG/vLS5
Td2FWD5S7/tNWyBiQvZjvaM2fQpMYX1lCmVHbJ+PlIrzlxGVJThDAYwViL0k2Zrs
3dnPAkb0CO/gCkfjmV7XrtXa+SYv/ztofVN1zKsycB0WULpfbfiiMo1WpPfFHgP2
a3kTMTHkkTQ67hLWOP/C/+gtLrFkRW6pVCcABDfe5vMB4NY6sK0y+rHvvz1k4D3g
aKieZffU4I64MK8T9ClOIJNgea0OgqTrPGP+kctsha5d/UUh5kq7ZlS1Gcuk7pP6
DQRFOKe9qX2NstIAQ+v+34IiS3jVCYRR2AOiKsIr6Q9TnUUa4bqX/tuLowwmq3UE
aA9EvVE3S1d5SLdJly0bFYLQVChOXawKf3WXSI//wML9OYCJdNqwj5B1J89ZWjOF
VMt+hMe66ffZ/YmZX4iHaNhfqQXOl29tBeHxqvlZ+MutzIs3spf0LLNn0i0by5Fh
pRgfShQcXvEzQmN6FUlGbbGwqglVt5FW0tP1x8Vez93oql508H4UrzC46mxOikaB
R8et6yJT1+F6qMIYQlMC
=mnJO
-----END PGP SIGNATURE-----

--E0h0CbphJD8hN+Gf--
