Received: from eggs.gnu.org ([2001:4830:134:3::10]:46346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1dKdkj-0000l0-S0
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 00:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1dKdkf-0004b5-UU
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 00:48:29 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1dKdkf-0004ar-Ny
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 00:48:25 -0400
Received: by mail-wr0-f193.google.com with SMTP id g76so26392269wrd.2
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 21:48:23 -0700 (PDT)
References: <20170611231633.32582-1-laurent@vivier.eu>
	<20170611231633.32582-6-laurent@vivier.eu>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <221c6711-d46f-2fcf-6091-f1f3340664f7@tuxfamily.org>
Date: Tue, 13 Jun 2017 06:48:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170611231633.32582-6-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 5/7] target-m68k: use floatx80 internally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

On 12.06.2017 01:16, Laurent Vivier wrote:
> Coldfire uses float64, but 680x0 use floatx80.
> This patch introduces the use of floatx80 internally
> and enables 680x0 80bits FPU.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/cpu.c        |   9 +-
>  target/m68k/cpu.h        |   6 +-
>  target/m68k/fpu_helper.c |  85 +++----
>  target/m68k/helper.c     |  12 +-
>  target/m68k/helper.h     |  37 +--
>  target/m68k/qregs.def    |   1 -
>  target/m68k/translate.c  | 568 +++++++++++++++++++++++++++++++----------------
>  7 files changed, 464 insertions(+), 254 deletions(-)
> 
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index f068922..435456f 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -49,6 +49,8 @@ static void m68k_cpu_reset(CPUState *s)
>      M68kCPU *cpu = M68K_CPU(s);
>      M68kCPUClass *mcc = M68K_CPU_GET_CLASS(cpu);
>      CPUM68KState *env = &cpu->env;
> +    floatx80 nan = floatx80_default_nan(NULL);
> +    int i;
>  
>      mcc->parent_reset(s);
>  
> @@ -57,7 +59,12 @@ static void m68k_cpu_reset(CPUState *s)
>      env->sr = 0x2700;
>  #endif
>      m68k_switch_sp(env);
> -    /* ??? FP regs should be initialized to NaN.  */
> +    for (i = 0; i < 8; i++) {
> +        env->fregs[i].d = nan;
> +    }
> +    env->fpcr = 0;
> +    env->fpsr = 0;
> +

Maybe move such non-related hunks to a separate patch? This patch here
is already big enough...

 Thomas
