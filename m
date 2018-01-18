Received: from eggs.gnu.org ([2001:4830:134:3::10]:37004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ecCI5-0003r6-FJ
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:39:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ecCHz-0001Au-GE
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:39:45 -0500
Received: from 7.mo173.mail-out.ovh.net ([46.105.44.159]:37908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ecCHz-0001AS-5j
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:39:39 -0500
Received: from player791.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id AF780A4AAA
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 16:39:36 +0100 (CET)
Date: Thu, 18 Jan 2018 16:39:30 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180118163930.2b5a8448@bahia.lan>
In-Reply-To: <20180118034340.GD30352@umbus.fritz.box>
References: <151618081462.20461.3393245354775542888.stgit@bahia.lan>
	<151618083506.20461.14178623580944316317.stgit@bahia.lan>
	<20180118034340.GD30352@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/4fiEH0sf7XcO_djgUCznfqc";
	protocol="application/pgp-signature"
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

--Sig_/4fiEH0sf7XcO_djgUCznfqc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Jan 2018 14:43:40 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Jan 17, 2018 at 10:20:35AM +0100, Greg Kurz wrote:
> > When QEMU is started, all cold-plugged CPUs are reset twice: first
> > during initialization and then during machine reset. This is sub-
> > optimal.
> >=20
> > The first reset is only needed for hot-plugged CPUs because the CPU
> > hotplug code doesn't reset them. This patch adds the necessary code
> > to reset hot-plugged CPUs on the CPU core hotplug path, and removes
> > the now useless initial CPU reset.
> >=20
> > We just need to mark the newly created CPU as halted to prevent it
> > to run until it is put online later.
> >=20
> > Full CPU reset is now explicitely triggered from the machine code
> > only, either during system reset or during CPU hotplug.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> Hrm, this looks ok in outline, but makes me nervous in a couple of
> ways.
>=20
>=20
> > ---
> >  hw/ppc/spapr.c                  |    8 ++++++++
> >  hw/ppc/spapr_cpu_core.c         |    8 ++++++--
> >  include/hw/ppc/spapr_cpu_core.h |    2 ++
> >  3 files changed, 16 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index bca838fce638..a2ff401f738a 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -3336,6 +3336,14 @@ static void spapr_core_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
> >          void *fdt;
> >          int fdt_offset;
> > =20
> > +        if (hotplugged) { =20
>=20
> First, I'm always wary of using the hotplugged parameter, because what
> qemu means by it often doesn't line up with what PAPR means by it.
>=20

Hmmm... you're right, hotplugged in QDEV simply means that the device
was not created during initial machine startup.

ie, any device added with QMP/HMP is always hotplugged.

To cope with the DRC state management, commit 94fd9cbaa3190 added the
fact that QEMU mustn't be waiting for an incoming migration as well.

ie, if QEMU is started with -incoming and CPUs are added before migration
starts, like libvirt does, this code wouldn't reset the CPUs...

I guess we should check qdev->hotplugged instead. Makes sense ?

> > +            int i;
> > +
> > +            for (i =3D 0; i < cc->nr_threads; i++) {
> > +                spapr_cpu_reset(core->threads[i]);
> > +            }
> > +        }
> > +
> >          fdt =3D spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr);
> > =20
> >          spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index ac19b2e0b72c..268be7784efb 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -22,7 +22,7 @@
> >  #include "sysemu/hw_accel.h"
> >  #include "qemu/error-report.h"
> > =20
> > -static void spapr_cpu_reset(void *opaque)
> > +void spapr_cpu_reset(void *opaque)
> >  {
> >      PowerPCCPU *cpu =3D opaque;
> >      CPUState *cs =3D CPU(cpu);
> > @@ -63,7 +63,11 @@ static void spapr_cpu_init(sPAPRMachineState *spapr,=
 PowerPCCPU *cpu,
> >      cpu_ppc_set_papr(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
> > =20
> >      qemu_register_reset(spapr_cpu_reset, cpu);
> > -    spapr_cpu_reset(cpu);
> > +
> > +    /* CPU must not execute anything until explicitely started otherwi=
se the
> > +     * guest will crash.
> > +     */
> > +    CPU(cpu)->halted =3D 1; =20
>=20
> And poking specifics in a CPU that hasn't already been set to a known
> state by a reset also worries me.
>=20

IIUC the halted flag doesn't really depend any CPU state. It is
only a way to prevent the CPU from executing, which is needed
if the CPU wasn't set to a known state.

FWIW I've seen other places where it is set before resetting the
CPU (eg, s390_cpu_initfn() or cpu_devinit() for Sun4m).

I was thinking of another solution: create a DeviceClass reset function
that would call spapr_cpu_reset() for all CPUs of a core, and register
it in spapr_cpu_core_class_init(). It would be called by QDEV during
realization of hot-plugged cores only. Unfortunately, this also happens
after the call to spapr_core_plug() (see device_set_realized()).

> >  }
> > =20
> >  /*
> > diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu=
_core.h
> > index 1129f344aa0c..763a2168461e 100644
> > --- a/include/hw/ppc/spapr_cpu_core.h
> > +++ b/include/hw/ppc/spapr_cpu_core.h
> > @@ -38,4 +38,6 @@ typedef struct sPAPRCPUCoreClass {
> >  } sPAPRCPUCoreClass;
> > =20
> >  const char *spapr_get_cpu_core_type(const char *cpu_type);
> > +void spapr_cpu_reset(void *opaque);
> > +
> >  #endif
> >  =20
>=20


--Sig_/4fiEH0sf7XcO_djgUCznfqc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlpgv7IACgkQcdTV5YIv
c9ZTcA//VhfuyEdmaI2yg0L2P78CV7TqNoSXkqH73EYvNH0WwwsmcQ/jUUV/RYnn
zcYhjoZJiHX5NP4mBTfPj6XZtE1fHhW4KnMI4ptmxrx9YiHNqprtl/tMYjjwRpN8
7Hqu0EFnNU8u2K3kJICGMcVVOuIEnHNDQzJDZ2EbzvcUvRCGWwPuwFfAIz0OCcV9
d9V5952RwZLe9EOWgYHGYuXcp3ZMuhEslp4pZfDJFHRRYf79MWi2CjYSnGu/8sYz
3ewv73NMVPJIRMhV+7EKWpaf4szzTa5wDriSzG8ntNW6q8cIbBJ0cKVpGy8nrA/B
CUyli+lbBHFSXWJCeJ8XndGC2YHdGg3UtTk0KaY+GvDAUgZlqEQR+XlgAykw/YOd
PDOXhn801MUyM0Vd57ir4T/AuF9RWI3W1QmGfuas8YhAkclHBSl4T/woFBX+z24L
u9W7I2GPTidANdGcyYRjxGUZxWTVWmggxbcmyLTaARf1t6cN5YftqEvF1tpnMkGz
zVe+lVGJ57Cbr0RxKuucCOxCUgEPC8Gi6D/6Z/GGghSneOMH47zch+gG6E2NVRKh
3dIy5vPqukv86hDCmTnzEQhN3ex/+Hc5HYzxMmggonrRIB5CYiuoQK8LzLfDBjQt
nPeIxoarK4zwa1Ef34Gq7jeMnippwzB0+R3vmyMz42LpA644v/s=
=dtXB
-----END PGP SIGNATURE-----

--Sig_/4fiEH0sf7XcO_djgUCznfqc--
