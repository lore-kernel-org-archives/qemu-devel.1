Received: from eggs.gnu.org ([2001:4830:134:3::10]:40084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dSvJM-0006Pc-0H
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 21:10:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dSvJI-00088x-2C
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 21:10:27 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:51451)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dSvJH-00088V-NE
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 21:10:23 -0400
References: <20170706002401.10507-1-rth@twiddle.net>
	<20170706002401.10507-6-rth@twiddle.net>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e969146b-3061-e0ee-3e5c-e709c73abc11@vivier.eu>
Date: Thu, 6 Jul 2017 03:09:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170706002401.10507-6-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/11] linux-user/sh4: Notice gUSA regions
 during signal delivery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: bruno@clisp.org, aurelien@aurel32.net, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Le 06/07/2017 à 02:23, Richard Henderson a écrit :
> We translate gUSA regions atomically in a parallel context.
> But in a serial context a gUSA region may be interrupted.
> In that case, restart the region as the kernel would.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  linux-user/signal.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index 3d18d1b..1e716a9 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -3471,6 +3471,23 @@ static abi_ulong get_sigframe(struct target_sigaction *ka,
>      return (sp - frame_size) & -8ul;
>  }
>  
> +/* Notice when we're in the middle of a gUSA region and reset.
> +   Note that this will only occur for !parallel_cpus, as we will
> +   translate such sequences differently in a parallel context.  */
> +static void unwind_gusa(CPUSH4State *regs)
> +{
> +    /* If the stack pointer is sufficiently negative... */
> +    if ((regs->gregs[15] & 0xc0000000u) == 0xc0000000u) {
> +        /* Reset the PC to before the gUSA region, as computed from
> +           R0 = region end, SP = -(region size), plus one more insn
> +           that actually sets SP to the region size.  */
> +        regs->pc = regs->gregs[0] + regs->gregs[15] - 2;
> +
> +        /* Reset the SP to the saved version in R1.  */
> +        regs->gregs[15] = regs->gregs[1];
> +    }
> +}
> +
>  static void setup_sigcontext(struct target_sigcontext *sc,
>                               CPUSH4State *regs, unsigned long mask)
>  {
> @@ -3534,6 +3551,8 @@ static void setup_frame(int sig, struct target_sigaction *ka,
>      abi_ulong frame_addr;
>      int i;
>  
> +    unwind_gusa(regs);
> +
>      frame_addr = get_sigframe(ka, regs->gregs[15], sizeof(*frame));
>      trace_user_setup_frame(regs, frame_addr);
>      if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
> @@ -3583,6 +3602,8 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
>      abi_ulong frame_addr;
>      int i;
>  
> +    unwind_gusa(regs);
> +
>      frame_addr = get_sigframe(ka, regs->gregs[15], sizeof(*frame));
>      trace_user_setup_rt_frame(regs, frame_addr);
>      if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
