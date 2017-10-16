Received: from eggs.gnu.org ([2001:4830:134:3::10]:52380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49A1-0002Dm-EC
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e499z-0003Wk-ES
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:41 -0400
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229]:49548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e499z-0003WG-6O
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:39 -0400
Received: by mail-pf0-x229.google.com with SMTP id i5so3201637pfe.6
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 10:26:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 16 Oct 2017 10:25:36 -0700
Message-Id: <20171016172609.23422-18-richard.henderson@linaro.org>
In-Reply-To: <20171016172609.23422-1-richard.henderson@linaro.org>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 17/50] tcg: Introduce index_arg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

For multi-threaded tcg we have one TCGContext per thread.  With that,
plus static cpu_* variables, we need the translators to handle indicies.
We transform those to "arguments" at opcode generating time.

For now, that transformation is a no-op.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.h | 92 ++++++++++++++++++++++++++++++------------------------------
 tcg/tcg.h    | 20 +++++++++++++
 tcg/tcg-op.c | 14 ++++-----
 tcg/tcg.c    | 26 ++++++++---------
 4 files changed, 86 insertions(+), 66 deletions(-)

diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index de9a61206a..ca1a3becb9 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -37,12 +37,12 @@ void tcg_gen_op6(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
 
 static inline void tcg_gen_op1_i32(TCGOpcode opc, TCGv_i32 a1)
 {
-    tcg_gen_op1(opc, GET_TCGV_I32(a1));
+    tcg_gen_op1(opc, tcgv_i32_arg(a1));
 }
 
 static inline void tcg_gen_op1_i64(TCGOpcode opc, TCGv_i64 a1)
 {
-    tcg_gen_op1(opc, GET_TCGV_I64(a1));
+    tcg_gen_op1(opc, tcgv_i64_arg(a1));
 }
 
 static inline void tcg_gen_op1i(TCGOpcode opc, TCGArg a1)
@@ -52,22 +52,22 @@ static inline void tcg_gen_op1i(TCGOpcode opc, TCGArg a1)
 
 static inline void tcg_gen_op2_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2)
 {
-    tcg_gen_op2(opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2));
+    tcg_gen_op2(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2));
 }
 
 static inline void tcg_gen_op2_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2)
 {
-    tcg_gen_op2(opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2));
+    tcg_gen_op2(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2));
 }
 
 static inline void tcg_gen_op2i_i32(TCGOpcode opc, TCGv_i32 a1, TCGArg a2)
 {
-    tcg_gen_op2(opc, GET_TCGV_I32(a1), a2);
+    tcg_gen_op2(opc, tcgv_i32_arg(a1), a2);
 }
 
 static inline void tcg_gen_op2i_i64(TCGOpcode opc, TCGv_i64 a1, TCGArg a2)
 {
-    tcg_gen_op2(opc, GET_TCGV_I64(a1), a2);
+    tcg_gen_op2(opc, tcgv_i64_arg(a1), a2);
 }
 
 static inline void tcg_gen_op2ii(TCGOpcode opc, TCGArg a1, TCGArg a2)
