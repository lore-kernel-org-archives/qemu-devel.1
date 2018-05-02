Received: from eggs.gnu.org ([2001:4830:134:3::10]:59034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fE02o-0000oz-B6
	for qemu-devel@nongnu.org; Wed, 02 May 2018 18:16:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fE02n-00084H-2M
	for qemu-devel@nongnu.org; Wed, 02 May 2018 18:16:14 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:45787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fE02m-00082v-UE
	for qemu-devel@nongnu.org; Wed, 02 May 2018 18:16:13 -0400
Received: by mail-pg0-x244.google.com with SMTP id i29-v6so11613134pgn.12
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 15:16:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  2 May 2018 15:15:51 -0700
Message-Id: <20180502221552.3873-14-richard.henderson@linaro.org>
In-Reply-To: <20180502221552.3873-1-richard.henderson@linaro.org>
References: <20180502221552.3873-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 13/14] target/arm: Implement FMOV
 (immediate) for fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-stable@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

All the hard work is already done by vfp_expand_imm, we just need to
make sure we pick up the correct size.

Cc: qemu-stable@nongnu.org
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
[rth: Merge unallocated_encoding check with TCGMemOp conversion.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 1ea5185f14..b73d6d96cd 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5437,11 +5437,25 @@ static void disas_fp_imm(DisasContext *s, uint32_t insn)
 {
     int rd = extract32(insn, 0, 5);
     int imm8 = extract32(insn, 13, 8);
-    int is_double = extract32(insn, 22, 2);
+    int type = extract32(insn, 22, 2);
     uint64_t imm;
     TCGv_i64 tcg_res;
+    TCGMemOp sz;
 
-    if (is_double > 1) {
+    switch (type) {
+    case 0:
+        sz = MO_32;
+        break;
+    case 1:
+        sz = MO_64;
+        break;
+    case 3:
+        sz = MO_16;
+        if (arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+            break;
+        }
+        /* fallthru */
+    default:
         unallocated_encoding(s);
         return;
     }
@@ -5450,7 +5464,7 @@ static void disas_fp_imm(DisasContext *s, uint32_t insn)
         return;
     }
 
-    imm = vfp_expand_imm(MO_32 + is_double, imm8);
+    imm = vfp_expand_imm(sz, imm8);
 
     tcg_res = tcg_const_i64(imm);
     write_fp_dreg(s, rd, tcg_res);
-- 
2.14.3
