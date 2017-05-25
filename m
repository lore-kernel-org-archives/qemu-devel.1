Received: from eggs.gnu.org ([2001:4830:134:3::10]:51888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjGT-0002zn-1k
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:16:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjGP-0002T6-T9
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:16:41 -0400
Date: Thu, 25 May 2017 12:45:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170525024534.GD12929@umbus.fritz.box>
References: <20170523111812.13469-1-lvivier@redhat.com>
	<20170523111812.13469-4-lvivier@redhat.com>
	<20170524050754.GW30246@umbus.fritz.box>
	<20170524112857.31c3d8f9@bahia.ttt.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2Z2K0IlrPCVsbNpk"
Content-Disposition: inline
In-Reply-To: <20170524112857.31c3d8f9@bahia.ttt.fr.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 3/4] spapr: disable hotplugging
 without OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>


--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2017 at 11:28:57AM +0200, Greg Kurz wrote:
> On Wed, 24 May 2017 15:07:54 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Tue, May 23, 2017 at 01:18:11PM +0200, Laurent Vivier wrote:
> > > If the OS is not started, QEMU sends an event to the OS
> > > that is lost and cannot be recovered. An unplug is not
> > > able to restore QEMU in a coherent state.
> > > So, while the OS is not started, disable CPU and memory hotplug.
> > > We use option vector 6 to know if the OS is started
> > >=20
> > > Signed-off-by: Laurent Vivier <lvivier@redhat.com> =20
> >=20
> > Urgh.. I'm not terribly confident that this is really correct.  As
> > discussed on the previous patch, you're essentially using OV6 as a
> > flag that CAS is complete.
> >=20
> > But while it undoubtedly makes the race window much smaller, I don't
> > see that there's any guarantee the guest OS will really be able to
> > handle hotplug events immediately after CAS.
> >=20
> > In particular if the CAS process completes partially but then needs to
> > trigger a reboot, I think that would end up setting the ov6 variable,
> > but the OS would definitely not be in a state to accept events.
> >=20
>=20
> We never have any guarantee that the OS will process an event that
> we've sent actually (think of a kernel crash just after a successful
> CAS negotiation for example, or any failure with the various guest
> components involved in the process of hotplug).
>=20
> > Mike, I really think we need some input from someone familiar with how
> > these hotplug events are supposed to work.  What do we need to do to
> > handle lost or stale events, such as those delivered when an OS is not
> > booted.
> >=20
>=20
> AFAIK, in the PowerVM world, the HMC exposes a user configurable timeout.
>=20
> https://www.ibm.com/support/knowledgecenter/POWER8/p8hat/p8hat_dlparprocp=
oweraddp6.htm
>=20
> I'm not sure we can do anything better than being able to "cancel" a prev=
ious
> hotplug attempt if it takes too long, but I'm not necessarily the expert =
you're
> looking for :)

Right, but at the moment we *don't* have a way to cancel a previous
hotplug attempt.  Trying to remove again ends up with things in a
tangle.

>=20
> > > ---
> > >  hw/ppc/spapr.c | 22 +++++++++++++++++++---
> > >  1 file changed, 19 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index eceb4cc..2e9320d 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -2625,6 +2625,7 @@ out:
> > >  static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, Devic=
eState *dev,
> > >                                  Error **errp)
> > >  {
> > > +    sPAPRMachineState *ms =3D SPAPR_MACHINE(hotplug_dev);
> > >      PCDIMMDevice *dimm =3D PC_DIMM(dev);
> > >      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
> > >      MemoryRegion *mr =3D ddc->get_memory_region(dimm);
> > > @@ -2645,6 +2646,13 @@ static void spapr_memory_pre_plug(HotplugHandl=
er *hotplug_dev, DeviceState *dev,
> > >          goto out;
> > >      }
> > > =20
> > > +    if (dev->hotplugged) {
> > > +        if (!ms->os_name) {
> > > +            error_setg(&local_err, "Memory hotplug not supported wit=
hout OS");
> > > +            goto out;
> > > +        }
> > > +    }
> > > +
> > >  out:
> > >      error_propagate(errp, local_err);
> > >  }
> > > @@ -2874,6 +2882,7 @@ static void spapr_core_pre_plug(HotplugHandler =
*hotplug_dev, DeviceState *dev,
> > >                                  Error **errp)
> > >  {
> > >      MachineState *machine =3D MACHINE(OBJECT(hotplug_dev));
> > > +    sPAPRMachineState *ms =3D SPAPR_MACHINE(machine);
> > >      MachineClass *mc =3D MACHINE_GET_CLASS(hotplug_dev);
> > >      Error *local_err =3D NULL;
> > >      CPUCore *cc =3D CPU_CORE(dev);
> > > @@ -2884,9 +2893,16 @@ static void spapr_core_pre_plug(HotplugHandler=
 *hotplug_dev, DeviceState *dev,
> > >      int node_id;
> > >      int index;
> > > =20
> > > -    if (dev->hotplugged && !mc->has_hotpluggable_cpus) {
> > > -        error_setg(&local_err, "CPU hotplug not supported for this m=
achine");
> > > -        goto out;
> > > +    if (dev->hotplugged) {
> > > +        if (!mc->has_hotpluggable_cpus) {
> > > +            error_setg(&local_err,
> > > +                       "CPU hotplug not supported for this machine");
> > > +            goto out;
> > > +        }
> > > +        if (!ms->os_name) {
> > > +            error_setg(&local_err, "CPU hotplug not supported withou=
t OS");
> > > +            goto out;
> > > +        }
> > >      }
> > > =20
> > >      if (strcmp(base_core_type, type)) { =20
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2Z2K0IlrPCVsbNpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZJkVLAAoJEGw4ysog2bOSuboQALXMX2dMdpy8JegxTiSogtF/
G1Vm+kKyLr3VPnnwv+V+zuS5tWfV3ie9Dq60mNVYyDn8p0KLyLQgzzCkdV6UkFcF
axYt8MTcsg8yxswUzDEA5PtPpHlOXi284pjXc31vwno81aujxA1/Kc8Eu8llMyQD
AHRvgtkCbc/jTFJTl4zAlUsw30f9YPWh+VNhJ625uEK/QYRg6LEuuODUSeP95zCO
6Fvnbkqg/t46gsH409mqjKOSQ6Qe/cY0GpcexP52RCVWERpo/pM9EqBzvtXCg3ni
/JDD+3WI+8U5GJYPQ86Qn0ZwLXgSQf2hEajuIrEasCIRIUw0Z3oFGyPVrrGyIhTW
kuRbXOV2WrczegI6Vy8Ppakm+Fp/7ydfKvKAHt4h4Z6mXGjcvBRrtOL4zYL72FCu
SrNvpP1UTSMlR/X0oSx3QJx16WNGZejGZhSSaxbAfUgzL1MSseVC9EaowTznXQ8e
E6Qw2beSTEBRR7kYjp5qjNKgb1gyXzSp5CJkgK3JOXZjC2t+MH3zdEvU0vy8TXby
aGu/S8tY2nARdZrp1BNXYXGpLh6wq5uI3S3+5j0xhCEqEWjdKYJA4MRCE2VNUgwy
sVb0QtoD0BqYB7easl7W8WZughUHnT21T77P68tfVWy0dhS5lVJGKsl7s0TWEfnb
1Kbx/q2kVO5e/hcRVNE2
=f3Cw
-----END PGP SIGNATURE-----

--2Z2K0IlrPCVsbNpk--