@@ -78,167 +78,167 @@ static inline void tcg_gen_op2ii(TCGOpcode opc, TCGArg a1, TCGArg a2)
 static inline void tcg_gen_op3_i32(TCGOpcode opc, TCGv_i32 a1,
                                    TCGv_i32 a2, TCGv_i32 a3)
 {
-    tcg_gen_op3(opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2), GET_TCGV_I32(a3));
+    tcg_gen_op3(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2), tcgv_i32_arg(a3));
 }
 
 static inline void tcg_gen_op3_i64(TCGOpcode opc, TCGv_i64 a1,
                                    TCGv_i64 a2, TCGv_i64 a3)
 {
-    tcg_gen_op3(opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2), GET_TCGV_I64(a3));
+    tcg_gen_op3(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2), tcgv_i64_arg(a3));
 }
 
 static inline void tcg_gen_op3i_i32(TCGOpcode opc, TCGv_i32 a1,
                                     TCGv_i32 a2, TCGArg a3)
 {
-    tcg_gen_op3(opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2), a3);
+    tcg_gen_op3(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2), a3);
 }
 
 static inline void tcg_gen_op3i_i64(TCGOpcode opc, TCGv_i64 a1,
                                     TCGv_i64 a2, TCGArg a3)
 {
-    tcg_gen_op3(opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2), a3);
+    tcg_gen_op3(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3);
 }
 
 static inline void tcg_gen_ldst_op_i32(TCGOpcode opc, TCGv_i32 val,
                                        TCGv_ptr base, TCGArg offset)
 {
-    tcg_gen_op3(opc, GET_TCGV_I32(val), GET_TCGV_PTR(base), offset);
+    tcg_gen_op3(opc, tcgv_i32_arg(val), tcgv_ptr_arg(base), offset);
 }
 
 static inline void tcg_gen_ldst_op_i64(TCGOpcode opc, TCGv_i64 val,
                                        TCGv_ptr base, TCGArg offset)
 {
-    tcg_gen_op3(opc, GET_TCGV_I64(val), GET_TCGV_PTR(base), offset);
+    tcg_gen_op3(opc, tcgv_i64_arg(val), tcgv_ptr_arg(base), offset);
 }
 
 static inline void tcg_gen_op4_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                    TCGv_i32 a3, TCGv_i32 a4)
 {
-    tcg_gen_op4(opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
-                GET_TCGV_I32(a3), GET_TCGV_I32(a4));
+    tcg_gen_op4(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+                tcgv_i32_arg(a3), tcgv_i32_arg(a4));
 }
 
 static inline void tcg_gen_op4_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                    TCGv_i64 a3, TCGv_i64 a4)
 {
-    tcg_gen_op4(opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
-                GET_TCGV_I64(a3), GET_TCGV_I64(a4));
+    tcg_gen_op4(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
+                tcgv_i64_arg(a3), tcgv_i64_arg(a4));
 }
 
 static inline void tcg_gen_op4i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                     TCGv_i32 a3, TCGArg a4)
 {
-    tcg_gen_op4(opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2), GET_TCGV_I32(a3), a4);
+    tcg_gen_op4(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2), tcgv_i32_arg(a3), a4);
 }
 
 static inline void tcg_gen_op4i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                     TCGv_i64 a3, TCGArg a4)
 {
-    tcg_gen_op4(opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2), GET_TCGV_I64(a3), a4);
+    tcg_gen_op4(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2), tcgv_i64_arg(a3), a4);
 }
 
 static inline void tcg_gen_op4ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                      TCGArg a3, TCGArg a4)
 {
-    tcg_gen_op4(opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2), a3, a4);
+    tcg_gen_op4(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2), a3, a4);
 }
 
 static inline void tcg_gen_op4ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                      TCGArg a3, TCGArg a4)
 {
-    tcg_gen_op4(opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2), a3, a4);
+    tcg_gen_op4(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3, a4);
 }
 
 static inline void tcg_gen_op5_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                    TCGv_i32 a3, TCGv_i32 a4, TCGv_i32 a5)
 {
-    tcg_gen_op5(opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
-                GET_TCGV_I32(a3), GET_TCGV_I32(a4), GET_TCGV_I32(a5));
+    tcg_gen_op5(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+                tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5));
 }
 
 static inline void tcg_gen_op5_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                    TCGv_i64 a3, TCGv_i64 a4, TCGv_i64 a5)
 {
-    tcg_gen_op5(opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
-                GET_TCGV_I64(a3), GET_TCGV_I64(a4), GET_TCGV_I64(a5));
+    tcg_gen_op5(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
+                tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5));
 }
 
 static inline void tcg_gen_op5i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                     TCGv_i32 a3, TCGv_i32 a4, TCGArg a5)
 {
-    tcg_gen_op5(opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
-                GET_TCGV_I32(a3), GET_TCGV_I32(a4), a5);
+    tcg_gen_op5(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+                tcgv_i32_arg(a3), tcgv_i32_arg(a4), a5);
 }
 
 static inline void tcg_gen_op5i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                     TCGv_i64 a3, TCGv_i64 a4, TCGArg a5)
 {
-    tcg_gen_op5(opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
-                GET_TCGV_I64(a3), GET_TCGV_I64(a4), a5);
+    tcg_gen_op5(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
+                tcgv_i64_arg(a3), tcgv_i64_arg(a4), a5);
 }
 
 static inline void tcg_gen_op5ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                      TCGv_i32 a3, TCGArg a4, TCGArg a5)
 {
-    tcg_gen_op5(opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
-                GET_TCGV_I32(a3), a4, a5);
+    tcg_gen_op5(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+                tcgv_i32_arg(a3), a4, a5);
 }
 
 static inline void tcg_gen_op5ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                      TCGv_i64 a3, TCGArg a4, TCGArg a5)
 {
-    tcg_gen_op5(opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
-                GET_TCGV_I64(a3), a4, a5);
+    tcg_gen_op5(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
+                tcgv_i64_arg(a3), a4, a5);
 }
 
 static inline void tcg_gen_op6_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                    TCGv_i32 a3, TCGv_i32 a4,
                                    TCGv_i32 a5, TCGv_i32 a6)
 {
-    tcg_gen_op6(opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
-                GET_TCGV_I32(a3), GET_TCGV_I32(a4), GET_TCGV_I32(a5),
-                GET_TCGV_I32(a6));
+    tcg_gen_op6(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+                tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5),
+                tcgv_i32_arg(a6));
 }
 
 static inline void tcg_gen_op6_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                    TCGv_i64 a3, TCGv_i64 a4,
                                    TCGv_i64 a5, TCGv_i64 a6)
 {
-    tcg_gen_op6(opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
-                GET_TCGV_I64(a3), GET_TCGV_I64(a4), GET_TCGV_I64(a5),
-                GET_TCGV_I64(a6));
+    tcg_gen_op6(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
+                tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5),
+                tcgv_i64_arg(a6));
 }
 
 static inline void tcg_gen_op6i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                     TCGv_i32 a3, TCGv_i32 a4,
                                     TCGv_i32 a5, TCGArg a6)
 {
-    tcg_gen_op6(opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
-                GET_TCGV_I32(a3), GET_TCGV_I32(a4), GET_TCGV_I32(a5), a6);
+    tcg_gen_op6(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+                tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5), a6);
 }
 
 static inline void tcg_gen_op6i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                     TCGv_i64 a3, TCGv_i64 a4,
                                     TCGv_i64 a5, TCGArg a6)
 {
-    tcg_gen_op6(opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
-                GET_TCGV_I64(a3), GET_TCGV_I64(a4), GET_TCGV_I64(a5), a6);
+    tcg_gen_op6(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
+                tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5), a6);
 }
 
 static inline void tcg_gen_op6ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                      TCGv_i32 a3, TCGv_i32 a4,
                                      TCGArg a5, TCGArg a6)
 {
-    tcg_gen_op6(opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
-                GET_TCGV_I32(a3), GET_TCGV_I32(a4), a5, a6);
+    tcg_gen_op6(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+                tcgv_i32_arg(a3), tcgv_i32_arg(a4), a5, a6);
 }
 
 static inline void tcg_gen_op6ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                      TCGv_i64 a3, TCGv_i64 a4,
                                      TCGArg a5, TCGArg a6)
 {
-    tcg_gen_op6(opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
-                GET_TCGV_I64(a3), GET_TCGV_I64(a4), a5, a6);
+    tcg_gen_op6(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
+                tcgv_i64_arg(a3), tcgv_i64_arg(a4), a5, a6);
 }
 
 
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 0d61932301..b8ede7fe5c 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -756,6 +756,26 @@ static inline size_t arg_index(TCGArg a)
     return a;
 }
 
