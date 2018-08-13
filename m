Received: from eggs.gnu.org ([2001:4830:134:3::10]:59674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpH3E-0005ZN-1w
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpH36-000794-HW
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:43 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55804 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fpH36-00076q-1h
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:36 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 13 Aug 2018 19:53:17 +0200
Message-Id: <1534182832-554-53-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v8 52/87] target/mips: Add handling of branch
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
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Matthew Fortune <matthew.fortune@mips.com>

ISA mode bit (LSB of address) is no longer required but is also
masked to allow for tools transition. The flag has_isa_mode has the
key role in the implementation.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 3282fca..e4427e4 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1471,6 +1471,7 @@ typedef struct DisasContext {
     bool mrp;
     bool nan2008;
     bool abs2008;
+    bool has_isa_mode;
 } DisasContext;
 
 #define DISAS_STOP       DISAS_TARGET_0
@@ -4674,7 +4675,7 @@ static void gen_compute_branch (DisasContext *ctx, uint32_t opc,
 
     if (blink > 0) {
         int post_delay = insn_bytes + delayslot_size;
-        int lowbit = !!(ctx->hflags & MIPS_HFLAG_M16);
+        int lowbit = ctx->has_isa_mode && !!(ctx->hflags & MIPS_HFLAG_M16);
 
         tcg_gen_movi_tl(cpu_gpr[blink],
                         ctx->base.pc_next + post_delay + lowbit);
@@ -11171,7 +11172,7 @@ static void gen_compute_compact_branch(DisasContext *ctx, uint32_t opc,
     int bcond_compute = 0;
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
-    int m16_lowbit = (ctx->hflags & MIPS_HFLAG_M16) != 0;
+    int m16_lowbit = ctx->has_isa_mode && ((ctx->hflags & MIPS_HFLAG_M16) != 0);
 
     if (ctx->hflags & MIPS_HFLAG_BMASK) {
 #ifdef MIPS_DEBUG_DISAS
@@ -24970,6 +24971,7 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->mrp = (env->CP0_Config5 >> CP0C5_MRP) & 1;
     ctx->nan2008 = (env->active_fpu.fcr31 >> FCR31_NAN2008) & 1;
     ctx->abs2008 = (env->active_fpu.fcr31 >> FCR31_ABS2008) & 1;
+    ctx->has_isa_mode = ((env->CP0_Config3 >> CP0C3_MMAR) & 0x7) < 3;
     restore_cpu_state(env, ctx);
 #ifdef CONFIG_USER_ONLY
         ctx->mem_idx = MIPS_HFLAG_UM;
-- 
2.7.4
