Received: from eggs.gnu.org ([208.118.235.92]:53712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfSHo-00057V-U6
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:25:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfSHo-0002AB-7V
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:25:28 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:40367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gfSHm-0001yM-BT
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:25:28 -0500
Received: by mail-oi1-x241.google.com with SMTP id t204so30765136oie.7
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 08:25:24 -0800 (PST)
MIME-Version: 1.0
References: <20181214052410.11863-1-richard.henderson@linaro.org>
	<20181214052410.11863-5-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jan 2019 16:25:12 +0000
Message-ID: <CAFEAcA8r+Zt3rZWnHa+-uj25OtB9i6UoCXVqNHBsr_88JVfRuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 04/27] target/arm: Add PAuth helpers
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

On Fri, 14 Dec 2018 at 05:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The cryptographic internals are stubbed out for now,
> but the enable and trap bits are checked.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ----

> +static void QEMU_NORETURN pauth_trap(CPUARMState *env, int target_el,
> +                                     uintptr_t ra)
> +{
> +    CPUState *cs = ENV_GET_CPU(env);
> +
> +    cs->exception_index = EXCP_UDEF;
> +    env->exception.syndrome = syn_pactrap();
> +    env->exception.target_el = target_el;
> +    cpu_loop_exit_restore(cs, ra);

This should use raise_exception(), or some variant on it that
lets you pass in the ra, because otherwise you lose the
"redirect EL1 exceptions to EL2" HCR.TGE behaviour.
Or can we only ever call this for a target_el of 2 or 3?

It might be cleaner to have a raise_exception_ra() anyway,
to preserve the "all exception throwing goes through here" rule.

> +}

thanks
-- PMM