+static inline TCGArg index_arg(size_t n)
+{
+    return n;
+}
+
+static inline TCGArg tcgv_i32_arg(TCGv_i32 t)
+{
+    return index_arg(GET_TCGV_I32(t));
+}
+
+static inline TCGArg tcgv_i64_arg(TCGv_i64 t)
+{
+    return index_arg(GET_TCGV_I64(t));
+}
+
+static inline TCGArg tcgv_ptr_arg(TCGv_ptr t)
+{
+    return index_arg(GET_TCGV_PTR(t));
+}
+
 static inline void tcg_set_insn_param(int op_idx, int arg, TCGArg v)
 {
     tcg_ctx.gen_op_buf[op_idx].args[arg] = v;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index bff4b95097..be4b623e82 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2458,7 +2458,7 @@ void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
         tcg_gen_mov_i32(ret, TCGV_LOW(arg));
     } else if (TCG_TARGET_HAS_extrl_i64_i32) {
         tcg_gen_op2(INDEX_op_extrl_i64_i32,
-                    GET_TCGV_I32(ret), GET_TCGV_I64(arg));
+                    tcgv_i32_arg(ret), tcgv_i64_arg(arg));
     } else {
         tcg_gen_mov_i32(ret, MAKE_TCGV_I32(GET_TCGV_I64(arg)));
     }
@@ -2470,7 +2470,7 @@ void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
         tcg_gen_mov_i32(ret, TCGV_HIGH(arg));
     } else if (TCG_TARGET_HAS_extrh_i64_i32) {
         tcg_gen_op2(INDEX_op_extrh_i64_i32,
-                    GET_TCGV_I32(ret), GET_TCGV_I64(arg));
+                    tcgv_i32_arg(ret), tcgv_i64_arg(arg));
     } else {
         TCGv_i64 t = tcg_temp_new_i64();
         tcg_gen_shri_i64(t, arg, 32);
@@ -2486,7 +2486,7 @@ void tcg_gen_extu_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
         tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
     } else {
         tcg_gen_op2(INDEX_op_extu_i32_i64,
-                    GET_TCGV_I64(ret), GET_TCGV_I32(arg));
+                    tcgv_i64_arg(ret), tcgv_i32_arg(arg));
     }
 }
 
