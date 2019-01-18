Received: from eggs.gnu.org ([209.51.188.92]:48251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkSuN-0000IB-8p
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:05:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkSuM-0007uW-KM
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:05:59 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkSuM-0007uK-FZ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:05:58 -0500
Received: by mail-oi1-x242.google.com with SMTP id t204so8771092oie.7
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 04:05:58 -0800 (PST)
MIME-Version: 1.0
References: <20190108223129.5570-1-richard.henderson@linaro.org>
	<20190108223129.5570-23-richard.henderson@linaro.org>
In-Reply-To: <20190108223129.5570-23-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 12:05:45 +0000
Message-ID: <CAFEAcA86e=nfUFtvWzkceE88yy9V+iow6H6zTHY3Qqx=Pow5YA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 22/31] target/arm: Decode TBID from TCR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, 8 Jan 2019 at 22:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Use TBID in aa64_va_parameters depending on the data parameter.
> This automatically updates all existing users of the function.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

>  ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
>                                     ARMMMUIdx mmu_idx, bool data)
>  {
> -    return aa64_va_parameters_both(env, va, mmu_idx);
> +    ARMVAParameters ret = aa64_va_parameters_both(env, va, mmu_idx);
> +
> +    /* Present TBI as a composite with TBID.  */
> +    ret.tbi &= (data || !ret.tbid);
> +    return ret;

It took me a good couple of minutes to to work out if this
expression actually did what the docs say TBID is supposed to do...

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>


thanks
-- PMM
