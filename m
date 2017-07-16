Received: from eggs.gnu.org ([2001:4830:134:3::10]:46232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmc-0001Ax-2J
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmW-0008MW-4q
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:49 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42111)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dWpmW-0008KE-1G
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:44 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 16 Jul 2017 16:04:04 -0400
Message-Id: <1500235468-15341-22-git-send-email-cota@braap.org>
In-Reply-To: <1500235468-15341-1-git-send-email-cota@braap.org>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 21/45] tcg: check CF_PARALLEL instead of
 parallel_cpus
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

Thereby decoupling the resulting translated code from the current state
of the system.

The tb->cflags field is not passed to tcg generation functions. So
we add a bit to TCGContext, storing there whether CF_PARALLEL is set
before translating every TB.

Most architectures have <= 32 registers, which results in a 4-byte hole
in TCGContext. Use this hole for the bit we need; use a uint8_t instead
of a bool, since a bool might take more than one byte in some systems.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/tcg.h                 |  1 +
 accel/tcg/translate-all.c |  1 +
 tcg/tcg-op.c              | 10 +++++-----
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 96872f8..bd1fdfa 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -656,6 +656,7 @@ struct TCGContext {
     uintptr_t *tb_jmp_target_addr; /* tb->jmp_target_addr if !USE_DIRECT_JUMP */
 
     TCGRegSet reserved_regs;
+    uint8_t cf_parallel; /* whether CF_PARALLEL is set in tb->cflags */
     intptr_t current_frame_offset;
     intptr_t frame_start;
     intptr_t frame_end;
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 483248f..80ac85a 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1275,6 +1275,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb->flags = flags;
     tb->cflags = cflags;
     tb->trace_vcpu_dstate = *cpu->trace_dstate;
+    tcg_ctx.cf_parallel = !!(cflags & CF_PARALLEL);
 
 #ifdef CONFIG_PROFILER
     tcg_ctx.tb_count1++; /* includes aborted translations because of
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 205d07f..ef420d4 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -150,7 +150,7 @@ void tcg_gen_op6(TCGContext *ctx, TCGOpcode opc, TCGArg a1, TCGArg a2,
 
 void tcg_gen_mb(TCGBar mb_type)
 {
-    if (parallel_cpus) {
+    if (tcg_ctx.cf_parallel) {
         tcg_gen_op1(&tcg_ctx, INDEX_op_mb, mb_type);
     }
 }
@@ -2794,7 +2794,7 @@ void tcg_gen_atomic_cmpxchg_i32(TCGv_i32 retv, TCGv addr, TCGv_i32 cmpv,
 {
     memop = tcg_canonicalize_memop(memop, 0, 0);
 
-    if (!parallel_cpus) {
+    if (!tcg_ctx.cf_parallel) {
         TCGv_i32 t1 = tcg_temp_new_i32();
         TCGv_i32 t2 = tcg_temp_new_i32();
 
@@ -2838,7 +2838,7 @@ void tcg_gen_atomic_cmpxchg_i64(TCGv_i64 retv, TCGv addr, TCGv_i64 cmpv,
 {
     memop = tcg_canonicalize_memop(memop, 1, 0);
 
-    if (!parallel_cpus) {
+    if (!tcg_ctx.cf_parallel) {
         TCGv_i64 t1 = tcg_temp_new_i64();
         TCGv_i64 t2 = tcg_temp_new_i64();
 
@@ -3015,7 +3015,7 @@ static void * const table_##NAME[16] = {                                \
 void tcg_gen_atomic_##NAME##_i32                                        \
     (TCGv_i32 ret, TCGv addr, TCGv_i32 val, TCGArg idx, TCGMemOp memop) \
 {                                                                       \
-    if (parallel_cpus) {                                                \
+    if (tcg_ctx.cf_parallel) {                                          \
         do_atomic_op_i32(ret, addr, val, idx, memop, table_##NAME);     \
     } else {                                                            \
         do_nonatomic_op_i32(ret, addr, val, idx, memop, NEW,            \
@@ -3025,7 +3025,7 @@ void tcg_gen_atomic_##NAME##_i32                                        \
 void tcg_gen_atomic_##NAME##_i64                                        \
     (TCGv_i64 ret, TCGv addr, TCGv_i64 val, TCGArg idx, TCGMemOp memop) \
 {                                                                       \
-    if (parallel_cpus) {                                                \
+    if (tcg_ctx.cf_parallel) {                                          \
         do_atomic_op_i64(ret, addr, val, idx, memop, table_##NAME);     \
     } else {                                                            \
         do_nonatomic_op_i64(ret, addr, val, idx, memop, NEW,            \
-- 
2.7.4
