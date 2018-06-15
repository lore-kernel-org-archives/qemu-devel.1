Received: from eggs.gnu.org ([2001:4830:134:3::10]:60916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfa-0001iq-45
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfX-0006HO-Dx
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:42 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfW-0006G7-U0
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:39 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfV-0003jc-Ue
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:37 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:24:59 +0100
Message-Id: <20180615142521.19143-22-peter.maydell@linaro.org>
In-Reply-To: <20180615142521.19143-1-peter.maydell@linaro.org>
References: <20180615142521.19143-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 21/43] target/arm: Implement SVE Permute -
 Predicates Group
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
Message-id: 20180613015641.5667-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-sve.h    |   6 +
 target/arm/sve_helper.c    | 290 +++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 120 +++++++++++++++
 target/arm/sve.decode      |  18 +++
 4 files changed, 434 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 0c9aad575e0..ff958fcebd5 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -439,6 +439,12 @@ DEF_HELPER_FLAGS_3(sve_uunpk_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_uunpk_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_uunpk_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve_zip_p, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_uzp_p, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_trn_p, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_rev_p, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_punpk_p, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_and_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_bic_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_eor_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 58c0fda3331..f4d49d4aff7 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1674,3 +1674,293 @@ DO_UNPK(sve_uunpk_s, uint32_t, uint16_t, H4, H2)
 DO_UNPK(sve_uunpk_d, uint64_t, uint32_t, , H4)
 
 #undef DO_UNPK
+
+/* Mask of bits included in the even numbered predicates of width esz.
+ * We also use this for expand_bits/compress_bits, and so extend the
+ * same pattern out to 16-bit units.
+ */
+static const uint64_t even_bit_esz_masks[5] = {
+    0x5555555555555555ull,
+    0x3333333333333333ull,
+    0x0f0f0f0f0f0f0f0full,
+    0x00ff00ff00ff00ffull,
+    0x0000ffff0000ffffull,
+};
+
+/* Zero-extend units of 2**N bits to units of 2**(N+1) bits.
+ * For N==0, this corresponds to the operation that in qemu/bitops.h
+ * we call half_shuffle64; this algorithm is from Hacker's Delight,
+ * section 7-2 Shuffling Bits.
+ */
+static uint64_t expand_bits(uint64_t x, int n)
+{
+    int i;
+
+    x &= 0xffffffffu;
+    for (i = 4; i >= n; i--) {
+        int sh = 1 << i;
+        x = ((x << sh) | x) & even_bit_esz_masks[i];
+    }
+    return x;
+}
+
+/* Compress units of 2**(N+1) bits to units of 2**N bits.
+ * For N==0, this corresponds to the operation that in qemu/bitops.h
+ * we call half_unshuffle64; this algorithm is from Hacker's Delight,
+ * section 7-2 Shuffling Bits, where it is called an inverse half shuffle.
+ */
+static uint64_t compress_bits(uint64_t x, int n)
+{
+    int i;
+
+    for (i = n; i <= 4; i++) {
+        int sh = 1 << i;
+        x &= even_bit_esz_masks[i];
+        x = (x >> sh) | x;
+    }
+    return x & 0xffffffffu;
+}
+
+void HELPER(sve_zip_p)(void *vd, void *vn, void *vm, uint32_t pred_desc)
+{
+    intptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
+    int esz = extract32(pred_desc, SIMD_DATA_SHIFT, 2);
+    intptr_t high = extract32(pred_desc, SIMD_DATA_SHIFT + 2, 1);
+    uint64_t *d = vd;
+    intptr_t i;
+
+    if (oprsz <= 8) {
+        uint64_t nn = *(uint64_t *)vn;
+        uint64_t mm = *(uint64_t *)vm;
+        int half = 4 * oprsz;
+
+        nn = extract64(nn, high * half, half);
+        mm = extract64(mm, high * half, half);
+        nn = expand_bits(nn, esz);
+        mm = expand_bits(mm, esz);
+        d[0] = nn + (mm << (1 << esz));
+    } else {
+        ARMPredicateReg tmp_n, tmp_m;
+
+        /* We produce output faster than we consume input.
+           Therefore we must be mindful of possible overlap.  */
+        if ((vn - vd) < (uintptr_t)oprsz) {
+            vn = memcpy(&tmp_n, vn, oprsz);
+        }
+        if ((vm - vd) < (uintptr_t)oprsz) {
+            vm = memcpy(&tmp_m, vm, oprsz);
+        }
+        if (high) {
+            high = oprsz >> 1;
+        }
+
+        if ((high & 3) == 0) {
+            uint32_t *n = vn, *m = vm;
+            high >>= 2;
+
+            for (i = 0; i < DIV_ROUND_UP(oprsz, 8); i++) {
+                uint64_t nn = n[H4(high + i)];
+                uint64_t mm = m[H4(high + i)];
+
+                nn = expand_bits(nn, esz);
+                mm = expand_bits(mm, esz);
+                d[i] = nn + (mm << (1 << esz));
+            }
+        } else {
+            uint8_t *n = vn, *m = vm;
+            uint16_t *d16 = vd;
+
+            for (i = 0; i < oprsz / 2; i++) {
+                uint16_t nn = n[H1(high + i)];
+                uint16_t mm = m[H1(high + i)];
+
+                nn = expand_bits(nn, esz);
+                mm = expand_bits(mm, esz);
+                d16[H2(i)] = nn + (mm << (1 << esz));
+            }
+        }
+    }
+}
+
+void HELPER(sve_uzp_p)(void *vd, void *vn, void *vm, uint32_t pred_desc)
+{
+    intptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
+    int esz = extract32(pred_desc, SIMD_DATA_SHIFT, 2);
+    int odd = extract32(pred_desc, SIMD_DATA_SHIFT + 2, 1) << esz;
+    uint64_t *d = vd, *n = vn, *m = vm;
+    uint64_t l, h;
+    intptr_t i;
+
+    if (oprsz <= 8) {
+        l = compress_bits(n[0] >> odd, esz);
+        h = compress_bits(m[0] >> odd, esz);
+        d[0] = extract64(l + (h << (4 * oprsz)), 0, 8 * oprsz);
+    } else {
+        ARMPredicateReg tmp_m;
+        intptr_t oprsz_16 = oprsz / 16;
+
+        if ((vm - vd) < (uintptr_t)oprsz) {
+            m = memcpy(&tmp_m, vm, oprsz);
+        }
+
+        for (i = 0; i < oprsz_16; i++) {
+            l = n[2 * i + 0];
+            h = n[2 * i + 1];
+            l = compress_bits(l >> odd, esz);
+            h = compress_bits(h >> odd, esz);
+            d[i] = l + (h << 32);
+        }
+
+        /* For VL which is not a power of 2, the results from M do not
+           align nicely with the uint64_t for D.  Put the aligned results
+           from M into TMP_M and then copy it into place afterward.  */
+        if (oprsz & 15) {
+            d[i] = compress_bits(n[2 * i] >> odd, esz);
+
+            for (i = 0; i < oprsz_16; i++) {
+                l = m[2 * i + 0];
+                h = m[2 * i + 1];
+                l = compress_bits(l >> odd, esz);
+                h = compress_bits(h >> odd, esz);
+                tmp_m.p[i] = l + (h << 32);
+            }
+            tmp_m.p[i] = compress_bits(m[2 * i] >> odd, esz);
+
+            swap_memmove(vd + oprsz / 2, &tmp_m, oprsz / 2);
+        } else {
+            for (i = 0; i < oprsz_16; i++) {
+                l = m[2 * i + 0];
+                h = m[2 * i + 1];
+                l = compress_bits(l >> odd, esz);
+                h = compress_bits(h >> odd, esz);
+                d[oprsz_16 + i] = l + (h << 32);
+            }
+        }
+    }
+}
+
+void HELPER(sve_trn_p)(void *vd, void *vn, void *vm, uint32_t pred_desc)
+{
+    intptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
+    uintptr_t esz = extract32(pred_desc, SIMD_DATA_SHIFT, 2);
+    bool odd = extract32(pred_desc, SIMD_DATA_SHIFT + 2, 1);
+    uint64_t *d = vd, *n = vn, *m = vm;
+    uint64_t mask;
+    int shr, shl;
+    intptr_t i;
+
+    shl = 1 << esz;
+    shr = 0;
+    mask = even_bit_esz_masks[esz];
+    if (odd) {
+        mask <<= shl;
+        shr = shl;
+        shl = 0;
+    }
+
+    for (i = 0; i < DIV_ROUND_UP(oprsz, 8); i++) {
+        uint64_t nn = (n[i] & mask) >> shr;
+        uint64_t mm = (m[i] & mask) << shl;
+        d[i] = nn + mm;
+    }
+}
+
+/* Reverse units of 2**N bits.  */
+static uint64_t reverse_bits_64(uint64_t x, int n)
+{
+    int i, sh;
+
+    x = bswap64(x);
+    for (i = 2, sh = 4; i >= n; i--, sh >>= 1) {
+        uint64_t mask = even_bit_esz_masks[i];
+        x = ((x & mask) << sh) | ((x >> sh) & mask);
+    }
+    return x;
+}
+
+static uint8_t reverse_bits_8(uint8_t x, int n)
+{
+    static const uint8_t mask[3] = { 0x55, 0x33, 0x0f };
+    int i, sh;
+
+    for (i = 2, sh = 4; i >= n; i--, sh >>= 1) {
+        x = ((x & mask[i]) << sh) | ((x >> sh) & mask[i]);
+    }
+    return x;
+}
+
+void HELPER(sve_rev_p)(void *vd, void *vn, uint32_t pred_desc)
+{
+    intptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
+    int esz = extract32(pred_desc, SIMD_DATA_SHIFT, 2);
+    intptr_t i, oprsz_2 = oprsz / 2;
+
+    if (oprsz <= 8) {
+        uint64_t l = *(uint64_t *)vn;
+        l = reverse_bits_64(l << (64 - 8 * oprsz), esz);
+        *(uint64_t *)vd = l;
+    } else if ((oprsz & 15) == 0) {
+        for (i = 0; i < oprsz_2; i += 8) {
+            intptr_t ih = oprsz - 8 - i;
+            uint64_t l = reverse_bits_64(*(uint64_t *)(vn + i), esz);
+            uint64_t h = reverse_bits_64(*(uint64_t *)(vn + ih), esz);
+            *(uint64_t *)(vd + i) = h;
+            *(uint64_t *)(vd + ih) = l;
+        }
+    } else {
+        for (i = 0; i < oprsz_2; i += 1) {
+            intptr_t il = H1(i);
+            intptr_t ih = H1(oprsz - 1 - i);
+            uint8_t l = reverse_bits_8(*(uint8_t *)(vn + il), esz);
+            uint8_t h = reverse_bits_8(*(uint8_t *)(vn + ih), esz);
+            *(uint8_t *)(vd + il) = h;
+            *(uint8_t *)(vd + ih) = l;
+        }
+    }
+}
+
+void HELPER(sve_punpk_p)(void *vd, void *vn, uint32_t pred_desc)
+{
+    intptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
+    intptr_t high = extract32(pred_desc, SIMD_DATA_SHIFT + 2, 1);
+    uint64_t *d = vd;
+    intptr_t i;
+
+    if (oprsz <= 8) {
+        uint64_t nn = *(uint64_t *)vn;
+        int half = 4 * oprsz;
+
+        nn = extract64(nn, high * half, half);
+        nn = expand_bits(nn, 0);
+        d[0] = nn;
+    } else {
+        ARMPredicateReg tmp_n;
+
+        /* We produce output faster than we consume input.
+           Therefore we must be mindful of possible overlap.  */
+        if ((vn - vd) < (uintptr_t)oprsz) {
+            vn = memcpy(&tmp_n, vn, oprsz);
+        }
+        if (high) {
+            high = oprsz >> 1;
+        }
+
+        if ((high & 3) == 0) {
+            uint32_t *n = vn;
+            high >>= 2;
+
+            for (i = 0; i < DIV_ROUND_UP(oprsz, 8); i++) {
+                uint64_t nn = n[H4(high + i)];
+                d[i] = expand_bits(nn, 0);
+            }
+        } else {
+            uint16_t *d16 = vd;
+            uint8_t *n = vn;
+
+            for (i = 0; i < oprsz / 2; i++) {
+                uint16_t nn = n[H1(high + i)];
+                d16[H2(i)] = expand_bits(nn, 0);
+            }
+        }
+    }
+}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 388cce99243..0160d06915b 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -2089,6 +2089,126 @@ static bool trans_UNPK(DisasContext *s, arg_UNPK *a, uint32_t insn)
     return true;
 }
 
