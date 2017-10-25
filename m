Received: from eggs.gnu.org ([2001:4830:134:3::10]:45536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6T-0008Fa-38
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6Q-00086O-TE
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:01 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:50349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7I6Q-00085o-If
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:35:58 -0400
Received: by mail-wm0-x242.google.com with SMTP id u138so594893wmu.5
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 02:35:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 11:34:58 +0200
Message-Id: <20171025093535.10175-15-richard.henderson@linaro.org>
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/51] tcg: Push tcg_ctx into generator functions
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

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.h | 100 +++++++++++++++++++++++++++--------------------------------
 tcg/tcg-op.c |  47 ++++++++++++++--------------
 2 files changed, 69 insertions(+), 78 deletions(-)

diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 18d01b2f43..de9a61206a 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -28,173 +28,166 @@
 
 /* Basic output routines.  Not for general consumption.  */
 
-void tcg_gen_op1(TCGContext *, TCGOpcode, TCGArg);
-void tcg_gen_op2(TCGContext *, TCGOpcode, TCGArg, TCGArg);
-void tcg_gen_op3(TCGContext *, TCGOpcode, TCGArg, TCGArg, TCGArg);
-void tcg_gen_op4(TCGContext *, TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg);
-void tcg_gen_op5(TCGContext *, TCGOpcode, TCGArg, TCGArg, TCGArg,
-                 TCGArg, TCGArg);
-void tcg_gen_op6(TCGContext *, TCGOpcode, TCGArg, TCGArg, TCGArg,
-                 TCGArg, TCGArg, TCGArg);
-
+void tcg_gen_op1(TCGOpcode, TCGArg);
+void tcg_gen_op2(TCGOpcode, TCGArg, TCGArg);
+void tcg_gen_op3(TCGOpcode, TCGArg, TCGArg, TCGArg);
+void tcg_gen_op4(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg);
+void tcg_gen_op5(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
+void tcg_gen_op6(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
 
 static inline void tcg_gen_op1_i32(TCGOpcode opc, TCGv_i32 a1)
 {
-    tcg_gen_op1(&tcg_ctx, opc, GET_TCGV_I32(a1));
+    tcg_gen_op1(opc, GET_TCGV_I32(a1));
 }
 
 static inline void tcg_gen_op1_i64(TCGOpcode opc, TCGv_i64 a1)
 {
-    tcg_gen_op1(&tcg_ctx, opc, GET_TCGV_I64(a1));
+    tcg_gen_op1(opc, GET_TCGV_I64(a1));
 }
 
 static inline void tcg_gen_op1i(TCGOpcode opc, TCGArg a1)
 {
-    tcg_gen_op1(&tcg_ctx, opc, a1);
+    tcg_gen_op1(opc, a1);
 }
 
 static inline void tcg_gen_op2_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2)
 {
-    tcg_gen_op2(&tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2));
+    tcg_gen_op2(opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2));
 }
 
 static inline void tcg_gen_op2_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2)
 {
-    tcg_gen_op2(&tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2));
+    tcg_gen_op2(opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2));
 }
 
 static inline void tcg_gen_op2i_i32(TCGOpcode opc, TCGv_i32 a1, TCGArg a2)
 {
-    tcg_gen_op2(&tcg_ctx, opc, GET_TCGV_I32(a1), a2);
+    tcg_gen_op2(opc, GET_TCGV_I32(a1), a2);
 }
 
 static inline void tcg_gen_op2i_i64(TCGOpcode opc, TCGv_i64 a1, TCGArg a2)
 {
-    tcg_gen_op2(&tcg_ctx, opc, GET_TCGV_I64(a1), a2);
+    tcg_gen_op2(opc, GET_TCGV_I64(a1), a2);
 }
 
 static inline void tcg_gen_op2ii(TCGOpcode opc, TCGArg a1, TCGArg a2)
 {
-    tcg_gen_op2(&tcg_ctx, opc, a1, a2);
+    tcg_gen_op2(opc, a1, a2);
 }
 
 static inline void tcg_gen_op3_i32(TCGOpcode opc, TCGv_i32 a1,
                                    TCGv_i32 a2, TCGv_i32 a3)
 {
-    tcg_gen_op3(&tcg_ctx, opc, GET_TCGV_I32(a1),
-                GET_TCGV_I32(a2), GET_TCGV_I32(a3));
+    tcg_gen_op3(opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2), GET_TCGV_I32(a3));
 }
 
 static inline void tcg_gen_op3_i64(TCGOpcode opc, TCGv_i64 a1,
                                    TCGv_i64 a2, TCGv_i64 a3)
 {
-    tcg_gen_op3(&tcg_ctx, opc, GET_TCGV_I64(a1),
-                GET_TCGV_I64(a2), GET_TCGV_I64(a3));
+    tcg_gen_op3(opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2), GET_TCGV_I64(a3));
 }
 
 static inline void tcg_gen_op3i_i32(TCGOpcode opc, TCGv_i32 a1,
                                     TCGv_i32 a2, TCGArg a3)
 {
-    tcg_gen_op3(&tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2), a3);
+    tcg_gen_op3(opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2), a3);
 }
 
 static inline void tcg_gen_op3i_i64(TCGOpcode opc, TCGv_i64 a1,
                                     TCGv_i64 a2, TCGArg a3)
 {
-    tcg_gen_op3(&tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2), a3);
+    tcg_gen_op3(opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2), a3);
 }
 
 static inline void tcg_gen_ldst_op_i32(TCGOpcode opc, TCGv_i32 val,
                                        TCGv_ptr base, TCGArg offset)
 {
-    tcg_gen_op3(&tcg_ctx, opc, GET_TCGV_I32(val), GET_TCGV_PTR(base), offset);
+    tcg_gen_op3(opc, GET_TCGV_I32(val), GET_TCGV_PTR(base), offset);
 }
 
 static inline void tcg_gen_ldst_op_i64(TCGOpcode opc, TCGv_i64 val,
                                        TCGv_ptr base, TCGArg offset)
 {
-    tcg_gen_op3(&tcg_ctx, opc, GET_TCGV_I64(val), GET_TCGV_PTR(base), offset);
+    tcg_gen_op3(opc, GET_TCGV_I64(val), GET_TCGV_PTR(base), offset);
 }
 
 static inline void tcg_gen_op4_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                    TCGv_i32 a3, TCGv_i32 a4)
 {
-    tcg_gen_op4(&tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
+    tcg_gen_op4(opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
                 GET_TCGV_I32(a3), GET_TCGV_I32(a4));
 }
 
 static inline void tcg_gen_op4_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                    TCGv_i64 a3, TCGv_i64 a4)
 {
-    tcg_gen_op4(&tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
+    tcg_gen_op4(opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
                 GET_TCGV_I64(a3), GET_TCGV_I64(a4));
 }
 
 static inline void tcg_gen_op4i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                     TCGv_i32 a3, TCGArg a4)
 {
-    tcg_gen_op4(&tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
-                GET_TCGV_I32(a3), a4);
+    tcg_gen_op4(opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2), GET_TCGV_I32(a3), a4);
 }
 
 static inline void tcg_gen_op4i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                     TCGv_i64 a3, TCGArg a4)
 {
-    tcg_gen_op4(&tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
-                GET_TCGV_I64(a3), a4);
+    tcg_gen_op4(opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2), GET_TCGV_I64(a3), a4);
 }
 
 static inline void tcg_gen_op4ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                      TCGArg a3, TCGArg a4)
 {
-    tcg_gen_op4(&tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2), a3, a4);
+    tcg_gen_op4(opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2), a3, a4);
 }
 
 static inline void tcg_gen_op4ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                      TCGArg a3, TCGArg a4)
 {
-    tcg_gen_op4(&tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2), a3, a4);
+    tcg_gen_op4(opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2), a3, a4);
 }
 
 static inline void tcg_gen_op5_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                    TCGv_i32 a3, TCGv_i32 a4, TCGv_i32 a5)
 {
-    tcg_gen_op5(&tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
+    tcg_gen_op5(opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
                 GET_TCGV_I32(a3), GET_TCGV_I32(a4), GET_TCGV_I32(a5));
 }
 
 static inline void tcg_gen_op5_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                    TCGv_i64 a3, TCGv_i64 a4, TCGv_i64 a5)
 {
-    tcg_gen_op5(&tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
+    tcg_gen_op5(opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
                 GET_TCGV_I64(a3), GET_TCGV_I64(a4), GET_TCGV_I64(a5));
 }
 
 static inline void tcg_gen_op5i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                     TCGv_i32 a3, TCGv_i32 a4, TCGArg a5)
 {
-    tcg_gen_op5(&tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
+    tcg_gen_op5(opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
                 GET_TCGV_I32(a3), GET_TCGV_I32(a4), a5);
 }
 
 static inline void tcg_gen_op5i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                     TCGv_i64 a3, TCGv_i64 a4, TCGArg a5)
 {
-    tcg_gen_op5(&tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
+    tcg_gen_op5(opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
                 GET_TCGV_I64(a3), GET_TCGV_I64(a4), a5);
 }
 
 static inline void tcg_gen_op5ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                      TCGv_i32 a3, TCGArg a4, TCGArg a5)
 {
-    tcg_gen_op5(&tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
+    tcg_gen_op5(opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
                 GET_TCGV_I32(a3), a4, a5);
 }
 
 static inline void tcg_gen_op5ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                      TCGv_i64 a3, TCGArg a4, TCGArg a5)
 {
-    tcg_gen_op5(&tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
+    tcg_gen_op5(opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
                 GET_TCGV_I64(a3), a4, a5);
 }
 
@@ -202,7 +195,7 @@ static inline void tcg_gen_op6_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                    TCGv_i32 a3, TCGv_i32 a4,
                                    TCGv_i32 a5, TCGv_i32 a6)
 {
-    tcg_gen_op6(&tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
+    tcg_gen_op6(opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
                 GET_TCGV_I32(a3), GET_TCGV_I32(a4), GET_TCGV_I32(a5),
                 GET_TCGV_I32(a6));
 }
@@ -211,7 +204,7 @@ static inline void tcg_gen_op6_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                    TCGv_i64 a3, TCGv_i64 a4,
                                    TCGv_i64 a5, TCGv_i64 a6)
 {
-    tcg_gen_op6(&tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
+    tcg_gen_op6(opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
                 GET_TCGV_I64(a3), GET_TCGV_I64(a4), GET_TCGV_I64(a5),
                 GET_TCGV_I64(a6));
 }
@@ -220,7 +213,7 @@ static inline void tcg_gen_op6i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                     TCGv_i32 a3, TCGv_i32 a4,
                                     TCGv_i32 a5, TCGArg a6)
 {
-    tcg_gen_op6(&tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
+    tcg_gen_op6(opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
                 GET_TCGV_I32(a3), GET_TCGV_I32(a4), GET_TCGV_I32(a5), a6);
 }
 
@@ -228,7 +221,7 @@ static inline void tcg_gen_op6i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                     TCGv_i64 a3, TCGv_i64 a4,
                                     TCGv_i64 a5, TCGArg a6)
 {
-    tcg_gen_op6(&tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
+    tcg_gen_op6(opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
                 GET_TCGV_I64(a3), GET_TCGV_I64(a4), GET_TCGV_I64(a5), a6);
 }
 
@@ -236,7 +229,7 @@ static inline void tcg_gen_op6ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                      TCGv_i32 a3, TCGv_i32 a4,
                                      TCGArg a5, TCGArg a6)
 {
-    tcg_gen_op6(&tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
+    tcg_gen_op6(opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
                 GET_TCGV_I32(a3), GET_TCGV_I32(a4), a5, a6);
 }
 
@@ -244,7 +237,7 @@ static inline void tcg_gen_op6ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                      TCGv_i64 a3, TCGv_i64 a4,
                                      TCGArg a5, TCGArg a6)
 {
-    tcg_gen_op6(&tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
+    tcg_gen_op6(opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
                 GET_TCGV_I64(a3), GET_TCGV_I64(a4), a5, a6);
 }
 
@@ -253,12 +246,12 @@ static inline void tcg_gen_op6ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
 
 static inline void gen_set_label(TCGLabel *l)
 {
-    tcg_gen_op1(&tcg_ctx, INDEX_op_set_label, label_arg(l));
+    tcg_gen_op1(INDEX_op_set_label, label_arg(l));
 }
 
 static inline void tcg_gen_br(TCGLabel *l)
 {
-    tcg_gen_op1(&tcg_ctx, INDEX_op_br, label_arg(l));
+    tcg_gen_op1(INDEX_op_br, label_arg(l));
 }
 
 void tcg_gen_mb(TCGBar);
@@ -732,25 +725,24 @@ static inline void tcg_gen_concat32_i64(TCGv_i64 ret, TCGv_i64 lo, TCGv_i64 hi)
 # if TARGET_LONG_BITS <= TCG_TARGET_REG_BITS
 static inline void tcg_gen_insn_start(target_ulong pc)
 {
-    tcg_gen_op1(&tcg_ctx, INDEX_op_insn_start, pc);
+    tcg_gen_op1(INDEX_op_insn_start, pc);
 }
 # else
 static inline void tcg_gen_insn_start(target_ulong pc)
 {
-    tcg_gen_op2(&tcg_ctx, INDEX_op_insn_start,
-                (uint32_t)pc, (uint32_t)(pc >> 32));
+    tcg_gen_op2(INDEX_op_insn_start, (uint32_t)pc, (uint32_t)(pc >> 32));
 }
 # endif
 #elif TARGET_INSN_START_WORDS == 2
 # if TARGET_LONG_BITS <= TCG_TARGET_REG_BITS
 static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1)
 {
-    tcg_gen_op2(&tcg_ctx, INDEX_op_insn_start, pc, a1);
+    tcg_gen_op2(INDEX_op_insn_start, pc, a1);
 }
 # else
 static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1)
 {
-    tcg_gen_op4(&tcg_ctx, INDEX_op_insn_start,
+    tcg_gen_op4(INDEX_op_insn_start,
                 (uint32_t)pc, (uint32_t)(pc >> 32),
                 (uint32_t)a1, (uint32_t)(a1 >> 32));
 }
@@ -760,13 +752,13 @@ static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1)
 static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1,
                                       target_ulong a2)
 {
-    tcg_gen_op3(&tcg_ctx, INDEX_op_insn_start, pc, a1, a2);
+    tcg_gen_op3(INDEX_op_insn_start, pc, a1, a2);
 }
 # else
 static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1,
                                       target_ulong a2)
 {
-    tcg_gen_op6(&tcg_ctx, INDEX_op_insn_start,
+    tcg_gen_op6(INDEX_op_insn_start,
                 (uint32_t)pc, (uint32_t)(pc >> 32),
                 (uint32_t)a1, (uint32_t)(a1 >> 32),
                 (uint32_t)a2, (uint32_t)(a2 >> 32));
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index bd84a782e3..bff4b95097 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -46,8 +46,9 @@ extern TCGv_i32 TCGV_HIGH_link_error(TCGv_i64);
    Up to and including filling in the forward link immediately.  We'll do
    proper termination of the end of the list after we finish translation.  */
 
-static inline TCGOp *tcg_emit_op(TCGContext *ctx, TCGOpcode opc)
+static inline TCGOp *tcg_emit_op(TCGOpcode opc)
 {
+    TCGContext *ctx = &tcg_ctx;
     int oi = ctx->gen_next_op_idx;
     int ni = oi + 1;
     int pi = oi - 1;
@@ -65,42 +66,40 @@ static inline TCGOp *tcg_emit_op(TCGContext *ctx, TCGOpcode opc)
     return op;
 }
 
-void tcg_gen_op1(TCGContext *ctx, TCGOpcode opc, TCGArg a1)
+void tcg_gen_op1(TCGOpcode opc, TCGArg a1)
 {
-    TCGOp *op = tcg_emit_op(ctx, opc);
+    TCGOp *op = tcg_emit_op(opc);
     op->args[0] = a1;
 }
 
-void tcg_gen_op2(TCGContext *ctx, TCGOpcode opc, TCGArg a1, TCGArg a2)
+void tcg_gen_op2(TCGOpcode opc, TCGArg a1, TCGArg a2)
 {
-    TCGOp *op = tcg_emit_op(ctx, opc);
+    TCGOp *op = tcg_emit_op(opc);
     op->args[0] = a1;
     op->args[1] = a2;
 }
 
-void tcg_gen_op3(TCGContext *ctx, TCGOpcode opc, TCGArg a1,
-                 TCGArg a2, TCGArg a3)
+void tcg_gen_op3(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3)
 {
-    TCGOp *op = tcg_emit_op(ctx, opc);
+    TCGOp *op = tcg_emit_op(opc);
     op->args[0] = a1;
     op->args[1] = a2;
     op->args[2] = a3;
 }
 
-void tcg_gen_op4(TCGContext *ctx, TCGOpcode opc, TCGArg a1,
-                 TCGArg a2, TCGArg a3, TCGArg a4)
+void tcg_gen_op4(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3, TCGArg a4)
 {
-    TCGOp *op = tcg_emit_op(ctx, opc);
+    TCGOp *op = tcg_emit_op(opc);
     op->args[0] = a1;
     op->args[1] = a2;
     op->args[2] = a3;
     op->args[3] = a4;
 }
 
-void tcg_gen_op5(TCGContext *ctx, TCGOpcode opc, TCGArg a1,
-                 TCGArg a2, TCGArg a3, TCGArg a4, TCGArg a5)
+void tcg_gen_op5(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
+                 TCGArg a4, TCGArg a5)
 {
-    TCGOp *op = tcg_emit_op(ctx, opc);
+    TCGOp *op = tcg_emit_op(opc);
     op->args[0] = a1;
     op->args[1] = a2;
     op->args[2] = a3;
@@ -108,10 +107,10 @@ void tcg_gen_op5(TCGContext *ctx, TCGOpcode opc, TCGArg a1,
     op->args[4] = a5;
 }
 
-void tcg_gen_op6(TCGContext *ctx, TCGOpcode opc, TCGArg a1, TCGArg a2,
-                 TCGArg a3, TCGArg a4, TCGArg a5, TCGArg a6)
+void tcg_gen_op6(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
+                 TCGArg a4, TCGArg a5, TCGArg a6)
 {
-    TCGOp *op = tcg_emit_op(ctx, opc);
+    TCGOp *op = tcg_emit_op(opc);
     op->args[0] = a1;
     op->args[1] = a2;
     op->args[2] = a3;
@@ -123,7 +122,7 @@ void tcg_gen_op6(TCGContext *ctx, TCGOpcode opc, TCGArg a1, TCGArg a2,
 void tcg_gen_mb(TCGBar mb_type)
 {
     if (parallel_cpus) {
-        tcg_gen_op1(&tcg_ctx, INDEX_op_mb, mb_type);
+        tcg_gen_op1(INDEX_op_mb, mb_type);
     }
 }
 
@@ -2458,7 +2457,7 @@ void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_mov_i32(ret, TCGV_LOW(arg));
     } else if (TCG_TARGET_HAS_extrl_i64_i32) {
-        tcg_gen_op2(&tcg_ctx, INDEX_op_extrl_i64_i32,
+        tcg_gen_op2(INDEX_op_extrl_i64_i32,
                     GET_TCGV_I32(ret), GET_TCGV_I64(arg));
     } else {
         tcg_gen_mov_i32(ret, MAKE_TCGV_I32(GET_TCGV_I64(arg)));
@@ -2470,7 +2469,7 @@ void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_mov_i32(ret, TCGV_HIGH(arg));
     } else if (TCG_TARGET_HAS_extrh_i64_i32) {
-        tcg_gen_op2(&tcg_ctx, INDEX_op_extrh_i64_i32,
+        tcg_gen_op2(INDEX_op_extrh_i64_i32,
                     GET_TCGV_I32(ret), GET_TCGV_I64(arg));
     } else {
         TCGv_i64 t = tcg_temp_new_i64();
@@ -2486,7 +2485,7 @@ void tcg_gen_extu_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
         tcg_gen_mov_i32(TCGV_LOW(ret), arg);
         tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
     } else {
-        tcg_gen_op2(&tcg_ctx, INDEX_op_extu_i32_i64,
+        tcg_gen_op2(INDEX_op_extu_i32_i64,
                     GET_TCGV_I64(ret), GET_TCGV_I32(arg));
     }
 }
@@ -2497,7 +2496,7 @@ void tcg_gen_ext_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
         tcg_gen_mov_i32(TCGV_LOW(ret), arg);
         tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
     } else {
-        tcg_gen_op2(&tcg_ctx, INDEX_op_ext_i32_i64,
+        tcg_gen_op2(INDEX_op_ext_i32_i64,
                     GET_TCGV_I64(ret), GET_TCGV_I32(arg));
     }
 }
@@ -2609,7 +2608,7 @@ static void gen_ldst_i32(TCGOpcode opc, TCGv_i32 val, TCGv addr,
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_op4i_i32(opc, val, TCGV_LOW(addr), TCGV_HIGH(addr), oi);
     } else {
-        tcg_gen_op3(&tcg_ctx, opc, GET_TCGV_I32(val), GET_TCGV_I64(addr), oi);
+        tcg_gen_op3(opc, GET_TCGV_I32(val), GET_TCGV_I64(addr), oi);
     }
 #endif
 }
@@ -2622,7 +2621,7 @@ static void gen_ldst_i64(TCGOpcode opc, TCGv_i64 val, TCGv addr,
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_op4i_i32(opc, TCGV_LOW(val), TCGV_HIGH(val), addr, oi);
     } else {
-        tcg_gen_op3(&tcg_ctx, opc, GET_TCGV_I64(val), GET_TCGV_I32(addr), oi);
+        tcg_gen_op3(opc, GET_TCGV_I64(val), GET_TCGV_I32(addr), oi);
     }
 #else
     if (TCG_TARGET_REG_BITS == 32) {
-- 
2.13.6
