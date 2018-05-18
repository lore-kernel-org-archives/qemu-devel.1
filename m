Received: from eggs.gnu.org ([2001:4830:134:3::10]:36198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3Q-0000q4-OM
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3P-0007f0-F6
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:32 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fJj3O-0007Z3-SY
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:31 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3N-0004vW-Su
	for qemu-devel@nongnu.org; Fri, 18 May 2018 18:20:29 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 18:20:04 +0100
Message-Id: <20180518172009.14416-28-peter.maydell@linaro.org>
In-Reply-To: <20180518172009.14416-1-peter.maydell@linaro.org>
References: <20180518172009.14416-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 27/32] target/arm: Implement SVE floating-point
 exponential accelerator
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
Message-id: 20180516223007.10256-21-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-sve.h    |  4 ++
 target/arm/sve_helper.c    | 90 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 24 ++++++++++
 target/arm/sve.decode      |  7 +++
 4 files changed, 125 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 5280d375f9..e2925ff8ec 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -385,6 +385,10 @@ DEF_HELPER_FLAGS_4(sve_adr_p64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_adr_s32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_adr_u32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_3(sve_fexpa_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_fexpa_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_fexpa_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_and_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_bic_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_eor_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 7fa8394aec..6ffb126821 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1102,3 +1102,93 @@ void HELPER(sve_adr_u32)(void *vd, void *vn, void *vm, uint32_t desc)
         d[i] = n[i] + ((uint64_t)(uint32_t)m[i] << sh);
     }
 }
+
+void HELPER(sve_fexpa_h)(void *vd, void *vn, uint32_t desc)
+{
+    /* These constants are cut-and-paste directly from the ARM pseudocode.  */
+    static const uint16_t coeff[] = {
+        0x0000, 0x0016, 0x002d, 0x0045, 0x005d, 0x0075, 0x008e, 0x00a8,
+        0x00c2, 0x00dc, 0x00f8, 0x0114, 0x0130, 0x014d, 0x016b, 0x0189,
+        0x01a8, 0x01c8, 0x01e8, 0x0209, 0x022b, 0x024e, 0x0271, 0x0295,
+        0x02ba, 0x02e0, 0x0306, 0x032e, 0x0356, 0x037f, 0x03a9, 0x03d4,
+    };
+    intptr_t i, opr_sz = simd_oprsz(desc) / 2;
+    uint16_t *d = vd, *n = vn;
+
+    for (i = 0; i < opr_sz; i++) {
+        uint16_t nn = n[i];
+        intptr_t idx = extract32(nn, 0, 5);
+        uint16_t exp = extract32(nn, 5, 5);
+        d[i] = coeff[idx] | (exp << 10);
+    }
+}
+
+void HELPER(sve_fexpa_s)(void *vd, void *vn, uint32_t desc)
+{
+    /* These constants are cut-and-paste directly from the ARM pseudocode.  */
+    static const uint32_t coeff[] = {
+        0x000000, 0x0164d2, 0x02cd87, 0x043a29,
+        0x05aac3, 0x071f62, 0x08980f, 0x0a14d5,
+        0x0b95c2, 0x0d1adf, 0x0ea43a, 0x1031dc,
+        0x11c3d3, 0x135a2b, 0x14f4f0, 0x16942d,
+        0x1837f0, 0x19e046, 0x1b8d3a, 0x1d3eda,
+        0x1ef532, 0x20b051, 0x227043, 0x243516,
+        0x25fed7, 0x27cd94, 0x29a15b, 0x2b7a3a,
+        0x2d583f, 0x2f3b79, 0x3123f6, 0x3311c4,
+        0x3504f3, 0x36fd92, 0x38fbaf, 0x3aff5b,
+        0x3d08a4, 0x3f179a, 0x412c4d, 0x4346cd,
+        0x45672a, 0x478d75, 0x49b9be, 0x4bec15,
+        0x4e248c, 0x506334, 0x52a81e, 0x54f35b,
+        0x5744fd, 0x599d16, 0x5bfbb8, 0x5e60f5,
+        0x60ccdf, 0x633f89, 0x65b907, 0x68396a,
+        0x6ac0c7, 0x6d4f30, 0x6fe4ba, 0x728177,
+        0x75257d, 0x77d0df, 0x7a83b3, 0x7d3e0c,
+    };
+    intptr_t i, opr_sz = simd_oprsz(desc) / 4;
+    uint32_t *d = vd, *n = vn;
+
+    for (i = 0; i < opr_sz; i++) {
+        uint32_t nn = n[i];
+        intptr_t idx = extract32(nn, 0, 6);
+        uint32_t exp = extract32(nn, 6, 8);
+        d[i] = coeff[idx] | (exp << 23);
+    }
+}
+
+void HELPER(sve_fexpa_d)(void *vd, void *vn, uint32_t desc)
+{
+    /* These constants are cut-and-paste directly from the ARM pseudocode.  */
+    static const uint64_t coeff[] = {
+        0x0000000000000ull, 0x02C9A3E778061ull, 0x059B0D3158574ull,
+        0x0874518759BC8ull, 0x0B5586CF9890Full, 0x0E3EC32D3D1A2ull,
+        0x11301D0125B51ull, 0x1429AAEA92DE0ull, 0x172B83C7D517Bull,
+        0x1A35BEB6FCB75ull, 0x1D4873168B9AAull, 0x2063B88628CD6ull,
+        0x2387A6E756238ull, 0x26B4565E27CDDull, 0x29E9DF51FDEE1ull,
+        0x2D285A6E4030Bull, 0x306FE0A31B715ull, 0x33C08B26416FFull,
+        0x371A7373AA9CBull, 0x3A7DB34E59FF7ull, 0x3DEA64C123422ull,
+        0x4160A21F72E2Aull, 0x44E086061892Dull, 0x486A2B5C13CD0ull,
+        0x4BFDAD5362A27ull, 0x4F9B2769D2CA7ull, 0x5342B569D4F82ull,
+        0x56F4736B527DAull, 0x5AB07DD485429ull, 0x5E76F15AD2148ull,
+        0x6247EB03A5585ull, 0x6623882552225ull, 0x6A09E667F3BCDull,
+        0x6DFB23C651A2Full, 0x71F75E8EC5F74ull, 0x75FEB564267C9ull,
+        0x7A11473EB0187ull, 0x7E2F336CF4E62ull, 0x82589994CCE13ull,
+        0x868D99B4492EDull, 0x8ACE5422AA0DBull, 0x8F1AE99157736ull,
+        0x93737B0CDC5E5ull, 0x97D829FDE4E50ull, 0x9C49182A3F090ull,
+        0xA0C667B5DE565ull, 0xA5503B23E255Dull, 0xA9E6B5579FDBFull,
+        0xAE89F995AD3ADull, 0xB33A2B84F15FBull, 0xB7F76F2FB5E47ull,
+        0xBCC1E904BC1D2ull, 0xC199BDD85529Cull, 0xC67F12E57D14Bull,
+        0xCB720DCEF9069ull, 0xD072D4A07897Cull, 0xD5818DCFBA487ull,
+        0xDA9E603DB3285ull, 0xDFC97337B9B5Full, 0xE502EE78B3FF6ull,
+        0xEA4AFA2A490DAull, 0xEFA1BEE615A27ull, 0xF50765B6E4540ull,
+        0xFA7C1819E90D8ull,
+    };
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd, *n = vn;
+
+    for (i = 0; i < opr_sz; i++) {
+        uint64_t nn = n[i];
+        intptr_t idx = extract32(nn, 0, 6);
+        uint64_t exp = extract32(nn, 6, 11);
+        d[i] = coeff[idx] | (exp << 52);
+    }
+}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 8924848463..54d774b5e0 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -929,6 +929,30 @@ static bool trans_ADR_u32(DisasContext *s, arg_rrri *a, uint32_t insn)
     return do_adr(s, a, gen_helper_sve_adr_u32);
 }
 
