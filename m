Received: from eggs.gnu.org ([2001:4830:134:3::10]:34096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumx-0007cx-M6
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumw-0007Eo-Gt
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:19 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYumw-00079y-90
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:18 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumu-0004iY-UL
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:54:16 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:53:25 +0100
Message-Id: <20180629145347.652-34-peter.maydell@linaro.org>
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 33/55] target/arm: Implement SVE MOVPRFX
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180627043328.11531-28-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 60 +++++++++++++++++++++++++++++++++++++-
 target/arm/sve.decode      |  7 +++++
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index b11b6326b94..812823777ad 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -351,6 +351,23 @@ static bool do_zpzz_ool(DisasContext *s, arg_rprr_esz *a, gen_helper_gvec_4 *fn)
     return true;
 }
 
+/* Select active elememnts from Zn and inactive elements from Zm,
+ * storing the result in Zd.
+ */
+static void do_sel_z(DisasContext *s, int rd, int rn, int rm, int pg, int esz)
+{
+    static gen_helper_gvec_4 * const fns[4] = {
+        gen_helper_sve_sel_zpzz_b, gen_helper_sve_sel_zpzz_h,
+        gen_helper_sve_sel_zpzz_s, gen_helper_sve_sel_zpzz_d
+    };
+    unsigned vsz = vec_full_reg_size(s);
+    tcg_gen_gvec_4_ool(vec_full_reg_offset(s, rd),
+                       vec_full_reg_offset(s, rn),
+                       vec_full_reg_offset(s, rm),
+                       pred_full_reg_offset(s, pg),
+                       vsz, vsz, 0, fns[esz]);
+}
+
 #define DO_ZPZZ(NAME, name) \
 static bool trans_##NAME##_zpzz(DisasContext *s, arg_rprr_esz *a,         \
                                 uint32_t insn)                            \
@@ -401,7 +418,13 @@ static bool trans_UDIV_zpzz(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
     return do_zpzz_ool(s, a, fns[a->esz]);
 }
 
-DO_ZPZZ(SEL, sel)
+static bool trans_SEL_zpzz(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+{
+    if (sve_access_check(s)) {
+        do_sel_z(s, a->rd, a->rn, a->rm, a->pg, a->esz);
+    }
+    return true;
+}
 
 #undef DO_ZPZZ
 
@@ -5035,3 +5058,38 @@ static bool trans_PRF_rr(DisasContext *s, arg_PRF_rr *a, uint32_t insn)
     sve_access_check(s);
     return true;
 }
+
+/*
+ * Move Prefix
+ *
+ * TODO: The implementation so far could handle predicated merging movprfx.
+ * The helper functions as written take an extra source register to
+ * use in the operation, but the result is only written when predication
+ * succeeds.  For unpredicated movprfx, we need to rearrange the helpers
+ * to allow the final write back to the destination to be unconditional.
+ * For predicated zeroing movprfx, we need to rearrange the helpers to
+ * allow the final write back to zero inactives.
+ *
+ * In the meantime, just emit the moves.
+ */
+
+static bool trans_MOVPRFX(DisasContext *s, arg_MOVPRFX *a, uint32_t insn)
+{
+    return do_mov_z(s, a->rd, a->rn);
+}
+
+static bool trans_MOVPRFX_m(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    if (sve_access_check(s)) {
+        do_sel_z(s, a->rd, a->rn, a->rd, a->pg, a->esz);
+    }
+    return true;
+}
+
+static bool trans_MOVPRFX_z(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    if (sve_access_check(s)) {
+        do_movz_zpz(s, a->rd, a->rn, a->pg, a->esz);
+    }
+    return true;
+}
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 2aca9f0bb04..c725ee25843 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -270,6 +270,10 @@ ORV             00000100 .. 011 000 001 ... ..... .....         @rd_pg_rn
 EORV            00000100 .. 011 001 001 ... ..... .....         @rd_pg_rn
 ANDV            00000100 .. 011 010 001 ... ..... .....         @rd_pg_rn
 
+# SVE constructive prefix (predicated)
+MOVPRFX_z       00000100 .. 010 000 001 ... ..... .....         @rd_pg_rn
+MOVPRFX_m       00000100 .. 010 001 001 ... ..... .....         @rd_pg_rn
+
 # SVE integer add reduction (predicated)
 # Note that saddv requires size != 3.
 UADDV           00000100 .. 000 001 001 ... ..... .....         @rd_pg_rn
@@ -418,6 +422,9 @@ ADR_p64         00000100 11 1 ..... 1010 .. ..... .....         @rd_rn_msz_rm
 
 ### SVE Integer Misc - Unpredicated Group
 
+# SVE constructive prefix (unpredicated)
+MOVPRFX         00000100 00 1 00000 101111 rn:5 rd:5
+
 # SVE floating-point exponential accelerator
 # Note esz != 0
 FEXPA           00000100 .. 1 00000 101110 ..... .....          @rd_rn
-- 
2.17.1
