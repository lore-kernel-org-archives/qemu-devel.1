Received: from eggs.gnu.org ([2001:4830:134:3::10]:45608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6Y-0008JZ-M5
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6S-00087Y-Ue
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:06 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:50350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7I6S-00086s-KC
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:00 -0400
Received: by mail-wm0-x242.google.com with SMTP id u138so595056wmu.5
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 02:36:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 11:35:00 +0200
Message-Id: <20171025093535.10175-17-richard.henderson@linaro.org>
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/51] tcg: Introduce tcgv_{i32, i64, ptr}_{arg,
 temp}
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

Transform TCGv_* to an "argument" or a temporary.
For now, an argument is simply the temporary index.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/helper-gen.h  | 10 ++---
 include/exec/helper-head.h | 12 +++---
 tcg/tcg-op.h               | 94 +++++++++++++++++++++++-----------------------
 tcg/tcg.h                  | 32 +++++++++++++++-
 tcg/tcg-op.c               | 14 +++----
 tcg/tcg.c                  | 50 ++++++++++++------------
 6 files changed, 122 insertions(+), 90 deletions(-)

diff --git a/include/exec/helper-gen.h b/include/exec/helper-gen.h
index 476acd9220..15204ab961 100644
--- a/include/exec/helper-gen.h
+++ b/include/exec/helper-gen.h
@@ -16,7 +16,7 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl0(ret))        \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1))                                                 \
 {                                                                       \
-  TCGArg args[1] = { dh_arg(t1, 1) };                                   \
+  TCGTemp *args[1] = { dh_arg(t1, 1) };                                 \
   tcg_gen_callN(HELPER(name), dh_retvar(ret), 1, args);                 \
 }
 
@@ -24,7 +24,7 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2))                             \
 {                                                                       \
-  TCGArg args[2] = { dh_arg(t1, 1), dh_arg(t2, 2) };                    \
+  TCGTemp *args[2] = { dh_arg(t1, 1), dh_arg(t2, 2) };                  \
   tcg_gen_callN(HELPER(name), dh_retvar(ret), 2, args);                 \
 }
 
@@ -32,7 +32,7 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3))         \
 {                                                                       \
-  TCGArg args[3] = { dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3) };     \
+  TCGTemp *args[3] = { dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3) };   \
   tcg_gen_callN(HELPER(name), dh_retvar(ret), 3, args);                 \
 }
 
@@ -41,7 +41,7 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2),                             \
     dh_arg_decl(t3, 3), dh_arg_decl(t4, 4))                             \
 {                                                                       \
-  TCGArg args[4] = { dh_arg(t1, 1), dh_arg(t2, 2),                      \
+  TCGTemp *args[4] = { dh_arg(t1, 1), dh_arg(t2, 2),                    \
                      dh_arg(t3, 3), dh_arg(t4, 4) };                    \
   tcg_gen_callN(HELPER(name), dh_retvar(ret), 4, args);                 \
 }
@@ -51,7 +51,7 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1),  dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),        \
     dh_arg_decl(t4, 4), dh_arg_decl(t5, 5))                             \
 {                                                                       \
-  TCGArg args[5] = { dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),       \
+  TCGTemp *args[5] = { dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),     \
                      dh_arg(t4, 4), dh_arg(t5, 5) };                    \
   tcg_gen_callN(HELPER(name), dh_retvar(ret), 5, args);                 \
 }
diff --git a/include/exec/helper-head.h b/include/exec/helper-head.h
index 1cfc43b9ff..13286018fd 100644
--- a/include/exec/helper-head.h
+++ b/include/exec/helper-head.h
@@ -78,11 +78,11 @@
 #define dh_retvar_decl_ptr TCGv_ptr retval,
 #define dh_retvar_decl(t) glue(dh_retvar_decl_, dh_alias(t))
 
-#define dh_retvar_void TCG_CALL_DUMMY_ARG
-#define dh_retvar_noreturn TCG_CALL_DUMMY_ARG
-#define dh_retvar_i32 GET_TCGV_i32(retval)
-#define dh_retvar_i64 GET_TCGV_i64(retval)
-#define dh_retvar_ptr GET_TCGV_ptr(retval)
+#define dh_retvar_void NULL
+#define dh_retvar_noreturn NULL
+#define dh_retvar_i32 tcgv_i32_temp(retval)
+#define dh_retvar_i64 tcgv_i64_temp(retval)
+#define dh_retvar_ptr tcgv_ptr_temp(retval)
 #define dh_retvar(t) glue(dh_retvar_, dh_alias(t))
 
 #define dh_is_64bit_void 0
@@ -113,7 +113,7 @@
   ((dh_is_64bit(t) << (n*2)) | (dh_is_signed(t) << (n*2+1)))
 
 #define dh_arg(t, n) \
