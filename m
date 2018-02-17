Received: from eggs.gnu.org ([2001:4830:134:3::10]:39527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en795-000075-78
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:23:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en794-0001TG-AA
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:23:35 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:46293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en794-0001Ss-4a
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:23:34 -0500
Received: by mail-pl0-x244.google.com with SMTP id x19so3427827plr.13
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 10:23:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 10:22:20 -0800
Message-Id: <20180217182323.25885-5-richard.henderson@linaro.org>
In-Reply-To: <20180217182323.25885-1-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 04/67] target/arm: Implement SVE Bitwise
 Logical - Unpredicated Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

These were the instructions that were stubbed out when
introducing the decode skeleton.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 50 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 2c9e4733cb..50cf2a1fdd 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -32,6 +32,10 @@
 #include "trace-tcg.h"
 #include "translate-a64.h"
 
+typedef void GVecGen2Fn(unsigned, uint32_t, uint32_t, uint32_t, uint32_t);
+typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
+                        uint32_t, uint32_t, uint32_t);
+
 /*
  * Include the generated decoder.
  */
@@ -42,22 +46,54 @@
  * Implement all of the translator functions referenced by the decoder.
  */
 
-static void trans_AND_zzz(DisasContext *s, arg_AND_zzz *a, uint32_t insn)
+/* Invoke a vector expander on two Zregs.  */
+static void do_vector2_z(DisasContext *s, GVecGen2Fn *gvec_fn,
+                         int esz, int rd, int rn)
 {
-    unsupported_encoding(s, insn);
+    unsigned vsz = vec_full_reg_size(s);
+    gvec_fn(esz, vec_full_reg_offset(s, rd),
+            vec_full_reg_offset(s, rn), vsz, vsz);
 }
 
-static void trans_ORR_zzz(DisasContext *s, arg_ORR_zzz *a, uint32_t insn)
+/* Invoke a vector expander on three Zregs.  */
+static void do_vector3_z(DisasContext *s, GVecGen3Fn *gvec_fn,
+                         int esz, int rd, int rn, int rm)
 {
-    unsupported_encoding(s, insn);
+    unsigned vsz = vec_full_reg_size(s);
+    gvec_fn(esz, vec_full_reg_offset(s, rd), vec_full_reg_offset(s, rn),
+            vec_full_reg_offset(s, rm), vsz, vsz);
 }
 
-static void trans_EOR_zzz(DisasContext *s, arg_EOR_zzz *a, uint32_t insn)
+/* Invoke a vector move on two Zregs.  */
+static void do_mov_z(DisasContext *s, int rd, int rn)
 {
-    unsupported_encoding(s, insn);
+    do_vector2_z(s, tcg_gen_gvec_mov, 0, rd, rn);
+}
+
+/*
+ *** SVE Logical - Unpredicated Group
+ */
+
+static void trans_AND_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    do_vector3_z(s, tcg_gen_gvec_and, 0, a->rd, a->rn, a->rm);
+}
+
+static void trans_ORR_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    if (a->rn == a->rm) { /* MOV */
+        do_mov_z(s, a->rd, a->rn);
+    } else {
+        do_vector3_z(s, tcg_gen_gvec_or, 0, a->rd, a->rn, a->rm);
+    }
+}
+
+static void trans_EOR_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    do_vector3_z(s, tcg_gen_gvec_xor, 0, a->rd, a->rn, a->rm);
 }
 
 static void trans_BIC_zzz(DisasContext *s, arg_BIC_zzz *a, uint32_t insn)
 {
-    unsupported_encoding(s, insn);
+    do_vector3_z(s, tcg_gen_gvec_andc, 0, a->rd, a->rn, a->rm);
 }
-- 
2.14.3
