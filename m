Received: from eggs.gnu.org ([2001:4830:134:3::10]:45798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1exhdv-00088D-1I
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 19:23:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1exhdq-0003im-9v
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 19:23:11 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:39616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1exhdq-0003ie-2g
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 19:23:06 -0400
Received: by mail-wr0-x243.google.com with SMTP id c24so4974945wrc.6
	for <qemu-devel@nongnu.org>; Sun, 18 Mar 2018 16:23:06 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180316155340.25734-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <51dfa8a4-8d95-c2b4-2d1c-5560d6774adb@amsat.org>
Date: Mon, 19 Mar 2018 00:23:03 +0100
MIME-Version: 1.0
In-Reply-To: <20180316155340.25734-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg: fix cpu_io_recompile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Pavel.Dovgaluk@ispras.ru, pbonzini@redhat.com

On 03/16/2018 04:53 PM, Richard Henderson wrote:
> We have confused the number of instructions that have been
> executed in the TB with the number of instructions needed
> to repeat the I/O instruction.
> 
> We have used cpu_restore_state_from_tb, which means that
> the guest pc is pointing to the I/O instruction.  The only
> time the answer to the later question is not 1 is when
> MIPS or SH4 need to re-execute the branch for the delay
> slot as well.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  accel/tcg/translate-all.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 67795cd78c..d4190602d1 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1736,37 +1736,32 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
>          cpu_abort(cpu, "cpu_io_recompile: could not find TB for pc=%p",
>                    (void *)retaddr);
>      }
> -    n = cpu->icount_decr.u16.low + tb->icount;
>      cpu_restore_state_from_tb(cpu, tb, retaddr);
> -    /* Calculate how many instructions had been executed before the fault
> -       occurred.  */
> -    n = n - cpu->icount_decr.u16.low;
> -    /* Generate a new TB ending on the I/O insn.  */
> -    n++;
> +
>      /* On MIPS and SH, delay slot instructions can only be restarted if
>         they were already the first instruction in the TB.  If this is not
>         the first instruction in a TB then re-execute the preceding
>         branch.  */
> +    n = 1;
>  #if defined(TARGET_MIPS)
> -    if ((env->hflags & MIPS_HFLAG_BMASK) != 0 && n > 1) {
> +    if ((env->hflags & MIPS_HFLAG_BMASK) != 0
> +        && env->active_tc.PC != tb->pc) {
>          env->active_tc.PC -= (env->hflags & MIPS_HFLAG_B16 ? 2 : 4);
>          cpu->icount_decr.u16.low++;
>          env->hflags &= ~MIPS_HFLAG_BMASK;
> +        n = 2;
>      }
>  #elif defined(TARGET_SH4)
>      if ((env->flags & ((DELAY_SLOT | DELAY_SLOT_CONDITIONAL))) != 0
> -            && n > 1) {
> +        && env->pc != tb->pc) {
>          env->pc -= 2;
>          cpu->icount_decr.u16.low++;
>          env->flags &= ~(DELAY_SLOT | DELAY_SLOT_CONDITIONAL);
> +        n = 2;
>      }
>  #endif
> -    /* This should never happen.  */
> -    if (n > CF_COUNT_MASK) {
> -        cpu_abort(cpu, "TB too big during recompile");
> -    }
>  
> -    /* Adjust the execution state of the next TB.  */
> +    /* Generate a new TB executing the I/O insn.  */
>      cpu->cflags_next_tb = curr_cflags() | CF_LAST_IO | n;
>  
>      if (tb->cflags & CF_NOCACHE) {
> 
