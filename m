Received: from eggs.gnu.org ([2001:4830:134:3::10]:58993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fE02n-0000ov-8X
	for qemu-devel@nongnu.org; Wed, 02 May 2018 18:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fE02l-00082D-T8
	for qemu-devel@nongnu.org; Wed, 02 May 2018 18:16:13 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:40974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fE02l-000812-M7
	for qemu-devel@nongnu.org; Wed, 02 May 2018 18:16:11 -0400
Received: by mail-pg0-x244.google.com with SMTP id m21-v6so11628372pgv.8
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 15:16:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  2 May 2018 15:15:50 -0700
Message-Id: <20180502221552.3873-13-richard.henderson@linaro.org>
In-Reply-To: <20180502221552.3873-1-richard.henderson@linaro.org>
References: <20180502221552.3873-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 12/14] target/arm: Implement FCSEL for fp16
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

These were missed out from the rest of the half-precision work.

Cc: qemu-stable@nongnu.org
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
[rth: Fix erroneous check vs type]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index f0aca20771..1ea5185f14 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4666,15 +4666,34 @@ static void disas_fp_csel(DisasContext *s, uint32_t insn)
     unsigned int mos, type, rm, cond, rn, rd;
     TCGv_i64 t_true, t_false, t_zero;
     DisasCompare64 c;
+    TCGMemOp sz;
 
     mos = extract32(insn, 29, 3);
-    type = extract32(insn, 22, 2); /* 0 = single, 1 = double */
+    type = extract32(insn, 22, 2);
     rm = extract32(insn, 16, 5);
     cond = extract32(insn, 12, 4);
     rn = extract32(insn, 5, 5);
     rd = extract32(insn, 0, 5);
 
-    if (mos || type > 1) {
+    if (mos) {
+        unallocated_encoding(s);
+        return;
+    }
+
+    switch(type) {
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
@@ -4683,11 +4702,11 @@ static void disas_fp_csel(DisasContext *s, uint32_t insn)
         return;
     }
 
-    /* Zero extend sreg inputs to 64 bits now.  */
+    /* Zero extend sreg & hreg inputs to 64 bits now.  */
     t_true = tcg_temp_new_i64();
     t_false = tcg_temp_new_i64();
-    read_vec_element(s, t_true, rn, 0, type ? MO_64 : MO_32);
-    read_vec_element(s, t_false, rm, 0, type ? MO_64 : MO_32);
+    read_vec_element(s, t_true, rn, 0, sz);
+    read_vec_element(s, t_false, rm, 0, sz);
 
     a64_test_cc(&c, cond);
     t_zero = tcg_const_i64(0);
@@ -4696,7 +4715,7 @@ static void disas_fp_csel(DisasContext *s, uint32_t insn)
     tcg_temp_free_i64(t_false);
     a64_free_cc(&c);
 
-    /* Note that sregs write back zeros to the high bits,
+    /* Note that sregs & hregs write back zeros to the high bits,
        and we've already done the zero-extension.  */
     write_fp_dreg(s, rd, t_true);
     tcg_temp_free_i64(t_true);
-- 
2.14.3
