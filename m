Received: from eggs.gnu.org ([2001:4830:134:3::10]:52403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq5UK-0003Ib-0A
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq5UE-0008Pu-43
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:32 -0400
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b]:35578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq5UD-0008PQ-RX
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:26 -0400
Received: by mail-pg0-x22b.google.com with SMTP id 188so1820206pgb.2
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 15:41:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Sep 2017 15:40:49 -0700
Message-Id: <20170907224051.21518-22-richard.henderson@linaro.org>
In-Reply-To: <20170907224051.21518-1-richard.henderson@linaro.org>
References: <20170907224051.21518-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 21/23] tcg/ppc: Change TCG_REG_RA to TCG_REG_TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

At this point the conversion is a wash.  Loading of TB+ofs is
smaller, but the actual return address from exit_tb is larger.
There are a few more insns required to transition between TBs.

But the expectation is that accesses to the constant pool will
on the whole be smaller.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/ppc/tcg-target.inc.c | 273 +++++++++++++++++++++--------------------------
 1 file changed, 122 insertions(+), 151 deletions(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index d772faf7be..bc14d2c9c6 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -39,29 +39,8 @@
 # define TCG_REG_TMP1   TCG_REG_R12
 #endif
 
-/* For the 64-bit target, we don't like the 5 insn sequence needed to build
-   full 64-bit addresses.  Better to have a base register to which we can
-   apply a 32-bit displacement.
-
-   There are generally three items of interest:
-   (1) helper functions in the main executable,
-   (2) TranslationBlock data structures,
-   (3) the return address in the epilogue.
-
-   For user-only, we USE_STATIC_CODE_GEN_BUFFER, so the code_gen_buffer
-   will be inside the main executable, and thus near enough to make a
-   pointer to the epilogue be within 2GB of all helper functions.
-
-   For softmmu, we'll let the kernel choose the address of code_gen_buffer,
-   and odds are it'll be somewhere close to the main malloc arena, and so
-   a pointer to the epilogue will be within 2GB of the TranslationBlocks.
-
-   For --enable-pie, everything will be kinda near everything else,
-   somewhere in high memory.
-
-   Thus we choose to keep the return address in a call-saved register.  */
-#define TCG_REG_RA     TCG_REG_R31
-#define USE_REG_RA     (TCG_TARGET_REG_BITS == 64)
+#define TCG_REG_TB     TCG_REG_R31
+#define USE_REG_TB     (TCG_TARGET_REG_BITS == 64)
 
 /* Shorthand for size of a pointer.  Avoid promotion to unsigned.  */
 #define SZP  ((int)sizeof(void *))
@@ -614,50 +593,68 @@ static inline void tcg_out_shri64(TCGContext *s, TCGReg dst, TCGReg src, int c)
     tcg_out_rld(s, RLDICL, dst, src, 64 - c, c);
 }
 
