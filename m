Received: from eggs.gnu.org ([209.51.188.92]:52728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzv7-0000Cd-A6
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzv5-0004mo-8i
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:25 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ggzv4-0004d4-Jz
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:22 -0500
Received: by mail-pf1-x443.google.com with SMTP id y126so2620202pfb.4
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 14:32:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 Jan 2019 08:31:12 +1000
Message-Id: <20190108223129.5570-15-richard.henderson@linaro.org>
In-Reply-To: <20190108223129.5570-1-richard.henderson@linaro.org>
References: <20190108223129.5570-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 14/31] target/arm: Decode Load/store
 register (pac)
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

Not that there are any stores involved, but why argue with ARM's
naming convention.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Use do_gpr_ld; fix sextend typo; iss_valid only for !wback.
---
 target/arm/translate-a64.c | 60 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index fa50003f0b..a4dfdf5836 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3146,6 +3146,63 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
        s->be_data | size | MO_ALIGN);
 }
 
+/* PAC memory operations
+ *
+ *  31  30      27  26    24    22  21       12  11  10    5     0
+ * +------+-------+---+-----+-----+---+--------+---+---+----+-----+
+ * | size | 1 1 1 | V | 0 0 | M S | 1 |  imm9  | W | 1 | Rn |  Rt |
+ * +------+-------+---+-----+-----+------------+---+---+----+-----+
+ *
+ * Rt: the result register
+ * Rn: base address or SP
+ * V: vector flag (always 0 as of v8.3)
+ * M: clear for key DA, set for key DB
+ * W: pre-indexing flag
+ * S: sign for imm9.
+ */
+static void disas_ldst_pac(DisasContext *s, uint32_t insn,
+                           int size, int rt, bool is_vector)
+{
+    int rn = extract32(insn, 5, 5);
+    bool is_wback = extract32(insn, 11, 1);
+    bool use_key_a = !extract32(insn, 23, 1);
+    int offset;
+    TCGv_i64 tcg_addr, tcg_rt;
+
+    if (size != 3 || is_vector || !dc_isar_feature(aa64_pauth, s)) {
+        unallocated_encoding(s);
+        return;
+    }
+
+    if (rn == 31) {
+        gen_check_sp_alignment(s);
+    }
+    tcg_addr = read_cpu_reg_sp(s, rn, 1);
+
+    if (s->pauth_active) {
+        if (use_key_a) {
+            gen_helper_autda(tcg_addr, cpu_env, tcg_addr, cpu_X[31]);
+        } else {
+            gen_helper_autdb(tcg_addr, cpu_env, tcg_addr, cpu_X[31]);
+        }
+    }
+
+    /* Form the 10-bit signed, scaled offset.  */
+    offset = (extract32(insn, 22, 1) << 9) | extract32(insn, 12, 9);
+    offset = sextract32(offset << size, 0, 10 + size);
+    tcg_gen_addi_i64(tcg_addr, tcg_addr, offset);
+
+    tcg_rt = cpu_reg(s, rt);
+
+    do_gpr_ld(s, tcg_rt, tcg_addr, size, /* is_signed */ false,
+              /* extend */ false, /* iss_valid */ !is_wback,
+              /* iss_srt */ rt, /* iss_sf */ true, /* iss_ar */ false);
+
+    if (is_wback) {
+        tcg_gen_mov_i64(cpu_reg_sp(s, rn), tcg_addr);
+    }
+}
+
 /* Load/store register (all forms) */
 static void disas_ldst_reg(DisasContext *s, uint32_t insn)
 {
@@ -3171,6 +3228,9 @@ static void disas_ldst_reg(DisasContext *s, uint32_t insn)
         case 2:
             disas_ldst_reg_roffset(s, insn, opc, size, rt, is_vector);
             return;
+        default:
+            disas_ldst_pac(s, insn, size, rt, is_vector);
+            return;
         }
         break;
     case 1:
-- 
2.17.2
