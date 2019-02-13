Received: from eggs.gnu.org ([209.51.188.92]:42377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gu1Qm-0006Za-KL
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 15:46:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gu1Qk-0003Ey-Uc
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 15:46:56 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:59095)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gu1Qj-00036I-Gd
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 15:46:54 -0500
References: <1550076626-7202-1-git-send-email-sandra@codesourcery.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a48ece75-537d-72e9-8851-bc7a801f77af@vivier.eu>
Date: Wed, 13 Feb 2019 21:46:29 +0100
MIME-Version: 1.0
In-Reply-To: <1550076626-7202-1-git-send-email-sandra@codesourcery.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Sandra Loosemore <sandra@codesourcery.com>, qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>

CC'ing NiosII Maintainers

On 13/02/2019 17:50, Sandra Loosemore wrote:
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
> 
