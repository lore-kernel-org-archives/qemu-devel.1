Received: from eggs.gnu.org ([2001:4830:134:3::10]:58950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe1C-0006GV-3w
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:20:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe1A-0007cv-10
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:20:01 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:32917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXe18-0007Bx-46
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:58 -0500
Received: by mail-oi1-x22e.google.com with SMTP id c206so3495368oib.0
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 19:19:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 21:19:11 -0600
Message-Id: <20181214031923.29527-22-richard.henderson@linaro.org>
In-Reply-To: <20181214031923.29527-1-richard.henderson@linaro.org>
References: <20181214031923.29527-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 20/32] tcg/i386: Assume 32-bit values are
 zero-extended
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

We now have an invariant that all TCG_TYPE_I32 values are
zero-extended, which means that we do not need to extend
them again during qemu_ld/st, either explicitly via a separate
tcg_out_ext32u or implicitly via P_ADDR32.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 103 +++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 63 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index fe864e9ef9..f7b548545a 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -309,13 +309,11 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define P_EXT38         0x200           /* 0x0f 0x38 opcode prefix */
 #define P_DATA16        0x400           /* 0x66 opcode prefix */
 #if TCG_TARGET_REG_BITS == 64
-# define P_ADDR32       0x800           /* 0x67 opcode prefix */
 # define P_REXW         0x1000          /* Set REX.W = 1 */
 # define P_REXB_R       0x2000          /* REG field as byte register */
 # define P_REXB_RM      0x4000          /* R/M field as byte register */
 # define P_GS           0x8000          /* gs segment override */
 #else
-# define P_ADDR32	0
 # define P_REXW		0
 # define P_REXB_R	0
 # define P_REXB_RM	0
@@ -528,9 +526,6 @@ static void tcg_out_opc(TCGContext *s, int opc, int r, int rm, int x)
         tcg_debug_assert((opc & P_REXW) == 0);
         tcg_out8(s, 0x66);
     }
-    if (opc & P_ADDR32) {
-        tcg_out8(s, 0x67);
-    }
     if (opc & P_SIMDF3) {
         tcg_out8(s, 0xf3);
     } else if (opc & P_SIMDF2) {
@@ -1659,11 +1654,7 @@ static inline void tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
     tcg_out_modrm_offset(s, OPC_CMP_GvEv + trexw, r1, r0, 0);
 
     /* Prepare for both the fast path add of the tlb addend, and the slow
-       path function argument setup.  There are two cases worth note:
-       For 32-bit guest and x86_64 host, MOVL zero-extends the guest address
-       before the fastpath ADDQ below.  For 64-bit guest and x32 host, MOVQ
-       copies the entire guest address for the slow path, while truncation
-       for the 32-bit host happens with the fastpath ADDL below.  */
+       path function argument setup.  */
     tcg_out_mov(s, ttype, r1, addrlo);
 
     /* jne slow_path */
@@ -2022,41 +2013,31 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is64)
 #else
     {
         int32_t offset = guest_base;
-        TCGReg base = addrlo;
         int index = -1;
         int seg = 0;
 
-        /* For a 32-bit guest, the high 32 bits may contain garbage.
-           We can do this with the ADDR32 prefix if we're not using
-           a guest base, or when using segmentation.  Otherwise we
-           need to zero-extend manually.  */
+        /*
+         * Recall we store 32-bit values zero-extended.  No need for
+         * further manual extension or an addr32 (0x67) prefix.
+         */
         if (guest_base == 0 || guest_base_flags) {
             seg = guest_base_flags;
             offset = 0;
-            if (TCG_TARGET_REG_BITS > TARGET_LONG_BITS) {
-                seg |= P_ADDR32;
-            }
-        } else if (TCG_TARGET_REG_BITS == 64) {
-            if (TARGET_LONG_BITS == 32) {
-                tcg_out_ext32u(s, TCG_REG_L0, base);
-                base = TCG_REG_L0;
-            }
-            if (offset != guest_base) {
-                tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_L1, guest_base);
-                index = TCG_REG_L1;
-                offset = 0;
-            }
+        } else if (TCG_TARGET_REG_BITS == 64 && offset != guest_base) {
+            tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_L1, guest_base);
+            index = TCG_REG_L1;
+            offset = 0;
         }
 
         tcg_out_qemu_ld_direct(s, datalo, datahi,
-                               base, index, offset, seg, is64, opc);
+                               addrlo, index, offset, seg, is64, opc);
     }
 #endif
 }
 
 static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
