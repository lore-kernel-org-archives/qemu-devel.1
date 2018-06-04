Received: from eggs.gnu.org ([2001:4830:134:3::10]:58448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fPl7O-00060a-8x
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fPl7N-0002o7-8y
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:45:34 -0400
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon,  4 Jun 2018 18:15:13 +0930
Message-Id: <20180604084513.8298-1-joel@jms.id.au>
Subject: [Qemu-devel] [PATCH v3] target/ppc: Allow privileged access to
 SPR_PCR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Greg Kurz <groug@kaod.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>

The powerpc Linux kernel[1] and skiboot firmware[2] recently gained changes
that cause the Processor Compatibility Register (PCR) SPR to be cleared.

These changes cause Linux to fail to boot on the Qemu powernv machine
with an error:

 Trying to write privileged spr 338 (0x152) at 0000000030017f0c

With this patch Qemu makes this register available as a hypervisor
privileged register.

Note that bits set in this register disable features of the processor.
Currently the only register state that is supported is when the register
is zeroed (enable all features). This is sufficient for guests to
once again boot.

[1] https://lkml.kernel.org/r/20180518013742.24095-1-mikey@neuling.org
[2] https://patchwork.ozlabs.org/patch/915932/

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2:
 - Change error message to say Invalid instead of Unimplemented
 - Fix compile warning on other powerpc targets, thanks patchew
v3:
 - Mask against pcr_mask before storing
 - Drop check for non-zero value
---
 target/ppc/helper.h             | 1 +
 target/ppc/misc_helper.c        | 9 +++++++++
 target/ppc/translate_init.inc.c | 9 +++++++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 19453c68138a..d751f0e21909 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -17,6 +17,7 @@ DEF_HELPER_2(pminsn, void, env, i32)
 DEF_HELPER_1(rfid, void, env)
 DEF_HELPER_1(hrfid, void, env)
 DEF_HELPER_2(store_lpcr, void, env, tl)
+DEF_HELPER_2(store_pcr, void, env, tl)
 #endif
 DEF_HELPER_1(check_tlb_flush_local, void, env)
 DEF_HELPER_1(check_tlb_flush_global, void, env)
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 8c8cba5cc6f1..b88493009609 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -20,6 +20,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
+#include "qemu/error-report.h"
 
 #include "helper_regs.h"
 
@@ -98,6 +99,14 @@ void helper_store_ptcr(CPUPPCState *env, target_ulong val)
         tlb_flush(CPU(cpu));
     }
 }
+
+void helper_store_pcr(CPUPPCState *env, target_ulong value)
+{
+    PowerPCCPU *cpu = ppc_env_get_cpu(env);
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+
+    env->spr[SPR_PCR] = value & pcc->pcr_mask;
+}
 #endif /* defined(TARGET_PPC64) */
 
 void helper_store_pidr(CPUPPCState *env, target_ulong val)
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index ab782cb32aaa..1a89017ddea8 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -424,6 +424,10 @@ static void spr_write_ptcr(DisasContext *ctx, int sprn, int gprn)
     gen_helper_store_ptcr(cpu_env, cpu_gpr[gprn]);
 }
 
+static void spr_write_pcr(DisasContext *ctx, int sprn, int gprn)
+{
+    gen_helper_store_pcr(cpu_env, cpu_gpr[gprn]);
+}
 #endif
 #endif
 
@@ -7957,11 +7961,12 @@ static void gen_spr_power6_common(CPUPPCState *env)
 #endif
     /*
      * Register PCR to report POWERPC_EXCP_PRIV_REG instead of
-     * POWERPC_EXCP_INVAL_SPR.
+     * POWERPC_EXCP_INVAL_SPR in userspace. Permit hypervisor access.
      */
-    spr_register(env, SPR_PCR, "PCR",
+    spr_register_hv(env, SPR_PCR, "PCR",
                  SPR_NOACCESS, SPR_NOACCESS,
                  SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_pcr,
                  0x00000000);
 }
 
-- 
2.17.0
