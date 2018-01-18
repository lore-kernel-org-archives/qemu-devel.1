Received: from eggs.gnu.org ([2001:4830:134:3::10]:60393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecJeU-0002lP-94
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 18:31:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecJeS-0000G8-Vx
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 18:31:22 -0500
Date: Fri, 19 Jan 2018 10:30:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180118233056.GY30352@umbus.fritz.box>
References: <151618081462.20461.3393245354775542888.stgit@bahia.lan>
	<151618083506.20461.14178623580944316317.stgit@bahia.lan>
	<20180118034340.GD30352@umbus.fritz.box>
	<20180118163930.2b5a8448@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="e8znkWhb8vS+si4n"
Content-Disposition: inline
In-Reply-To: <20180118163930.2b5a8448@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 2/3] spapr_cpu_core: don't reset CPUs
 during realization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--e8znkWhb8vS+si4n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 04:39:30PM +0100, Greg Kurz wrote:
> On Thu, 18 Jan 2018 14:43:40 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Wed, Jan 17, 2018 at 10:20:35AM +0100, Greg Kurz wrote:
> > > When QEMU is started, all cold-plugged CPUs are reset twice: first
> > > during initialization and then during machine reset. This is sub-
> > > optimal.
> > >=20
> > > The first reset is only needed for hot-plugged CPUs because the CPU
> > > hotplug code doesn't reset them. This patch adds the necessary code
> > > to reset hot-plugged CPUs on the CPU core hotplug path, and removes
> > > the now useless initial CPU reset.
> > >=20
> > > We just need to mark the newly created CPU as halted to prevent it
> > > to run until it is put online later.
> > >=20
> > > Full CPU reset is now explicitely triggered from the machine code
> > > only, either during system reset or during CPU hotplug.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org> =20
> >=20
> > Hrm, this looks ok in outline, but makes me nervous in a couple of
> > ways.
> >=20
> >=20
> > > ---
> > >  hw/ppc/spapr.c                  |    8 ++++++++
> > >  hw/ppc/spapr_cpu_core.c         |    8 ++++++--
> > >  include/hw/ppc/spapr_cpu_core.h |    2 ++
> > >  3 files changed, 16 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index bca838fce638..a2ff401f738a 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -3336,6 +3336,14 @@ static void spapr_core_plug(HotplugHandler *ho=
tplug_dev, DeviceState *dev,
> > >          void *fdt;
> > >          int fdt_offset;
> > > =20
> > > +        if (hotplugged) { =20
> >=20
> > First, I'm always wary of using the hotplugged parameter, because what
> > qemu means by it often doesn't line up with what PAPR means by it.
> >=20
>=20
> Hmmm... you're right, hotplugged in QDEV simply means that the device
> was not created during initial machine startup.
>=20
> ie, any device added with QMP/HMP is always hotplugged.
>=20
> To cope with the DRC state management, commit 94fd9cbaa3190 added the
> fact that QEMU mustn't be waiting for an incoming migration as well.
>=20
> ie, if QEMU is started with -incoming and CPUs are added before migration
> starts, like libvirt does, this code wouldn't reset the CPUs...
>=20
> I guess we should check qdev->hotplugged instead. Makes sense ?

Actually I don't think that dev->hotplugged is any better in terms of
meaning what you want it to.

> > > +            int i;
> > > +
> > > +            for (i =3D 0; i < cc->nr_threads; i++) {
> > > +                spapr_cpu_reset(core->threads[i]);
> > > +            }
> > > +        }
> > > +
> > >          fdt =3D spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr=
);
> > > =20
> > >          spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
> > > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > > index ac19b2e0b72c..268be7784efb 100644
> > > --- a/hw/ppc/spapr_cpu_core.c
> > > +++ b/hw/ppc/spapr_cpu_core.c
> > > @@ -22,7 +22,7 @@
> > >  #include "sysemu/hw_accel.h"
> > >  #include "qemu/error-report.h"
> > > =20
> > > -static void spapr_cpu_reset(void *opaque)
> > > +void spapr_cpu_reset(void *opaque)
> > >  {
> > >      PowerPCCPU *cpu =3D opaque;
> > >      CPUState *cs =3D CPU(cpu);
> > > @@ -63,7 +63,11 @@ static void spapr_cpu_init(sPAPRMachineState *spap=
r, PowerPCCPU *cpu,
> > >      cpu_ppc_set_papr(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
> > > =20
> > >      qemu_register_reset(spapr_cpu_reset, cpu);
> > > -    spapr_cpu_reset(cpu);
> > > +
> > > +    /* CPU must not execute anything until explicitely started other=
wise the
> > > +     * guest will crash.
> > > +     */
> > > +    CPU(cpu)->halted =3D 1; =20
> >=20
> > And poking specifics in a CPU that hasn't already been set to a known
> > state by a reset also worries me.
> >=20
>=20
> IIUC the halted flag doesn't really depend any CPU state. It is
> only a way to prevent the CPU from executing, which is needed
> if the CPU wasn't set to a known state.
>=20
> FWIW I've seen other places where it is set before resetting the
> CPU (eg, s390_cpu_initfn() or cpu_devinit() for Sun4m).

Its effects do, though - e.g. the recent patches to explicitly disable
the decrementer on stopped vcpus, because halted alone wasn't enough
to keep them quiescent.

> I was thinking of another solution: create a DeviceClass reset function
> that would call spapr_cpu_reset() for all CPUs of a core, and register
> it in spapr_cpu_core_class_init(). It would be called by QDEV during
> realization of hot-plugged cores only. Unfortunately, this also happens
> after the call to spapr_core_plug() (see device_set_realized()).

Well, feel free to come up with something.  AIUI there's no urgency
about this, though - I'm not too worried by extraneous resets, as long
as we have enough to be correct.


>=20
> > >  }
> > > =20
> > >  /*
> > > diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_c=
pu_core.h
> > > index 1129f344aa0c..763a2168461e 100644
> > > --- a/include/hw/ppc/spapr_cpu_core.h
> > > +++ b/include/hw/ppc/spapr_cpu_core.h
> > > @@ -38,4 +38,6 @@ typedef struct sPAPRCPUCoreClass {
> > >  } sPAPRCPUCoreClass;
> > > =20
> > >  const char *spapr_get_cpu_core_type(const char *cpu_type);
> > > +void spapr_cpu_reset(void *opaque);
> > > +
> > >  #endif
> > >  =20
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--e8znkWhb8vS+si4n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlphLjAACgkQbDjKyiDZ
s5LycA//b4GOe5IxMNq8qz+VCeXR5nK67C41Mt/blX9hRwl1WMsGa8fX1HIoOQL9
gXWYSaZtulLG2eKrJVd86jiJfB7q0R6nlQ+XyDhVmE/+gEeV201Yap6tyDtkmVaF
tpyy8aRQa4ZURxwslLQuabyBwrv3ndApvIt3EcKnAatQdNq9uhsWilrzbHd/tY/1
orj5Ob28D473zuqwnBPDDgv/gvtX5BkdBvHpLjexCv0i3MbWwmB/A2qiVhjJp4UF
YDKH6asiMD2uU/4noxYN0syuxB2wJYA3LjDEbOo1Cp8z0QQs47f6jeuoMP0EmSZ+
cMNGQ5dG4zCNsGIKLiBnZDMRmlw0A0Fq9gRscoCBuUwV26xvUkYY7FZ+tKNDX2Tz
C4pWHBInuB4tJHKI9X9aCfvrdSQ+S2ZnPiEBxJAXAHZkIh/O/UTCTw5xA1KKi0K3
yDj0q56W2NqsTFKM9IeGOGPwLLQuwarKqks48xP4DVKgon3OnNXBOwe2nLEWvE/m
yC5JKEvaxdblb9UCjHHXtK63/EIyVgC4cnHap90+/OnDjrKzNO00uuwoswhrLBEc
fCAQ/gfazenf02l7at7gkw9DPOCeH5sJ5EU7pC8AowvS5RG1Lb233Z174pQ1wTQ7
hKn7pzSS2B9DiTFb96Yf4EzrgMqohyq5FinNZxsMNgEaXj6wHLM=
=WDKP
-----END PGP SIGNATURE-----

--e8znkWhb8vS+si4n--
