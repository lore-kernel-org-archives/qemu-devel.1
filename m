Received: from eggs.gnu.org ([2001:4830:134:3::10]:39464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVooO-0004ov-8C
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:55:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVooM-0003Qt-Ga
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:55:00 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:44093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fVooM-0003Qe-Ab
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:54:58 -0400
Received: by mail-pg0-x232.google.com with SMTP id g26-v6so636820pgn.11
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 18:54:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 20 Jun 2018 15:53:51 -1000
Message-Id: <20180621015359.12018-28-richard.henderson@linaro.org>
In-Reply-To: <20180621015359.12018-1-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 27/35] target/arm: Implement SVE MOVPRFX
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
 target/arm/translate-sve.c | 60 +++++++++++++++++++++++++++++++++++++-
 target/arm/sve.decode      |  7 +++++
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 308c04de89..067c219b54 100644
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
 
@@ -5038,3 +5061,38 @@ static bool trans_PRF_rr(DisasContext *s, arg_PRF_rr *a, uint32_t insn)
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
+ * For predicated zering movprfz, we need to rearrange the helpers to
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
index 94d7b157b4..85f2b39776 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -266,6 +266,10 @@ ORV             00000100 .. 011 000 001 ... ..... .....         @rd_pg_rn
 EORV            00000100 .. 011 001 001 ... ..... .....         @rd_pg_rn
 ANDV            00000100 .. 011 010 001 ... ..... .....         @rd_pg_rn
 
+# SVE constructive prefix (predicated)
+MOVPRFX_z       00000100 .. 010 000 001 ... ..... .....         @rd_pg_rn
+MOVPRFX_m       00000100 .. 010 001 001 ... ..... .....         @rd_pg_rn
+
 # SVE integer add reduction (predicated)
 # Note that saddv requires size != 3.
 UADDV           00000100 .. 000 001 001 ... ..... .....         @rd_pg_rn
@@ -414,6 +418,9 @@ ADR_p64         00000100 11 1 ..... 1010 .. ..... .....         @rd_rn_msz_rm
 
 ### SVE Integer Misc - Unpredicated Group
 
+# SVE constructive prefix (unpredicated)
+MOVPRFX         00000100 00 1 00000 101111 rn:5 rd:5
+
 # SVE floating-point exponential accelerator
 # Note esz != 0
 FEXPA           00000100 .. 1 00000 101110 ..... .....          @rd_rn
-- 
2.17.1
