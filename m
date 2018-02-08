Received: from eggs.gnu.org ([2001:4830:134:3::10]:34287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ejb9j-0000Ap-Mu
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 20:37:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ejb9h-0007B4-Fs
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 20:37:43 -0500
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:35214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ejb9h-0007Ai-7i
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 20:37:41 -0500
Received: by mail-ot0-x231.google.com with SMTP id a2so2727305otf.2
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 17:37:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1518046997-22714-1-git-send-email-mjc@sifive.com>
References: <1518046997-22714-1-git-send-email-mjc@sifive.com>
From: Michael Clark <mjc@sifive.com>
Date: Thu, 8 Feb 2018 14:37:39 +1300
Message-ID: <CAHNT7NtGpu03Gx-aqfhSbpKzTCAUtkNJjR840SRExvoxR-rYPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1] Implement support for IEEE 754-201x
 minimumNumber/maximumNumber
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Clark <mjc@sifive.com>

I've included this patch in the RISC-V patch series just submitted.

The change is enclosed within a simple conditional so there is no risk of
affecting any other ports.

There was one line whitespace fix to the pre-existing code however it fell
nicely within the diff hunk so I included the fix.

On Thu, Feb 8, 2018 at 12:43 PM, Michael Clark <mjc@sifive.com> wrote:

