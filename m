Received: from eggs.gnu.org ([2001:4830:134:3::10]:46834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dAlFa-0002Hr-6Y
	for qemu-devel@nongnu.org; Tue, 16 May 2017 18:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dAlFZ-0005JP-9I
	for qemu-devel@nongnu.org; Tue, 16 May 2017 18:47:30 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:45090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dAlFZ-0005If-3N
	for qemu-devel@nongnu.org; Tue, 16 May 2017 18:47:29 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Wed, 17 May 2017 00:47:21 +0200
Message-Id: <20170516224721.13832-6-aurelien@aurel32.net>
In-Reply-To: <20170516224721.13832-1-aurelien@aurel32.net>
References: <20170516224721.13832-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 5/5] target/sh4: fix RTE instruction delay slot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

The ReTurn from Exception (RTE) instruction loads the system register
(SR) with the saved system register (SSR). It has a delay slot, and
behaves specially according to the SH4 manual:

  The SR value accessed by the instruction in the RTE delay slot is the
  value restored from SSR by the RTE instruction. The SR and MD values
  defined prior to RTE execution are used to fetch the instruction in
  the RTE delay slot.

The instruction in the delay slot being often a NOP, it doesn't cause
any issue most of the time except in some rare cases where the NOP is
being splitted in a different TB (for example when the TCG op buffer
is full). In that case the NOP is fetched with the user permissions
and causes an instruction TLB protection violation exception.

This patches fixes that by introducing a new delay slot flag for the
RTE instruction. Given it's a privileged instruction, the RTE delay
slot instruction is always fetched in privileged mode. It is therefore
enough to to check for this flag in cpu_mmu_index.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/cpu.h       | 13 ++++++++++---
 target/sh4/translate.c |  8 ++++++--
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 7969c9af98..ffb91687b8 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -91,9 +91,10 @@
 #define FPSCR_RM_NEAREST       (0 << 0)
 #define FPSCR_RM_ZERO          (1 << 0)
 
-#define DELAY_SLOT_MASK        0x3
+#define DELAY_SLOT_MASK        0x7
 #define DELAY_SLOT             (1 << 0)
 #define DELAY_SLOT_CONDITIONAL (1 << 1)
+#define DELAY_SLOT_RTE         (1 << 2)
 
 typedef struct tlb_t {
     uint32_t vpn;		/* virtual page number */
@@ -264,7 +265,13 @@ void cpu_load_tlb(CPUSH4State * env);
 #define MMU_USER_IDX 1
 static inline int cpu_mmu_index (CPUSH4State *env, bool ifetch)
 {
-    return (env->sr & (1u << SR_MD)) == 0 ? 1 : 0;
+    /* The instruction in a RTE delay slot is fetched in privileged
+       mode, but executed in user mode.  */
+    if (ifetch && (env->flags & DELAY_SLOT_RTE)) {
+        return 0;
+    } else {
+        return (env->sr & (1u << SR_MD)) == 0 ? 1 : 0;
+    }
 }
 
 #include "exec/cpu-all.h"
@@ -381,7 +388,7 @@ static inline void cpu_get_tb_cpu_state(CPUSH4State *env, target_ulong *pc,
 {
     *pc = env->pc;
     *cs_base = 0;
-    *flags = (env->flags & DELAY_SLOT_MASK)                    /* Bits  0- 1 */
+    *flags = (env->flags & DELAY_SLOT_MASK)                    /* Bits  0- 2 */
             | (env->fpscr & (FPSCR_FR | FPSCR_SZ | FPSCR_PR))  /* Bits 19-21 */
             | (env->sr & ((1u << SR_MD) | (1u << SR_RB)))      /* Bits 29-30 */
             | (env->sr & (1u << SR_FD))                        /* Bit 15 */
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index aba316f593..8bc132b27b 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -185,6 +185,9 @@ void superh_cpu_dump_state(CPUState *cs, FILE *f,
     } else if (env->flags & DELAY_SLOT_CONDITIONAL) {
 	cpu_fprintf(f, "in conditional delay slot (delayed_pc=0x%08x)\n",
 		    env->delayed_pc);
+    } else if (env->flags & DELAY_SLOT_RTE) {
+        cpu_fprintf(f, "in rte delay slot (delayed_pc=0x%08x)\n",
+                    env->delayed_pc);
     }
 }
 
@@ -427,8 +430,9 @@ static void _decode_opc(DisasContext * ctx)
 	CHECK_NOT_DELAY_SLOT
         gen_write_sr(cpu_ssr);
 	tcg_gen_mov_i32(cpu_delayed_pc, cpu_spc);
-        ctx->envflags |= DELAY_SLOT;
+        ctx->envflags |= DELAY_SLOT_RTE;
 	ctx->delayed_pc = (uint32_t) - 1;
+        ctx->bstate = BS_STOP;
 	return;
     case 0x0058:		/* sets */
         tcg_gen_ori_i32(cpu_sr, cpu_sr, (1u << SR_S));
@@ -1804,7 +1808,7 @@ static void decode_opc(DisasContext * ctx)
         ctx->bstate = BS_BRANCH;
         if (old_flags & DELAY_SLOT_CONDITIONAL) {
 	    gen_delayed_conditional_jump(ctx);
-        } else if (old_flags & DELAY_SLOT) {
+        } else {
             gen_jump(ctx);
 	}
 
-- 
2.11.0
