Received: from eggs.gnu.org ([2001:4830:134:3::10]:52758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92p-0001ba-RJ
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:39:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92n-0002lf-MC
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:39:55 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZ92l-0001u6-5j
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:39:51 -0500
Received: by mail-pg1-x543.google.com with SMTP id n2so7349923pgm.3
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 22:39:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 17 Dec 2018 22:38:40 -0800
Message-Id: <20181218063911.2112-4-richard.henderson@linaro.org>
In-Reply-To: <20181218063911.2112-1-richard.henderson@linaro.org>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 03/34] tcg: Add gvec expanders for nand, nor,
 eqv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h      |  3 +++
 tcg/tcg-op-gvec.h            |  6 +++++
 tcg/tcg-op.h                 |  3 +++
 accel/tcg/tcg-runtime-gvec.c | 33 +++++++++++++++++++++++
 tcg/tcg-op-gvec.c            | 51 ++++++++++++++++++++++++++++++++++++
 tcg/tcg-op-vec.c             | 21 +++++++++++++++
 6 files changed, 117 insertions(+)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 1bd39d136d..835ddfebb2 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -211,6 +211,9 @@ DEF_HELPER_FLAGS_4(gvec_or, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_xor, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_andc, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_orc, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_nand, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_nor, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_eqv, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(gvec_ands, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(gvec_xors, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
index ff43a29a0b..d65b9d9d4c 100644
--- a/tcg/tcg-op-gvec.h
+++ b/tcg/tcg-op-gvec.h
@@ -242,6 +242,12 @@ void tcg_gen_gvec_andc(unsigned vece, uint32_t dofs, uint32_t aofs,
                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
 void tcg_gen_gvec_orc(unsigned vece, uint32_t dofs, uint32_t aofs,
                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_nand(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_nor(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_eqv(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
 
 void tcg_gen_gvec_andi(unsigned vece, uint32_t dofs, uint32_t aofs,
                        int64_t c, uint32_t oprsz, uint32_t maxsz);
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index db4e9188f4..1974bf1cae 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -961,6 +961,9 @@ void tcg_gen_or_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_xor_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_andc_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_orc_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+void tcg_gen_nand_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+void tcg_gen_nor_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+void tcg_gen_eqv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
 void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
 
diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index 90340e56e0..d1802467d5 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -512,6 +512,39 @@ void HELPER(gvec_orc)(void *d, void *a, void *b, uint32_t desc)
     clear_high(d, oprsz, desc);
 }
 
+void HELPER(gvec_nand)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec64)) {
+        *(vec64 *)(d + i) = ~(*(vec64 *)(a + i) & *(vec64 *)(b + i));
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_nor)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec64)) {
+        *(vec64 *)(d + i) = ~(*(vec64 *)(a + i) | *(vec64 *)(b + i));
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_eqv)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec64)) {
+        *(vec64 *)(d + i) = ~(*(vec64 *)(a + i) ^ *(vec64 *)(b + i));
+    }
+    clear_high(d, oprsz, desc);
+}
+
 void HELPER(gvec_ands)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index ec231b78fb..81689d02f7 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -1920,6 +1920,57 @@ void tcg_gen_gvec_orc(unsigned vece, uint32_t dofs, uint32_t aofs,
     }
 }
 
+void tcg_gen_gvec_nand(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen3 g = {
+        .fni8 = tcg_gen_nand_i64,
+        .fniv = tcg_gen_nand_vec,
+        .fno = gen_helper_gvec_nand,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    };
+
+    if (aofs == bofs) {
+        tcg_gen_gvec_not(vece, dofs, aofs, oprsz, maxsz);
+    } else {
+        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
+    }
+}
+
+void tcg_gen_gvec_nor(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen3 g = {
+        .fni8 = tcg_gen_nor_i64,
+        .fniv = tcg_gen_nor_vec,
+        .fno = gen_helper_gvec_nor,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    };
+
+    if (aofs == bofs) {
+        tcg_gen_gvec_not(vece, dofs, aofs, oprsz, maxsz);
+    } else {
+        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
+    }
+}
+
+void tcg_gen_gvec_eqv(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen3 g = {
+        .fni8 = tcg_gen_eqv_i64,
+        .fniv = tcg_gen_eqv_vec,
+        .fno = gen_helper_gvec_eqv,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    };
+
+    if (aofs == bofs) {
+        tcg_gen_gvec_dup8i(dofs, oprsz, maxsz, -1);
+    } else {
+        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
+    }
+}
+
 static const GVecGen2s gop_ands = {
     .fni8 = tcg_gen_and_i64,
     .fniv = tcg_gen_and_vec,
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index cefba3d185..d77fdf7c1d 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -275,6 +275,27 @@ void tcg_gen_orc_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
     }
 }
 
+void tcg_gen_nand_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    /* TODO: Add TCG_TARGET_HAS_nand_vec when adding a backend supports it. */
+    tcg_gen_and_vec(0, r, a, b);
+    tcg_gen_not_vec(0, r, r);
+}
+
+void tcg_gen_nor_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    /* TODO: Add TCG_TARGET_HAS_nor_vec when adding a backend supports it. */
+    tcg_gen_or_vec(0, r, a, b);
+    tcg_gen_not_vec(0, r, r);
+}
+
+void tcg_gen_eqv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    /* TODO: Add TCG_TARGET_HAS_eqv_vec when adding a backend supports it. */
+    tcg_gen_xor_vec(0, r, a, b);
+    tcg_gen_not_vec(0, r, r);
+}
+
 void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
 {
     if (TCG_TARGET_HAS_not_vec) {
-- 
2.17.2
