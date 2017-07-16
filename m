Received: from eggs.gnu.org ([2001:4830:134:3::10]:46499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmk-0001Hw-5i
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:05:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmY-0008PR-TD
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:58 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48345)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dWpmY-0008Ov-NP
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:46 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 16 Jul 2017 16:04:17 -0400
Message-Id: <1500235468-15341-35-git-send-email-cota@braap.org>
In-Reply-To: <1500235468-15341-1-git-send-email-cota@braap.org>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 34/45] tcg: define tcg_init_ctx and make
 tcg_ctx a pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

Groundwork for supporting multiple TCG contexts.

The core of this patch is this change to tcg/tcg.h:

> -extern TCGContext tcg_ctx;
> +extern TCGContext tcg_init_ctx;
> +extern TCGContext *tcg_ctx;

Note that for now we set *tcg_ctx to whatever TCGContext is passed
to tcg_context_init -- in this case &tcg_init_ctx.

To avoid diff churn we could do something like
> TCGContext *tcg_ctx_ptr;
> #define tcg_ctx (*tcg_ctx_ptr)
as Richard suggested during review, but sooner or later
we'd end up doing the conversion anyway, so do it now.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/gen-icount.h     | 10 ++---
 include/exec/helper-gen.h     | 12 +++---
 tcg/tcg-op.h                  | 80 +++++++++++++++++------------------
 tcg/tcg.h                     | 15 +++----
 accel/tcg/translate-all.c     | 97 ++++++++++++++++++++++---------------------
 bsd-user/main.c               |  2 +-
 linux-user/main.c             |  2 +-
 target/alpha/translate.c      |  2 +-
 target/arm/translate.c        |  2 +-
 target/cris/translate.c       |  2 +-
 target/cris/translate_v10.c   |  2 +-
 target/hppa/translate.c       |  2 +-
 target/i386/translate.c       |  2 +-
 target/lm32/translate.c       |  2 +-
 target/m68k/translate.c       |  2 +-
 target/microblaze/translate.c |  2 +-
 target/mips/translate.c       |  2 +-
 target/moxie/translate.c      |  2 +-
 target/openrisc/translate.c   |  2 +-
 target/ppc/translate.c        |  2 +-
 target/s390x/translate.c      |  2 +-
 target/sh4/translate.c        |  2 +-
 target/sparc/translate.c      |  2 +-
 target/tilegx/translate.c     |  2 +-
 target/tricore/translate.c    |  2 +-
 target/unicore32/translate.c  |  2 +-
 target/xtensa/translate.c     |  2 +-
 tcg/tcg-op.c                  | 58 +++++++++++++-------------
 tcg/tcg-runtime.c             |  2 +-
 tcg/tcg.c                     | 21 +++++-----
 30 files changed, 171 insertions(+), 168 deletions(-)

diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index 9b3cb14..4a55da8 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -19,7 +19,7 @@ static inline void gen_tb_start(TranslationBlock *tb)
         count = tcg_temp_new_i32();
     }
 
-    tcg_gen_ld_i32(count, tcg_ctx.tcg_env,
+    tcg_gen_ld_i32(count, tcg_ctx->tcg_env,
                    -ENV_OFFSET + offsetof(CPUState, icount_decr.u32));
 
     if (tb->cflags & CF_USE_ICOUNT) {
@@ -37,7 +37,7 @@ static inline void gen_tb_start(TranslationBlock *tb)
     tcg_gen_brcondi_i32(TCG_COND_LT, count, 0, exitreq_label);
 
     if (tb->cflags & CF_USE_ICOUNT) {
-        tcg_gen_st16_i32(count, tcg_ctx.tcg_env,
+        tcg_gen_st16_i32(count, tcg_ctx->tcg_env,
                          -ENV_OFFSET + offsetof(CPUState, icount_decr.u16.low));
     }
 
@@ -56,13 +56,13 @@ static inline void gen_tb_end(TranslationBlock *tb, int num_insns)
     tcg_gen_exit_tb((uintptr_t)tb + TB_EXIT_REQUESTED);
 
     /* Terminate the linked list.  */
-    tcg_ctx.gen_op_buf[tcg_ctx.gen_op_buf[0].prev].next = 0;
+    tcg_ctx->gen_op_buf[tcg_ctx->gen_op_buf[0].prev].next = 0;
 }
 
 static inline void gen_io_start(void)
 {
     TCGv_i32 tmp = tcg_const_i32(1);
-    tcg_gen_st_i32(tmp, tcg_ctx.tcg_env,
+    tcg_gen_st_i32(tmp, tcg_ctx->tcg_env,
                    -ENV_OFFSET + offsetof(CPUState, can_do_io));
     tcg_temp_free_i32(tmp);
 }
@@ -70,7 +70,7 @@ static inline void gen_io_start(void)
 static inline void gen_io_end(void)
 {
     TCGv_i32 tmp = tcg_const_i32(0);
-    tcg_gen_st_i32(tmp, tcg_ctx.tcg_env,
+    tcg_gen_st_i32(tmp, tcg_ctx->tcg_env,
                    -ENV_OFFSET + offsetof(CPUState, can_do_io));
     tcg_temp_free_i32(tmp);
 }
diff --git a/include/exec/helper-gen.h b/include/exec/helper-gen.h
index 8239ffc..3bcb901 100644
--- a/include/exec/helper-gen.h
+++ b/include/exec/helper-gen.h
@@ -9,7 +9,7 @@
 #define DEF_HELPER_FLAGS_0(name, flags, ret)                            \
 static inline void glue(gen_helper_, name)(dh_retvar_decl0(ret))        \
 {                                                                       \
-  tcg_gen_callN(&tcg_ctx, HELPER(name), dh_retvar(ret), 0, NULL);       \
+  tcg_gen_callN(tcg_ctx, HELPER(name), dh_retvar(ret), 0, NULL);        \
 }
 
 #define DEF_HELPER_FLAGS_1(name, flags, ret, t1)                        \
@@ -17,7 +17,7 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1))                                                 \
 {                                                                       \
   TCGArg args[1] = { dh_arg(t1, 1) };                                   \
-  tcg_gen_callN(&tcg_ctx, HELPER(name), dh_retvar(ret), 1, args);       \
+  tcg_gen_callN(tcg_ctx, HELPER(name), dh_retvar(ret), 1, args);        \
 }
 
 #define DEF_HELPER_FLAGS_2(name, flags, ret, t1, t2)                    \
@@ -25,7 +25,7 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2))                             \
 {                                                                       \
   TCGArg args[2] = { dh_arg(t1, 1), dh_arg(t2, 2) };                    \
-  tcg_gen_callN(&tcg_ctx, HELPER(name), dh_retvar(ret), 2, args);       \
+  tcg_gen_callN(tcg_ctx, HELPER(name), dh_retvar(ret), 2, args);        \
 }
 
 #define DEF_HELPER_FLAGS_3(name, flags, ret, t1, t2, t3)                \
@@ -33,7 +33,7 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3))         \
 {                                                                       \
   TCGArg args[3] = { dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3) };     \
-  tcg_gen_callN(&tcg_ctx, HELPER(name), dh_retvar(ret), 3, args);       \
+  tcg_gen_callN(tcg_ctx, HELPER(name), dh_retvar(ret), 3, args);        \
 }
 
 #define DEF_HELPER_FLAGS_4(name, flags, ret, t1, t2, t3, t4)            \
@@ -43,7 +43,7 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
 {                                                                       \
   TCGArg args[4] = { dh_arg(t1, 1), dh_arg(t2, 2),                      \
                      dh_arg(t3, 3), dh_arg(t4, 4) };                    \
-  tcg_gen_callN(&tcg_ctx, HELPER(name), dh_retvar(ret), 4, args);       \
+  tcg_gen_callN(tcg_ctx, HELPER(name), dh_retvar(ret), 4, args);        \
 }
 
 #define DEF_HELPER_FLAGS_5(name, flags, ret, t1, t2, t3, t4, t5)        \
@@ -53,7 +53,7 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
 {                                                                       \
   TCGArg args[5] = { dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),       \
                      dh_arg(t4, 4), dh_arg(t5, 5) };                    \
