Received: from eggs.gnu.org ([2001:4830:134:3::10]:43708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gP4x7-0001mG-53
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:16:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gP4x4-00052Q-1T
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:16:25 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gP4x3-000523-Q0
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:16:21 -0500
Received: by mail-pg1-x542.google.com with SMTP id 70so826761pgh.8
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 04:16:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 20 Nov 2018 13:15:56 +0100
Message-Id: <20181120121558.7660-4-richard.henderson@linaro.org>
In-Reply-To: <20181120121558.7660-1-richard.henderson@linaro.org>
References: <20181120121558.7660-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 3/5] tcg/i386: Set TCG_TARGET_HAS_MEMORY_BSWAP
 with have_movbe
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
the generic code to emit any extra bswaps.

This does not quite allow all of the cleanup that should be
possible, as we still must take care of i386 storing bytes
from non 'q' registers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h     |   3 +-
 tcg/i386/tcg-target.inc.c | 112 ++++++++++++--------------------------
 2 files changed, 37 insertions(+), 78 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index b1b861f8f2..ed2d5d4441 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -101,6 +101,7 @@ extern bool have_bmi1;
 extern bool have_popcnt;
 extern bool have_avx1;
 extern bool have_avx2;
+extern bool have_movbe;
 
 /* optional instructions */
 #define TCG_TARGET_HAS_div2_i32         1
