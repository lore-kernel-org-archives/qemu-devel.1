Received: from eggs.gnu.org ([2001:4830:134:3::10]:59769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ewWqR-0003Su-1h
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:39:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ewWqO-00055F-FI
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:39:15 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:34818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ewWqO-00054j-6G
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:39:12 -0400
Received: by mail-pg0-x242.google.com with SMTP id d1so3040123pgv.2
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 10:39:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 16 Mar 2018 01:38:55 +0800
Message-Id: <20180315173855.22456-4-richard.henderson@linaro.org>
In-Reply-To: <20180315173855.22456-1-richard.henderson@linaro.org>
References: <20180315173855.22456-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL v2 3/3] tcg: Add choose_vector_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This unifies 5 copies of checks for supported vector size,
and in the process fixes a missing check in tcg_gen_gvec_2s.

This lead to an assertion failure for 64-bit vector multiply,
which is not available in the AVX instruction set.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c | 438 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 259 insertions(+), 179 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index bfe44bba81..22db1590d5 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -351,6 +351,42 @@ static void gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in)
     }
 }
 
+/* Select a supported vector type for implementing an operation on SIZE
+ * bytes.  If OP is 0, assume that the real operation to be performed is
+ * required by all backends.  Otherwise, make sure than OP can be performed
+ * on elements of size VECE in the selected type.  Do not select V64 if
+ * PREFER_I64 is true.  Return 0 if no vector type is selected.
+ */
+static TCGType choose_vector_type(TCGOpcode op, unsigned vece, uint32_t size,
+                                  bool prefer_i64)
+{
+    if (TCG_TARGET_HAS_v256 && check_size_impl(size, 32)) {
+        if (op == 0) {
+            return TCG_TYPE_V256;
+        }
+        /* Recall that ARM SVE allows vector sizes that are not a
+         * power of 2, but always a multiple of 16.  The intent is
+         * that e.g. size == 80 would be expanded with 2x32 + 1x16.
+         * It is hard to imagine a case in which v256 is supported
+         * but v128 is not, but check anyway.
+         */
+        if (tcg_can_emit_vec_op(op, TCG_TYPE_V256, vece)
+            && (size % 32 == 0
+                || tcg_can_emit_vec_op(op, TCG_TYPE_V128, vece))) {
+            return TCG_TYPE_V256;
+        }
+    }
+    if (TCG_TARGET_HAS_v128 && check_size_impl(size, 16)
+        && (op == 0 || tcg_can_emit_vec_op(op, TCG_TYPE_V128, vece))) {
+        return TCG_TYPE_V128;
+    }
+    if (TCG_TARGET_HAS_v64 && !prefer_i64 && check_size_impl(size, 8)
+        && (op == 0 || tcg_can_emit_vec_op(op, TCG_TYPE_V64, vece))) {
+        return TCG_TYPE_V64;
+    }
+    return 0;
+}
+
 /* Set OPRSZ bytes at DOFS to replications of IN_32, IN_64 or IN_C.
  * Only one of IN_32 or IN_64 may be set;
  * IN_C is used if IN_32 and IN_64 are unset.
@@ -376,19 +412,12 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
         }
     }
 
-    type = 0;
-    if (TCG_TARGET_HAS_v256 && check_size_impl(oprsz, 32)) {
-        type = TCG_TYPE_V256;
-    } else if (TCG_TARGET_HAS_v128 && check_size_impl(oprsz, 16)) {
-        type = TCG_TYPE_V128;
-    } else if (TCG_TARGET_HAS_v64 && check_size_impl(oprsz, 8)
-               /* Prefer integer when 64-bit host and no variable dup.  */
-               && !(TCG_TARGET_REG_BITS == 64 && in_32 == NULL
-                    && (in_64 == NULL || vece == MO_64))) {
-        type = TCG_TYPE_V64;
-    }
-
-    /* Implement inline with a vector type, if possible.  */
+    /* Implement inline with a vector type, if possible.
+     * Prefer integer when 64-bit host and no variable dup.
+     */
+    type = choose_vector_type(0, vece, oprsz,
+                              (TCG_TARGET_REG_BITS == 64 && in_32 == NULL
+                               && (in_64 == NULL || vece == MO_64)));
     if (type != 0) {
         TCGv_vec t_vec = tcg_temp_new_vec(type);
 
@@ -414,21 +443,30 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
         }
 
         i = 0;
