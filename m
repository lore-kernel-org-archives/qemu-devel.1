Received: from eggs.gnu.org ([2001:4830:134:3::10]:59367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVPV-0003mJ-0H
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVPS-0002zD-78
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:32 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:33513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddVPR-0002x8-UO
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:30 -0400
Received: by mail-pf0-x242.google.com with SMTP id c65so872732pfl.0
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 22:44:29 -0700 (PDT)
Received: from bigtime.twiddle.net (97-126-108-236.tukw.qwest.net.
	[97.126.108.236]) by smtp.gmail.com with ESMTPSA id
	o14sm1061063pfi.158.2017.08.03.22.44.27 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 03 Aug 2017 22:44:27 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  3 Aug 2017 22:44:04 -0700
Message-Id: <20170804054426.10590-2-rth@twiddle.net>
In-Reply-To: <20170804054426.10590-1-rth@twiddle.net>
References: <20170804054426.10590-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH for-2.11 01/23] tcg: Move USE_DIRECT_JUMP
 discriminator to tcg/cpu/tcg-target.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Replace the USE_DIRECT_JUMP ifdef with a TCG_TARGET_HAS_direct_jump
boolean test.  Replace the tb_set_jmp_target1 ifdef with an unconditional
function tb_target_set_jmp_target.

While we're touching all backends, add a parameter for tb->tc_ptr;
we're going to need it shortly for some backends.

Move tb_set_jmp_target and tb_add_jump from exec-all.h to cpu-exec.c.

This opens the possibility for TCG_TARGET_HAS_direct_jump to be
a runtime decision -- based on host cpu capabilities, the size of
code_gen_buffer, or a future debugging switch.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 include/exec/exec-all.h      | 95 ++------------------------------------------
 tcg/aarch64/tcg-target.h     |  3 ++
 tcg/arm/tcg-target.h         |  4 ++
 tcg/i386/tcg-target.h        |  9 +++++
 tcg/ia64/tcg-target.h        |  4 ++
 tcg/mips/tcg-target.h        |  3 ++
 tcg/ppc/tcg-target.h         |  2 +
 tcg/s390/tcg-target.h        | 10 +++++
 tcg/sparc/tcg-target.h       |  3 ++
 tcg/tcg.h                    |  4 +-
 tcg/tci/tcg-target.h         |  9 +++++
 accel/tcg/cpu-exec.c         | 35 ++++++++++++++++
 accel/tcg/translate-all.c    | 14 +++----
 tcg/aarch64/tcg-target.inc.c | 13 +++---
 tcg/mips/tcg-target.inc.c    |  3 +-
 tcg/ppc/tcg-target.inc.c     |  6 ++-
 tcg/sparc/tcg-target.inc.c   |  3 +-
 17 files changed, 107 insertions(+), 113 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 440fc31b37..aff4d33e3c 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -330,15 +330,6 @@ static inline void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr)
 #define CODE_GEN_AVG_BLOCK_SIZE 150
 #endif
 
