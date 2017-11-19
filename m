Received: from eggs.gnu.org ([2001:4830:134:3::10]:48451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eGZ76-0005vY-AO
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 18:35:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eGZ71-000705-PM
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 18:35:00 -0500
Date: Mon, 20 Nov 2017 10:12:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171119231233.GB19214@umbus.fritz.box>
References: <151092340873.11818.16813698420232981002.stgit@bahia>
	<48df4371-5966-a428-f5df-37c014c1ab94@linux.vnet.ibm.com>
	<151094277418.31225.11006663740924379616@sif>
	<02367603-093e-3c09-e026-d78928a3f291@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Content-Disposition: inline
In-Reply-To: <02367603-093e-3c09-e026-d78928a3f291@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for-2.11] spapr: reset DRCs
 after devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-stable@nongnu.org, qemu-ppc@nongnu.org


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2017 at 06:42:25PM -0200, Daniel Henrique Barboza wrote:
>=20
>=20
> On 11/17/2017 04:19 PM, Michael Roth wrote:
> > Quoting Daniel Henrique Barboza (2017-11-17 10:21:27)
> > >=20
> > > On 11/17/2017 10:56 AM, Greg Kurz wrote:
> > > > A DRC with a pending unplug request releases its associated device =
at
> > > > machine reset time.
> > > >=20
> > > > In the case of LMB, when all DRCs for a DIMM device have been reset,
> > > > the DIMM gets unplugged, causing guest memory to disappear. This may
> > > > be very confusing for anything still using this memory.
> > > >=20
> > > > This is exactly what happens with vhost backends, and QEMU aborts
> > > > with:
> > > >=20
> > > > qemu-system-ppc64: used ring relocated for ring 2
> > > > qemu-system-ppc64: qemu/hw/virtio/vhost.c:649: vhost_commit: Assert=
ion
> > > >    `r >=3D 0' failed.
> > > >=20
> > > > The issue is that each DRC registers a QEMU reset handler, and we
> > > > don't control the order in which these handlers are called (ie,
> > > > a LMB DRC will unplug a DIMM before the virtio device using the
> > > > memory on this DIMM could stop its vhost backend).
> > > >=20
> > > > To avoid such situations, let's reset DRCs after all devices
> > > > have been reset.
> > > >=20
> > > > Reported-by: Mallesh N. Koti <mallesh@linux.vnet.ibm.com>
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > ---
> > > I believe this has to do with the problem discussed at the memory
> > > unplug reboot with vhost=3Don, right?
> > >=20
> > > I don't see any problem with this patch and it's probably the best so=
lution
> > > short-term for the problem (and potentially other related LMB release
> > > problems), but that said, how hard it is to forbid LMB unplug at all =
if the
> > > memory is being used in vhost?
> > >=20
> > > The way I see it, the root problem is that a device unplug failed at =
the
> > > guest
> > > side and we don't know about it, leaving drc->unplug_requested flags =
set
> > > around the code when it shouldn't. Reading that thread I see a commen=
t from
> > I'm not sure we want to go down the road of preemptively aborting
> > specific cases where we think unplug will fail in the guest. We already
> > need to deal with the cases where we don't know whether they'll fail
> > ahead of time, so it seems like more of a headache to add special cases
> > on top of that that management would need to deal with.
>=20
> Just to be clear, I only advocate this kind of constraint if the LMB unpl=
ug,
> at this specific scenario, has a 100% chance of fail. Otherwise we're
> better of rolling the dice.
>=20
>=20
> >=20
> > And in this particular case we'd never be able to unplug the DIMM if
> > the guest happens to use it for the vring each boot (unless maybe the
> > unplug request occured during early boot), even though there's no
> > technical reason we shouldn't be able to at least handle it on the
> > next reset.
>=20
> I am ok going this route if we have our bases covered. Does this
> behavior of unplugging the LMBs pending unplug at reset documented
> in the PAPR specs? If not, we would need to document it somewhere else
> (or ask for a PAPR revision to add it).

Well, the LMB is supposed to be released once the guest has vacated
it.  At reset, the guest can't be using it any more, so..

> Otherwise, I am not sure if management will be OK with LMBs being
> "inadvertently" hot unplugged in a reset due to a failed LMB hot unplug t=
hat
> might have occurred days ago and the user doesn't even remember it
> anymore :)
>=20
>=20
> Thanks,
>=20
>=20
> Daniel
> >=20
> > > Michael S. Tsirkin saying that this bug is somewhat expected, that vh=
ost
> > > backend will
> > > not behave well if memory is going away. Unlike other LMB unplug
> > > failures from
> > > the guest side that might happen for any other reason, this one sees
> > > predicable
> > > and we can avoid it.
> > >=20
> > > I think this is something worth considering. But for now,
> > >=20
> > >=20
> > > Reviewed-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> > >=20
> > > >    hw/ppc/spapr.c     |   21 +++++++++++++++++++++
> > > >    hw/ppc/spapr_drc.c |    7 -------
> > > >    2 files changed, 21 insertions(+), 7 deletions(-)
> > > >=20
> > > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > > index 6841bd294b3c..6285f7211f9a 100644
> > > > --- a/hw/ppc/spapr.c
> > > > +++ b/hw/ppc/spapr.c
> > > > @@ -1411,6 +1411,19 @@ static void find_unknown_sysbus_device(SysBu=
sDevice *sbdev, void *opaque)
> > > >        }
> > > >    }
> > > >=20
> > > > +static int spapr_reset_drcs(Object *child, void *opaque)
> > > > +{
> > > > +    sPAPRDRConnector *drc =3D
> > > > +        (sPAPRDRConnector *) object_dynamic_cast(child,
> > > > +                                                 TYPE_SPAPR_DR_CON=
NECTOR);
> > > > +
> > > > +    if (drc) {
> > > > +        spapr_drc_reset(drc);
> > > > +    }
> > > > +
> > > > +    return 0;
> > > > +}
> > > > +
> > > >    static void ppc_spapr_reset(void)
> > > >    {
> > > >        MachineState *machine =3D MACHINE(qdev_get_machine());
> > > > @@ -1434,6 +1447,14 @@ static void ppc_spapr_reset(void)
> > > >        }
> > > >=20
> > > >        qemu_devices_reset();
> > > > +
> > > > +    /* DRC reset may cause a device to be unplugged. This will cau=
se troubles
> > > > +     * if this device is used by another device (eg, a running vho=
st backend
> > > > +     * will crash QEMU if the DIMM holding the vring goes away). T=
o avoid such
> > > > +     * situations, we reset DRCs after all devices have been reset.
> > > > +     */
> > > > +    object_child_foreach_recursive(object_get_root(), spapr_reset_=
drcs, NULL);
> > > > +
> > > >        spapr_clear_pending_events(spapr);
> > > >=20
> > > >        /*
> > > > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > > > index 915e9b51c40c..e3b122968e89 100644
> > > > --- a/hw/ppc/spapr_drc.c
> > > > +++ b/hw/ppc/spapr_drc.c
> > > > @@ -455,11 +455,6 @@ void spapr_drc_reset(sPAPRDRConnector *drc)
> > > >        }
> > > >    }
> > > >=20
> > > > -static void drc_reset(void *opaque)
> > > > -{
> > > > -    spapr_drc_reset(SPAPR_DR_CONNECTOR(opaque));
> > > > -}
> > > > -
> > > >    bool spapr_drc_needed(void *opaque)
> > > >    {
> > > >        sPAPRDRConnector *drc =3D (sPAPRDRConnector *)opaque;
> > > > @@ -518,7 +513,6 @@ static void realize(DeviceState *d, Error **err=
p)
> > > >        }
> > > >        vmstate_register(DEVICE(drc), spapr_drc_index(drc), &vmstate=
_spapr_drc,
> > > >                         drc);
> > > > -    qemu_register_reset(drc_reset, drc);
> > > >        trace_spapr_drc_realize_complete(spapr_drc_index(drc));
> > > >    }
> > > >=20
> > > > @@ -529,7 +523,6 @@ static void unrealize(DeviceState *d, Error **e=
rrp)
> > > >        gchar *name;
> > > >=20
> > > >        trace_spapr_drc_unrealize(spapr_drc_index(drc));
> > > > -    qemu_unregister_reset(drc_reset, drc);
> > > >        vmstate_unregister(DEVICE(drc), &vmstate_spapr_drc, drc);
> > > >        root_container =3D container_get(object_get_root(), DRC_CONT=
AINER_PATH);
> > > >        name =3D g_strdup_printf("%x", spapr_drc_index(drc));
> > > >=20
> > > >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloSD94ACgkQbDjKyiDZ
s5Is/BAA4TuP8AFH4OmDVKeKAfQ4t9zVSVeXbTMvJDgS9BQjMXFHtioJD6jLoHku
Fp9tSmdKVTrHN1RLcgj9FidD1uzKPZl8LClz432CzwYQdW1Cm73WgLsPVn2ipEvA
2jVJLjgPJ1ppwg46oxvnpZlsutwbQRz6qXodJytyq3/zP85K10qNWHiN9YudPt4z
g1b6FagiJobbF195eDWEf6BGDMRUynQ4e67t3f7ObraA+pV0vG9gwZJwcfCwE7Ja
tHBahNfel0MoIFzXQv4pQ/I2YIlY3Xf5g5ypWau7MCsstBBTkkX06ss6JInbGB2j
OeBQKLwTbMhK0+1/SuDEnfnwexkZU9bduuCSUUEmRgt23rECsUDh4QZfGeXDM1Xu
EQfj5DfuQRYLg41+CfGuG5BiFKu2bMddwnPybhLlY+JnNO3PvEa+2nC31qo9Jg/8
rLOu6i8ijO+A6sWqq6fPZu2PWpc9KK6KWDZ7yiBjRF3K183Rh3h2zyzeyvOaZxL3
aE5zI805GQEpDc26ssRgNhfVjwfZwUHBY97sdVKi7Yo3DmWGo01kxTuzZbSEOu6y
i+fPoVODzBCCckfK29l1jdZixOXEdzSPzp8JdtTfBCNEcZ0vv+CXRXQzVUyr4s33
gKkzERTAABiaJoNQFTbfmbr6orjHDxs90dcEL5PO1DVIOO7Golg=
=HUZ+
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--
