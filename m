Received: from eggs.gnu.org ([2001:4830:134:3::10]:43738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gP4xD-0001ov-K2
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:16:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gP4xC-00056I-4v
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:16:31 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gP4xB-000566-SV
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:16:30 -0500
Received: by mail-pg1-x544.google.com with SMTP id z10so830985pgp.7
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 04:16:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 20 Nov 2018 13:15:58 +0100
Message-Id: <20181120121558.7660-6-richard.henderson@linaro.org>
In-Reply-To: <20181120121558.7660-1-richard.henderson@linaro.org>
References: <20181120121558.7660-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 5/5] tcg/arm: Set TCG_TARGET_HAS_MEMORY_BSWAP
 to false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com

This allows us to remove some code from the backend, allowing
the generic code to emit any extra bswaps.  It also allows us
to avoid reserving an extra register for CONFIG_USER_ONLY.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.h     |   2 +-
 tcg/arm/tcg-target.inc.c | 198 ++++++++++-----------------------------
 2 files changed, 48 insertions(+), 152 deletions(-)

diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 16172f73a3..a6f7be5483 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -131,7 +131,7 @@ enum {
 };
 
 #define TCG_TARGET_DEFAULT_MO (0)
-#define TCG_TARGET_HAS_MEMORY_BSWAP     1
+#define TCG_TARGET_HAS_MEMORY_BSWAP     0
 
 static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
 {
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index e1fbf465cb..0043454d6b 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -285,11 +285,10 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     case 's':
         ct->ct |= TCG_CT_REG;
         ct->u.regs = 0xffff;
-        /* r0-r2 will be overwritten when reading the tlb entry (softmmu only)
-           and r0-r1 doing the byte swapping, so don't use these. */
+#if defined(CONFIG_SOFTMMU)
+        /* r0-r2 will be overwritten when reading the tlb entry.  */
         tcg_regset_reset_reg(ct->u.regs, TCG_REG_R0);
         tcg_regset_reset_reg(ct->u.regs, TCG_REG_R1);
-#if defined(CONFIG_SOFTMMU)
         /* Avoid clashes with registers being used for helper args */
         tcg_regset_reset_reg(ct->u.regs, TCG_REG_R2);
 #if TARGET_LONG_BITS == 64
@@ -870,21 +869,6 @@ static inline void tcg_out_ext16u(TCGContext *s, int cond,
     }
 }
 
-static inline void tcg_out_bswap16s(TCGContext *s, int cond, int rd, int rn)
-{
-    if (use_armv6_instructions) {
-        /* revsh */
-        tcg_out32(s, 0x06ff0fb0 | (cond << 28) | (rd << 12) | rn);
-    } else {
-        tcg_out_dat_reg(s, cond, ARITH_MOV,
-                        TCG_REG_TMP, 0, rn, SHIFT_IMM_LSL(24));
-        tcg_out_dat_reg(s, cond, ARITH_MOV,
-                        TCG_REG_TMP, 0, TCG_REG_TMP, SHIFT_IMM_ASR(16));
-        tcg_out_dat_reg(s, cond, ARITH_ORR,
-                        rd, TCG_REG_TMP, rn, SHIFT_IMM_LSR(8));
-    }
-}
-
 static inline void tcg_out_bswap16(TCGContext *s, int cond, int rd, int rn)
 {
     if (use_armv6_instructions) {
@@ -900,22 +884,6 @@ static inline void tcg_out_bswap16(TCGContext *s, int cond, int rd, int rn)
     }
 }
 
