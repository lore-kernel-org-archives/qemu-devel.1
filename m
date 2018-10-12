Received: from eggs.gnu.org ([2001:4830:134:3::10]:40111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gB1Ht-00020a-Hy
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gB1Hs-0000UU-7r
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:45 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:33852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gB1Hr-0000H3-Rd
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:44 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Fri, 12 Oct 2018 19:30:47 +0200
Message-Id: <20181012173047.25420-29-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 28/28] target/riscv: Replace
 gen_exception_illegal with return false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mjc@sifive.com, palmer@sifive.com, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de
Cc: qemu-devel@nongnu.org, peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com

return false in trans_* instructions is no longer used as a fallback to
the old decoder. We can therefore now use 'return false' to indicate an illegal
instruction.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
 .../riscv/insn_trans/trans_privileged.inc.c   |  6 ++----
 target/riscv/insn_trans/trans_rvc.inc.c       | 21 +++++++------------
 target/riscv/insn_trans/trans_rvd.inc.c       | 14 ++++++-------
 target/riscv/insn_trans/trans_rvf.inc.c       | 10 ++++-----
 target/riscv/insn_trans/trans_rvi.inc.c       | 18 ++++++----------
 target/riscv/translate.c                      |  1 +
 6 files changed, 28 insertions(+), 42 deletions(-)

diff --git a/target/riscv/insn_trans/trans_privileged.inc.c b/target/riscv/insn_trans/trans_privileged.inc.c
index 9534adb025..f378c3852e 100644
--- a/target/riscv/insn_trans/trans_privileged.inc.c
+++ b/target/riscv/insn_trans/trans_privileged.inc.c
@@ -37,8 +37,7 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a, uint32_t insn)
 
 static bool trans_uret(DisasContext *ctx, arg_uret *a, uint32_t insn)
 {
-    gen_exception_illegal(ctx);
-    return true;
+    return false;
 }
 
 static bool trans_sret(DisasContext *ctx, arg_sret *a, uint32_t insn)
@@ -61,8 +60,7 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a, uint32_t insn)
 
 static bool trans_hret(DisasContext *ctx, arg_hret *a, uint32_t insn)
 {
-    gen_exception_illegal(ctx);
-    return true;
+    return false;
 }
 
 static bool trans_mret(DisasContext *ctx, arg_mret *a, uint32_t insn)
