Received: from eggs.gnu.org ([2001:4830:134:3::10]:39035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gMEpd-0000gA-5x
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:12:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gMEpa-0002CU-0s
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:12:57 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:60355)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gMEpZ-0002BY-Ls
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:12:53 -0500
References: <20181019174958.26616-1-peter.maydell@linaro.org>
	<20181019174958.26616-3-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <592c1ffc-fc4b-580f-91d8-cfc9131c783b@vivier.eu>
Date: Mon, 12 Nov 2018 17:12:09 +0100
MIME-Version: 1.0
In-Reply-To: <20181019174958.26616-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] linux-user: Clean up nios2 main loop
 signal handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marek Vasut <marex@denx.de>, Riku Voipio <riku.voipio@iki.fi>, Chris Wulff <crwulff@gmail.com>, patches@linaro.org

On 19/10/2018 19:49, Peter Maydell wrote:
> The nios2 main loop code's code does some odd
> things with gdb_handlesig() that no other target
> CPU does: it has some signals that are delivered
> to gdb and only to gdb. Stop doing this, and instead
> behave like all the other targets:
>  * a trap instruction becomes a SIGTRAP
>  * an unhandled exception type returned from cpu_exec()
>    causes us to abort(), not to try to hand gdb a SIGILL
> 
> This fixes in passing Coverity issue CID 1390853,
> which was a complaint that the old code failed to
> check the return value from gdb_handlesig().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Disclaimer: compile tested, and the change makes conceptual
> sense, but I have no nios2 test environment.

I'll push a slightly modified version of this patch: gdbsig is now
unused and my compiler complains about that.

Thanks,
Laurent

> ---
>  linux-user/nios2/cpu_loop.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/linux-user/nios2/cpu_loop.c b/linux-user/nios2/cpu_loop.c
> index dac7a061813..973dd54d791 100644
> --- a/linux-user/nios2/cpu_loop.c
> +++ b/linux-user/nios2/cpu_loop.c
> @@ -68,7 +68,10 @@ void cpu_loop(CPUNios2State *env)
>                  env->regs[R_EA] = env->regs[R_PC] + 4;
>                  env->regs[R_PC] = cpu->exception_addr;
>  
> -                gdbsig = TARGET_SIGTRAP;
> +                info.si_signo = TARGET_SIGTRAP;
> +                info.si_errno = 0;
> +                info.si_code = TARGET_TRAP_BRKPT;
> +                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
>                  break;
>              }
>          case 0xaa:
> @@ -106,14 +109,7 @@ kuser_fail:
>          default:
>              EXCP_DUMP(env, "\nqemu: unhandled CPU exception %#x - aborting\n",
>                       trapnr);
> -            gdbsig = TARGET_SIGILL;
> -            break;
> -        }
> -        if (gdbsig) {
> -            gdb_handlesig(cs, gdbsig);
> -            if (gdbsig != TARGET_SIGTRAP) {
> -                exit(EXIT_FAILURE);
> -            }
> +            abort();
>          }
>  
>          process_pending_signals(env);
> 
