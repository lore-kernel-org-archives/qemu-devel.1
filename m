Received: from eggs.gnu.org ([2001:4830:134:3::10]:55718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9wEf-00023J-HC
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:55:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9wEb-0007m2-My
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:55:55 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g9wEZ-0007lF-JP
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:55:53 -0400
Received: by mail-ot1-x342.google.com with SMTP id c23so787618otl.9
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 10:55:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181009174557.16125-2-cota@braap.org>
References: <20181009174557.16125-1-cota@braap.org>
	<20181009174557.16125-2-cota@braap.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Oct 2018 18:55:30 +0100
Message-ID: <CAFEAcA8DyV6_BfRZT2_9K1PKNkPnLqw8e=55uJ3R1r5+ejkRFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 1/6] target/alpha: remove tlb_flush from
 alpha_cpu_initfn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

On 9 October 2018 at 18:45, Emilio G. Cota <cota@braap.org> wrote:
> As far as I can tell tlb_flush does not need to be called
> this early. tlb_flush is eventually called after the CPU
> has been realized.
>
> This change paves the way to the introduction of tlb_init,
> which will be called from cpu_exec_realizefn.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/alpha/cpu.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
> index b08078e7fc..a953897fcc 100644
> --- a/target/alpha/cpu.c
> +++ b/target/alpha/cpu.c
> @@ -201,7 +201,6 @@ static void alpha_cpu_initfn(Object *obj)
>      CPUAlphaState *env = &cpu->env;
>
>      cs->env_ptr = env;
> -    tlb_flush(cs);
>
>      env->lock_addr = -1;
>  #if defined(CONFIG_USER_ONLY)
> --
> 2.17.1

Definitely agreed that we don't want to tlb_flush in the
target cpu initfn.


What's the codepath by which tlb_flush gets called on
cpu reset? I had a quick look but couldn't find it...

(The other dubious-looking bit of flushing in the
target/alpha code is the code that generates calls
to tb_flush()... we have very few calls to tb_flush
outside the 'core' code and I suspect they could all
be avoided.)

thanks
-- PMM
