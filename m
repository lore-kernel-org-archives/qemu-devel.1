Received: from eggs.gnu.org ([2001:4830:134:3::10]:32831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfh-0001u4-VA
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfb-0006Ma-Ld
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:49 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfb-0006Kx-CD
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:43 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfa-0003mS-DF
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:42 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:25:05 +0100
Message-Id: <20180615142521.19143-28-peter.maydell@linaro.org>
In-Reply-To: <20180615142521.19143-1-peter.maydell@linaro.org>
References: <20180615142521.19143-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 27/43] target/arm: Implement SVE vector splice
 (predicated)
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
Message-id: 20180613015641.5667-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-sve.h    |  2 ++
 target/arm/sve_helper.c    | 37 +++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 13 +++++++++++++
 target/arm/sve.decode      |  3 +++
 4 files changed, 55 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 3b7c54905dd..c3f8a2b5021 100644
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
index 4017b9eed14..8da7baad764 100644
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
index f8d8cf1547a..1517d82468b 100644
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
index 95eb4968a9f..a9fa6312522 100644
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
