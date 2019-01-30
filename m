Received: from eggs.gnu.org ([209.51.188.92]:38318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gotmx-0004cJ-L8
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gotms-0008VJ-CZ
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:36:37 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:37424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gotmm-0008Pr-Nf
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:36:30 -0500
Received: by mail-pg1-x531.google.com with SMTP id c25so126534pgb.4
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 09:36:20 -0800 (PST)
Date: Wed, 30 Jan 2019 09:35:53 -0800
Message-Id: <20190130173601.3268-3-palmer@sifive.com>
In-Reply-To: <20190130173601.3268-1-palmer@sifive.com>
References: <20190130173601.3268-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 02/10] RISC-V: Mark mstatus.fs dirty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Michael Clark <mjc@sifive.com>, Alistair Francis <alistair.francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>

From: Richard Henderson <richard.henderson@linaro.org>

Modifed from Richard Henderson's patch [1] to integrate
with the new control and status register implementation.

[1] https://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg07034.html

Note: the f* CSRs already mark mstatus.FS dirty using
env->mstatus |= mstatus.FS so the bug in the first
spin of this patch has been fixed in a prior commit.

Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Co-authored-by: Richard Henderson <richard.henderson@linaro.org>
Co-authored-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/csr.c       | 12 ------------
 target/riscv/translate.c | 40 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5e7e7d16b8b5..571414768992 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -317,18 +317,6 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
 
     mstatus = (mstatus & ~mask) | (val & mask);
 
-    /* Note: this is a workaround for an issue where mstatus.FS
-       does not report dirty after floating point operations
-       that modify floating point state. This workaround is
-       technically compliant with the RISC-V Privileged
-       specification as it is legal to return only off, or dirty.
-       at the expense of extra floating point save/restore. */
-
-    /* FP is always dirty or off */
-    if (mstatus & MSTATUS_FS) {
-        mstatus |= MSTATUS_FS;
-    }
-
     int dirty = ((mstatus & MSTATUS_FS) == MSTATUS_FS) |
                 ((mstatus & MSTATUS_XS) == MSTATUS_XS);
     mstatus = set_field(mstatus, MSTATUS_SD, dirty);
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 3d07d651b60c..0581b3c1f7d7 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -651,6 +651,31 @@ static void gen_store(DisasContext *ctx, uint32_t opc, int rs1, int rs2,
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
@@ -679,6 +704,8 @@ static void gen_fp_load(DisasContext *ctx, uint32_t opc, int rd,
         break;
     }
     tcg_temp_free(t0);
+
+    mark_fs_dirty(ctx);
 }
 
 static void gen_fp_store(DisasContext *ctx, uint32_t opc, int rs1,
@@ -944,6 +971,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
                          int rs1, int rs2, int rm)
 {
     TCGv t0 = NULL;
+    bool fp_output = true;
 
     if (ctx->mstatus_fs == 0) {
         goto do_illegal;
@@ -1006,6 +1034,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
         }
         gen_set_gpr(rd, t0);
         tcg_temp_free(t0);
+        fp_output = false;
         break;
 
     case OPC_RISC_FCVT_W_S:
@@ -1035,6 +1064,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
         }
         gen_set_gpr(rd, t0);
         tcg_temp_free(t0);
+        fp_output = false;
         break;
 
     case OPC_RISC_FCVT_S_W:
@@ -1085,6 +1115,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
         }
         gen_set_gpr(rd, t0);
         tcg_temp_free(t0);
+        fp_output = false;
         break;
 
     case OPC_RISC_FMV_S_X:
@@ -1177,6 +1208,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
         }
         gen_set_gpr(rd, t0);
         tcg_temp_free(t0);
+        fp_output = false;
         break;
 
     case OPC_RISC_FCVT_W_D:
@@ -1206,6 +1238,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
         }
         gen_set_gpr(rd, t0);
         tcg_temp_free(t0);
+        fp_output = false;
         break;
 
     case OPC_RISC_FCVT_D_W:
@@ -1254,6 +1287,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
         default:
             goto do_illegal;
         }
+        fp_output = false;
         break;
 
 #if defined(TARGET_RISCV64)
@@ -1271,7 +1305,11 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
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
2.18.1
