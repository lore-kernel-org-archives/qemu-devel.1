Received: from eggs.gnu.org ([208.118.235.92]:49809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtl4-0004gA-Kv
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:57:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtl3-0007SK-Q1
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:56:58 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:45256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtl3-0007R1-KE
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:56:57 -0500
Received: by mail-pg1-x532.google.com with SMTP id y4so6808093pgc.12
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:56:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 07:54:57 +1100
Message-Id: <20181225205529.10874-11-richard.henderson@linaro.org>
In-Reply-To: <20181225205529.10874-1-richard.henderson@linaro.org>
References: <20181225205529.10874-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 10/42] tcg/riscv: Add the relocation functions
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
Message-Id: <6ac4f4b0d5ea93cb0ee9a3b8b47ee9f7b3711494.1545246859.git.alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.inc.c | 88 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index d198cfd5f7..a26744052f 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -422,3 +422,91 @@ static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
         p[i] = encode_i(OPC_ADDI, TCG_REG_ZERO, TCG_REG_ZERO, 0);
     }
 }
+
+/*
+ * Relocations
+ */
+
+static bool reloc_sbimm12(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+{
+    intptr_t offset = (intptr_t)target - (intptr_t)code_ptr;
+
+    if (offset == sextreg(offset, 1, 12) << 1) {
+        code_ptr[0] |= encode_sbimm12(offset);
+        return true;
+    }
+
+    return false;
+}
+
+static bool reloc_jimm20(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+{
+    intptr_t offset = (intptr_t)target - (intptr_t)code_ptr;
+
+    if (offset == sextreg(offset, 1, 20) << 1) {
+        code_ptr[0] |= encode_ujimm20(offset);
+        return true;
+    }
+
+    return false;
+}
+
+static bool reloc_call(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+{
+    intptr_t offset = (intptr_t)target - (intptr_t)code_ptr;
+    int32_t lo = sextreg(offset, 0, 12);
+    int32_t hi = offset - lo;
+
+    if (offset == hi + lo) {
+        code_ptr[0] |= encode_uimm20(hi);
+        code_ptr[1] |= encode_imm12(lo);
+        return true;
+    }
+
+    return false;
+}
+
+static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
+                        intptr_t value, intptr_t addend)
+{
+    uint32_t insn = *code_ptr;
+    intptr_t diff;
+    bool short_jmp;
+
+    tcg_debug_assert(addend == 0);
+
+    switch (type) {
+    case R_RISCV_BRANCH:
+        diff = value - (uintptr_t)code_ptr;
+        short_jmp = diff == sextreg(diff, 0, 12);
+        if (short_jmp) {
+            return reloc_sbimm12(code_ptr, (tcg_insn_unit *)value);
+        } else {
+            /* Invert the condition */
+            insn = insn ^ (1 << 12);
+            /* Clear the offset */
+            insn &= 0x01fff07f;
+            /* Set the offset to the PC + 8 */
+            insn |= encode_sbimm12(8);
+
+            /* Move forward */
+            code_ptr[0] = insn;
+
+            /* Overwrite the NOP with jal x0,value */
+            diff = value - (uintptr_t)(code_ptr + 1);
+            insn = encode_uj(OPC_JAL, TCG_REG_ZERO, diff);
+            code_ptr[1] = insn;
+
+            return true;
+        }
+        break;
+    case R_RISCV_JAL:
+        return reloc_jimm20(code_ptr, (tcg_insn_unit *)value);
+        break;
+    case R_RISCV_CALL:
+        return reloc_call(code_ptr, (tcg_insn_unit *)value);
+        break;
+    default:
+        tcg_abort();
+    }
+}
-- 
2.17.2