-static void tcg_out_movi32(TCGContext *s, TCGReg ret, int32_t arg)
+static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
+                             tcg_target_long arg, bool in_prologue)
 {
-    if (arg == (int16_t) arg) {
+    intptr_t tb_diff;
+    int32_t high;
+
+    tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || type == TCG_TYPE_I32);
+
+    if (TCG_TARGET_REG_BITS == 64 && type == TCG_TYPE_I32) {
+        arg = (int32_t)arg;
+    }
+
+    /* Load 16-bit immediates with one insn.  */
+    if (arg == (int16_t)arg) {
         tcg_out32(s, ADDI | TAI(ret, 0, arg));
-    } else {
+        return;
+    }
+
+    /* Load addresses within the TB with one insn.  */
+    tb_diff = arg - (intptr_t)s->code_gen_ptr;
+    if (!in_prologue && USE_REG_TB && tb_diff == (int16_t)tb_diff) {
+        tcg_out32(s, ADDI | TAI(ret, TCG_REG_TB, tb_diff));
+        return;
+    }
+
+    /* Load 32-bit immediates with two insns.  */
+    if (TCG_TARGET_REG_BITS == 32 || arg == (int32_t)arg) {
         tcg_out32(s, ADDIS | TAI(ret, 0, arg >> 16));
         if (arg & 0xffff) {
             tcg_out32(s, ORI | SAI(ret, ret, arg));
         }
+        return;
     }
-}
-
-static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg ret,
-                         tcg_target_long arg)
-{
-    tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || type == TCG_TYPE_I32);
-    if (type == TCG_TYPE_I32 || arg == (int32_t)arg) {
-        tcg_out_movi32(s, ret, arg);
-    } else if (arg == (uint32_t)arg && !(arg & 0x8000)) {
+    if (arg == (uint32_t)arg && !(arg & 0x8000)) {
         tcg_out32(s, ADDI | TAI(ret, 0, arg));
         tcg_out32(s, ORIS | SAI(ret, ret, arg >> 16));
-    } else {
-        int32_t high;
+        return;
+    }
 
-        if (USE_REG_RA) {
-            intptr_t diff = arg - (intptr_t)tb_ret_addr;
-            if (diff == (int32_t)diff) {
-                tcg_out_mem_long(s, ADDI, ADD, ret, TCG_REG_RA, diff);
-                return;
-            }
-        }
+    /* Load addresses within 2GB of TB with 2 (or rarely 3) insns.  */
+    if (!in_prologue && USE_REG_TB && tb_diff == (int32_t)tb_diff) {
+        tcg_out_mem_long(s, ADDI, ADD, ret, TCG_REG_TB, tb_diff);
+        return;
+    }
 
-        high = arg >> 31 >> 1;
-        tcg_out_movi32(s, ret, high);
-        if (high) {
-            tcg_out_shli64(s, ret, ret, 32);
-        }
-        if (arg & 0xffff0000) {
-            tcg_out32(s, ORIS | SAI(ret, ret, arg >> 16));
-        }
-        if (arg & 0xffff) {
-            tcg_out32(s, ORI | SAI(ret, ret, arg));
-        }
+    high = arg >> 31 >> 1;
+    tcg_out_movi(s, TCG_TYPE_I32, ret, high);
+    if (high) {
+        tcg_out_shli64(s, ret, ret, 32);
     }
+    if (arg & 0xffff0000) {
+        tcg_out32(s, ORIS | SAI(ret, ret, arg >> 16));
+    }
+    if (arg & 0xffff) {
+        tcg_out32(s, ORI | SAI(ret, ret, arg));
+    }
+}
+
+static inline void tcg_out_movi(TCGContext *s, TCGType type, TCGReg ret,
+                                tcg_target_long arg)
+{
+    tcg_out_movi_int(s, type, ret, arg, false);
 }
 
 static bool mask_operand(uint32_t c, int *mb, int *me)
@@ -1293,49 +1290,43 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
     tcg_out32(s, insn);
 }
 
