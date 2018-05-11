Received: from eggs.gnu.org ([2001:4830:134:3::10]:47180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fH1nD-0003Aj-94
	for qemu-devel@nongnu.org; Fri, 11 May 2018 02:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fH1n8-0004S3-5D
	for qemu-devel@nongnu.org; Fri, 11 May 2018 02:44:39 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:45291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fH1n7-0004Rl-RD
	for qemu-devel@nongnu.org; Fri, 11 May 2018 02:44:34 -0400
Received: by mail-wr0-x241.google.com with SMTP id p5-v6so4157449wre.12
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 23:44:33 -0700 (PDT)
References: <20180511004345.26708-1-richard.henderson@linaro.org>
	<20180511004345.26708-2-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180511004345.26708-2-richard.henderson@linaro.org>
Date: Fri, 11 May 2018 07:44:30 +0100
Message-ID: <87h8nevghd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/19] fpu/softfloat: Merge
 NO_SIGNALING_NANS definitions
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

> Move the ifdef inside the relevant functions instead of
> duplicating the function declarations.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  fpu/softfloat-specialize.h | 100 +++++++++++++++----------------------
>  1 file changed, 40 insertions(+), 60 deletions(-)
>
> diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
> index a20b440159..8bd553abd2 100644
> --- a/fpu/softfloat-specialize.h
> +++ b/fpu/softfloat-specialize.h
> @@ -233,17 +233,6 @@ typedef struct {
>      uint64_t high, low;
>  } commonNaNT;
>
> -#ifdef NO_SIGNALING_NANS
> -int float16_is_quiet_nan(float16 a_, float_status *status)
> -{
> -    return float16_is_any_nan(a_);
> -}
> -
> -int float16_is_signaling_nan(float16 a_, float_status *status)
> -{
> -    return 0;
> -}
> -#else
>  /*----------------------------------------------------------------------=
------
>  | Returns 1 if the half-precision floating-point value `a' is a quiet
>  | NaN; otherwise returns 0.
> @@ -251,12 +240,16 @@ int float16_is_signaling_nan(float16 a_, float_stat=
us *status)
>
>  int float16_is_quiet_nan(float16 a_, float_status *status)
>  {
> +#ifdef NO_SIGNALING_NANS
> +    return float16_is_any_nan(a_);
> +#else
>      uint16_t a =3D float16_val(a_);
>      if (status->snan_bit_is_one) {
>          return (((a >> 9) & 0x3F) =3D=3D 0x3E) && (a & 0x1FF);
>      } else {
>          return ((a & ~0x8000) >=3D 0x7C80);
>      }
> +#endif
>  }
>
>  /*----------------------------------------------------------------------=
------
> @@ -266,14 +259,17 @@ int float16_is_quiet_nan(float16 a_, float_status *=
status)
>
>  int float16_is_signaling_nan(float16 a_, float_status *status)
>  {
> +#ifdef NO_SIGNALING_NANS
> +    return 0;
> +#else
>      uint16_t a =3D float16_val(a_);
>      if (status->snan_bit_is_one) {
>          return ((a & ~0x8000) >=3D 0x7C80);
>      } else {
>          return (((a >> 9) & 0x3F) =3D=3D 0x3E) && (a & 0x1FF);
>      }
> -}
>  #endif
> +}
>
>  /*----------------------------------------------------------------------=
------
>  | Returns a quiet NaN if the half-precision floating point value `a' is a
> @@ -293,17 +289,6 @@ float16 float16_maybe_silence_nan(float16 a_, float_=
status *status)
>      return a_;
>  }
>
> -#ifdef NO_SIGNALING_NANS
> -int float32_is_quiet_nan(float32 a_, float_status *status)
> -{
> -    return float32_is_any_nan(a_);
> -}
> -
> -int float32_is_signaling_nan(float32 a_, float_status *status)
> -{
> -    return 0;
> -}
> -#else
>  /*----------------------------------------------------------------------=
------
>  | Returns 1 if the single-precision floating-point value `a' is a quiet
>  | NaN; otherwise returns 0.
> @@ -311,12 +296,16 @@ int float32_is_signaling_nan(float32 a_, float_stat=
us *status)
>
>  int float32_is_quiet_nan(float32 a_, float_status *status)
>  {
> +#ifdef NO_SIGNALING_NANS
> +    return float32_is_any_nan(a_);
> +#else
>      uint32_t a =3D float32_val(a_);
>      if (status->snan_bit_is_one) {
>          return (((a >> 22) & 0x1FF) =3D=3D 0x1FE) && (a & 0x003FFFFF);
>      } else {
>          return ((uint32_t)(a << 1) >=3D 0xFF800000);
>      }
> +#endif
>  }
>
>  /*----------------------------------------------------------------------=
------
> @@ -326,14 +315,17 @@ int float32_is_quiet_nan(float32 a_, float_status *=
status)
>
>  int float32_is_signaling_nan(float32 a_, float_status *status)
>  {
> +#ifdef NO_SIGNALING_NANS
> +    return 0;
> +#else
>      uint32_t a =3D float32_val(a_);
>      if (status->snan_bit_is_one) {
>          return ((uint32_t)(a << 1) >=3D 0xFF800000);
>      } else {
>          return (((a >> 22) & 0x1FF) =3D=3D 0x1FE) && (a & 0x003FFFFF);
>      }
> -}
>  #endif
> +}
>
>  /*----------------------------------------------------------------------=
------
>  | Returns a quiet NaN if the single-precision floating point value `a' i=
s a
> @@ -704,17 +696,6 @@ static float32 propagateFloat32NaN(float32 a, float3=
2 b, float_status *status)
>      }
>  }
>
> -#ifdef NO_SIGNALING_NANS
> -int float64_is_quiet_nan(float64 a_, float_status *status)
> -{
> -    return float64_is_any_nan(a_);
> -}
> -
> -int float64_is_signaling_nan(float64 a_, float_status *status)
> -{
> -    return 0;
> -}
> -#else
>  /*----------------------------------------------------------------------=
------
>  | Returns 1 if the double-precision floating-point value `a' is a quiet
>  | NaN; otherwise returns 0.
> @@ -722,6 +703,9 @@ int float64_is_signaling_nan(float64 a_, float_status=
 *status)
>
>  int float64_is_quiet_nan(float64 a_, float_status *status)
>  {
> +#ifdef NO_SIGNALING_NANS
> +    return float64_is_any_nan(a_);
> +#else
>      uint64_t a =3D float64_val(a_);
>      if (status->snan_bit_is_one) {
>          return (((a >> 51) & 0xFFF) =3D=3D 0xFFE)
> @@ -729,6 +713,7 @@ int float64_is_quiet_nan(float64 a_, float_status *st=
atus)
>      } else {
>          return ((a << 1) >=3D 0xFFF0000000000000ULL);
>      }
> +#endif
>  }
>
>  /*----------------------------------------------------------------------=
------
> @@ -738,6 +723,9 @@ int float64_is_quiet_nan(float64 a_, float_status *st=
atus)
>
>  int float64_is_signaling_nan(float64 a_, float_status *status)
>  {
> +#ifdef NO_SIGNALING_NANS
> +    return 0;
> +#else
>      uint64_t a =3D float64_val(a_);
>      if (status->snan_bit_is_one) {
>          return ((a << 1) >=3D 0xFFF0000000000000ULL);
> @@ -745,8 +733,8 @@ int float64_is_signaling_nan(float64 a_, float_status=
 *status)
>          return (((a >> 51) & 0xFFF) =3D=3D 0xFFE)
>              && (a & LIT64(0x0007FFFFFFFFFFFF));
>      }
> -}
>  #endif
> +}
>
>  /*----------------------------------------------------------------------=
------
>  | Returns a quiet NaN if the double-precision floating point value `a' i=
s a
> @@ -859,17 +847,6 @@ static float64 propagateFloat64NaN(float64 a, float6=
4 b, float_status *status)
>      }
>  }
>
> -#ifdef NO_SIGNALING_NANS
> -int floatx80_is_quiet_nan(floatx80 a_, float_status *status)
> -{
> -    return floatx80_is_any_nan(a_);
> -}
> -
> -int floatx80_is_signaling_nan(floatx80 a_, float_status *status)
> -{
> -    return 0;
> -}
> -#else
>  /*----------------------------------------------------------------------=
------
>  | Returns 1 if the extended double-precision floating-point value `a' is=
 a
>  | quiet NaN; otherwise returns 0. This slightly differs from the same
> @@ -878,6 +855,9 @@ int floatx80_is_signaling_nan(floatx80 a_, float_stat=
us *status)
>
>  int floatx80_is_quiet_nan(floatx80 a, float_status *status)
>  {
> +#ifdef NO_SIGNALING_NANS
> +    return floatx80_is_any_nan(a);
> +#else
>      if (status->snan_bit_is_one) {
>          uint64_t aLow;
>
> @@ -889,6 +869,7 @@ int floatx80_is_quiet_nan(floatx80 a, float_status *s=
tatus)
>          return ((a.high & 0x7FFF) =3D=3D 0x7FFF)
>              && (LIT64(0x8000000000000000) <=3D ((uint64_t)(a.low << 1)));
>      }
> +#endif
>  }
>
>  /*----------------------------------------------------------------------=
------
> @@ -899,6 +880,9 @@ int floatx80_is_quiet_nan(floatx80 a, float_status *s=
tatus)
>
>  int floatx80_is_signaling_nan(floatx80 a, float_status *status)
>  {
> +#ifdef NO_SIGNALING_NANS
> +    return 0;
> +#else
>      if (status->snan_bit_is_one) {
>          return ((a.high & 0x7FFF) =3D=3D 0x7FFF)
>              && ((a.low << 1) >=3D 0x8000000000000000ULL);
> @@ -910,8 +894,8 @@ int floatx80_is_signaling_nan(floatx80 a, float_statu=
s *status)
>              && (uint64_t)(aLow << 1)
>              && (a.low =3D=3D aLow);
>      }
> -}
>  #endif
> +}
>
>  /*----------------------------------------------------------------------=
------
>  | Returns a quiet NaN if the extended double-precision floating point va=
lue
> @@ -1020,17 +1004,6 @@ floatx80 propagateFloatx80NaN(floatx80 a, floatx80=
 b, float_status *status)
>      }
>  }
>
> -#ifdef NO_SIGNALING_NANS
> -int float128_is_quiet_nan(float128 a_, float_status *status)
> -{
> -    return float128_is_any_nan(a_);
> -}
> -
> -int float128_is_signaling_nan(float128 a_, float_status *status)
> -{
> -    return 0;
> -}
> -#else
>  /*----------------------------------------------------------------------=
------
>  | Returns 1 if the quadruple-precision floating-point value `a' is a qui=
et
>  | NaN; otherwise returns 0.
> @@ -1038,6 +1011,9 @@ int float128_is_signaling_nan(float128 a_, float_st=
atus *status)
>
>  int float128_is_quiet_nan(float128 a, float_status *status)
>  {
> +#ifdef NO_SIGNALING_NANS
> +    return float128_is_any_nan(a);
> +#else
>      if (status->snan_bit_is_one) {
>          return (((a.high >> 47) & 0xFFFF) =3D=3D 0xFFFE)
>              && (a.low || (a.high & 0x00007FFFFFFFFFFFULL));
> @@ -1045,6 +1021,7 @@ int float128_is_quiet_nan(float128 a, float_status =
*status)
>          return ((a.high << 1) >=3D 0xFFFF000000000000ULL)
>              && (a.low || (a.high & 0x0000FFFFFFFFFFFFULL));
>      }
> +#endif
>  }
>
>  /*----------------------------------------------------------------------=
------
> @@ -1054,6 +1031,9 @@ int float128_is_quiet_nan(float128 a, float_status =
*status)
>
>  int float128_is_signaling_nan(float128 a, float_status *status)
>  {
> +#ifdef NO_SIGNALING_NANS
> +    return 0;
> +#else
>      if (status->snan_bit_is_one) {
>          return ((a.high << 1) >=3D 0xFFFF000000000000ULL)
>              && (a.low || (a.high & 0x0000FFFFFFFFFFFFULL));
> @@ -1061,8 +1041,8 @@ int float128_is_signaling_nan(float128 a, float_sta=
tus *status)
>          return (((a.high >> 47) & 0xFFFF) =3D=3D 0xFFFE)
>              && (a.low || (a.high & LIT64(0x00007FFFFFFFFFFF)));
>      }
> -}
>  #endif
> +}
>
>  /*----------------------------------------------------------------------=
------
>  | Returns a quiet NaN if the quadruple-precision floating point value `a=
' is


--
Alex Benn=C3=A9e
