Received: from eggs.gnu.org ([2001:4830:134:3::10]:44272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCj6-0000Hj-RR
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCj4-0003lo-Su
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:35 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:32861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gQCj4-0003iu-Ki
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:34 -0500
Received: by mail-wr1-x441.google.com with SMTP id c14so6956475wrr.0
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 06:46:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 23 Nov 2018 15:45:54 +0100
Message-Id: <20181123144558.5048-34-richard.henderson@linaro.org>
In-Reply-To: <20181123144558.5048-1-richard.henderson@linaro.org>
References: <20181123144558.5048-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 v2 33/37] tcg/i386: Propagate is64 to
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
Cc: Alistair.Francis@wdc.com

This can save a few rex prefixes for qemu_ld_i32.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 76235e90c9..5cad31cfe5 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -1815,10 +1815,11 @@ static inline void setup_guest_base_seg(void) { }
 
 static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
                                    TCGReg base, int index, intptr_t ofs,
-                                   int seg, TCGMemOp memop)
+                                   int seg, bool is64, TCGMemOp memop)
 {
     bool use_bswap = memop & MO_BSWAP;
     bool use_movbe = false;
+    int rexw = is64 * P_REXW;
     int movop = OPC_MOVL_GvEv;
 
     /*
@@ -1843,7 +1844,7 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
                                  base, index, 0, ofs);
         break;
     case MO_SB:
-        tcg_out_modrm_sib_offset(s, OPC_MOVSBL + P_REXW + seg, datalo,
+        tcg_out_modrm_sib_offset(s, OPC_MOVSBL + rexw + seg, datalo,
                                  base, index, 0, ofs);
         break;
     case MO_UW:
@@ -1871,14 +1872,15 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
         if (use_movbe) {
             tcg_out_modrm_sib_offset(s, OPC_MOVBE_GyMy + P_DATA16 + seg,
                                      datalo, base, index, 0, ofs);
-            tcg_out_ext16s(s, datalo, datalo, P_REXW);
-        } else {
-            tcg_out_modrm_sib_offset(s, OPC_MOVSWL + P_REXW + seg,
+            tcg_out_ext16s(s, datalo, datalo, rexw);
+        } else if (use_bswap) {
+            tcg_out_modrm_sib_offset(s, OPC_MOVSWL + seg,
+                                     datalo, base, index, 0, ofs);
+            tcg_out_rolw_8(s, datalo);
+            tcg_out_ext16s(s, datalo, datalo, rexw);
+        } else {
+            tcg_out_modrm_sib_offset(s, OPC_MOVSWL + rexw + seg,
                                      datalo, base, index, 0, ofs);
-            if (use_bswap) {
-                tcg_out_rolw_8(s, datalo);
-                tcg_out_ext16s(s, datalo, datalo, P_REXW);
-            }
         }
         break;
     case MO_UL:
@@ -2004,7 +2006,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is64)
         }
 
         tcg_out_qemu_ld_direct(s, datalo, datahi,
-                               base, index, offset, seg, opc);
+                               base, index, offset, seg, is64, opc);
     }
 #endif
 }
@@ -2202,7 +2204,7 @@ static tcg_insn_unit *tcg_out_qemu_ldst_ool(TCGContext *s, bool is_ld,
 
     /* TLB Hit.  */
     if (is_ld) {
-        tcg_out_qemu_ld_direct(s, datalo, datahi, base, -1, 0, 0, opc);
+        tcg_out_qemu_ld_direct(s, datalo, datahi, base, -1, 0, 0, is_64, opc);
     } else {
         tcg_out_qemu_st_direct(s, datalo, datahi, base, 0, 0, opc);
     }
-- 
2.17.2