-        if (TCG_TARGET_HAS_v256) {
+        switch (type) {
+        case TCG_TYPE_V256:
+            /* Recall that ARM SVE allows vector sizes that are not a
+             * power of 2, but always a multiple of 16.  The intent is
+             * that e.g. size == 80 would be expanded with 2x32 + 1x16.
+             */
             for (; i + 32 <= oprsz; i += 32) {
                 tcg_gen_stl_vec(t_vec, cpu_env, dofs + i, TCG_TYPE_V256);
             }
-        }
-        if (TCG_TARGET_HAS_v128) {
+            /* fallthru */
+        case TCG_TYPE_V128:
             for (; i + 16 <= oprsz; i += 16) {
                 tcg_gen_stl_vec(t_vec, cpu_env, dofs + i, TCG_TYPE_V128);
             }
-        }
-        if (TCG_TARGET_HAS_v64) {
+            break;
+        case TCG_TYPE_V64:
             for (; i < oprsz; i += 8) {
                 tcg_gen_stl_vec(t_vec, cpu_env, dofs + i, TCG_TYPE_V64);
             }
+            break;
+        default:
+            g_assert_not_reached();
         }
+
         tcg_temp_free_vec(t_vec);
         goto done;
     }
@@ -484,7 +522,7 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
             }
             tcg_temp_free_i64(t_64);
             goto done;
-        } 
+        }
     }
 
     /* Otherwise implement out of line.  */
@@ -866,49 +904,55 @@ static void expand_4_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
                     uint32_t oprsz, uint32_t maxsz, const GVecGen2 *g)
 {
+    TCGType type;
+    uint32_t some;
+
     check_size_align(oprsz, maxsz, dofs | aofs);
     check_overlap_2(dofs, aofs, maxsz);
 
-    /* Recall that ARM SVE allows vector sizes that are not a power of 2.
-       Expand with successively smaller host vector sizes.  The intent is
-       that e.g. oprsz == 80 would be expanded with 2x32 + 1x16.  */
-    /* ??? For maxsz > oprsz, the host may be able to use an opr-sized
-       operation, zeroing the balance of the register.  We can then
-       use a max-sized store to implement the clearing without an extra
-       store operation.  This is true for aarch64 and x86_64 hosts.  */
-
-    if (TCG_TARGET_HAS_v256 && g->fniv && check_size_impl(oprsz, 32)
-        && (!g->opc || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V256, g->vece))) {
-        uint32_t some = QEMU_ALIGN_DOWN(oprsz, 32);
+    type = 0;
+    if (g->fniv) {
+        type = choose_vector_type(g->opc, g->vece, oprsz, g->prefer_i64);
+    }
+    switch (type) {
+    case TCG_TYPE_V256:
+        /* Recall that ARM SVE allows vector sizes that are not a
+         * power of 2, but always a multiple of 16.  The intent is
+         * that e.g. size == 80 would be expanded with 2x32 + 1x16.
+         */
+        some = QEMU_ALIGN_DOWN(oprsz, 32);
         expand_2_vec(g->vece, dofs, aofs, some, 32, TCG_TYPE_V256, g->fniv);
         if (some == oprsz) {
-            goto done;
+            break;
         }
         dofs += some;
         aofs += some;
         oprsz -= some;
         maxsz -= some;
-    }
-
-    if (TCG_TARGET_HAS_v128 && g->fniv && check_size_impl(oprsz, 16)
-        && (!g->opc || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V128, g->vece))) {
+        /* fallthru */
+    case TCG_TYPE_V128:
         expand_2_vec(g->vece, dofs, aofs, oprsz, 16, TCG_TYPE_V128, g->fniv);
-    } else if (TCG_TARGET_HAS_v64 && !g->prefer_i64
-               && g->fniv && check_size_impl(oprsz, 8)
-               && (!g->opc
-                   || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V64, g->vece))) {
+        break;
+    case TCG_TYPE_V64:
         expand_2_vec(g->vece, dofs, aofs, oprsz, 8, TCG_TYPE_V64, g->fniv);
-    } else if (g->fni8 && check_size_impl(oprsz, 8)) {
-        expand_2_i64(dofs, aofs, oprsz, g->fni8);
-    } else if (g->fni4 && check_size_impl(oprsz, 4)) {
-        expand_2_i32(dofs, aofs, oprsz, g->fni4);
-    } else {
-        assert(g->fno != NULL);
-        tcg_gen_gvec_2_ool(dofs, aofs, oprsz, maxsz, g->data, g->fno);
-        return;
+        break;
+
+    case 0:
+        if (g->fni8 && check_size_impl(oprsz, 8)) {
+            expand_2_i64(dofs, aofs, oprsz, g->fni8);
+        } else if (g->fni4 && check_size_impl(oprsz, 4)) {
+            expand_2_i32(dofs, aofs, oprsz, g->fni4);
+        } else {
+            assert(g->fno != NULL);
+            tcg_gen_gvec_2_ool(dofs, aofs, oprsz, maxsz, g->data, g->fno);
+            return;
+        }
+        break;
+
+    default:
+        g_assert_not_reached();
     }
 