diff --git a/target/riscv/insn_trans/trans_rvc.inc.c b/target/riscv/insn_trans/trans_rvc.inc.c
index b98c18d99e..43e9e6e1ac 100644
--- a/target/riscv/insn_trans/trans_rvc.inc.c
+++ b/target/riscv/insn_trans/trans_rvc.inc.c
@@ -23,8 +23,7 @@ static bool trans_c_addi4spn(DisasContext *ctx, arg_c_addi4spn *a,
 {
     if (a->nzuimm == 0) {
         /* Reserved in ISA */
-        gen_exception_illegal(ctx);
-        return true;
+        return false;
     }
     arg_addi arg = { .rd = a->rd, .rs1 = 2, .imm = a->nzuimm };
     return trans_addi(ctx, &arg, insn);
@@ -144,14 +143,12 @@ static bool trans_c_srli(DisasContext *ctx, arg_c_srli *a, uint16_t insn)
 {
     if (a->shamt == 0) {
         /* Reserved in ISA */
-        gen_exception_illegal(ctx);
-        return true;
+        return false;
     }
 #ifdef TARGET_RISCV32
     /* Ensure, that shamt[5] is zero for RV32 */
     if (a->shamt >= 32) {
-        gen_exception_illegal(ctx);
-        return true;
+        return false;
     }
 #endif
 
@@ -163,14 +160,12 @@ static bool trans_c_srai(DisasContext *ctx, arg_c_srai *a, uint16_t insn)
 {
     if (a->shamt == 0) {
         /* Reserved in ISA */
-        gen_exception_illegal(ctx);
-        return true;
+        return false;
     }
 #ifdef TARGET_RISCV32
     /* Ensure, that shamt[5] is zero for RV32 */
     if (a->shamt >= 32) {
-        gen_exception_illegal(ctx);
-        return true;
+        return false;
     }
 #endif
 
@@ -242,15 +237,13 @@ static bool trans_c_slli(DisasContext *ctx, arg_c_slli *a, uint16_t insn)
 {
     if (a->shamt == 0) {
         /* Reserved in ISA */
-        gen_exception_illegal(ctx);
-        return true;
+        return false;
     }
 
 #ifdef TARGET_RISCV32
     /* Ensure, that shamt[5] is zero for RV32 */
     if (a->shamt >= 32) {
-        gen_exception_illegal(ctx);
-        return true;
+        return false;
     }
 #endif
 
diff --git a/target/riscv/insn_trans/trans_rvd.inc.c b/target/riscv/insn_trans/trans_rvd.inc.c
index 076d2147c3..8593b20233 100644
--- a/target/riscv/insn_trans/trans_rvd.inc.c
+++ b/target/riscv/insn_trans/trans_rvd.inc.c
@@ -253,7 +253,7 @@ static bool trans_fclass_d(DisasContext *ctx, arg_fclass_d *a, uint32_t insn)
     gen_set_gpr(a->rd, t0);
     tcg_temp_free(t0);
 #else
-    gen_exception_illegal(ctx);
+    return false;
 #endif
     return true;
 }
@@ -323,7 +323,7 @@ static bool trans_fcvt_l_d(DisasContext *ctx, arg_fcvt_l_d *a, uint32_t insn)
     gen_set_gpr(a->rd, t0);
     tcg_temp_free(t0);
 #else
-    gen_exception_illegal(ctx);
+    return false;
 #endif
     return true;
 }
@@ -339,7 +339,7 @@ static bool trans_fcvt_lu_d(DisasContext *ctx, arg_fcvt_lu_d *a, uint32_t insn)
     gen_set_gpr(a->rd, t0);
     tcg_temp_free(t0);
 #else
-    gen_exception_illegal(ctx);
+    return false;
 #endif
     return true;
 }
@@ -351,7 +351,7 @@ static bool trans_fmv_x_d(DisasContext *ctx, arg_fmv_x_d *a, uint32_t insn)
 
     gen_set_gpr(a->rd, cpu_fpr[a->rs1]);
 #else
-    gen_exception_illegal(ctx);
+    return false;
 #endif
     return true;
 }
@@ -368,7 +368,7 @@ static bool trans_fcvt_d_l(DisasContext *ctx, arg_fcvt_d_l *a, uint32_t insn)
     gen_helper_fcvt_d_l(cpu_fpr[a->rd], cpu_env, t0);
     tcg_temp_free(t0);
 #else
-    gen_exception_illegal(ctx);
+    return false;
 #endif
     return true;
 }
@@ -385,7 +385,7 @@ static bool trans_fcvt_d_lu(DisasContext *ctx, arg_fcvt_d_lu *a, uint32_t insn)
     gen_helper_fcvt_d_lu(cpu_fpr[a->rd], cpu_env, t0);
     tcg_temp_free(t0);
 #else
-    gen_exception_illegal(ctx);
+    return false;
 #endif
     return true;
 }
@@ -401,7 +401,7 @@ static bool trans_fmv_d_x(DisasContext *ctx, arg_fmv_d_x *a, uint32_t insn)
     tcg_gen_mov_tl(cpu_fpr[a->rd], t0);
     tcg_temp_free(t0);
 #else
-    gen_exception_illegal(ctx);
+    return false;
 #endif
     return true;
 }
diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
index d33a0113c2..6b9a6eea95 100644
--- a/target/riscv/insn_trans/trans_rvf.inc.c
+++ b/target/riscv/insn_trans/trans_rvf.inc.c
@@ -20,7 +20,7 @@
 
 #define REQUIRE_FPU \
 if (!(ctx->flags & TB_FLAGS_FP_ENABLE)) \
