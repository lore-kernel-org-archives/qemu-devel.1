Received: from eggs.gnu.org ([2001:4830:134:3::10]:44265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCj5-0000Hg-FT
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCj3-0003jw-KT
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:35 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gQCj3-0003hc-Ae
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:33 -0500
Received: by mail-wr1-x442.google.com with SMTP id l9so12571118wrt.13
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 06:46:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 23 Nov 2018 15:45:53 +0100
Message-Id: <20181123144558.5048-33-richard.henderson@linaro.org>
In-Reply-To: <20181123144558.5048-1-richard.henderson@linaro.org>
References: <20181123144558.5048-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 v2 32/37] tcg/arm: Set
 TCG_TARGET_HAS_MEMORY_BSWAP to false for user-only
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

Letting the generic code emit any bswaps allows us to avoid reserving
an extra register for CONFIG_USER_ONLY.  For SOFTMMU, where we have
free call-clobbered registers anyway, leaving the bswap in the out-of-line
thunk maximizes code sharing.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.h     |   4 ++
 tcg/arm/tcg-target.inc.c | 129 +++++++++++++--------------------------
 2 files changed, 48 insertions(+), 85 deletions(-)

diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 7a4c55d66d..a05310a684 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -131,7 +131,11 @@ enum {
 };
 
 #define TCG_TARGET_DEFAULT_MO (0)
+#ifdef CONFIG_SOFTMMU
 #define TCG_TARGET_HAS_MEMORY_BSWAP     1
+#else
+#define TCG_TARGET_HAS_MEMORY_BSWAP     0
+#endif
 
 static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
 {
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 5a15f6a546..898701f105 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -270,15 +270,6 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
         ct->u.regs = 0xffff;
         break;
 
-    /* qemu_st address & data */
-    case 's':
-        ct->ct |= TCG_CT_REG;
-        ct->u.regs = 0xffff;
-        /* r0-r1 doing the byte swapping, so don't use these */
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R0);
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R1);
-        break;
-
     default:
         return NULL;
     }
@@ -1363,6 +1354,7 @@ static inline void tcg_out_qemu_ld_index(TCGContext *s, TCGMemOp opc,
                                          TCGReg addrlo, TCGReg addend)
 {
     TCGMemOp bswap = opc & MO_BSWAP;
+    assert(USING_SOFTMMU || !bswap);
 
     switch (opc & MO_SSIZE) {
     case MO_UB:
@@ -1386,7 +1378,6 @@ static inline void tcg_out_qemu_ld_index(TCGContext *s, TCGMemOp opc,
         }
         break;
     case MO_UL:
-    default:
         tcg_out_ld32_r(s, COND_AL, datalo, addrlo, addend);
         if (bswap) {
             tcg_out_bswap32(s, COND_AL, datalo, datalo);
@@ -1416,6 +1407,8 @@ static inline void tcg_out_qemu_ld_index(TCGContext *s, TCGMemOp opc,
             }
         }
         break;
+    default:
+        g_assert_not_reached();
     }
 }
 
