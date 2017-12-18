Received: from eggs.gnu.org ([2001:4830:134:3::10]:37648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz3w-0000rC-Q6
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz3r-0001cF-M8
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:48 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:36778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQz3r-0001bD-CP
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:43 -0500
Received: by mail-pf0-x244.google.com with SMTP id p84so9944796pfd.3
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:18:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:17:58 -0800
Message-Id: <20171218171758.16964-27-richard.henderson@linaro.org>
In-Reply-To: <20171218171758.16964-1-richard.henderson@linaro.org>
References: <20171218171758.16964-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v7 26/26] tcg: Add generic helpers for
 saturating arithmetic
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

No vector ops as yet.  SSE only has direct support for 8- and 16-bit
saturation; handling 32- and 64-bit saturation is much more expensive.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h      |  20 ++++
 tcg/tcg-op-gvec.h            |  10 ++
 accel/tcg/tcg-runtime-gvec.c | 268 +++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg-op-gvec.c            |  92 +++++++++++++++
 4 files changed, 390 insertions(+)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index d1b3542946..ec187a094b 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -157,6 +157,26 @@ DEF_HELPER_FLAGS_4(gvec_mul16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_mul32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_mul64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_ssadd8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_ssadd16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_ssadd32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_ssadd64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_sssub8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sssub16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sssub32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sssub64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_usadd8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_usadd16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_usadd32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_usadd64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_ussub8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_ussub16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_ussub32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_ussub64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_3(gvec_neg8, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_neg16, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_neg32, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
index 3a927ce24d..64116d4291 100644
--- a/tcg/tcg-op-gvec.h
+++ b/tcg/tcg-op-gvec.h
@@ -179,6 +179,16 @@ void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_mul(unsigned vece, uint32_t dofs, uint32_t aofs,
                       uint32_t bofs, uint32_t opsz, uint32_t clsz);
 
+/* Saturated arithmetic.  */
+void tcg_gen_gvec_ssadd(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        uint32_t bofs, uint32_t opsz, uint32_t clsz);
+void tcg_gen_gvec_sssub(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        uint32_t bofs, uint32_t opsz, uint32_t clsz);
+void tcg_gen_gvec_usadd(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        uint32_t bofs, uint32_t opsz, uint32_t clsz);
+void tcg_gen_gvec_ussub(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        uint32_t bofs, uint32_t opsz, uint32_t clsz);
+
 void tcg_gen_gvec_and(unsigned vece, uint32_t dofs, uint32_t aofs,
                       uint32_t bofs, uint32_t opsz, uint32_t clsz);
 void tcg_gen_gvec_or(unsigned vece, uint32_t dofs, uint32_t aofs,
diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index ff26be0744..398ca54e1e 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -614,3 +614,271 @@ DO_EXT(gvec_extu32, uint32_t, uint64_t)
 DO_EXT(gvec_exts8, int8_t, int16_t)
 DO_EXT(gvec_exts16, int16_t, int32_t)
 DO_EXT(gvec_exts32, int32_t, int64_t)
+
+void HELPER(gvec_ssadd8)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(int8_t)) {
+        int r = *(int8_t *)(a + i) + *(int8_t *)(b + i);
+        if (r > INT8_MAX) {
+            r = INT8_MAX;
+        } else if (r < INT8_MIN) {
+            r = INT8_MIN;
+        }
+        *(int8_t *)(d + i) = r;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_ssadd16)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(int16_t)) {
+        int r = *(int16_t *)(a + i) + *(int16_t *)(b + i);
+        if (r > INT16_MAX) {
+            r = INT16_MAX;
+        } else if (r < INT16_MIN) {
+            r = INT16_MIN;
+        }
+        *(int16_t *)(d + i) = r;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_ssadd32)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(int32_t)) {
+        int32_t ai = *(int32_t *)(a + i);
+        int32_t bi = *(int32_t *)(b + i);
+        int32_t di = ai + bi;
+        if (((di ^ ai) &~ (ai ^ bi)) < 0) {
+            /* Signed overflow.  */
+            di = (di < 0 ? INT32_MAX : INT32_MIN);
+        }
+        *(int32_t *)(d + i) = di;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_ssadd64)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(int64_t)) {
+        int64_t ai = *(int64_t *)(a + i);
+        int64_t bi = *(int64_t *)(b + i);
+        int64_t di = ai + bi;
+        if (((di ^ ai) &~ (ai ^ bi)) < 0) {
+            /* Signed overflow.  */
+            di = (di < 0 ? INT64_MAX : INT64_MIN);
+        }
+        *(int64_t *)(d + i) = di;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_sssub8)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        int r = *(uint8_t *)(a + i) - *(uint8_t *)(b + i);
+        if (r > INT8_MAX) {
+            r = INT8_MAX;
+        } else if (r < INT8_MIN) {
+            r = INT8_MIN;
+        }
+        *(uint8_t *)(d + i) = r;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_sssub16)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(int16_t)) {
+        int r = *(int16_t *)(a + i) - *(int16_t *)(b + i);
+        if (r > INT16_MAX) {
+            r = INT16_MAX;
+        } else if (r < INT16_MIN) {
+            r = INT16_MIN;
+        }
+        *(int16_t *)(d + i) = r;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_sssub32)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(int32_t)) {
+        int32_t ai = *(int32_t *)(a + i);
+        int32_t bi = *(int32_t *)(b + i);
+        int32_t di = ai - bi;
+        if (((di ^ ai) & (ai ^ bi)) < 0) {
+            /* Signed overflow.  */
+            di = (di < 0 ? INT32_MAX : INT32_MIN);
+        }
+        *(int32_t *)(d + i) = di;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_sssub64)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(int64_t)) {
+        int64_t ai = *(int64_t *)(a + i);
+        int64_t bi = *(int64_t *)(b + i);
+        int64_t di = ai - bi;
+        if (((di ^ ai) & (ai ^ bi)) < 0) {
+            /* Signed overflow.  */
+            di = (di < 0 ? INT64_MAX : INT64_MIN);
+        }
+        *(int64_t *)(d + i) = di;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_usadd8)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        unsigned r = *(uint8_t *)(a + i) + *(uint8_t *)(b + i);
+        if (r > UINT8_MAX) {
+            r = UINT8_MAX;
+        }
+        *(uint8_t *)(d + i) = r;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_usadd16)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        unsigned r = *(uint16_t *)(a + i) + *(uint16_t *)(b + i);
+        if (r > UINT16_MAX) {
+            r = UINT16_MAX;
+        }
+        *(uint16_t *)(d + i) = r;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_usadd32)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        uint32_t ai = *(uint32_t *)(a + i);
+        uint32_t bi = *(uint32_t *)(b + i);
+        uint32_t di = ai + bi;
+        if (di < ai) {
+            di = UINT32_MAX;
+        }
+        *(uint32_t *)(d + i) = di;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_usadd64)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        uint64_t ai = *(uint64_t *)(a + i);
+        uint64_t bi = *(uint64_t *)(b + i);
+        uint64_t di = ai + bi;
+        if (di < ai) {
+            di = UINT64_MAX;
+        }
+        *(uint64_t *)(d + i) = di;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_ussub8)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        int r = *(uint8_t *)(a + i) - *(uint8_t *)(b + i);
+        if (r < 0) {
+            r = 0;
+        }
+        *(uint8_t *)(d + i) = r;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_ussub16)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        int r = *(uint16_t *)(a + i) - *(uint16_t *)(b + i);
+        if (r < 0) {
+            r = 0;
+        }
+        *(uint16_t *)(d + i) = r;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_ussub32)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        uint32_t ai = *(uint32_t *)(a + i);
+        uint32_t bi = *(uint32_t *)(b + i);
+        uint32_t di = ai - bi;
+        if (ai < bi) {
+            di = 0;
+        }
+        *(uint32_t *)(d + i) = di;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_ussub64)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        uint64_t ai = *(uint64_t *)(a + i);
+        uint64_t bi = *(uint64_t *)(b + i);
+        uint64_t di = ai - bi;
+        if (ai < bi) {
+            di = 0;
+        }
+        *(uint64_t *)(d + i) = di;
+    }
+    clear_high(d, oprsz, desc);
+}
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index a6df90b284..ddf0354106 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -1393,6 +1393,98 @@ void tcg_gen_gvec_mul(unsigned vece, uint32_t dofs, uint32_t aofs,
     tcg_gen_gvec_3(dofs, aofs, bofs, opsz, maxsz, &g[vece]);
 }
 
