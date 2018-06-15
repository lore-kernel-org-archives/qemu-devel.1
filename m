Received: from eggs.gnu.org ([2001:4830:134:3::10]:32799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfg-0001sP-J6
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfc-0006NI-Iu
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:48 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfc-0006Kx-BG
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:44 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfb-0003mj-3m
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:43 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:25:06 +0100
Message-Id: <20180615142521.19143-29-peter.maydell@linaro.org>
In-Reply-To: <20180615142521.19143-1-peter.maydell@linaro.org>
References: <20180615142521.19143-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 28/43] target/arm: Implement SVE Select Vectors
 Group
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
Message-id: 20180613015641.5667-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-sve.h    |  9 +++++++
 target/arm/sve_helper.c    | 55 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c |  2 ++
 target/arm/sve.decode      |  6 +++++
 4 files changed, 72 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index c3f8a2b5021..0f57f64895b 100644
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
index 8da7baad764..f55fdc7dbef 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2146,3 +2146,58 @@ void HELPER(sve_splice)(void *vd, void *vn, void *vm, void *vg, uint32_t desc)
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
index 1517d82468b..0de9118fdfb 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -373,6 +373,8 @@ static bool trans_UDIV_zpzz(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
     return do_zpzz_ool(s, a, fns[a->esz]);
 }
 
+DO_ZPZZ(SEL, sel)
+
 #undef DO_ZPZZ
 
 /*
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index a9fa6312522..91522d8e137 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -98,6 +98,7 @@
                 &rprr_esz rn=%reg_movprfx
 @rdm_pg_rn      ........ esz:2 ... ... ... pg:3 rn:5 rd:5 \
                 &rprr_esz rm=%reg_movprfx
+@rd_pg4_rn_rm   ........ esz:2 . rm:5  .. pg:4  rn:5 rd:5       &rprr_esz
 
 # Three register operand, with governing predicate, vector element size
 @rda_pg_rn_rm   ........ esz:2 . rm:5  ... pg:3 rn:5 rd:5 \
@@ -466,6 +467,11 @@ RBIT            00000101 .. 1001 11 100 ... ..... .....         @rd_pg_rn
 # SVE vector splice (predicated)
 SPLICE          00000101 .. 101 100 100 ... ..... .....         @rdn_pg_rm
 
+### SVE Select Vectors Group
+
+# SVE select vector elements (predicated)
+SEL_zpzz        00000101 .. 1 ..... 11 .... ..... .....         @rd_pg4_rn_rm
+
 ### SVE Predicate Logical Operations Group
 
 # SVE predicate logical operations
-- 
2.17.1
