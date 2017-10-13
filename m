Received: from eggs.gnu.org ([2001:4830:134:3::10]:44248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32si-0000iy-Dc
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:32:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32sh-0002Sk-Ej
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:32:16 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:50731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e32sh-0002Rb-9C
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:32:15 -0400
Received: by mail-wm0-x22c.google.com with SMTP id u138so22539413wmu.5
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 09:32:15 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Oct 2017 17:24:27 +0100
Message-Id: <20171013162438.32458-20-alex.bennee@linaro.org>
In-Reply-To: <20171013162438.32458-1-alex.bennee@linaro.org>
References: <20171013162438.32458-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 19/30] Fix mask for AdvancedSIMD 2 reg misc
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

While the group encoding declares bit 28 a zero it is set for
FCMGT (zero)

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/translate-a64.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 11990daff4..7792cea9f5 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10571,10 +10571,10 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
 /* AdvSIMD two reg misc FP16
  *   31  30  29 28       24  23 22 21       17 16    12 11 10 9    5 4    0
  * +---+---+---+-----------+---+-------------+--------+-----+------+------+
- * | 0 | 1 | U | 1 1 1 1 0 | a | 1 1 1 1 0 0 | opcode | 1 0 |  Rn  |  Rd  |
+ * | 0 | Q | U | 1 1 1 1 0 | a | 1 1 1 1 0 0 | opcode | 1 0 |  Rn  |  Rd  |
  * +---+---+---+-----------+---+-------------+--------+-----+------+------+
- *   mask: 1101 1111 0111 1110 0000 1100 0000 0000 0xdf7e 0c00
- *   val:  0101 1110 0111 1000 0000 1000 0000 0000 0x5e78 0800
+ *   mask: 1001 1111 0111 1110 0000 1100 0000 0000 0x9f7e 0c00
+ *   val:  0001 1110 0111 1000 0000 1000 0000 0000 0x1e78 0800
  * Half-precision variants of two-reg misc.
  */
 static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
@@ -11304,7 +11304,7 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x5e000000, 0xff208c00, disas_crypto_three_reg_sha },
     { 0x5e280800, 0xff3e0c00, disas_crypto_two_reg_sha },
     { 0x0e400400, 0x9f60c400, disas_simd_three_reg_same_fp16 },
-    { 0x5e780800, 0xdf7e0c00, disas_simd_two_reg_misc_fp16 },
+    { 0x0e780800, 0x8f7e0c00, disas_simd_two_reg_misc_fp16 },
     { 0x00000000, 0x00000000, NULL }
 };
 
@@ -11318,6 +11318,8 @@ static void disas_data_proc_simd(DisasContext *s, uint32_t insn)
     if (fn) {
         fn(s, insn);
     } else {
+        fprintf(stderr, "%s: failed to find %#4x @ %#" PRIx64 "\n",
+                __func__, insn, s->pc);
         unallocated_encoding(s);
     }
 }
-- 
2.14.1
