Received: from eggs.gnu.org ([2001:4830:134:3::10]:37346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNu-0008B4-1e
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNq-0002m3-5b
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:38 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ebRNp-0002gG-Uw
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:34 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNo-0002sw-M6
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:34:32 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 13:34:04 +0000
Message-Id: <1516109659-1557-10-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
References: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 09/24] target/arm: Split out vfp_expand_imm
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180110063337.21538-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index ba94f7d..80ae019 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4985,6 +4985,33 @@ static void disas_fp_3src(DisasContext *s, uint32_t insn)
     }
 }
 
+/* The imm8 encodes the sign bit, enough bits to represent an exponent in
+ * the range 01....1xx to 10....0xx, and the most significant 4 bits of
+ * the mantissa; see VFPExpandImm() in the v8 ARM ARM.
+ */
+static uint64_t vfp_expand_imm(int size, uint8_t imm8)
+{
+    uint64_t imm;
+
+    switch (size) {
+    case MO_64:
+        imm = (extract32(imm8, 7, 1) ? 0x8000 : 0) |
+            (extract32(imm8, 6, 1) ? 0x3fc0 : 0x4000) |
+            extract32(imm8, 0, 6);
+        imm <<= 48;
+        break;
+    case MO_32:
+        imm = (extract32(imm8, 7, 1) ? 0x8000 : 0) |
+            (extract32(imm8, 6, 1) ? 0x3e00 : 0x4000) |
+            (extract32(imm8, 0, 6) << 3);
+        imm <<= 16;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return imm;
+}
+
 /* Floating point immediate
  *   31  30  29 28       24 23  22  21 20        13 12   10 9    5 4    0
  * +---+---+---+-----------+------+---+------------+-------+------+------+
@@ -5008,22 +5035,7 @@ static void disas_fp_imm(DisasContext *s, uint32_t insn)
         return;
     }
 
-    /* The imm8 encodes the sign bit, enough bits to represent
-     * an exponent in the range 01....1xx to 10....0xx,
-     * and the most significant 4 bits of the mantissa; see
-     * VFPExpandImm() in the v8 ARM ARM.
-     */
-    if (is_double) {
-        imm = (extract32(imm8, 7, 1) ? 0x8000 : 0) |
-            (extract32(imm8, 6, 1) ? 0x3fc0 : 0x4000) |
-            extract32(imm8, 0, 6);
-        imm <<= 48;
-    } else {
-        imm = (extract32(imm8, 7, 1) ? 0x8000 : 0) |
-            (extract32(imm8, 6, 1) ? 0x3e00 : 0x4000) |
-            (extract32(imm8, 0, 6) << 3);
-        imm <<= 16;
-    }
+    imm = vfp_expand_imm(MO_32 + is_double, imm8);
 
     tcg_res = tcg_const_i64(imm);
     write_fp_dreg(s, rd, tcg_res);
-- 
2.7.4
