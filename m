Received: from eggs.gnu.org ([2001:4830:134:3::10]:59393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dOE-0001fy-6G
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dOC-0001W2-3g
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:14 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:32857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d5dOB-0001Vm-Tx
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:12 -0400
Received: by mail-qt0-x242.google.com with SMTP id c45so21741861qtb.0
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 12:23:11 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  2 May 2017 12:22:39 -0700
Message-Id: <20170502192300.2124-5-rth@twiddle.net>
In-Reply-To: <20170502192300.2124-1-rth@twiddle.net>
References: <20170502192300.2124-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 04/25] tcg: Introduce goto_ptr opcode and
 tcg_gen_lookup_and_goto_ptr
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

Instead of exporting goto_ptr directly to TCG frontends, export
tcg_gen_lookup_and_goto_ptr(), which calls goto_ptr with the pointer
returned by the lookup_tb_ptr() helper. This is the only use case
we have for goto_ptr and lookup_tb_ptr, so having this function is
very convenient. Furthermore, it trivially allows us to avoid calling
the lookup helper if goto_ptr is not implemented by the backend.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <1493263764-18657-2-git-send-email-cota@braap.org>
Message-Id: <1493263764-18657-3-git-send-email-cota@braap.org>
Message-Id: <1493263764-18657-4-git-send-email-cota@braap.org>
Message-Id: <1493263764-18657-5-git-send-email-cota@braap.org>
[rth: Squashed 4 related commits.]
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 cpu-exec.c               |  6 ++----
 include/exec/exec-all.h  |  2 ++
 tcg-runtime.c            | 32 ++++++++++++++++++++++++++++++++
 tcg/README               |  8 ++++++++
 tcg/aarch64/tcg-target.h |  1 +
 tcg/arm/tcg-target.h     |  1 +
 tcg/i386/tcg-target.h    |  1 +
 tcg/ia64/tcg-target.h    |  1 +
 tcg/mips/tcg-target.h    |  1 +
 tcg/ppc/tcg-target.h     |  1 +
 tcg/s390/tcg-target.h    |  1 +
 tcg/sparc/tcg-target.h   |  1 +
 tcg/tcg-op.c             | 13 +++++++++++++
 tcg/tcg-op.h             | 11 +++++++++++
 tcg/tcg-opc.h            |  1 +
 tcg/tcg-runtime.h        |  2 ++
 tcg/tcg.c                |  5 +++++
 tcg/tcg.h                |  1 +
 tcg/tci/tcg-target.h     |  1 +
 19 files changed, 86 insertions(+), 4 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index 63a56d0..5b181c1 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -309,10 +309,8 @@ static bool tb_cmp(const void *p, const void *d)
     return false;
 }
 
-static TranslationBlock *tb_htable_lookup(CPUState *cpu,
-                                          target_ulong pc,
-                                          target_ulong cs_base,
-                                          uint32_t flags)
+TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
+                                   target_ulong cs_base, uint32_t flags)
 {
     tb_page_addr_t phys_pc;
     struct tb_desc desc;
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index bcde1e6..87ae10b 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -368,6 +368,8 @@ struct TranslationBlock {
 void tb_free(TranslationBlock *tb);
 void tb_flush(CPUState *cpu);
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
+TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
+                                   target_ulong cs_base, uint32_t flags);
 
 #if defined(USE_DIRECT_JUMP)
 
diff --git a/tcg-runtime.c b/tcg-runtime.c
index 4c60c96..7fa90ce 100644
--- a/tcg-runtime.c
+++ b/tcg-runtime.c
@@ -27,6 +27,9 @@
 #include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
 #include "exec/exec-all.h"
+#include "exec/tb-hash.h"
+#include "disas/disas.h"
+#include "exec/log.h"
 
 /* 32-bit helpers */
 
@@ -141,6 +144,35 @@ uint64_t HELPER(ctpop_i64)(uint64_t arg)
     return ctpop64(arg);
 }
 
