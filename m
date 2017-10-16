Received: from eggs.gnu.org ([2001:4830:134:3::10]:52353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e499y-0002BT-UI
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e499x-0003Vb-On
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:38 -0400
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b]:55271)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e499x-0003Ux-HF
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:37 -0400
Received: by mail-pg0-x22b.google.com with SMTP id l24so7293177pgu.11
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 10:26:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 16 Oct 2017 10:25:35 -0700
Message-Id: <20171016172609.23422-17-richard.henderson@linaro.org>
In-Reply-To: <20171016172609.23422-1-richard.henderson@linaro.org>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 16/50] tcg: Push tcg_ctx into tcg_gen_callN
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/helper-gen.h | 12 ++++++------
 tcg/tcg.h                 |  3 +--
 tcg/tcg.c                 |  4 ++--
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/include/exec/helper-gen.h b/include/exec/helper-gen.h
index 8239ffc77c..476acd9220 100644
--- a/include/exec/helper-gen.h
+++ b/include/exec/helper-gen.h
@@ -9,7 +9,7 @@
 #define DEF_HELPER_FLAGS_0(name, flags, ret)                            \
 static inline void glue(gen_helper_, name)(dh_retvar_decl0(ret))        \
 {                                                                       \
-  tcg_gen_callN(&tcg_ctx, HELPER(name), dh_retvar(ret), 0, NULL);       \
+  tcg_gen_callN(HELPER(name), dh_retvar(ret), 0, NULL);                 \
 }
 
 #define DEF_HELPER_FLAGS_1(name, flags, ret, t1)                        \
@@ -17,7 +17,7 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1))                                                 \
 {                                                                       \
   TCGArg args[1] = { dh_arg(t1, 1) };                                   \
-  tcg_gen_callN(&tcg_ctx, HELPER(name), dh_retvar(ret), 1, args);       \
+  tcg_gen_callN(HELPER(name), dh_retvar(ret), 1, args);                 \
 }
 
 #define DEF_HELPER_FLAGS_2(name, flags, ret, t1, t2)                    \
@@ -25,7 +25,7 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2))                             \
 {                                                                       \
   TCGArg args[2] = { dh_arg(t1, 1), dh_arg(t2, 2) };                    \
-  tcg_gen_callN(&tcg_ctx, HELPER(name), dh_retvar(ret), 2, args);       \
+  tcg_gen_callN(HELPER(name), dh_retvar(ret), 2, args);                 \
 }
 
 #define DEF_HELPER_FLAGS_3(name, flags, ret, t1, t2, t3)                \
@@ -33,7 +33,7 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3))         \
 {                                                                       \
   TCGArg args[3] = { dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3) };     \
-  tcg_gen_callN(&tcg_ctx, HELPER(name), dh_retvar(ret), 3, args);       \
+  tcg_gen_callN(HELPER(name), dh_retvar(ret), 3, args);                 \
 }
 
 #define DEF_HELPER_FLAGS_4(name, flags, ret, t1, t2, t3, t4)            \
@@ -43,7 +43,7 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
 {                                                                       \
   TCGArg args[4] = { dh_arg(t1, 1), dh_arg(t2, 2),                      \
                      dh_arg(t3, 3), dh_arg(t4, 4) };                    \
-  tcg_gen_callN(&tcg_ctx, HELPER(name), dh_retvar(ret), 4, args);       \
+  tcg_gen_callN(HELPER(name), dh_retvar(ret), 4, args);                 \
 }
 
 #define DEF_HELPER_FLAGS_5(name, flags, ret, t1, t2, t3, t4, t5)        \
@@ -53,7 +53,7 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
 {                                                                       \
   TCGArg args[5] = { dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),       \
                      dh_arg(t4, 4), dh_arg(t5, 5) };                    \
-  tcg_gen_callN(&tcg_ctx, HELPER(name), dh_retvar(ret), 5, args);       \
+  tcg_gen_callN(HELPER(name), dh_retvar(ret), 5, args);                 \
 }
 
 #include "helper.h"
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 563e7d36aa..0d61932301 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -951,8 +951,7 @@ do {\
 
 bool tcg_op_supported(TCGOpcode op);
 
-void tcg_gen_callN(TCGContext *s, void *func,
-                   TCGArg ret, int nargs, TCGArg *args);
+void tcg_gen_callN(void *func, TCGArg ret, int nargs, TCGArg *args);
 
 void tcg_op_remove(TCGContext *s, TCGOp *op);
 TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op, TCGOpcode opc, int narg);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index b39944d42a..113700ccc1 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -974,9 +974,9 @@ bool tcg_op_supported(TCGOpcode op)
 /* Note: we convert the 64 bit args to 32 bit and do some alignment
    and endian swap. Maybe it would be better to do the alignment
    and endian swap in tcg_reg_alloc_call(). */
-void tcg_gen_callN(TCGContext *s, void *func, TCGArg ret,
-                   int nargs, TCGArg *args)
+void tcg_gen_callN(void *func, TCGArg ret, int nargs, TCGArg *args)
 {
+    TCGContext *s = &tcg_ctx;
     int i, real_args, nb_rets, pi;
     unsigned sizemask, flags;
     TCGHelperInfo *info;
-- 
2.13.6