+/*
+ *** SVE Permute - Predicates Group
+ */
+
+static bool do_perm_pred3(DisasContext *s, arg_rrr_esz *a, bool high_odd,
+                          gen_helper_gvec_3 *fn)
+{
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    unsigned vsz = pred_full_reg_size(s);
+
+    /* Predicate sizes may be smaller and cannot use simd_desc.
+       We cannot round up, as we do elsewhere, because we need
+       the exact size for ZIP2 and REV.  We retain the style for
+       the other helpers for consistency.  */
+    TCGv_ptr t_d = tcg_temp_new_ptr();
+    TCGv_ptr t_n = tcg_temp_new_ptr();
+    TCGv_ptr t_m = tcg_temp_new_ptr();
+    TCGv_i32 t_desc;
+    int desc;
+
+    desc = vsz - 2;
+    desc = deposit32(desc, SIMD_DATA_SHIFT, 2, a->esz);
+    desc = deposit32(desc, SIMD_DATA_SHIFT + 2, 2, high_odd);
+
+    tcg_gen_addi_ptr(t_d, cpu_env, pred_full_reg_offset(s, a->rd));
+    tcg_gen_addi_ptr(t_n, cpu_env, pred_full_reg_offset(s, a->rn));
+    tcg_gen_addi_ptr(t_m, cpu_env, pred_full_reg_offset(s, a->rm));
+    t_desc = tcg_const_i32(desc);
+
+    fn(t_d, t_n, t_m, t_desc);
+
+    tcg_temp_free_ptr(t_d);
+    tcg_temp_free_ptr(t_n);
+    tcg_temp_free_ptr(t_m);
+    tcg_temp_free_i32(t_desc);
+    return true;
+}
+
+static bool do_perm_pred2(DisasContext *s, arg_rr_esz *a, bool high_odd,
+                          gen_helper_gvec_2 *fn)
+{
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    unsigned vsz = pred_full_reg_size(s);
+    TCGv_ptr t_d = tcg_temp_new_ptr();
+    TCGv_ptr t_n = tcg_temp_new_ptr();
+    TCGv_i32 t_desc;
+    int desc;
+
+    tcg_gen_addi_ptr(t_d, cpu_env, pred_full_reg_offset(s, a->rd));
+    tcg_gen_addi_ptr(t_n, cpu_env, pred_full_reg_offset(s, a->rn));
+
+    /* Predicate sizes may be smaller and cannot use simd_desc.
+       We cannot round up, as we do elsewhere, because we need
+       the exact size for ZIP2 and REV.  We retain the style for
+       the other helpers for consistency.  */
+
+    desc = vsz - 2;
+    desc = deposit32(desc, SIMD_DATA_SHIFT, 2, a->esz);
+    desc = deposit32(desc, SIMD_DATA_SHIFT + 2, 2, high_odd);
+    t_desc = tcg_const_i32(desc);
+
+    fn(t_d, t_n, t_desc);
+
+    tcg_temp_free_i32(t_desc);
+    tcg_temp_free_ptr(t_d);
+    tcg_temp_free_ptr(t_n);
+    return true;
+}
+
+static bool trans_ZIP1_p(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    return do_perm_pred3(s, a, 0, gen_helper_sve_zip_p);
+}
+
+static bool trans_ZIP2_p(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    return do_perm_pred3(s, a, 1, gen_helper_sve_zip_p);
+}
+
+static bool trans_UZP1_p(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    return do_perm_pred3(s, a, 0, gen_helper_sve_uzp_p);
+}
+
+static bool trans_UZP2_p(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    return do_perm_pred3(s, a, 1, gen_helper_sve_uzp_p);
+}
+
+static bool trans_TRN1_p(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    return do_perm_pred3(s, a, 0, gen_helper_sve_trn_p);
+}
+
+static bool trans_TRN2_p(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    return do_perm_pred3(s, a, 1, gen_helper_sve_trn_p);
+}
+
+static bool trans_REV_p(DisasContext *s, arg_rr_esz *a, uint32_t insn)
+{
+    return do_perm_pred2(s, a, 0, gen_helper_sve_rev_p);
+}
+
+static bool trans_PUNPKLO(DisasContext *s, arg_PUNPKLO *a, uint32_t insn)
+{
+    return do_perm_pred2(s, a, 0, gen_helper_sve_punpk_p);
+}
+
+static bool trans_PUNPKHI(DisasContext *s, arg_PUNPKHI *a, uint32_t insn)
+{
+    return do_perm_pred2(s, a, 1, gen_helper_sve_punpk_p);
+}
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 7ffd7962c8c..26fe1608c4a 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -86,6 +86,7 @@
 
 # Three operand, vector element size
 @rd_rn_rm       ........ esz:2 . rm:5 ... ... rn:5 rd:5         &rrr_esz
