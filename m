Received: from eggs.gnu.org ([2001:4830:134:3::10]:33902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJz-0003nR-QC
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJy-0008Ar-NN
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:23 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1erMJy-0008AR-Fr
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:22 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJx-0000dQ-Iy
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:24:21 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Mar 2018 11:23:45 +0000
Message-Id: <20180301112403.12487-25-peter.maydell@linaro.org>
In-Reply-To: <20180301112403.12487-1-peter.maydell@linaro.org>
References: <20180301112403.12487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 24/42] arm/translate-a64: initial decode for
 simd_two_reg_misc_fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

This actually covers two different sections of the encoding table:

   Advanced SIMD scalar two-register miscellaneous FP16
   Advanced SIMD two-register miscellaneous (FP16)

The difference between the two is covered by a combination of Q (bit
30) and S (bit 28). Notably the FRINTx instructions are only
available in the vector form.

This is just the decode skeleton which will be filled out by later
patches.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180227143852.11175-17-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 3487c0430f..9c1892c49a 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11164,6 +11164,45 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 }
 
+/* AdvSIMD [scalar] two register miscellaneous (FP16)
+ *
+ *   31  30  29 28  27     24  23 22 21       17 16    12 11 10 9    5 4    0
+ * +---+---+---+---+---------+---+-------------+--------+-----+------+------+
+ * | 0 | Q | U | S | 1 1 1 0 | a | 1 1 1 1 0 0 | opcode | 1 0 |  Rn  |  Rd  |
+ * +---+---+---+---+---------+---+-------------+--------+-----+------+------+
+ *   mask: 1000 1111 0111 1110 0000 1100 0000 0000 0x8f7e 0c00
+ *   val:  0000 1110 0111 1000 0000 1000 0000 0000 0x0e78 0800
+ *
+ * This actually covers two groups where scalar access is governed by
+ * bit 28. A bunch of the instructions (float to integral) only exist
+ * in the vector form and are un-allocated for the scalar decode. Also
+ * in the scalar decode Q is always 1.
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
@@ -12236,6 +12275,7 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0xce800000, 0xffe00000, disas_crypto_xar },
     { 0xce408000, 0xffe0c000, disas_crypto_three_reg_imm2 },
     { 0x0e400400, 0x9f60c400, disas_simd_three_reg_same_fp16 },
+    { 0x0e780800, 0x8f7e0c00, disas_simd_two_reg_misc_fp16 },
     { 0x00000000, 0x00000000, NULL }
 };
 
-- 
2.16.2
