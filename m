Received: from eggs.gnu.org ([2001:4830:134:3::10]:39220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cP08B-0007rr-W7
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 23:58:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cP088-0002f1-6U
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 23:58:28 -0500
Received: from [114.242.206.163] (port=60092 helo=mail.loongson.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cP087-0002be-BR
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 23:58:24 -0500
From: Jin Guojie <jinguojie@loongson.cn>
Date: Thu,  5 Jan 2017 12:57:50 +0800
Message-Id: <1483592275-4496-6-git-send-email-jinguojie@loongson.cn>
In-Reply-To: <1483592275-4496-1-git-send-email-jinguojie@loongson.cn>
References: <1483592275-4496-1-git-send-email-jinguojie@loongson.cn>
Subject: [Qemu-devel] [PATCH v6 RESEND 05/10] tcg-mips: Adjust move
 functions for mips64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, James Hogan <james.hogan@imgtec.com>, YunQiang Su <wzssyqa@gmail.com>, Richard Henderson <rth@twiddle.net>, Jin Guojie <jinguojie@loongson.cn>

tcg_out_mov: using OPC_OR as most mips assemblers do;
tcg_out_movi: extended to 64-bit immediate.

Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Tested-by: James Hogan <james.hogan@imgtec.com>
Tested-by: YunQiang Su <wzssyqa@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Jin Guojie <jinguojie@loongson.cn>
---
 tcg/mips/tcg-target.inc.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index ec139cd..18368f0 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -544,23 +544,39 @@ static inline void tcg_out_mov(TCGContext *s, TCGType type,
 {
     /* Simple reg-reg move, optimising out the 'do nothing' case */
     if (ret != arg) {
-        tcg_out_opc_reg(s, OPC_ADDU, ret, arg, TCG_REG_ZERO);
+        tcg_out_opc_reg(s, OPC_OR, ret, arg, TCG_REG_ZERO);
     }
 }
 
-static inline void tcg_out_movi(TCGContext *s, TCGType type,
-                                TCGReg reg, tcg_target_long arg)
+static void tcg_out_movi(TCGContext *s, TCGType type,
+                         TCGReg ret, tcg_target_long arg)
 {
+    if (TCG_TARGET_REG_BITS == 64 && type == TCG_TYPE_I32) {
+        arg = (int32_t)arg;
+    }
     if (arg == (int16_t)arg) {
-        tcg_out_opc_imm(s, OPC_ADDIU, reg, TCG_REG_ZERO, arg);
-    } else if (arg == (uint16_t)arg) {
-        tcg_out_opc_imm(s, OPC_ORI, reg, TCG_REG_ZERO, arg);
+        tcg_out_opc_imm(s, OPC_ADDIU, ret, TCG_REG_ZERO, arg);
+        return;
+    }
+    if (arg == (uint16_t)arg) {
+        tcg_out_opc_imm(s, OPC_ORI, ret, TCG_REG_ZERO, arg);
+        return;
+    }
+    if (TCG_TARGET_REG_BITS == 32 || arg == (int32_t)arg) {
+        tcg_out_opc_imm(s, OPC_LUI, ret, TCG_REG_ZERO, arg >> 16);
     } else {
-        tcg_out_opc_imm(s, OPC_LUI, reg, TCG_REG_ZERO, arg >> 16);
-        if (arg & 0xffff) {
-            tcg_out_opc_imm(s, OPC_ORI, reg, reg, arg & 0xffff);
+        tcg_out_movi(s, TCG_TYPE_I32, ret, arg >> 31 >> 1);
+        if (arg & 0xffff0000ull) {
+            tcg_out_dsll(s, ret, ret, 16);
+            tcg_out_opc_imm(s, OPC_ORI, ret, ret, arg >> 16);
+            tcg_out_dsll(s, ret, ret, 16);
+        } else {
+            tcg_out_dsll(s, ret, ret, 32);
         }
     }
+    if (arg & 0xffff) {
+        tcg_out_opc_imm(s, OPC_ORI, ret, ret, arg & 0xffff);
+    }
 }
 
 static inline void tcg_out_bswap16(TCGContext *s, TCGReg ret, TCGReg arg)
-- 
2.1.0