-  tcg_gen_callN(&tcg_ctx, HELPER(name), dh_retvar(ret), 5, args);       \
+  tcg_gen_callN(tcg_ctx, HELPER(name), dh_retvar(ret), 5, args);        \
 }
 
 #include "helper.h"
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 18d01b2..75c15cc 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -40,161 +40,161 @@ void tcg_gen_op6(TCGContext *, TCGOpcode, TCGArg, TCGArg, TCGArg,
 
 static inline void tcg_gen_op1_i32(TCGOpcode opc, TCGv_i32 a1)
 {
-    tcg_gen_op1(&tcg_ctx, opc, GET_TCGV_I32(a1));
+    tcg_gen_op1(tcg_ctx, opc, GET_TCGV_I32(a1));
 }
 
 static inline void tcg_gen_op1_i64(TCGOpcode opc, TCGv_i64 a1)
 {
-    tcg_gen_op1(&tcg_ctx, opc, GET_TCGV_I64(a1));
+    tcg_gen_op1(tcg_ctx, opc, GET_TCGV_I64(a1));
 }
 
 static inline void tcg_gen_op1i(TCGOpcode opc, TCGArg a1)
 {
-    tcg_gen_op1(&tcg_ctx, opc, a1);
+    tcg_gen_op1(tcg_ctx, opc, a1);
 }
 
 static inline void tcg_gen_op2_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2)
 {
-    tcg_gen_op2(&tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2));
+    tcg_gen_op2(tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2));
 }
 
 static inline void tcg_gen_op2_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2)
 {
-    tcg_gen_op2(&tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2));
+    tcg_gen_op2(tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2));
 }
 
 static inline void tcg_gen_op2i_i32(TCGOpcode opc, TCGv_i32 a1, TCGArg a2)
 {
-    tcg_gen_op2(&tcg_ctx, opc, GET_TCGV_I32(a1), a2);
+    tcg_gen_op2(tcg_ctx, opc, GET_TCGV_I32(a1), a2);
 }
 
 static inline void tcg_gen_op2i_i64(TCGOpcode opc, TCGv_i64 a1, TCGArg a2)
 {
-    tcg_gen_op2(&tcg_ctx, opc, GET_TCGV_I64(a1), a2);
+    tcg_gen_op2(tcg_ctx, opc, GET_TCGV_I64(a1), a2);
 }
 
 static inline void tcg_gen_op2ii(TCGOpcode opc, TCGArg a1, TCGArg a2)
 {
-    tcg_gen_op2(&tcg_ctx, opc, a1, a2);
+    tcg_gen_op2(tcg_ctx, opc, a1, a2);
 }
 
 static inline void tcg_gen_op3_i32(TCGOpcode opc, TCGv_i32 a1,
                                    TCGv_i32 a2, TCGv_i32 a3)
 {
-    tcg_gen_op3(&tcg_ctx, opc, GET_TCGV_I32(a1),
+    tcg_gen_op3(tcg_ctx, opc, GET_TCGV_I32(a1),
                 GET_TCGV_I32(a2), GET_TCGV_I32(a3));
 }
 
 static inline void tcg_gen_op3_i64(TCGOpcode opc, TCGv_i64 a1,
                                    TCGv_i64 a2, TCGv_i64 a3)
 {
-    tcg_gen_op3(&tcg_ctx, opc, GET_TCGV_I64(a1),
+    tcg_gen_op3(tcg_ctx, opc, GET_TCGV_I64(a1),
                 GET_TCGV_I64(a2), GET_TCGV_I64(a3));
 }
 
 static inline void tcg_gen_op3i_i32(TCGOpcode opc, TCGv_i32 a1,
                                     TCGv_i32 a2, TCGArg a3)
 {
-    tcg_gen_op3(&tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2), a3);
+    tcg_gen_op3(tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2), a3);
 }
 
 static inline void tcg_gen_op3i_i64(TCGOpcode opc, TCGv_i64 a1,
                                     TCGv_i64 a2, TCGArg a3)
 {
-    tcg_gen_op3(&tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2), a3);
+    tcg_gen_op3(tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2), a3);
 }
 
 static inline void tcg_gen_ldst_op_i32(TCGOpcode opc, TCGv_i32 val,
                                        TCGv_ptr base, TCGArg offset)
 {
-    tcg_gen_op3(&tcg_ctx, opc, GET_TCGV_I32(val), GET_TCGV_PTR(base), offset);
+    tcg_gen_op3(tcg_ctx, opc, GET_TCGV_I32(val), GET_TCGV_PTR(base), offset);
 }
 
 static inline void tcg_gen_ldst_op_i64(TCGOpcode opc, TCGv_i64 val,
                                        TCGv_ptr base, TCGArg offset)
 {
-    tcg_gen_op3(&tcg_ctx, opc, GET_TCGV_I64(val), GET_TCGV_PTR(base), offset);
+    tcg_gen_op3(tcg_ctx, opc, GET_TCGV_I64(val), GET_TCGV_PTR(base), offset);
 }
 
 static inline void tcg_gen_op4_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                    TCGv_i32 a3, TCGv_i32 a4)
 {
-    tcg_gen_op4(&tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
+    tcg_gen_op4(tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
                 GET_TCGV_I32(a3), GET_TCGV_I32(a4));
 }
 
 static inline void tcg_gen_op4_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                    TCGv_i64 a3, TCGv_i64 a4)
 {
-    tcg_gen_op4(&tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
+    tcg_gen_op4(tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
                 GET_TCGV_I64(a3), GET_TCGV_I64(a4));
 }
 
 static inline void tcg_gen_op4i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                     TCGv_i32 a3, TCGArg a4)
 {
-    tcg_gen_op4(&tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
+    tcg_gen_op4(tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
                 GET_TCGV_I32(a3), a4);
 }
 
 static inline void tcg_gen_op4i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                     TCGv_i64 a3, TCGArg a4)
 {
-    tcg_gen_op4(&tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
+    tcg_gen_op4(tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
                 GET_TCGV_I64(a3), a4);
 }
 
 static inline void tcg_gen_op4ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                      TCGArg a3, TCGArg a4)
 {
-    tcg_gen_op4(&tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2), a3, a4);
+    tcg_gen_op4(tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2), a3, a4);
 }
 
 static inline void tcg_gen_op4ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                      TCGArg a3, TCGArg a4)
 {
-    tcg_gen_op4(&tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2), a3, a4);
+    tcg_gen_op4(tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2), a3, a4);
 }
 
 static inline void tcg_gen_op5_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                    TCGv_i32 a3, TCGv_i32 a4, TCGv_i32 a5)
 {
-    tcg_gen_op5(&tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
+    tcg_gen_op5(tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
                 GET_TCGV_I32(a3), GET_TCGV_I32(a4), GET_TCGV_I32(a5));
 }
 
 static inline void tcg_gen_op5_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                    TCGv_i64 a3, TCGv_i64 a4, TCGv_i64 a5)
 {
-    tcg_gen_op5(&tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
+    tcg_gen_op5(tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
                 GET_TCGV_I64(a3), GET_TCGV_I64(a4), GET_TCGV_I64(a5));
 }
 
 static inline void tcg_gen_op5i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                     TCGv_i32 a3, TCGv_i32 a4, TCGArg a5)
 {
-    tcg_gen_op5(&tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
+    tcg_gen_op5(tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
                 GET_TCGV_I32(a3), GET_TCGV_I32(a4), a5);
 }
 
 static inline void tcg_gen_op5i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                     TCGv_i64 a3, TCGv_i64 a4, TCGArg a5)
 {
-    tcg_gen_op5(&tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
+    tcg_gen_op5(tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
                 GET_TCGV_I64(a3), GET_TCGV_I64(a4), a5);
 }
 
 static inline void tcg_gen_op5ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                      TCGv_i32 a3, TCGArg a4, TCGArg a5)
 {
-    tcg_gen_op5(&tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
+    tcg_gen_op5(tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
                 GET_TCGV_I32(a3), a4, a5);
 }
 
 static inline void tcg_gen_op5ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                      TCGv_i64 a3, TCGArg a4, TCGArg a5)
 {
-    tcg_gen_op5(&tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
+    tcg_gen_op5(tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
                 GET_TCGV_I64(a3), a4, a5);
 }
 
@@ -202,7 +202,7 @@ static inline void tcg_gen_op6_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                    TCGv_i32 a3, TCGv_i32 a4,
                                    TCGv_i32 a5, TCGv_i32 a6)
 {
-    tcg_gen_op6(&tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
+    tcg_gen_op6(tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
                 GET_TCGV_I32(a3), GET_TCGV_I32(a4), GET_TCGV_I32(a5),
                 GET_TCGV_I32(a6));
 }
@@ -211,7 +211,7 @@ static inline void tcg_gen_op6_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                    TCGv_i64 a3, TCGv_i64 a4,
                                    TCGv_i64 a5, TCGv_i64 a6)
 {
-    tcg_gen_op6(&tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
+    tcg_gen_op6(tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
                 GET_TCGV_I64(a3), GET_TCGV_I64(a4), GET_TCGV_I64(a5),
                 GET_TCGV_I64(a6));
 }
@@ -220,7 +220,7 @@ static inline void tcg_gen_op6i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                     TCGv_i32 a3, TCGv_i32 a4,
                                     TCGv_i32 a5, TCGArg a6)
 {
-    tcg_gen_op6(&tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
+    tcg_gen_op6(tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
                 GET_TCGV_I32(a3), GET_TCGV_I32(a4), GET_TCGV_I32(a5), a6);
 }
 
@@ -228,7 +228,7 @@ static inline void tcg_gen_op6i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                     TCGv_i64 a3, TCGv_i64 a4,
                                     TCGv_i64 a5, TCGArg a6)
 {
-    tcg_gen_op6(&tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
+    tcg_gen_op6(tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
                 GET_TCGV_I64(a3), GET_TCGV_I64(a4), GET_TCGV_I64(a5), a6);
 }
 
@@ -236,7 +236,7 @@ static inline void tcg_gen_op6ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                      TCGv_i32 a3, TCGv_i32 a4,
                                      TCGArg a5, TCGArg a6)
 {
-    tcg_gen_op6(&tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
+    tcg_gen_op6(tcg_ctx, opc, GET_TCGV_I32(a1), GET_TCGV_I32(a2),
                 GET_TCGV_I32(a3), GET_TCGV_I32(a4), a5, a6);
 }
 
@@ -244,7 +244,7 @@ static inline void tcg_gen_op6ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                      TCGv_i64 a3, TCGv_i64 a4,
                                      TCGArg a5, TCGArg a6)
 {
-    tcg_gen_op6(&tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
+    tcg_gen_op6(tcg_ctx, opc, GET_TCGV_I64(a1), GET_TCGV_I64(a2),
                 GET_TCGV_I64(a3), GET_TCGV_I64(a4), a5, a6);
 }
 
@@ -253,12 +253,12 @@ static inline void tcg_gen_op6ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
 
 static inline void gen_set_label(TCGLabel *l)
 {
-    tcg_gen_op1(&tcg_ctx, INDEX_op_set_label, label_arg(l));
+    tcg_gen_op1(tcg_ctx, INDEX_op_set_label, label_arg(l));
 }
 
 static inline void tcg_gen_br(TCGLabel *l)
 {
-    tcg_gen_op1(&tcg_ctx, INDEX_op_br, label_arg(l));
+    tcg_gen_op1(tcg_ctx, INDEX_op_br, label_arg(l));
 }
 
 void tcg_gen_mb(TCGBar);
@@ -732,12 +732,12 @@ static inline void tcg_gen_concat32_i64(TCGv_i64 ret, TCGv_i64 lo, TCGv_i64 hi)
 # if TARGET_LONG_BITS <= TCG_TARGET_REG_BITS
 static inline void tcg_gen_insn_start(target_ulong pc)
 {
-    tcg_gen_op1(&tcg_ctx, INDEX_op_insn_start, pc);
+    tcg_gen_op1(tcg_ctx, INDEX_op_insn_start, pc);
 }
 # else
 static inline void tcg_gen_insn_start(target_ulong pc)
 {
-    tcg_gen_op2(&tcg_ctx, INDEX_op_insn_start,
+    tcg_gen_op2(tcg_ctx, INDEX_op_insn_start,
                 (uint32_t)pc, (uint32_t)(pc >> 32));
 }
 # endif
@@ -745,12 +745,12 @@ static inline void tcg_gen_insn_start(target_ulong pc)
 # if TARGET_LONG_BITS <= TCG_TARGET_REG_BITS
 static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1)
 {
-    tcg_gen_op2(&tcg_ctx, INDEX_op_insn_start, pc, a1);
+    tcg_gen_op2(tcg_ctx, INDEX_op_insn_start, pc, a1);
 }
 # else
 static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1)
 {
-    tcg_gen_op4(&tcg_ctx, INDEX_op_insn_start,
+    tcg_gen_op4(tcg_ctx, INDEX_op_insn_start,
                 (uint32_t)pc, (uint32_t)(pc >> 32),
                 (uint32_t)a1, (uint32_t)(a1 >> 32));
 }
@@ -760,13 +760,13 @@ static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1)
 static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1,
                                       target_ulong a2)
 {
-    tcg_gen_op3(&tcg_ctx, INDEX_op_insn_start, pc, a1, a2);
+    tcg_gen_op3(tcg_ctx, INDEX_op_insn_start, pc, a1, a2);
 }
 # else
 static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1,
                                       target_ulong a2)
 {
-    tcg_gen_op6(&tcg_ctx, INDEX_op_insn_start,
+    tcg_gen_op6(tcg_ctx, INDEX_op_insn_start,
                 (uint32_t)pc, (uint32_t)(pc >> 32),
                 (uint32_t)a1, (uint32_t)(a1 >> 32),
                 (uint32_t)a2, (uint32_t)(a2 >> 32));
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 7cbe802..6913d4b 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -726,18 +726,19 @@ struct TCGContext {
     target_ulong gen_insn_data[TCG_MAX_INSNS][TARGET_INSN_START_WORDS];
 };
 
-extern TCGContext tcg_ctx;
+extern TCGContext tcg_init_ctx;
+extern TCGContext *tcg_ctx;
 
 static inline void tcg_set_insn_param(int op_idx, int arg, TCGArg v)
 {
-    int op_argi = tcg_ctx.gen_op_buf[op_idx].args;
-    tcg_ctx.gen_opparam_buf[op_argi + arg] = v;
+    int op_argi = tcg_ctx->gen_op_buf[op_idx].args;
+    tcg_ctx->gen_opparam_buf[op_argi + arg] = v;
 }
 
 /* The number of opcodes emitted so far.  */
 static inline int tcg_op_buf_count(void)
 {
-    return tcg_ctx.gen_next_op_idx;
+    return tcg_ctx->gen_next_op_idx;
 }
 
 /* Test for whether to terminate the TB for using too many opcodes.  */
@@ -756,13 +757,13 @@ TranslationBlock *tcg_tb_alloc(TCGContext *s);
 /* Called with tb_lock held.  */
 static inline void *tcg_malloc(int size)
 {
-    TCGContext *s = &tcg_ctx;
+    TCGContext *s = tcg_ctx;
     uint8_t *ptr, *ptr_end;
     size = (size + sizeof(long) - 1) & ~(sizeof(long) - 1);
     ptr = s->pool_cur;
     ptr_end = ptr + size;
     if (unlikely(ptr_end > s->pool_end)) {
-        return tcg_malloc_internal(&tcg_ctx, size);
+        return tcg_malloc_internal(tcg_ctx, size);
     } else {
         s->pool_cur = ptr_end;
         return ptr;
@@ -1100,7 +1101,7 @@ static inline unsigned get_mmuidx(TCGMemOpIdx oi)
 uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr);
 #else
 # define tcg_qemu_tb_exec(env, tb_ptr) \
-    ((uintptr_t (*)(void *, void *))tcg_ctx.code_gen_prologue)(env, tb_ptr)
+    ((uintptr_t (*)(void *, void *))tcg_ctx->code_gen_prologue)(env, tb_ptr)
 #endif
 
 void tcg_register_jit(void *buf, size_t buf_size);
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 919ef6b..961e357 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -153,7 +153,8 @@ static int v_l2_levels;
 static void *l1_map[V_L1_MAX_SIZE];
 
 /* code generation context */
-TCGContext tcg_ctx;
+TCGContext tcg_init_ctx;
+TCGContext *tcg_ctx;
 TBContext tb_ctx;
 bool parallel_cpus;
 
@@ -209,7 +210,7 @@ static TranslationBlock *tb_find_pc(uintptr_t tc_ptr);
 
 void cpu_gen_init(void)
 {
-    tcg_context_init(&tcg_ctx); 
+    tcg_context_init(&tcg_init_ctx);
 }
 
 /* Encode VAL as a signed leb128 sequence at P.
@@ -267,7 +268,7 @@ static target_long decode_sleb128(uint8_t **pp)
 
 static int encode_search(TranslationBlock *tb, uint8_t *block)
 {
-    uint8_t *highwater = tcg_ctx.code_gen_highwater;
+    uint8_t *highwater = tcg_ctx->code_gen_highwater;
     uint8_t *p = block;
     int i, j, n;
 
@@ -280,12 +281,12 @@ static int encode_search(TranslationBlock *tb, uint8_t *block)
             if (i == 0) {
                 prev = (j == 0 ? tb->pc : 0);
             } else {
-                prev = tcg_ctx.gen_insn_data[i - 1][j];
+                prev = tcg_ctx->gen_insn_data[i - 1][j];
             }
-            p = encode_sleb128(p, tcg_ctx.gen_insn_data[i][j] - prev);
+            p = encode_sleb128(p, tcg_ctx->gen_insn_data[i][j] - prev);
         }
-        prev = (i == 0 ? 0 : tcg_ctx.gen_insn_end_off[i - 1]);
-        p = encode_sleb128(p, tcg_ctx.gen_insn_end_off[i] - prev);
+        prev = (i == 0 ? 0 : tcg_ctx->gen_insn_end_off[i - 1]);
+        p = encode_sleb128(p, tcg_ctx->gen_insn_end_off[i] - prev);
 
         /* Test for (pending) buffer overflow.  The assumption is that any
            one row beginning below the high water mark cannot overrun
@@ -345,8 +346,8 @@ static int cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
     restore_state_to_opc(env, tb, data);
 
 #ifdef CONFIG_PROFILER
-    tcg_ctx.restore_time += profile_getclock() - ti;
-    tcg_ctx.restore_count++;
+    tcg_ctx->restore_time += profile_getclock() - ti;
+    tcg_ctx->restore_count++;
 #endif
     return 0;
 }
@@ -592,7 +593,7 @@ static inline void *split_cross_256mb(void *buf1, size_t size1)
         buf1 = buf2;
     }
 
-    tcg_ctx.code_gen_buffer_size = size1;
+    tcg_ctx->code_gen_buffer_size = size1;
     return buf1;
 }
 #endif
@@ -655,16 +656,16 @@ static inline void *alloc_code_gen_buffer(void)
     size = full_size - qemu_real_host_page_size;
 
     /* Honor a command-line option limiting the size of the buffer.  */
-    if (size > tcg_ctx.code_gen_buffer_size) {
-        size = (((uintptr_t)buf + tcg_ctx.code_gen_buffer_size)
+    if (size > tcg_ctx->code_gen_buffer_size) {
+        size = (((uintptr_t)buf + tcg_ctx->code_gen_buffer_size)
                 & qemu_real_host_page_mask) - (uintptr_t)buf;
     }
-    tcg_ctx.code_gen_buffer_size = size;
+    tcg_ctx->code_gen_buffer_size = size;
 
 #ifdef __mips__
     if (cross_256mb(buf, size)) {
         buf = split_cross_256mb(buf, size);
-        size = tcg_ctx.code_gen_buffer_size;
+        size = tcg_ctx->code_gen_buffer_size;
     }
 #endif
 
@@ -677,7 +678,7 @@ static inline void *alloc_code_gen_buffer(void)
 #elif defined(_WIN32)
 static inline void *alloc_code_gen_buffer(void)
 {
-    size_t size = tcg_ctx.code_gen_buffer_size;
+    size_t size = tcg_ctx->code_gen_buffer_size;
     void *buf1, *buf2;
 
     /* Perform the allocation in two steps, so that the guard page
@@ -696,7 +697,7 @@ static inline void *alloc_code_gen_buffer(void)
 {
     int flags = MAP_PRIVATE | MAP_ANONYMOUS;
     uintptr_t start = 0;
-    size_t size = tcg_ctx.code_gen_buffer_size;
+    size_t size = tcg_ctx->code_gen_buffer_size;
     void *buf;
 
     /* Constrain the position of the buffer based on the host cpu.
@@ -713,7 +714,7 @@ static inline void *alloc_code_gen_buffer(void)
     flags |= MAP_32BIT;
     /* Cannot expect to map more than 800MB in low memory.  */
     if (size > 800u * 1024 * 1024) {
-        tcg_ctx.code_gen_buffer_size = size = 800u * 1024 * 1024;
+        tcg_ctx->code_gen_buffer_size = size = 800u * 1024 * 1024;
     }
 # elif defined(__sparc__)
     start = 0x40000000ul;
@@ -753,7 +754,7 @@ static inline void *alloc_code_gen_buffer(void)
         default:
             /* Split the original buffer.  Free the smaller half.  */
             buf2 = split_cross_256mb(buf, size);
-            size2 = tcg_ctx.code_gen_buffer_size;
+            size2 = tcg_ctx->code_gen_buffer_size;
             if (buf == buf2) {
                 munmap(buf + size2 + qemu_real_host_page_size, size - size2);
             } else {
@@ -821,9 +822,9 @@ static gint tb_tc_cmp(gconstpointer ap, gconstpointer bp)
 
 static inline void code_gen_alloc(size_t tb_size)
 {
-    tcg_ctx.code_gen_buffer_size = size_code_gen_buffer(tb_size);
-    tcg_ctx.code_gen_buffer = alloc_code_gen_buffer();
-    if (tcg_ctx.code_gen_buffer == NULL) {
+    tcg_ctx->code_gen_buffer_size = size_code_gen_buffer(tb_size);
+    tcg_ctx->code_gen_buffer = alloc_code_gen_buffer();
+    if (tcg_ctx->code_gen_buffer == NULL) {
         fprintf(stderr, "Could not allocate dynamic translator buffer\n");
         exit(1);
     }
@@ -851,7 +852,7 @@ void tcg_exec_init(unsigned long tb_size)
 #if defined(CONFIG_SOFTMMU)
     /* There's no guest base to take into account, so go ahead and
        initialize the prologue now.  */
-    tcg_prologue_init(&tcg_ctx);
+    tcg_prologue_init(tcg_ctx);
 #endif
 }
 
@@ -867,7 +868,7 @@ static TranslationBlock *tb_alloc(target_ulong pc)
 
     assert_tb_locked();
 
-    tb = tcg_tb_alloc(&tcg_ctx);
+    tb = tcg_tb_alloc(tcg_ctx);
     if (unlikely(tb == NULL)) {
         return NULL;
     }
@@ -951,11 +952,11 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
 
         g_tree_foreach(tb_ctx.tb_tree, tb_host_size_iter, &host_size);
         printf("qemu: flush code_size=%td nb_tbs=%zu avg_tb_size=%zu\n",
-               tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer, nb_tbs,
+               tcg_ctx->code_gen_ptr - tcg_ctx->code_gen_buffer, nb_tbs,
                nb_tbs > 0 ? host_size / nb_tbs : 0);
     }
-    if ((unsigned long)(tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer)
-        > tcg_ctx.code_gen_buffer_size) {
+    if ((unsigned long)(tcg_ctx->code_gen_ptr - tcg_ctx->code_gen_buffer)
+        > tcg_ctx->code_gen_buffer_size) {
         cpu_abort(cpu, "Internal error: code buffer overflow\n");
     }
 
@@ -970,7 +971,7 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
     qht_reset_size(&tb_ctx.htable, CODE_GEN_HTABLE_SIZE);
     page_flush_tb();
 
-    tcg_ctx.code_gen_ptr = tcg_ctx.code_gen_buffer;
+    tcg_ctx->code_gen_ptr = tcg_ctx->code_gen_buffer;
     /* XXX: flush processor icache at this point if cache flush is
        expensive */
     atomic_mb_set(&tb_ctx.tb_flush_count, tb_ctx.tb_flush_count + 1);
@@ -1325,44 +1326,44 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         cpu_loop_exit(cpu);
     }
 
-    gen_code_buf = tcg_ctx.code_gen_ptr;
+    gen_code_buf = tcg_ctx->code_gen_ptr;
     tb->tc.ptr = gen_code_buf;
     tb->pc = pc;
     tb->cs_base = cs_base;
     tb->flags = flags;
     tb->cflags = cflags;
     tb->trace_vcpu_dstate = *cpu->trace_dstate;
-    tcg_ctx.cf_parallel = !!(cflags & CF_PARALLEL);
+    tcg_ctx->cf_parallel = !!(cflags & CF_PARALLEL);
 
 #ifdef CONFIG_PROFILER
-    tcg_ctx.tb_count1++; /* includes aborted translations because of
+    tcg_ctx->tb_count1++; /* includes aborted translations because of
                        exceptions */
     ti = profile_getclock();
 #endif
 
-    tcg_func_start(&tcg_ctx);
+    tcg_func_start(tcg_ctx);
 
-    tcg_ctx.cpu = ENV_GET_CPU(env);
+    tcg_ctx->cpu = ENV_GET_CPU(env);
     gen_intermediate_code(env, tb);
-    tcg_ctx.cpu = NULL;
+    tcg_ctx->cpu = NULL;
 
     trace_translate_block(tb, tb->pc, tb->tc.ptr);
 
     /* generate machine code */
     tb->jmp_reset_offset[0] = TB_JMP_RESET_OFFSET_INVALID;
     tb->jmp_reset_offset[1] = TB_JMP_RESET_OFFSET_INVALID;
-    tcg_ctx.tb_jmp_reset_offset = tb->jmp_reset_offset;
+    tcg_ctx->tb_jmp_reset_offset = tb->jmp_reset_offset;
 #ifdef USE_DIRECT_JUMP
-    tcg_ctx.tb_jmp_insn_offset = tb->jmp_insn_offset;
-    tcg_ctx.tb_jmp_target_addr = NULL;
+    tcg_ctx->tb_jmp_insn_offset = tb->jmp_insn_offset;
+    tcg_ctx->tb_jmp_target_addr = NULL;
 #else
-    tcg_ctx.tb_jmp_insn_offset = NULL;
-    tcg_ctx.tb_jmp_target_addr = tb->jmp_target_addr;
+    tcg_ctx->tb_jmp_insn_offset = NULL;
+    tcg_ctx->tb_jmp_target_addr = tb->jmp_target_addr;
 #endif
 
 #ifdef CONFIG_PROFILER
-    tcg_ctx.tb_count++;
-    tcg_ctx.interm_time += profile_getclock() - ti;
+    tcg_ctx->tb_count++;
+    tcg_ctx->interm_time += profile_getclock() - ti;
     ti = profile_getclock();
 #endif
 
@@ -1371,7 +1372,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
        the tcg optimization currently hidden inside tcg_gen_code.  All
        that should be required is to flush the TBs, allocate a new TB,
        re-initialize it per above, and re-do the actual code generation.  */
-    gen_code_size = tcg_gen_code(&tcg_ctx, tb);
+    gen_code_size = tcg_gen_code(tcg_ctx, tb);
     if (unlikely(gen_code_size < 0)) {
         goto buffer_overflow;
     }
@@ -1382,10 +1383,10 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb->tc.size = gen_code_size;
 
 #ifdef CONFIG_PROFILER
-    tcg_ctx.code_time += profile_getclock() - ti;
-    tcg_ctx.code_in_len += tb->size;
-    tcg_ctx.code_out_len += gen_code_size;
-    tcg_ctx.search_out_len += search_size;
+    tcg_ctx->code_time += profile_getclock() - ti;
+    tcg_ctx->code_in_len += tb->size;
+    tcg_ctx->code_out_len += gen_code_size;
+    tcg_ctx->search_out_len += search_size;
 #endif
 
 #ifdef DEBUG_DISAS
@@ -1400,7 +1401,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     }
 #endif
 
-    tcg_ctx.code_gen_ptr = (void *)
+    tcg_ctx->code_gen_ptr = (void *)
         ROUND_UP((uintptr_t)gen_code_buf + gen_code_size + search_size,
                  CODE_GEN_ALIGN);
 
@@ -1955,8 +1956,8 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
      * For avg host size we use the precise numbers from tb_tree_stats though.
      */
     cpu_fprintf(f, "gen code size       %td/%zd\n",
-                tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer,
-                tcg_ctx.code_gen_highwater - tcg_ctx.code_gen_buffer);
+                tcg_ctx->code_gen_ptr - tcg_ctx->code_gen_buffer,
+                tcg_ctx->code_gen_highwater - tcg_ctx->code_gen_buffer);
     cpu_fprintf(f, "TB count            %zu\n", nb_tbs);
     cpu_fprintf(f, "TB avg target size  %zu max=%zu bytes\n",
                 nb_tbs ? tst.target_size / nb_tbs : 0,
diff --git a/bsd-user/main.c b/bsd-user/main.c
index fa9c012..7a8b29e 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -978,7 +978,7 @@ int main(int argc, char **argv)
     /* Now that we've loaded the binary, GUEST_BASE is fixed.  Delay
        generating the prologue until now so that the prologue can take
        the real value of GUEST_BASE into account.  */
-    tcg_prologue_init(&tcg_ctx);
+    tcg_prologue_init(tcg_ctx);
 
     /* build Task State */
     memset(ts, 0, sizeof(TaskState));
diff --git a/linux-user/main.c b/linux-user/main.c
index 630c73d..ad4c6f5 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4456,7 +4456,7 @@ int main(int argc, char **argv, char **envp)
     /* Now that we've loaded the binary, GUEST_BASE is fixed.  Delay
        generating the prologue until now so that the prologue can take
        the real value of GUEST_BASE into account.  */
-    tcg_prologue_init(&tcg_ctx);
+    tcg_prologue_init(tcg_ctx);
 
 #if defined(TARGET_I386)
     env->cr[0] = CR0_PG_MASK | CR0_WP_MASK | CR0_PE_MASK;
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 96c527b..ee309bb 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -154,7 +154,7 @@ void alpha_translate_init(void)
     done_init = 1;
 
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx.tcg_env = cpu_env;
+    tcg_ctx->tcg_env = cpu_env;
 
     for (i = 0; i < 31; i++) {
         cpu_std_ir[i] = tcg_global_mem_new_i64(cpu_env,
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 34aa95d..4fbbd71 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -82,7 +82,7 @@ void arm_translate_init(void)
     int i;
 
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx.tcg_env = cpu_env;
+    tcg_ctx->tcg_env = cpu_env;
 
     for (i = 0; i < 16; i++) {
         cpu_R[i] = tcg_global_mem_new_i32(cpu_env,
diff --git a/target/cris/translate.c b/target/cris/translate.c
index 0ee05ca..a503b96 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -3365,7 +3365,7 @@ void cris_initialize_tcg(void)
     int i;
 
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx.tcg_env = cpu_env;
+    tcg_ctx->tcg_env = cpu_env;
     cc_x = tcg_global_mem_new(cpu_env,
                               offsetof(CPUCRISState, cc_x), "cc_x");
     cc_src = tcg_global_mem_new(cpu_env,
diff --git a/target/cris/translate_v10.c b/target/cris/translate_v10.c
index 4a0b485..5d48920 100644
--- a/target/cris/translate_v10.c
+++ b/target/cris/translate_v10.c
@@ -1273,7 +1273,7 @@ void cris_initialize_crisv10_tcg(void)
     int i;
 
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx.tcg_env = cpu_env;
+    tcg_ctx->tcg_env = cpu_env;
     cc_x = tcg_global_mem_new(cpu_env,
                               offsetof(CPUCRISState, cc_x), "cc_x");
     cc_src = tcg_global_mem_new(cpu_env,
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index fde3dba..6f476db 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -145,7 +145,7 @@ void hppa_translate_init(void)
     done_init = 1;
 
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx.tcg_env = cpu_env;
+    tcg_ctx->tcg_env = cpu_env;
 
     TCGV_UNUSED(cpu_gr[0]);
     for (i = 1; i < 32; i++) {
diff --git a/target/i386/translate.c b/target/i386/translate.c
index c5e4d77..4da5a8f 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8335,7 +8335,7 @@ void tcg_x86_init(void)
     initialized = true;
 
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx.tcg_env = cpu_env;
+    tcg_ctx->tcg_env = cpu_env;
     cpu_cc_op = tcg_global_mem_new_i32(cpu_env,
                                        offsetof(CPUX86State, cc_op), "cc_op");
     cpu_cc_dst = tcg_global_mem_new(cpu_env, offsetof(CPUX86State, cc_dst),
diff --git a/target/lm32/translate.c b/target/lm32/translate.c
index 692882f..b38e1e5 100644
--- a/target/lm32/translate.c
+++ b/target/lm32/translate.c
@@ -1203,7 +1203,7 @@ void lm32_translate_init(void)
     int i;
 
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx.tcg_env = cpu_env;
+    tcg_ctx->tcg_env = cpu_env;
 
     for (i = 0; i < ARRAY_SIZE(cpu_R); i++) {
         cpu_R[i] = tcg_global_mem_new(cpu_env,
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 5cfa25f..6dd72bc 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -69,7 +69,7 @@ void m68k_tcg_init(void)
     int i;
 
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx.tcg_env = cpu_env;
+    tcg_ctx->tcg_env = cpu_env;
 
 #define DEFO32(name, offset) \
     QREG_##name = tcg_global_mem_new_i32(cpu_env, \
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index cb65d1e..cb2ef50 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1861,7 +1861,7 @@ void mb_tcg_init(void)
     int i;
 
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx.tcg_env = cpu_env;
+    tcg_ctx->tcg_env = cpu_env;
 
     env_debug = tcg_global_mem_new(cpu_env,
                     offsetof(CPUMBState, debug),
diff --git a/target/mips/translate.c b/target/mips/translate.c
index a2f5385..2929e61 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20139,7 +20139,7 @@ void mips_tcg_init(void)
         return;
 
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx.tcg_env = cpu_env;
+    tcg_ctx->tcg_env = cpu_env;
 
     TCGV_UNUSED(cpu_gpr[0]);
     for (i = 1; i < 32; i++)
diff --git a/target/moxie/translate.c b/target/moxie/translate.c
index 0660b44..5a5f62f 100644
--- a/target/moxie/translate.c
+++ b/target/moxie/translate.c
@@ -106,7 +106,7 @@ void moxie_translate_init(void)
         return;
     }
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx.tcg_env = cpu_env;
+    tcg_ctx->tcg_env = cpu_env;
     cpu_pc = tcg_global_mem_new_i32(cpu_env,
                                     offsetof(CPUMoxieState, pc), "$pc");
     for (i = 0; i < 16; i++)
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index e49518e..27714f6 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -75,7 +75,7 @@ void openrisc_translate_init(void)
     int i;
 
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx.tcg_env = cpu_env;
+    tcg_ctx->tcg_env = cpu_env;
     cpu_sr = tcg_global_mem_new(cpu_env,
                                 offsetof(CPUOpenRISCState, sr), "sr");
     cpu_dflag = tcg_global_mem_new_i32(cpu_env,
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index c0cd64d..b842bd5 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -90,7 +90,7 @@ void ppc_translate_init(void)
         return;
 
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx.tcg_env = cpu_env;
+    tcg_ctx->tcg_env = cpu_env;
 
     p = cpu_reg_names;
     cpu_reg_names_size = sizeof(cpu_reg_names);
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 6535f6c..b23356b 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -171,7 +171,7 @@ void s390x_translate_init(void)
     int i;
 
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx.tcg_env = cpu_env;
+    tcg_ctx->tcg_env = cpu_env;
     psw_addr = tcg_global_mem_new_i64(cpu_env,
                                       offsetof(CPUS390XState, psw.addr),
                                       "psw_addr");
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 8bc132b..f745eb2 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -102,7 +102,7 @@ void sh4_translate_init(void)
         return;
 
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx.tcg_env = cpu_env;
+    tcg_ctx->tcg_env = cpu_env;
 
     for (i = 0; i < 24; i++)
         cpu_gregs[i] = tcg_global_mem_new_i32(cpu_env,
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 0274e83..0b4ab3d 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5933,7 +5933,7 @@ void gen_intermediate_code_init(CPUSPARCState *env)
     inited = 1;
 
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx.tcg_env = cpu_env;
+    tcg_ctx->tcg_env = cpu_env;
 
     cpu_regwptr = tcg_global_mem_new_ptr(cpu_env,
                                          offsetof(CPUSPARCState, regwptr),
diff --git a/target/tilegx/translate.c b/target/tilegx/translate.c
index ff2ef7b..913cbe4 100644
--- a/target/tilegx/translate.c
+++ b/target/tilegx/translate.c
@@ -2447,7 +2447,7 @@ void tilegx_tcg_init(void)
     int i;
 
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx.tcg_env = cpu_env;
+    tcg_ctx->tcg_env = cpu_env;
     cpu_pc = tcg_global_mem_new_i64(cpu_env, offsetof(CPUTLGState, pc), "pc");
     for (i = 0; i < TILEGX_R_COUNT; i++) {
         cpu_regs[i] = tcg_global_mem_new_i64(cpu_env,
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index ddd2dd0..bb56f03 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8886,7 +8886,7 @@ void tricore_tcg_init(void)
         return;
     }
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx.tcg_env = cpu_env;
+    tcg_ctx->tcg_env = cpu_env;
     /* reg init */
     for (i = 0 ; i < 16 ; i++) {
         cpu_gpr_a[i] = tcg_global_mem_new(cpu_env,
diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index 666a201..5f36fb3 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -70,7 +70,7 @@ void uc32_translate_init(void)
     int i;
 
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx.tcg_env = cpu_env;
+    tcg_ctx->tcg_env = cpu_env;
 
     for (i = 0; i < 32; i++) {
         cpu_R[i] = tcg_global_mem_new_i32(cpu_env,
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 2630024..c984fb4 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -218,7 +218,7 @@ void xtensa_translate_init(void)
     int i;
 
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
-    tcg_ctx.tcg_env = cpu_env;
+    tcg_ctx->tcg_env = cpu_env;
     cpu_pc = tcg_global_mem_new_i32(cpu_env,
             offsetof(CPUXtensaState, pc), "pc");
 
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ef420d4..4a7057e 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -150,8 +150,8 @@ void tcg_gen_op6(TCGContext *ctx, TCGOpcode opc, TCGArg a1, TCGArg a2,
 
 void tcg_gen_mb(TCGBar mb_type)
 {
-    if (tcg_ctx.cf_parallel) {
-        tcg_gen_op1(&tcg_ctx, INDEX_op_mb, mb_type);
+    if (tcg_ctx->cf_parallel) {
+        tcg_gen_op1(tcg_ctx, INDEX_op_mb, mb_type);
     }
 }
 
@@ -2486,7 +2486,7 @@ void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_mov_i32(ret, TCGV_LOW(arg));
     } else if (TCG_TARGET_HAS_extrl_i64_i32) {
-        tcg_gen_op2(&tcg_ctx, INDEX_op_extrl_i64_i32,
+        tcg_gen_op2(tcg_ctx, INDEX_op_extrl_i64_i32,
                     GET_TCGV_I32(ret), GET_TCGV_I64(arg));
     } else {
         tcg_gen_mov_i32(ret, MAKE_TCGV_I32(GET_TCGV_I64(arg)));
@@ -2498,7 +2498,7 @@ void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_mov_i32(ret, TCGV_HIGH(arg));
     } else if (TCG_TARGET_HAS_extrh_i64_i32) {
-        tcg_gen_op2(&tcg_ctx, INDEX_op_extrh_i64_i32,
+        tcg_gen_op2(tcg_ctx, INDEX_op_extrh_i64_i32,
                     GET_TCGV_I32(ret), GET_TCGV_I64(arg));
     } else {
         TCGv_i64 t = tcg_temp_new_i64();
@@ -2514,7 +2514,7 @@ void tcg_gen_extu_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
         tcg_gen_mov_i32(TCGV_LOW(ret), arg);
         tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
     } else {
-        tcg_gen_op2(&tcg_ctx, INDEX_op_extu_i32_i64,
+        tcg_gen_op2(tcg_ctx, INDEX_op_extu_i32_i64,
                     GET_TCGV_I64(ret), GET_TCGV_I32(arg));
     }
 }
@@ -2525,7 +2525,7 @@ void tcg_gen_ext_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
         tcg_gen_mov_i32(TCGV_LOW(ret), arg);
         tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
     } else {
-        tcg_gen_op2(&tcg_ctx, INDEX_op_ext_i32_i64,
+        tcg_gen_op2(tcg_ctx, INDEX_op_ext_i32_i64,
                     GET_TCGV_I64(ret), GET_TCGV_I32(arg));
     }
 }
@@ -2581,8 +2581,8 @@ void tcg_gen_goto_tb(unsigned idx)
     tcg_debug_assert(idx <= 1);
 #ifdef CONFIG_DEBUG_TCG
     /* Verify that we havn't seen this numbered exit before.  */
-    tcg_debug_assert((tcg_ctx.goto_tb_issue_mask & (1 << idx)) == 0);
-    tcg_ctx.goto_tb_issue_mask |= 1 << idx;
+    tcg_debug_assert((tcg_ctx->goto_tb_issue_mask & (1 << idx)) == 0);
+    tcg_ctx->goto_tb_issue_mask |= 1 << idx;
 #endif
     tcg_gen_op1i(INDEX_op_goto_tb, idx);
 }
@@ -2591,7 +2591,7 @@ void tcg_gen_lookup_and_goto_ptr(void)
 {
     if (TCG_TARGET_HAS_goto_ptr && !qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) {
         TCGv_ptr ptr = tcg_temp_new_ptr();
-        gen_helper_lookup_tb_ptr(ptr, tcg_ctx.tcg_env);
+        gen_helper_lookup_tb_ptr(ptr, tcg_ctx->tcg_env);
         tcg_gen_op1i(INDEX_op_goto_ptr, GET_TCGV_PTR(ptr));
         tcg_temp_free_ptr(ptr);
     } else {
@@ -2637,7 +2637,7 @@ static void gen_ldst_i32(TCGOpcode opc, TCGv_i32 val, TCGv addr,
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_op4i_i32(opc, val, TCGV_LOW(addr), TCGV_HIGH(addr), oi);
     } else {
-        tcg_gen_op3(&tcg_ctx, opc, GET_TCGV_I32(val), GET_TCGV_I64(addr), oi);
+        tcg_gen_op3(tcg_ctx, opc, GET_TCGV_I32(val), GET_TCGV_I64(addr), oi);
     }
 #endif
 }
@@ -2650,7 +2650,7 @@ static void gen_ldst_i64(TCGOpcode opc, TCGv_i64 val, TCGv addr,
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_op4i_i32(opc, TCGV_LOW(val), TCGV_HIGH(val), addr, oi);
     } else {
-        tcg_gen_op3(&tcg_ctx, opc, GET_TCGV_I64(val), GET_TCGV_I32(addr), oi);
+        tcg_gen_op3(tcg_ctx, opc, GET_TCGV_I64(val), GET_TCGV_I32(addr), oi);
     }
 #else
     if (TCG_TARGET_REG_BITS == 32) {
@@ -2665,7 +2665,7 @@ static void gen_ldst_i64(TCGOpcode opc, TCGv_i64 val, TCGv addr,
 void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 {
     memop = tcg_canonicalize_memop(memop, 0, 0);
-    trace_guest_mem_before_tcg(tcg_ctx.cpu, tcg_ctx.tcg_env,
+    trace_guest_mem_before_tcg(tcg_ctx->cpu, tcg_ctx->tcg_env,
                                addr, trace_mem_get_info(memop, 0));
     gen_ldst_i32(INDEX_op_qemu_ld_i32, val, addr, memop, idx);
 }
@@ -2673,7 +2673,7 @@ void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 {
     memop = tcg_canonicalize_memop(memop, 0, 1);
-    trace_guest_mem_before_tcg(tcg_ctx.cpu, tcg_ctx.tcg_env,
+    trace_guest_mem_before_tcg(tcg_ctx->cpu, tcg_ctx->tcg_env,
                                addr, trace_mem_get_info(memop, 1));
     gen_ldst_i32(INDEX_op_qemu_st_i32, val, addr, memop, idx);
 }
@@ -2691,7 +2691,7 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
     }
 
     memop = tcg_canonicalize_memop(memop, 1, 0);
-    trace_guest_mem_before_tcg(tcg_ctx.cpu, tcg_ctx.tcg_env,
+    trace_guest_mem_before_tcg(tcg_ctx->cpu, tcg_ctx->tcg_env,
                                addr, trace_mem_get_info(memop, 0));
     gen_ldst_i64(INDEX_op_qemu_ld_i64, val, addr, memop, idx);
 }
@@ -2704,7 +2704,7 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
     }
 
     memop = tcg_canonicalize_memop(memop, 1, 1);
-    trace_guest_mem_before_tcg(tcg_ctx.cpu, tcg_ctx.tcg_env,
+    trace_guest_mem_before_tcg(tcg_ctx->cpu, tcg_ctx->tcg_env,
                                addr, trace_mem_get_info(memop, 1));
     gen_ldst_i64(INDEX_op_qemu_st_i64, val, addr, memop, idx);
 }
@@ -2794,7 +2794,7 @@ void tcg_gen_atomic_cmpxchg_i32(TCGv_i32 retv, TCGv addr, TCGv_i32 cmpv,
 {
     memop = tcg_canonicalize_memop(memop, 0, 0);
 
-    if (!tcg_ctx.cf_parallel) {
+    if (!tcg_ctx->cf_parallel) {
         TCGv_i32 t1 = tcg_temp_new_i32();
         TCGv_i32 t2 = tcg_temp_new_i32();
 
@@ -2820,11 +2820,11 @@ void tcg_gen_atomic_cmpxchg_i32(TCGv_i32 retv, TCGv addr, TCGv_i32 cmpv,
 #ifdef CONFIG_SOFTMMU
         {
             TCGv_i32 oi = tcg_const_i32(make_memop_idx(memop & ~MO_SIGN, idx));
-            gen(retv, tcg_ctx.tcg_env, addr, cmpv, newv, oi);
+            gen(retv, tcg_ctx->tcg_env, addr, cmpv, newv, oi);
             tcg_temp_free_i32(oi);
         }
 #else
-        gen(retv, tcg_ctx.tcg_env, addr, cmpv, newv);
+        gen(retv, tcg_ctx->tcg_env, addr, cmpv, newv);
 #endif
 
         if (memop & MO_SIGN) {
@@ -2838,7 +2838,7 @@ void tcg_gen_atomic_cmpxchg_i64(TCGv_i64 retv, TCGv addr, TCGv_i64 cmpv,
 {
     memop = tcg_canonicalize_memop(memop, 1, 0);
 
-    if (!tcg_ctx.cf_parallel) {
+    if (!tcg_ctx->cf_parallel) {
         TCGv_i64 t1 = tcg_temp_new_i64();
         TCGv_i64 t2 = tcg_temp_new_i64();
 
@@ -2865,14 +2865,14 @@ void tcg_gen_atomic_cmpxchg_i64(TCGv_i64 retv, TCGv addr, TCGv_i64 cmpv,
 #ifdef CONFIG_SOFTMMU
         {
             TCGv_i32 oi = tcg_const_i32(make_memop_idx(memop, idx));
-            gen(retv, tcg_ctx.tcg_env, addr, cmpv, newv, oi);
+            gen(retv, tcg_ctx->tcg_env, addr, cmpv, newv, oi);
             tcg_temp_free_i32(oi);
         }
 #else
-        gen(retv, tcg_ctx.tcg_env, addr, cmpv, newv);
+        gen(retv, tcg_ctx->tcg_env, addr, cmpv, newv);
 #endif
 #else
-        gen_helper_exit_atomic(tcg_ctx.tcg_env);
+        gen_helper_exit_atomic(tcg_ctx->tcg_env);
         /* Produce a result, so that we have a well-formed opcode stream
            with respect to uses of the result in the (dead) code following.  */
         tcg_gen_movi_i64(retv, 0);
@@ -2928,11 +2928,11 @@ static void do_atomic_op_i32(TCGv_i32 ret, TCGv addr, TCGv_i32 val,
 #ifdef CONFIG_SOFTMMU
     {
         TCGv_i32 oi = tcg_const_i32(make_memop_idx(memop & ~MO_SIGN, idx));
-        gen(ret, tcg_ctx.tcg_env, addr, val, oi);
+        gen(ret, tcg_ctx->tcg_env, addr, val, oi);
         tcg_temp_free_i32(oi);
     }
 #else
-    gen(ret, tcg_ctx.tcg_env, addr, val);
+    gen(ret, tcg_ctx->tcg_env, addr, val);
 #endif
 
     if (memop & MO_SIGN) {
@@ -2973,14 +2973,14 @@ static void do_atomic_op_i64(TCGv_i64 ret, TCGv addr, TCGv_i64 val,
 #ifdef CONFIG_SOFTMMU
         {
             TCGv_i32 oi = tcg_const_i32(make_memop_idx(memop & ~MO_SIGN, idx));
-            gen(ret, tcg_ctx.tcg_env, addr, val, oi);
+            gen(ret, tcg_ctx->tcg_env, addr, val, oi);
             tcg_temp_free_i32(oi);
         }
 #else
-        gen(ret, tcg_ctx.tcg_env, addr, val);
+        gen(ret, tcg_ctx->tcg_env, addr, val);
 #endif
 #else
-        gen_helper_exit_atomic(tcg_ctx.tcg_env);
+        gen_helper_exit_atomic(tcg_ctx->tcg_env);
         /* Produce a result, so that we have a well-formed opcode stream
            with respect to uses of the result in the (dead) code following.  */
         tcg_gen_movi_i64(ret, 0);
@@ -3015,7 +3015,7 @@ static void * const table_##NAME[16] = {                                \
 void tcg_gen_atomic_##NAME##_i32                                        \
     (TCGv_i32 ret, TCGv addr, TCGv_i32 val, TCGArg idx, TCGMemOp memop) \
 {                                                                       \
-    if (tcg_ctx.cf_parallel) {                                          \
+    if (tcg_ctx->cf_parallel) {                                         \
         do_atomic_op_i32(ret, addr, val, idx, memop, table_##NAME);     \
     } else {                                                            \
         do_nonatomic_op_i32(ret, addr, val, idx, memop, NEW,            \
@@ -3025,7 +3025,7 @@ void tcg_gen_atomic_##NAME##_i32                                        \
 void tcg_gen_atomic_##NAME##_i64                                        \
     (TCGv_i64 ret, TCGv addr, TCGv_i64 val, TCGArg idx, TCGMemOp memop) \
 {                                                                       \
-    if (tcg_ctx.cf_parallel) {                                          \
+    if (tcg_ctx->cf_parallel) {                                         \
         do_atomic_op_i64(ret, addr, val, idx, memop, table_##NAME);     \
     } else {                                                            \
         do_nonatomic_op_i64(ret, addr, val, idx, memop, NEW,            \
diff --git a/tcg/tcg-runtime.c b/tcg/tcg-runtime.c
index 08fe077..2f80b19 100644
--- a/tcg/tcg-runtime.c
+++ b/tcg/tcg-runtime.c
@@ -153,7 +153,7 @@ void *HELPER(lookup_tb_ptr)(CPUArchState *env)
 
     tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags, curr_cf_mask());
     if (tb == NULL) {
-        return tcg_ctx.code_gen_epilogue;
+        return tcg_ctx->code_gen_epilogue;
     }
     qemu_log_mask_and_addr(CPU_LOG_EXEC, pc,
                            "Chain %p [%d: " TARGET_FMT_lx "] %s\n",
diff --git a/tcg/tcg.c b/tcg/tcg.c
index c0c2d6c..f907c47 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -116,7 +116,6 @@ static void tcg_out_tb_init(TCGContext *s);
 static bool tcg_out_tb_finalize(TCGContext *s);
 
 
-
 static TCGRegSet tcg_target_available_regs[2];
 static TCGRegSet tcg_target_call_clobber_regs;
 
@@ -242,7 +241,7 @@ static void tcg_out_label(TCGContext *s, TCGLabel *l, tcg_insn_unit *ptr)
 
 TCGLabel *gen_new_label(void)
 {
-    TCGContext *s = &tcg_ctx;
+    TCGContext *s = tcg_ctx;
     TCGLabel *l = tcg_malloc(sizeof(TCGLabel));
 
     *l = (TCGLabel){
@@ -381,6 +380,8 @@ void tcg_context_init(TCGContext *s)
     for (; i < ARRAY_SIZE(tcg_target_reg_alloc_order); ++i) {
         indirect_reg_alloc_order[i] = tcg_target_reg_alloc_order[i];
     }
+
+    tcg_ctx = s;
 }
 
 /*
@@ -526,7 +527,7 @@ void tcg_set_frame(TCGContext *s, TCGReg reg, intptr_t start, intptr_t size)
 
 TCGv_i32 tcg_global_reg_new_i32(TCGReg reg, const char *name)
 {
-    TCGContext *s = &tcg_ctx;
+    TCGContext *s = tcg_ctx;
     int idx;
 
     if (tcg_regset_test_reg(s->reserved_regs, reg)) {
@@ -538,7 +539,7 @@ TCGv_i32 tcg_global_reg_new_i32(TCGReg reg, const char *name)
 
 TCGv_i64 tcg_global_reg_new_i64(TCGReg reg, const char *name)
 {
-    TCGContext *s = &tcg_ctx;
+    TCGContext *s = tcg_ctx;
     int idx;
 
     if (tcg_regset_test_reg(s->reserved_regs, reg)) {
@@ -551,7 +552,7 @@ TCGv_i64 tcg_global_reg_new_i64(TCGReg reg, const char *name)
 int tcg_global_mem_new_internal(TCGType type, TCGv_ptr base,
                                 intptr_t offset, const char *name)
 {
-    TCGContext *s = &tcg_ctx;
+    TCGContext *s = tcg_ctx;
     TCGTemp *base_ts = &s->temps[GET_TCGV_PTR(base)];
     TCGTemp *ts = tcg_global_alloc(s);
     int indirect_reg = 0, bigendian = 0;
@@ -606,7 +607,7 @@ int tcg_global_mem_new_internal(TCGType type, TCGv_ptr base,
 
 static int tcg_temp_new_internal(TCGType type, int temp_local)
 {
-    TCGContext *s = &tcg_ctx;
+    TCGContext *s = tcg_ctx;
     TCGTemp *ts;
     int idx, k;
 
@@ -668,7 +669,7 @@ TCGv_i64 tcg_temp_new_internal_i64(int temp_local)
 
 static void tcg_temp_free_internal(int idx)
 {
-    TCGContext *s = &tcg_ctx;
+    TCGContext *s = tcg_ctx;
     TCGTemp *ts;
     int k;
 
@@ -733,13 +734,13 @@ TCGv_i64 tcg_const_local_i64(int64_t val)
 #if defined(CONFIG_DEBUG_TCG)
 void tcg_clear_temp_count(void)
 {
-    TCGContext *s = &tcg_ctx;
+    TCGContext *s = tcg_ctx;
     s->temps_in_use = 0;
 }
 
 int tcg_check_temp_count(void)
 {
-    TCGContext *s = &tcg_ctx;
+    TCGContext *s = tcg_ctx;
     if (s->temps_in_use) {
         /* Clear the count so that we don't give another
          * warning immediately next time around.
@@ -2707,7 +2708,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
 #ifdef CONFIG_PROFILER
 void tcg_dump_info(FILE *f, fprintf_function cpu_fprintf)
 {
-    TCGContext *s = &tcg_ctx;
+    TCGContext *s = tcg_ctx;
     int64_t tb_count = s->tb_count;
     int64_t tb_div_count = tb_count ? tb_count : 1;
     int64_t tot = s->interm_time + s->code_time;
-- 
2.7.4