- done:
     if (oprsz < maxsz) {
         expand_clr(dofs + oprsz, maxsz - oprsz);
     }
@@ -918,53 +962,64 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
                      uint32_t maxsz, int64_t c, const GVecGen2i *g)
 {
+    TCGType type;
+    uint32_t some;
+
     check_size_align(oprsz, maxsz, dofs | aofs);
     check_overlap_2(dofs, aofs, maxsz);
 
-    /* Recall that ARM SVE allows vector sizes that are not a power of 2.
-       Expand with successively smaller host vector sizes.  The intent is
-       that e.g. oprsz == 80 would be expanded with 2x32 + 1x16.  */
-
-    if (TCG_TARGET_HAS_v256 && g->fniv && check_size_impl(oprsz, 32)
-        && (!g->opc || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V256, g->vece))) {
-        uint32_t some = QEMU_ALIGN_DOWN(oprsz, 32);
+    type = 0;
+    if (g->fniv) {
+        type = choose_vector_type(g->opc, g->vece, oprsz, g->prefer_i64);
+    }
+    switch (type) {
+    case TCG_TYPE_V256:
+        /* Recall that ARM SVE allows vector sizes that are not a
+         * power of 2, but always a multiple of 16.  The intent is
+         * that e.g. size == 80 would be expanded with 2x32 + 1x16.
+         */
+        some = QEMU_ALIGN_DOWN(oprsz, 32);
         expand_2i_vec(g->vece, dofs, aofs, some, 32, TCG_TYPE_V256,
                       c, g->load_dest, g->fniv);
         if (some == oprsz) {
-            goto done;
+            break;
         }
         dofs += some;
         aofs += some;
         oprsz -= some;
         maxsz -= some;
-    }
-
-    if (TCG_TARGET_HAS_v128 && g->fniv && check_size_impl(oprsz, 16)
-        && (!g->opc || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V128, g->vece))) {
+        /* fallthru */
+    case TCG_TYPE_V128:
         expand_2i_vec(g->vece, dofs, aofs, oprsz, 16, TCG_TYPE_V128,
                       c, g->load_dest, g->fniv);
-    } else if (TCG_TARGET_HAS_v64 && !g->prefer_i64
-               && g->fniv && check_size_impl(oprsz, 8)
-               && (!g->opc
-                   || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V64, g->vece))) {
+        break;
+    case TCG_TYPE_V64:
         expand_2i_vec(g->vece, dofs, aofs, oprsz, 8, TCG_TYPE_V64,
                       c, g->load_dest, g->fniv);
-    } else if (g->fni8 && check_size_impl(oprsz, 8)) {
-        expand_2i_i64(dofs, aofs, oprsz, c, g->load_dest, g->fni8);
-    } else if (g->fni4 && check_size_impl(oprsz, 4)) {
-        expand_2i_i32(dofs, aofs, oprsz, c, g->load_dest, g->fni4);
-    } else {
-        if (g->fno) {
-            tcg_gen_gvec_2_ool(dofs, aofs, oprsz, maxsz, c, g->fno);
+        break;
+
+    case 0:
+        if (g->fni8 && check_size_impl(oprsz, 8)) {
+            expand_2i_i64(dofs, aofs, oprsz, c, g->load_dest, g->fni8);
+        } else if (g->fni4 && check_size_impl(oprsz, 4)) {
+            expand_2i_i32(dofs, aofs, oprsz, c, g->load_dest, g->fni4);
         } else {
-            TCGv_i64 tcg_c = tcg_const_i64(c);
-            tcg_gen_gvec_2i_ool(dofs, aofs, tcg_c, oprsz, maxsz, c, g->fnoi);
-            tcg_temp_free_i64(tcg_c);
+            if (g->fno) {
+                tcg_gen_gvec_2_ool(dofs, aofs, oprsz, maxsz, c, g->fno);
+            } else {
+                TCGv_i64 tcg_c = tcg_const_i64(c);
+                tcg_gen_gvec_2i_ool(dofs, aofs, tcg_c, oprsz,
+                                    maxsz, c, g->fnoi);
+                tcg_temp_free_i64(tcg_c);
+            }
+            return;
         }
-        return;
+        break;
+
+    default:
+        g_assert_not_reached();
     }
 
- done:
     if (oprsz < maxsz) {
         expand_clr(dofs + oprsz, maxsz - oprsz);
     }
@@ -981,37 +1036,30 @@ void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
 
     type = 0;
     if (g->fniv) {
-        if (TCG_TARGET_HAS_v256 && check_size_impl(oprsz, 32)) {
-            type = TCG_TYPE_V256;
-        } else if (TCG_TARGET_HAS_v128 && check_size_impl(oprsz, 16)) {
-            type = TCG_TYPE_V128;
-        } else if (TCG_TARGET_HAS_v64 && !g->prefer_i64
-               && check_size_impl(oprsz, 8)) {
-            type = TCG_TYPE_V64;
-        }
+        type = choose_vector_type(g->opc, g->vece, oprsz, g->prefer_i64);
     }
     if (type != 0) {
         TCGv_vec t_vec = tcg_temp_new_vec(type);
+        uint32_t some;
 
         tcg_gen_dup_i64_vec(g->vece, t_vec, c);
 
-        /* Recall that ARM SVE allows vector sizes that are not a power of 2.
-           Expand with successively smaller host vector sizes.  The intent is
-           that e.g. oprsz == 80 would be expanded with 2x32 + 1x16.  */
         switch (type) {
         case TCG_TYPE_V256:
-            {
-                uint32_t some = QEMU_ALIGN_DOWN(oprsz, 32);
-                expand_2s_vec(g->vece, dofs, aofs, some, 32, TCG_TYPE_V256,
-                              t_vec, g->scalar_first, g->fniv);
-                if (some == oprsz) {
-                    break;
-                }
-                dofs += some;
-                aofs += some;
-                oprsz -= some;
-                maxsz -= some;
+            /* Recall that ARM SVE allows vector sizes that are not a
+             * power of 2, but always a multiple of 16.  The intent is
+             * that e.g. size == 80 would be expanded with 2x32 + 1x16.
+             */
+            some = QEMU_ALIGN_DOWN(oprsz, 32);
+            expand_2s_vec(g->vece, dofs, aofs, some, 32, TCG_TYPE_V256,
+                          t_vec, g->scalar_first, g->fniv);
+            if (some == oprsz) {
+                break;
             }
+            dofs += some;
+            aofs += some;
+            oprsz -= some;
+            maxsz -= some;
             /* fallthru */
 
         case TCG_TYPE_V128:
@@ -1055,48 +1103,60 @@ void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
 void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                     uint32_t oprsz, uint32_t maxsz, const GVecGen3 *g)
 {
+    TCGType type;
+    uint32_t some;
+
     check_size_align(oprsz, maxsz, dofs | aofs | bofs);
     check_overlap_3(dofs, aofs, bofs, maxsz);
 
-    /* Recall that ARM SVE allows vector sizes that are not a power of 2.
-       Expand with successively smaller host vector sizes.  The intent is
-       that e.g. oprsz == 80 would be expanded with 2x32 + 1x16.  */
-
-    if (TCG_TARGET_HAS_v256 && g->fniv && check_size_impl(oprsz, 32)
-        && (!g->opc || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V256, g->vece))) {
-        uint32_t some = QEMU_ALIGN_DOWN(oprsz, 32);
+    type = 0;
+    if (g->fniv) {
+        type = choose_vector_type(g->opc, g->vece, oprsz, g->prefer_i64);
+    }
+    switch (type) {
+    case TCG_TYPE_V256:
+        /* Recall that ARM SVE allows vector sizes that are not a
+         * power of 2, but always a multiple of 16.  The intent is
+         * that e.g. size == 80 would be expanded with 2x32 + 1x16.
+         */
+        some = QEMU_ALIGN_DOWN(oprsz, 32);
         expand_3_vec(g->vece, dofs, aofs, bofs, some, 32, TCG_TYPE_V256,
                      g->load_dest, g->fniv);
         if (some == oprsz) {
-            goto done;
+            break;
         }
         dofs += some;
         aofs += some;
         bofs += some;
         oprsz -= some;
         maxsz -= some;
-    }
-
-    if (TCG_TARGET_HAS_v128 && g->fniv && check_size_impl(oprsz, 16)
-        && (!g->opc || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V128, g->vece))) {
+        /* fallthru */
+    case TCG_TYPE_V128:
         expand_3_vec(g->vece, dofs, aofs, bofs, oprsz, 16, TCG_TYPE_V128,
                      g->load_dest, g->fniv);
-    } else if (TCG_TARGET_HAS_v64 && !g->prefer_i64
-               && g->fniv && check_size_impl(oprsz, 8)
-               && (!g->opc
-                   || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V64, g->vece))) {
+        break;
+    case TCG_TYPE_V64:
         expand_3_vec(g->vece, dofs, aofs, bofs, oprsz, 8, TCG_TYPE_V64,
                      g->load_dest, g->fniv);
-    } else if (g->fni8 && check_size_impl(oprsz, 8)) {
-        expand_3_i64(dofs, aofs, bofs, oprsz, g->load_dest, g->fni8);
-    } else if (g->fni4 && check_size_impl(oprsz, 4)) {
-        expand_3_i32(dofs, aofs, bofs, oprsz, g->load_dest, g->fni4);
-    } else {
-        assert(g->fno != NULL);
-        tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz, maxsz, g->data, g->fno);
+        break;
+
+    case 0:
+        if (g->fni8 && check_size_impl(oprsz, 8)) {
+            expand_3_i64(dofs, aofs, bofs, oprsz, g->load_dest, g->fni8);
+        } else if (g->fni4 && check_size_impl(oprsz, 4)) {
+            expand_3_i32(dofs, aofs, bofs, oprsz, g->load_dest, g->fni4);
+        } else {
+            assert(g->fno != NULL);
+            tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz,
+                               maxsz, g->data, g->fno);
+            return;
+        }
+        break;
+
+    default:
+        g_assert_not_reached();
     }
 
