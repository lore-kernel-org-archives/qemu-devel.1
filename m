Received: from eggs.gnu.org ([2001:4830:134:3::10]:53053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92y-0001iB-3r
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92q-0002pi-Mv
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:03 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:34232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZ92q-0001ws-5E
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:39:56 -0500
Received: by mail-pl1-x644.google.com with SMTP id w4so7367773plz.1
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 22:39:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 17 Dec 2018 22:38:44 -0800
Message-Id: <20181218063911.2112-8-richard.henderson@linaro.org>
In-Reply-To: <20181218063911.2112-1-richard.henderson@linaro.org>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 07/34] tcg: Add opcodes for vector minmax
 arithmetic
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
 accel/tcg/tcg-runtime.h      |  20 ++++
 tcg/aarch64/tcg-target.h     |   1 +
 tcg/i386/tcg-target.h        |   1 +
 tcg/tcg-op-gvec.h            |  10 ++
 tcg/tcg-op.h                 |   4 +
 tcg/tcg-opc.h                |   4 +
 tcg/tcg.h                    |   1 +
 accel/tcg/tcg-runtime-gvec.c | 224 +++++++++++++++++++++++++++++++++++
 tcg/tcg-op-gvec.c            | 108 +++++++++++++++++
 tcg/tcg-op-vec.c             |  20 ++++
 tcg/tcg.c                    |   5 +
 11 files changed, 398 insertions(+)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 835ddfebb2..dfe325625c 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -200,6 +200,26 @@ DEF_HELPER_FLAGS_4(gvec_ussub16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_ussub32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_ussub64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_smin8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_smin16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_smin32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_smin64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_smax8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_smax16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_smax32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_smax64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_umin8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_umin16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_umin32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_umin64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_umax8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_umax16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_umax32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_umax64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_3(gvec_neg8, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_neg16, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_neg32, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 98556bcf22..545a6eec75 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -136,6 +136,7 @@ typedef enum {
 #define TCG_TARGET_HAS_cmp_vec          1
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          0
+#define TCG_TARGET_HAS_minmax_vec       0
 
 #define TCG_TARGET_DEFAULT_MO (0)
 #define TCG_TARGET_HAS_MEMORY_BSWAP     1
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index f50234d97b..efbd5a6fc9 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -186,6 +186,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_cmp_vec          1
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
+#define TCG_TARGET_HAS_minmax_vec       0
 
 #define TCG_TARGET_deposit_i32_valid(ofs, len) \
     (((ofs) == 0 && (len) == 8) || ((ofs) == 8 && (len) == 8) || \
diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
index 2cb447112e..4734eef7de 100644
--- a/tcg/tcg-op-gvec.h
+++ b/tcg/tcg-op-gvec.h
@@ -234,6 +234,16 @@ void tcg_gen_gvec_usadd(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_ussub(unsigned vece, uint32_t dofs, uint32_t aofs,
                         uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
 
+/* Min/max.  */
+void tcg_gen_gvec_smin(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_umin(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_smax(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_umax(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+
 void tcg_gen_gvec_and(unsigned vece, uint32_t dofs, uint32_t aofs,
                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
 void tcg_gen_gvec_or(unsigned vece, uint32_t dofs, uint32_t aofs,
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 90b3193bf3..042c45e807 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -970,6 +970,10 @@ void tcg_gen_ssadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_usadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_sssub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_ussub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+void tcg_gen_smin_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+void tcg_gen_umin_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+void tcg_gen_smax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+void tcg_gen_umax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 
 void tcg_gen_shli_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
 void tcg_gen_shri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index 94691e849b..691eddebdf 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -225,6 +225,10 @@ DEF(ssadd_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_sat_vec))
 DEF(usadd_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_sat_vec))
 DEF(sssub_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_sat_vec))
 DEF(ussub_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_sat_vec))
+DEF(smin_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_minmax_vec))
+DEF(umin_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_minmax_vec))
+DEF(smax_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_minmax_vec))
+DEF(umax_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_minmax_vec))
 
 DEF(and_vec, 1, 2, 0, IMPLVEC)
 DEF(or_vec, 1, 2, 0, IMPLVEC)
diff --git a/tcg/tcg.h b/tcg/tcg.h
index c90f65a387..b5bec3abf8 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -184,6 +184,7 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_shv_vec          0
 #define TCG_TARGET_HAS_mul_vec          0
 #define TCG_TARGET_HAS_sat_vec          0
+#define TCG_TARGET_HAS_minmax_vec       0
 #else
 #define TCG_TARGET_MAYBE_vec            1
 #endif
diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index d1802467d5..9358749741 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -1028,3 +1028,227 @@ void HELPER(gvec_ussub64)(void *d, void *a, void *b, uint32_t desc)
     }
     clear_high(d, oprsz, desc);
 }
+
+void HELPER(gvec_smin8)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(int8_t)) {
+        int8_t aa = *(int8_t *)(a + i);
+        int8_t bb = *(int8_t *)(b + i);
+        int8_t dd = aa < bb ? aa : bb;
+        *(int8_t *)(d + i) = dd;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_smin16)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(int16_t)) {
+        int16_t aa = *(int16_t *)(a + i);
+        int16_t bb = *(int16_t *)(b + i);
+        int16_t dd = aa < bb ? aa : bb;
+        *(int16_t *)(d + i) = dd;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_smin32)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(int32_t)) {
+        int32_t aa = *(int32_t *)(a + i);
+        int32_t bb = *(int32_t *)(b + i);
+        int32_t dd = aa < bb ? aa : bb;
+        *(int32_t *)(d + i) = dd;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_smin64)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(int64_t)) {
+        int64_t aa = *(int64_t *)(a + i);
+        int64_t bb = *(int64_t *)(b + i);
+        int64_t dd = aa < bb ? aa : bb;
+        *(int64_t *)(d + i) = dd;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_smax8)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(int8_t)) {
+        int8_t aa = *(int8_t *)(a + i);
+        int8_t bb = *(int8_t *)(b + i);
+        int8_t dd = aa > bb ? aa : bb;
+        *(int8_t *)(d + i) = dd;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_smax16)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(int16_t)) {
+        int16_t aa = *(int16_t *)(a + i);
+        int16_t bb = *(int16_t *)(b + i);
+        int16_t dd = aa > bb ? aa : bb;
+        *(int16_t *)(d + i) = dd;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_smax32)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(int32_t)) {
+        int32_t aa = *(int32_t *)(a + i);
+        int32_t bb = *(int32_t *)(b + i);
+        int32_t dd = aa > bb ? aa : bb;
+        *(int32_t *)(d + i) = dd;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_smax64)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(int64_t)) {
+        int64_t aa = *(int64_t *)(a + i);
+        int64_t bb = *(int64_t *)(b + i);
+        int64_t dd = aa > bb ? aa : bb;
+        *(int64_t *)(d + i) = dd;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_umin8)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        uint8_t aa = *(uint8_t *)(a + i);
+        uint8_t bb = *(uint8_t *)(b + i);
+        uint8_t dd = aa < bb ? aa : bb;
+        *(uint8_t *)(d + i) = dd;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_umin16)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        uint16_t aa = *(uint16_t *)(a + i);
+        uint16_t bb = *(uint16_t *)(b + i);
+        uint16_t dd = aa < bb ? aa : bb;
+        *(uint16_t *)(d + i) = dd;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_umin32)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        uint32_t aa = *(uint32_t *)(a + i);
+        uint32_t bb = *(uint32_t *)(b + i);
+        uint32_t dd = aa < bb ? aa : bb;
+        *(uint32_t *)(d + i) = dd;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_umin64)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        uint64_t aa = *(uint64_t *)(a + i);
+        uint64_t bb = *(uint64_t *)(b + i);
+        uint64_t dd = aa < bb ? aa : bb;
+        *(uint64_t *)(d + i) = dd;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_umax8)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        uint8_t aa = *(uint8_t *)(a + i);
+        uint8_t bb = *(uint8_t *)(b + i);
+        uint8_t dd = aa > bb ? aa : bb;
+        *(uint8_t *)(d + i) = dd;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_umax16)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        uint16_t aa = *(uint16_t *)(a + i);
+        uint16_t bb = *(uint16_t *)(b + i);
+        uint16_t dd = aa > bb ? aa : bb;
+        *(uint16_t *)(d + i) = dd;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_umax32)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        uint32_t aa = *(uint32_t *)(a + i);
+        uint32_t bb = *(uint32_t *)(b + i);
+        uint32_t dd = aa > bb ? aa : bb;
+        *(uint32_t *)(d + i) = dd;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_umax64)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        uint64_t aa = *(uint64_t *)(a + i);
+        uint64_t bb = *(uint64_t *)(b + i);
+        uint64_t dd = aa > bb ? aa : bb;
+        *(uint64_t *)(d + i) = dd;
+    }
+    clear_high(d, oprsz, desc);
+}
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 0a33f51065..3ee44fcb75 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -1810,6 +1810,114 @@ void tcg_gen_gvec_ussub(unsigned vece, uint32_t dofs, uint32_t aofs,
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
 }
 
