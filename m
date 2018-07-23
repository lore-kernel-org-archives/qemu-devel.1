Received: from eggs.gnu.org ([2001:4830:134:3::10]:43262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKw-000488-V7
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKw-0005Ub-07
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:42 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:33 -0500
Message-Id: <20180723201748.25573-85-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 84/99] target/arm: Implement FMOV (immediate)
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
Cc: qemu-stable@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

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

(cherry picked from commit 6ba28ddb9be37bdb67e3e38007a53ccbdcd010df)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/translate-a64.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 7075f27e05..f4587c3814 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5431,11 +5431,25 @@ static void disas_fp_imm(DisasContext *s, uint32_t insn)
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
@@ -5444,7 +5458,7 @@ static void disas_fp_imm(DisasContext *s, uint32_t insn)
         return;
     }
 
-    imm = vfp_expand_imm(MO_32 + is_double, imm8);
+    imm = vfp_expand_imm(sz, imm8);
 
     tcg_res = tcg_const_i64(imm);
     write_fp_dreg(s, rd, tcg_res);
-- 
2.17.1
