Received: from eggs.gnu.org ([2001:4830:134:3::10]:56356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eysPW-0000NY-Vl
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 01:05:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eysPT-00058f-Qs
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 01:05:10 -0400
Received: from mail-io0-x236.google.com ([2607:f8b0:4001:c06::236]:36381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eysPT-00057X-L7
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 01:05:07 -0400
Received: by mail-io0-x236.google.com with SMTP id o4so9358328iod.3
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 22:05:07 -0700 (PDT)
References: <1521663109-32262-1-git-send-email-cota@braap.org>
	<1521663109-32262-9-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <67b8c0f8-3fd9-ba7c-a666-d0715b5a3329@linaro.org>
Date: Thu, 22 Mar 2018 13:05:00 +0800
MIME-Version: 1.0
In-Reply-To: <1521663109-32262-9-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 08/14] hostfloat: support float32/64
 addition and subtraction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 03/22/2018 04:11 AM, Emilio G. Cota wrote:
> +#define GEN_FPU_ADDSUB(add_name, sub_name, soft_t, host_t,              \
> +                       host_abs_func, min_normal)                       \
> +    static inline __attribute__((always_inline)) soft_t                 \
> +    fpu_ ## soft_t ## _addsub(soft_t a, soft_t b, bool subtract,        \
> +                              float_status *s)                          \
> +    {                                                                   \
> +        soft_t ## _input_flush2(&a, &b, s);                             \
> +        if (likely((soft_t ## _is_normal(a) || soft_t ## _is_zero(a)) && \
> +                   (soft_t ## _is_normal(b) || soft_t ## _is_zero(b)) && \
> +                   s->float_exception_flags & float_flag_inexact &&     \
> +                   s->float_rounding_mode == float_round_nearest_even)) { \
> +            host_t ha = soft_t ## _to_ ## host_t(a);                    \
> +            host_t hb = soft_t ## _to_ ## host_t(b);                    \
> +            host_t hr;                                                  \
> +            soft_t r;                                                   \
> +                                                                        \
> +            if (subtract) {                                             \
> +                hb = -hb;                                               \
> +            }                                                           \
> +            hr = ha + hb;                                               \
> +            r = host_t ## _to_ ## soft_t(hr);                           \
> +            if (unlikely(soft_t ## _is_infinity(r))) {                  \
> +                s->float_exception_flags |= float_flag_overflow;        \
> +            } else if (unlikely(host_abs_func(hr) <= min_normal)) {     \
> +                goto soft;                                              \
> +            }                                                           \
> +            return r;                                                   \
> +        }                                                               \
> +    soft:                                                               \

Is there any especially good reason you want to not put this code into the
normal softfloat function?  Does it really many any measurable difference at
all to force this code to be inlined into a helper?


r~