+void tcg_gen_gvec_ssadd(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        uint32_t bofs, uint32_t opsz, uint32_t maxsz)
+{
+    static const GVecGen3 g[4] = {
+        { .fno = gen_helper_gvec_ssadd8, .vece = MO_8 },
+        { .fno = gen_helper_gvec_ssadd16, .vece = MO_16 },
+        { .fno = gen_helper_gvec_ssadd32, .vece = MO_32 },
+        { .fno = gen_helper_gvec_ssadd64, .vece = MO_64 }
+    };
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, maxsz, &g[vece]);
+}
+
+void tcg_gen_gvec_sssub(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        uint32_t bofs, uint32_t opsz, uint32_t maxsz)
+{
+    static const GVecGen3 g[4] = {
+        { .fno = gen_helper_gvec_sssub8, .vece = MO_8 },
+        { .fno = gen_helper_gvec_sssub16, .vece = MO_16 },
+        { .fno = gen_helper_gvec_sssub32, .vece = MO_32 },
+        { .fno = gen_helper_gvec_sssub64, .vece = MO_64 }
+    };
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, maxsz, &g[vece]);
+}
+
+static void tcg_gen_vec_usadd32_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 max = tcg_const_i32(-1);
+    tcg_gen_add_i32(d, a, b);
+    tcg_gen_movcond_i32(TCG_COND_LTU, d, d, a, max, d);
+    tcg_temp_free_i32(max);
+}
+
+static void tcg_gen_vec_usadd32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 max = tcg_const_i64(-1);
+    tcg_gen_add_i64(d, a, b);
+    tcg_gen_movcond_i64(TCG_COND_LTU, d, d, a, max, d);
+    tcg_temp_free_i64(max);
+}
+
+void tcg_gen_gvec_usadd(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        uint32_t bofs, uint32_t opsz, uint32_t maxsz)
+{
+    static const GVecGen3 g[4] = {
+        { .fno = gen_helper_gvec_usadd8, .vece = MO_8 },
+        { .fno = gen_helper_gvec_usadd16, .vece = MO_16 },
+        { .fni4 = tcg_gen_vec_usadd32_i32,
+          .fno = gen_helper_gvec_usadd32,
+          .vece = MO_32 },
+        { .fni8 = tcg_gen_vec_usadd32_i64,
+          .fno = gen_helper_gvec_usadd64,
+          .vece = MO_64 }
+    };
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, maxsz, &g[vece]);
+}
+
+static void tcg_gen_vec_ussub32_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 min = tcg_const_i32(0);
+    tcg_gen_sub_i32(d, a, b);
+    tcg_gen_movcond_i32(TCG_COND_LTU, d, a, b, min, d);
+    tcg_temp_free_i32(min);
+}
+
+static void tcg_gen_vec_ussub32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 min = tcg_const_i64(0);
+    tcg_gen_sub_i64(d, a, b);
+    tcg_gen_movcond_i64(TCG_COND_LTU, d, a, b, min, d);
+    tcg_temp_free_i64(min);
+}
+
+void tcg_gen_gvec_ussub(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        uint32_t bofs, uint32_t opsz, uint32_t maxsz)
+{
+    static const GVecGen3 g[4] = {
+        { .fno = gen_helper_gvec_ussub8, .vece = MO_8 },
+        { .fno = gen_helper_gvec_ussub16, .vece = MO_16 },
+        { .fni4 = tcg_gen_vec_ussub32_i32,
+          .fno = gen_helper_gvec_ussub32,
+          .vece = MO_32 },
+        { .fni8 = tcg_gen_vec_ussub32_i64,
+          .fno = gen_helper_gvec_ussub64,
+          .vece = MO_64 }
+    };
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, maxsz, &g[vece]);
+}
+
 /* Perform a vector negation using normal negation and a mask.
    Compare gen_subv_mask above.  */
 static void gen_negv_mask(TCGv_i64 d, TCGv_i64 b, TCGv_i64 m)
-- 
2.14.3