> QEMU currently implements IEEE 754-2008 minNum/maxNum. This patch adds
> support for IEEE 754-201x minimumNumber/maximumNumber which is required
> by the RISC-V port.
>
> minNum(x, y) is defined as
> - min(x, y) if neither is NaN
> - if one of x and y is a number and one is qNaN, return the number
> - if both are qNaN, or either is sNaN, return NaN
>
> minimumNumber(x, y) is defined as
> - min(x, y) if neither is NaN
> - if one of x and y is a number and one is qNaN or sNaN, return the number
> - if both are NaN, return the number
>
> Both functions signal the invalid exception on sNaN inputs.
>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  fpu/softfloat.c         | 41 +++++++++++++++++++++++++++++++++++------
>  include/fpu/softfloat.h |  4 ++++
>  2 files changed, 39 insertions(+), 6 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 433c5da..5793cc9 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -7675,6 +7675,9 @@ int float128_compare_quiet(float128 a, float128 b,
> float_status *status)
>   * minnummag() and maxnummag() functions correspond to minNumMag()
>   * and minNumMag() from the IEEE-754 2008.
>   */
> +
> +enum { ieee2008 = 1, ieee201x = 2 };
> +
>  #define MINMAX(s)                                                       \
>  static inline float ## s float ## s ## _minmax(float ## s a, float ## s
> b,     \
>                                                 int ismin, int isieee,   \
> @@ -7687,12 +7690,26 @@ static inline float ## s float ## s ##
> _minmax(float ## s a, float ## s b,     \
>      b = float ## s ## _squash_input_denormal(b, status);                \
>      if (float ## s ## _is_any_nan(a) ||                                 \
>          float ## s ## _is_any_nan(b)) {                                 \
> -        if (isieee) {                                                   \
> +        if (isieee == ieee2008) {                                       \
>              if (float ## s ## _is_quiet_nan(a, status) &&               \
>                  !float ## s ##_is_any_nan(b)) {                         \
>                  return b;                                               \
>              } else if (float ## s ## _is_quiet_nan(b, status) &&        \
> -                       !float ## s ## _is_any_nan(a)) {                \
> +                       !float ## s ## _is_any_nan(a)) {                 \
> +                return a;                                               \
> +            }                                                           \
> +        } else if (isieee == ieee201x) {                                \
> +            if (float ## s ## _is_any_nan(a) &&                         \
> +                !float ## s ##_is_any_nan(b)) {                         \
> +                if (!float ## s ## _is_quiet_nan(a, status)) {          \
> +                    float_raise(float_flag_invalid, status);            \
> +                }                                                       \
> +                return b;                                               \
> +            } else if (float ## s ## _is_any_nan(b) &&                  \
> +                       !float ## s ## _is_any_nan(a)) {                 \
> +                if (!float ## s ## _is_quiet_nan(b, status)) {          \
> +                    float_raise(float_flag_invalid, status);            \
> +                }                                                       \
>                  return a;                                               \
>              }                                                           \
>          }                                                               \
> @@ -7743,25 +7760,37 @@ float ## s float ## s ## _max(float ## s a, float
> ## s b,               \
>  float ## s float ## s ## _minnum(float ## s a, float ## s b,            \
>                                   float_status *status)                  \
>  {                                                                       \
> -    return float ## s ## _minmax(a, b, 1, 1, 0, status);                \
> +    return float ## s ## _minmax(a, b, 1, ieee2008, 0, status);         \
>  }                                                                       \
>                                                                          \
>  float ## s float ## s ## _maxnum(float ## s a, float ## s b,            \
>                                   float_status *status)                  \
>  {                                                                       \
> -    return float ## s ## _minmax(a, b, 0, 1, 0, status);                \
> +    return float ## s ## _minmax(a, b, 0, ieee2008, 0, status);         \
> +}                                                                       \
> +                                                                        \
> +float ## s float ## s ## _minimumnumber(float ## s a, float ## s b,     \
> +                                 float_status *status)                  \
> +{                                                                       \
> +    return float ## s ## _minmax(a, b, 1, ieee201x, 0, status);         \
> +}                                                                       \
> +                                                                        \
> +float ## s float ## s ## _maximumnumber(float ## s a, float ## s b,     \
> +                                 float_status *status)                  \
> +{                                                                       \
> +    return float ## s ## _minmax(a, b, 0, ieee201x, 0, status);         \
>  }                                                                       \
>                                                                          \
>  float ## s float ## s ## _minnummag(float ## s a, float ## s b,         \
>                                      float_status *status)               \
>  {                                                                       \
> -    return float ## s ## _minmax(a, b, 1, 1, 1, status);                \
> +    return float ## s ## _minmax(a, b, 1, ieee2008, 1, status);         \
>  }                                                                       \
>                                                                          \
>  float ## s float ## s ## _maxnummag(float ## s a, float ## s b,         \
>                                      float_status *status)               \
>  {                                                                       \
> -    return float ## s ## _minmax(a, b, 0, 1, 1, status);                \
> +    return float ## s ## _minmax(a, b, 0, ieee2008, 1, status);         \
>  }
>
>  MINMAX(32)
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index 0f96a0e..e0d0259 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -424,6 +424,8 @@ float32 float32_min(float32, float32, float_status
> *status);
>  float32 float32_max(float32, float32, float_status *status);
>  float32 float32_minnum(float32, float32, float_status *status);
>  float32 float32_maxnum(float32, float32, float_status *status);
> +float32 float32_minimumnumber(float32, float32, float_status *status);
> +float32 float32_maximumnumber(float32, float32, float_status *status);
>  float32 float32_minnummag(float32, float32, float_status *status);
>  float32 float32_maxnummag(float32, float32, float_status *status);
>  int float32_is_quiet_nan(float32, float_status *status);
> @@ -536,6 +538,8 @@ float64 float64_min(float64, float64, float_status
> *status);
>  float64 float64_max(float64, float64, float_status *status);
>  float64 float64_minnum(float64, float64, float_status *status);
>  float64 float64_maxnum(float64, float64, float_status *status);
> +float64 float64_minimumnumber(float64, float64, float_status *status);
> +float64 float64_maximumnumber(float64, float64, float_status *status);
>  float64 float64_minnummag(float64, float64, float_status *status);
>  float64 float64_maxnummag(float64, float64, float_status *status);
>  int float64_is_quiet_nan(float64 a, float_status *status);
> --
> 2.7.0
>
>
