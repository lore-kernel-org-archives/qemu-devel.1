Received: from eggs.gnu.org ([2001:4830:134:3::10]:37495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dWW2E-0005Vb-Ib
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 18:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dWW2D-0000M5-Ht
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 18:59:38 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:49448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dWW2D-0000KC-Bv
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 18:59:37 -0400
Date: Sun, 16 Jul 2017 00:59:34 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170715225934.lap5cnukiyotqrqs@aurel32.net>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-10-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170707022111.21836-10-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 09/27] linux-user/sh4: Clean env->flags
 on signal boundaries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

On 2017-07-06 16:20, Richard Henderson wrote:
> If a signal is delivered during the execution of a delay slot,
> or a gUSA region, clear those bits from the environment so that
> the signal handler does not start in that same state.

How are signals delivered in linux-user? At least in system mode we
forbid interrupts in the delay slot (see commit 5c6f3eb7db), as the
manual clearly declare them as indivisible. Maybe the same should be
done for linux-user?

> 
> Cleaning the bits on signal return is paranoid good sense.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  linux-user/signal.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index a537778..8c0b851 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -3544,6 +3544,7 @@ static void restore_sigcontext(CPUSH4State *regs, struct target_sigcontext *sc)
>      __get_user(regs->fpul, &sc->sc_fpul);
>  
>      regs->tra = -1;         /* disable syscall checks */
> +    regs->flags &= ~(DELAY_SLOT_MASK | GUSA_MASK);
>  }
>  
>  static void setup_frame(int sig, struct target_sigaction *ka,

Why not using TB_FLAG_ENVFLAGS_MASK introduced earlier in this patch
series?

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
