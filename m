Received: from eggs.gnu.org ([2001:4830:134:3::10]:49050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e1aJZ-0004D1-Qj
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e1aJW-00039x-N7
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:49:57 -0400
Received: from 15.mo4.mail-out.ovh.net ([91.121.62.11]:38280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e1aJW-00039O-Dc
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:49:54 -0400
Received: from player746.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id DCDFED9558
	for <qemu-devel@nongnu.org>; Mon,  9 Oct 2017 17:49:52 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  9 Oct 2017 17:49:28 +0200
Message-Id: <20171009154930.29095-3-clg@kaod.org>
In-Reply-To: <20171009154930.29095-1-clg@kaod.org>
References: <20171009154930.29095-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/4] spapr/rtas: disable the decrementer
 interrupt when a CPU is unplugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
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
cause. To be safe, let's disable the decrementer interrupt in the LPCR
when the CPU is halted and reenable it when the CPU is restarted.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

Changes in v2:

 - used a new routine ppc_cpu_pvr_match() to discriminate CPU versions
 - removed the LPCR:PECE* enablement bit when the CPU is initialized
   if it is a secondary

 hw/ppc/spapr_rtas.c         | 20 ++++++++++++++++++++
 target/ppc/translate_init.c | 19 +++++++++++++++++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index cdf0b607a0a0..dfdbf1e2c6f8 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -46,6 +46,7 @@
 #include "qemu/cutils.h"
 #include "trace.h"
 #include "hw/ppc/fdt.h"
+#include "target/ppc/cpu-models.h"
=20
 static void rtas_display_character(PowerPCCPU *cpu, sPAPRMachineState *s=
papr,
                                    uint32_t token, uint32_t nargs,
@@ -174,6 +175,15 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMa=
chineState *spapr,
         kvm_cpu_synchronize_state(cs);
=20
         env->msr =3D (1ULL << MSR_SF) | (1ULL << MSR_ME);
+
+        /* Enable DECR interrupt */
+        if (ppc_cpu_pvr_match(cpu, CPU_POWERPC_LOGICAL_3_00)) {
+            env->spr[SPR_LPCR] |=3D LPCR_DEE;
+        } else {
+            /* P7 and P8 both have same bit for DECR */
+            env->spr[SPR_LPCR] |=3D LPCR_P8_PECE3;
+        }
+
         env->nip =3D start;
         env->gpr[3] =3D r3;
         cs->halted =3D 0;
@@ -210,6 +220,16 @@ static void rtas_stop_self(PowerPCCPU *cpu, sPAPRMac=
hineState *spapr,
      * no need to bother with specific bits, we just clear it.
      */
     env->msr =3D 0;
+
+    /* Don't let the decremeter run on a CPU being stopped. This could
+     * deliver an interrupt on a dying CPU and crash the guest.
+     */
+    if (ppc_cpu_pvr_match(cpu, CPU_POWERPC_LOGICAL_3_00)) {
+        env->spr[SPR_LPCR] &=3D ~LPCR_DEE;
+    } else {
+        /* P7 and P8 both have same bit for DECR */
+        env->spr[SPR_LPCR] &=3D ~LPCR_P8_PECE3;
+    }
 }
=20
 static inline int sysparm_st(target_ulong addr, target_ulong len,
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 0d6379fcc5b4..1a62159843e7 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8905,6 +8905,7 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHy=
pervisor *vhyp)
     CPUPPCState *env =3D &cpu->env;
     ppc_spr_t *lpcr =3D &env->spr_cb[SPR_LPCR];
     ppc_spr_t *amor =3D &env->spr_cb[SPR_AMOR];
+    CPUState *cs =3D CPU(cpu);
=20
     cpu->vhyp =3D vhyp;
=20
@@ -8946,8 +8947,15 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualH=
ypervisor *vhyp)
         } else {
             lpcr->default_value &=3D ~(LPCR_UPRT | LPCR_GTSE);
         }
-        lpcr->default_value |=3D LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR=
_DEE |
+        lpcr->default_value |=3D LPCR_PDEE | LPCR_HDEE | LPCR_EEE |
                                LPCR_OEE;
+
+        /* Only let the decremeter wake up the boot CPU. The RTAS
+         * command start-cpu will enable it on secondaries.
+         */
+        if (cs =3D=3D first_cpu) {
+            lpcr->default_value |=3D LPCR_DEE;
+        }
         break;
     default:
         /* P7 and P8 has slightly different PECE bits, mostly because P8=
 adds
@@ -8955,7 +8963,14 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualH=
ypervisor *vhyp)
          * will work as expected for both implementations
          */
         lpcr->default_value |=3D LPCR_P8_PECE0 | LPCR_P8_PECE1 | LPCR_P8=
_PECE2 |
-                               LPCR_P8_PECE3 | LPCR_P8_PECE4;
+                               LPCR_P8_PECE4;
+
+        /* Only let the decremeter wake up the boot CPU. The RTAS
+         * command start-cpu will enable it on secondaries.
+         */
+        if (cs =3D=3D first_cpu) {
+            lpcr->default_value |=3D LPCR_P8_PECE3;
+        }
     }
=20
     /* We should be followed by a CPU reset but update the active value
--=20
2.13.6
