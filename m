Received: from eggs.gnu.org ([2001:4830:134:3::10]:40018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en79Y-0000dI-KO
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en79X-0001jf-Je
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:04 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:36444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en79X-0001jM-EB
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:03 -0500
Received: by mail-pg0-x241.google.com with SMTP id j9so4359617pgv.3
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 10:24:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 10:22:38 -0800
Message-Id: <20180217182323.25885-23-richard.henderson@linaro.org>
In-Reply-To: <20180217182323.25885-1-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 22/67] target/arm: Implement SVE
 floating-point trig select coefficient
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
 target/arm/helper-sve.h    |  4 ++++
 target/arm/sve_helper.c    | 43 +++++++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 19 +++++++++++++++++++
 target/arm/sve.decode      |  4 ++++
 4 files changed, 70 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index e2925ff8ec..4f1bd5a62f 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -389,6 +389,10 @@ DEF_HELPER_FLAGS_3(sve_fexpa_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_fexpa_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_fexpa_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve_ftssel_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_ftssel_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_ftssel_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_and_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_bic_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_eor_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 4d42653eef..b4f70af23f 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -23,6 +23,7 @@
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
+#include "fpu/softfloat.h"
 
 
 /* Note that vector data is stored in host-endian 64-bit chunks,
@@ -1182,3 +1183,45 @@ void HELPER(sve_fexpa_d)(void *vd, void *vn, uint32_t desc)
         d[i] = coeff[idx] | (exp << 52);
     }
 }
+
+void HELPER(sve_ftssel_h)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 2;
+    uint16_t *d = vd, *n = vn, *m = vm;
+    for (i = 0; i < opr_sz; i += 1) {
+        uint16_t nn = n[i];
+        uint16_t mm = m[i];
+        if (mm & 1) {
+            nn = float16_one;
+        }
+        d[i] = nn ^ (mm & 2) << 14;
+    }
+}
+
+void HELPER(sve_ftssel_s)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 4;
+    uint32_t *d = vd, *n = vn, *m = vm;
+    for (i = 0; i < opr_sz; i += 1) {
+        uint32_t nn = n[i];
+        uint32_t mm = m[i];
+        if (mm & 1) {
+            nn = float32_one;
+        }
+        d[i] = nn ^ (mm & 2) << 30;
+    }
+}
+
+void HELPER(sve_ftssel_d)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd, *n = vn, *m = vm;
+    for (i = 0; i < opr_sz; i += 1) {
+        uint64_t nn = n[i];
+        uint64_t mm = m[i];
+        if (mm & 1) {
+            nn = float64_one;
+        }
+        d[i] = nn ^ (mm & 2) << 62;
+    }
+}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 2f23f1b192..e32be385fd 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -902,6 +902,25 @@ static void trans_FEXPA(DisasContext *s, arg_rr_esz *a, uint32_t insn)
                        vsz, vsz, 0, fns[a->esz]);
 }
 
+static void trans_FTSSEL(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        NULL,
+        gen_helper_sve_ftssel_h,
+        gen_helper_sve_ftssel_s,
+        gen_helper_sve_ftssel_d,
+    };
+    unsigned vsz = vec_full_reg_size(s);
+    if (a->esz == 0) {
+        unallocated_encoding(s);
+        return;
+    }
+    tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
+                       vec_full_reg_offset(s, a->rn),
+                       vec_full_reg_offset(s, a->rm),
+                       vsz, vsz, 0, fns[a->esz]);
+}
+
 /*
  *** SVE Predicate Logical Operations Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index e791fe8031..4ea3f33919 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -297,6 +297,10 @@ ADR_p64		00000100 11 1 ..... 1010 .. ..... .....		@rd_rn_msz_rm
 # Note esz != 0
 FEXPA		00000100 .. 1 00000 101110 ..... .....		@rd_rn
 
+# SVE floating-point trig select coefficient
+# Note esz != 0
+FTSSEL		00000100 .. 1 ..... 101100 ..... .....		@rd_rn_rm
+
 ### SVE Predicate Logical Operations Group
 
 # SVE predicate logical operations
-- 
2.14.3
