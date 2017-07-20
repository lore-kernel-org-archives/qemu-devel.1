Received: from eggs.gnu.org ([2001:4830:134:3::10]:55521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD80-00035g-8j
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:12:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD7z-0004GN-3L
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:12:36 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:38157)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYD7y-0004G9-Sh
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:12:35 -0400
Received: by mail-wm0-x22d.google.com with SMTP id w191so29897530wmw.1
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:12:34 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 20 Jul 2017 16:04:18 +0100
Message-Id: <20170720150426.12393-16-alex.bennee@linaro.org>
In-Reply-To: <20170720150426.12393-1-alex.bennee@linaro.org>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for 2.11 15/23] target/arm/translate-a64.c:
 AdvSIMD scalar 2 register misc decode
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

This is the initial decode skeleton for the Advanced SIMD scalar two
register miscellaneous FP16 instruction group. The fprintfs are to aid
debugging as the additional instructions are added. They will be removed
once the group is complete.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/translate-a64.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index a8876e4bcc..c3f6080ce4 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10582,6 +10582,65 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 }
 
+/* ARMv8.2 AdvSIMD two reg misc half-precision
+ *
+ *   31  30  29 28       24 23               17 16    12 11 10 9    5 4    0
+ * +---+---+---+-----------+---+---------------+--------+-----+------+------+
+ * | 0 | Q | U | 0 1 1 1 0 | a | 1 1 1 0 0 0 0 | opcode | 1 0 |  Rn  |  Rd  |
+ * +---+---+---+-----------+---+---------------+--------+-----+------+------+
+ *
+ * This includes conversion functions and compare against zero
+ */
+static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
+{
+    int opcode = extract32(insn, 12, 5);
+    int u = extract32(insn, 29, 1);
+    int is_q = extract32(insn, 30, 1);
+    int a = extract32(insn, 23, 1);
+    int rn = extract32(insn, 5, 5);
+    int rd = extract32(insn, 0, 5);
+    int datasize, elements;
+    int fpopcode, pass;
+    TCGv_ptr fpst;
+
+    /* Handle any non-vector operations first */
+    switch (opcode) {
+    default:
+        fprintf(stderr, "%s: not a non-vector opcode %#x\n", __func__, opcode);
+        break;
+    }
+
+    fpopcode = opcode | (a << 5) | (u << 6);
+    datasize = is_q ? 128 : 64;
+    elements = datasize / 16;
+
+    fpst = get_fpstatus_ptr();
+
+    for (pass = 0; pass < elements; pass++) {
+        TCGv_i32 tcg_op1 = tcg_temp_new_i32();
+        TCGv_i32 tcg_res = tcg_temp_new_i32();
+
+        read_vec_element_i32(s, tcg_op1, rn, pass, MO_16);
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
+    }
+
+    tcg_temp_free_ptr(fpst);
+
+    if (!is_q) {
+        /* non-quad vector op */
+        clear_vec_high(s, rd);
+    }
+}
+
 /* C3.6.13 AdvSIMD scalar x indexed element
  *  31 30  29 28       24 23  22 21  20  19  16 15 12  11  10 9    5 4    0
  * +-----+---+-----------+------+---+---+------+-----+---+---+------+------+
@@ -11259,6 +11318,7 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x5e000000, 0xff208c00, disas_crypto_three_reg_sha },
     { 0x5e280800, 0xff3e0c00, disas_crypto_two_reg_sha },
     { 0x0e400400, 0x9f60c400, disas_simd_three_reg_same_fp16 },
+    { 0x0e780800, 0x9f7f0c00, disas_simd_two_reg_misc_fp16 },
     { 0x00000000, 0x00000000, NULL }
 };
 
-- 
2.13.0