-#if defined(_ARCH_PPC) \
-    || defined(__x86_64__) || defined(__i386__) \
-    || defined(__sparc__) || defined(__aarch64__) \
-    || defined(__s390x__) || defined(__mips__) \
-    || defined(CONFIG_TCG_INTERPRETER)
-/* NOTE: Direct jump patching must be atomic to be thread-safe. */
-#define USE_DIRECT_JUMP
-#endif
-
 struct TranslationBlock {
     target_ulong pc;   /* simulated PC corresponding to this block (EIP + CS base) */
     target_ulong cs_base; /* CS base for this block */
@@ -376,11 +367,8 @@ struct TranslationBlock {
      */
     uint16_t jmp_reset_offset[2]; /* offset of original jump target */
 #define TB_JMP_RESET_OFFSET_INVALID 0xffff /* indicates no jump generated */
-#ifdef USE_DIRECT_JUMP
-    uint16_t jmp_insn_offset[2]; /* offset of native jump instruction */
-#else
-    uintptr_t jmp_target_addr[2]; /* target address for indirect jump */
-#endif
+    uintptr_t jmp_target_arg[2];  /* target address or offset */
+
     /* Each TB has an assosiated circular list of TBs jumping to this one.
      * jmp_list_first points to the first TB jumping to this one.
      * jmp_list_next is used to point to the next TB in a list.
@@ -402,84 +390,7 @@ void tb_flush(CPUState *cpu);
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
                                    target_ulong cs_base, uint32_t flags);
-
-#if defined(USE_DIRECT_JUMP)
-
-#if defined(CONFIG_TCG_INTERPRETER)
-static inline void tb_set_jmp_target1(uintptr_t jmp_addr, uintptr_t addr)
-{
-    /* patch the branch destination */
-    atomic_set((int32_t *)jmp_addr, addr - (jmp_addr + 4));
-    /* no need to flush icache explicitly */
-}
-#elif defined(_ARCH_PPC)
-void ppc_tb_set_jmp_target(uintptr_t jmp_addr, uintptr_t addr);
-#define tb_set_jmp_target1 ppc_tb_set_jmp_target
-#elif defined(__i386__) || defined(__x86_64__)
-static inline void tb_set_jmp_target1(uintptr_t jmp_addr, uintptr_t addr)
-{
-    /* patch the branch destination */
-    atomic_set((int32_t *)jmp_addr, addr - (jmp_addr + 4));
-    /* no need to flush icache explicitly */
-}
-#elif defined(__s390x__)
-static inline void tb_set_jmp_target1(uintptr_t jmp_addr, uintptr_t addr)
-{
-    /* patch the branch destination */
-    intptr_t disp = addr - (jmp_addr - 2);
-    atomic_set((int32_t *)jmp_addr, disp / 2);
-    /* no need to flush icache explicitly */
-}
-#elif defined(__aarch64__)
-void aarch64_tb_set_jmp_target(uintptr_t jmp_addr, uintptr_t addr);
-#define tb_set_jmp_target1 aarch64_tb_set_jmp_target
-#elif defined(__sparc__) || defined(__mips__)
-void tb_set_jmp_target1(uintptr_t jmp_addr, uintptr_t addr);
-#else
-#error tb_set_jmp_target1 is missing
-#endif
-
-static inline void tb_set_jmp_target(TranslationBlock *tb,
-                                     int n, uintptr_t addr)
-{
-    uint16_t offset = tb->jmp_insn_offset[n];
-    tb_set_jmp_target1((uintptr_t)(tb->tc_ptr + offset), addr);
-}
-
-#else
-
-/* set the jump target */
-static inline void tb_set_jmp_target(TranslationBlock *tb,
-                                     int n, uintptr_t addr)
-{
-    tb->jmp_target_addr[n] = addr;
-}
-
-#endif
-
-/* Called with tb_lock held.  */
-static inline void tb_add_jump(TranslationBlock *tb, int n,
-                               TranslationBlock *tb_next)
-{
-    assert(n < ARRAY_SIZE(tb->jmp_list_next));
-    if (tb->jmp_list_next[n]) {
-        /* Another thread has already done this while we were
-         * outside of the lock; nothing to do in this case */
-        return;
-    }
-    qemu_log_mask_and_addr(CPU_LOG_EXEC, tb->pc,
-                           "Linking TBs %p [" TARGET_FMT_lx
-                           "] index %d -> %p [" TARGET_FMT_lx "]\n",
-                           tb->tc_ptr, tb->pc, n,
-                           tb_next->tc_ptr, tb_next->pc);
-
-    /* patch the native jump address */
-    tb_set_jmp_target(tb, n, (uintptr_t)tb_next->tc_ptr);
-
-    /* add in TB jmp circular list */
-    tb->jmp_list_next[n] = tb_next->jmp_list_first;
-    tb_next->jmp_list_first = (uintptr_t)tb | n;
-}
+void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr);
 
 /* GETPC is the true target of the return instruction that we'll execute.  */
 #if defined(CONFIG_TCG_INTERPRETER)
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 55a46ac825..3c3b1e603d 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -111,10 +111,13 @@ typedef enum {
 #define TCG_TARGET_HAS_muls2_i64        0
 #define TCG_TARGET_HAS_muluh_i64        1
 #define TCG_TARGET_HAS_mulsh_i64        1
+#define TCG_TARGET_HAS_direct_jump      1
 
 static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
 {
     __builtin___clear_cache((char *)start, (char *)stop);
 }
 
+void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
+
 #endif /* AARCH64_TCG_TARGET_H */
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 5ef1086710..b836f7f127 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -124,6 +124,7 @@ extern bool use_idiv_instructions;
 #define TCG_TARGET_HAS_div_i32          use_idiv_instructions
 #define TCG_TARGET_HAS_rem_i32          0
 #define TCG_TARGET_HAS_goto_ptr         1
+#define TCG_TARGET_HAS_direct_jump      0
 
 enum {
     TCG_AREG0 = TCG_REG_R6,
@@ -134,4 +135,7 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
     __builtin___clear_cache((char *) start, (char *) stop);
 }
 
+/* not defined -- call should be eliminated at compile time */
+void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
+
 #endif
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 73a15f7e80..2fd28fa6a5 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -108,6 +108,7 @@ extern bool have_popcnt;
 #define TCG_TARGET_HAS_muluh_i32        0
 #define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_goto_ptr         1
+#define TCG_TARGET_HAS_direct_jump      1
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extrl_i64_i32    0
@@ -166,6 +167,14 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
 {
 }
 
+static inline void tb_target_set_jmp_target(uintptr_t tc_ptr,
+                                            uintptr_t jmp_addr, uintptr_t addr)
+{
+    /* patch the branch destination */
+    atomic_set((int32_t *)jmp_addr, addr - (jmp_addr + 4));
+    /* no need to flush icache explicitly */
+}
+
 /* This defines the natural memory order supported by this
  * architecture before guarantees made by various barrier
  * instructions.
diff --git a/tcg/ia64/tcg-target.h b/tcg/ia64/tcg-target.h
index 901bb7575d..5c9ca8c1ce 100644
--- a/tcg/ia64/tcg-target.h
+++ b/tcg/ia64/tcg-target.h
@@ -174,6 +174,7 @@ typedef enum {
 #define TCG_TARGET_HAS_extrl_i64_i32    0
 #define TCG_TARGET_HAS_extrh_i64_i32    0
 #define TCG_TARGET_HAS_goto_ptr         0
+#define TCG_TARGET_HAS_direct_jump      0
 
 #define TCG_TARGET_deposit_i32_valid(ofs, len) ((len) <= 16)
 #define TCG_TARGET_deposit_i64_valid(ofs, len) ((len) <= 16)
@@ -195,4 +196,7 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
     asm volatile (";;sync.i;;srlz.i;;");
 }
 
+/* not defined -- call should be eliminated at compile time */
+void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
+
 #endif
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index d75cb63ed3..557c8ddc46 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -131,6 +131,7 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_mulsh_i32        1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_goto_ptr         1
+#define TCG_TARGET_HAS_direct_jump      1
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_add2_i32         0
@@ -206,4 +207,6 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
     cacheflush ((void *)start, stop-start, ICACHE);
 }
 
