Received: from eggs.gnu.org ([209.51.188.92]:40550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXY-00012Z-9F
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXW-0000mz-8o
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:36:00 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:33293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkXV-0000AK-UL
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:58 -0400
Received: by mail-pg1-x534.google.com with SMTP id k19so3604839pgh.0
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 19 Apr 2019 21:34:32 -1000
Message-Id: <20190420073442.7488-29-richard.henderson@linaro.org>
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 28/38] tcg: Add support for vector comparison
 select
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

At present, only tcg_gen_cmpsel_vec added, which can be used by
other target-specific vector expanders.  It is not clear whether
a full gvec expander would be worthwhile, given the unspecified
nature of the selector.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h |  1 +
 tcg/i386/tcg-target.h    |  1 +
 tcg/tcg-op.h             |  2 ++
 tcg/tcg-opc.h            |  1 +
 tcg/tcg.h                |  1 +
 tcg/tcg-op-gvec.c        |  3 +++
 tcg/tcg-op-vec.c         | 37 +++++++++++++++++++++++++++++++++++++
 tcg/tcg.c                |  2 ++
 tcg/README               | 12 ++++++++++++
 9 files changed, 60 insertions(+)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index e43554c3c7..e1135e930a 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -140,6 +140,7 @@ typedef enum {
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
+#define TCG_TARGET_HAS_cmpsel_vec       0
 
 #define TCG_TARGET_DEFAULT_MO (0)
 #define TCG_TARGET_HAS_MEMORY_BSWAP     1
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 66f16fbe3c..683e029980 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -190,6 +190,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
+#define TCG_TARGET_HAS_cmpsel_vec       0
 
 #define TCG_TARGET_deposit_i32_valid(ofs, len) \
     (((ofs) == 0 && (len) == 8) || ((ofs) == 8 && (len) == 8) || \
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 660fe205d0..6c4cd0aa14 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -999,6 +999,8 @@ void tcg_gen_sarv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
 
 void tcg_gen_cmp_vec(TCGCond cond, unsigned vece, TCGv_vec r,
                      TCGv_vec a, TCGv_vec b);
+void tcg_gen_cmpsel_vec(unsigned vece, TCGv_vec r, TCGv_vec s,
+                        TCGv_vec a, TCGv_vec b);
 
 void tcg_gen_ld_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
 void tcg_gen_st_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index 4a2dd116eb..05fb9e3f37 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -255,6 +255,7 @@ DEF(shrv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shv_vec))
 DEF(sarv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shv_vec))
 
 DEF(cmp_vec, 1, 2, 1, IMPLVEC)
+DEF(cmpsel_vec, 1, 3, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_cmpsel_vec))
 
 DEF(last_generic, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 986055fdfa..1abee6cbe5 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -187,6 +187,7 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_mul_vec          0
 #define TCG_TARGET_HAS_sat_vec          0
 #define TCG_TARGET_HAS_minmax_vec       0
+#define TCG_TARGET_HAS_cmpsel_vec       0
 #else
 #define TCG_TARGET_MAYBE_vec            1
 #endif
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 87d5a01cc9..e7029d26f4 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -96,6 +96,9 @@ static bool tcg_can_emit_vecop_list(const TCGOpcode *list,
                 continue;
             }
             break;
+        case INDEX_op_cmpsel_vec:
+            /* Fallback expansion uses only required logial ops.  */
+            continue;
         default:
             break;
         }
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index b7f21145bb..7d8f7b490a 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -599,3 +599,40 @@ void tcg_gen_sars_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 b)
 {
     do_shifts(vece, r, a, b, INDEX_op_sars_vec, INDEX_op_sarv_vec);
 }
+
+void tcg_gen_cmpsel_vec(unsigned vece, TCGv_vec r, TCGv_vec s,
+                        TCGv_vec a, TCGv_vec b)
+{
+    TCGTemp *rt = tcgv_vec_temp(r);
+    TCGTemp *st = tcgv_vec_temp(s);
+    TCGTemp *at = tcgv_vec_temp(a);
+    TCGTemp *bt = tcgv_vec_temp(b);
+    TCGArg ri = temp_arg(rt);
+    TCGArg si = temp_arg(st);
+    TCGArg ai = temp_arg(at);
+    TCGArg bi = temp_arg(bt);
+    TCGType type = rt->base_type;
+    const TCGOpcode *hold_list;
+    int can;
+
+    tcg_debug_assert(st->base_type >= type);
+    tcg_debug_assert(at->base_type >= type);
+    tcg_debug_assert(bt->base_type >= type);
+    tcg_assert_listed_vecop(INDEX_op_cmpsel_vec);
+    hold_list = tcg_swap_vecop_list(NULL);
+
+    can = tcg_can_emit_vec_op(INDEX_op_cmpsel_vec, type, vece);
+    if (can > 0) {
+        vec_gen_4(INDEX_op_cmpsel_vec, type, vece, ri, si, ai, bi);
+    } else if (can < 0) {
+        tcg_expand_vec_op(INDEX_op_cmpsel_vec, type, vece, ri, si, ai, bi);
+    } else {
+        TCGv_vec t = tcg_temp_new_vec(type);
+
+        tcg_gen_and_vec(vece, t, a, s);
+        tcg_gen_andc_vec(vece, r, b, s);
+        tcg_gen_or_vec(vece, r, r, t);
+        tcg_temp_free_vec(t);
+    }
+    tcg_swap_vecop_list(hold_list);
+}
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 86a95a636b..0c68bd5cf5 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1651,6 +1651,8 @@ bool tcg_op_supported(TCGOpcode op)
     case INDEX_op_smax_vec:
     case INDEX_op_umax_vec:
         return have_vec && TCG_TARGET_HAS_minmax_vec;
+    case INDEX_op_cmpsel_vec:
+        return have_vec && TCG_TARGET_HAS_cmpsel_vec;
 
     default:
         tcg_debug_assert(op > INDEX_op_last_generic && op < NB_OPS);
diff --git a/tcg/README b/tcg/README
index cbdfd3b6bc..16977a8d62 100644
--- a/tcg/README
+++ b/tcg/README
@@ -627,6 +627,18 @@ E.g. VECL=1 -> 64 << 1 -> v128, and VECE=2 -> 1 << 2 -> i32.
 
   Compare vectors by element, storing -1 for true and 0 for false.
 
+* cmpsel_vec v0, v1, v2, v3
+
+  If an element in v1 is "true", select the corresponding element
+  from v2, else select the corresponding element from v3, storing
+  the result in v0.  Nominally, this can be implemented as
+
+    v0 = (v2 & v1) | (v3 & ~v1)
+
+  HOWEVER, it is unspecified which bits of v1 are significant.
+  Thus each element of v1 must be -1 or 0, as if by the result
+  of cmp_vec.
+
 *********
 
 Note 1: Some shortcuts are defined when the last operand is known to be
-- 
2.17.1
