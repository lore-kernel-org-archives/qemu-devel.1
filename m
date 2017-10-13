Received: from eggs.gnu.org ([2001:4830:134:3::10]:44078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32sc-0000cB-IP
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:32:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32sY-0002Hc-RM
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:32:10 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:50729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e32sY-0002H1-Kb
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:32:06 -0400
Received: by mail-wm0-x232.google.com with SMTP id u138so22538586wmu.5
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 09:32:06 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Oct 2017 17:24:26 +0100
Message-Id: <20171013162438.32458-19-alex.bennee@linaro.org>
In-Reply-To: <20171013162438.32458-1-alex.bennee@linaro.org>
References: <20171013162438.32458-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 18/30] target/arm/translate-a64.c: add
 AdvSIMD scalar two-reg misc skeleton
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This is just the decode skeleton which will be filled out by later
patches.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/translate-a64.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d12106695f..11990daff4 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10568,6 +10568,40 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 }
 
+/* AdvSIMD two reg misc FP16
+ *   31  30  29 28       24  23 22 21       17 16    12 11 10 9    5 4    0
+ * +---+---+---+-----------+---+-------------+--------+-----+------+------+
+ * | 0 | 1 | U | 1 1 1 1 0 | a | 1 1 1 1 0 0 | opcode | 1 0 |  Rn  |  Rd  |
+ * +---+---+---+-----------+---+-------------+--------+-----+------+------+
+ *   mask: 1101 1111 0111 1110 0000 1100 0000 0000 0xdf7e 0c00
+ *   val:  0101 1110 0111 1000 0000 1000 0000 0000 0x5e78 0800
+ * Half-precision variants of two-reg misc.
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
+        fprintf(stderr,"%s: insn %#04x fpop %#2x\n", __func__, insn, fpop);
+        g_assert_not_reached();
+    }
+
+}
+
 /* AdvSIMD scalar x indexed element
  *  31 30  29 28       24 23  22 21  20  19  16 15 12  11  10 9    5 4    0
  * +-----+---+-----------+------+---+---+------+-----+---+---+------+------+
@@ -11270,6 +11304,7 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x5e000000, 0xff208c00, disas_crypto_three_reg_sha },
     { 0x5e280800, 0xff3e0c00, disas_crypto_two_reg_sha },
     { 0x0e400400, 0x9f60c400, disas_simd_three_reg_same_fp16 },
+    { 0x5e780800, 0xdf7e0c00, disas_simd_two_reg_misc_fp16 },
     { 0x00000000, 0x00000000, NULL }
 };
 
-- 
2.14.1