+void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
+
 #endif
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 5f4a40a5b4..5bab3387e5 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -83,6 +83,7 @@ extern bool have_isa_3_00;
 #define TCG_TARGET_HAS_muluh_i32        1
 #define TCG_TARGET_HAS_mulsh_i32        1
 #define TCG_TARGET_HAS_goto_ptr         1
+#define TCG_TARGET_HAS_direct_jump      1
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_add2_i32         0
@@ -124,5 +125,6 @@ extern bool have_isa_3_00;
 #endif
 
 void flush_icache_range(uintptr_t start, uintptr_t stop);
+void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
 
 #endif
diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index 81fc179459..1398952d6b 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -95,6 +95,7 @@ extern uint64_t s390_facilities;
 #define TCG_TARGET_HAS_extrl_i64_i32  0
 #define TCG_TARGET_HAS_extrh_i64_i32  0
 #define TCG_TARGET_HAS_goto_ptr       1
+#define TCG_TARGET_HAS_direct_jump    1
 
 #define TCG_TARGET_HAS_div2_i64       1
 #define TCG_TARGET_HAS_rot_i64        1
@@ -143,4 +144,13 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
 {
 }
 
+static inline void tb_target_set_jmp_target(uintptr_t tc_ptr,
+                                            uintptr_t jmp_addr, uintptr_t addr)
+{
+    /* patch the branch destination */
+    intptr_t disp = addr - (jmp_addr - 2);
+    atomic_set((int32_t *)jmp_addr, disp / 2);
+    /* no need to flush icache explicitly */
+}
+
 #endif
diff --git a/tcg/sparc/tcg-target.h b/tcg/sparc/tcg-target.h
index 854a0afd70..3ac0bd33d3 100644
--- a/tcg/sparc/tcg-target.h
+++ b/tcg/sparc/tcg-target.h
@@ -124,6 +124,7 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_muluh_i32        0
 #define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_goto_ptr         1