@@ -2497,7 +2497,7 @@ void tcg_gen_ext_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
         tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
     } else {
         tcg_gen_op2(INDEX_op_ext_i32_i64,
-                    GET_TCGV_I64(ret), GET_TCGV_I32(arg));
+                    tcgv_i64_arg(ret), tcgv_i32_arg(arg));
     }
 }
 
@@ -2563,7 +2563,7 @@ void tcg_gen_lookup_and_goto_ptr(void)
     if (TCG_TARGET_HAS_goto_ptr && !qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) {
         TCGv_ptr ptr = tcg_temp_new_ptr();
         gen_helper_lookup_tb_ptr(ptr, tcg_ctx.tcg_env);
-        tcg_gen_op1i(INDEX_op_goto_ptr, GET_TCGV_PTR(ptr));
+        tcg_gen_op1i(INDEX_op_goto_ptr, tcgv_ptr_arg(ptr));
         tcg_temp_free_ptr(ptr);
     } else {
         tcg_gen_exit_tb(0);
@@ -2608,7 +2608,7 @@ static void gen_ldst_i32(TCGOpcode opc, TCGv_i32 val, TCGv addr,
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_op4i_i32(opc, val, TCGV_LOW(addr), TCGV_HIGH(addr), oi);
     } else {
-        tcg_gen_op3(opc, GET_TCGV_I32(val), GET_TCGV_I64(addr), oi);
+        tcg_gen_op3(opc, tcgv_i32_arg(val), tcgv_i64_arg(addr), oi);
     }
 #endif
 }
@@ -2621,7 +2621,7 @@ static void gen_ldst_i64(TCGOpcode opc, TCGv_i64 val, TCGv addr,
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_op4i_i32(opc, TCGV_LOW(val), TCGV_HIGH(val), addr, oi);
     } else {
-        tcg_gen_op3(opc, GET_TCGV_I64(val), GET_TCGV_I32(addr), oi);
+        tcg_gen_op3(opc, tcgv_i64_arg(val), tcgv_i32_arg(addr), oi);
     }
 #else
     if (TCG_TARGET_REG_BITS == 32) {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 113700ccc1..129aecca60 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1054,25 +1054,25 @@ void tcg_gen_callN(void *func, TCGArg ret, int nargs, TCGArg *args)
                two return temporaries, and reassemble below.  */
             retl = tcg_temp_new_i64();
             reth = tcg_temp_new_i64();
-            op->args[pi++] = GET_TCGV_I64(reth);
-            op->args[pi++] = GET_TCGV_I64(retl);
+            op->args[pi++] = tcgv_i64_arg(reth);
+            op->args[pi++] = tcgv_i64_arg(retl);
             nb_rets = 2;
         } else {
-            op->args[pi++] = ret;
+            op->args[pi++] = index_arg(ret);
             nb_rets = 1;
         }
 #else
         if (TCG_TARGET_REG_BITS < 64 && (sizemask & 1)) {
 #ifdef HOST_WORDS_BIGENDIAN
-            op->args[pi++] = ret + 1;
-            op->args[pi++] = ret;
+            op->args[pi++] = index_arg(ret + 1);
+            op->args[pi++] = index_arg(ret);
 #else
-            op->args[pi++] = ret;
-            op->args[pi++] = ret + 1;
+            op->args[pi++] = index_arg(ret);
+            op->args[pi++] = index_arg(ret + 1);
 #endif
             nb_rets = 2;
         } else {
-            op->args[pi++] = ret;
+            op->args[pi++] = index_arg(ret);
             nb_rets = 1;
         }
 #endif
@@ -1103,17 +1103,17 @@ void tcg_gen_callN(void *func, TCGArg ret, int nargs, TCGArg *args)
               have to get more complicated to differentiate between
               stack arguments and register arguments.  */
 #if defined(HOST_WORDS_BIGENDIAN) != defined(TCG_TARGET_STACK_GROWSUP)
-            op->args[pi++] = args[i] + 1;
-            op->args[pi++] = args[i];
+            op->args[pi++] = index_arg(args[i] + 1);
+            op->args[pi++] = index_arg(args[i]);
 #else
-            op->args[pi++] = args[i];
-            op->args[pi++] = args[i] + 1;
+            op->args[pi++] = index_arg(args[i]);
+            op->args[pi++] = index_arg(args[i] + 1);
 #endif
             real_args += 2;
             continue;
         }
 
-        op->args[pi++] = args[i];
+        op->args[pi++] = index_arg(args[i]);
         real_args++;
     }
     op->args[pi++] = (uintptr_t)func;
-- 
2.13.6
