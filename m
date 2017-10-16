Received: from eggs.gnu.org ([2001:4830:134:3::10]:42868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4BiV-0001kU-2V
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:10:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4BiQ-00058x-NZ
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:10:27 -0400
Received: from mail-pg0-x22e.google.com ([2607:f8b0:400e:c05::22e]:48122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e4BiQ-00058Z-FT
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:10:22 -0400
Received: by mail-pg0-x22e.google.com with SMTP id r25so7692762pgn.4
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 13:10:22 -0700 (PDT)
References: <20171013162438.32458-1-alex.bennee@linaro.org>
	<20171013162438.32458-12-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d1091101-7397-54a6-70b9-8c46df86a3a2@linaro.org>
Date: Mon, 16 Oct 2017 13:10:18 -0700
MIME-Version: 1.0
In-Reply-To: <20171013162438.32458-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 11/30] target/arm: implement
 half-precision F(MIN|MAX)(V|NMV)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 10/13/2017 09:24 AM, Alex Bennée wrote:
> +/*
> + * do_reduction_op helper
> + *
> + * This mirrors the Reduce() pseudocode in the ARM ARM. It is
> + * important for correct NaN propagation that we do these
> + * operations in exactly the order specified by the pseudocode.
> + *
> + * This is a recursive function, TCG temps should be freed by the
> + * calling function once it is done with the values.
> + */
> +static TCGv_i32 do_reduction_op(DisasContext *s, int fpopcode, int rn,
> +                                int esize, int size, int vmap, TCGv_ptr fpst)
> +{
> +    if (esize == size) {
> +        int element;
> +        TCGMemOp msize = esize == 16 ? MO_16 : MO_32;
> +        TCGv_i32 tcg_elem;
> +
> +        /* We should have one register left here */
> +        assert(ctpop8(vmap) == 1);

I think you should match the ctpop to the size of vmap.  It's true you only
need uint8_t at present, so maybe use that?  At least it's self-consistent.

> +        tcg_hi = do_reduction_op(s, fpopcode, rn, esize, bits, vmap_hi, fpst);
> +        tcg_lo = do_reduction_op(s, fpopcode, rn, esize, bits, vmap_lo, fpst);
> +        tcg_res = tcg_temp_new_i32();

You can re-use one of the two inputs for the output, fwiw.

> +        /* Bit 1 of size field encodes min vs max and the actual size
> +         * depends on the encoding of the U bit. If not set (and FP16
> +         * enabled) then we do half-precision float instead of single
> +         * precision.
>           */
>          is_min = extract32(size, 1, 1);
>          is_fp = true;
> -        size = 2;
> +        if (!is_u && arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
> +            size = 1;

You do still need to check size[0] == 0.


r~
