Received: from eggs.gnu.org ([208.118.235.92]:49850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtlB-0004qN-Sv
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:57:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtlA-0007aE-Tm
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:57:05 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:39961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtlA-0007ZO-Nb
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:57:04 -0500
Received: by mail-pl1-x643.google.com with SMTP id u18so6802209plq.7
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:57:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 07:54:58 +1100
Message-Id: <20181225205529.10874-12-richard.henderson@linaro.org>
In-Reply-To: <20181225205529.10874-1-richard.henderson@linaro.org>
References: <20181225205529.10874-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 11/42] tcg/riscv: Add the mov and movi
 instruction
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
Message-Id: <bd6a45c73a67b77ddaa2fe590a6bb8ee422b9683.1545246859.git.alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.inc.c | 86 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index a26744052f..01b4443d6d 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -510,3 +510,89 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
         tcg_abort();
     }
 }
+
+/*
+ * TCG intrinsics
+ */
+
+static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
+{
+    if (ret == arg) {
+        return;
+    }
+    switch (type) {
+    case TCG_TYPE_I32:
+    case TCG_TYPE_I64:
+        tcg_out_opc_imm(s, OPC_ADDI, ret, arg, 0);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
+                         tcg_target_long val)
+{
+    tcg_target_long lo, hi, tmp;
+    int shift, ret;
+
+    if (TCG_TARGET_REG_BITS == 64 && type == TCG_TYPE_I32) {
+        val = (int32_t)val;
+    }
+
+    lo = sextreg(val, 0, 12);
+    if (val == lo) {
+        tcg_out_opc_imm(s, OPC_ADDI, rd, TCG_REG_ZERO, lo);
+        return;
+    }
+
+    hi = val - lo;
+    if (TCG_TARGET_REG_BITS == 32 || val == (int32_t)val) {
+        tcg_out_opc_upper(s, OPC_LUI, rd, hi);
+        if (lo != 0) {
+            tcg_out_opc_imm(s, OPC_ADDIW, rd, rd, lo);
+        }
+        return;
+    }
+
+    /* We can only be here if TCG_TARGET_REG_BITS != 32 */
+    tmp = tcg_pcrel_diff(s, (void *)val);
+    if (tmp == (int32_t)tmp) {
+        tcg_out_opc_upper(s, OPC_AUIPC, rd, 0);
+        tcg_out_opc_imm(s, OPC_ADDI, rd, rd, 0);
+        ret = reloc_call(s->code_ptr - 2, (tcg_insn_unit *)val);
+        tcg_debug_assert(ret == true);
+        return;
+    }
+
+    /* Look for a single 20-bit section.  */
+    shift = ctz64(val);
+    tmp = val >> shift;
+    if (tmp == sextreg(tmp, 0, 20)) {
+        tcg_out_opc_upper(s, OPC_LUI, rd, tmp << 12);
+        if (shift > 12) {
+            tcg_out_opc_imm(s, OPC_SLLI, rd, rd, shift - 12);
+        } else {
+            tcg_out_opc_imm(s, OPC_SRAI, rd, rd, 12 - shift);
+        }
+        return;
+    }
+
+    /* Look for a few high zero bits, with lots of bits set in the middle.  */
+    shift = clz64(val);
+    tmp = val << shift;
+    if (tmp == sextreg(tmp, 12, 20) << 12) {
+        tcg_out_opc_upper(s, OPC_LUI, rd, tmp);
+        tcg_out_opc_imm(s, OPC_SRLI, rd, rd, shift);
+        return;
+    } else if (tmp == sextreg(tmp, 0, 12)) {
+        tcg_out_opc_imm(s, OPC_ADDI, rd, TCG_REG_ZERO, tmp);
+        tcg_out_opc_imm(s, OPC_SRLI, rd, rd, shift);
+        return;
+    }
+
+    /* Drop into the constant pool.  */
+    new_pool_label(s, val, R_RISCV_CALL, s->code_ptr, 0);
+    tcg_out_opc_upper(s, OPC_AUIPC, rd, 0);
+    tcg_out_opc_imm(s, OPC_LD, rd, rd, 0);
+}
-- 
2.17.2
