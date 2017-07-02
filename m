Received: from eggs.gnu.org ([2001:4830:134:3::10]:59385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRTmN-00076u-If
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 21:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRTmM-0007cf-IV
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 21:34:27 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865776960.17063.4875279139522061160.stgit@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <2bfdb883-f19b-7fcf-c28b-7ce39115937e@twiddle.net>
Date: Sat, 1 Jul 2017 18:34:17 -0700
MIME-Version: 1.0
In-Reply-To: <149865776960.17063.4875279139522061160.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v11 23/29] target/arm: [tcg] Port to
 translate_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>, "open list:ARM" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 06/28/2017 06:49 AM, Lluís Vilanova wrote:
> +        /* We want to stop the TB if the next insn starts in a new page,
> +         * or if it spans between this page and the next. This means that
> +         * if we're looking at the last halfword in the page we need to
> +         * see if it's a 16-bit Thumb insn (which will fit in this TB)
> +         * or a 32-bit Thumb insn (which won't).
> +         * This is to avoid generating a silly TB with a single 16-bit insn
> +         * in it at the end of this page (which would execute correctly
> +         * but isn't very efficient).
> +         */
> +        return DISAS_PAGE_CROSS;

Any reason to introduce a new name as opposed to TOO_MANY?  As far as I can 
tell they're the same....


> +    if (dc->ss_active && !dc->pstate_ss) {
> +        /* Singlestep state is Active-pending.
> +         * If we're in this state at the start of a TB then either
> +         *  a) we just took an exception to an EL which is being debugged
> +         *     and this is the first insn in the exception handler
> +         *  b) debug exceptions were masked and we just unmasked them
> +         *     without changing EL (eg by clearing PSTATE.D)
> +         * In either case we're going to take a swstep exception in the
> +         * "did not step an insn" case, and so the syndrome ISV and EX
> +         * bits should be zero.
> +         */
> +        assert(dc->base.num_insns == 1);
> +        gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
> +                      default_exception_el(dc));
> +        dc->base.is_jmp = DISAS_SKIP;

This is surely DISAS_EXC -- see gen_step_complete_exception.
Why introduce a new name?


r~