-  glue(GET_TCGV_, dh_alias(t))(glue(arg, n))
+  glue(glue(tcgv_, dh_alias(t)), _temp)(glue(arg, n))
 
 #define dh_arg_decl(t, n) glue(TCGv_, dh_alias(t)) glue(arg, n)
 
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index de9a61206a..ab2f3c6cee 100644
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
@@ -78,167 +78,169 @@ static inline void tcg_gen_op2ii(TCGOpcode opc, TCGArg a1, TCGArg a2)
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
+    tcg_gen_op4(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+                tcgv_i32_arg(a3), a4);
 }
 
 static inline void tcg_gen_op4i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                     TCGv_i64 a3, TCGArg a4)
 {
-    tcg_gen_op4(opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2), GET_TCGV_I64(a3), a4);
+    tcg_gen_op4(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
+                tcgv_i64_arg(a3), a4);
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
index 0d61932301..fb8ce01664 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -756,6 +756,36 @@ static inline size_t arg_index(TCGArg a)
     return a;
 }
 
+static inline TCGArg tcgv_i32_arg(TCGv_i32 t)
+{
+    return (intptr_t)t;
+}
+
+static inline TCGArg tcgv_i64_arg(TCGv_i64 t)
+{
+    return (intptr_t)t;
+}
+
+static inline TCGArg tcgv_ptr_arg(TCGv_ptr t)
+{
+    return (intptr_t)t;
+}
+
+static inline TCGTemp *tcgv_i32_temp(TCGv_i32 t)
+{
+    return arg_temp(tcgv_i32_arg(t));
+}
+
+static inline TCGTemp *tcgv_i64_temp(TCGv_i64 t)
+{
+    return arg_temp(tcgv_i64_arg(t));
+}
+
+static inline TCGTemp *tcgv_ptr_temp(TCGv_ptr t)
+{
+    return arg_temp(tcgv_ptr_arg(t));
+}
+
 static inline void tcg_set_insn_param(int op_idx, int arg, TCGArg v)
 {
     tcg_ctx.gen_op_buf[op_idx].args[arg] = v;
@@ -951,7 +981,7 @@ do {\
 
 bool tcg_op_supported(TCGOpcode op);
 
-void tcg_gen_callN(void *func, TCGArg ret, int nargs, TCGArg *args);
+void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args);
 
 void tcg_op_remove(TCGContext *s, TCGOp *op);
 TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op, TCGOpcode opc, int narg);
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
index dac3e06a5b..cb985aabdc 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -974,7 +974,7 @@ bool tcg_op_supported(TCGOpcode op)
 /* Note: we convert the 64 bit args to 32 bit and do some alignment
    and endian swap. Maybe it would be better to do the alignment
    and endian swap in tcg_reg_alloc_call(). */
