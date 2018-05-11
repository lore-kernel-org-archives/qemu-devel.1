Received: from eggs.gnu.org ([2001:4830:134:3::10]:60103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fH2lh-00033H-Ur
	for qemu-devel@nongnu.org; Fri, 11 May 2018 03:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fH2ld-0004Vo-TB
	for qemu-devel@nongnu.org; Fri, 11 May 2018 03:47:09 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:47009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fH2ld-0004VP-JN
	for qemu-devel@nongnu.org; Fri, 11 May 2018 03:47:05 -0400
Received: by mail-wr0-x241.google.com with SMTP id a12-v6so4318819wrn.13
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 00:47:05 -0700 (PDT)
References: <20180511004345.26708-1-richard.henderson@linaro.org>
	<20180511004345.26708-3-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180511004345.26708-3-richard.henderson@linaro.org>
Date: Fri, 11 May 2018 08:47:03 +0100
Message-ID: <87fu2yvdl4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/19] fpu/softfloat: Split
 floatXX_silence_nan from floatXX_maybe_silence_nan
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

> The new function assumes that the input is an SNaN and
> does not double-check.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  fpu/softfloat-specialize.h | 174 +++++++++++++++++++++++++------------
>  include/fpu/softfloat.h    |   5 ++
>  2 files changed, 123 insertions(+), 56 deletions(-)
>
> diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
> index 8bd553abd2..b59356f6a5 100644
> --- a/fpu/softfloat-specialize.h
> +++ b/fpu/softfloat-specialize.h
> @@ -271,22 +271,35 @@ int float16_is_signaling_nan(float16 a_, float_stat=
us *status)
>  #endif
>  }
>
> +/*----------------------------------------------------------------------=
------
> +| Returns a quiet NaN from a signalling NaN for the half-precision
> +| floating point value `a'.
> +*-----------------------------------------------------------------------=
-----*/
> +
> +float16 float16_silence_nan(float16 a, float_status *status)
> +{
> +#ifdef NO_SIGNALING_NANS
> +    g_assert_not_reached();
> +#else
> +    if (status->snan_bit_is_one) {
> +        return float16_default_nan(status);
> +    } else {
> +        return a | (1 << 9);
> +    }
> +#endif
> +}
> +
>  /*----------------------------------------------------------------------=
------
>  | Returns a quiet NaN if the half-precision floating point value `a' is a
>  | signaling NaN; otherwise returns `a'.
>  *-----------------------------------------------------------------------=
-----*/
> -float16 float16_maybe_silence_nan(float16 a_, float_status *status)
> +
> +float16 float16_maybe_silence_nan(float16 a, float_status *status)
>  {
> -    if (float16_is_signaling_nan(a_, status)) {
> -        if (status->snan_bit_is_one) {
> -            return float16_default_nan(status);
> -        } else {
> -            uint16_t a =3D float16_val(a_);
> -            a |=3D (1 << 9);
> -            return make_float16(a);
> -        }
> +    if (float16_is_signaling_nan(a, status)) {
> +        float16_silence_nan(a, status);
>      }
> -    return a_;
> +    return a;
>  }
>
>  /*----------------------------------------------------------------------=
------
> @@ -327,30 +340,40 @@ int float32_is_signaling_nan(float32 a_, float_stat=
us *status)
>  #endif
>  }
>
> +/*----------------------------------------------------------------------=
------
> +| Returns a quiet NaN from a signalling NaN for the single-precision
> +| floating point value `a'.
> +*-----------------------------------------------------------------------=
-----*/
> +
> +float32 float32_silence_nan(float32 a, float_status *status)
> +{
> +#ifdef NO_SIGNALING_NANS
> +    g_assert_not_reached();
> +#else
> +    if (status->snan_bit_is_one) {
> +# ifdef TARGET_HPPA
> +        a &=3D ~0x00400000;
> +        a |=3D  0x00200000;
> +        return a;
> +# else
> +        return float32_default_nan(status);
> +# endif
> +    } else {
> +        return a | (1 << 22);
> +    }
> +#endif
> +}
>  /*----------------------------------------------------------------------=
------
>  | Returns a quiet NaN if the single-precision floating point value `a' i=
s a
>  | signaling NaN; otherwise returns `a'.
>  *-----------------------------------------------------------------------=
-----*/
>
> -float32 float32_maybe_silence_nan(float32 a_, float_status *status)
> +float32 float32_maybe_silence_nan(float32 a, float_status *status)
>  {
> -    if (float32_is_signaling_nan(a_, status)) {
> -        if (status->snan_bit_is_one) {
> -#ifdef TARGET_HPPA
> -            uint32_t a =3D float32_val(a_);
> -            a &=3D ~0x00400000;
> -            a |=3D  0x00200000;
> -            return make_float32(a);
> -#else
> -            return float32_default_nan(status);
> -#endif
> -        } else {
> -            uint32_t a =3D float32_val(a_);
> -            a |=3D (1 << 22);
> -            return make_float32(a);
> -        }
> +    if (float32_is_signaling_nan(a, status)) {
> +        float32_silence_nan(a, status);
>      }
> -    return a_;
> +    return a;
>  }
>
>  /*----------------------------------------------------------------------=
------
> @@ -736,30 +759,41 @@ int float64_is_signaling_nan(float64 a_, float_stat=
us *status)
>  #endif
>  }
>
> +/*----------------------------------------------------------------------=
------
> +| Returns a quiet NaN from a signalling NaN for the double-precision
> +| floating point value `a'.
> +*-----------------------------------------------------------------------=
-----*/
> +
> +float64 float64_silence_nan(float64 a, float_status *status)
> +{
> +#ifdef NO_SIGNALING_NANS
> +    g_assert_not_reached();
> +#else
> +    if (status->snan_bit_is_one) {
> +# ifdef TARGET_HPPA
> +        a &=3D ~0x0008000000000000ULL;
> +        a |=3D  0x0004000000000000ULL;
> +        return a;
> +# else
> +        return float64_default_nan(status);
> +# endif
> +    } else {
> +        return a | LIT64(0x0008000000000000);
> +    }
> +#endif
> +}
> +
>  /*----------------------------------------------------------------------=
------
>  | Returns a quiet NaN if the double-precision floating point value `a' i=
s a
>  | signaling NaN; otherwise returns `a'.
>  *-----------------------------------------------------------------------=
-----*/
>
> -float64 float64_maybe_silence_nan(float64 a_, float_status *status)
> +float64 float64_maybe_silence_nan(float64 a, float_status *status)
>  {
> -    if (float64_is_signaling_nan(a_, status)) {
> -        if (status->snan_bit_is_one) {
> -#ifdef TARGET_HPPA
> -            uint64_t a =3D float64_val(a_);
> -            a &=3D ~0x0008000000000000ULL;
> -            a |=3D  0x0004000000000000ULL;
> -            return make_float64(a);
> -#else
> -            return float64_default_nan(status);
> -#endif
> -        } else {
> -            uint64_t a =3D float64_val(a_);
> -            a |=3D LIT64(0x0008000000000000);
> -            return make_float64(a);
> -        }
> +    if (float64_is_signaling_nan(a, status)) {
> +        return float64_silence_nan(a, status);
>      }
> -    return a_;
> +    return a;
>  }
>
>  /*----------------------------------------------------------------------=
------
> @@ -897,6 +931,25 @@ int floatx80_is_signaling_nan(floatx80 a, float_stat=
us *status)
>  #endif
>  }
>
> +/*----------------------------------------------------------------------=
------
> +| Returns a quiet NaN from a signalling NaN for the extended double-prec=
ision
> +| floating point value `a'.
> +*-----------------------------------------------------------------------=
-----*/
> +
> +floatx80 floatx80_silence_nan(floatx80 a, float_status *status)
> +{
> +#ifdef NO_SIGNALING_NANS
> +    g_assert_not_reached();
> +#else
> +    if (status->snan_bit_is_one) {
> +        return floatx80_default_nan(status);
> +    } else {
> +        a.low |=3D LIT64(0xC000000000000000);
> +        return a;
> +    }
> +#endif
> +}
> +
>  /*----------------------------------------------------------------------=
------
>  | Returns a quiet NaN if the extended double-precision floating point va=
lue
>  | `a' is a signaling NaN; otherwise returns `a'.
> @@ -905,12 +958,7 @@ int floatx80_is_signaling_nan(floatx80 a, float_stat=
us *status)
>  floatx80 floatx80_maybe_silence_nan(floatx80 a, float_status *status)
>  {
>      if (floatx80_is_signaling_nan(a, status)) {
> -        if (status->snan_bit_is_one) {
> -            a =3D floatx80_default_nan(status);
> -        } else {
> -            a.low |=3D LIT64(0xC000000000000000);
> -            return a;
> -        }
> +        return floatx80_silence_nan(a, status);
>      }
>      return a;
>  }
> @@ -1044,6 +1092,25 @@ int float128_is_signaling_nan(float128 a, float_st=
atus *status)
>  #endif
>  }
>
> +/*----------------------------------------------------------------------=
------
> +| Returns a quiet NaN from a signalling NaN for the quadruple-precision
> +| floating point value `a'.
> +*-----------------------------------------------------------------------=
-----*/
> +
> +float128 float128_silence_nan(float128 a, float_status *status)
> +{
> +#ifdef NO_SIGNALING_NANS
> +    g_assert_not_reached();
> +#else
> +    if (status->snan_bit_is_one) {
> +        return float128_default_nan(status);
> +    } else {
> +        a.high |=3D LIT64(0x0000800000000000);
> +        return a;
> +    }
> +#endif
> +}
> +
>  /*----------------------------------------------------------------------=
------
>  | Returns a quiet NaN if the quadruple-precision floating point value `a=
' is
>  | a signaling NaN; otherwise returns `a'.
> @@ -1052,12 +1119,7 @@ int float128_is_signaling_nan(float128 a, float_st=
atus *status)
>  float128 float128_maybe_silence_nan(float128 a, float_status *status)
>  {
>      if (float128_is_signaling_nan(a, status)) {
> -        if (status->snan_bit_is_one) {
> -            a =3D float128_default_nan(status);
> -        } else {
> -            a.high |=3D LIT64(0x0000800000000000);
> -            return a;
> -        }
> +        return float128_silence_nan(a, status);
>      }
>      return a;
>  }
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index 01ef1c6b81..a6860e858d 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -257,6 +257,7 @@ int float16_compare_quiet(float16, float16, float_sta=
tus *status);
>
>  int float16_is_quiet_nan(float16, float_status *status);
>  int float16_is_signaling_nan(float16, float_status *status);
> +float16 float16_silence_nan(float16, float_status *status);
>  float16 float16_maybe_silence_nan(float16, float_status *status);
>
>  static inline int float16_is_any_nan(float16 a)
> @@ -368,6 +369,7 @@ float32 float32_minnummag(float32, float32, float_sta=
tus *status);
>  float32 float32_maxnummag(float32, float32, float_status *status);
>  int float32_is_quiet_nan(float32, float_status *status);
>  int float32_is_signaling_nan(float32, float_status *status);
> +float32 float32_silence_nan(float32, float_status *status);
>  float32 float32_maybe_silence_nan(float32, float_status *status);
>  float32 float32_scalbn(float32, int, float_status *status);
>
> @@ -497,6 +499,7 @@ float64 float64_minnummag(float64, float64, float_sta=
tus *status);
>  float64 float64_maxnummag(float64, float64, float_status *status);
>  int float64_is_quiet_nan(float64 a, float_status *status);
>  int float64_is_signaling_nan(float64, float_status *status);
> +float64 float64_silence_nan(float64, float_status *status);
>  float64 float64_maybe_silence_nan(float64, float_status *status);
>  float64 float64_scalbn(float64, int, float_status *status);
>
> @@ -600,6 +603,7 @@ int floatx80_compare(floatx80, floatx80, float_status=
 *status);
>  int floatx80_compare_quiet(floatx80, floatx80, float_status *status);
>  int floatx80_is_quiet_nan(floatx80, float_status *status);
>  int floatx80_is_signaling_nan(floatx80, float_status *status);
> +floatx80 floatx80_silence_nan(floatx80, float_status *status);
>  floatx80 floatx80_maybe_silence_nan(floatx80, float_status *status);
>  floatx80 floatx80_scalbn(floatx80, int, float_status *status);
>
> @@ -811,6 +815,7 @@ int float128_compare(float128, float128, float_status=
 *status);
>  int float128_compare_quiet(float128, float128, float_status *status);
>  int float128_is_quiet_nan(float128, float_status *status);
>  int float128_is_signaling_nan(float128, float_status *status);
> +float128 float128_silence_nan(float128, float_status *status);
>  float128 float128_maybe_silence_nan(float128, float_status *status);
>  float128 float128_scalbn(float128, int, float_status *status);


--
Alex Benn=C3=A9e
