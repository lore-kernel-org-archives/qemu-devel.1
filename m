Received: from eggs.gnu.org ([2001:4830:134:3::10]:44081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSv2C-0002Nb-S3
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSv2A-0006H7-7P
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:57:16 -0400
Received: from mail-pl0-x235.google.com ([2607:f8b0:400e:c01::235]:44821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fSv2A-0006Gy-1R
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:57:14 -0400
Received: by mail-pl0-x235.google.com with SMTP id z9-v6so544517plk.11
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 18:57:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 12 Jun 2018 15:56:32 -1000
Message-Id: <20180613015641.5667-10-richard.henderson@linaro.org>
In-Reply-To: <20180613015641.5667-1-richard.henderson@linaro.org>
References: <20180613015641.5667-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4b 09/18] target/arm: Implement SVE vector
 splice (predicated)
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |  2 ++
 target/arm/sve_helper.c    | 37 +++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 13 +++++++++++++
 target/arm/sve.decode      |  3 +++
 4 files changed, 55 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 3b7c54905d..c3f8a2b502 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -479,6 +479,8 @@ DEF_HELPER_FLAGS_4(sve_rbit_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_rbit_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_rbit_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(sve_splice, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_and_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_bic_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_eor_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 4017b9eed1..8da7baad76 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2109,3 +2109,40 @@ int32_t HELPER(sve_last_active_element)(void *vg, uint32_t pred_desc)
 
     return last_active_element(vg, DIV_ROUND_UP(oprsz, 8), esz);
 }
+
+void HELPER(sve_splice)(void *vd, void *vn, void *vm, void *vg, uint32_t desc)
+{
+    intptr_t opr_sz = simd_oprsz(desc) / 8;
+    int esz = simd_data(desc);
+    uint64_t pg, first_g, last_g, len, mask = pred_esz_masks[esz];
+    intptr_t i, first_i, last_i;
+    ARMVectorReg tmp;
+
+    first_i = last_i = 0;
+    first_g = last_g = 0;
+
+    /* Find the extent of the active elements within VG.  */
+    for (i = QEMU_ALIGN_UP(opr_sz, 8) - 8; i >= 0; i -= 8) {
+        pg = *(uint64_t *)(vg + i) & mask;
+        if (pg) {
+            if (last_g == 0) {
+                last_g = pg;
+                last_i = i;
+            }
+            first_g = pg;
+            first_i = i;
+        }
+    }
+
+    len = 0;
+    if (first_g != 0) {
+        first_i = first_i * 8 + ctz64(first_g);
+        last_i = last_i * 8 + 63 - clz64(last_g);
+        len = last_i - first_i + (1 << esz);
+        if (vd == vm) {
+            vm = memcpy(&tmp, vm, opr_sz * 8);
+        }
+        swap_memmove(vd, vn + first_i, len);
+    }
+    swap_memmove(vd + len, vm, opr_sz * 8 - len);
+}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index f8d8cf1547..1517d82468 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -2681,6 +2681,19 @@ static bool trans_RBIT(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
     return do_zpz_ool(s, a, fns[a->esz]);
 }
 
+static bool trans_SPLICE(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+{
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_4_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           pred_full_reg_offset(s, a->pg),
+                           vsz, vsz, a->esz, gen_helper_sve_splice);
+    }
+    return true;
+}
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 95eb4968a9..a9fa631252 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -463,6 +463,9 @@ REVH            00000101 .. 1001 01 100 ... ..... .....         @rd_pg_rn
 REVW            00000101 .. 1001 10 100 ... ..... .....         @rd_pg_rn
 RBIT            00000101 .. 1001 11 100 ... ..... .....         @rd_pg_rn
 
+# SVE vector splice (predicated)
+SPLICE          00000101 .. 101 100 100 ... ..... .....         @rdn_pg_rm
+
 ### SVE Predicate Logical Operations Group
 
 # SVE predicate logical operations
-- 
2.17.1