-void tcg_gen_callN(void *func, TCGArg ret, int nargs, TCGArg *args)
+void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args)
 {
     TCGContext *s = &tcg_ctx;
     int i, real_args, nb_rets, pi;
@@ -993,7 +993,7 @@ void tcg_gen_callN(void *func, TCGArg ret, int nargs, TCGArg *args)
     int orig_sizemask = sizemask;
     int orig_nargs = nargs;
     TCGv_i64 retl, reth;
-    TCGArg split_args[MAX_OPC_PARAM];
+    TCGTemp *split_args[MAX_OPC_PARAM];
 
     TCGV_UNUSED_I64(retl);
     TCGV_UNUSED_I64(reth);
@@ -1001,12 +1001,12 @@ void tcg_gen_callN(void *func, TCGArg ret, int nargs, TCGArg *args)
         for (i = real_args = 0; i < nargs; ++i) {
             int is_64bit = sizemask & (1 << (i+1)*2);
             if (is_64bit) {
-                TCGv_i64 orig = MAKE_TCGV_I64(args[i]);
+                TCGv_i64 orig = MAKE_TCGV_I64(temp_idx(args[i]));
                 TCGv_i32 h = tcg_temp_new_i32();
                 TCGv_i32 l = tcg_temp_new_i32();
                 tcg_gen_extr_i64_i32(l, h, orig);
-                split_args[real_args++] = GET_TCGV_I32(h);
-                split_args[real_args++] = GET_TCGV_I32(l);
+                split_args[real_args++] = tcgv_i32_temp(h);
+                split_args[real_args++] = tcgv_i32_temp(l);
             } else {
                 split_args[real_args++] = args[i];
             }
@@ -1021,13 +1021,13 @@ void tcg_gen_callN(void *func, TCGArg ret, int nargs, TCGArg *args)
         int is_signed = sizemask & (2 << (i+1)*2);
         if (!is_64bit) {
             TCGv_i64 temp = tcg_temp_new_i64();
-            TCGv_i64 orig = MAKE_TCGV_I64(args[i]);
+            TCGv_i64 orig = MAKE_TCGV_I64(temp_idx(args[i]));
             if (is_signed) {
                 tcg_gen_ext32s_i64(temp, orig);
             } else {
                 tcg_gen_ext32u_i64(temp, orig);
             }
-            args[i] = GET_TCGV_I64(temp);
+            args[i] = tcgv_i64_temp(temp);
         }
     }
 #endif /* TCG_TARGET_EXTEND_ARGS */
@@ -1045,7 +1045,7 @@ void tcg_gen_callN(void *func, TCGArg ret, int nargs, TCGArg *args)
     op->next = i + 1;
 
     pi = 0;
-    if (ret != TCG_CALL_DUMMY_ARG) {
+    if (ret != NULL) {
 #if defined(__sparc__) && !defined(__arch64__) \
     && !defined(CONFIG_TCG_INTERPRETER)
         if (orig_sizemask & 1) {
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
+            op->args[pi++] = temp_arg(ret);
             nb_rets = 1;
         }
 #else
         if (TCG_TARGET_REG_BITS < 64 && (sizemask & 1)) {
 #ifdef HOST_WORDS_BIGENDIAN
-            op->args[pi++] = ret + 1;
-            op->args[pi++] = ret;
+            op->args[pi++] = temp_arg(ret + 1);
+            op->args[pi++] = temp_arg(ret);
 #else
-            op->args[pi++] = ret;
-            op->args[pi++] = ret + 1;
+            op->args[pi++] = temp_arg(ret);
+            op->args[pi++] = temp_arg(ret + 1);
 #endif
             nb_rets = 2;
         } else {
-            op->args[pi++] = ret;
+            op->args[pi++] = temp_arg(ret);
             nb_rets = 1;
         }
 #endif
@@ -1103,17 +1103,17 @@ void tcg_gen_callN(void *func, TCGArg ret, int nargs, TCGArg *args)
               have to get more complicated to differentiate between
               stack arguments and register arguments.  */
 #if defined(HOST_WORDS_BIGENDIAN) != defined(TCG_TARGET_STACK_GROWSUP)
-            op->args[pi++] = args[i] + 1;
-            op->args[pi++] = args[i];
+            op->args[pi++] = temp_arg(args[i] + 1);
+            op->args[pi++] = temp_arg(args[i]);
 #else
-            op->args[pi++] = args[i];
-            op->args[pi++] = args[i] + 1;
+            op->args[pi++] = temp_arg(args[i]);
+            op->args[pi++] = temp_arg(args[i] + 1);
 #endif
             real_args += 2;
             continue;
         }
 
-        op->args[pi++] = args[i];
+        op->args[pi++] = temp_arg(args[i]);
         real_args++;
     }
     op->args[pi++] = (uintptr_t)func;
@@ -1130,8 +1130,8 @@ void tcg_gen_callN(void *func, TCGArg ret, int nargs, TCGArg *args)
     for (i = real_args = 0; i < orig_nargs; ++i) {
         int is_64bit = orig_sizemask & (1 << (i+1)*2);
         if (is_64bit) {
-            TCGv_i32 h = MAKE_TCGV_I32(args[real_args++]);
-            TCGv_i32 l = MAKE_TCGV_I32(args[real_args++]);
+            TCGv_i32 h = MAKE_TCGV_I32(temp_idx(args[real_args++]));
+            TCGv_i32 l = MAKE_TCGV_I32(temp_idx(args[real_args++]));
             tcg_temp_free_i32(h);
             tcg_temp_free_i32(l);
         } else {
@@ -1142,7 +1142,7 @@ void tcg_gen_callN(void *func, TCGArg ret, int nargs, TCGArg *args)
         /* The 32-bit ABI returned two 32-bit pieces.  Re-assemble them.
            Note that describing these as TCGv_i64 eliminates an unnecessary
            zero-extension that tcg_gen_concat_i32_i64 would create.  */
-        tcg_gen_concat32_i64(MAKE_TCGV_I64(ret), retl, reth);
+        tcg_gen_concat32_i64(MAKE_TCGV_I64(temp_idx(ret)), retl, reth);
         tcg_temp_free_i64(retl);
         tcg_temp_free_i64(reth);
     }
@@ -1150,7 +1150,7 @@ void tcg_gen_callN(void *func, TCGArg ret, int nargs, TCGArg *args)
     for (i = 0; i < nargs; ++i) {
         int is_64bit = sizemask & (1 << (i+1)*2);
         if (!is_64bit) {
-            TCGv_i64 temp = MAKE_TCGV_I64(args[i]);
+            TCGv_i64 temp = MAKE_TCGV_I64(temp_idx(args[i]));
             tcg_temp_free_i64(temp);
         }
     }
-- 
2.13.6