- done:
     if (oprsz < maxsz) {
         expand_clr(dofs + oprsz, maxsz - oprsz);
     }
@@ -1106,20 +1166,27 @@ void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
 void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
                     uint32_t oprsz, uint32_t maxsz, const GVecGen4 *g)
 {
+    TCGType type;
+    uint32_t some;
+
     check_size_align(oprsz, maxsz, dofs | aofs | bofs | cofs);
     check_overlap_4(dofs, aofs, bofs, cofs, maxsz);
 
-    /* Recall that ARM SVE allows vector sizes that are not a power of 2.
-       Expand with successively smaller host vector sizes.  The intent is
-       that e.g. oprsz == 80 would be expanded with 2x32 + 1x16.  */
-
-    if (TCG_TARGET_HAS_v256 && g->fniv && check_size_impl(oprsz, 32)
-        && (!g->opc || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V256, g->vece))) {
-        uint32_t some = QEMU_ALIGN_DOWN(oprsz, 32);
+    type = 0;
+    if (g->fniv) {
+        type = choose_vector_type(g->opc, g->vece, oprsz, g->prefer_i64);
+    }
+    switch (type) {
+    case TCG_TYPE_V256:
+        /* Recall that ARM SVE allows vector sizes that are not a
+         * power of 2, but always a multiple of 16.  The intent is
+         * that e.g. size == 80 would be expanded with 2x32 + 1x16.
+         */
+        some = QEMU_ALIGN_DOWN(oprsz, 32);
         expand_4_vec(g->vece, dofs, aofs, bofs, cofs, some,
                      32, TCG_TYPE_V256, g->fniv);
         if (some == oprsz) {
-            goto done;
+            break;
         }
         dofs += some;
         aofs += some;
@@ -1127,30 +1194,33 @@ void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
         cofs += some;
         oprsz -= some;
         maxsz -= some;
-    }
-
-    if (TCG_TARGET_HAS_v128 && g->fniv && check_size_impl(oprsz, 16)
-        && (!g->opc || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V128, g->vece))) {
+        /* fallthru */
+    case TCG_TYPE_V128:
         expand_4_vec(g->vece, dofs, aofs, bofs, cofs, oprsz,
                      16, TCG_TYPE_V128, g->fniv);
-    } else if (TCG_TARGET_HAS_v64 && !g->prefer_i64
-               && g->fniv && check_size_impl(oprsz, 8)
-                && (!g->opc
-                    || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V64, g->vece))) {
+        break;
+    case TCG_TYPE_V64:
         expand_4_vec(g->vece, dofs, aofs, bofs, cofs, oprsz,
                      8, TCG_TYPE_V64, g->fniv);
-    } else if (g->fni8 && check_size_impl(oprsz, 8)) {
-        expand_4_i64(dofs, aofs, bofs, cofs, oprsz, g->fni8);
-    } else if (g->fni4 && check_size_impl(oprsz, 4)) {
-        expand_4_i32(dofs, aofs, bofs, cofs, oprsz, g->fni4);
-    } else {
-        assert(g->fno != NULL);
-        tcg_gen_gvec_4_ool(dofs, aofs, bofs, cofs,
-                           oprsz, maxsz, g->data, g->fno);
-        return;
+        break;
+
+    case 0:
+        if (g->fni8 && check_size_impl(oprsz, 8)) {
+            expand_4_i64(dofs, aofs, bofs, cofs, oprsz, g->fni8);
+        } else if (g->fni4 && check_size_impl(oprsz, 4)) {
+            expand_4_i32(dofs, aofs, bofs, cofs, oprsz, g->fni4);
+        } else {
+            assert(g->fno != NULL);
+            tcg_gen_gvec_4_ool(dofs, aofs, bofs, cofs,
+                               oprsz, maxsz, g->data, g->fno);
+            return;
+        }
+        break;
+
+    default:
+        g_assert_not_reached();
     }
 
