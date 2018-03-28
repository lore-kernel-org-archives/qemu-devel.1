Received: from eggs.gnu.org ([2001:4830:134:3::10]:46220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f10jm-0004SX-L0
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 22:22:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f10jl-0002m7-AZ
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 22:22:54 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:36024)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f10jl-0002lq-2F
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 22:22:53 -0400
Received: by mail-pf0-x243.google.com with SMTP id g14so408731pfh.3
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 19:22:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 28 Mar 2018 10:22:33 +0800
Message-Id: <20180328022233.13400-3-richard.henderson@linaro.org>
In-Reply-To: <20180328022233.13400-1-richard.henderson@linaro.org>
References: <20180328022233.13400-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] target/riscv: Mark MSTATUS_FS dirty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mjc@sifive.com, patches@groups.riscv.org, palmer@sifive.com

Writes to the FP register file mark the register file as dirty.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/op_helper.c | 25 +++++++++++++++++--------
 target/riscv/translate.c | 40 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index e34715df4e..74eeef0be8 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -72,11 +72,20 @@ void helper_raise_exception(CPURISCVState *env, uint32_t exception)
     do_raise_exception_err(env, exception, 0);
 }
 
-static void validate_mstatus_fs(CPURISCVState *env, uintptr_t ra)
+static void validate_mstatus_fs(CPURISCVState *env, uintptr_t ra, bool write)
 {
 #ifndef CONFIG_USER_ONLY
-    if (!(env->mstatus & MSTATUS_FS)) {
+    switch (get_field(env->mstatus, MSTATUS_FS)) {
+    case 0: /* disabled */
         do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, ra);
+        g_assert_not_reached();
+    case 1: /* initial */
+    case 2: /* clean */
+        if (write) {
+            /* Mark fp status as dirty.  */
+            env->mstatus = MSTATUS_FS;
+        }
+        break;
     }
 #endif
 }
@@ -96,15 +105,15 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
 
     switch (csrno) {
     case CSR_FFLAGS:
-        validate_mstatus_fs(env, GETPC());
+        validate_mstatus_fs(env, GETPC(), true);
         cpu_riscv_set_fflags(env, val_to_write & (FSR_AEXC >> FSR_AEXC_SHIFT));
         break;
     case CSR_FRM:
-        validate_mstatus_fs(env, GETPC());
+        validate_mstatus_fs(env, GETPC(), true);
         env->frm = val_to_write & (FSR_RD >> FSR_RD_SHIFT);
         break;
     case CSR_FCSR:
-        validate_mstatus_fs(env, GETPC());
+        validate_mstatus_fs(env, GETPC(), true);
         env->frm = (val_to_write & FSR_RD) >> FSR_RD_SHIFT;
         cpu_riscv_set_fflags(env, (val_to_write & FSR_AEXC) >> FSR_AEXC_SHIFT);
         break;
@@ -379,13 +388,13 @@ target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno)
 
     switch (csrno) {
     case CSR_FFLAGS:
-        validate_mstatus_fs(env, GETPC());
+        validate_mstatus_fs(env, GETPC(), false);
         return cpu_riscv_get_fflags(env);
     case CSR_FRM:
-        validate_mstatus_fs(env, GETPC());
+        validate_mstatus_fs(env, GETPC(), false);
         return env->frm;
     case CSR_FCSR:
-        validate_mstatus_fs(env, GETPC());
+        validate_mstatus_fs(env, GETPC(), false);
         return (cpu_riscv_get_fflags(env) << FSR_AEXC_SHIFT)
                 | (env->frm << FSR_RD_SHIFT);
     /* rdtime/rdtimeh is trapped and emulated by bbl in system mode */
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index a30724aa90..08fc42a679 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -660,6 +660,31 @@ static void gen_store(DisasContext *ctx, uint32_t opc, int rs1, int rs2,
     tcg_temp_free(dat);
 }
 
+#ifndef CONFIG_USER_ONLY
+/* The states of mstatus_fs are:
+ * 0 = disabled, 1 = initial, 2 = clean, 3 = dirty
+ * We will have already diagnosed disabled state,
+ * and need to turn initial/clean into dirty.
+ */
+static void mark_fs_dirty(DisasContext *ctx)
+{
+    TCGv tmp;
+    if (ctx->mstatus_fs == MSTATUS_FS) {
+        return;
+    }
+    /* Remember the state change for the rest of the TB.  */
+    ctx->mstatus_fs = MSTATUS_FS;
+
+    tmp = tcg_temp_new();
+    tcg_gen_ld_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
+    tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
+    tcg_gen_st_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
+    tcg_temp_free(tmp);
+}
+#else
+static inline void mark_fs_dirty(DisasContext *ctx) { }
+#endif
+
 static void gen_fp_load(DisasContext *ctx, uint32_t opc, int rd,
         int rs1, target_long imm)
 {
@@ -688,6 +713,8 @@ static void gen_fp_load(DisasContext *ctx, uint32_t opc, int rd,
         break;
     }
     tcg_temp_free(t0);
+
+    mark_fs_dirty(ctx);
 }
 
 static void gen_fp_store(DisasContext *ctx, uint32_t opc, int rs1,
@@ -985,6 +1012,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
                          int rs1, int rs2, int rm)
 {
     TCGv t0 = NULL;
+    bool fp_output = true;
 
     if (ctx->mstatus_fs == 0) {
         goto do_illegal;
@@ -1047,6 +1075,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
         }
         gen_set_gpr(rd, t0);
         tcg_temp_free(t0);
+        fp_output = false;
         break;
 
     case OPC_RISC_FCVT_W_S:
@@ -1076,6 +1105,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
         }
         gen_set_gpr(rd, t0);
         tcg_temp_free(t0);
+        fp_output = false;
         break;
 
     case OPC_RISC_FCVT_S_W:
@@ -1126,6 +1156,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
         }
         gen_set_gpr(rd, t0);
         tcg_temp_free(t0);
+        fp_output = false;
         break;
 
     case OPC_RISC_FMV_S_X:
@@ -1218,6 +1249,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
         }
         gen_set_gpr(rd, t0);
         tcg_temp_free(t0);
+        fp_output = false;
         break;
 
     case OPC_RISC_FCVT_W_D:
@@ -1247,6 +1279,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
         }
         gen_set_gpr(rd, t0);
         tcg_temp_free(t0);
+        fp_output = false;
         break;
 
     case OPC_RISC_FCVT_D_W:
@@ -1294,6 +1327,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
         default:
             goto do_illegal;
         }
+        fp_output = false;
         break;
 
     case OPC_RISC_FMV_D_X:
@@ -1310,7 +1344,11 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
             tcg_temp_free(t0);
         }
         gen_exception_illegal(ctx);
-        break;
+        return;
+    }
+
+    if (fp_output) {
+        mark_fs_dirty(ctx);
     }
 }
 
-- 
2.14.3
