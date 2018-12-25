Received: from eggs.gnu.org ([208.118.235.92]:49940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtlX-0005GJ-G0
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:57:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtlR-0007rF-Jb
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:57:27 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:34338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtlQ-0007pJ-P3
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:57:21 -0500
Received: by mail-pf1-x42b.google.com with SMTP id h3so7091001pfg.1
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:57:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 07:55:00 +1100
Message-Id: <20181225205529.10874-14-richard.henderson@linaro.org>
In-Reply-To: <20181225205529.10874-1-richard.henderson@linaro.org>
References: <20181225205529.10874-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 13/42] tcg/riscv: Add the out load and store
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
Cc: peter.maydell@linaro.org, Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair.francis@wdc.com>, Michael Clark <mjc@sifive.com>

From: Alistair Francis <Alistair.Francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <d5d88ff29163788938368bbdbd18815d59cef6a0.1545246859.git.alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.inc.c | 65 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 48399480b2..65718df7ad 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -630,3 +630,68 @@ static void tcg_out_ext32s(TCGContext *s, TCGReg ret, TCGReg arg)
 {
     tcg_out_opc_imm(s, OPC_ADDIW, ret, arg, 0);
 }
+
+static void tcg_out_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
+                         TCGReg addr, intptr_t offset)
+{
+    intptr_t imm12 = sextreg(offset, 0, 12);
+
+    if (offset != imm12) {
+        intptr_t diff = offset - (uintptr_t)s->code_ptr;
+
+        if (addr == TCG_REG_ZERO && diff == (int32_t)diff) {
+            imm12 = sextreg(diff, 0, 12);
+            tcg_out_opc_upper(s, OPC_AUIPC, TCG_REG_TMP2, diff - imm12);
+        } else {
+            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP2, offset - imm12);
+            if (addr != TCG_REG_ZERO) {
+                tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP2, TCG_REG_TMP2, addr);
+            }
+        }
+        addr = TCG_REG_TMP2;
+    }
+
+    switch (opc) {
+    case OPC_SB:
+    case OPC_SH:
+    case OPC_SW:
+    case OPC_SD:
+        tcg_out_opc_store(s, opc, addr, data, imm12);
+        break;
+    case OPC_LB:
+    case OPC_LBU:
+    case OPC_LH:
+    case OPC_LHU:
+    case OPC_LW:
+    case OPC_LWU:
+    case OPC_LD:
+        tcg_out_opc_imm(s, opc, data, addr, imm12);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg arg,
+                       TCGReg arg1, intptr_t arg2)
+{
+    bool is32bit = (TCG_TARGET_REG_BITS == 32 || type == TCG_TYPE_I32);
+    tcg_out_ldst(s, is32bit ? OPC_LW : OPC_LD, arg, arg1, arg2);
+}
+
+static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
+                       TCGReg arg1, intptr_t arg2)
+{
+    bool is32bit = (TCG_TARGET_REG_BITS == 32 || type == TCG_TYPE_I32);
+    tcg_out_ldst(s, is32bit ? OPC_SW : OPC_SD, arg, arg1, arg2);
+}
+
+static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
+                        TCGReg base, intptr_t ofs)
+{
+    if (val == 0) {
+        tcg_out_st(s, type, TCG_REG_ZERO, base, ofs);
+        return true;
+    }
+    return false;
+}
-- 
2.17.2
