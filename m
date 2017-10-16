Received: from eggs.gnu.org ([2001:4830:134:3::10]:52678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49AS-0002ik-IQ
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:27:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49AM-0003og-KV
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:27:08 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:47624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e49AM-0003nm-Ep
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:27:02 -0400
Received: by mail-pg0-x232.google.com with SMTP id r25so7349314pgn.4
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 10:27:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 16 Oct 2017 10:25:53 -0700
Message-Id: <20171016172609.23422-35-richard.henderson@linaro.org>
In-Reply-To: <20171016172609.23422-1-richard.henderson@linaro.org>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 34/50] tcg: check CF_PARALLEL instead of
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
Cc: cota@braap.org

From: "Emilio G. Cota" <cota@braap.org>

Thereby decoupling the resulting translated code from the current state
of the system.

The tb->cflags field is not passed to tcg generation functions. So
we add a field to TCGContext, storing there a copy of tb->cflags.

Most architectures have <= 32 registers, which results in a 4-byte hole
in TCGContext. Use this hole for the new field.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/tcg.h                 |  1 +
 accel/tcg/translate-all.c |  1 +
 tcg/tcg-op.c              | 10 +++++-----
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 5e1170b299..6736a9fe2e 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -656,6 +656,7 @@ struct TCGContext {
     uintptr_t *tb_jmp_target_addr; /* tb->jmp_target_arg if !direct_jump */
 
     TCGRegSet reserved_regs;
+    uint32_t tb_cflags; /* cflags of the current TB */
     intptr_t current_frame_offset;
     intptr_t frame_start;
     intptr_t frame_end;
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index a7415c8661..d3dee985b4 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1296,6 +1296,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb->flags = flags;
     tb->cflags = cflags;
     tb->trace_vcpu_dstate = *cpu->trace_dstate;
+    tcg_ctx.tb_cflags = cflags;
 
 #ifdef CONFIG_PROFILER
     tcg_ctx.tb_count1++; /* includes aborted translations because of
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index be4b623e82..3253451115 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -121,7 +121,7 @@ void tcg_gen_op6(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
 
 void tcg_gen_mb(TCGBar mb_type)
 {
-    if (parallel_cpus) {
+    if (tcg_ctx.tb_cflags & CF_PARALLEL) {
         tcg_gen_op1(INDEX_op_mb, mb_type);
     }
 }
@@ -2780,7 +2780,7 @@ void tcg_gen_atomic_cmpxchg_i32(TCGv_i32 retv, TCGv addr, TCGv_i32 cmpv,
 {
     memop = tcg_canonicalize_memop(memop, 0, 0);
 
-    if (!parallel_cpus) {
+    if (!(tcg_ctx.tb_cflags & CF_PARALLEL)) {
         TCGv_i32 t1 = tcg_temp_new_i32();
         TCGv_i32 t2 = tcg_temp_new_i32();
 
@@ -2824,7 +2824,7 @@ void tcg_gen_atomic_cmpxchg_i64(TCGv_i64 retv, TCGv addr, TCGv_i64 cmpv,
 {
     memop = tcg_canonicalize_memop(memop, 1, 0);
 
-    if (!parallel_cpus) {
+    if (!(tcg_ctx.tb_cflags & CF_PARALLEL)) {
         TCGv_i64 t1 = tcg_temp_new_i64();
         TCGv_i64 t2 = tcg_temp_new_i64();
 
@@ -3001,7 +3001,7 @@ static void * const table_##NAME[16] = {                                \
 void tcg_gen_atomic_##NAME##_i32                                        \
     (TCGv_i32 ret, TCGv addr, TCGv_i32 val, TCGArg idx, TCGMemOp memop) \
 {                                                                       \
-    if (parallel_cpus) {                                                \
+    if (tcg_ctx.tb_cflags & CF_PARALLEL) {                              \
         do_atomic_op_i32(ret, addr, val, idx, memop, table_##NAME);     \
     } else {                                                            \
         do_nonatomic_op_i32(ret, addr, val, idx, memop, NEW,            \
@@ -3011,7 +3011,7 @@ void tcg_gen_atomic_##NAME##_i32                                        \
 void tcg_gen_atomic_##NAME##_i64                                        \
     (TCGv_i64 ret, TCGv addr, TCGv_i64 val, TCGArg idx, TCGMemOp memop) \
 {                                                                       \
-    if (parallel_cpus) {                                                \
+    if (tcg_ctx.tb_cflags & CF_PARALLEL) {                              \
         do_atomic_op_i64(ret, addr, val, idx, memop, table_##NAME);     \
     } else {                                                            \
         do_nonatomic_op_i64(ret, addr, val, idx, memop, NEW,            \
-- 
2.13.6
