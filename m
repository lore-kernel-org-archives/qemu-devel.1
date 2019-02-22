Received: from eggs.gnu.org ([209.51.188.92]:48013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amagdy.afifi@gmail.com>) id 1gxDfJ-0007so-U0
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 11:27:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amagdy.afifi@gmail.com>) id 1gxDfI-0001vB-6M
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 11:27:09 -0500
From: amagdy.afifi@gmail.com
Date: Fri, 22 Feb 2019 18:25:55 +0200
Message-Id: <20190222162555.13764-2-amagdy.afifi@gmail.com>
In-Reply-To: <20190222162555.13764-1-amagdy.afifi@gmail.com>
References: <20190222162555.13764-1-amagdy.afifi@gmail.com>
Subject: [Qemu-devel] [PATCH] riscv: Add proper alignment check and pending
 'C' extension upon misa writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, mjc@sifive.com, palmer@sifive.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, amagdy.afifi@gmail.com

From: ahmed_magdy <amagdy.afifi@gmail.com>

Signed-off-by: ahmed_magdy <amagdy.afifi@gmail.com>
---
 target/riscv/cpu.h       |  2 ++
 target/riscv/csr.c       |  5 +++--
 target/riscv/translate.c | 14 ++++++++++----
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a269c07..b49bdb3 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -109,6 +109,8 @@ struct CPURISCVState {
     target_ulong gpr[32];
     uint64_t fpr[32]; /* assume both F and D extensions */
     target_ulong pc;
+    target_ulong pc_next; /* next target pc */
+    int pending_rvc;
     target_ulong load_res;
     target_ulong load_val;
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 90f6866..b0886f0 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -373,9 +373,10 @@ static int write_misa(CPURISCVState *env, int csrno, target_ulong val)
     }
 
     /* Suppress 'C' if next instruction is not aligned
-       TODO: this should check next_pc */
-    if ((val & RVC) && (GETPC() & ~3) != 0) {
+       check next target pc */
+    if ((val & RVC) && (env->pc_next & 3) != 0) {
         val &= ~RVC;
+        env->pending_rvc = 1;
     }
 
     /* misa.MXL writes are not supported by QEMU */
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 2321bba..c9d84ea 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1999,20 +1999,26 @@ static void decode_RV32_64G(DisasContext *ctx)
     }
 }
 
-static void decode_opc(DisasContext *ctx)
+static void decode_opc(DisasContext *ctx, CPUState *cpu)
 {
+    CPURISCVState *env = cpu->env_ptr;
     /* check for compressed insn */
     if (extract32(ctx->opcode, 0, 2) != 3) {
         if (!has_ext(ctx, RVC)) {
             gen_exception_illegal(ctx);
         } else {
-            ctx->pc_succ_insn = ctx->base.pc_next + 2;
+            env->pc_next = ctx->pc_succ_insn = ctx->base.pc_next + 2;
             decode_RV32_64C(ctx);
         }
     } else {
-        ctx->pc_succ_insn = ctx->base.pc_next + 4;
+        env->pc_next = ctx->pc_succ_insn = ctx->base.pc_next + 4;
         decode_RV32_64G(ctx);
     }
+    /* check pending RVC */
+    if (env->pending_rvc && ((env->pc_next & 3) != 0)) {
+        env->misa |= RVC;
+        env->pending_rvc = 0;
+    }
 }
 
 static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
@@ -2061,7 +2067,7 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     CPURISCVState *env = cpu->env_ptr;
 
     ctx->opcode = cpu_ldl_code(env, ctx->base.pc_next);
-    decode_opc(ctx);
+    decode_opc(ctx, cpu);
     ctx->base.pc_next = ctx->pc_succ_insn;
 
     if (ctx->base.is_jmp == DISAS_NEXT) {
-- 
1.9.1
