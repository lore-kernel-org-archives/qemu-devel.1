Received: from eggs.gnu.org ([2001:4830:134:3::10]:59798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIwlD-00083R-53
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:46:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIwlA-0000Fm-2F
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:46:31 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:43471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fIwl9-0000FY-OJ
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:46:27 -0400
Received: by mail-wr0-x244.google.com with SMTP id v15-v6so1260941wrm.10
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 06:46:27 -0700 (PDT)
References: <20180515222540.9988-1-richard.henderson@linaro.org>
	<20180515222540.9988-27-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180515222540.9988-27-richard.henderson@linaro.org>
Date: Wed, 16 May 2018 14:46:25 +0100
Message-ID: <87tvr7emry.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 26/28] fpu/softfloat: Define
 floatN_default_nan in terms of parts_default_nan
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

> Isolate the target-specific choice to 2 functions instead of 6.
>
> The code in float16_default_nan was only correct for ARM, MIPS, and X86.
> Though float16 support is rare among our targets.
>
> The code in float128_default_nan was arguably wrong for Sparc.  While
> QEMU supports the Sparc 128-bit insns, no real cpu enables it.
>
> The code in floatx80_default_nan tried to be over-general.  There are
> only two targets that support this format: x86 and m68k.  Thus there
> is no point in inventing a value for snan_bit_is_one.
>
> Move routines that no longer have ifdefs out of softfloat-specialize.h.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
> ---
> v6
>   - shift the nan fraction into place before raw packing
> ---
>  fpu/softfloat-specialize.h | 105 +++----------------------------------
>  fpu/softfloat.c            |  41 +++++++++++++++
>  2 files changed, 47 insertions(+), 99 deletions(-)
>
> diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
> index 0399dfe011..9d562ed504 100644
> --- a/fpu/softfloat-specialize.h
> +++ b/fpu/softfloat-specialize.h
> @@ -179,94 +179,22 @@ static FloatParts parts_silence_nan(FloatParts a, f=
loat_status *status)
>      return a;
>  }
>
> -/*----------------------------------------------------------------------=
------
> -| The pattern for a default generated half-precision NaN.
> -*-----------------------------------------------------------------------=
-----*/
> -float16 float16_default_nan(float_status *status)
> -{
> -#if defined(TARGET_ARM)
> -    return const_float16(0x7E00);
> -#else
> -    if (snan_bit_is_one(status)) {
> -        return const_float16(0x7DFF);
> -    } else {
> -#if defined(TARGET_MIPS)
> -        return const_float16(0x7E00);
> -#else
> -        return const_float16(0xFE00);
> -#endif
> -    }
> -#endif
> -}
> -
> -/*----------------------------------------------------------------------=
------
> -| The pattern for a default generated single-precision NaN.
> -*-----------------------------------------------------------------------=
-----*/
> -float32 float32_default_nan(float_status *status)
> -{
> -#if defined(TARGET_SPARC) || defined(TARGET_M68K)
> -    return const_float32(0x7FFFFFFF);
> -#elif defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_ALPHA=
) || \
> -      defined(TARGET_XTENSA) || defined(TARGET_S390X) || \
> -      defined(TARGET_TRICORE) || defined(TARGET_RISCV)
> -    return const_float32(0x7FC00000);
> -#elif defined(TARGET_HPPA)
> -    return const_float32(0x7FA00000);
> -#else
> -    if (snan_bit_is_one(status)) {
> -        return const_float32(0x7FBFFFFF);
> -    } else {
> -#if defined(TARGET_MIPS)
> -        return const_float32(0x7FC00000);
> -#else
> -        return const_float32(0xFFC00000);
> -#endif
> -    }
> -#endif
> -}
> -
> -/*----------------------------------------------------------------------=
------
> -| The pattern for a default generated double-precision NaN.
> -*-----------------------------------------------------------------------=
-----*/
> -float64 float64_default_nan(float_status *status)
> -{
> -#if defined(TARGET_SPARC) || defined(TARGET_M68K)
> -    return const_float64(LIT64(0x7FFFFFFFFFFFFFFF));
> -#elif defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_ALPHA=
) || \
> -      defined(TARGET_S390X) || defined(TARGET_RISCV)
> -    return const_float64(LIT64(0x7FF8000000000000));
> -#elif defined(TARGET_HPPA)
> -    return const_float64(LIT64(0x7FF4000000000000));
> -#else
> -    if (snan_bit_is_one(status)) {
> -        return const_float64(LIT64(0x7FF7FFFFFFFFFFFF));
> -    } else {
> -#if defined(TARGET_MIPS)
> -        return const_float64(LIT64(0x7FF8000000000000));
> -#else
> -        return const_float64(LIT64(0xFFF8000000000000));
> -#endif
> -    }
> -#endif
> -}
> -
>  /*----------------------------------------------------------------------=
------
>  | The pattern for a default generated extended double-precision NaN.
>  *-----------------------------------------------------------------------=
-----*/
>  floatx80 floatx80_default_nan(float_status *status)
>  {
>      floatx80 r;
> +
> +    /* None of the targets that have snan_bit_is_one use floatx80.  */
> +    assert(!snan_bit_is_one(status));
>  #if defined(TARGET_M68K)
>      r.low =3D LIT64(0xFFFFFFFFFFFFFFFF);
>      r.high =3D 0x7FFF;
>  #else
> -    if (snan_bit_is_one(status)) {
> -        r.low =3D LIT64(0xBFFFFFFFFFFFFFFF);
> -        r.high =3D 0x7FFF;
> -    } else {
> -        r.low =3D LIT64(0xC000000000000000);
> -        r.high =3D 0xFFFF;
> -    }
> +    /* X86 */
> +    r.low =3D LIT64(0xC000000000000000);
> +    r.high =3D 0xFFFF;
>  #endif
>      return r;
>  }
> @@ -285,27 +213,6 @@ floatx80 floatx80_default_nan(float_status *status)
>  const floatx80 floatx80_infinity
>      =3D make_floatx80_init(floatx80_infinity_high, floatx80_infinity_low=
);
>
> -/*----------------------------------------------------------------------=
------
> -| The pattern for a default generated quadruple-precision NaN.
> -*-----------------------------------------------------------------------=
-----*/
> -float128 float128_default_nan(float_status *status)
> -{
> -    float128 r;
> -
> -    if (snan_bit_is_one(status)) {
> -        r.low =3D LIT64(0xFFFFFFFFFFFFFFFF);
> -        r.high =3D LIT64(0x7FFF7FFFFFFFFFFF);
> -    } else {
> -        r.low =3D LIT64(0x0000000000000000);
> -#if defined(TARGET_S390X) || defined(TARGET_PPC) || defined(TARGET_RISCV)
> -        r.high =3D LIT64(0x7FFF800000000000);
> -#else
> -        r.high =3D LIT64(0xFFFF800000000000);
> -#endif
> -    }
> -    return r;
> -}
> -
>  /*----------------------------------------------------------------------=
------
>  | Raises the exceptions specified by `flags'.  Floating-point traps can =
be
>  | defined here if desired.  It is currently not possible for such a trap
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 8e97602ace..c8b33e35f4 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -2092,6 +2092,47 @@ float64 __attribute__((flatten)) float64_sqrt(floa=
t64 a, float_status *status)
>      return float64_round_pack_canonical(pr, status);
>  }
>
> +/*----------------------------------------------------------------------=
------
> +| The pattern for a default generated NaN.
> +*-----------------------------------------------------------------------=
-----*/
> +
> +float16 float16_default_nan(float_status *status)
> +{
> +    FloatParts p =3D parts_default_nan(status);
> +    p.frac >>=3D float16_params.frac_shift;
> +    return float16_pack_raw(p);
> +}
> +
> +float32 float32_default_nan(float_status *status)
> +{
> +    FloatParts p =3D parts_default_nan(status);
> +    p.frac >>=3D float32_params.frac_shift;
> +    return float32_pack_raw(p);
> +}
> +
> +float64 float64_default_nan(float_status *status)
> +{
> +    FloatParts p =3D parts_default_nan(status);
> +    p.frac >>=3D float64_params.frac_shift;
> +    return float64_pack_raw(p);
> +}
> +
> +float128 float128_default_nan(float_status *status)
> +{
> +    FloatParts p =3D parts_default_nan(status);
> +    float128 r;
> +
> +    /* Extrapolate from the choices made by parts_default_nan to fill
> +     * in the quad-floating format.  If the low bit is set, assume we
> +     * want to set all non-snan bits.
> +     */
> +    r.low =3D -(p.frac & 1);
> +    r.high =3D p.frac >> (DECOMPOSED_BINARY_POINT - 48);
> +    r.high |=3D LIT64(0x7FFF000000000000);
> +    r.high |=3D (uint64_t)p.sign << 63;
> +
> +    return r;
> +}
>
>  /*----------------------------------------------------------------------=
------
>  | Takes a 64-bit fixed-point value `absZ' with binary point between bits=
 6


--
Alex Benn=C3=A9e