@@ -1424,6 +1417,7 @@ static inline void tcg_out_qemu_ld_direct(TCGContext *s, TCGMemOp opc,
                                           TCGReg addrlo)
 {
     TCGMemOp bswap = opc & MO_BSWAP;
+    assert(!USING_SOFTMMU && !bswap);
 
     switch (opc & MO_SSIZE) {
     case MO_UB:
@@ -1434,47 +1428,24 @@ static inline void tcg_out_qemu_ld_direct(TCGContext *s, TCGMemOp opc,
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
+        if (datalo == addrlo) {
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
 
@@ -1485,19 +1456,18 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is64)
     TCGReg datalo __attribute__((unused));
     TCGReg datahi __attribute__((unused));
     TCGMemOpIdx oi;
-    TCGMemOp opc;
 
     datalo = *args++;
     datahi = (is64 ? *args++ : 0);
     addrlo = *args++;
     addrhi = (TARGET_LONG_BITS == 64 ? *args++ : 0);
     oi = *args++;
-    opc = get_memop(oi);
 
 #ifdef CONFIG_SOFTMMU
     add_ldst_ool_label(s, true, is64, oi, R_ARM_PC24, 0);
     tcg_out_bl_noaddr(s, COND_AL);
 #else
+    TCGMemOp opc = get_memop(oi);
     if (guest_base) {
         tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP, guest_base);
         tcg_out_qemu_ld_index(s, opc, datalo, datahi, addrlo, TCG_REG_TMP);
@@ -1512,6 +1482,7 @@ static inline void tcg_out_qemu_st_index(TCGContext *s, int cond, TCGMemOp opc,
                                          TCGReg addrlo, TCGReg addend)
 {
     TCGMemOp bswap = opc & MO_BSWAP;
+    assert(USING_SOFTMMU || !bswap);
 
     switch (opc & MO_SIZE) {
     case MO_8:
@@ -1526,7 +1497,6 @@ static inline void tcg_out_qemu_st_index(TCGContext *s, int cond, TCGMemOp opc,
         }
         break;
     case MO_32:
-    default:
         if (bswap) {
             tcg_out_bswap32(s, cond, TCG_REG_R0, datalo);
             tcg_out_st32_r(s, cond, TCG_REG_R0, addrlo, addend);
@@ -1535,20 +1505,32 @@ static inline void tcg_out_qemu_st_index(TCGContext *s, int cond, TCGMemOp opc,
         }
         break;
     case MO_64:
-        /* Avoid strd for user-only emulation, to handle unaligned.  */
         if (bswap) {
-            tcg_out_bswap32(s, cond, TCG_REG_R0, datahi);
-            tcg_out_st32_rwb(s, cond, TCG_REG_R0, addend, addrlo);
-            tcg_out_bswap32(s, cond, TCG_REG_R0, datalo);
-            tcg_out_st32_12(s, cond, TCG_REG_R0, addend, 4);
-        } else if (USING_SOFTMMU && use_armv6_instructions
-                   && (datalo & 1) == 0 && datahi == datalo + 1) {
+            /*
+             * Assert inputs are where I think, for the softmmu thunk.
+             * One pair of R0/R1 or R2/R3 will be free and call-clobbered,
+             * which allows the use of STRD below.  Note the bswaps also
+             * reverse the lo/hi registers to swap the two words.
+             */
+            tcg_debug_assert(addend == TCG_REG_TMP);
+            tcg_debug_assert(datalo == TCG_REG_R4);
+            tcg_debug_assert(datahi == TCG_REG_R5);
+            datalo = addrlo == TCG_REG_R1 ? TCG_REG_R2 : TCG_REG_R0;
+            datahi = datalo + 1;
+            tcg_out_bswap32(s, cond, datalo, TCG_REG_R5);
+            tcg_out_bswap32(s, cond, datahi, TCG_REG_R4);
+        }
+        /* Avoid strd for user-only emulation, to handle unaligned.  */
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
 
@@ -1557,43 +1539,25 @@ static inline void tcg_out_qemu_st_direct(TCGContext *s, TCGMemOp opc,
                                           TCGReg addrlo)
 {
     TCGMemOp bswap = opc & MO_BSWAP;
+    assert(!USING_SOFTMMU && !bswap);
 
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
-            tcg_out_strd_8(s, COND_AL, datalo, addrlo, 0);
-        } else {
-            tcg_out_st32_12(s, COND_AL, datalo, addrlo, 0);
-            tcg_out_st32_12(s, COND_AL, datahi, addrlo, 4);
-        }
+        tcg_out_st32_12(s, COND_AL, datalo, addrlo, 0);
+        tcg_out_st32_12(s, COND_AL, datahi, addrlo, 4);
         break;
+    default:
+        g_assert_not_reached();
     }
 }
 
@@ -1604,19 +1568,18 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is64)
     TCGReg datalo __attribute__((unused));
     TCGReg datahi __attribute__((unused));
     TCGMemOpIdx oi;
-    TCGMemOp opc;
 
     datalo = *args++;
     datahi = (is64 ? *args++ : 0);
     addrlo = *args++;
     addrhi = (TARGET_LONG_BITS == 64 ? *args++ : 0);
     oi = *args++;
-    opc = get_memop(oi);
 
 #ifdef CONFIG_SOFTMMU
     add_ldst_ool_label(s, false, is64, oi, R_ARM_PC24, 0);
     tcg_out_bl_noaddr(s, COND_AL);
 #else
+    TCGMemOp opc = get_memop(oi);
     if (guest_base) {
         tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP, guest_base);
         tcg_out_qemu_st_index(s, COND_AL, opc, datalo,
@@ -2055,11 +2018,9 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 {
     static const TCGTargetOpDef r = { .args_ct_str = { "r" } };
     static const TCGTargetOpDef r_r = { .args_ct_str = { "r", "r" } };
-    static const TCGTargetOpDef s_s = { .args_ct_str = { "s", "s" } };
     static const TCGTargetOpDef a_b = { .args_ct_str = { "a", "b" } };
     static const TCGTargetOpDef c_b = { .args_ct_str = { "c", "b" } };
     static const TCGTargetOpDef r_r_r = { .args_ct_str = { "r", "r", "r" } };
-    static const TCGTargetOpDef s_s_s = { .args_ct_str = { "s", "s", "s" } };
     static const TCGTargetOpDef a_c_d = { .args_ct_str = { "a", "c", "d" } };
     static const TCGTargetOpDef a_b_b = { .args_ct_str = { "a", "b", "b" } };
     static const TCGTargetOpDef e_c_d = { .args_ct_str = { "e", "c", "d" } };
@@ -2072,8 +2033,6 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         = { .args_ct_str = { "r", "r", "rIK" } };
     static const TCGTargetOpDef r_r_r_r
         = { .args_ct_str = { "r", "r", "r", "r" } };
-    static const TCGTargetOpDef s_s_s_s
-        = { .args_ct_str = { "s", "s", "s", "s" } };
     static const TCGTargetOpDef a_b_c_d
         = { .args_ct_str = { "a", "b", "c", "d" } };
     static const TCGTargetOpDef e_f_c_d
@@ -2175,7 +2134,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         }
     case INDEX_op_qemu_st_i32:
         if (!USING_SOFTMMU) {
-            return TARGET_LONG_BITS == 32 ? &s_s : &s_s_s;
+            return TARGET_LONG_BITS == 32 ? &r_r : &r_r_r;
         } else if (TARGET_LONG_BITS == 32) {
             return &c_b;     /* temps available r0, r3, r12 */
         } else {
@@ -2183,7 +2142,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         }
     case INDEX_op_qemu_st_i64:
         if (!USING_SOFTMMU) {
-            return TARGET_LONG_BITS == 32 ? &s_s_s : &s_s_s_s;
+            return TARGET_LONG_BITS == 32 ? &r_r_r : &r_r_r_r;
         } else if (TARGET_LONG_BITS == 32) {
             return &e_f_b;   /* temps available r0, r2, r3, r12 */
         } else {
-- 
2.17.2
