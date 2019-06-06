Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D257BC28D1E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 09:54:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A62192083E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 09:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A62192083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57481 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYp6d-00034K-09
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 05:54:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1hYp5a-0002U1-Px
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 05:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1hYp5Z-0005rm-Nb
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 05:53:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40928
	helo=foss.arm.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>)
	id 1hYp5X-0005is-5M; Thu, 06 Jun 2019 05:53:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16D86341;
	Thu,  6 Jun 2019 02:53:37 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.72.51.249])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05A823F690;
	Thu,  6 Jun 2019 02:53:35 -0700 (PDT)
Date: Thu, 6 Jun 2019 10:53:33 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
	g@e103592.cambridge.arm.com
Message-ID: <20190606095333.GZ28398@e103592.cambridge.arm.com>
References: <20190605205706.569-1-richard.henderson@linaro.org>
	<20190605205706.569-2-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605205706.569-2-richard.henderson@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.140.101.70
Subject: Re: [Qemu-devel] [PATCH v6 1/6] linux-user/aarch64: Reset btype for
 syscalls and signalsy
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 05, 2019 at 09:57:01PM +0100, Richard Henderson wrote:
> The value of btype for syscalls is CONSTRAINED UNPREDICTABLE,
> so we need to make sure that the value is 0 before clone,
> fork, or syscall return.
> 
> The kernel sets btype for the signal handler as if for a call.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/cpu_loop.c |  7 +++++++
>  linux-user/aarch64/signal.c   | 10 ++++++++--
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
> index 2f2f63e3e8..1f68b13168 100644
> --- a/linux-user/aarch64/cpu_loop.c
> +++ b/linux-user/aarch64/cpu_loop.c
> @@ -86,6 +86,13 @@ void cpu_loop(CPUARMState *env)
>  
>          switch (trapnr) {
>          case EXCP_SWI:
> +            /*
> +             * The state of BTYPE on syscall entry is CONSTRAINED
> +             * UNPREDICTABLE.  The real kernel will need to tidy this up
> +             * as well.  Do this before syscalls so that the value is
> +             * correct on return from syscall (especially clone & fork).
> +             */
> +            env->btype = 0;

Note, after discussion with the architects, I think Linux won't bother
sanitising this field in my next spin of the patches.

If the SVC (or HVC or SMC) sits in a PROT_BTI page, then it won't
execute anyway unless BTYPE is already 0: otherwise, a branch target
exception would be taken instead.

If the insn isn't in a PROT_BTI page, then BTYPE could be nonzero when
the SVC (etc.) exception is taken, but it also won't matter in that case
what BTYPE is on return, since branch target exceptions are never
generated on insns in non-guarded pages.

For this to make a difference:

 a) the SVC be in a non-PROT_BTI page, just before a page boundary,
    where the next page is a PROT_BTI page, so that the exception return
    goes to the next page.

 b) the SVC must be an mprotect() call or similar that enabled PROT_BTI
    for the patch containing the SVC itself.

These are both silly things to do, and we probably don't care what
happens in such cases.

(Question: does qemu ever mprotect() the page containing PC?  I'd hope
not...)

>              ret = do_syscall(env,
>                               env->xregs[8],
>                               env->xregs[0],
> diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
> index f84a9cf28a..5605d404b3 100644
> --- a/linux-user/aarch64/signal.c
> +++ b/linux-user/aarch64/signal.c
> @@ -506,10 +506,16 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
>              + offsetof(struct target_rt_frame_record, tramp);
>      }
>      env->xregs[0] = usig;
> -    env->xregs[31] = frame_addr;
>      env->xregs[29] = frame_addr + fr_ofs;
> -    env->pc = ka->_sa_handler;
>      env->xregs[30] = return_addr;
> +    env->xregs[31] = frame_addr;
> +    env->pc = ka->_sa_handler;
> +
> +    /* Invoke the signal handler as if by indirect call.  */
> +    if (cpu_isar_feature(aa64_bti, arm_env_get_cpu(env))) {
> +        env->btype = 2;
> +    }
> +

Ack.  I had a simple test for this for native userspace, and it seems to
work as desired -- so I don't expect to change it.

Cheers
---Dave

