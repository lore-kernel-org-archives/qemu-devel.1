Received: from eggs.gnu.org ([2001:4830:134:3::10]:44254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCj5-0000Hf-8C
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCj3-0003k5-Ld
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:35 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42971)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gQCj3-0003f9-BL
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:33 -0500
Received: by mail-wr1-x441.google.com with SMTP id q18so12568773wrx.9
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 06:46:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 23 Nov 2018 15:45:51 +0100
Message-Id: <20181123144558.5048-31-richard.henderson@linaro.org>
In-Reply-To: <20181123144558.5048-1-richard.henderson@linaro.org>
References: <20181123144558.5048-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 v2 30/37] tcg/i386: Adjust
 TCG_TARGET_HAS_MEMORY_BSWAP
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

Always true for softmmu and when movbe is available.  In the softmmu
case we always have call-clobbered scratch registers available, and
having the bswap in the softmmu thunk maximizes code sharing.

For user-only and without movbe, leave this to generic code.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h     |   5 ++
 tcg/i386/tcg-target.inc.c | 122 ++++++++++++++++++++++++--------------
 2 files changed, 82 insertions(+), 45 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 212ba554e9..2d7cbb5dd6 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -101,6 +101,7 @@ extern bool have_bmi1;
 extern bool have_popcnt;
 extern bool have_avx1;
 extern bool have_avx2;
+extern bool have_movbe;
 
 /* optional instructions */
 #define TCG_TARGET_HAS_div2_i32         1
