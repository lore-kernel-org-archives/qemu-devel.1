Received: from eggs.gnu.org ([2001:4830:134:3::10]:35956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3D-0000c6-PZ
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3C-0007TF-HM
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:19 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fJj3C-0007Sa-A6
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:18 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3B-0004o5-E1
	for qemu-devel@nongnu.org; Fri, 18 May 2018 18:20:17 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 18:19:47 +0100
Message-Id: <20180518172009.14416-11-peter.maydell@linaro.org>
In-Reply-To: <20180518172009.14416-1-peter.maydell@linaro.org>
References: <20180518172009.14416-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 10/32] target/arm: Implement SVE Bitwise Logical
 - Unpredicated Group
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

These were the instructions that were stubbed out when
introducing the decode skeleton.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180516223007.10256-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 55 ++++++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index d323bd0b67..67d6db313e 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -42,22 +42,61 @@
  * Implement all of the translator functions referenced by the decoder.
  */
 
-static bool trans_AND_zzz(DisasContext *s, arg_AND_zzz *a, uint32_t insn)
+/* Invoke a vector expander on two Zregs.  */
+static bool do_vector2_z(DisasContext *s, GVecGen2Fn *gvec_fn,
+                         int esz, int rd, int rn)
 {
-    return false;
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        gvec_fn(esz, vec_full_reg_offset(s, rd),
+                vec_full_reg_offset(s, rn), vsz, vsz);
+    }
+    return true;
 }
 
-static bool trans_ORR_zzz(DisasContext *s, arg_ORR_zzz *a, uint32_t insn)
+/* Invoke a vector expander on three Zregs.  */
+static bool do_vector3_z(DisasContext *s, GVecGen3Fn *gvec_fn,
+                         int esz, int rd, int rn, int rm)
 {
-    return false;
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        gvec_fn(esz, vec_full_reg_offset(s, rd),
+                vec_full_reg_offset(s, rn),
+                vec_full_reg_offset(s, rm), vsz, vsz);
+    }
+    return true;
 }
 
-static bool trans_EOR_zzz(DisasContext *s, arg_EOR_zzz *a, uint32_t insn)
+/* Invoke a vector move on two Zregs.  */
+static bool do_mov_z(DisasContext *s, int rd, int rn)
 {
-    return false;
+    return do_vector2_z(s, tcg_gen_gvec_mov, 0, rd, rn);
 }
 
-static bool trans_BIC_zzz(DisasContext *s, arg_BIC_zzz *a, uint32_t insn)
+/*
+ *** SVE Logical - Unpredicated Group
+ */
+
+static bool trans_AND_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
 {
-    return false;
+    return do_vector3_z(s, tcg_gen_gvec_and, 0, a->rd, a->rn, a->rm);
+}
+
+static bool trans_ORR_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    if (a->rn == a->rm) { /* MOV */
+        return do_mov_z(s, a->rd, a->rn);
+    } else {
+        return do_vector3_z(s, tcg_gen_gvec_or, 0, a->rd, a->rn, a->rm);
+    }
+}
+
+static bool trans_EOR_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    return do_vector3_z(s, tcg_gen_gvec_xor, 0, a->rd, a->rn, a->rm);
+}
+
+static bool trans_BIC_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    return do_vector3_z(s, tcg_gen_gvec_andc, 0, a->rd, a->rn, a->rm);
 }
-- 
2.17.0
