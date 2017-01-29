Received: from eggs.gnu.org ([2001:4830:134:3::10]:46956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cXwix-00083O-73
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 16:09:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cXwir-0002Ck-BO
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 16:09:23 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33523)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cXwir-0002CY-54
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 16:09:17 -0500
Received: by mail-qt0-x243.google.com with SMTP id n13so53482228qtc.0
	for <qemu-devel@nongnu.org>; Sun, 29 Jan 2017 13:09:17 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 29 Jan 2017 22:09:09 +0100
Message-Id: <20170129210910.6333-7-pbonzini@redhat.com>
In-Reply-To: <20170129210910.6333-1-pbonzini@redhat.com>
References: <20170129210910.6333-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 6/7] cpu-exec: unify icount_decr and
 tcg_exit_req
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: serge.fdrv@gmail.com, peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru

The icount interrupt flag and tcg_exit_req serve almost the same
purpose, let's make them completely the same.

The former TB_EXIT_REQUESTED and TB_EXIT_ICOUNT_EXPIRED cases are
unified, since we can distinguish them from the value of the
interrupt flag.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpu-exec.c                | 68 +++++++++++++++++++++--------------------------
 include/exec/gen-icount.h | 53 +++++++++++++++++-------------------
 include/qom/cpu.h         | 15 +++++------
 qom/cpu.c                 |  2 +-
 tcg/tcg.h                 |  1 -
 translate-all.c           |  2 +-
 translate-common.c        | 13 ++++-----
 7 files changed, 69 insertions(+), 85 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index 1226362..903a834 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -185,12 +185,6 @@ static inline tcg_target_ulong cpu_tb_exec(CPUState *cpu, TranslationBlock *itb)
             cc->set_pc(cpu, last_tb->pc);
         }
     }
-    if (tb_exit == TB_EXIT_REQUESTED) {
-        /* We were asked to stop executing TBs (probably a pending
-         * interrupt. We've now stopped, so clear the flag.
-         */
-        atomic_set(&cpu->tcg_exit_req, 0);
-    }
     return ret;
 }
 
