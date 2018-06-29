Received: from eggs.gnu.org ([2001:4830:134:3::10]:33890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumo-0007V8-QP
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumm-0006iY-Bb
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:10 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYuml-0006e1-Ma
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:08 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumk-0004dE-Jn
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:54:06 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:53:13 +0100
Message-Id: <20180629145347.652-22-peter.maydell@linaro.org>
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 21/55] target/arm: Implement SVE scatter store
 vector immediate
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
Message-id: 20180627043328.11531-16-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 85 ++++++++++++++++++++++++++------------
 target/arm/sve.decode      | 11 +++++
 2 files changed, 70 insertions(+), 26 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 66d8c94c588..75913585399 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4391,32 +4391,34 @@ static bool trans_LD1_zpiz(DisasContext *s, arg_LD1_zpiz *a, uint32_t insn)
     return true;
 }
 
+/* Indexed by [xs][msz].  */
+static gen_helper_gvec_mem_scatter * const scatter_store_fn32[2][3] = {
+    { gen_helper_sve_stbs_zsu,
+      gen_helper_sve_sths_zsu,
+      gen_helper_sve_stss_zsu, },
+    { gen_helper_sve_stbs_zss,
+      gen_helper_sve_sths_zss,
+      gen_helper_sve_stss_zss, },
+};
+
+/* Note that we overload xs=2 to indicate 64-bit offset.  */
+static gen_helper_gvec_mem_scatter * const scatter_store_fn64[3][4] = {
+    { gen_helper_sve_stbd_zsu,
+      gen_helper_sve_sthd_zsu,
+      gen_helper_sve_stsd_zsu,
+      gen_helper_sve_stdd_zsu, },
+    { gen_helper_sve_stbd_zss,
+      gen_helper_sve_sthd_zss,
+      gen_helper_sve_stsd_zss,
+      gen_helper_sve_stdd_zss, },
+    { gen_helper_sve_stbd_zd,
+      gen_helper_sve_sthd_zd,
+      gen_helper_sve_stsd_zd,
+      gen_helper_sve_stdd_zd, },
+};
+
 static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a, uint32_t insn)
 {
-    /* Indexed by [xs][msz].  */
-    static gen_helper_gvec_mem_scatter * const fn32[2][3] = {
-        { gen_helper_sve_stbs_zsu,
-          gen_helper_sve_sths_zsu,
-          gen_helper_sve_stss_zsu, },
-        { gen_helper_sve_stbs_zss,
-          gen_helper_sve_sths_zss,
-          gen_helper_sve_stss_zss, },
-    };
-    /* Note that we overload xs=2 to indicate 64-bit offset.  */
-    static gen_helper_gvec_mem_scatter * const fn64[3][4] = {
-        { gen_helper_sve_stbd_zsu,
-          gen_helper_sve_sthd_zsu,
-          gen_helper_sve_stsd_zsu,
-          gen_helper_sve_stdd_zsu, },
-        { gen_helper_sve_stbd_zss,
-          gen_helper_sve_sthd_zss,
-          gen_helper_sve_stsd_zss,
-          gen_helper_sve_stdd_zss, },
-        { gen_helper_sve_stbd_zd,
-          gen_helper_sve_sthd_zd,
-          gen_helper_sve_stsd_zd,
-          gen_helper_sve_stdd_zd, },
-    };
     gen_helper_gvec_mem_scatter *fn;
 
     if (a->esz < a->msz || (a->msz == 0 && a->scale)) {
@@ -4427,10 +4429,10 @@ static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a, uint32_t insn)
     }
     switch (a->esz) {
     case MO_32:
-        fn = fn32[a->xs][a->msz];
+        fn = scatter_store_fn32[a->xs][a->msz];
         break;
     case MO_64:
-        fn = fn64[a->xs][a->msz];
+        fn = scatter_store_fn64[a->xs][a->msz];
         break;
     default:
         g_assert_not_reached();
@@ -4440,6 +4442,37 @@ static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a, uint32_t insn)
     return true;
 }
 
+static bool trans_ST1_zpiz(DisasContext *s, arg_ST1_zpiz *a, uint32_t insn)
+{
+    gen_helper_gvec_mem_scatter *fn = NULL;
+    TCGv_i64 imm;
+
+    if (a->esz < a->msz) {
+        return false;
+    }
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    switch (a->esz) {
+    case MO_32:
+        fn = scatter_store_fn32[0][a->msz];
+        break;
+    case MO_64:
+        fn = scatter_store_fn64[2][a->msz];
+        break;
+    }
+    assert(fn != NULL);
+
+    /* Treat ST1_zpiz (zn[x] + imm) the same way as ST1_zprz (rn + zm[x])
+     * by loading the immediate into the scalar parameter.
+     */
+    imm = tcg_const_i64(a->imm << a->msz);
+    do_mem_zpz(s, a->rd, a->pg, a->rn, 0, imm, fn);
+    tcg_temp_free_i64(imm);
+    return true;
+}
+
 /*
  * Prefetches
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 45016c60426..75133ce6596 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -83,6 +83,7 @@
 &rprr_gather_load       rd pg rn rm esz msz u ff xs scale
 &rpri_gather_load       rd pg rn imm esz msz u ff
 &rprr_scatter_store     rd pg rn rm esz msz xs scale
+&rpri_scatter_store     rd pg rn imm esz msz
 
 ###########################################################################
 # Named instruction formats.  These are generally used to
@@ -219,6 +220,8 @@
                     &rprr_store nreg=0
 @rprr_scatter_store ....... msz:2 ..     rm:5 ... pg:3 rn:5 rd:5 \
                     &rprr_scatter_store
+@rpri_scatter_store ....... msz:2 ..    imm:5 ... pg:3 rn:5 rd:5 \
+                    &rpri_scatter_store
 
 ###########################################################################
 # Instruction patterns.  Grouped according to the SVE encodingindex.xhtml.
@@ -932,6 +935,14 @@ ST1_zprz        1110010 .. 01 ..... 101 ... ..... ..... \
 ST1_zprz        1110010 .. 00 ..... 101 ... ..... ..... \
                 @rprr_scatter_store xs=2 esz=3 scale=0
 
+# SVE 64-bit scatter store (vector plus immediate)
+ST1_zpiz        1110010 .. 10 ..... 101 ... ..... ..... \
+                @rpri_scatter_store esz=3
+
+# SVE 32-bit scatter store (vector plus immediate)
+ST1_zpiz        1110010 .. 11 ..... 101 ... ..... ..... \
+                @rpri_scatter_store esz=2
+
 # SVE 64-bit scatter store (scalar plus unpacked 32-bit scaled offset)
 # Require msz > 0
 ST1_zprz        1110010 .. 01 ..... 100 ... ..... ..... \
-- 
2.17.1