-                                   TCGReg base, intptr_t ofs, int seg,
-                                   TCGMemOp memop)
+                                   TCGReg base, int index, intptr_t ofs,
+                                   int seg, TCGMemOp memop)
 {
     /* ??? Ideally we wouldn't need a scratch register.  For user-only,
        we could perform the bswap twice to restore the original value
@@ -2080,8 +2061,8 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
             tcg_out_mov(s, TCG_TYPE_I32, scratch, datalo);
             datalo = scratch;
         }
-        tcg_out_modrm_offset(s, OPC_MOVB_EvGv + P_REXB_R + seg,
-                             datalo, base, ofs);
+        tcg_out_modrm_sib_offset(s, OPC_MOVB_EvGv + P_REXB_R + seg,
+                                 datalo, base, index, 0, ofs);
         break;
     case MO_16:
         if (bswap) {
@@ -2089,7 +2070,8 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
             tcg_out_rolw_8(s, scratch);
             datalo = scratch;
         }
-        tcg_out_modrm_offset(s, movop + P_DATA16 + seg, datalo, base, ofs);
+        tcg_out_modrm_sib_offset(s, movop + P_DATA16 + seg, datalo,
+                                 base, index, 0, ofs);
         break;
     case MO_32:
         if (bswap) {
@@ -2097,7 +2079,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
             tcg_out_bswap32(s, scratch);
             datalo = scratch;
         }
-        tcg_out_modrm_offset(s, movop + seg, datalo, base, ofs);
+        tcg_out_modrm_sib_offset(s, movop + seg, datalo, base, index, 0, ofs);
         break;
     case MO_64:
         if (TCG_TARGET_REG_BITS == 64) {
@@ -2106,22 +2088,27 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
                 tcg_out_bswap64(s, scratch);
                 datalo = scratch;
             }
-            tcg_out_modrm_offset(s, movop + P_REXW + seg, datalo, base, ofs);
+            tcg_out_modrm_sib_offset(s, movop + P_REXW + seg, datalo,
+                                     base, index, 0, ofs);
         } else if (bswap) {
             tcg_out_mov(s, TCG_TYPE_I32, scratch, datahi);
             tcg_out_bswap32(s, scratch);
-            tcg_out_modrm_offset(s, OPC_MOVL_EvGv + seg, scratch, base, ofs);
+            tcg_out_modrm_sib_offset(s, OPC_MOVL_EvGv + seg, scratch,
+                                     base, index, 0, ofs);
             tcg_out_mov(s, TCG_TYPE_I32, scratch, datalo);
             tcg_out_bswap32(s, scratch);
-            tcg_out_modrm_offset(s, OPC_MOVL_EvGv + seg, scratch, base, ofs+4);
+            tcg_out_modrm_sib_offset(s, OPC_MOVL_EvGv + seg, scratch,
+                                     base, index, 0, ofs + 4);
         } else {
             if (real_bswap) {
                 int t = datalo;
                 datalo = datahi;
                 datahi = t;
             }
-            tcg_out_modrm_offset(s, movop + seg, datalo, base, ofs);
-            tcg_out_modrm_offset(s, movop + seg, datahi, base, ofs+4);
+            tcg_out_modrm_sib_offset(s, movop + seg, datalo,
+                                     base, index, 0, ofs);
+            tcg_out_modrm_sib_offset(s, movop + seg, datahi,
+                                     base, index, 0, ofs + 4);
         }
         break;
     default:
@@ -2154,7 +2141,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is64)
                      label_ptr, offsetof(CPUTLBEntry, addr_write));
 
     /* TLB Hit.  */
-    tcg_out_qemu_st_direct(s, datalo, datahi, TCG_REG_L1, 0, 0, opc);
+    tcg_out_qemu_st_direct(s, datalo, datahi, TCG_REG_L1, -1, 0, 0, opc);
 
     /* Record the current context of a store into ldst label */
     add_qemu_ldst_label(s, false, is64, oi, datalo, datahi, addrlo, addrhi,
@@ -2162,35 +2149,25 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is64)
 #else
     {
         int32_t offset = guest_base;
-        TCGReg base = addrlo;
+        int index = -1;
         int seg = 0;
 
-        /* See comment in tcg_out_qemu_ld re zero-extension of addrlo.  */
+        /*
+         * Recall we store 32-bit values zero-extended.  No need for
+         * further manual extension or an addr32 (0x67) prefix.
+         */
         if (guest_base == 0 || guest_base_flags) {
             seg = guest_base_flags;
             offset = 0;
-            if (TCG_TARGET_REG_BITS > TARGET_LONG_BITS) {
-                seg |= P_ADDR32;
-            }
-        } else if (TCG_TARGET_REG_BITS == 64) {
-            /* ??? Note that we can't use the same SIB addressing scheme
-               as for loads, since we require L0 free for bswap.  */
-            if (offset != guest_base) {
-                if (TARGET_LONG_BITS == 32) {
-                    tcg_out_ext32u(s, TCG_REG_L0, base);
-                    base = TCG_REG_L0;
-                }
-                tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_L1, guest_base);
-                tgen_arithr(s, ARITH_ADD + P_REXW, TCG_REG_L1, base);
-                base = TCG_REG_L1;
-                offset = 0;
-            } else if (TARGET_LONG_BITS == 32) {
-                tcg_out_ext32u(s, TCG_REG_L1, base);
-                base = TCG_REG_L1;
-            }
+        } else if (TCG_TARGET_REG_BITS == 64 && offset != guest_base) {
+            /* ??? Note that we require L0 free for bswap.  */
+            tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_L1, guest_base);
+            index = TCG_REG_L1;
+            offset = 0;
         }
 
-        tcg_out_qemu_st_direct(s, datalo, datahi, base, offset, seg, opc);
+        tcg_out_qemu_st_direct(s, datalo, datahi,
+                               addrlo, index, offset, seg, opc);
     }
 #endif
 }
-- 
2.17.2
