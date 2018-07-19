Received: from eggs.gnu.org ([2001:4830:134:3::10]:51446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8Wh-0003Os-F7
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:00:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8Vd-0006Ud-Dm
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:59:23 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:57545 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1fg8Vc-0006T9-RL
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:58:17 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Thu, 19 Jul 2018 14:54:54 +0200
Message-Id: <1532004912-13899-23-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 22/40] target/mips: Add handling of branch
 delay slots for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Matthew Fortune <matthew.fortune@mips.com>

ISA mode bit (LSB of address) is no longer required but is also
masked to allow for tools transition. The flag has_isa_mode has the
key role in the implementation.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index d7454a6..7fb2ff9 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1458,6 +1458,7 @@ typedef struct DisasContext {
     bool mrp;
     bool nan2008;
     bool abs2008;
+    bool has_isa_mode;
 } DisasContext;
 
 #define DISAS_STOP       DISAS_TARGET_0
@@ -4538,7 +4539,7 @@ static void gen_compute_branch (DisasContext *ctx, uint32_t opc,
 
     if (blink > 0) {
         int post_delay = insn_bytes + delayslot_size;
-        int lowbit = !!(ctx->hflags & MIPS_HFLAG_M16);
+        int lowbit = ctx->has_isa_mode && !!(ctx->hflags & MIPS_HFLAG_M16);
 
         tcg_gen_movi_tl(cpu_gpr[blink],
                         ctx->base.pc_next + post_delay + lowbit);
@@ -10991,7 +10992,8 @@ static void gen_branch(DisasContext *ctx, int insn_bytes)
             break;
         case MIPS_HFLAG_BR:
             /* unconditional branch to register */
-            if (ctx->insn_flags & (ASE_MIPS16 | ASE_MICROMIPS)) {
+            if (ctx->has_isa_mode &&
+                    (ctx->insn_flags & (ASE_MIPS16 | ASE_MICROMIPS))) {
                 TCGv t0 = tcg_temp_new();
                 TCGv_i32 t1 = tcg_temp_new_i32();
 
@@ -11027,7 +11029,7 @@ static void gen_compute_compact_branch(DisasContext *ctx, uint32_t opc,
     int bcond_compute = 0;
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
-    int m16_lowbit = (ctx->hflags & MIPS_HFLAG_M16) != 0;
+    int m16_lowbit = ctx->has_isa_mode && ((ctx->hflags & MIPS_HFLAG_M16) != 0);
 
     if (ctx->hflags & MIPS_HFLAG_BMASK) {
 #ifdef MIPS_DEBUG_DISAS
@@ -24747,6 +24749,7 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->mrp = (env->CP0_Config5 >> CP0C5_MRP) & 1;
     ctx->nan2008 = (env->active_fpu.fcr31 >> FCR31_NAN2008) & 1;
     ctx->abs2008 = (env->active_fpu.fcr31 >> FCR31_ABS2008) & 1;
+    ctx->has_isa_mode = ((env->CP0_Config3 >> CP0C3_MMAR) & 0x7) != 3;
     restore_cpu_state(env, ctx);
 #ifdef CONFIG_USER_ONLY
         ctx->mem_idx = MIPS_HFLAG_UM;
-- 
2.7.4