+@pd_pn_pm       ........ esz:2 .. rm:4 ....... rn:4 . rd:4      &rrr_esz
 @rdn_rm         ........ esz:2 ...... ...... rm:5 rd:5 \
                 &rrr_esz rn=%reg_movprfx
 
@@ -396,6 +397,23 @@ TBL             00000101 .. 1 ..... 001100 ..... .....          @rd_rn_rm
 # SVE unpack vector elements
 UNPK            00000101 esz:2 1100 u:1 h:1 001110 rn:5 rd:5
 
+### SVE Permute - Predicates Group
+
+# SVE permute predicate elements
+ZIP1_p          00000101 .. 10 .... 010 000 0 .... 0 ....       @pd_pn_pm
+ZIP2_p          00000101 .. 10 .... 010 001 0 .... 0 ....       @pd_pn_pm
+UZP1_p          00000101 .. 10 .... 010 010 0 .... 0 ....       @pd_pn_pm
+UZP2_p          00000101 .. 10 .... 010 011 0 .... 0 ....       @pd_pn_pm
+TRN1_p          00000101 .. 10 .... 010 100 0 .... 0 ....       @pd_pn_pm
+TRN2_p          00000101 .. 10 .... 010 101 0 .... 0 ....       @pd_pn_pm
+
+# SVE reverse predicate elements
+REV_p           00000101 .. 11 0100 010 000 0 .... 0 ....       @pd_pn
+
+# SVE unpack predicate elements
+PUNPKLO         00000101 00 11 0000 010 000 0 .... 0 ....       @pd_pn_e0
+PUNPKHI         00000101 00 11 0001 010 000 0 .... 0 ....       @pd_pn_e0
+
 ### SVE Predicate Logical Operations Group
 
 # SVE predicate logical operations
-- 
2.17.1