-#ifdef __powerpc64__
 void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
                               uintptr_t addr)
 {
-    tcg_insn_unit i1, i2;
-    uint64_t pair;
-    intptr_t diff = addr - jmp_addr;
-
-    if (in_range_b(diff)) {
-        i1 = B | (diff & 0x3fffffc);
-        i2 = NOP;
-    } else if (USE_REG_RA) {
-        intptr_t lo, hi;
-        diff = addr - (uintptr_t)tb_ret_addr;
-        lo = (int16_t)diff;
-        hi = (int32_t)(diff - lo);
-        tcg_debug_assert(diff == hi + lo);
-        i1 = ADDIS | TAI(TCG_REG_TMP1, TCG_REG_RA, hi >> 16);
-        i2 = ADDI | TAI(TCG_REG_TMP1, TCG_REG_TMP1, lo);
-    } else {
-        tcg_debug_assert(TCG_TARGET_REG_BITS == 32 || addr == (int32_t)addr);
-        i1 = ADDIS | TAI(TCG_REG_TMP1, 0, addr >> 16);
-        i2 = ORI | SAI(TCG_REG_TMP1, TCG_REG_TMP1, addr);
-    }
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_insn_unit i1, i2;
+        intptr_t tb_diff = addr - tc_ptr;
+        intptr_t br_diff = addr - (jmp_addr + 4);
+        uint64_t pair;
+
+        /* This does not exercise the range of the branch, but we do
+           still need to be able to load the new value of TCG_REG_TB.
+           But this does still happen quite often.  */
+        if (tb_diff == (int16_t)tb_diff) {
+            i1 = ADDI | TAI(TCG_REG_TB, TCG_REG_TB, tb_diff);
+            i2 = B | (br_diff & 0x3fffffc);
+        } else {
+            intptr_t lo = (int16_t)tb_diff;
+            intptr_t hi = (int32_t)(tb_diff - lo);
+            assert(tb_diff == hi + lo);
+            i1 = ADDIS | TAI(TCG_REG_TB, TCG_REG_TB, hi >> 16);
+            i2 = ADDI | TAI(TCG_REG_TB, TCG_REG_TB, lo);
+        }
 #ifdef HOST_WORDS_BIGENDIAN
-    pair = (uint64_t)i1 << 32 | i2;
+        pair = (uint64_t)i1 << 32 | i2;
 #else
-    pair = (uint64_t)i2 << 32 | i1;
+        pair = (uint64_t)i2 << 32 | i1;
 #endif
 
-    atomic_set((uint64_t *)jmp_addr, pair);
-    flush_icache_range(jmp_addr, jmp_addr + 8);
-}
-#else
-void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
-                              uintptr_t addr)
-{
-    intptr_t diff = addr - jmp_addr;
-    tcg_debug_assert(in_range_b(diff));
-    atomic_set((uint32_t *)jmp_addr, B | (diff & 0x3fffffc));
-    flush_icache_range(jmp_addr, jmp_addr + 4);
+        atomic_set((uint64_t *)jmp_addr, pair);
+        flush_icache_range(jmp_addr, jmp_addr + 8);
+    } else {
+        intptr_t diff = addr - jmp_addr;
+        tcg_debug_assert(in_range_b(diff));
+        atomic_set((uint32_t *)jmp_addr, B | (diff & 0x3fffffc));
+        flush_icache_range(jmp_addr, jmp_addr + 4);
+    }
 }
-#endif
 
 static void tcg_out_call(TCGContext *s, tcg_insn_unit *target)
 {
@@ -1897,44 +1888,20 @@ static void tcg_target_qemu_prologue(TCGContext *s)
 
 #ifndef CONFIG_SOFTMMU
     if (guest_base) {
-        tcg_out_movi(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base);
+        tcg_out_movi_int(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base, true);
         tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
     }
 #endif
 
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_AREG0, tcg_target_call_iarg_regs[0]);
     tcg_out32(s, MTSPR | RS(tcg_target_call_iarg_regs[1]) | CTR);
-
-    if (USE_REG_RA) {
-#ifdef _CALL_AIX
-        /* Make the caller load the value as the TOC into R2.  */
-        tb_ret_addr = s->code_ptr + 2;
-        desc[1] = tb_ret_addr;
-        tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_RA, TCG_REG_R2);
-        tcg_out32(s, BCCTR | BO_ALWAYS);
-#elif defined(_CALL_ELF) && _CALL_ELF == 2
-        /* Compute from the incoming R12 value.  */
-        tb_ret_addr = s->code_ptr + 2;
-        tcg_out32(s, ADDI | TAI(TCG_REG_RA, TCG_REG_R12,
-                                tcg_ptr_byte_diff(tb_ret_addr, s->code_buf)));
-        tcg_out32(s, BCCTR | BO_ALWAYS);
-#else
-        /* Reserve max 5 insns for the constant load.  */
-        tb_ret_addr = s->code_ptr + 6;
-        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_RA, (intptr_t)tb_ret_addr);
-        tcg_out32(s, BCCTR | BO_ALWAYS);
-        while (s->code_ptr < tb_ret_addr) {
-            tcg_out32(s, NOP);
-        }
-#endif
-    } else {
-        tcg_out32(s, BCCTR | BO_ALWAYS);
-        tb_ret_addr = s->code_ptr;
+    if (USE_REG_TB) {
+        tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_TB, tcg_target_call_iarg_regs[1]);
     }
+    tcg_out32(s, BCCTR | BO_ALWAYS);
 
     /* Epilogue */
