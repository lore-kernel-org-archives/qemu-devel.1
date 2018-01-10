Received: from eggs.gnu.org ([2001:4830:134:3::10]:58463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZ9xJ-0000ph-QY
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 01:33:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZ9xF-0007L7-WE
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 01:33:45 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:40665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eZ9xF-0007Kq-QR
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 01:33:41 -0500
Received: by mail-pl0-x241.google.com with SMTP id 62so6728388pld.7
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 22:33:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue,  9 Jan 2018 22:33:36 -0800
Message-Id: <20180110063337.21538-2-richard.henderson@linaro.org>
In-Reply-To: <20180110063337.21538-1-richard.henderson@linaro.org>
References: <20180110063337.21538-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] target/arm: Split out vfp_expand_imm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index ecb72e4d9c..e03cd3801a 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5014,6 +5014,33 @@ static void disas_fp_3src(DisasContext *s, uint32_t insn)
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
@@ -5037,22 +5064,7 @@ static void disas_fp_imm(DisasContext *s, uint32_t insn)
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
2.13.6
