Received: from eggs.gnu.org ([2001:4830:134:3::10]:37218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fbQyB-0006Q2-22
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:40:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fbQy5-0002PD-Nk
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:40:19 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fbQy5-0002O8-Fy
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:40:13 -0400
Received: by mail-pg1-x544.google.com with SMTP id x5-v6so253080pgp.7
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 06:40:13 -0700 (PDT)
References: <1530877732-26557-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1530877732-26557-7-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <04dc592b-90e5-46be-7ce9-1447642234a0@linaro.org>
Date: Fri, 6 Jul 2018 06:40:09 -0700
MIME-Version: 1.0
In-Reply-To: <1530877732-26557-7-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 6/8] target/mips: Amend CP0 WatchHi
 register implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/06/2018 04:48 AM, Aleksandar Markovic wrote:
> +++ b/target/mips/op_helper.c
> @@ -893,7 +893,12 @@ target_ulong helper_mfc0_watchlo(CPUMIPSState *env, uint32_t sel)
>  
>  target_ulong helper_mfc0_watchhi(CPUMIPSState *env, uint32_t sel)
>  {
> -    return env->CP0_WatchHi[sel];
> +    return (int32_t) env->CP0_WatchHi[sel];
> +}
> +
> +target_ulong helper_mfhc0_watchhi(CPUMIPSState *env, uint32_t sel)
> +{
> +    return env->CP0_WatchHi[sel] >> 32;
>  }

Did you in fact want the high-part sign-extended as well?
It might be more obvious to write

    return sextract64(env->CP0_WatchHi[sel], 32, 32);

in that case.

> +void helper_mthc0_watchhi(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
> +{
> +    env->CP0_WatchHi[sel] = ((uint64_t) (arg1) << 32) |
> +                            (env->CP0_WatchHi[sel] & 0x00000000ffffffffULL);

Cleaner as

    env->CP0_WatchHi[sel] = deposit64(env->CP0_WatchHi[sel], 32, 32, arg1);


For future cleanup, there is nothing in this (or several other) that requires
writing helper code.  This could just as easily be expanded inline with one
single load or store operation.


r~
