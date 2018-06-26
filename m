Received: from eggs.gnu.org ([2001:4830:134:3::10]:42502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXqgq-0000xh-TC
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXqgo-0005vM-25
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:19:36 -0400
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b]:32893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXqgn-0005v2-TK
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:19:34 -0400
Received: by mail-pg0-x22b.google.com with SMTP id e11-v6so7849502pgq.0
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 09:19:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 26 Jun 2018 09:19:14 -0700
Message-Id: <20180626161921.27941-7-richard.henderson@linaro.org>
In-Reply-To: <20180626161921.27941-1-richard.henderson@linaro.org>
References: <20180626161921.27941-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 06/13] target/ppc: Tidy gen_conditional_store
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Leave only the minimal amount of code within the STCX macro,
moving the rest of the code into gen_conditional_store.
Remove the explicit call to gen_check_align; the matching LDAX will
have already checked alignment, and we verify the same address.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 03e8c5df03..e751072404 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3201,14 +3201,17 @@ ST_ATOMIC(stwat, DEF_MEMOP(MO_UL), i32, trunc_tl_i32)
 ST_ATOMIC(stdat, DEF_MEMOP(MO_Q), i64, mov_i64)
 #endif
 
-static void gen_conditional_store(DisasContext *ctx, TCGv EA,
-                                  int reg, int memop)
+static void gen_conditional_store(DisasContext *ctx, TCGMemOp memop)
 {
     TCGLabel *l1 = gen_new_label();
     TCGLabel *l2 = gen_new_label();
-    TCGv t0;
+    TCGv t0 = tcg_temp_new();
+    int reg = rS(ctx->opcode);
 
-    tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, l1);
+    gen_set_access_type(ctx, ACCESS_RES);
+    gen_addr_reg_index(ctx, t0);
+    tcg_gen_brcond_tl(TCG_COND_NE, t0, cpu_reserve, l1);
+    tcg_temp_free(t0);
 
     t0 = tcg_temp_new();
     tcg_gen_atomic_cmpxchg_tl(t0, cpu_reserve, cpu_reserve_val,
@@ -3232,19 +3235,10 @@ static void gen_conditional_store(DisasContext *ctx, TCGv EA,
     tcg_gen_movi_tl(cpu_reserve, -1);
 }
 
-#define STCX(name, memop)                                   \
-static void gen_##name(DisasContext *ctx)                   \
-{                                                           \
-    TCGv t0;                                                \
-    int len = MEMOP_GET_SIZE(memop);                        \
-    gen_set_access_type(ctx, ACCESS_RES);                   \
-    t0 = tcg_temp_local_new();                              \
-    gen_addr_reg_index(ctx, t0);                            \
-    if (len > 1) {                                          \
-        gen_check_align(ctx, t0, (len) - 1);                \
-    }                                                       \
-    gen_conditional_store(ctx, t0, rS(ctx->opcode), memop); \
-    tcg_temp_free(t0);                                      \
+#define STCX(name, memop)                  \
+static void gen_##name(DisasContext *ctx)  \
+{                                          \
+    gen_conditional_store(ctx, memop);     \
 }
 
 STCX(stbcx_, DEF_MEMOP(MO_UB))
-- 
2.17.1
