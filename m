Received: from eggs.gnu.org ([209.51.188.92]:41855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyi9B-0005pA-0L
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:12:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyi9A-0005uE-AY
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:12:08 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:38977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gyi99-0005tU-Tr
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:12:08 -0500
Received: by mail-pg1-x52a.google.com with SMTP id h8so6145516pgp.6
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 11:12:07 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-7-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f3a978e7-2e40-9f57-f085-ff5dbf259964@linaro.org>
Date: Tue, 26 Feb 2019 11:12:04 -0800
MIME-Version: 1.0
In-Reply-To: <20190226113915.20150-7-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 06/33] s390x/tcg: Implement VECTOR
 GENERATE BYTE MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 2/26/19 3:38 AM, David Hildenbrand wrote:
> +static DisasJumpType op_vgbm(DisasContext *s, DisasOps *o)
> +{
> +    const uint16_t i2 = get_field(s->fields, i2);
> +    TCGv_i32 ones = tcg_const_i32(-1u);
> +    TCGv_i32 zeroes = tcg_const_i32(0);
> +    int i;
> +
> +    for (i = 0; i < 16; i++) {
> +        if (extract32(i2, 15 - i, 1)) {
> +            write_vec_element_i32(ones, get_field(s->fields, v1), i, MO_8);
> +        } else {
> +            write_vec_element_i32(zeroes, get_field(s->fields, v1), i, MO_8);
> +        }
> +    }
> +    tcg_temp_free_i32(ones);
> +    tcg_temp_free_i32(zeroes);
> +    return DISAS_NEXT;
> +}

While this works, it's not in the spirit of

> Programming Note: VECTOR GENERATE BYTE
> MASK is the preferred method for setting a vector
> register to all zeroes or ones.

Better, I think, with

uint64_t generate_byte_mask(uint8_t mask)
{
    uint64_t r = 0;
    int i;
    for (i = 0; i < 8; i++) {
        if ((mask >> i) & 1) {
            r |= 0xffull << (i * 8);
        }
    }
    return r;
}

    if (i2 == (i2 & 0xff) * 0x0101) {
        /* masks for both halves of the vector are the same.
           trust tcg to produce a good constant loading.  */
        tcg_gen_gvec_dup64i(vec_full_reg_offset(s, v1), 16, 16,
                            generate_byte_mask(i2 & 0xff));
    } else {
        TCGv_i64 t = tcg_temp_new_i64();
        tcg_gen_movi_i64(t, generate_byte_mask(i2 >> 8));
        write_vec_element_i64(t, v1, 0, MO_64);
        tcg_gen_movi_i64(t, generate_byte_mask(i2 & 0xff));
        write_vec_element_i64(t, v1, 1, MO_64);
        tcg_temp_free_i64();
    }

Somewhere behind tcg_gen_gvec_dup64i, I check to see if the constant can be
decomposed further, which will eventually bottom out at

	vpxor	%xmm0,%xmm0,%xmm0		// all zeros
	vpcmpeq	%xmm0,%xmm0,%xmm0		// all ones

and even more interesting combinations for tcg/aarch64.



r~
