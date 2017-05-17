Received: from eggs.gnu.org ([2001:4830:134:3::10]:55343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAnP9-0006xa-Vy
	for qemu-devel@nongnu.org; Tue, 16 May 2017 21:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAnP6-0000Sr-23
	for qemu-devel@nongnu.org; Tue, 16 May 2017 21:05:31 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAnP5-0000Sh-UK
	for qemu-devel@nongnu.org; Tue, 16 May 2017 21:05:27 -0400
Received: by mail-qk0-x243.google.com with SMTP id y128so25233958qka.3
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 18:05:27 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170516224721.13832-1-aurelien@aurel32.net>
	<20170516224721.13832-5-aurelien@aurel32.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <20e55fd3-4fb1-01f4-e593-0642f6f60f88@amsat.org>
Date: Tue, 16 May 2017 22:05:24 -0300
MIME-Version: 1.0
In-Reply-To: <20170516224721.13832-5-aurelien@aurel32.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/5] target/sh4: ignore interrupts in a
 delay slot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 05/16/2017 07:47 PM, Aurelien Jarno wrote:
> Delay slots are indivisible, therefore avoid scheduling an interrupt in
> the delay slot. However exceptions are possible.
>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/sh4/helper.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/target/sh4/helper.c b/target/sh4/helper.c
> index d420931530..19d4ec5fb5 100644
> --- a/target/sh4/helper.c
> +++ b/target/sh4/helper.c
> @@ -871,8 +871,16 @@ int cpu_sh4_is_cached(CPUSH4State * env, target_ulong addr)
>  bool superh_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>  {
>      if (interrupt_request & CPU_INTERRUPT_HARD) {
> -        superh_cpu_do_interrupt(cs);
> -        return true;
> +        SuperHCPU *cpu = SUPERH_CPU(cs);
> +        CPUSH4State *env = &cpu->env;
> +
> +        /* Delay slots are indivisible, ignore interrupts */
> +        if (env->flags & DELAY_SLOT_MASK) {
> +            return false;
> +        } else {
> +            superh_cpu_do_interrupt(cs);
> +            return true;
> +        }
>      }
>      return false;
>  }
>