+/*
+ *** SVE Integer Misc - Unpredicated Group
+ */
+
+static bool trans_FEXPA(DisasContext *s, arg_rr_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_2 * const fns[4] = {
+        NULL,
+        gen_helper_sve_fexpa_h,
+        gen_helper_sve_fexpa_s,
+        gen_helper_sve_fexpa_d,
+    };
+    if (a->esz == 0) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_2_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vsz, vsz, 0, fns[a->esz]);
+    }
+    return true;
+}
+
 /*
  *** SVE Predicate Logical Operations Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 691876de4e..cd53b95831 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -66,6 +66,7 @@
 
 # Two operand
 @pd_pn          ........ esz:2 .. .... ....... rn:4 . rd:4      &rr_esz
+@rd_rn          ........ esz:2 ...... ...... rn:5 rd:5          &rr_esz
 
 # Three operand with unused vector element size
 @rd_rn_rm_e0    ........ ... rm:5 ... ... rn:5 rd:5             &rrr_esz esz=0
@@ -288,6 +289,12 @@ ADR_u32         00000100 01 1 ..... 1010 .. ..... .....         @rd_rn_msz_rm
 ADR_p32         00000100 10 1 ..... 1010 .. ..... .....         @rd_rn_msz_rm
 ADR_p64         00000100 11 1 ..... 1010 .. ..... .....         @rd_rn_msz_rm
 
+### SVE Integer Misc - Unpredicated Group
+
+# SVE floating-point exponential accelerator
+# Note esz != 0
+FEXPA           00000100 .. 1 00000 101110 ..... .....          @rd_rn
+
 ### SVE Predicate Logical Operations Group
 
 # SVE predicate logical operations
-- 
2.17.0
