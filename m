Received: from eggs.gnu.org ([2001:4830:134:3::10]:38595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diRKg-0001mx-GH
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 16:23:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diRKb-0003Pe-RV
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 16:23:57 -0400
Received: from mail-pg0-x22e.google.com ([2607:f8b0:400e:c05::22e]:35238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1diRKb-0003PJ-LY
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 16:23:53 -0400
Received: by mail-pg0-x22e.google.com with SMTP id v189so49712489pgd.2
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 13:23:53 -0700 (PDT)
References: <20170817180404.29334-1-alex.bennee@linaro.org>
	<20170817180404.29334-10-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0aac1365-72e1-ff17-b9e2-4bdd5c34901e@linaro.org>
Date: Thu, 17 Aug 2017 13:23:49 -0700
MIME-Version: 1.0
In-Reply-To: <20170817180404.29334-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 9/9] target/arm/translate-a64:
 vectorise smull vD.4s, vN.[48]s, vM.h[]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, rth@twiddle.net, cota@braap.org, batuzovk@ispras.ru
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 08/17/2017 11:04 AM, Alex Bennée wrote:
> +    int32_t *rd = (int32_t *) d;
> +    int16_t *rn = (int16_t *) n;
> +    int16_t rm = (int16_t) m;
> +    int i;
> +
> +    #pragma GCC ivdep
> +    for (i = 0; i < opr_elt; ++i) {
> +        rd[i] = rn[i + doff_elt] * rm;
> +    }

You need to run this loop backward to avoid clobbering data when rd == rn.
I thought you'd put m into ADVSIMD_DATA.

> 
> +                if (is_q) {
> +                    simd_info = deposit32(simd_info,
> +                                          ADVSIMD_DOFF_ELT_SHIFT, ADVSIMD_DOFF_ELT_BITS, 4);
> +                }

It'd probably be useful to have a macro to clean this up:

#define PUT_SIMD_DATA(t, d)  \
    deposit32(0, ADVSIMD_ ## t ## _SHIFT, ADVSIMD_ ## t ## _BITS, (d))

  simd_info |= PUT_SIMD_DATA(DOFF_ELT, 4)

that said, folding DOFF into the pointer that gets passed in the first place
seems a better solution to me.


r~