-/* swap the two low bytes assuming that the two high input bytes and the
-   two high output bit can hold any value. */
-static inline void tcg_out_bswap16st(TCGContext *s, int cond, int rd, int rn)
-{
-    if (use_armv6_instructions) {
-        /* rev16 */
-        tcg_out32(s, 0x06bf0fb0 | (cond << 28) | (rd << 12) | rn);
-    } else {
-        tcg_out_dat_reg(s, cond, ARITH_MOV,
-                        TCG_REG_TMP, 0, rn, SHIFT_IMM_LSR(8));
-        tcg_out_dat_imm(s, cond, ARITH_AND, TCG_REG_TMP, TCG_REG_TMP, 0xff);
-        tcg_out_dat_reg(s, cond, ARITH_ORR,
-                        rd, TCG_REG_TMP, rn, SHIFT_IMM_LSL(8));
-    }
-}
-
 static inline void tcg_out_bswap32(TCGContext *s, int cond, int rd, int rn)
 {
     if (use_armv6_instructions) {
@@ -1410,9 +1378,9 @@ static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
        icache usage.  For pre-armv6, use the signed helpers since we do
        not have a single insn sign-extend.  */
     if (use_armv6_instructions) {
-        func = qemu_ld_helpers[opc & (MO_BSWAP | MO_SIZE)];
+        func = qemu_ld_helpers[opc & MO_SIZE];
     } else {
-        func = qemu_ld_helpers[opc & (MO_BSWAP | MO_SSIZE)];
+        func = qemu_ld_helpers[opc & MO_SSIZE];
         if (opc & MO_SIGN) {
             opc = MO_UL;
         }
@@ -1487,7 +1455,7 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     argreg = tcg_out_arg_reg32(s, argreg, TCG_REG_R14);
 
     /* Tail-call to the helper, which will return to the fast path.  */
-    tcg_out_goto(s, COND_AL, qemu_st_helpers[opc & (MO_BSWAP | MO_SIZE)]);
+    tcg_out_goto(s, COND_AL, qemu_st_helpers[opc & MO_SIZE]);
 }
 #endif /* SOFTMMU */
 
@@ -1495,8 +1463,6 @@ static inline void tcg_out_qemu_ld_index(TCGContext *s, TCGMemOp opc,
                                          TCGReg datalo, TCGReg datahi,
                                          TCGReg addrlo, TCGReg addend)
 {
-    TCGMemOp bswap = opc & MO_BSWAP;
-
     switch (opc & MO_SSIZE) {
     case MO_UB:
         tcg_out_ld8_r(s, COND_AL, datalo, addrlo, addend);
@@ -1506,49 +1472,30 @@ static inline void tcg_out_qemu_ld_index(TCGContext *s, TCGMemOp opc,
         break;
     case MO_UW:
         tcg_out_ld16u_r(s, COND_AL, datalo, addrlo, addend);
-        if (bswap) {
-            tcg_out_bswap16(s, COND_AL, datalo, datalo);
-        }
         break;
     case MO_SW:
-        if (bswap) {
-            tcg_out_ld16u_r(s, COND_AL, datalo, addrlo, addend);
-            tcg_out_bswap16s(s, COND_AL, datalo, datalo);
-        } else {
-            tcg_out_ld16s_r(s, COND_AL, datalo, addrlo, addend);
-        }
+        tcg_out_ld16s_r(s, COND_AL, datalo, addrlo, addend);
         break;
     case MO_UL:
-    default:
         tcg_out_ld32_r(s, COND_AL, datalo, addrlo, addend);
-        if (bswap) {
-            tcg_out_bswap32(s, COND_AL, datalo, datalo);
-        }
         break;
     case MO_Q:
-        {
-            TCGReg dl = (bswap ? datahi : datalo);
-            TCGReg dh = (bswap ? datalo : datahi);
-
-            /* Avoid ldrd for user-only emulation, to handle unaligned.  */
-            if (USING_SOFTMMU && use_armv6_instructions
-                && (dl & 1) == 0 && dh == dl + 1) {
-                tcg_out_ldrd_r(s, COND_AL, dl, addrlo, addend);
-            } else if (dl != addend) {
-                tcg_out_ld32_rwb(s, COND_AL, dl, addend, addrlo);
-                tcg_out_ld32_12(s, COND_AL, dh, addend, 4);
-            } else {
-                tcg_out_dat_reg(s, COND_AL, ARITH_ADD, TCG_REG_TMP,
-                                addend, addrlo, SHIFT_IMM_LSL(0));
-                tcg_out_ld32_12(s, COND_AL, dl, TCG_REG_TMP, 0);
-                tcg_out_ld32_12(s, COND_AL, dh, TCG_REG_TMP, 4);
-            }
-            if (bswap) {
-                tcg_out_bswap32(s, COND_AL, dl, dl);
-                tcg_out_bswap32(s, COND_AL, dh, dh);
-            }
+        /* Avoid ldrd for user-only emulation, to handle unaligned.  */
+        if (USING_SOFTMMU && use_armv6_instructions
+            && (datalo & 1) == 0 && datahi == datalo + 1) {
+            tcg_out_ldrd_r(s, COND_AL, datalo, addrlo, addend);
+        } else if (datalo != addend) {
+            tcg_out_ld32_rwb(s, COND_AL, datalo, addend, addrlo);
+            tcg_out_ld32_12(s, COND_AL, datahi, addend, 4);
+        } else {
+            tcg_out_dat_reg(s, COND_AL, ARITH_ADD, TCG_REG_TMP,
+                            addend, addrlo, SHIFT_IMM_LSL(0));
+            tcg_out_ld32_12(s, COND_AL, datalo, TCG_REG_TMP, 0);
+            tcg_out_ld32_12(s, COND_AL, datahi, TCG_REG_TMP, 4);
         }
         break;
+    default:
+        g_assert_not_reached();
     }
 }
 
@@ -1556,8 +1503,6 @@ static inline void tcg_out_qemu_ld_direct(TCGContext *s, TCGMemOp opc,
                                           TCGReg datalo, TCGReg datahi,
                                           TCGReg addrlo)
 {
-    TCGMemOp bswap = opc & MO_BSWAP;
-
     switch (opc & MO_SSIZE) {
     case MO_UB:
         tcg_out_ld8_12(s, COND_AL, datalo, addrlo, 0);
@@ -1567,47 +1512,28 @@ static inline void tcg_out_qemu_ld_direct(TCGContext *s, TCGMemOp opc,
         break;
     case MO_UW:
         tcg_out_ld16u_8(s, COND_AL, datalo, addrlo, 0);
-        if (bswap) {
-            tcg_out_bswap16(s, COND_AL, datalo, datalo);
-        }
         break;
     case MO_SW:
-        if (bswap) {
-            tcg_out_ld16u_8(s, COND_AL, datalo, addrlo, 0);
-            tcg_out_bswap16s(s, COND_AL, datalo, datalo);
-        } else {
-            tcg_out_ld16s_8(s, COND_AL, datalo, addrlo, 0);
-        }
+        tcg_out_ld16s_8(s, COND_AL, datalo, addrlo, 0);
         break;
     case MO_UL:
-    default:
         tcg_out_ld32_12(s, COND_AL, datalo, addrlo, 0);
-        if (bswap) {
-            tcg_out_bswap32(s, COND_AL, datalo, datalo);
-        }
         break;
     case MO_Q:
-        {
-            TCGReg dl = (bswap ? datahi : datalo);
-            TCGReg dh = (bswap ? datalo : datahi);
-
-            /* Avoid ldrd for user-only emulation, to handle unaligned.  */
-            if (USING_SOFTMMU && use_armv6_instructions
-                && (dl & 1) == 0 && dh == dl + 1) {
-                tcg_out_ldrd_8(s, COND_AL, dl, addrlo, 0);
-            } else if (dl == addrlo) {
-                tcg_out_ld32_12(s, COND_AL, dh, addrlo, bswap ? 0 : 4);
-                tcg_out_ld32_12(s, COND_AL, dl, addrlo, bswap ? 4 : 0);
-            } else {
-                tcg_out_ld32_12(s, COND_AL, dl, addrlo, bswap ? 4 : 0);
-                tcg_out_ld32_12(s, COND_AL, dh, addrlo, bswap ? 0 : 4);
-            }
-            if (bswap) {
-                tcg_out_bswap32(s, COND_AL, dl, dl);
-                tcg_out_bswap32(s, COND_AL, dh, dh);
-            }
+        /* Avoid ldrd for user-only emulation, to handle unaligned.  */
+        if (USING_SOFTMMU && use_armv6_instructions
+            && (datalo & 1) == 0 && datahi == datalo + 1) {
+            tcg_out_ldrd_8(s, COND_AL, datalo, addrlo, 0);
+        } else if (datalo == addrlo) {
+            tcg_out_ld32_12(s, COND_AL, datahi, addrlo, 4);
+            tcg_out_ld32_12(s, COND_AL, datalo, addrlo, 0);
+        } else {
+            tcg_out_ld32_12(s, COND_AL, datalo, addrlo, 0);
+            tcg_out_ld32_12(s, COND_AL, datahi, addrlo, 4);
         }
         break;
+    default:
+        g_assert_not_reached();
     }
 }
 
@@ -1628,6 +1554,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is64)
     addrhi = (TARGET_LONG_BITS == 64 ? *args++ : 0);
     oi = *args++;
     opc = get_memop(oi);
+    tcg_debug_assert(!(opc & MO_BSWAP));
 
 #ifdef CONFIG_SOFTMMU
     mem_index = get_mmuidx(oi);
@@ -1656,44 +1583,28 @@ static inline void tcg_out_qemu_st_index(TCGContext *s, int cond, TCGMemOp opc,
                                          TCGReg datalo, TCGReg datahi,
                                          TCGReg addrlo, TCGReg addend)
 {
-    TCGMemOp bswap = opc & MO_BSWAP;
-
     switch (opc & MO_SIZE) {
     case MO_8:
         tcg_out_st8_r(s, cond, datalo, addrlo, addend);
         break;
     case MO_16:
-        if (bswap) {
-            tcg_out_bswap16st(s, cond, TCG_REG_R0, datalo);
-            tcg_out_st16_r(s, cond, TCG_REG_R0, addrlo, addend);
-        } else {
-            tcg_out_st16_r(s, cond, datalo, addrlo, addend);
-        }
+        tcg_out_st16_r(s, cond, datalo, addrlo, addend);
         break;
     case MO_32:
-    default:
-        if (bswap) {
-            tcg_out_bswap32(s, cond, TCG_REG_R0, datalo);
-            tcg_out_st32_r(s, cond, TCG_REG_R0, addrlo, addend);
-        } else {
-            tcg_out_st32_r(s, cond, datalo, addrlo, addend);
-        }
+        tcg_out_st32_r(s, cond, datalo, addrlo, addend);
         break;
     case MO_64:
         /* Avoid strd for user-only emulation, to handle unaligned.  */
-        if (bswap) {
-            tcg_out_bswap32(s, cond, TCG_REG_R0, datahi);
-            tcg_out_st32_rwb(s, cond, TCG_REG_R0, addend, addrlo);
-            tcg_out_bswap32(s, cond, TCG_REG_R0, datalo);
-            tcg_out_st32_12(s, cond, TCG_REG_R0, addend, 4);
-        } else if (USING_SOFTMMU && use_armv6_instructions
-                   && (datalo & 1) == 0 && datahi == datalo + 1) {
+        if (USING_SOFTMMU && use_armv6_instructions
+            && (datalo & 1) == 0 && datahi == datalo + 1) {
             tcg_out_strd_r(s, cond, datalo, addrlo, addend);
         } else {
             tcg_out_st32_rwb(s, cond, datalo, addend, addrlo);
             tcg_out_st32_12(s, cond, datahi, addend, 4);
         }
         break;
+    default:
+        g_assert_not_reached();
     }
 }
 
@@ -1701,44 +1612,28 @@ static inline void tcg_out_qemu_st_direct(TCGContext *s, TCGMemOp opc,
                                           TCGReg datalo, TCGReg datahi,
                                           TCGReg addrlo)
 {
-    TCGMemOp bswap = opc & MO_BSWAP;
-
     switch (opc & MO_SIZE) {
     case MO_8:
         tcg_out_st8_12(s, COND_AL, datalo, addrlo, 0);
         break;
     case MO_16:
-        if (bswap) {
-            tcg_out_bswap16st(s, COND_AL, TCG_REG_R0, datalo);
-            tcg_out_st16_8(s, COND_AL, TCG_REG_R0, addrlo, 0);
-        } else {
-            tcg_out_st16_8(s, COND_AL, datalo, addrlo, 0);
-        }
+        tcg_out_st16_8(s, COND_AL, datalo, addrlo, 0);
         break;
     case MO_32:
-    default:
-        if (bswap) {
-            tcg_out_bswap32(s, COND_AL, TCG_REG_R0, datalo);
-            tcg_out_st32_12(s, COND_AL, TCG_REG_R0, addrlo, 0);
-        } else {
-            tcg_out_st32_12(s, COND_AL, datalo, addrlo, 0);
-        }
+        tcg_out_st32_12(s, COND_AL, datalo, addrlo, 0);
         break;
     case MO_64:
         /* Avoid strd for user-only emulation, to handle unaligned.  */
-        if (bswap) {
-            tcg_out_bswap32(s, COND_AL, TCG_REG_R0, datahi);
-            tcg_out_st32_12(s, COND_AL, TCG_REG_R0, addrlo, 0);
-            tcg_out_bswap32(s, COND_AL, TCG_REG_R0, datalo);
-            tcg_out_st32_12(s, COND_AL, TCG_REG_R0, addrlo, 4);
-        } else if (USING_SOFTMMU && use_armv6_instructions
-                   && (datalo & 1) == 0 && datahi == datalo + 1) {
+        if (USING_SOFTMMU && use_armv6_instructions
+            && (datalo & 1) == 0 && datahi == datalo + 1) {
             tcg_out_strd_8(s, COND_AL, datalo, addrlo, 0);
         } else {
             tcg_out_st32_12(s, COND_AL, datalo, addrlo, 0);
             tcg_out_st32_12(s, COND_AL, datahi, addrlo, 4);
         }
         break;
+    default:
+        g_assert_not_reached();
     }
 }
 
@@ -1759,6 +1654,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is64)
     addrhi = (TARGET_LONG_BITS == 64 ? *args++ : 0);
     oi = *args++;
     opc = get_memop(oi);
+    tcg_debug_assert(!(opc & MO_BSWAP));
 
 #ifdef CONFIG_SOFTMMU
     mem_index = get_mmuidx(oi);
-- 
2.17.2