+#define TCG_TARGET_HAS_direct_jump      1
 
 #define TCG_TARGET_HAS_extrl_i64_i32    1
 #define TCG_TARGET_HAS_extrh_i64_i32    1
@@ -170,4 +171,6 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
     }
 }
 
+void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
+
 #endif
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 17b7750ee6..46957d9bd7 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -652,8 +652,8 @@ struct TCGContext {
     /* goto_tb support */
     tcg_insn_unit *code_buf;
     uint16_t *tb_jmp_reset_offset; /* tb->jmp_reset_offset */
-    uint16_t *tb_jmp_insn_offset; /* tb->jmp_insn_offset if USE_DIRECT_JUMP */
-    uintptr_t *tb_jmp_target_addr; /* tb->jmp_target_addr if !USE_DIRECT_JUMP */
+    uintptr_t *tb_jmp_insn_offset; /* tb->jmp_target_arg if direct_jump */
+    uintptr_t *tb_jmp_target_addr; /* tb->jmp_target_arg if !direct_jump */
 
     TCGRegSet reserved_regs;
     intptr_t current_frame_offset;
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 06963288dc..036e8049c8 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -86,6 +86,7 @@
 #define TCG_TARGET_HAS_muluh_i32        0
 #define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_goto_ptr         0
+#define TCG_TARGET_HAS_direct_jump      1
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extrl_i64_i32    0
@@ -192,4 +193,12 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
 {
 }
 
+static inline void tb_target_set_jmp_target(uintptr_t tc_ptr,
+                                            uintptr_t jmp_addr, uintptr_t addr)
+{
+    /* patch the branch destination */
+    atomic_set((int32_t *)jmp_addr, addr - (jmp_addr + 4));
+    /* no need to flush icache explicitly */
+}
+
 #endif /* TCG_TARGET_H */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index d84b01d1b8..ff6866624a 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -329,6 +329,41 @@ TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
     return qht_lookup(&tcg_ctx.tb_ctx.htable, tb_cmp, &desc, h);
 }
 
+void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr)
+{
+    if (TCG_TARGET_HAS_direct_jump) {
+        uintptr_t offset = tb->jmp_target_arg[n];
+        uintptr_t tc_ptr = (uintptr_t)tb->tc_ptr;
+        tb_target_set_jmp_target(tc_ptr, tc_ptr + offset, addr);
+    } else {
+        tb->jmp_target_arg[n] = addr;
+    }
+}
+
+/* Called with tb_lock held.  */
+static inline void tb_add_jump(TranslationBlock *tb, int n,
+                               TranslationBlock *tb_next)
+{
+    assert(n < ARRAY_SIZE(tb->jmp_list_next));
+    if (tb->jmp_list_next[n]) {
+        /* Another thread has already done this while we were
+         * outside of the lock; nothing to do in this case */
+        return;
+    }
+    qemu_log_mask_and_addr(CPU_LOG_EXEC, tb->pc,
+                           "Linking TBs %p [" TARGET_FMT_lx
+                           "] index %d -> %p [" TARGET_FMT_lx "]\n",
+                           tb->tc_ptr, tb->pc, n,
+                           tb_next->tc_ptr, tb_next->pc);
+
+    /* patch the native jump address */
+    tb_set_jmp_target(tb, n, (uintptr_t)tb_next->tc_ptr);
+
+    /* add in TB jmp circular list */
+    tb->jmp_list_next[n] = tb_next->jmp_list_first;
+    tb_next->jmp_list_first = (uintptr_t)tb | n;
+}
+
 static inline TranslationBlock *tb_find(CPUState *cpu,
                                         TranslationBlock *last_tb,
                                         int tb_exit)
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 37ecafa931..93a1cf2ba8 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1289,13 +1289,13 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb->jmp_reset_offset[0] = TB_JMP_RESET_OFFSET_INVALID;
     tb->jmp_reset_offset[1] = TB_JMP_RESET_OFFSET_INVALID;
     tcg_ctx.tb_jmp_reset_offset = tb->jmp_reset_offset;