+void *HELPER(lookup_tb_ptr)(CPUArchState *env, target_ulong addr)
+{
+    CPUState *cpu = ENV_GET_CPU(env);
+    TranslationBlock *tb;
+    target_ulong cs_base, pc;
+    uint32_t flags;
+
+    tb = atomic_rcu_read(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(addr)]);
+    if (likely(tb)) {
+        cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
+        if (likely(tb->pc == addr && tb->cs_base == cs_base &&
+                   tb->flags == flags)) {
+            goto found;
+        }
+        tb = tb_htable_lookup(cpu, addr, cs_base, flags);
+        if (likely(tb)) {
+            atomic_set(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(addr)], tb);
+            goto found;
+        }
+    }
+    return tcg_ctx.code_gen_epilogue;
+ found:
+    qemu_log_mask_and_addr(CPU_LOG_EXEC, addr,
+                           "Chain %p [%d: " TARGET_FMT_lx "] %s\n",
+                           tb->tc_ptr, cpu->cpu_index, addr,
+                           lookup_symbol(addr));
+    return tb->tc_ptr;
+}
+
 void HELPER(exit_atomic)(CPUArchState *env)
 {
     cpu_loop_exit_atomic(ENV_GET_CPU(env), GETPC());
diff --git a/tcg/README b/tcg/README
index a9858c2..bf49e82 100644
--- a/tcg/README
+++ b/tcg/README
@@ -477,6 +477,14 @@ current TB was linked to this TB. Otherwise execute the next
 instructions. Only indices 0 and 1 are valid and tcg_gen_goto_tb may be issued
 at most once with each slot index per TB.
 
+* lookup_and_goto_ptr tb_addr
+
+Look up a TB address ('tb_addr') and jump to it if valid. If not valid,
+jump to the TCG epilogue to go back to the exec loop.
+
+This operation is optional. If the TCG backend does not implement the
+goto_ptr opcode, emitting this op is equivalent to emitting exit_tb(0).
+
 * qemu_ld_i32/i64 t0, t1, flags, memidx
 * qemu_st_i32/i64 t0, t1, flags, memidx
 
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 1a5ea23..b82eac4 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -77,6 +77,7 @@ typedef enum {
 #define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_extrl_i64_i32    0
 #define TCG_TARGET_HAS_extrh_i64_i32    0
+#define TCG_TARGET_HAS_goto_ptr         0
 
 #define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          1
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 75ea247..c114df7 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -123,6 +123,7 @@ extern bool use_idiv_instructions;
 #define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_div_i32          use_idiv_instructions
 #define TCG_TARGET_HAS_rem_i32          0
+#define TCG_TARGET_HAS_goto_ptr         0
 
 enum {
     TCG_AREG0 = TCG_REG_R6,
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 4275787..59d9835 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -107,6 +107,7 @@ extern bool have_popcnt;
 #define TCG_TARGET_HAS_muls2_i32        1
 #define TCG_TARGET_HAS_muluh_i32        0
 #define TCG_TARGET_HAS_mulsh_i32        0
+#define TCG_TARGET_HAS_goto_ptr         0
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extrl_i64_i32    0
diff --git a/tcg/ia64/tcg-target.h b/tcg/ia64/tcg-target.h
index 42aea03..901bb75 100644
--- a/tcg/ia64/tcg-target.h
+++ b/tcg/ia64/tcg-target.h
@@ -173,6 +173,7 @@ typedef enum {
 #define TCG_TARGET_HAS_mulsh_i64        0
 #define TCG_TARGET_HAS_extrl_i64_i32    0
 #define TCG_TARGET_HAS_extrh_i64_i32    0
+#define TCG_TARGET_HAS_goto_ptr         0
 
 #define TCG_TARGET_deposit_i32_valid(ofs, len) ((len) <= 16)
 #define TCG_TARGET_deposit_i64_valid(ofs, len) ((len) <= 16)
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index f46d64a..e3240cf 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -130,6 +130,7 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_muluh_i32        1
 #define TCG_TARGET_HAS_mulsh_i32        1
 #define TCG_TARGET_HAS_bswap32_i32      1
+#define TCG_TARGET_HAS_goto_ptr         0
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_add2_i32         0
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index abd8b3d..a9aa974 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -82,6 +82,7 @@ extern bool have_isa_3_00;
 #define TCG_TARGET_HAS_muls2_i32        0
 #define TCG_TARGET_HAS_muluh_i32        1
 #define TCG_TARGET_HAS_mulsh_i32        1
+#define TCG_TARGET_HAS_goto_ptr         0
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_add2_i32         0
diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index cbdd2a6..6b7bcfb 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -92,6 +92,7 @@ extern uint64_t s390_facilities;
 #define TCG_TARGET_HAS_mulsh_i32      0
 #define TCG_TARGET_HAS_extrl_i64_i32  0
 #define TCG_TARGET_HAS_extrh_i64_i32  0
+#define TCG_TARGET_HAS_goto_ptr       0
 
 #define TCG_TARGET_HAS_div2_i64       1
 #define TCG_TARGET_HAS_rot_i64        1
diff --git a/tcg/sparc/tcg-target.h b/tcg/sparc/tcg-target.h
index b8b74f96f..9348ddd 100644
--- a/tcg/sparc/tcg-target.h
+++ b/tcg/sparc/tcg-target.h
@@ -123,6 +123,7 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_muls2_i32        1
 #define TCG_TARGET_HAS_muluh_i32        0
 #define TCG_TARGET_HAS_mulsh_i32        0
+#define TCG_TARGET_HAS_goto_ptr         0
 
 #define TCG_TARGET_HAS_extrl_i64_i32    1
 #define TCG_TARGET_HAS_extrh_i64_i32    1
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6b1f415..660dac9 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2587,6 +2587,19 @@ void tcg_gen_goto_tb(unsigned idx)
     tcg_gen_op1i(INDEX_op_goto_tb, idx);
 }
 
+void tcg_gen_lookup_and_goto_ptr(TCGv addr)
+{
+    if (TCG_TARGET_HAS_goto_ptr) {
+        TCGv_ptr ptr = tcg_temp_new_ptr();
+
+        gen_helper_lookup_tb_ptr(ptr, tcg_ctx.tcg_env, addr);
+        tcg_gen_op1i(INDEX_op_goto_ptr, GET_TCGV_PTR(ptr));
+        tcg_temp_free_ptr(ptr);
+    } else {
+        tcg_gen_exit_tb(0);
+    }
+}
+
 static inline TCGMemOp tcg_canonicalize_memop(TCGMemOp op, bool is64, bool st)
 {
     /* Trigger the asserts within as early as possible.  */
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index c68e300..5d3278f 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -796,6 +796,17 @@ static inline void tcg_gen_exit_tb(uintptr_t val)
  */
 void tcg_gen_goto_tb(unsigned idx);
 
+/**
+ * tcg_gen_lookup_and_goto_ptr() - look up a TB and jump to it if valid
+ * @addr: Guest address of the target TB
+ *
+ * If the TB is not valid, jump to the epilogue.
+ *
+ * This operation is optional. If the TCG backend does not implement goto_ptr,
+ * this op is equivalent to calling tcg_gen_exit_tb() with 0 as the argument.
+ */
+void tcg_gen_lookup_and_goto_ptr(TCGv addr);
+
 #if TARGET_LONG_BITS == 32
 #define tcg_temp_new() tcg_temp_new_i32()
 #define tcg_global_reg_new tcg_global_reg_new_i32
diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index f06f894..956fb1e 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -193,6 +193,7 @@ DEF(insn_start, 0, 0, TLADDR_ARGS * TARGET_INSN_START_WORDS,
     TCG_OPF_NOT_PRESENT)
 DEF(exit_tb, 0, 0, 1, TCG_OPF_BB_END)
 DEF(goto_tb, 0, 0, 1, TCG_OPF_BB_END)
+DEF(goto_ptr, 0, 1, 0, TCG_OPF_BB_END | IMPL(TCG_TARGET_HAS_goto_ptr))
 
 DEF(qemu_ld_i32, 1, TLADDR_ARGS, 1,
     TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
diff --git a/tcg/tcg-runtime.h b/tcg/tcg-runtime.h
index 114ea6f..c41d38a 100644
--- a/tcg/tcg-runtime.h
+++ b/tcg/tcg-runtime.h
@@ -24,6 +24,8 @@ DEF_HELPER_FLAGS_1(clrsb_i64, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_FLAGS_1(ctpop_i32, TCG_CALL_NO_RWG_SE, i32, i32)
 DEF_HELPER_FLAGS_1(ctpop_i64, TCG_CALL_NO_RWG_SE, i64, i64)
 
+DEF_HELPER_FLAGS_2(lookup_tb_ptr, TCG_CALL_NO_WG_SE, ptr, env, tl)
+
 DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
 
 #ifdef CONFIG_SOFTMMU
diff --git a/tcg/tcg.c b/tcg/tcg.c
index cb898f1..564292f 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -424,6 +424,11 @@ void tcg_prologue_init(TCGContext *s)
         qemu_log_unlock();
     }
 #endif
+
+    /* Assert that goto_ptr is implemented completely.  */
+    if (TCG_TARGET_HAS_goto_ptr) {
+        tcg_debug_assert(s->code_gen_epilogue != NULL);
+    }
 }
 
 void tcg_func_start(TCGContext *s)
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 6c216bb..5ec48d1 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -699,6 +699,7 @@ struct TCGContext {
        extension that allows arithmetic on void*.  */
     int code_gen_max_blocks;
     void *code_gen_prologue;
+    void *code_gen_epilogue;
     void *code_gen_buffer;
     size_t code_gen_buffer_size;
     void *code_gen_ptr;
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 838bf3a..0696328 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -85,6 +85,7 @@
 #define TCG_TARGET_HAS_muls2_i32        0
 #define TCG_TARGET_HAS_muluh_i32        0
 #define TCG_TARGET_HAS_mulsh_i32        0
+#define TCG_TARGET_HAS_goto_ptr         0
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extrl_i64_i32    0
-- 
2.9.3