+void tcg_gen_gvec_smin(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen3 g[4] = {
+        { .fniv = tcg_gen_smin_vec,
+          .fno = gen_helper_gvec_smin8,
+          .opc = INDEX_op_smin_vec,
+          .vece = MO_8 },
+        { .fniv = tcg_gen_smin_vec,
+          .fno = gen_helper_gvec_smin16,
+          .opc = INDEX_op_smin_vec,
+          .vece = MO_16 },
+        { .fni4 = tcg_gen_smin_i32,
+          .fniv = tcg_gen_smin_vec,
+          .fno = gen_helper_gvec_smin32,
+          .opc = INDEX_op_smin_vec,
+          .vece = MO_32 },
+        { .fni8 = tcg_gen_smin_i64,
+          .fniv = tcg_gen_smin_vec,
+          .fno = gen_helper_gvec_smin64,
+          .opc = INDEX_op_smin_vec,
+          .vece = MO_64 }
+    };
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
+}
+
+void tcg_gen_gvec_umin(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen3 g[4] = {
+        { .fniv = tcg_gen_umin_vec,
+          .fno = gen_helper_gvec_umin8,
+          .opc = INDEX_op_umin_vec,
+          .vece = MO_8 },
+        { .fniv = tcg_gen_umin_vec,
+          .fno = gen_helper_gvec_umin16,
+          .opc = INDEX_op_umin_vec,
+          .vece = MO_16 },
+        { .fni4 = tcg_gen_umin_i32,
+          .fniv = tcg_gen_umin_vec,
+          .fno = gen_helper_gvec_umin32,
+          .opc = INDEX_op_umin_vec,
+          .vece = MO_32 },
+        { .fni8 = tcg_gen_umin_i64,
+          .fniv = tcg_gen_umin_vec,
+          .fno = gen_helper_gvec_umin64,
+          .opc = INDEX_op_umin_vec,
+          .vece = MO_64 }
+    };
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
+}
+
+void tcg_gen_gvec_smax(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen3 g[4] = {
+        { .fniv = tcg_gen_smax_vec,
+          .fno = gen_helper_gvec_smax8,
+          .opc = INDEX_op_smax_vec,
+          .vece = MO_8 },
+        { .fniv = tcg_gen_smax_vec,
+          .fno = gen_helper_gvec_smax16,
+          .opc = INDEX_op_smax_vec,
+          .vece = MO_16 },
+        { .fni4 = tcg_gen_smax_i32,
+          .fniv = tcg_gen_smax_vec,
+          .fno = gen_helper_gvec_smax32,
+          .opc = INDEX_op_smax_vec,
+          .vece = MO_32 },
+        { .fni8 = tcg_gen_smax_i64,
+          .fniv = tcg_gen_smax_vec,
+          .fno = gen_helper_gvec_smax64,
+          .opc = INDEX_op_smax_vec,
+          .vece = MO_64 }
+    };
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
+}
+
+void tcg_gen_gvec_umax(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen3 g[4] = {
+        { .fniv = tcg_gen_umax_vec,
+          .fno = gen_helper_gvec_umax8,
+          .opc = INDEX_op_umax_vec,
+          .vece = MO_8 },
+        { .fniv = tcg_gen_umax_vec,
+          .fno = gen_helper_gvec_umax16,
+          .opc = INDEX_op_umax_vec,
+          .vece = MO_16 },
+        { .fni4 = tcg_gen_umax_i32,
+          .fniv = tcg_gen_umax_vec,
+          .fno = gen_helper_gvec_umax32,
+          .opc = INDEX_op_umax_vec,
+          .vece = MO_32 },
+        { .fni8 = tcg_gen_umax_i64,
+          .fniv = tcg_gen_umax_vec,
+          .fno = gen_helper_gvec_umax64,
+          .opc = INDEX_op_umax_vec,
+          .vece = MO_64 }
+    };
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
+}
+
 /* Perform a vector negation using normal negation and a mask.
    Compare gen_subv_mask above.  */
 static void gen_negv_mask(TCGv_i64 d, TCGv_i64 b, TCGv_i64 m)
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 675aa09258..36f35022ac 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -433,3 +433,23 @@ void tcg_gen_ussub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
     do_op3(vece, r, a, b, INDEX_op_ussub_vec);
 }
+
+void tcg_gen_smin_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    do_op3(vece, r, a, b, INDEX_op_smin_vec);
+}
+
+void tcg_gen_umin_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    do_op3(vece, r, a, b, INDEX_op_umin_vec);
+}
+
+void tcg_gen_smax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    do_op3(vece, r, a, b, INDEX_op_smax_vec);
+}
+
+void tcg_gen_umax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    do_op3(vece, r, a, b, INDEX_op_umax_vec);
+}
diff --git a/tcg/tcg.c b/tcg/tcg.c
index f2cf60425b..2ee031fcf7 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1612,6 +1612,11 @@ bool tcg_op_supported(TCGOpcode op)
     case INDEX_op_sssub_vec:
     case INDEX_op_ussub_vec:
         return have_vec && TCG_TARGET_HAS_sat_vec;
+    case INDEX_op_smin_vec:
+    case INDEX_op_umin_vec:
+    case INDEX_op_smax_vec:
+    case INDEX_op_umax_vec:
+        return have_vec && TCG_TARGET_HAS_minmax_vec;
 
     default:
         tcg_debug_assert(op > INDEX_op_last_generic && op < NB_OPS);
-- 
2.17.2
