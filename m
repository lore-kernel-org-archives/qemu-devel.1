Received: from eggs.gnu.org ([209.51.188.92]:56688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLROe-0002Kj-6q
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:58:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLRGo-0007AK-5V
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:49:59 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLRGn-000791-Ut
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:49:58 -0400
Received: by mail-ot1-x342.google.com with SMTP id s11so7279368otp.0
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 04:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-8-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 12:49:46 +0100
Message-ID: <CAFEAcA-_OG6DKJCVqYahNOo_oMoiWSq0Tb7+dQhOGh3jFg01=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 07/26] target/i386: Convert to
 CPUClass::tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, 3 Apr 2019 at 04:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We do not support probing, but we do not need it yet either.
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


> +    env->retaddr = retaddr;
> +    if (handle_mmu_fault(cs, addr, size, access_type, mmu_idx)) {
> +        /* FIXME: On error in get_hphys we have already jumpped out.  */

"jumped"

> +        g_assert(!probe);

> --- a/target/i386/mem_helper.c
> +++ b/target/i386/mem_helper.c
> @@ -191,24 +191,3 @@ void helper_boundl(CPUX86State *env, target_ulong a0, int v)
>          raise_exception_ra(env, EXCP05_BOUND, GETPC());
>      }
>  }
> -
> -#if !defined(CONFIG_USER_ONLY)
> -/* try to fill the TLB and return an exception if error. If retaddr is
> - * NULL, it means that the function was called in C code (i.e. not
> - * from generated code or from helper.c)
> - */
> -/* XXX: fix it to restore all registers */

Is this XXX comment definitely stale ?

> -void tlb_fill(CPUState *cs, target_ulong addr, int size,
> -              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
> -{
> -    X86CPU *cpu = X86_CPU(cs);
> -    CPUX86State *env = &cpu->env;
> -    int ret;
> -
> -    env->retaddr = retaddr;
> -    ret = x86_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
> -    if (ret) {
> -        raise_exception_err_ra(env, cs->exception_index, env->error_code, retaddr);
> -    }
> -}

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
