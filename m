Received: from eggs.gnu.org ([2001:4830:134:3::10]:33615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eI83s-0002Wc-By
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:06:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eI83n-0007o3-DQ
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:06:08 -0500
Received: from 19.mo6.mail-out.ovh.net ([188.165.56.177]:38325)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eI83n-0007lg-85
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:06:03 -0500
Received: from player696.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id CEEB6120D9C
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 08:06:01 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 24 Nov 2017 08:05:48 +0100
Message-Id: <20171124070550.6433-2-clg@kaod.org>
In-Reply-To: <20171124070550.6433-1-clg@kaod.org>
References: <20171124070550.6433-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 1/3] spapr/rtas: disable the decrementer
 interrupt when a CPU is unplugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

When a CPU is stopped with the 'stop-self' RTAS call, its state
'halted' is switched to 1 and, in this case, the MSR is not taken into
account anymore in the cpu_has_work() routine. Only the pending
hardware interrupts are checked with their LPCR:PECE* enablement bit.

If the DECR timer fires after 'stop-self' is called and before the CPU
'stop' state is reached, the nearly-dead CPU will have some work to do
and the guest will crash. This case happens very frequently with the
not yet upstream P9 XIVE exploitation mode. In XICS mode, the DECR is
occasionally fired but after 'stop' state, so no work is to be done
and the guest survives.

I suspect there is a race between the QEMU mainloop triggering the
timers and the TCG CPU thread but I could not quite identify the root
cause. To be safe, let's disable in the LPCR all the exceptions which
can cause an exit while the CPU is in power-saving mode and reenable
them when the CPU is started.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

Changes in v4:

 - used the 'lpcr_pm' field of PowerPCCPUClass

Changes in v3:

 - introduced a cpu_ppc_papr_pece_bits() helper to gather the PECE
   bits depending on the CPU family.  =20
 - enabled Power-saving mode Exit Cause exceptions only on the boot CPU.
=20
Changes in v2:

 - used a new routine ppc_cpu_pvr_match() to discriminate CPU versions
 - removed the LPCR:PECE* enablement bit when the CPU is initialized
   if it is a secondary

 hw/ppc/spapr_rtas.c         | 11 +++++++++++
 target/ppc/translate_init.c |  9 ++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index cdf0b607a0a0..858adb1bf3a9 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -162,6 +162,7 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMac=
hineState *spapr,
     if (cpu !=3D NULL) {
         CPUState *cs =3D CPU(cpu);
         CPUPPCState *env =3D &cpu->env;
+        PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
=20
         if (!cs->halted) {
             rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
@@ -174,6 +175,10 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMa=
chineState *spapr,
         kvm_cpu_synchronize_state(cs);
=20
         env->msr =3D (1ULL << MSR_SF) | (1ULL << MSR_ME);
+
+        /* Enable Power-saving mode Exit Cause exceptions for the new CP=
U */
+        env->spr[SPR_LPCR] |=3D pcc->lpcr_pm;
+
         env->nip =3D start;
         env->gpr[3] =3D r3;
         cs->halted =3D 0;
@@ -197,6 +202,7 @@ static void rtas_stop_self(PowerPCCPU *cpu, sPAPRMach=
ineState *spapr,
 {
     CPUState *cs =3D CPU(cpu);
     CPUPPCState *env =3D &cpu->env;
+    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
=20
     cs->halted =3D 1;
     qemu_cpu_kick(cs);
@@ -210,6 +216,11 @@ static void rtas_stop_self(PowerPCCPU *cpu, sPAPRMac=
hineState *spapr,
      * no need to bother with specific bits, we just clear it.
      */
     env->msr =3D 0;
+
+    /* Disable Power-saving mode Exit Cause exceptions for the CPU.
+     * This could deliver an interrupt on a dying CPU and crash the
+     * guest */
+    env->spr[SPR_LPCR] &=3D ~pcc->lpcr_pm;
 }
=20
 static inline int sysparm_st(target_ulong addr, target_ulong len,
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 828d7e778c3b..78a4a581bab7 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8911,6 +8911,7 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHy=
pervisor *vhyp)
     CPUPPCState *env =3D &cpu->env;
     ppc_spr_t *lpcr =3D &env->spr_cb[SPR_LPCR];
     ppc_spr_t *amor =3D &env->spr_cb[SPR_AMOR];
+    CPUState *cs =3D CPU(cpu);
=20
     cpu->vhyp =3D vhyp;
=20
@@ -8953,10 +8954,12 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtual=
Hypervisor *vhyp)
         }
     }
=20
-    /* Also set the power-saving mode bits which depend on the CPU
-     * family
+    /* Only enable Power-saving mode Exit Cause exceptions on the boot
+     * CPU. The RTAS command start-cpu will enable them on secondaries.
      */
-    lpcr->default_value |=3D pcc->lpcr_pm;
+    if (cs =3D=3D first_cpu) {
+        lpcr->default_value |=3D pcc->lpcr_pm;
+    }
=20
     /* We should be followed by a CPU reset but update the active value
      * just in case...
--=20
2.13.6
