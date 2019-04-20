Received: from eggs.gnu.org ([209.51.188.92]:40197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWg-0008VI-Cb
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWe-00080H-Rq
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:06 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkWe-0007zd-KN
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:04 -0400
Received: by mail-pf1-x443.google.com with SMTP id e24so3448169pfi.12
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 19 Apr 2019 21:34:15 -1000
Message-Id: <20190420073442.7488-12-richard.henderson@linaro.org>
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 11/38] tcg: Add INDEX_op_dup_mem_vec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@redhat.com

Allow the backend to expand dup from memory directly, instead of
forcing the value into a temp first.  This is especially important
if integer/vector register moves do not exist.

Note that officially tcg_out_dupm_vec is allowed to fail.
If it did, we could fix this up relatively easily:

  VECE == 32/64:
    Load the value into a vector register, then dup.
    Both of these must work.

  VECE == 8/16:
    If the value happens to be at an offset such that an aligned
    load would place the desired value in the least significant
    end of the register, go ahead and load w/garbage in high bits.

    Load the value w/INDEX_op_ld{8,16}_i32.
    Attempt a move directly to vector reg, which may fail.
    Store the value into the backing store for OTS.
    Load the value into the vector reg w/TCG_TYPE_I32, which must work.
    Duplicate from the vector reg into itself, which must work.

All of which is well and good, except that all supported
hosts can support dupm for all vece, so all of the failure
paths would be dead code and untestable.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.h                 |  1 +
 tcg/tcg-opc.h                |  1 +
 tcg/aarch64/tcg-target.inc.c |  4 ++
 tcg/i386/tcg-target.inc.c    |  4 ++
 tcg/tcg-op-gvec.c            | 88 +++++++++++++++++++-----------------
 tcg/tcg-op-vec.c             | 11 +++++
 tcg/tcg.c                    |  1 +
 7 files changed, 69 insertions(+), 41 deletions(-)

diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 1f1824c30a..9fff9864f6 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -954,6 +954,7 @@ void tcg_gen_atomic_umax_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
 void tcg_gen_mov_vec(TCGv_vec, TCGv_vec);
 void tcg_gen_dup_i32_vec(unsigned vece, TCGv_vec, TCGv_i32);
 void tcg_gen_dup_i64_vec(unsigned vece, TCGv_vec, TCGv_i64);
+void tcg_gen_dup_mem_vec(unsigned vece, TCGv_vec, TCGv_ptr, tcg_target_long);
 void tcg_gen_dup8i_vec(TCGv_vec, uint32_t);
 void tcg_gen_dup16i_vec(TCGv_vec, uint32_t);
 void tcg_gen_dup32i_vec(TCGv_vec, uint32_t);
diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index 1bad6e4208..4bf71f261f 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -219,6 +219,7 @@ DEF(dup2_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_REG_BITS == 32))
 
 DEF(ld_vec, 1, 1, 1, IMPLVEC)
 DEF(st_vec, 0, 2, 1, IMPLVEC)
+DEF(dupm_vec, 1, 1, 1, IMPLVEC)
 
 DEF(add_vec, 1, 2, 0, IMPLVEC)
 DEF(sub_vec, 1, 2, 0, IMPLVEC)
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 1db4e22365..1c9f4b0cb3 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -2188,6 +2188,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_st_vec:
         tcg_out_st(s, type, a0, a1, a2);
         break;
+    case INDEX_op_dupm_vec:
+        tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
+        break;
     case INDEX_op_add_vec:
         tcg_out_insn(s, 3616, ADD, is_q, vece, a0, a1, a2);
         break;
@@ -2520,6 +2523,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         return &w_w;
     case INDEX_op_ld_vec:
     case INDEX_op_st_vec:
+    case INDEX_op_dupm_vec:
         return &w_r;
     case INDEX_op_dup_vec:
         return &w_wr;
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index fcabc1bdf2..4c42a2430d 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -2827,6 +2827,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_st_vec:
         tcg_out_st(s, type, a0, a1, a2);
         break;
+    case INDEX_op_dupm_vec:
+        tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
+        break;
 
     case INDEX_op_x86_shufps_vec:
         insn = OPC_SHUFPS;
@@ -3113,6 +3116,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_ld_vec:
     case INDEX_op_st_vec:
+    case INDEX_op_dupm_vec:
         return &x_r;
 
     case INDEX_op_add_vec:
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 0996ef0812..f056018713 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -390,6 +390,40 @@ static TCGType choose_vector_type(TCGOpcode op, unsigned vece, uint32_t size,
     return 0;
 }
 