-    tcg_debug_assert(tb_ret_addr == s->code_ptr);
-    s->code_gen_epilogue = tb_ret_addr;
+    s->code_gen_epilogue = tb_ret_addr = s->code_ptr;
 
     tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_R0, TCG_REG_R1, FRAME_SIZE+LR_OFFSET);
     for (i = 0; i < ARRAY_SIZE(tcg_target_callee_save_regs); ++i) {
@@ -1954,44 +1921,48 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
 
     switch (opc) {
     case INDEX_op_exit_tb:
-        if (USE_REG_RA) {
-            ptrdiff_t disp = tcg_pcrel_diff(s, tb_ret_addr);
-
-            /* Use a direct branch if we can, otherwise use the value in RA.
-               Note that the direct branch is always backward, thus we need
-               to account for the possibility of 5 insns from the movi.  */
-            if (!in_range_b(disp - 20)) {
-                tcg_out32(s, MTSPR | RS(TCG_REG_RA) | CTR);
-                tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R3, args[0]);
-                tcg_out32(s, BCCTR | BO_ALWAYS);
-                break;
-            }
-        }
         tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R3, args[0]);
         tcg_out_b(s, 0, tb_ret_addr);
         break;
     case INDEX_op_goto_tb:
-        tcg_debug_assert(s->tb_jmp_insn_offset);
-        /* Direct jump. */
-#ifdef __powerpc64__
-        /* Ensure the next insns are 8-byte aligned. */
-        if ((uintptr_t)s->code_ptr & 7) {
-            tcg_out32(s, NOP);
-        }
-        s->tb_jmp_insn_offset[args[0]] = tcg_current_code_size(s);
-        /* To be replaced by either a branch+nop or a load into TMP1.  */
-        s->code_ptr += 2;
-        tcg_out32(s, MTSPR | RS(TCG_REG_TMP1) | CTR);
+        if (s->tb_jmp_insn_offset) {
+            /* Direct jump. */
+            if (TCG_TARGET_REG_BITS == 64) {
+                /* Ensure the next insns are 8-byte aligned. */
+                if ((uintptr_t)s->code_ptr & 7) {
+                    tcg_out32(s, NOP);
+                }
+                s->tb_jmp_insn_offset[args[0]] = tcg_current_code_size(s);
+                tcg_out32(s, ADDIS | TAI(TCG_REG_TB, TCG_REG_TB, 0));
+                tcg_out32(s, ADDI | TAI(TCG_REG_TB, TCG_REG_TB, 0));
+            } else {
+                s->tb_jmp_insn_offset[args[0]] = tcg_current_code_size(s);
+                tcg_out32(s, B);
+                s->tb_jmp_reset_offset[args[0]] = tcg_current_code_size(s);
+                break;
+            }
+        } else {
+            /* Indirect jump. */
+            tcg_debug_assert(s->tb_jmp_insn_offset == NULL);
+            tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TB, 0,
+                       (intptr_t)(s->tb_jmp_insn_offset + args[0]));
+        }
+        tcg_out32(s, MTSPR | RS(TCG_REG_TB) | CTR);
         tcg_out32(s, BCCTR | BO_ALWAYS);
-#else
-        /* To be replaced by a branch.  */
-        s->code_ptr++;
-#endif
-        s->tb_jmp_reset_offset[args[0]] = tcg_current_code_size(s);
+        s->tb_jmp_reset_offset[args[0]] = c = tcg_current_code_size(s);
+        if (USE_REG_TB) {
+            /* For the unlinked case, need to reset TCG_REG_TB.  */
+            c = -c;
+            assert(c == (int16_t)c);
+            tcg_out32(s, ADDI | TAI(TCG_REG_TB, TCG_REG_TB, c));
+        }
         break;
     case INDEX_op_goto_ptr:
         tcg_out32(s, MTSPR | RS(args[0]) | CTR);
-        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R3, 0);
+        if (USE_REG_TB) {
+            tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_TB, args[0]);
+        }
+        tcg_out32(s, ADDI | TAI(TCG_REG_R3, 0, 0));
         tcg_out32(s, BCCTR | BO_ALWAYS);
         break;
     case INDEX_op_br:
@@ -2761,8 +2732,8 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_R13); /* thread pointer */
 #endif
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP1); /* mem temp */
-    if (USE_REG_RA) {
-        tcg_regset_set_reg(s->reserved_regs, TCG_REG_RA);  /* return addr */
+    if (USE_REG_TB) {
+        tcg_regset_set_reg(s->reserved_regs, TCG_REG_TB);  /* tb->tc_ptr */
     }
 }
 
-- 
2.13.5
