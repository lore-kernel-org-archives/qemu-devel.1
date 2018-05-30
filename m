Received: from eggs.gnu.org ([2001:4830:134:3::10]:33470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fO5Pq-0001z4-Jo
	for qemu-devel@nongnu.org; Wed, 30 May 2018 14:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fO5Po-0004dh-DU
	for qemu-devel@nongnu.org; Wed, 30 May 2018 14:01:42 -0400
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:38425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fO5Po-0004cT-2n
	for qemu-devel@nongnu.org; Wed, 30 May 2018 14:01:40 -0400
Received: by mail-pg0-x230.google.com with SMTP id c9-v6so5663057pgf.5
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 11:01:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 30 May 2018 11:01:12 -0700
Message-Id: <20180530180120.13355-11-richard.henderson@linaro.org>
In-Reply-To: <20180530180120.13355-1-richard.henderson@linaro.org>
References: <20180530180120.13355-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3b 10/18] target/arm: Implement SVE Select
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |  9 +++++++
 target/arm/sve_helper.c    | 55 ++++++++++++++++++++++++++++++++++++++
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
index f6d4b2139a..51cf9c47d9 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2145,3 +2145,58 @@ void HELPER(sve_splice)(void *vd, void *vn, void *vm, void *vg, uint32_t desc)
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
index cf3624b439..53b86af94d 100644
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
index a9fa631252..91522d8e13 100644
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
2.17.0
