Received: from eggs.gnu.org ([2001:4830:134:3::10]:44243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f9Y8k-0007w5-Ej
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:40:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f9Y8g-0002qk-BJ
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:39:58 -0400
Received: from 1.mo69.mail-out.ovh.net ([178.33.251.173]:42045)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f9Y8g-0002PX-1c
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:39:54 -0400
Received: from player791.ha.ovh.net (unknown [10.109.120.77])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id CE4D313F91
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 17:39:45 +0200 (CEST)
Date: Fri, 20 Apr 2018 17:39:42 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180420173942.641ed698@bahia.lan>
In-Reply-To: <20180420111501.5fb192bf@bahia.lan>
References: <20180417071722.9399-1-david@gibson.dropbear.id.au>
	<20180417071722.9399-2-david@gibson.dropbear.id.au>
	<20180419154823.0e937610@bahia.lan>
	<20180420063437.GM2434@umbus.fritz.box>
	<20180420111501.5fb192bf@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/gKeHa+A4gwmp21vYCwvvnz.";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for-2.13 01/10] spapr: Avoid
 redundant calls to spapr_cpu_reset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

--Sig_/gKeHa+A4gwmp21vYCwvvnz.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Apr 2018 11:15:01 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Fri, 20 Apr 2018 16:34:37 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Apr 19, 2018 at 03:48:23PM +0200, Greg Kurz wrote: =20
> > > On Tue, 17 Apr 2018 17:17:13 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >    =20
> > > > af81cf323c1 "spapr: CPU hotplug support" added a direct call to
> > > > spapr_cpu_reset() in spapr_cpu_init(), as well as registering it as=
 a
> > > > reset callback.  That was in order to make sure that the reset func=
tion
> > > > got called for a newly hotplugged cpu, which would miss the global =
machine
> > > > reset.
> > > >=20
> > > > However, this change means that spapr_cpu_reset() gets called twice=
 for
> > > > normal cold-plugged cpus: once from spapr_cpu_init(), then again du=
ring
> > > > the system reset.  As well as being ugly in its redundancy, the fir=
st call
> > > > happens before the machine reset calls have happened, which will ca=
use
> > > > problems for some things we're going to want to add.
> > > >=20
> > > > So, we remove the reset call from spapr_cpu_init().  We instead put=
 an
> > > > explicit reset call in the hotplug specific path.
> > > >=20
> > > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > > ---   =20
> > >=20
> > > I had sent a tentative patch to do something similar earlier this yea=
r:
> > >=20
> > > https://patchwork.ozlabs.org/patch/862116/
> > >=20
> > > but it got nacked for several reasons, one of them being you were
> > > "always wary of using the hotplugged parameter, because what qemu
> > > means by it often doesn't line up with what PAPR means by it."   =20
> >=20
> > Yeah, I was and am wary of that, but convinced myself it was correct
> > in this case (which doesn't really interact with the PAPR meaning of
> > hotplug).
> >  =20
> > > >  hw/ppc/spapr.c                  |  6 ++++--
> > > >  hw/ppc/spapr_cpu_core.c         | 13 ++++++++++++-
> > > >  include/hw/ppc/spapr_cpu_core.h |  2 ++
> > > >  3 files changed, 18 insertions(+), 3 deletions(-)
> > > >=20
> > > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > > index 7b2bc4e25d..81b50af3b5 100644
> > > > --- a/hw/ppc/spapr.c
> > > > +++ b/hw/ppc/spapr.c
> > > > @@ -3370,9 +3370,11 @@ static void spapr_core_plug(HotplugHandler *=
hotplug_dev, DeviceState *dev,
> > > > =20
> > > >          if (hotplugged) {   =20
> > >=20
> > > ... but you rely on it here. Can you explain why it is
> > > okay now ?   =20
> >=20
> > So the value I actually need here is "wasn't present at the last
> > system reset" (with false positives being mostly harmless, but not
> > false negatives).
> >  =20
>=20
> Hmm... It is rather the other way around, sth like "will be caught
> by the initial machine reset".
>=20
> > > Also, if QEMU is started with -incoming and the CPU core
> > > is hotplugged before migration begins, the following will
> > > return false:
> > >=20
> > > static inline bool spapr_drc_hotplugged(DeviceState *dev)
> > > {
> > >     return dev->hotplugged && !runstate_check(RUN_STATE_INMIGRATE);
> > > }
> > >=20
> > > and the CPU core won't be reset.   =20
> >=20
> > Uh... spapr_dtc_hotplugged() would definitely be wrong here, which is
> > why I'm not using it.
> >  =20
>=20
> This is how hotplugged is set in spapr_core_plug():
>=20
>     bool hotplugged =3D spapr_drc_hotplugged(dev);
>=20
> but to detect the "will be caught by the initial machine reset" condition,
> we only need to check dev->hotplugged actually.
>=20
> > >    =20
> > > >              /*
> > > > -             * Send hotplug notification interrupt to the guest on=
ly
> > > > -             * in case of hotplugged CPUs.
> > > > +             * For hotplugged CPUs, we need to reset them (they mi=
ssed
> > > > +             * out on the system reset), and send the guest a
> > > > +             * notification
> > > >               */
> > > > +            spapr_cpu_core_reset(core);   =20
> > >=20
> > > spapr_cpu_reset() also sets the compat mode, which is used
> > > to set some properties in the DT, ie, this should be called
> > > before spapr_populate_hotplug_cpu_dt().   =20
> >=20
> > Good point.  I've moved the reset to fix that.
> >  =20

Thinking of it again: since cold-plugged devices reach this before machine
reset, we would then attach to the DRC a DT blob based on a non-reset CPU :=
-\

Instead of registering a reset handler for each individual CPUs, maybe
we should rather register it a the CPU core level. The handler would
first reset all CPUs in the core and then setup the DRC for new cores only,
like it is done currently in spapr_core_plug().

spapr_core_plug() would then just need to register the reset handler,
and call it only for hotplugged cores.

I've tweaked your patch to implement this, and could do some basic
plug/unplug tests without seeing anything wrong. But I'll be on
vacation next week (currently packing), so I inline it below as
food for thought.

---------------------------------------------------------------------------=
--------
 hw/ppc/spapr.c                  |   62 ++++++++++++++++++++++++++++-------=
----
 hw/ppc/spapr_cpu_core.c         |   27 +++++++++++------
 include/hw/ppc/spapr_cpu_core.h |    2 +
 3 files changed, 64 insertions(+), 27 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9bf3eba9c5ea..51a0349c2bcc 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3388,6 +3388,36 @@ static void *spapr_populate_hotplug_cpu_dt(CPUState =
*cs, int *fdt_offset,
     return fdt;
 }
=20
+static void spapr_core_reset(void *opaque)
+{
+    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
+    DeviceState *dev =3D DEVICE(opaque);
+    CPUCore *cc =3D CPU_CORE(dev);
+    sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(dev);
+    CPUState *cs =3D CPU(sc->threads[0]);
+    sPAPRDRConnector *drc;
+
+    spapr_cpu_core_reset(sc);
+
+    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_CPU,
+                          spapr_vcpu_id(spapr, cc->core_id));
+
+    assert(drc);
+
+    if (!drc->dev) {
+        void *fdt;
+        int fdt_offset;
+
+        fdt =3D spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr);
+
+        spapr_drc_attach(drc, dev, fdt, fdt_offset, &error_abort);
+
+        if (!spapr_drc_hotplugged(dev)) {
+            spapr_drc_reset(drc);
+        }
+    }
+}
+
 /* Callback to be called during DRC release. */
 void spapr_core_release(DeviceState *dev)
 {
@@ -3395,9 +3425,9 @@ void spapr_core_release(DeviceState *dev)
     sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(ms);
     CPUCore *cc =3D CPU_CORE(dev);
     CPUArchId *core_slot =3D spapr_find_cpu_slot(ms, cc->core_id, NULL);
+    sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
=20
     if (smc->pre_2_10_has_unused_icps) {
-        sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
         int i;
=20
         for (i =3D 0; i < cc->nr_threads; i++) {
@@ -3407,6 +3437,8 @@ void spapr_core_release(DeviceState *dev)
         }
     }
=20
+    qemu_unregister_reset(spapr_core_reset, sc);
+
     assert(core_slot);
     core_slot->cpu =3D NULL;
     object_unparent(OBJECT(dev));
@@ -3448,12 +3480,9 @@ static void spapr_core_plug(HotplugHandler *hotplug_=
dev, DeviceState *dev,
     sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
     sPAPRCPUCore *core =3D SPAPR_CPU_CORE(OBJECT(dev));
     CPUCore *cc =3D CPU_CORE(dev);
-    CPUState *cs =3D CPU(core->threads[0]);
     sPAPRDRConnector *drc;
-    Error *local_err =3D NULL;
     CPUArchId *core_slot;
     int index;
-    bool hotplugged =3D spapr_drc_hotplugged(dev);
=20
     core_slot =3D spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_id, &=
index);
     if (!core_slot) {
@@ -3467,32 +3496,31 @@ static void spapr_core_plug(HotplugHandler *hotplug=
_dev, DeviceState *dev,
     g_assert(drc || !mc->has_hotpluggable_cpus);
=20
     if (drc) {
-        void *fdt;
-        int fdt_offset;
-
-        fdt =3D spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr);
-
-        spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
-        if (local_err) {
-            g_free(fdt);
-            error_propagate(errp, local_err);
-            return;
+        /* The boot core and any core specified on the command line will
+         * be reset during the initial machine reset. Filter them out based
+         * on @hotplugged which is set to false in this case. Another case
+         * is when a core is added after the machine was shutdown: no need
+         * to reset here since a system reset is needed to restart the mac=
hine.
+         */
+        if (dev->hotplugged && !runstate_check(RUN_STATE_SHUTDOWN)) {
+            spapr_core_reset(core);
         }
=20
-        if (hotplugged) {
+        if (spapr_drc_hotplugged(dev)) {
             /*
              * Send hotplug notification interrupt to the guest only
              * in case of hotplugged CPUs.
              */
             spapr_hotplug_req_add_by_index(drc);
-        } else {
-            spapr_drc_reset(drc);
         }
     }
=20
+    qemu_register_reset(spapr_core_reset, core);
+
     core_slot->cpu =3D OBJECT(dev);
=20
     if (smc->pre_2_10_has_unused_icps) {
+        CPUState *cs =3D CPU(core->threads[0]);
         int i;
=20
         for (i =3D 0; i < cc->nr_threads; i++) {
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 90e4b72c3e96..aaae90bbcb6d 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -22,9 +22,8 @@
 #include "sysemu/hw_accel.h"
 #include "qemu/error-report.h"
=20
-static void spapr_cpu_reset(void *opaque)
+static void spapr_cpu_reset(PowerPCCPU *cpu)
 {
-    PowerPCCPU *cpu =3D opaque;
     CPUState *cs =3D CPU(cpu);
     CPUPPCState *env =3D &cpu->env;
     PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
@@ -50,11 +49,6 @@ static void spapr_cpu_reset(void *opaque)
=20
 }
=20
-static void spapr_cpu_destroy(PowerPCCPU *cpu)
-{
-    qemu_unregister_reset(spapr_cpu_reset, cpu);
-}
-
 static void spapr_cpu_init(sPAPRMachineState *spapr, PowerPCCPU *cpu,
                            Error **errp)
 {
@@ -66,8 +60,10 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, Pow=
erPCCPU *cpu,
     /* Enable PAPR mode in TCG or KVM */
     cpu_ppc_set_papr(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
=20
-    qemu_register_reset(spapr_cpu_reset, cpu);
-    spapr_cpu_reset(cpu);
+    /* All CPUs start halted.  CPU0 is unhalted from the machine level
+     * reset code and the rest are explicitly started up by the guest
+     * using an RTAS call */
+    CPU(cpu)->halted =3D 1;
 }
=20
 /*
@@ -101,7 +97,6 @@ static void spapr_cpu_core_unrealizefn(DeviceState *dev,=
 Error **errp)
         CPUState *cs =3D CPU(dev);
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
=20
-        spapr_cpu_destroy(cpu);
         object_unparent(cpu->intc);
         cpu_remove_sync(cs);
         object_unparent(obj);
@@ -205,6 +200,18 @@ err:
     error_propagate(errp, local_err);
 }
=20
+void spapr_cpu_core_reset(sPAPRCPUCore *sc)
+{
+    CPUCore *cc =3D CPU_CORE(sc);
+    int i;
+
+    for (i =3D 0; i < cc->nr_threads; i++) {
+        PowerPCCPU *cpu =3D sc->threads[i];
+
+        spapr_cpu_reset(cpu);
+    }
+}
+
 static Property spapr_cpu_core_properties[] =3D {
     DEFINE_PROP_INT32("node-id", sPAPRCPUCore, node_id, CPU_UNSET_NUMA_NOD=
E_ID),
     DEFINE_PROP_END_OF_LIST()
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_cor=
e.h
index 1129f344aa0c..1a38544706e7 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -38,4 +38,6 @@ typedef struct sPAPRCPUCoreClass {
 } sPAPRCPUCoreClass;
=20
 const char *spapr_get_cpu_core_type(const char *cpu_type);
+void spapr_cpu_core_reset(sPAPRCPUCore *sc);
+
 #endif

--Sig_/gKeHa+A4gwmp21vYCwvvnz.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlraCb4ACgkQcdTV5YIv
c9ZfQg//RGatiLH8KWtcB5DJs1Lkau1Y64wA425MGdxqHLXRFY6OvitzQ9Fsv1pb
7PmoV7xMrEf4S9KQZAH2Q0tYvmTQGmZqnQPsdAieto3jLFU06Xo9+bTCYJTvPTgb
sKDshOE5C7iTq2H4OQ9tERUL3Sd6xumJjbsFDnODAmgojf/veHBULHDsrwt5BbSh
NliR2I9VYJah5F8yyGpZP3Lpj96InYVAhw4J/oF6LQmuBOit7+Q0G6wK7nRTKGxz
ubeoWf01Q6HOXoJB2fskB6I5XnWA8zDvu+FRW4KQIwDusGi8Ga1EQN/+qe8tYlBU
ZUcjcLMU/9ctr6njwYPhi17QfSTE/ViFU8wjPMBn7y6nSIi/0yndEQjwoyX0dL59
p4+2Iu41Bdhw3HFIq0y0IWENgSirXf8fL07dz90J7vr/uRk+TZDAIKCtRHHKcSyd
8tmwAFpWZNWUSqOkGM0PCzcraBTny32wkOJeUp1PjuYMmv7zQLzTRj9RwjPgVx4K
DivOZDdbZSiMyw7DIuySQ2nMRxr6CJbpN4HXtbPsfWBlpCi3irUegr2wI+93jy+D
MTEYJ1KZL34bz5pFxEefChg8EtbkCnHLHpPzYjGFlInS4+rSzmKzd6VZZmRUiauc
O4v06dXYjimK/2poEd6Mbgg6DCLrdVPch48tS6p4Yj6VGsbAD98=
=jFoc
-----END PGP SIGNATURE-----

--Sig_/gKeHa+A4gwmp21vYCwvvnz.--