- done:
     if (oprsz < maxsz) {
         expand_clr(dofs + oprsz, maxsz - oprsz);
     }
@@ -2155,6 +2225,8 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
         [TCG_COND_LTU] = ltu_fn,
         [TCG_COND_LEU] = leu_fn,
     };
+    TCGType type;
+    uint32_t some;
 
     check_size_align(oprsz, maxsz, dofs | aofs | bofs);
     check_overlap_3(dofs, aofs, bofs, maxsz);
@@ -2165,51 +2237,59 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
         return;
     }
 
-    /* Recall that ARM SVE allows vector sizes that are not a power of 2.
-       Expand with successively smaller host vector sizes.  The intent is
-       that e.g. oprsz == 80 would be expanded with 2x32 + 1x16.  */
-
-    if (TCG_TARGET_HAS_v256 && check_size_impl(oprsz, 32)
-        && tcg_can_emit_vec_op(INDEX_op_cmp_vec, TCG_TYPE_V256, vece)) {
-        uint32_t some = QEMU_ALIGN_DOWN(oprsz, 32);
+    /* Implement inline with a vector type, if possible.
+     * Prefer integer when 64-bit host and 64-bit comparison.
+     */
+    type = choose_vector_type(INDEX_op_cmp_vec, vece, oprsz,
+                              TCG_TARGET_REG_BITS == 64 && vece == MO_64);
+    switch (type) {
+    case TCG_TYPE_V256:
+        /* Recall that ARM SVE allows vector sizes that are not a
+         * power of 2, but always a multiple of 16.  The intent is
+         * that e.g. size == 80 would be expanded with 2x32 + 1x16.
+         */
+        some = QEMU_ALIGN_DOWN(oprsz, 32);
         expand_cmp_vec(vece, dofs, aofs, bofs, some, 32, TCG_TYPE_V256, cond);
         if (some == oprsz) {
-            goto done;
+            break;
         }
         dofs += some;
         aofs += some;
         bofs += some;
         oprsz -= some;
         maxsz -= some;
-    }
-
-    if (TCG_TARGET_HAS_v128 && check_size_impl(oprsz, 16)
-        && tcg_can_emit_vec_op(INDEX_op_cmp_vec, TCG_TYPE_V128, vece)) {
+        /* fallthru */
+    case TCG_TYPE_V128:
         expand_cmp_vec(vece, dofs, aofs, bofs, oprsz, 16, TCG_TYPE_V128, cond);
-    } else if (TCG_TARGET_HAS_v64
-               && check_size_impl(oprsz, 8)
-               && (TCG_TARGET_REG_BITS == 32 || vece != MO_64)
-               && tcg_can_emit_vec_op(INDEX_op_cmp_vec, TCG_TYPE_V64, vece)) {
+        break;
+    case TCG_TYPE_V64:
         expand_cmp_vec(vece, dofs, aofs, bofs, oprsz, 8, TCG_TYPE_V64, cond);
-    } else if (vece == MO_64 && check_size_impl(oprsz, 8)) {
-        expand_cmp_i64(dofs, aofs, bofs, oprsz, cond);
-    } else if (vece == MO_32 && check_size_impl(oprsz, 4)) {
-        expand_cmp_i32(dofs, aofs, bofs, oprsz, cond);
-    } else {
-        gen_helper_gvec_3 * const *fn = fns[cond];
+        break;
 
-        if (fn == NULL) {
-            uint32_t tmp;
-            tmp = aofs, aofs = bofs, bofs = tmp;
-            cond = tcg_swap_cond(cond);
-            fn = fns[cond];
-            assert(fn != NULL);
+    case 0:
+        if (vece == MO_64 && check_size_impl(oprsz, 8)) {
+            expand_cmp_i64(dofs, aofs, bofs, oprsz, cond);
+        } else if (vece == MO_32 && check_size_impl(oprsz, 4)) {
+            expand_cmp_i32(dofs, aofs, bofs, oprsz, cond);
+        } else {
+            gen_helper_gvec_3 * const *fn = fns[cond];
+
+            if (fn == NULL) {
+                uint32_t tmp;
+                tmp = aofs, aofs = bofs, bofs = tmp;
+                cond = tcg_swap_cond(cond);
+                fn = fns[cond];
+                assert(fn != NULL);
+            }
+            tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz, maxsz, 0, fn[vece]);
+            return;
         }
-        tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz, maxsz, 0, fn[vece]);
-        return;
+        break;
+
+    default:
+        g_assert_not_reached();
     }
 
- done:
     if (oprsz < maxsz) {
         expand_clr(dofs + oprsz, maxsz - oprsz);
     }
-- 
2.14.3
