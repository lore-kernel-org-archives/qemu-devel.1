Received: from eggs.gnu.org ([2001:4830:134:3::10]:35719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbx8-00060f-JO
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbx2-0005am-Kr
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:11:10 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:54268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Yongbok.Kim@mips.com>)
	id 1fVbx2-0005X5-AU
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:11:04 -0400
From: Yongbok Kim <yongbok.kim@mips.com>
Date: Wed, 20 Jun 2018 13:06:01 +0100
Message-ID: <20180620120620.12806-17-yongbok.kim@mips.com>
In-Reply-To: <20180620120620.12806-1-yongbok.kim@mips.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 16/35] target/mips: Add has_isa_mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, Aleksandar.Markovic@mips.com, James.Hogan@mips.com, Paul.Burton@mips.com, Matthew.Fortune@mips.com, Stefan.Markovic@mips.com

From: Matthew Fortune <matthew.fortune@imgtec.com>

ISA mode bit (LSB of address) is no longer required but is also
masked to allow for tools transition.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
---
 target/mips/translate.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index bd50281..2e794da 100644
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
@@ -10876,7 +10877,8 @@ static void gen_branch(DisasContext *ctx, int insn_bytes)
             break;
         case MIPS_HFLAG_BR:
             /* unconditional branch to register */
-            if (ctx->insn_flags & (ASE_MIPS16 | ASE_MICROMIPS)) {
+            if (ctx->has_isa_mode &&
+                    (ctx->insn_flags & (ASE_MIPS16 | ASE_MICROMIPS))) {
                 TCGv t0 = tcg_temp_new();
                 TCGv_i32 t1 = tcg_temp_new_i32();
 
@@ -10912,7 +10914,7 @@ static void gen_compute_compact_branch(DisasContext *ctx, uint32_t opc,
     int bcond_compute = 0;
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
-    int m16_lowbit = (ctx->hflags & MIPS_HFLAG_M16) != 0;
+    int m16_lowbit = ctx->has_isa_mode && ((ctx->hflags & MIPS_HFLAG_M16) != 0);
 
     if (ctx->hflags & MIPS_HFLAG_BMASK) {
 #ifdef MIPS_DEBUG_DISAS
@@ -22476,6 +22478,7 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->mrp = (env->CP0_Config5 >> CP0C5_MRP) & 1;
     ctx->nan2008 = (env->active_fpu.fcr31 >> FCR31_NAN2008) & 1;
     ctx->abs2008 = (env->active_fpu.fcr31 >> FCR31_ABS2008) & 1;
+    ctx->has_isa_mode = ((env->CP0_Config3 >> CP0C3_MMAR) & 0x7) != 3;
     restore_cpu_state(env, ctx);
 #ifdef CONFIG_USER_ONLY
         ctx->mem_idx = MIPS_HFLAG_UM;
-- 
1.9.1
