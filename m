Received: from eggs.gnu.org ([2001:4830:134:3::10]:53317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvMR-0006QS-GH
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:29:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvMQ-00023J-Eo
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:29:15 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 13 Jan 2017 17:28:19 +1100
Message-Id: <1484288903-18807-14-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 13/17] target/ppc/POWER9: Add cpu_has_work
 function for POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The cpu has work function is used to mask interrupts used to determine
if there is work for the cpu based on the LPCR. Add a function to do this
for POWER9 and add it to the POWER9 cpu definition. This is similar to that
for POWER8 except using the LPCR bits as defined for POWER9.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 target/ppc/translate_init.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 87297a7..9db004d 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8797,10 +8797,54 @@ static bool ppc_pvr_match_power9(PowerPCCPUClass *pcc, uint32_t pvr)
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
@@ -8811,6 +8855,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
                          PCR_COMPAT_2_05;
     pcc->init_proc = init_proc_POWER9;
     pcc->check_pow = check_pow_nocheck;
+    cc->has_work = cpu_has_work_POWER9;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
-- 
2.5.5
