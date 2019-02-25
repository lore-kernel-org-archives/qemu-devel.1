Received: from eggs.gnu.org ([209.51.188.92]:45325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyCHx-0004uN-Qw
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 04:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyCHx-0006Km-15
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 04:11:05 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gyCHw-0006Gx-Kz
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 04:11:04 -0500
Received: by mail-ot1-x343.google.com with SMTP id b3so7208477otp.4
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 01:11:03 -0800 (PST)
MIME-Version: 1.0
References: <1550076626-7202-1-git-send-email-sandra@codesourcery.com>
In-Reply-To: <1550076626-7202-1-git-send-email-sandra@codesourcery.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Feb 2019 09:10:48 +0000
Message-ID: <CAFEAcA8YQm940GGF3fT7ZeOOrg_cn8JVrbi=TzbbLiABstOPZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Fix breakpoint support in Nios II
 user-mode emulation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sandra Loosemore <sandra@codesourcery.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On Wed, 13 Feb 2019 at 17:19, Sandra Loosemore <sandra@codesourcery.com> wrote:
>
> Nios II user-mode emulation was missing handling for EXCP_DEBUG,
> making the gdb stub essentially useless.  This patch adds the missing
> piece.  The new code was copied from the existing EXCP_TRAP handling
> and is also similar to what other targets (e.g., arm) do with EXCP_DEBUG.
>
> Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
> ---
>  linux-user/nios2/cpu_loop.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/linux-user/nios2/cpu_loop.c b/linux-user/nios2/cpu_loop.c
> index b96b1aa..5aa1eca 100644
> --- a/linux-user/nios2/cpu_loop.c
> +++ b/linux-user/nios2/cpu_loop.c
> @@ -73,6 +73,12 @@ void cpu_loop(CPUNios2State *env)
>                  queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
>                  break;
>              }
> +        case EXCP_DEBUG:
> +            info.si_signo = TARGET_SIGTRAP;
> +            info.si_errno = 0;
> +            info.si_code = TARGET_TRAP_BRKPT;
> +            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
> +            break;
>          case 0xaa:
>              switch (env->regs[R_PC]) {
>              /*case 0x1000:*/  /* TODO:__kuser_helper_version */

I don't know NiosII at all, but a quick check of the kernel
sources suggests this is correct, so

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
