Received: from eggs.gnu.org ([2001:4830:134:3::10]:39679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIabs-0003t3-Jj
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:07:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIabm-0002vo-J3
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:07:24 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fIabm-0002tn-Cc
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:07:18 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fIabl-0001So-HV
	for qemu-devel@nongnu.org; Tue, 15 May 2018 15:07:17 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 15:07:04 +0100
Message-Id: <20180515140707.15957-14-peter.maydell@linaro.org>
In-Reply-To: <20180515140707.15957-1-peter.maydell@linaro.org>
References: <20180515140707.15957-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/16] target/arm: Implement FMOV (immediate)
 for fp16
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

All the hard work is already done by vfp_expand_imm, we just need to
make sure we pick up the correct size.

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180512003217.9105-11-richard.henderson@linaro.org
[rth: Merge unallocated_encoding check with TCGMemOp conversion.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 9dacb583ae..35997969b4 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5674,11 +5674,25 @@ static void disas_fp_imm(DisasContext *s, uint32_t insn)
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
@@ -5687,7 +5701,7 @@ static void disas_fp_imm(DisasContext *s, uint32_t insn)
         return;
     }
 
-    imm = vfp_expand_imm(MO_32 + is_double, imm8);
+    imm = vfp_expand_imm(sz, imm8);
 
     tcg_res = tcg_const_i64(imm);
     write_fp_dreg(s, rd, tcg_res);
-- 
2.17.0
