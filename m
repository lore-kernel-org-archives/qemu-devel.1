Received: from eggs.gnu.org ([2001:4830:134:3::10]:53493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dpgxU-0002Zo-BR
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:30:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dpgxR-00013f-5c
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:30:00 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41599)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dpgxQ-00011q-VR
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:29:57 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed,  6 Sep 2017 16:28:43 -0400
Message-Id: <1504729728-23279-2-git-send-email-cota@braap.org>
In-Reply-To: <1504729728-23279-1-git-send-email-cota@braap.org>
References: <1504729728-23279-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [RFC 1/6] tcg: keep a pointer to the current TB in
 TCGContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>

Instead of just a copy of tb->cflags. This gives access in TCG
to other fields in TB, which will be needed when we implement
callbacks from memory accesses performed by TCG-translated code.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/tcg.h                 |  2 +-
 accel/tcg/translate-all.c |  3 ++-
 tcg/tcg-op.c              | 10 +++++-----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index cf4eeaf..86ca604 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -676,7 +676,7 @@ struct TCGContext {
     uintptr_t *tb_jmp_target_addr; /* tb->jmp_target_addr if !USE_DIRECT_JUMP */
 
     TCGRegSet reserved_regs;
-    uint32_t tb_cflags; /* cflags of the current TB */
+    const TranslationBlock *tb;
     intptr_t current_frame_offset;
     intptr_t frame_start;
     intptr_t frame_end;
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 69cc7dc..7332afc 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1600,7 +1600,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb->flags = flags;
     tb->cflags = cflags;
     tb->trace_vcpu_dstate = *cpu->trace_dstate;
-    tcg_ctx->tb_cflags = cflags;
 
 #ifdef CONFIG_PROFILER
     /* includes aborted translations because of exceptions */
@@ -1610,9 +1609,11 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 
     tcg_func_start(tcg_ctx);
 
+    tcg_ctx->tb = tb;
     tcg_ctx->cpu = ENV_GET_CPU(env);
     gen_intermediate_code(cpu, tb);
     tcg_ctx->cpu = NULL;
+    tcg_ctx->tb = NULL;
 
     trace_translate_block(tb, tb->pc, tb->tc.ptr);
 
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 2a8bf90..32449d2 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -150,7 +150,7 @@ void tcg_gen_op6(TCGContext *ctx, TCGOpcode opc, TCGArg a1, TCGArg a2,
 
 void tcg_gen_mb(TCGBar mb_type)
 {
-    if (tcg_ctx->tb_cflags & CF_PARALLEL) {
+    if (tb_cflags(tcg_ctx->tb) & CF_PARALLEL) {
         tcg_gen_op1(tcg_ctx, INDEX_op_mb, mb_type);
     }
 }
@@ -2794,7 +2794,7 @@ void tcg_gen_atomic_cmpxchg_i32(TCGv_i32 retv, TCGv addr, TCGv_i32 cmpv,
 {
     memop = tcg_canonicalize_memop(memop, 0, 0);
 
-    if (!(tcg_ctx->tb_cflags & CF_PARALLEL)) {
+    if (!(tb_cflags(tcg_ctx->tb) & CF_PARALLEL)) {
         TCGv_i32 t1 = tcg_temp_new_i32();
         TCGv_i32 t2 = tcg_temp_new_i32();
 
@@ -2838,7 +2838,7 @@ void tcg_gen_atomic_cmpxchg_i64(TCGv_i64 retv, TCGv addr, TCGv_i64 cmpv,
 {
     memop = tcg_canonicalize_memop(memop, 1, 0);
 
-    if (!(tcg_ctx->tb_cflags & CF_PARALLEL)) {
+    if (!(tb_cflags(tcg_ctx->tb) & CF_PARALLEL)) {
         TCGv_i64 t1 = tcg_temp_new_i64();
         TCGv_i64 t2 = tcg_temp_new_i64();
 
@@ -3015,7 +3015,7 @@ static void * const table_##NAME[16] = {                                \
 void tcg_gen_atomic_##NAME##_i32                                        \
     (TCGv_i32 ret, TCGv addr, TCGv_i32 val, TCGArg idx, TCGMemOp memop) \
 {                                                                       \
-    if (tcg_ctx->tb_cflags & CF_PARALLEL) {                             \
+    if (tb_cflags(tcg_ctx->tb) & CF_PARALLEL) {                         \
         do_atomic_op_i32(ret, addr, val, idx, memop, table_##NAME);     \
     } else {                                                            \
         do_nonatomic_op_i32(ret, addr, val, idx, memop, NEW,            \
@@ -3025,7 +3025,7 @@ void tcg_gen_atomic_##NAME##_i32                                        \
 void tcg_gen_atomic_##NAME##_i64                                        \
     (TCGv_i64 ret, TCGv addr, TCGv_i64 val, TCGArg idx, TCGMemOp memop) \
 {                                                                       \
-    if (tcg_ctx->tb_cflags & CF_PARALLEL) {                             \
+    if (tb_cflags(tcg_ctx->tb) & CF_PARALLEL) {                         \
         do_atomic_op_i64(ret, addr, val, idx, memop, table_##NAME);     \
     } else {                                                            \
         do_nonatomic_op_i64(ret, addr, val, idx, memop, NEW,            \
-- 
2.7.4
