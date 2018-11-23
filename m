Received: from eggs.gnu.org ([2001:4830:134:3::10]:44137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCj1-0000EB-M9
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCiw-0003Xg-5p
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:30 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gQCiu-0003Rv-MR
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:25 -0500
Received: by mail-wr1-x443.google.com with SMTP id l9so12570617wrt.13
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 06:46:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 23 Nov 2018 15:45:42 +0100
Message-Id: <20181123144558.5048-22-richard.henderson@linaro.org>
In-Reply-To: <20181123144558.5048-1-richard.henderson@linaro.org>
References: <20181123144558.5048-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 v2 21/37] tcg/ppc: Split out
 tcg_out_call_int
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

Pass in a LK parameter, allowing us to create tail calls.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.inc.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 6e656cd41e..6377e3a829 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -1408,7 +1408,7 @@ void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
     }
 }
 
-static void tcg_out_call(TCGContext *s, tcg_insn_unit *target)
+static void tcg_out_call_int(TCGContext *s, tcg_insn_unit *target, int lk)
 {
 #ifdef _CALL_AIX
     /* Look through the descriptor.  If the branch is in range, and we
@@ -1419,7 +1419,7 @@ static void tcg_out_call(TCGContext *s, tcg_insn_unit *target)
 
     if (in_range_b(diff) && toc == (uint32_t)toc) {
         tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP1, toc);
-        tcg_out_b(s, LK, tgt);
+        tcg_out_b(s, lk, tgt);
     } else {
         /* Fold the low bits of the constant into the addresses below.  */
         intptr_t arg = (intptr_t)target;
@@ -1434,7 +1434,7 @@ static void tcg_out_call(TCGContext *s, tcg_insn_unit *target)
         tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_R0, TCG_REG_TMP1, ofs);
         tcg_out32(s, MTSPR | RA(TCG_REG_R0) | CTR);
         tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_R2, TCG_REG_TMP1, ofs + SZP);
-        tcg_out32(s, BCCTR | BO_ALWAYS | LK);
+        tcg_out32(s, BCCTR | BO_ALWAYS | lk);
     }
 #elif defined(_CALL_ELF) && _CALL_ELF == 2
     intptr_t diff;
@@ -1448,16 +1448,21 @@ static void tcg_out_call(TCGContext *s, tcg_insn_unit *target)
 
     diff = tcg_pcrel_diff(s, target);
     if (in_range_b(diff)) {
-        tcg_out_b(s, LK, target);
+        tcg_out_b(s, lk, target);
     } else {
         tcg_out32(s, MTSPR | RS(TCG_REG_R12) | CTR);
-        tcg_out32(s, BCCTR | BO_ALWAYS | LK);
+        tcg_out32(s, BCCTR | BO_ALWAYS | lk);
     }
 #else
-    tcg_out_b(s, LK, target);
+    tcg_out_b(s, lk, target);
 #endif
 }
 
+static void tcg_out_call(TCGContext *s, tcg_insn_unit *target)
+{
+    tcg_out_call_int(s, target, LK);
+}
+
 static const uint32_t qemu_ldx_opc[16] = {
     [MO_UB] = LBZX,
     [MO_UW] = LHZX,
-- 
2.17.2
