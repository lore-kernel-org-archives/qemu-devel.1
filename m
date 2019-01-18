Received: from eggs.gnu.org ([209.51.188.92]:42982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbT-0002lL-VV
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbS-0007Mb-Jl
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:39 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:38004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbS-0007Fy-As
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:38 -0500
Received: by mail-wr1-x42e.google.com with SMTP id v13so15437356wrw.5
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.27 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:34 +0000
Message-Id: <20190118145805.6852-19-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/49] target/arm: Decode Load/store register
 (pac)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Not that there are any stores involved, but why argue with ARM's
naming convention.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190108223129.5570-15-richard.henderson@linaro.org
[fixed trivial comment nit]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 61 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index fa50003f0b0..8d8f0a60b38 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3146,6 +3146,64 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
        s->be_data | size | MO_ALIGN);
 }
 
+/*
+ * PAC memory operations
+ *
+ *  31  30      27  26    24    22  21       12  11  10    5     0
+ * +------+-------+---+-----+-----+---+--------+---+---+----+-----+
+ * | size | 1 1 1 | V | 0 0 | M S | 1 |  imm9  | W | 1 | Rn |  Rt |
+ * +------+-------+---+-----+-----+---+--------+---+---+----+-----+
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
@@ -3171,6 +3229,9 @@ static void disas_ldst_reg(DisasContext *s, uint32_t insn)
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
2.20.1
