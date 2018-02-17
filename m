Received: from eggs.gnu.org ([2001:4830:134:3::10]:40333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en79t-000158-4r
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en79r-0001uf-RW
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:25 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:34162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en79r-0001uK-LQ
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:23 -0500
Received: by mail-pf0-x242.google.com with SMTP id g17so591387pfh.1
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 10:24:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 10:22:51 -0800
Message-Id: <20180217182323.25885-36-richard.henderson@linaro.org>
In-Reply-To: <20180217182323.25885-1-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 35/67] target/arm: Implement SVE Select
 Vectors Group
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |  9 ++++++++
 target/arm/sve_helper.c    | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c |  2 ++
 target/arm/sve.decode      |  6 +++++
 4 files changed, 72 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index c3f8a2b502..0f57f64895 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -195,6 +195,15 @@ DEF_HELPER_FLAGS_5(sve_lsl_zpzz_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(sve_lsl_zpzz_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(sve_sel_zpzz_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_sel_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_sel_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_sel_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_asr_zpzw_b, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_asr_zpzw_h, TCG_CALL_NO_RWG,
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index f524a1ddce..86cd792cdf 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2125,3 +2125,58 @@ void HELPER(sve_splice)(void *vd, void *vn, void *vm, void *vg, uint32_t desc)
     }
     swap_memmove(vd + len, vm, opr_sz * 8 - len);
 }
+
+void HELPER(sve_sel_zpzz_b)(void *vd, void *vn, void *vm,
+                            void *vg, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd, *n = vn, *m = vm;
+    uint8_t *pg = vg;
+
+    for (i = 0; i < opr_sz; i += 1) {
+        uint64_t nn = n[i], mm = m[i];
+        uint64_t pp = expand_pred_b(pg[H1(i)]);
+        d[i] = (nn & pp) | (mm & ~pp);
+    }
+}
+
+void HELPER(sve_sel_zpzz_h)(void *vd, void *vn, void *vm,
+                            void *vg, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd, *n = vn, *m = vm;
+    uint8_t *pg = vg;
+
+    for (i = 0; i < opr_sz; i += 1) {
+        uint64_t nn = n[i], mm = m[i];
+        uint64_t pp = expand_pred_h(pg[H1(i)]);
+        d[i] = (nn & pp) | (mm & ~pp);
+    }
+}
+
+void HELPER(sve_sel_zpzz_s)(void *vd, void *vn, void *vm,
+                            void *vg, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd, *n = vn, *m = vm;
+    uint8_t *pg = vg;
+
+    for (i = 0; i < opr_sz; i += 1) {
+        uint64_t nn = n[i], mm = m[i];
+        uint64_t pp = expand_pred_s(pg[H1(i)]);
+        d[i] = (nn & pp) | (mm & ~pp);
+    }
+}
+
+void HELPER(sve_sel_zpzz_d)(void *vd, void *vn, void *vm,
+                            void *vg, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd, *n = vn, *m = vm;
+    uint8_t *pg = vg;
+
+    for (i = 0; i < opr_sz; i += 1) {
+        uint64_t nn = n[i], mm = m[i];
+        d[i] = (pg[H1(i)] & 1 ? nn : mm);
+    }
+}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 559fb41fd6..021b33ced9 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -361,6 +361,8 @@ static void trans_UDIV_zpzz(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
     do_zpzz_ool(s, a, fns[a->esz]);
 }
 
+DO_ZPZZ(SEL, sel)
+
 #undef DO_ZPZZ
 
 /*
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 70feb448e6..7ec84fdd80 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -99,6 +99,7 @@
 		&rprr_esz rn=%reg_movprfx
 @rdm_pg_rn	........ esz:2 ... ... ... pg:3 rn:5 rd:5 \
 		&rprr_esz rm=%reg_movprfx
+@rd_pg4_rn_rm	........ esz:2 . rm:5  .. pg:4  rn:5 rd:5	&rprr_esz
 
 # Three register operand, with governing predicate, vector element size
 @rda_pg_rn_rm	........ esz:2 . rm:5  ... pg:3 rn:5 rd:5 \
@@ -467,6 +468,11 @@ RBIT		00000101 .. 1001 11 100 ... ..... .....		@rd_pg_rn
 # SVE vector splice (predicated)
 SPLICE		00000101 .. 101 100 100 ... ..... .....		@rdn_pg_rm
 
+### SVE Select Vectors Group
+
+# SVE select vector elements (predicated)
+SEL_zpzz	00000101 .. 1 ..... 11 .... ..... .....		@rd_pg4_rn_rm
+
 ### SVE Predicate Logical Operations Group
 
 # SVE predicate logical operations
-- 
2.14.3
