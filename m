Received: from eggs.gnu.org ([2001:4830:134:3::10]:35358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTqm8-0001ZO-CN
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:08:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTqm6-0003Ni-QE
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:08:48 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gTqm6-0003NT-Lq
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:08:46 -0500
Received: by mail-oi1-x244.google.com with SMTP id x202so11327176oif.13
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 08:08:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  3 Dec 2018 10:08:36 -0600
Message-Id: <20181203160840.15115-2-richard.henderson@linaro.org>
In-Reply-To: <20181203160840.15115-1-richard.henderson@linaro.org>
References: <20181203160840.15115-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 1/5] tcg/i386: Propagate is64 to
 tcg_out_qemu_ld_direct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, alex.bennee@linaro.org

This helps preserve the invariant that all TCG_TYPE_I32 values
are stored zero-extended in the 64-bit host registers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 28192f4608..6bf4f84b20 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -1883,10 +1883,11 @@ static inline void setup_guest_base_seg(void) { }
 
 static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
                                    TCGReg base, int index, intptr_t ofs,
-                                   int seg, TCGMemOp memop)
+                                   int seg, bool is64, TCGMemOp memop)
 {
     const TCGMemOp real_bswap = memop & MO_BSWAP;
     TCGMemOp bswap = real_bswap;
+    int rexw = is64 * P_REXW;
     int movop = OPC_MOVL_GvEv;
 
     if (have_movbe && real_bswap) {
@@ -1900,7 +1901,7 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
                                  base, index, 0, ofs);
         break;
     case MO_SB:
-        tcg_out_modrm_sib_offset(s, OPC_MOVSBL + P_REXW + seg, datalo,
+        tcg_out_modrm_sib_offset(s, OPC_MOVSBL + rexw + seg, datalo,
                                  base, index, 0, ofs);
         break;
     case MO_UW:
@@ -1920,9 +1921,9 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
                                          base, index, 0, ofs);
                 tcg_out_rolw_8(s, datalo);
             }
-            tcg_out_modrm(s, OPC_MOVSWL + P_REXW, datalo, datalo);
+            tcg_out_modrm(s, OPC_MOVSWL + rexw, datalo, datalo);
         } else {
-            tcg_out_modrm_sib_offset(s, OPC_MOVSWL + P_REXW + seg,
+            tcg_out_modrm_sib_offset(s, OPC_MOVSWL + rexw + seg,
                                      datalo, base, index, 0, ofs);
         }
         break;
@@ -2010,7 +2011,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is64)
                      label_ptr, offsetof(CPUTLBEntry, addr_read));
 
     /* TLB Hit.  */
-    tcg_out_qemu_ld_direct(s, datalo, datahi, TCG_REG_L1, -1, 0, 0, opc);
+    tcg_out_qemu_ld_direct(s, datalo, datahi, TCG_REG_L1, -1, 0, 0, is64, opc);
 
     /* Record the current context of a load into ldst label */
     add_qemu_ldst_label(s, true, oi, datalo, datahi, addrlo, addrhi,
@@ -2045,7 +2046,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is64)
         }
 
         tcg_out_qemu_ld_direct(s, datalo, datahi,
-                               base, index, offset, seg, opc);
+                               base, index, offset, seg, is64, opc);
     }
 #endif
 }
-- 
2.17.2