+static void do_dup_store(TCGType type, uint32_t dofs, uint32_t oprsz,
+                         uint32_t maxsz, TCGv_vec t_vec)
+{
+    uint32_t i = 0;
+
+    switch (type) {
+    case TCG_TYPE_V256:
+        /* Recall that ARM SVE allows vector sizes that are not a
+         * power of 2, but always a multiple of 16.  The intent is
+         * that e.g. size == 80 would be expanded with 2x32 + 1x16.
+         */
+        for (; i + 32 <= oprsz; i += 32) {
+            tcg_gen_stl_vec(t_vec, cpu_env, dofs + i, TCG_TYPE_V256);
+        }
+        /* fallthru */
+    case TCG_TYPE_V128:
+        for (; i + 16 <= oprsz; i += 16) {
+            tcg_gen_stl_vec(t_vec, cpu_env, dofs + i, TCG_TYPE_V128);
+        }
+        break;
+    case TCG_TYPE_V64:
+        for (; i < oprsz; i += 8) {
+            tcg_gen_stl_vec(t_vec, cpu_env, dofs + i, TCG_TYPE_V64);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (oprsz < maxsz) {
+        expand_clr(dofs + oprsz, maxsz - oprsz);
+    }
+}
+
 /* Set OPRSZ bytes at DOFS to replications of IN_32, IN_64 or IN_C.
  * Only one of IN_32 or IN_64 may be set;
  * IN_C is used if IN_32 and IN_64 are unset.
@@ -429,49 +463,11 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
         } else if (in_64) {
             tcg_gen_dup_i64_vec(vece, t_vec, in_64);
         } else {
-            switch (vece) {
-            case MO_8:
-                tcg_gen_dup8i_vec(t_vec, in_c);
-                break;
-            case MO_16:
-                tcg_gen_dup16i_vec(t_vec, in_c);
-                break;
-            case MO_32:
-                tcg_gen_dup32i_vec(t_vec, in_c);
-                break;
-            default:
-                tcg_gen_dup64i_vec(t_vec, in_c);
-                break;
-            }
+            tcg_gen_dupi_vec(vece, t_vec, in_c);
         }
-
-        i = 0;
-        switch (type) {
-        case TCG_TYPE_V256:
-            /* Recall that ARM SVE allows vector sizes that are not a
-             * power of 2, but always a multiple of 16.  The intent is
-             * that e.g. size == 80 would be expanded with 2x32 + 1x16.
-             */
-            for (; i + 32 <= oprsz; i += 32) {
-                tcg_gen_stl_vec(t_vec, cpu_env, dofs + i, TCG_TYPE_V256);
-            }
-            /* fallthru */
-        case TCG_TYPE_V128:
-            for (; i + 16 <= oprsz; i += 16) {
-                tcg_gen_stl_vec(t_vec, cpu_env, dofs + i, TCG_TYPE_V128);
-            }
-            break;
-        case TCG_TYPE_V64:
-            for (; i < oprsz; i += 8) {
-                tcg_gen_stl_vec(t_vec, cpu_env, dofs + i, TCG_TYPE_V64);
-            }
-            break;
-        default:
-            g_assert_not_reached();
-        }
-
+        do_dup_store(type, dofs, oprsz, maxsz, t_vec);
         tcg_temp_free_vec(t_vec);
-        goto done;
+        return;
     }
 
     /* Otherwise, inline with an integer type, unless "large".  */
@@ -1287,6 +1283,16 @@ void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dofs, uint32_t oprsz,
 void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
                           uint32_t oprsz, uint32_t maxsz)
 {
+    if (vece <= MO_64) {
+        TCGType type = choose_vector_type(0, vece, oprsz, 0);
+        if (type != 0) {
+            TCGv_vec t_vec = tcg_temp_new_vec(type);
+            tcg_gen_dup_mem_vec(vece, t_vec, cpu_env, aofs);
+            do_dup_store(type, dofs, oprsz, maxsz, t_vec);
+            tcg_temp_free_vec(t_vec);
+            return;
+        }
+    }
     if (vece <= MO_32) {
         TCGv_i32 in = tcg_temp_new_i32();
         switch (vece) {
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index cfb18682b1..ce7987b858 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -194,6 +194,17 @@ void tcg_gen_dup_i32_vec(unsigned vece, TCGv_vec r, TCGv_i32 a)
     vec_gen_2(INDEX_op_dup_vec, type, vece, ri, ai);
 }
 
+void tcg_gen_dup_mem_vec(unsigned vece, TCGv_vec r, TCGv_ptr b,
+                         tcg_target_long ofs)
+{
+    TCGArg ri = tcgv_vec_arg(r);
+    TCGArg bi = tcgv_ptr_arg(b);
+    TCGTemp *rt = arg_temp(ri);
+    TCGType type = rt->base_type;
+
+    vec_gen_3(INDEX_op_dupm_vec, type, vece, ri, bi, ofs);
+}
+
 static void vec_gen_ldst(TCGOpcode opc, TCGv_vec r, TCGv_ptr b, TCGArg o)
 {
     TCGArg ri = tcgv_vec_arg(r);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 1c34c08791..0b0b228bb5 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1605,6 +1605,7 @@ bool tcg_op_supported(TCGOpcode op)
     case INDEX_op_mov_vec:
     case INDEX_op_dup_vec:
     case INDEX_op_dupi_vec:
+    case INDEX_op_dupm_vec:
     case INDEX_op_ld_vec:
     case INDEX_op_st_vec:
     case INDEX_op_add_vec:
-- 
2.17.1
