Received: from eggs.gnu.org ([2001:4830:134:3::10]:44255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqV-00084R-Vp
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqU-0001M5-6w
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:31 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  3 Mar 2017 14:24:59 +1100
Message-Id: <20170303032507.16142-10-david@gibson.dropbear.id.au>
In-Reply-To: <20170303032507.16142-1-david@gibson.dropbear.id.au>
References: <20170303032507.16142-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 09/17] target/ppc/POWER9: Add cpu_has_work
 function for POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, sjitindarsingh@gmail.com, sam.bobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The cpu has work function is used to mask interrupts used to determine
if there is work for the cpu based on the LPCR. Add a function to do this
for POWER9 and add it to the POWER9 cpu definition. This is similar to that
for POWER8 except using the LPCR bits as defined for POWER9.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate_init.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index dc2f8eb..c1a9014 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8858,10 +8858,54 @@ static bool ppc_pvr_match_power9(PowerPCCPUClass *pcc, uint32_t pvr)
     return false;
 }
 
+static bool cpu_has_work_POWER9(CPUState *cs)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+
+    if (cs->halted) {
+        if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
+            return false;
+        }
+        /* External Exception */
+        if ((env->pending_interrupts & (1u << PPC_INTERRUPT_EXT)) &&
+            (env->spr[SPR_LPCR] & LPCR_EEE)) {
+            return true;
+        }
+        /* Decrementer Exception */
+        if ((env->pending_interrupts & (1u << PPC_INTERRUPT_DECR)) &&
+            (env->spr[SPR_LPCR] & LPCR_DEE)) {
+            return true;
+        }
+        /* Machine Check or Hypervisor Maintenance Exception */
+        if ((env->pending_interrupts & (1u << PPC_INTERRUPT_MCK |
+            1u << PPC_INTERRUPT_HMI)) && (env->spr[SPR_LPCR] & LPCR_OEE)) {
+            return true;
+        }
+        /* Privileged Doorbell Exception */
+        if ((env->pending_interrupts & (1u << PPC_INTERRUPT_DOORBELL)) &&
+            (env->spr[SPR_LPCR] & LPCR_PDEE)) {
+            return true;
+        }
+        /* Hypervisor Doorbell Exception */
+        if ((env->pending_interrupts & (1u << PPC_INTERRUPT_HDOORBELL)) &&
+            (env->spr[SPR_LPCR] & LPCR_HDEE)) {
+            return true;
+        }
+        if (env->pending_interrupts & (1u << PPC_INTERRUPT_RESET)) {
+            return true;
+        }
+        return false;
+    } else {
+        return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
+    }
+}
+
 POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
+    CPUClass *cc = CPU_CLASS(oc);
 
     dc->fw_name = "PowerPC,POWER9";
     dc->desc = "POWER9";
@@ -8872,6 +8916,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
                          PCR_COMPAT_2_05;
     pcc->init_proc = init_proc_POWER9;
     pcc->check_pow = check_pow_nocheck;
+    cc->has_work = cpu_has_work_POWER9;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
-- 
2.9.3
