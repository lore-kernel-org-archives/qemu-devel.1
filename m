Received: from eggs.gnu.org ([2001:4830:134:3::10]:38246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epF4S-00076e-02
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:15:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epF4Q-0004T7-Jl
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:15:35 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:37595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epF4Q-0004RQ-AZ
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:15:34 -0500
Received: by mail-pf0-x243.google.com with SMTP id s24so3631284pfm.4
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 07:15:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-29-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-29-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 15:15:12 +0000
Message-ID: <CAFEAcA8BnNkgHNQd2xK8BrYzhtG4_fee3rWTKXqVxRNEf5FJNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 28/67] target/arm: Implement SVE Permute
 - Predicates Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 17 February 2018 at 18:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    |   6 +
>  target/arm/sve_helper.c    | 280 +++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 110 ++++++++++++++++++
>  target/arm/sve.decode      |  18 +++
>  4 files changed, 414 insertions(+)
>
> diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
> index 0c9aad575e..ff958fcebd 100644
> --- a/target/arm/helper-sve.h
> +++ b/target/arm/helper-sve.h
> @@ -439,6 +439,12 @@ DEF_HELPER_FLAGS_3(sve_uunpk_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_3(sve_uunpk_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_3(sve_uunpk_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
>
> +DEF_HELPER_FLAGS_4(sve_zip_p, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(sve_uzp_p, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(sve_trn_p, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_3(sve_rev_p, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_3(sve_punpk_p, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
> +
>  DEF_HELPER_FLAGS_5(sve_and_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_5(sve_bic_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_5(sve_eor_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index 466a209c1e..c3a2706a16 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -1664,3 +1664,283 @@ DO_UNPK(sve_uunpk_s, uint32_t, uint16_t, H4, H2)
>  DO_UNPK(sve_uunpk_d, uint64_t, uint32_t, , H4)
>
>  #undef DO_UNPK
> +
> +static const uint64_t expand_bit_data[5][2] = {
> +    { 0x1111111111111111ull, 0x2222222222222222ull },
> +    { 0x0303030303030303ull, 0x0c0c0c0c0c0c0c0cull },
> +    { 0x000f000f000f000full, 0x00f000f000f000f0ull },
> +    { 0x000000ff000000ffull, 0x0000ff000000ff00ull },
> +    { 0x000000000000ffffull, 0x00000000ffff0000ull }
> +};
> +
> +/* Expand units of 2**N bits to units of 2**(N+1) bits,
> +   with the higher bits zero.  */

In bitops.h we call this operation "half shuffle" (where
it is specifically working on units of 1 bit size), and
the inverse "half unshuffle". Worth mentioning that (or
using similar terminology) ?

> +static uint64_t expand_bits(uint64_t x, int n)
> +{
> +    int i, sh;

Worth asserting that n is within the range we expect it to be ?
(what range is that? 0 to 4?)

> +    for (i = 4, sh = 16; i >= n; i--, sh >>= 1) {
> +        x = ((x & expand_bit_data[i][1]) << sh) | (x & expand_bit_data[i][0]);
> +    }
> +    return x;
> +}
> +
> +/* Compress units of 2**(N+1) bits to units of 2**N bits.  */
> +static uint64_t compress_bits(uint64_t x, int n)
> +{
> +    int i, sh;

Ditto assert.

> +    for (i = n, sh = 1 << n; i <= 4; i++, sh <<= 1) {
> +        x = ((x >> sh) & expand_bit_data[i][1]) | (x & expand_bit_data[i][0]);
> +    }
> +    return x;
> +}
> +
> +void HELPER(sve_zip_p)(void *vd, void *vn, void *vm, uint32_t pred_desc)
> +{
> +    intptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
> +    int esz = extract32(pred_desc, SIMD_DATA_SHIFT, 2);
> +    intptr_t high = extract32(pred_desc, SIMD_DATA_SHIFT + 2, 1);
> +    uint64_t *d = vd;
> +    intptr_t i;
> +
> +    if (oprsz <= 8) {
> +        uint64_t nn = *(uint64_t *)vn;
> +        uint64_t mm = *(uint64_t *)vm;
> +        int half = 4 * oprsz;
> +
> +        nn = extract64(nn, high * half, half);
> +        mm = extract64(mm, high * half, half);
> +        nn = expand_bits(nn, esz);
> +        mm = expand_bits(mm, esz);
> +        d[0] = nn + (mm << (1 << esz));

Is this actually doing an addition, or is it just an odd
way of writing a bitwise OR when neither of the two
inputs have 1 in the same bit position?

> +    } else {
> +        ARMPredicateReg tmp_n, tmp_m;
> +
> +        /* We produce output faster than we consume input.
> +           Therefore we must be mindful of possible overlap.  */
> +        if ((vn - vd) < (uintptr_t)oprsz) {
> +            vn = memcpy(&tmp_n, vn, oprsz);
> +        }
> +        if ((vm - vd) < (uintptr_t)oprsz) {
> +            vm = memcpy(&tmp_m, vm, oprsz);
> +        }
> +        if (high) {
> +            high = oprsz >> 1;
> +        }
> +
> +        if ((high & 3) == 0) {
> +            uint32_t *n = vn, *m = vm;
> +            high >>= 2;
> +
> +            for (i = 0; i < DIV_ROUND_UP(oprsz, 8); i++) {
> +                uint64_t nn = n[H4(high + i)];
> +                uint64_t mm = m[H4(high + i)];
> +
> +                nn = expand_bits(nn, esz);
> +                mm = expand_bits(mm, esz);
> +                d[i] = nn + (mm << (1 << esz));
> +            }
> +        } else {
> +            uint8_t *n = vn, *m = vm;
> +            uint16_t *d16 = vd;
> +
> +            for (i = 0; i < oprsz / 2; i++) {
> +                uint16_t nn = n[H1(high + i)];
> +                uint16_t mm = m[H1(high + i)];
> +
> +                nn = expand_bits(nn, esz);
> +                mm = expand_bits(mm, esz);
> +                d16[H2(i)] = nn + (mm << (1 << esz));
> +            }
> +        }
> +    }
> +}
> +
> +void HELPER(sve_uzp_p)(void *vd, void *vn, void *vm, uint32_t pred_desc)
> +{
> +    intptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
> +    int esz = extract32(pred_desc, SIMD_DATA_SHIFT, 2);
> +    int odd = extract32(pred_desc, SIMD_DATA_SHIFT + 2, 1) << esz;
> +    uint64_t *d = vd, *n = vn, *m = vm;
> +    uint64_t l, h;
> +    intptr_t i;
> +
> +    if (oprsz <= 8) {
> +        l = compress_bits(n[0] >> odd, esz);
> +        h = compress_bits(m[0] >> odd, esz);
> +        d[0] = extract64(l + (h << (4 * oprsz)), 0, 8 * oprsz);

This looks like it's using addition for logical OR again ?

> +    } else {
> +        ARMPredicateReg tmp_m;
> +        intptr_t oprsz_16 = oprsz / 16;
> +
> +        if ((vm - vd) < (uintptr_t)oprsz) {
> +            m = memcpy(&tmp_m, vm, oprsz);
> +        }
> +
> +        for (i = 0; i < oprsz_16; i++) {
> +            l = n[2 * i + 0];
> +            h = n[2 * i + 1];
> +            l = compress_bits(l >> odd, esz);
> +            h = compress_bits(h >> odd, esz);
> +            d[i] = l + (h << 32);
> +        }
> +
> +        /* For VL which is not a power of 2, the results from M do not
> +           align nicely with the uint64_t for D.  Put the aligned results
> +           from M into TMP_M and then copy it into place afterward.  */

How much risu testing did you do of funny vector lengths ?

> +        if (oprsz & 15) {
> +            d[i] = compress_bits(n[2 * i] >> odd, esz);
> +
> +            for (i = 0; i < oprsz_16; i++) {
> +                l = m[2 * i + 0];
> +                h = m[2 * i + 1];
> +                l = compress_bits(l >> odd, esz);
> +                h = compress_bits(h >> odd, esz);
> +                tmp_m.p[i] = l + (h << 32);
> +            }
> +            tmp_m.p[i] = compress_bits(m[2 * i] >> odd, esz);
> +
> +            swap_memmove(vd + oprsz / 2, &tmp_m, oprsz / 2);
> +        } else {
> +            for (i = 0; i < oprsz_16; i++) {
> +                l = m[2 * i + 0];
> +                h = m[2 * i + 1];
> +                l = compress_bits(l >> odd, esz);
> +                h = compress_bits(h >> odd, esz);
> +                d[oprsz_16 + i] = l + (h << 32);
> +            }
> +        }
> +    }
> +}
> +
> +static const uint64_t even_bit_esz_masks[4] = {
> +    0x5555555555555555ull,
> +    0x3333333333333333ull,
> +    0x0f0f0f0f0f0f0f0full,
> +    0x00ff00ff00ff00ffull
> +};

Comment describing the purpose of these numbers would be useful.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