@@ -219,7 +220,11 @@ static inline void tb_target_set_jmp_target(uintptr_t tc_ptr,
 
 #define TCG_TARGET_DEFAULT_MO (TCG_MO_ALL & ~TCG_MO_ST_LD)
 
+#ifdef CONFIG_SOFTMMU
 #define TCG_TARGET_HAS_MEMORY_BSWAP  1
+#else
+#define TCG_TARGET_HAS_MEMORY_BSWAP  have_movbe
+#endif
 
 #ifdef CONFIG_SOFTMMU
 #define TCG_TARGET_NEED_LDST_OOL_LABELS
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 5c68cbd43d..76235e90c9 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -158,13 +158,12 @@ bool have_bmi1;
 bool have_popcnt;
 bool have_avx1;
 bool have_avx2;
+bool have_movbe;
 
 #ifdef CONFIG_CPUID_H
-static bool have_movbe;
 static bool have_bmi2;
 static bool have_lzcnt;
 #else
-# define have_movbe 0
 # define have_bmi2 0
 # define have_lzcnt 0
 #endif
@@ -1818,13 +1817,24 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
                                    TCGReg base, int index, intptr_t ofs,
                                    int seg, TCGMemOp memop)
 {
-    const TCGMemOp real_bswap = memop & MO_BSWAP;
-    TCGMemOp bswap = real_bswap;
+    bool use_bswap = memop & MO_BSWAP;
+    bool use_movbe = false;
     int movop = OPC_MOVL_GvEv;
 
-    if (have_movbe && real_bswap) {
-        bswap = 0;
-        movop = OPC_MOVBE_GyMy;
+    /*
+     * Do big-endian loads with movbe or softmmu.
+     * User-only without movbe will have its swapping done generically.
+     */
+    if (use_bswap) {
+        if (have_movbe) {
+            use_bswap = false;
+            use_movbe = true;
+            movop = OPC_MOVBE_GyMy;
+        } else {
+#ifndef CONFIG_SOFTMMU
+            g_assert_not_reached();
+#endif
+        }
     }
 
     switch (memop & MO_SSIZE) {
@@ -1837,40 +1847,52 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
                                  base, index, 0, ofs);
         break;
     case MO_UW:
-        tcg_out_modrm_sib_offset(s, OPC_MOVZWL + seg, datalo,
-                                 base, index, 0, ofs);
-        if (real_bswap) {
-            tcg_out_rolw_8(s, datalo);
-        }
-        break;
-    case MO_SW:
-        if (real_bswap) {
-            if (have_movbe) {
+        if (use_movbe) {
+            /* There is no extending movbe; only low 16-bits are modified.  */
+            if (datalo != base && datalo != index) {
+                /* XOR breaks zeros while breaking dependency chains.  */
+                tgen_arithr(s, ARITH_XOR, datalo, datalo);
                 tcg_out_modrm_sib_offset(s, OPC_MOVBE_GyMy + P_DATA16 + seg,
                                          datalo, base, index, 0, ofs);
             } else {
-                tcg_out_modrm_sib_offset(s, OPC_MOVZWL + seg, datalo,
-                                         base, index, 0, ofs);
+                tcg_out_modrm_sib_offset(s, OPC_MOVBE_GyMy + P_DATA16 + seg,
+                                         datalo, base, index, 0, ofs);
+                tcg_out_ext16u(s, datalo, datalo);
+            }
+        } else {
+            tcg_out_modrm_sib_offset(s, OPC_MOVZWL + seg, datalo,
+                                     base, index, 0, ofs);
+            if (use_bswap) {
                 tcg_out_rolw_8(s, datalo);
             }
-            tcg_out_modrm(s, OPC_MOVSWL + P_REXW, datalo, datalo);
+        }
+        break;
+    case MO_SW:
+        if (use_movbe) {
+            tcg_out_modrm_sib_offset(s, OPC_MOVBE_GyMy + P_DATA16 + seg,
+                                     datalo, base, index, 0, ofs);
+            tcg_out_ext16s(s, datalo, datalo, P_REXW);
         } else {
             tcg_out_modrm_sib_offset(s, OPC_MOVSWL + P_REXW + seg,
                                      datalo, base, index, 0, ofs);
+            if (use_bswap) {
+                tcg_out_rolw_8(s, datalo);
+                tcg_out_ext16s(s, datalo, datalo, P_REXW);
+            }
         }
         break;
     case MO_UL:
         tcg_out_modrm_sib_offset(s, movop + seg, datalo, base, index, 0, ofs);
-        if (bswap) {
+        if (use_bswap) {
             tcg_out_bswap32(s, datalo);
         }
         break;
 #if TCG_TARGET_REG_BITS == 64
     case MO_SL:
-        if (real_bswap) {
+        if (use_bswap || use_movbe) {
             tcg_out_modrm_sib_offset(s, movop + seg, datalo,
                                      base, index, 0, ofs);
-            if (bswap) {
+            if (use_bswap) {
                 tcg_out_bswap32(s, datalo);
             }
             tcg_out_ext32s(s, datalo, datalo);
@@ -1884,12 +1906,12 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
         if (TCG_TARGET_REG_BITS == 64) {
             tcg_out_modrm_sib_offset(s, movop + P_REXW + seg, datalo,
                                      base, index, 0, ofs);
-            if (bswap) {
+            if (use_bswap) {
                 tcg_out_bswap64(s, datalo);
             }
         } else {
-            if (real_bswap) {
-                int t = datalo;
+            if (use_bswap || use_movbe) {
+                TCGReg t = datalo;
                 datalo = datahi;
                 datahi = t;
             }
@@ -1904,14 +1926,14 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
                 tcg_out_modrm_sib_offset(s, movop + seg, datalo,
                                          base, index, 0, ofs);
             }
-            if (bswap) {
+            if (use_bswap) {
                 tcg_out_bswap32(s, datalo);
                 tcg_out_bswap32(s, datahi);
             }
         }
         break;
     default:
-        tcg_abort();
+        g_assert_not_reached();
     }
 }
 
@@ -1991,24 +2013,34 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
                                    TCGReg base, intptr_t ofs, int seg,
                                    TCGMemOp memop)
 {
-    /* ??? Ideally we wouldn't need a scratch register.  For user-only,
-       we could perform the bswap twice to restore the original value
-       instead of moving to the scratch.  But as it is, the L constraint
-       means that TCG_REG_L0 is definitely free here.  */
     const TCGReg scratch = TCG_REG_L0;
-    const TCGMemOp real_bswap = memop & MO_BSWAP;
-    TCGMemOp bswap = real_bswap;
+    bool use_bswap = memop & MO_BSWAP;
+    bool use_movbe = false;
     int movop = OPC_MOVL_EvGv;
 
-    if (have_movbe && real_bswap) {
-        bswap = 0;
-        movop = OPC_MOVBE_MyGy;
+    /*
+     * Do big-endian stores with movbe or softmmu.
+     * User-only without movbe will have its swapping done generically.
+     */
+    if (use_bswap) {
+        if (have_movbe) {
+            use_bswap = false;
+            use_movbe = true;
+            movop = OPC_MOVBE_MyGy;
+        } else {
+#ifndef CONFIG_SOFTMMU
+            g_assert_not_reached();
+#endif
+        }
     }
 
     switch (memop & MO_SIZE) {
     case MO_8:
-        /* In 32-bit mode, 8-bit stores can only happen from [abcd]x.
-           Use the scratch register if necessary.  */
+        /*
+         * In 32-bit mode, 8-bit stores can only happen from [abcd]x.
+         * ??? Adjust constraints such that this is is forced, then
+         * we won't need a scratch at all for user-only.
+         */
         if (TCG_TARGET_REG_BITS == 32 && datalo >= 4) {
             tcg_out_mov(s, TCG_TYPE_I32, scratch, datalo);
             datalo = scratch;
@@ -2017,7 +2049,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
                              datalo, base, ofs);
         break;
     case MO_16:
-        if (bswap) {
+        if (use_bswap) {
             tcg_out_mov(s, TCG_TYPE_I32, scratch, datalo);
             tcg_out_rolw_8(s, scratch);
             datalo = scratch;
@@ -2025,7 +2057,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
         tcg_out_modrm_offset(s, movop + P_DATA16 + seg, datalo, base, ofs);
         break;
     case MO_32:
-        if (bswap) {
+        if (use_bswap) {
             tcg_out_mov(s, TCG_TYPE_I32, scratch, datalo);
             tcg_out_bswap32(s, scratch);
             datalo = scratch;
@@ -2034,13 +2066,13 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
         break;
     case MO_64:
         if (TCG_TARGET_REG_BITS == 64) {
-            if (bswap) {
+            if (use_bswap) {
                 tcg_out_mov(s, TCG_TYPE_I64, scratch, datalo);
                 tcg_out_bswap64(s, scratch);
                 datalo = scratch;
             }
             tcg_out_modrm_offset(s, movop + P_REXW + seg, datalo, base, ofs);
-        } else if (bswap) {
+        } else if (use_bswap) {
             tcg_out_mov(s, TCG_TYPE_I32, scratch, datahi);
             tcg_out_bswap32(s, scratch);
             tcg_out_modrm_offset(s, OPC_MOVL_EvGv + seg, scratch, base, ofs);
@@ -2048,8 +2080,8 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
             tcg_out_bswap32(s, scratch);
             tcg_out_modrm_offset(s, OPC_MOVL_EvGv + seg, scratch, base, ofs+4);
         } else {
-            if (real_bswap) {
-                int t = datalo;
+            if (use_movbe) {
+                TCGReg t = datalo;
                 datalo = datahi;
                 datahi = t;
             }
@@ -2058,7 +2090,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
         }
         break;
     default:
-        tcg_abort();
+        g_assert_not_reached();
     }
 }
 
-- 
2.17.2
