Received: from eggs.gnu.org ([2001:4830:134:3::10]:47230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR4Nc-0004E1-8S
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:59:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR4NY-0002Fd-8M
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:59:28 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:43652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eR4NY-0002FP-0p
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:59:24 -0500
Received: by mail-pl0-x242.google.com with SMTP id z5so5753434plo.10
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 14:59:23 -0800 (PST)
References: <20171211125705.16120-1-alex.bennee@linaro.org>
	<20171211125705.16120-17-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <04791c4d-cc8a-c279-d1a8-8a86c9d470ac@linaro.org>
Date: Mon, 18 Dec 2017 14:59:16 -0800
MIME-Version: 1.0
In-Reply-To: <20171211125705.16120-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 16/19] fpu/softfloat: re-factor int/uint
 to float
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, aleksandar.markovic@imgtec.com
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 12/11/2017 04:57 AM, Alex Bennée wrote:
> These are considerably simpler as the lower order integers can just
> use the higher order conversion function. As the decomposed fractional
> part is a full 64 bit rounding and inexact handling comes from the
> pack functions.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  fpu/softfloat.c         | 358 +++++++++++++++++++++++++-----------------------
>  include/fpu/softfloat.h |  30 ++--
>  2 files changed, 195 insertions(+), 193 deletions(-)
> 
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index d7858bdae5..1a7f1cab10 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -1409,17 +1409,18 @@ FLOAT_TO_INT(64, 64)
>  
>  #undef FLOAT_TO_INT
>  
> -/*----------------------------------------------------------------------------
> -| Returns the result of converting the  floating-point value
> -| `a' to the unsigned integer format.  The conversion is
> -| performed according to the IEC/IEEE Standard for Binary Floating-Point
> -| Arithmetic---which means in particular that the conversion is rounded
> -| according to the current rounding mode.  If `a' is a NaN, the largest
> -| unsigned integer is returned.  Otherwise, if the conversion overflows, the
> -| largest unsigned integer is returned.  If the 'a' is negative, the result
> -| is rounded and zero is returned; values that do not round to zero will
> -| raise the inexact exception flag.
> -*----------------------------------------------------------------------------*/
> +/*
> + *  Returns the result of converting the floating-point value `a' to
> + *  the unsigned integer format. The conversion is performed according
> + *  to the IEC/IEEE Standard for Binary Floating-Point
> + *  Arithmetic---which means in particular that the conversion is
> + *  rounded according to the current rounding mode. If `a' is a NaN,
> + *  the largest unsigned integer is returned. Otherwise, if the
> + *  conversion overflows, the largest unsigned integer is returned. If
> + *  the 'a' is negative, the result is rounded and zero is returned;
> + *  values that do not round to zero will raise the inexact exception
> + *  flag.
> + */
>  
>  static uint64_t uint64_pack_decomposed(decomposed_parts p, float_status *s)
>  {
> @@ -1433,6 +1434,7 @@ static uint64_t uint64_pack_decomposed(decomposed_parts p, float_status *s)
>          return 0;
>      case float_class_normal:
>          if (p.sign) {
> +            s->float_exception_flags |= float_flag_invalid;
>              return 0;
>          }
>          if (p.exp < DECOMPOSED_BINARY_POINT) {
> @@ -1440,6 +1442,7 @@ static uint64_t uint64_pack_decomposed(decomposed_parts p, float_status *s)
>          } else if (p.exp < 64) {
>              return p.frac << (p.exp - DECOMPOSED_BINARY_POINT);
>          } else {
> +            s->float_exception_flags |= float_flag_invalid;
>              return UINT64_MAX;
>          }
>      default:
> @@ -1450,13 +1453,21 @@ static uint64_t uint64_pack_decomposed(decomposed_parts p, float_status *s)
>  static uint16_t uint16_pack_decomposed(decomposed_parts p, float_status *s)
>  {
>      uint64_t r = uint64_pack_decomposed(p, s);
> -    return r > UINT16_MAX ? UINT16_MAX : r;
> +    if (r > UINT16_MAX) {
> +        s->float_exception_flags |= float_flag_invalid;
> +        r = UINT16_MAX;
> +    }
> +    return r;
>  }
>  
>  static uint32_t uint32_pack_decomposed(decomposed_parts p, float_status *s)
>  {
>      uint64_t r = uint64_pack_decomposed(p, s);
> -    return r > UINT32_MAX ? UINT32_MAX : r;
> +    if (r > UINT32_MAX) {
> +        s->float_exception_flags |= float_flag_invalid;
> +        r = UINT32_MAX;
> +    }
> +    return r;
>  }
>  
>  #define F

Ah, the fix for the bug in patch 15 got squashed into the wrong patch.  ;-)

> +float16 int16_to_float16(int16_t a, float_status *status)
> +{
> +    return int64_to_float16((int64_t) a, status);
> +}

Kill all of the redundant casts?

Otherwise, as amended in your followup,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