@@ -537,6 +531,7 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
                                     SyncClocks *sc)
 {
     uintptr_t ret;
+    int32_t insns_left;
 
     if (unlikely(atomic_read(&cpu->exit_request))) {
         return;
@@ -546,8 +541,15 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
     ret = cpu_tb_exec(cpu, tb);
     tb = (TranslationBlock *)(ret & ~TB_EXIT_MASK);
     *tb_exit = ret & TB_EXIT_MASK;
-    switch (*tb_exit) {
-    case TB_EXIT_REQUESTED:
+    if (*tb_exit != TB_EXIT_REQUESTED) {
+        *last_tb = tb;
+        return;
+    }
+
+    *last_tb = NULL;
+    insns_left = atomic_read(&cpu->icount_decr.u32);
+    atomic_set(&cpu->icount_decr.u16.high, 0);
+    if (insns_left < 0) {
         /* Something asked us to stop executing
          * chained TBs; just continue round the main
          * loop. Whatever requested the exit will also
@@ -559,37 +561,27 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
          * or cpu->interrupt_request.
          */
         smp_mb();
-        *last_tb = NULL;
-        break;
-    case TB_EXIT_ICOUNT_EXPIRED:
-    {
-        /* Instruction counter expired.  */
-#ifdef CONFIG_USER_ONLY
-        abort();
-#else
-        int insns_left = cpu->icount_decr.u32;
-        *last_tb = NULL;
-        if (cpu->icount_extra && insns_left >= 0) {
-            /* Refill decrementer and continue execution.  */
-            cpu->icount_extra += insns_left;
-            insns_left = MIN(0xffff, cpu->icount_extra);
-            cpu->icount_extra -= insns_left;
-            cpu->icount_decr.u16.low = insns_left;
-        } else {
-            if (insns_left > 0) {
-                /* Execute remaining instructions.  */
-                cpu_exec_nocache(cpu, insns_left, tb, false);
-                align_clocks(sc, cpu);
-            }
-            cpu->exception_index = EXCP_INTERRUPT;
-            cpu_loop_exit(cpu);
-        }
-        break;
-#endif
+        return;
     }
-    default:
-        *last_tb = tb;
-        break;
+
+    /* Instruction counter expired.  */
+    assert(use_icount);
+    if (cpu->icount_extra) {
+        /* Refill decrementer and continue execution.  */
+        cpu->icount_extra += insns_left;
+        insns_left = MIN(0xffff, cpu->icount_extra);
+        cpu->icount_extra -= insns_left;
+        cpu->icount_decr.u16.low = insns_left;
+    } else {
+        /* Execute any remaining instructions, then let the main loop
+         * handle the next event.
+         */
+        if (insns_left > 0) {
+            cpu_exec_nocache(cpu, insns_left, tb, false);
+            align_clocks(sc, cpu);
+        }
+        cpu->exception_index = EXCP_INTERRUPT;
+        cpu_loop_exit(cpu);
     }
 }
 
diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index 050de59..62d462e 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -6,58 +6,55 @@
 /* Helpers for instruction counting code generation.  */
 
 static int icount_start_insn_idx;
-static TCGLabel *icount_label;
 static TCGLabel *exitreq_label;
 
 static inline void gen_tb_start(TranslationBlock *tb)
 {
-    TCGv_i32 count, flag, imm;
+    TCGv_i32 count, imm;
 
     exitreq_label = gen_new_label();
-    flag = tcg_temp_new_i32();
-    tcg_gen_ld_i32(flag, cpu_env,
-                   offsetof(CPUState, tcg_exit_req) - ENV_OFFSET);
-    tcg_gen_brcondi_i32(TCG_COND_NE, flag, 0, exitreq_label);
-    tcg_temp_free_i32(flag);
-
-    if (!(tb->cflags & CF_USE_ICOUNT)) {
-        return;
+    if (tb->cflags & CF_USE_ICOUNT) {
+        count = tcg_temp_local_new_i32();
+    } else {
+        count = tcg_temp_new_i32();
     }
 
-    icount_label = gen_new_label();
-    count = tcg_temp_local_new_i32();
     tcg_gen_ld_i32(count, cpu_env,
                    -ENV_OFFSET + offsetof(CPUState, icount_decr.u32));
 
-    imm = tcg_temp_new_i32();
-    /* We emit a movi with a dummy immediate argument. Keep the insn index
-     * of the movi so that we later (when we know the actual insn count)
-     * can update the immediate argument with the actual insn count.  */
-    icount_start_insn_idx = tcg_op_buf_count();
-    tcg_gen_movi_i32(imm, 0xdeadbeef);
+    if (tb->cflags & CF_USE_ICOUNT) {
+        imm = tcg_temp_new_i32();
+        /* We emit a movi with a dummy immediate argument. Keep the insn index
+         * of the movi so that we later (when we know the actual insn count)
+         * can update the immediate argument with the actual insn count.  */
+        icount_start_insn_idx = tcg_op_buf_count();
+        tcg_gen_movi_i32(imm, 0xdeadbeef);
+
+        tcg_gen_sub_i32(count, count, imm);
+        tcg_temp_free_i32(imm);
+    }
+
+    tcg_gen_brcondi_i32(TCG_COND_LT, count, 0, exitreq_label);
 
-    tcg_gen_sub_i32(count, count, imm);
-    tcg_temp_free_i32(imm);
+    if (tb->cflags & CF_USE_ICOUNT) {
+        tcg_gen_st16_i32(count, cpu_env,
+                         -ENV_OFFSET + offsetof(CPUState, icount_decr.u16.low));
+    }
 
-    tcg_gen_brcondi_i32(TCG_COND_LT, count, 0, icount_label);
-    tcg_gen_st16_i32(count, cpu_env,
-                     -ENV_OFFSET + offsetof(CPUState, icount_decr.u16.low));
     tcg_temp_free_i32(count);
 }
 
 static void gen_tb_end(TranslationBlock *tb, int num_insns)
 {
-    gen_set_label(exitreq_label);
-    tcg_gen_exit_tb((uintptr_t)tb + TB_EXIT_REQUESTED);
-
     if (tb->cflags & CF_USE_ICOUNT) {
         /* Update the num_insn immediate parameter now that we know
          * the actual insn count.  */
         tcg_set_insn_param(icount_start_insn_idx, 1, num_insns);
-        gen_set_label(icount_label);
-        tcg_gen_exit_tb((uintptr_t)tb + TB_EXIT_ICOUNT_EXPIRED);
     }
 
+    gen_set_label(exitreq_label);
+    tcg_gen_exit_tb((uintptr_t)tb + TB_EXIT_REQUESTED);
+
     /* Terminate the linked list.  */
     tcg_ctx.gen_op_buf[tcg_ctx.gen_op_buf[0].prev].next = 0;
 }
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index ca4d0fb..e0b93ce 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -271,11 +271,11 @@ struct qemu_work_item;
  * @stopped: Indicates the CPU has been artificially stopped.
  * @unplug: Indicates a pending CPU unplug request.
  * @crash_occurred: Indicates the OS reported a crash (panic) for this CPU
- * @tcg_exit_req: Set to force TCG to stop executing linked TBs for this
- *           CPU and return to its top level loop.
  * @singlestep_enabled: Flags for single-stepping.
  * @icount_extra: Instructions until next timer event.
- * @icount_decr: Number of cycles left, with interrupt flag in high bit.
+ * @icount_decr: Low 16 bits: number of cycles left, only used in icount mode.
+ * High 16 bits: Set to -1 to force TCG to stop executing linked TBs for this
+ * CPU and return to its top level loop (even in non-icount mode).
  * This allows a single read-compare-cbranch-write sequence to test
  * for both decrementer underflow and exceptions.
  * @can_do_io: Nonzero if memory-mapped IO is safe. Deterministic execution
@@ -377,10 +377,6 @@ struct CPUState {
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index; /* used by alpha TCG */
     uint32_t halted; /* used by alpha, cris, ppc TCG */
-    union {
-        uint32_t u32;
-        icount_decr_u16 u16;
-    } icount_decr;
     uint32_t can_do_io;
     int32_t exception_index; /* used by m68k TCG */
 
@@ -393,7 +389,10 @@ struct CPUState {
        offset from AREG0.  Leave this field at the end so as to make the
        (absolute value) offset as small as possible.  This reduces code
        size, especially for hosts without large memory offsets.  */
-    uint32_t tcg_exit_req;
+    union {
+        uint32_t u32;
+        icount_decr_u16 u16;
+    } icount_decr;
 
     bool hax_vcpu_dirty;
     struct hax_vcpu_state *hax_vcpu;
diff --git a/qom/cpu.c b/qom/cpu.c
index e815db7..e63f4b9 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -123,7 +123,7 @@ void cpu_exit(CPUState *cpu)
     atomic_set(&cpu->exit_request, 1);
     /* Ensure cpu_exec will see the exit request after TCG has exited.  */
     smp_wmb();
-    atomic_set(&cpu->tcg_exit_req, 1);
+    atomic_set(&cpu->icount_decr.u16.high, -1);
 }
 
 int cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 631c6f6..167aa30 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -1108,7 +1108,6 @@ static inline unsigned get_mmuidx(TCGMemOpIdx oi)
 #define TB_EXIT_MASK 3
 #define TB_EXIT_IDX0 0
 #define TB_EXIT_IDX1 1
-#define TB_EXIT_ICOUNT_EXPIRED 2
 #define TB_EXIT_REQUESTED 3
 
 #ifdef HAVE_TCG_QEMU_TB_EXEC
diff --git a/translate-all.c b/translate-all.c
index 6d2fcab..b239e32 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -1958,7 +1958,7 @@ void dump_opcount_info(FILE *f, fprintf_function cpu_fprintf)
 void cpu_interrupt(CPUState *cpu, int mask)
 {
     cpu->interrupt_request |= mask;
-    cpu->tcg_exit_req = 1;
+    cpu->icount_decr.u16.high = -1;
 }
 
 /*
diff --git a/translate-common.c b/translate-common.c
index 5e989cd..77762fd 100644
--- a/translate-common.c
+++ b/translate-common.c
@@ -43,14 +43,11 @@ static void tcg_handle_interrupt(CPUState *cpu, int mask)
         return;
     }
 
-    if (use_icount) {
-        cpu->icount_decr.u16.high = 0xffff;
-        if (!cpu->can_do_io
-            && (mask & ~old_mask) != 0) {
-            cpu_abort(cpu, "Raised interrupt while not in I/O function");
-        }
-    } else {
-        cpu->tcg_exit_req = 1;
+    cpu->icount_decr.u16.high = -1;
+    if (use_icount &&
+        !cpu->can_do_io
+        && (mask & ~old_mask) != 0) {
+        cpu_abort(cpu, "Raised interrupt while not in I/O function");
     }
 }
 
-- 
2.9.3
