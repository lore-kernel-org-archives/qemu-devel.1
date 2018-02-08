Received: from eggs.gnu.org ([2001:4830:134:3::10]:57268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejqBS-0002vv-Sh
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:40:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejqBQ-0000QO-IQ
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:40:30 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:53307)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ejqBQ-0000Pt-7L
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:40:28 -0500
Received: by mail-wm0-x243.google.com with SMTP id t74so10991905wme.3
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 09:40:28 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  8 Feb 2018 17:31:42 +0000
Message-Id: <20180208173157.24705-18-alex.bennee@linaro.org>
In-Reply-To: <20180208173157.24705-1-alex.bennee@linaro.org>
References: <20180208173157.24705-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 17/32] arm/translate-a64: initial decode for
 simd_two_reg_misc_fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

This actually covers two different sections of the encoding table:

   Advanced SIMD scalar two-register miscellaneous FP16
   Advanced SIMD two-register miscellaneous (FP16)

The difference between the two is covered by a combination of Q (bit
30) and S (bit 28). Notably the FRINTx instructions are only
available in the vector form.

This is just the decode skeleton which will be filled out by later
patches.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - checkpatch cleanups
---
 target/arm/translate-a64.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index f01bab801c..f939ca4d40 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10724,6 +10724,45 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 }
 
+/* AdvSIMD [scalar] two register miscellaneous (FP16)
+ *
+ *   31  30  29 28  27     24  23 22 21       17 16    12 11 10 9    5 4    0
+ * +---+---+---+---+--------+---+-------------+--------+-----+------+------+
+ * | 0 | Q | U | S | 1 1 1 0 | a | 1 1 1 1 0 0 | opcode | 1 0 |  Rn  |  Rd  |
+ * +---+---+---+---+--------+---+-------------+--------+-----+------+------+
+ *   mask: 1000 1111 0111 1110 0000 1100 0000 0000 0x8f7e 0c00
+ *   val:  0000 1110 0111 1000 0000 1000 0000 0000 0x0e78 0800
+ *
+ * ???While the group is listed with bit 28 always set to 1 this is not
+ * always the case.????
+ *
+ * This actually covers two groups,
+ */
+static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
+{
+    int fpop, opcode, a;
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
+    opcode = extract32(insn, 12, 4);
+    a = extract32(insn, 23, 1);
+    fpop = deposit32(opcode, 5, 1, a);
+
+    switch (fpop) {
+    default:
+        fprintf(stderr, "%s: insn %#04x fpop %#2x\n", __func__, insn, fpop);
+        g_assert_not_reached();
+    }
+
+}
+
 /* AdvSIMD scalar x indexed element
  *  31 30  29 28       24 23  22 21  20  19  16 15 12  11  10 9    5 4    0
  * +-----+---+-----------+------+---+---+------+-----+---+---+------+------+
@@ -11459,6 +11498,7 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x5e000000, 0xff208c00, disas_crypto_three_reg_sha },
     { 0x5e280800, 0xff3e0c00, disas_crypto_two_reg_sha },
     { 0x0e400400, 0x9f60c400, disas_simd_three_reg_same_fp16 },
+    { 0x0e780800, 0x8f7e0c00, disas_simd_two_reg_misc_fp16 },
     { 0x00000000, 0x00000000, NULL }
 };
 
@@ -11472,6 +11512,8 @@ static void disas_data_proc_simd(DisasContext *s, uint32_t insn)
     if (fn) {
         fn(s, insn);
     } else {
+        /* fprintf(stderr, "%s: failed to find %#4x @ %#" PRIx64 "\n", */
+        /*         __func__, insn, s->pc); */
         unallocated_encoding(s);
     }
 }
-- 
2.15.1
