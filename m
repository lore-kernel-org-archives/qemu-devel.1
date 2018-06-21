Received: from eggs.gnu.org ([2001:4830:134:3::10]:39273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVonz-0004SA-E6
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:54:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVony-0003A3-Ax
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:54:35 -0400
Received: from mail-pl0-x22f.google.com ([2607:f8b0:400e:c01::22f]:45163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fVony-00039Y-2c
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:54:34 -0400
Received: by mail-pl0-x22f.google.com with SMTP id o18-v6so58673pll.12
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 18:54:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 20 Jun 2018 15:53:39 -1000
Message-Id: <20180621015359.12018-16-richard.henderson@linaro.org>
In-Reply-To: <20180621015359.12018-1-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 15/35] target/arm: Implement SVE scatter
 store vector immediate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 83 ++++++++++++++++++++++++++------------
 target/arm/sve.decode      | 11 +++++
 2 files changed, 69 insertions(+), 25 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 11c1bf112c..fdc3231e63 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4395,31 +4395,33 @@ static bool trans_LD1_zpiz(DisasContext *s, arg_LD1_zpiz *a, uint32_t insn)
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
@@ -4430,10 +4432,10 @@ static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a, uint32_t insn)
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
@@ -4443,6 +4445,37 @@ static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a, uint32_t insn)
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
index fb73a22c0e..311ae6dbdf 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -83,6 +83,7 @@
 &rprr_gather_load       rd pg rn rm esz msz u ff xs scale
 &rpri_gather_load       rd pg rn imm esz msz u ff
 &rprr_scatter_store     rd pg rn rm esz msz xs scale
+&rpri_scatter_store     rd pg rn imm esz msz
 
 ###########################################################################
 # Named instruction formats.  These are generally used to
@@ -215,6 +216,8 @@
                     &rprr_store nreg=0
 @rprr_scatter_store ....... msz:2 ..     rm:5 ... pg:3 rn:5 rd:5 \
                     &rprr_scatter_store
+@rpri_scatter_store ....... msz:2 ..    imm:5 ... pg:3 rn:5 rd:5 \
+                    &rpri_scatter_store
 
 ###########################################################################
 # Instruction patterns.  Grouped according to the SVE encodingindex.xhtml.
@@ -927,6 +930,14 @@ ST1_zprz        1110010 .. 01 ..... 101 ... ..... ..... \
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
