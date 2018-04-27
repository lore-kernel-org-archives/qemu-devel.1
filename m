Received: from eggs.gnu.org ([2001:4830:134:3::10]:37108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fC5rp-0005ci-Rq
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 12:05:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fC5rk-0006Hp-U3
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 12:05:01 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:42748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fC5rk-0006HP-NC
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 12:04:56 -0400
Received: by mail-wr0-x243.google.com with SMTP id v5-v6so2270022wrf.9
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 09:04:56 -0700 (PDT)
References: <20180425012300.14698-1-richard.henderson@linaro.org>
	<20180425012300.14698-2-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180425012300.14698-2-richard.henderson@linaro.org>
Date: Fri, 27 Apr 2018 17:04:53 +0100
Message-ID: <87y3h8k53u.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/9] target/arm: Implement vector shifted
 SCVF/UCVF for fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> While we have some of the scalar paths for *CVF for fp16,
> we failed to decode the fp16 version of these instructions.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index b47319d437..c92e052686 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -7077,13 +7077,26 @@ static void handle_simd_shift_intfp_conv(DisasCon=
text *s, bool is_scalar,
>                                           int immh, int immb, int opcode,
>                                           int rn, int rd)
>  {
> -    bool is_double =3D extract32(immh, 3, 1);
> -    int size =3D is_double ? MO_64 : MO_32;
> -    int elements;
> +    int size, elements, fracbits;
>      int immhb =3D immh << 3 | immb;
> -    int fracbits =3D (is_double ? 128 : 64) - immhb;
>
> -    if (!extract32(immh, 2, 2)) {
> +    if (immh & 8) {
> +        size =3D MO_64;
> +        if (!is_scalar && !is_q) {
> +            unallocated_encoding(s);
> +            return;
> +        }
> +    } else if (immh & 4) {
> +        size =3D MO_32;
> +    } else if (immh & 2) {
> +        size =3D MO_16;
> +        if (!arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
> +            unallocated_encoding(s);
> +            return;
> +        }
> +    } else {
> +        /* immh =3D=3D 0 would be a failure of the decode logic */
> +        g_assert(immh =3D=3D 1);
>          unallocated_encoding(s);
>          return;
>      }
> @@ -7091,20 +7104,14 @@ static void handle_simd_shift_intfp_conv(DisasCon=
text *s, bool is_scalar,
>      if (is_scalar) {
>          elements =3D 1;
>      } else {
> -        elements =3D is_double ? 2 : is_q ? 4 : 2;
> -        if (is_double && !is_q) {
> -            unallocated_encoding(s);
> -            return;
> -        }
> +        elements =3D 8 << is_q >> size;

That is a brain exercise for operator precedence. Would:

     elements =3D (is_q ? 16 : 8) >> size;

be clearer? Personally I'd have probably done it long hand in each size
leg above, e.g:

    size =3D MO_16;
    elements =3D is_scalar ? 1 : (is_q ? 8 : 4);

>      }
> +    fracbits =3D (16 << size) - immhb;

The ship has already sailed on this but I'm wishing we had a
mosize_to_bits() helper function to be explicit about this
transformation.

>
>      if (!fp_access_check(s)) {
>          return;
>      }
>
> -    /* immh =3D=3D 0 would be a failure of the decode logic */
> -    g_assert(immh);
> -
>      handle_simd_intfp_conv(s, rd, rn, elements, !is_u, fracbits, size);
>  }


--
Alex Benn=C3=A9e