@@ -219,7 +220,7 @@ static inline void tb_target_set_jmp_target(uintptr_t tc_ptr,
 
 #define TCG_TARGET_DEFAULT_MO (TCG_MO_ALL & ~TCG_MO_ST_LD)
 
-#define TCG_TARGET_HAS_MEMORY_BSWAP  1
+#define TCG_TARGET_HAS_MEMORY_BSWAP  have_movbe
 
 #ifdef CONFIG_SOFTMMU
 #define TCG_TARGET_NEED_LDST_LABELS
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 436195894b..14e1cf9eee 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -154,13 +154,12 @@ bool have_bmi1;
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
@@ -1884,12 +1883,11 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
                                    TCGReg base, int index, intptr_t ofs,
                                    int seg, TCGMemOp memop)
 {
-    const TCGMemOp real_bswap = memop & MO_BSWAP;
-    TCGMemOp bswap = real_bswap;
+    bool need_bswap = memop & MO_BSWAP;
     int movop = OPC_MOVL_GvEv;
 
-    if (have_movbe && real_bswap) {
-        bswap = 0;
+    if (need_bswap) {
+        tcg_debug_assert(have_movbe);
         movop = OPC_MOVBE_GyMy;
     }
 
@@ -1903,46 +1901,41 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
                                  base, index, 0, ofs);
         break;
     case MO_UW:
-        tcg_out_modrm_sib_offset(s, OPC_MOVZWL + seg, datalo,
+        if (!need_bswap) {
+            tcg_out_modrm_sib_offset(s, OPC_MOVZWL + seg, datalo,
                                  base, index, 0, ofs);
-        if (real_bswap) {
-            tcg_out_rolw_8(s, datalo);
+        } else if (datalo != base && datalo != index) {
+            tcg_out_movi(s, TCG_TYPE_I32, datalo, 0);
+            tcg_out_modrm_sib_offset(s, OPC_MOVBE_GyMy + P_DATA16 + seg,
+                                     datalo, base, index, 0, ofs);
+        } else {
+            tcg_out_modrm_sib_offset(s, OPC_MOVBE_GyMy + P_DATA16 + seg,
+                                     datalo, base, index, 0, ofs);
+            tcg_out_ext16u(s, datalo, datalo);
         }
         break;
     case MO_SW:
-        if (real_bswap) {
-            if (have_movbe) {
-                tcg_out_modrm_sib_offset(s, OPC_MOVBE_GyMy + P_DATA16 + seg,
-                                         datalo, base, index, 0, ofs);
-            } else {
-                tcg_out_modrm_sib_offset(s, OPC_MOVZWL + seg, datalo,
-                                         base, index, 0, ofs);
-                tcg_out_rolw_8(s, datalo);
-            }
-            tcg_out_modrm(s, OPC_MOVSWL + P_REXW, datalo, datalo);
-        } else {
+        if (!need_bswap) {
             tcg_out_modrm_sib_offset(s, OPC_MOVSWL + P_REXW + seg,
                                      datalo, base, index, 0, ofs);
+        } else {
+            tcg_out_modrm_sib_offset(s, OPC_MOVBE_GyMy + P_DATA16 + seg,
+                                     datalo, base, index, 0, ofs);
+            tcg_out_ext16s(s, datalo, datalo, P_REXW);
         }
         break;
     case MO_UL:
         tcg_out_modrm_sib_offset(s, movop + seg, datalo, base, index, 0, ofs);
-        if (bswap) {
-            tcg_out_bswap32(s, datalo);
-        }
         break;
 #if TCG_TARGET_REG_BITS == 64
     case MO_SL:
-        if (real_bswap) {
-            tcg_out_modrm_sib_offset(s, movop + seg, datalo,
-                                     base, index, 0, ofs);
-            if (bswap) {
-                tcg_out_bswap32(s, datalo);
-            }
-            tcg_out_ext32s(s, datalo, datalo);
-        } else {
+        if (!need_bswap) {
             tcg_out_modrm_sib_offset(s, OPC_MOVSLQ + seg, datalo,
                                      base, index, 0, ofs);
+        } else {
+            tcg_out_modrm_sib_offset(s, OPC_MOVBE_GyMy + seg, datalo,
+                                     base, index, 0, ofs);
+            tcg_out_ext32s(s, datalo, datalo);
         }
         break;
 #endif
@@ -1950,12 +1943,9 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
         if (TCG_TARGET_REG_BITS == 64) {
             tcg_out_modrm_sib_offset(s, movop + P_REXW + seg, datalo,
                                      base, index, 0, ofs);
-            if (bswap) {
-                tcg_out_bswap64(s, datalo);
-            }
         } else {
-            if (real_bswap) {
-                int t = datalo;
+            if (need_bswap) {
+                TCGReg t = datalo;
                 datalo = datahi;
                 datahi = t;
             }
@@ -1970,14 +1960,10 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
                 tcg_out_modrm_sib_offset(s, movop + seg, datalo,
                                          base, index, 0, ofs);
             }
-            if (bswap) {
-                tcg_out_bswap32(s, datalo);
-                tcg_out_bswap32(s, datahi);
-            }
         }
         break;
     default:
-        tcg_abort();
+        g_assert_not_reached();
     }
 }
 
@@ -2053,17 +2039,11 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
                                    TCGReg base, intptr_t ofs, int seg,
                                    TCGMemOp memop)
 {
-    /* ??? Ideally we wouldn't need a scratch register.  For user-only,
-       we could perform the bswap twice to restore the original value
-       instead of moving to the scratch.  But as it is, the L constraint
-       means that TCG_REG_L0 is definitely free here.  */
-    const TCGReg scratch = TCG_REG_L0;
-    const TCGMemOp real_bswap = memop & MO_BSWAP;
-    TCGMemOp bswap = real_bswap;
+    bool need_bswap = memop & MO_BSWAP;
     int movop = OPC_MOVL_EvGv;
 
-    if (have_movbe && real_bswap) {
-        bswap = 0;
+    if (need_bswap) {
+        tcg_debug_assert(have_movbe);
         movop = OPC_MOVBE_MyGy;
     }
 
@@ -2072,46 +2052,24 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
         /* In 32-bit mode, 8-bit stores can only happen from [abcd]x.
            Use the scratch register if necessary.  */
         if (TCG_TARGET_REG_BITS == 32 && datalo >= 4) {
-            tcg_out_mov(s, TCG_TYPE_I32, scratch, datalo);
-            datalo = scratch;
+            tcg_out_mov(s, TCG_TYPE_I32, TCG_REG_L0, datalo);
+            datalo = TCG_REG_L0;
         }
         tcg_out_modrm_offset(s, OPC_MOVB_EvGv + P_REXB_R + seg,
                              datalo, base, ofs);
         break;
     case MO_16:
-        if (bswap) {
-            tcg_out_mov(s, TCG_TYPE_I32, scratch, datalo);
-            tcg_out_rolw_8(s, scratch);
-            datalo = scratch;
-        }
         tcg_out_modrm_offset(s, movop + P_DATA16 + seg, datalo, base, ofs);
         break;
     case MO_32:
-        if (bswap) {
-            tcg_out_mov(s, TCG_TYPE_I32, scratch, datalo);
-            tcg_out_bswap32(s, scratch);
-            datalo = scratch;
-        }
         tcg_out_modrm_offset(s, movop + seg, datalo, base, ofs);
         break;
     case MO_64:
         if (TCG_TARGET_REG_BITS == 64) {
-            if (bswap) {
-                tcg_out_mov(s, TCG_TYPE_I64, scratch, datalo);
-                tcg_out_bswap64(s, scratch);
-                datalo = scratch;
-            }
             tcg_out_modrm_offset(s, movop + P_REXW + seg, datalo, base, ofs);
-        } else if (bswap) {
-            tcg_out_mov(s, TCG_TYPE_I32, scratch, datahi);
-            tcg_out_bswap32(s, scratch);
-            tcg_out_modrm_offset(s, OPC_MOVL_EvGv + seg, scratch, base, ofs);
-            tcg_out_mov(s, TCG_TYPE_I32, scratch, datalo);
-            tcg_out_bswap32(s, scratch);
-            tcg_out_modrm_offset(s, OPC_MOVL_EvGv + seg, scratch, base, ofs+4);
         } else {
-            if (real_bswap) {
-                int t = datalo;
+            if (need_bswap) {
+                TCGReg t = datalo;
                 datalo = datahi;
                 datahi = t;
             }
@@ -2120,7 +2078,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
         }
         break;
     default:
-        tcg_abort();
+        g_assert_not_reached();
     }
 }
 
-- 
2.17.2
