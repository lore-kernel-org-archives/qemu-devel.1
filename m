Received: from eggs.gnu.org ([2001:4830:134:3::10]:60568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1flEh5-0006iW-VX
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1flEh3-0008Es-Cq
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:35:11 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:39177 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1flEh3-0008Dw-4t
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:35:09 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Thu,  2 Aug 2018 16:16:31 +0200
Message-Id: <1533219424-7627-45-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v6 44/77] target/mips: Add handling of branch
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
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, arikalo@wavecomp.com

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
index 7e495d2..8da3fb5 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1458,6 +1458,7 @@ typedef struct DisasContext {
     bool mrp;
     bool nan2008;
     bool abs2008;
+    bool has_isa_mode;
 } DisasContext;
 
 #define DISAS_STOP       DISAS_TARGET_0
@@ -4550,7 +4551,7 @@ static void gen_compute_branch (DisasContext *ctx, uint32_t opc,
 
     if (blink > 0) {
         int post_delay = insn_bytes + delayslot_size;
-        int lowbit = !!(ctx->hflags & MIPS_HFLAG_M16);
+        int lowbit = ctx->has_isa_mode && !!(ctx->hflags & MIPS_HFLAG_M16);
 
         tcg_gen_movi_tl(cpu_gpr[blink],
                         ctx->base.pc_next + post_delay + lowbit);
@@ -11039,7 +11040,7 @@ static void gen_compute_compact_branch(DisasContext *ctx, uint32_t opc,
     int bcond_compute = 0;
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
-    int m16_lowbit = (ctx->hflags & MIPS_HFLAG_M16) != 0;
+    int m16_lowbit = ctx->has_isa_mode && ((ctx->hflags & MIPS_HFLAG_M16) != 0);
 
     if (ctx->hflags & MIPS_HFLAG_BMASK) {
 #ifdef MIPS_DEBUG_DISAS
@@ -24756,6 +24757,7 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->mrp = (env->CP0_Config5 >> CP0C5_MRP) & 1;
     ctx->nan2008 = (env->active_fpu.fcr31 >> FCR31_NAN2008) & 1;
     ctx->abs2008 = (env->active_fpu.fcr31 >> FCR31_ABS2008) & 1;
+    ctx->has_isa_mode = ((env->CP0_Config3 >> CP0C3_MMAR) & 0x7) < 3;
     restore_cpu_state(env, ctx);
 #ifdef CONFIG_USER_ONLY
         ctx->mem_idx = MIPS_HFLAG_UM;
-- 
1.9.1