-#ifdef USE_DIRECT_JUMP
-    tcg_ctx.tb_jmp_insn_offset = tb->jmp_insn_offset;
-    tcg_ctx.tb_jmp_target_addr = NULL;
-#else
-    tcg_ctx.tb_jmp_insn_offset = NULL;
-    tcg_ctx.tb_jmp_target_addr = tb->jmp_target_addr;
-#endif
+    if (TCG_TARGET_HAS_direct_jump) {
+        tcg_ctx.tb_jmp_insn_offset = tb->jmp_target_arg;
+        tcg_ctx.tb_jmp_target_addr = NULL;
+    } else {
+        tcg_ctx.tb_jmp_insn_offset = NULL;
+        tcg_ctx.tb_jmp_target_addr = tb->jmp_target_arg;
+    }
 
 #ifdef CONFIG_PROFILER
     tcg_ctx.tb_count++;
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 04bc369a92..a1e5dd2f03 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -871,9 +871,8 @@ static inline void tcg_out_call(TCGContext *s, tcg_insn_unit *target)
     }
 }
 
-#ifdef USE_DIRECT_JUMP
-
-void aarch64_tb_set_jmp_target(uintptr_t jmp_addr, uintptr_t addr)
+void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
+                              uintptr_t addr)
 {
     tcg_insn_unit i1, i2;
     TCGType rt = TCG_TYPE_I64;
@@ -898,8 +897,6 @@ void aarch64_tb_set_jmp_target(uintptr_t jmp_addr, uintptr_t addr)
     flush_icache_range(jmp_addr, jmp_addr + 8);
 }
 
-#endif
-
 static inline void tcg_out_goto_label(TCGContext *s, TCGLabel *l)
 {
     if (!l->has_value) {
@@ -1412,7 +1409,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
     case INDEX_op_goto_tb:
         if (s->tb_jmp_insn_offset != NULL) {
-            /* USE_DIRECT_JUMP */
+            /* TCG_TARGET_HAS_direct_jump */
             /* Ensure that ADRP+ADD are 8-byte aligned so that an atomic
                write can be used to patch the target address. */
             if ((uintptr_t)s->code_ptr & 7) {
@@ -1420,11 +1417,11 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
             }
             s->tb_jmp_insn_offset[a0] = tcg_current_code_size(s);
             /* actual branch destination will be patched by
-               aarch64_tb_set_jmp_target later. */
+               tb_target_set_jmp_target later. */
             tcg_out_insn(s, 3406, ADRP, TCG_REG_TMP, 0);
             tcg_out_insn(s, 3401, ADDI, TCG_TYPE_I64, TCG_REG_TMP, TCG_REG_TMP, 0);
         } else {
-            /* !USE_DIRECT_JUMP */
+            /* !TCG_TARGET_HAS_direct_jump */
             tcg_debug_assert(s->tb_jmp_target_addr != NULL);
             intptr_t offset = tcg_pcrel_diff(s, (s->tb_jmp_target_addr + a0)) >> 2;
             tcg_out_insn(s, 3305, LDR, offset, TCG_REG_TMP);
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 1a8169f5fc..04f8c839fe 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -2642,7 +2642,8 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_GP);   /* global pointer */
 }
 
-void tb_set_jmp_target1(uintptr_t jmp_addr, uintptr_t addr)
+void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
+                              uintptr_t addr)
 {
     atomic_set((uint32_t *)jmp_addr, deposit32(OPC_J, 0, 26, addr >> 2));
     flush_icache_range(jmp_addr, jmp_addr + 4);
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 1f690df20d..018c240f6d 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -1296,7 +1296,8 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
 }
 
 #ifdef __powerpc64__
-void ppc_tb_set_jmp_target(uintptr_t jmp_addr, uintptr_t addr)
+void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
+                              uintptr_t addr)
 {
     tcg_insn_unit i1, i2;
     uint64_t pair;
@@ -1328,7 +1329,8 @@ void ppc_tb_set_jmp_target(uintptr_t jmp_addr, uintptr_t addr)
     flush_icache_range(jmp_addr, jmp_addr + 8);
 }
 #else
-void ppc_tb_set_jmp_target(uintptr_t jmp_addr, uintptr_t addr)
+void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
+                              uintptr_t addr)
 {
     intptr_t diff = addr - jmp_addr;
     tcg_debug_assert(in_range_b(diff));
diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
index 18afce2f87..06cabbedf5 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc.c
@@ -1708,7 +1708,8 @@ void tcg_register_jit(void *buf, size_t buf_size)
     tcg_register_jit_int(buf, buf_size, &debug_frame, sizeof(debug_frame));
 }
 
-void tb_set_jmp_target1(uintptr_t jmp_addr, uintptr_t addr)
+void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
+                              uintptr_t addr)
 {
     uint32_t *ptr = (uint32_t *)jmp_addr;
     uintptr_t disp = addr - jmp_addr;
-- 
2.13.3
