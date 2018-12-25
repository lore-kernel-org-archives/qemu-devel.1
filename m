Received: from eggs.gnu.org ([208.118.235.92]:49955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtlY-0005Hd-Jf
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:57:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtlX-0007yp-M9
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:57:28 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:40551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtlX-0007xa-Fr
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:57:27 -0500
Received: by mail-pl1-x62f.google.com with SMTP id u18so6802375plq.7
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:57:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 07:55:01 +1100
Message-Id: <20181225205529.10874-15-richard.henderson@linaro.org>
In-Reply-To: <20181225205529.10874-1-richard.henderson@linaro.org>
References: <20181225205529.10874-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 14/42] tcg/riscv: Add the add2 and sub2
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair.francis@wdc.com>

From: Alistair Francis <Alistair.Francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <5665a57809e32b35775e8e98fdab898853af37b8.1545246859.git.alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.inc.c | 55 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 65718df7ad..5da850b957 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -695,3 +695,58 @@ static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
     }
     return false;
 }
+
+static void tcg_out_addsub2(TCGContext *s,
+                            TCGReg rl, TCGReg rh,
+                            TCGReg al, TCGReg ah,
+                            TCGArg bl, TCGArg bh,
+                            bool cbl, bool cbh, bool is_sub, bool is32bit)
+{
+    const RISCVInsn opc_add = is32bit ? OPC_ADDW : OPC_ADD;
+    const RISCVInsn opc_addi = is32bit ? OPC_ADDIW : OPC_ADDI;
+    const RISCVInsn opc_sub = is32bit ? OPC_SUBW : OPC_SUB;
+    TCGReg th = TCG_REG_TMP1;
+
+    /* If we have a negative constant such that negating it would
+       make the high part zero, we can (usually) eliminate one insn.  */
+    if (cbl && cbh && bh == -1 && bl != 0) {
+        bl = -bl;
+        bh = 0;
+        is_sub = !is_sub;
+    }
+
+    /* By operating on the high part first, we get to use the final
+       carry operation to move back from the temporary.  */
+    if (!cbh) {
+        tcg_out_opc_reg(s, (is_sub ? opc_sub : opc_add), th, ah, bh);
+    } else if (bh != 0 || ah == rl) {
+        tcg_out_opc_imm(s, opc_addi, th, ah, (is_sub ? -bh : bh));
+    } else {
+        th = ah;
+    }
+
+    /* Note that tcg optimization should eliminate the bl == 0 case.  */
+    if (is_sub) {
+        if (cbl) {
+            tcg_out_opc_imm(s, OPC_SLTIU, TCG_REG_TMP0, al, bl);
+            tcg_out_opc_imm(s, opc_addi, rl, al, -bl);
+        } else {
+            tcg_out_opc_reg(s, OPC_SLTU, TCG_REG_TMP0, al, bl);
+            tcg_out_opc_reg(s, opc_sub, rl, al, bl);
+        }
+        tcg_out_opc_reg(s, opc_sub, rh, th, TCG_REG_TMP0);
+    } else {
+        if (cbl) {
+            tcg_out_opc_imm(s, opc_addi, rl, al, bl);
+            tcg_out_opc_imm(s, OPC_SLTIU, TCG_REG_TMP0, rl, bl);
+        } else if (rl == al && rl == bl) {
+            tcg_out_opc_imm(s, OPC_SLTI, TCG_REG_TMP0, al, 0);
+            tcg_out_opc_reg(s, opc_addi, rl, al, bl);
+        } else {
+            tcg_out_opc_reg(s, opc_add, rl, al, bl);
+            tcg_out_opc_reg(s, OPC_SLTU, TCG_REG_TMP0,
+                            rl, (rl == bl ? al : bl));
+        }
+        tcg_out_opc_reg(s, opc_add, rh, th, TCG_REG_TMP0);
+    }
+}
-- 
2.17.2