-    gen_exception_illegal(ctx)
+    return false;
 
 static bool trans_flw(DisasContext *ctx, arg_flw *a, uint32_t insn)
 {
@@ -336,7 +336,7 @@ static bool trans_fcvt_l_s(DisasContext *ctx, arg_fcvt_l_s *a, uint32_t insn)
     gen_set_gpr(a->rd, t0);
     tcg_temp_free(t0);
 #else
-    gen_exception_illegal(ctx);
+    return false;
 #endif
 
     return true;
@@ -353,7 +353,7 @@ static bool trans_fcvt_lu_s(DisasContext *ctx, arg_fcvt_lu_s *a, uint32_t insn)
     gen_set_gpr(a->rd, t0);
     tcg_temp_free(t0);
 #else
-    gen_exception_illegal(ctx);
+    return false;
 #endif
 
     return true;
@@ -372,7 +372,7 @@ static bool trans_fcvt_s_l(DisasContext *ctx, arg_fcvt_s_l *a, uint32_t insn)
 
     tcg_temp_free(t0);
 #else
-    gen_exception_illegal(ctx);
+    return false;
 #endif
     return true;
 }
@@ -390,7 +390,7 @@ static bool trans_fcvt_s_lu(DisasContext *ctx, arg_fcvt_s_lu *a, uint32_t insn)
 
     tcg_temp_free(t0);
 #else
-    gen_exception_illegal(ctx);
+    return false;
 #endif
     return true;
 }
diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
index b84a2e018b..a0c15a256b 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -286,8 +286,7 @@ static bool trans_slli(DisasContext *ctx, arg_slli *a, uint32_t insn)
         gen_get_gpr(t, a->rs1);
 
         if (a->shamt >= TARGET_LONG_BITS) {
-            gen_exception_illegal(ctx);
-            return true;
+            return false;
         }
         tcg_gen_shli_tl(t, t, a->shamt);
 
@@ -447,8 +446,7 @@ static bool trans_sraiw(DisasContext *ctx, arg_sraiw *a, uint32_t insn)
 static bool trans_addw(DisasContext *ctx, arg_addw *a, uint32_t insn)
 {
 #if !defined(TARGET_RISCV64)
-    gen_exception_illegal(ctx);
-    return true;
+    return false;
 #endif
     return trans_arith(ctx, a, &tcg_gen_add_tl);
 }
@@ -456,8 +454,7 @@ static bool trans_addw(DisasContext *ctx, arg_addw *a, uint32_t insn)
 static bool trans_subw(DisasContext *ctx, arg_subw *a, uint32_t insn)
 {
 #if !defined(TARGET_RISCV64)
-    gen_exception_illegal(ctx);
-    return true;
+    return false;
 #endif
     return trans_arith(ctx, a, &tcg_gen_sub_tl);
 }
@@ -465,8 +462,7 @@ static bool trans_subw(DisasContext *ctx, arg_subw *a, uint32_t insn)
 static bool trans_sllw(DisasContext *ctx, arg_sllw *a, uint32_t insn)
 {
 #if !defined(TARGET_RISCV64)
-    gen_exception_illegal(ctx);
-    return true;
+    return false;
 #endif
     TCGv source1 = tcg_temp_new();
     TCGv source2 = tcg_temp_new();
@@ -486,8 +482,7 @@ static bool trans_sllw(DisasContext *ctx, arg_sllw *a, uint32_t insn)
 static bool trans_srlw(DisasContext *ctx, arg_srlw *a, uint32_t insn)
 {
 #if !defined(TARGET_RISCV64)
-    gen_exception_illegal(ctx);
-    return true;
+    return false;
 #endif
     TCGv source1 = tcg_temp_new();
     TCGv source2 = tcg_temp_new();
@@ -509,8 +504,7 @@ static bool trans_srlw(DisasContext *ctx, arg_srlw *a, uint32_t insn)
 static bool trans_sraw(DisasContext *ctx, arg_sraw *a, uint32_t insn)
 {
 #if !defined(TARGET_RISCV64)
-    gen_exception_illegal(ctx);
-    return true;
+    return false;
 #endif
     TCGv source1 = tcg_temp_new();
     TCGv source2 = tcg_temp_new();
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 8ef943f6c8..298f2e4aa5 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -427,6 +427,7 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx)
     } else {
         ctx->pc_succ_insn = ctx->base.pc_next + 4;
         if (!decode_insn32(ctx, ctx->opcode)) {
+            gen_exception_illegal(ctx);
         }
     }
 }
-- 
2.19.1
