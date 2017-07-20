Received: from eggs.gnu.org ([2001:4830:134:3::10]:53570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD0X-0004TW-5m
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD0V-0007vg-Hc
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:04:53 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:36854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYD0V-0007uY-9f
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:04:51 -0400
Received: by mail-wr0-x231.google.com with SMTP id y43so71957817wrd.3
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:04:51 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 20 Jul 2017 16:04:14 +0100
Message-Id: <20170720150426.12393-12-alex.bennee@linaro.org>
In-Reply-To: <20170720150426.12393-1-alex.bennee@linaro.org>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for 2.11 11/23] target/arm/translate-a64.c:
 AdvSIMD scalar 3 Same FP16 initial decode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: rth@twiddle.net, qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This is the initial decode skeleton for the Advanced SIMD scalar
three same instruction group. The fprintf is purely to aid debugging
as the additional instructions are added. It will be removed once the
group is complete.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/translate-a64.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 68099fdb5e..c766829ff9 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -9709,6 +9709,81 @@ static void disas_simd_three_reg_same(DisasContext *s, uint32_t insn)
     }
 }
 
+/*
+ * Advanced SIMD three same (ARMv8.2 FP16 variants)
+ *
+ *  31  30  29  28       24 23  22 21 20  16 15 14 13    11 10  9    5 4    0
+ * +---+---+---+-----------+---------+------+-----+--------+---+------+------+
+ * | 0 | Q | U | 0 1 1 1 0 | a | 1 0 |  Rm  | 0 0 | opcode | 1 |  Rn  |  Rd  |
+ * +---+---+---+-----------+---------+------+-----+--------+---+------+------+
+ *
+ * This includes FMULX, FCMEQ (register), FRECPS, FRSQRTS, FCMGE
+ * (register), FACGE, FABD, FCMGT (register) and FACGT.
+ *
+ */
+static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
+{
+    int opcode, fpopcode;
+    int is_q, u, a, rm, rn, rd;
+    int datasize, elements;
+    int pass;
+    TCGv_ptr fpst;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+        unallocated_encoding(s);
+        return;
+    }
+
+    if (!fp_access_check(s)) {
+        return;
+    }
+
+    /* For these floating point ops, the U, a and opcode bits
+     * together indicate the operation.
+     */
+    opcode = extract32(insn, 11, 3);
+    u = extract32(insn, 29, 1);
+    a = extract32(insn, 23, 1);
+    is_q = extract32(insn, 30, 1);
+    rm = extract32(insn, 16, 5);
+    rn = extract32(insn, 5, 5);
+    rd = extract32(insn, 0, 5);
+
+    fpopcode = opcode | (a << 4) |  (u << 5);
+    datasize = is_q ? 128 : 64;
+    elements = datasize / 16;
+
+    fpst = get_fpstatus_ptr();
+
+    for (pass = 0; pass < elements; pass++) {
+        TCGv_i32 tcg_op1 = tcg_temp_new_i32();
+        TCGv_i32 tcg_op2 = tcg_temp_new_i32();
+        TCGv_i32 tcg_res = tcg_temp_new_i32();
+
+        read_vec_element_i32(s, tcg_op1, rn, pass, MO_16);
+        read_vec_element_i32(s, tcg_op2, rm, pass, MO_16);
+
+        switch (fpopcode) {
+        default:
+            fprintf(stderr,"%s: insn %#04x fpop %#2x\n", __func__, insn, fpopcode);
+            unsupported_encoding(s, insn);
+        }
+
+        write_vec_element_i32(s, tcg_res, rd, pass, MO_16);
+        tcg_temp_free_i32(tcg_res);
+        tcg_temp_free_i32(tcg_op1);
+        tcg_temp_free_i32(tcg_op2);
+    }
+
+    tcg_temp_free_ptr(fpst);
+
+    if (!is_q) {
+        /* non-quad vector op */
+        clear_vec_high(s, rd);
+    }
+
+}
+
 static void handle_2misc_widening(DisasContext *s, int opcode, bool is_q,
                                   int size, int rn, int rd)
 {
@@ -11117,6 +11192,7 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x4e280800, 0xff3e0c00, disas_crypto_aes },
     { 0x5e000000, 0xff208c00, disas_crypto_three_reg_sha },
     { 0x5e280800, 0xff3e0c00, disas_crypto_two_reg_sha },
+    { 0x0e400400, 0x9f60c400, disas_simd_three_reg_same_fp16 },
     { 0x00000000, 0x00000000, NULL }
 };
 
-- 
2.13.0
