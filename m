Received: from eggs.gnu.org ([2001:4830:134:3::10]:60153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIwmh-0000WF-66
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIwmf-0000fB-RZ
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:48:03 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:39654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fIwmf-0000ee-HL
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:48:01 -0400
Received: by mail-wm0-x241.google.com with SMTP id f8-v6so1863499wmc.4
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 06:48:01 -0700 (PDT)
References: <20180515222540.9988-1-richard.henderson@linaro.org>
	<20180515222540.9988-29-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180515222540.9988-29-richard.henderson@linaro.org>
Date: Wed, 16 May 2018 14:47:59 +0100
Message-ID: <87sh6rempc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 28/28] fpu/softfloat: Define
 floatN_silence_nan in terms of parts_silence_nan
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

> Isolate the target-specific choice to 3 functions instead of 6.
>
> The code in floatx80_default_nan tried to be over-general.  There are
> only two targets that support this format: x86 and m68k.  Thus there
> is no point in inventing a mechanism for snan_bit_is_one.
>
> Move routines that no longer have ifdefs out of softfloat-specialize.h.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  fpu/softfloat-specialize.h | 81 ++------------------------------------
>  fpu/softfloat.c            | 31 +++++++++++++++
>  2 files changed, 35 insertions(+), 77 deletions(-)
>
> diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
> index ec4fb6ba8b..16c0bcb6fa 100644
> --- a/fpu/softfloat-specialize.h
> +++ b/fpu/softfloat-specialize.h
> @@ -278,24 +278,6 @@ int float16_is_signaling_nan(float16 a_, float_statu=
s *status)
>  #endif
>  }
>
> -/*----------------------------------------------------------------------=
------
> -| Returns a quiet NaN from a signalling NaN for the half-precision
> -| floating point value `a'.
> -*-----------------------------------------------------------------------=
-----*/
> -
> -float16 float16_silence_nan(float16 a, float_status *status)
> -{
> -#ifdef NO_SIGNALING_NANS
> -    g_assert_not_reached();
> -#else
> -    if (snan_bit_is_one(status)) {
> -        return float16_default_nan(status);
> -    } else {
> -        return a | (1 << 9);
> -    }
> -#endif
> -}
> -
>  /*----------------------------------------------------------------------=
------
>  | Returns 1 if the single-precision floating-point value `a' is a quiet
>  | NaN; otherwise returns 0.
> @@ -334,30 +316,6 @@ int float32_is_signaling_nan(float32 a_, float_statu=
s *status)
>  #endif
>  }
>
> -/*----------------------------------------------------------------------=
------
> -| Returns a quiet NaN from a signalling NaN for the single-precision
> -| floating point value `a'.
> -*-----------------------------------------------------------------------=
-----*/
> -
> -float32 float32_silence_nan(float32 a, float_status *status)
> -{
> -#ifdef NO_SIGNALING_NANS
> -    g_assert_not_reached();
> -#else
> -    if (snan_bit_is_one(status)) {
> -# ifdef TARGET_HPPA
> -        a &=3D ~0x00400000;
> -        a |=3D  0x00200000;
> -        return a;
> -# else
> -        return float32_default_nan(status);
> -# endif
> -    } else {
> -        return a | (1 << 22);
> -    }
> -#endif
> -}
> -
>  /*----------------------------------------------------------------------=
------
>  | Returns the result of converting the single-precision floating-point N=
aN
>  | `a' to the canonical NaN format.  If `a' is a signaling NaN, the inval=
id
> @@ -706,31 +664,6 @@ int float64_is_signaling_nan(float64 a_, float_statu=
s *status)
>  #endif
>  }
>
> -/*----------------------------------------------------------------------=
------
> -| Returns a quiet NaN from a signalling NaN for the double-precision
> -| floating point value `a'.
> -*-----------------------------------------------------------------------=
-----*/
> -
> -float64 float64_silence_nan(float64 a, float_status *status)
> -{
> -#ifdef NO_SIGNALING_NANS
> -    g_assert_not_reached();
> -#else
> -    if (snan_bit_is_one(status)) {
> -# ifdef TARGET_HPPA
> -        a &=3D ~0x0008000000000000ULL;
> -        a |=3D  0x0004000000000000ULL;
> -        return a;
> -# else
> -        return float64_default_nan(status);
> -# endif
> -    } else {
> -        return a | LIT64(0x0008000000000000);
> -    }
> -#endif
> -}
> -
> -
>  /*----------------------------------------------------------------------=
------
>  | Returns the result of converting the double-precision floating-point N=
aN
>  | `a' to the canonical NaN format.  If `a' is a signaling NaN, the inval=
id
> @@ -886,16 +819,10 @@ int floatx80_is_signaling_nan(floatx80 a, float_sta=
tus *status)
>
>  floatx80 floatx80_silence_nan(floatx80 a, float_status *status)
>  {
> -#ifdef NO_SIGNALING_NANS
> -    g_assert_not_reached();
> -#else
> -    if (snan_bit_is_one(status)) {
> -        return floatx80_default_nan(status);
> -    } else {
> -        a.low |=3D LIT64(0xC000000000000000);
> -        return a;
> -    }
> -#endif
> +    /* None of the targets that have snan_bit_is_one use floatx80.  */
> +    assert(!snan_bit_is_one(status));
> +    a.low |=3D LIT64(0xC000000000000000);
> +    return a;
>  }
>
>  /*----------------------------------------------------------------------=
------
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index c8b33e35f4..8cd2400081 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -2134,6 +2134,37 @@ float128 float128_default_nan(float_status *status)
>      return r;
>  }
>
> +/*----------------------------------------------------------------------=
------
> +| Returns a quiet NaN from a signalling NaN for the floating point value=
 `a'.
> +*-----------------------------------------------------------------------=
-----*/
> +
> +float16 float16_silence_nan(float16 a, float_status *status)
> +{
> +    FloatParts p =3D float16_unpack_raw(a);
> +    p.frac <<=3D float16_params.frac_shift;
> +    p =3D parts_silence_nan(p, status);
> +    p.frac >>=3D float16_params.frac_shift;
> +    return float16_pack_raw(p);
> +}
> +
> +float32 float32_silence_nan(float32 a, float_status *status)
> +{
> +    FloatParts p =3D float32_unpack_raw(a);
> +    p.frac <<=3D float32_params.frac_shift;
> +    p =3D parts_silence_nan(p, status);
> +    p.frac >>=3D float32_params.frac_shift;
> +    return float32_pack_raw(p);
> +}
> +
> +float64 float64_silence_nan(float64 a, float_status *status)
> +{
> +    FloatParts p =3D float64_unpack_raw(a);
> +    p.frac <<=3D float64_params.frac_shift;
> +    p =3D parts_silence_nan(p, status);
> +    p.frac >>=3D float64_params.frac_shift;
> +    return float64_pack_raw(p);
> +}
> +
>  /*----------------------------------------------------------------------=
------
>  | Takes a 64-bit fixed-point value `absZ' with binary point between bits=
 6
>  | and 7, and returns the properly rounded 32-bit integer corresponding t=
o the


--
Alex Benn=C3=A9e
