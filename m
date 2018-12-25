Received: from eggs.gnu.org ([208.118.235.92]:50107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtm0-0005nq-Ox
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:57:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtlx-0008K4-5u
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:57:55 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:46323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtlv-0008Hr-CA
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:57:52 -0500
Received: by mail-pl1-x633.google.com with SMTP id t13so6794296ply.13
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:57:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 07:55:04 +1100
Message-Id: <20181225205529.10874-18-richard.henderson@linaro.org>
In-Reply-To: <20181225205529.10874-1-richard.henderson@linaro.org>
References: <20181225205529.10874-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 17/42] tcg/riscv: Add direct load and store
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
Message-Id: <2e047a95c39c007c66cda024c095e29b0ac4c43e.1545246859.git.alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.inc.c | 158 +++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 7216bad086..154315787c 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -1151,3 +1151,161 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     tcg_out_goto(s, l->raddr);
 }
 #endif /* CONFIG_SOFTMMU */
+
+static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg lo, TCGReg hi,
+                                   TCGReg base, TCGMemOp opc, bool is_64)
+{
+    const TCGMemOp bswap = opc & MO_BSWAP;
+
+    /* We don't yet handle byteswapping, assert */
+    g_assert(!bswap);
+
+    switch (opc & (MO_SSIZE)) {
+    case MO_UB:
+        tcg_out_opc_imm(s, OPC_LBU, lo, base, 0);
+        break;
+    case MO_SB:
+        tcg_out_opc_imm(s, OPC_LB, lo, base, 0);
+        break;
+    case MO_UW:
+        tcg_out_opc_imm(s, OPC_LHU, lo, base, 0);
+        break;
+    case MO_SW:
+        tcg_out_opc_imm(s, OPC_LH, lo, base, 0);
+        break;
+    case MO_UL:
+        if (TCG_TARGET_REG_BITS == 64 && is_64) {
+            tcg_out_opc_imm(s, OPC_LWU, lo, base, 0);
+            break;
+        }
+        /* FALLTHRU */
+    case MO_SL:
+        tcg_out_opc_imm(s, OPC_LW, lo, base, 0);
+        break;
+    case MO_Q:
+        /* Prefer to load from offset 0 first, but allow for overlap.  */
+        if (TCG_TARGET_REG_BITS == 64) {
+            tcg_out_opc_imm(s, OPC_LD, lo, base, 0);
+        } else if (lo != base) {
+            tcg_out_opc_imm(s, OPC_LW, lo, base, 0);
+            tcg_out_opc_imm(s, OPC_LW, hi, base, 4);
+        } else {
+            tcg_out_opc_imm(s, OPC_LW, hi, base, 4);
+            tcg_out_opc_imm(s, OPC_LW, lo, base, 0);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is_64)
+{
+    TCGReg addr_regl, addr_regh __attribute__((unused));
+    TCGReg data_regl, data_regh;
+    TCGMemOpIdx oi;
+    TCGMemOp opc;
+#if defined(CONFIG_SOFTMMU)
+    tcg_insn_unit *label_ptr[1];
+#endif
+    TCGReg base = TCG_REG_TMP0;
+
+    data_regl = *args++;
+    data_regh = (TCG_TARGET_REG_BITS == 32 && is_64 ? *args++ : 0);
+    addr_regl = *args++;
+    addr_regh = (TCG_TARGET_REG_BITS < TARGET_LONG_BITS ? *args++ : 0);
+    oi = *args++;
+    opc = get_memop(oi);
+
+#if defined(CONFIG_SOFTMMU)
+    tcg_out_tlb_load(s, addr_regl, addr_regh, oi, label_ptr, 1);
+    tcg_out_qemu_ld_direct(s, data_regl, data_regh, base, opc, is_64);
+    add_qemu_ldst_label(s, 1, oi,
+                        (is_64 ? TCG_TYPE_I64 : TCG_TYPE_I32),
+                        data_regl, data_regh, addr_regl, addr_regh,
+                        s->code_ptr, label_ptr);
+#else
+    if (TCG_TARGET_REG_BITS > TARGET_LONG_BITS) {
+        tcg_out_ext32u(s, base, addr_regl);
+        addr_regl = base;
+    }
+
+    if (guest_base == 0) {
+        tcg_out_opc_reg(s, OPC_ADD, base, addr_regl, TCG_REG_ZERO);
+    } else {
+        tcg_out_opc_reg(s, OPC_ADD, base, TCG_GUEST_BASE_REG, addr_regl);
+    }
+    tcg_out_qemu_ld_direct(s, data_regl, data_regh, base, opc, is_64);
+#endif
+}
+
+static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg lo, TCGReg hi,
+                                   TCGReg base, TCGMemOp opc)
+{
+    const TCGMemOp bswap = opc & MO_BSWAP;
+
+    /* We don't yet handle byteswapping, assert */
+    g_assert(!bswap);
+
+    switch (opc & (MO_SSIZE)) {
+    case MO_8:
+        tcg_out_opc_store(s, OPC_SB, base, lo, 0);
+        break;
+    case MO_16:
+        tcg_out_opc_store(s, OPC_SH, base, lo, 0);
+        break;
+    case MO_32:
+        tcg_out_opc_store(s, OPC_SW, base, lo, 0);
+        break;
+    case MO_64:
+        if (TCG_TARGET_REG_BITS == 64) {
+            tcg_out_opc_store(s, OPC_SD, base, lo, 0);
+        } else {
+            tcg_out_opc_store(s, OPC_SW, base, lo, 0);
+            tcg_out_opc_store(s, OPC_SW, base, hi, 4);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is_64)
+{
+    TCGReg addr_regl, addr_regh __attribute__((unused));
+    TCGReg data_regl, data_regh;
+    TCGMemOpIdx oi;
+    TCGMemOp opc;
+#if defined(CONFIG_SOFTMMU)
+    tcg_insn_unit *label_ptr[1];
+#endif
+    TCGReg base = TCG_REG_TMP0;
+
+    data_regl = *args++;
+    data_regh = (TCG_TARGET_REG_BITS == 32 && is_64 ? *args++ : 0);
+    addr_regl = *args++;
+    addr_regh = (TCG_TARGET_REG_BITS < TARGET_LONG_BITS ? *args++ : 0);
+    oi = *args++;
+    opc = get_memop(oi);
+
+#if defined(CONFIG_SOFTMMU)
+    tcg_out_tlb_load(s, addr_regl, addr_regh, oi, label_ptr, 0);
+    tcg_out_qemu_st_direct(s, data_regl, data_regh, base, opc);
+    add_qemu_ldst_label(s, 0, oi,
+                        (is_64 ? TCG_TYPE_I64 : TCG_TYPE_I32),
+                        data_regl, data_regh, addr_regl, addr_regh,
+                        s->code_ptr, label_ptr);
+#else
+    if (TCG_TARGET_REG_BITS > TARGET_LONG_BITS) {
+        tcg_out_ext32u(s, base, addr_regl);
+        addr_regl = base;
+    }
+
+    if (guest_base == 0) {
+        tcg_out_opc_reg(s, OPC_ADD, base, addr_regl, TCG_REG_ZERO);
+    } else {
+        tcg_out_opc_reg(s, OPC_ADD, base, TCG_GUEST_BASE_REG, addr_regl);
+    }
+    tcg_out_qemu_st_direct(s, data_regl, data_regh, base, opc);
+#endif
+}
-- 
2.17.2
