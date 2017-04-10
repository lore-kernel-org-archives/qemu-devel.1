Received: from eggs.gnu.org ([2001:4830:134:3::10]:37287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cxXiz-0001aI-Gb
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 07:43:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cxXiw-0003LN-EK
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 07:43:13 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1491820793-5348-1-git-send-email-peter.maydell@linaro.org>
	<1491820793-5348-4-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c05b13b4-9ffe-318c-6ee6-04e1630ab92d@amsat.org>
Date: Mon, 10 Apr 2017 08:43:05 -0300
MIME-Version: 1.0
In-Reply-To: <1491820793-5348-4-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 3/7] arm: Factor out "generate
 right kind of step exception"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, patches@linaro.org

On 04/10/2017 07:39 AM, Peter Maydell wrote:
> We currently have two places that do:
>             if (dc->ss_active) {
>                 gen_step_complete_exception(dc);
>             } else {
>                 gen_exception_internal(EXCP_DEBUG);
>             }
>
> Factor this out into its own function, as we're about to add
> a third place that needs the same logic.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/arm/translate.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index ddc62b6..870e320 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -296,6 +296,19 @@ static void gen_step_complete_exception(DisasContext *s)
>      s->is_jmp = DISAS_EXC;
>  }
>
> +static void gen_singlestep_exception(DisasContext *s)
> +{
> +    /* Generate the right kind of exception for singlestep, which is
> +     * either the architectural singlestep or EXCP_DEBUG for QEMU's
> +     * gdb singlestepping.
> +     */
> +    if (s->ss_active) {
> +        gen_step_complete_exception(s);
> +    } else {
> +        gen_exception_internal(EXCP_DEBUG);
> +    }
> +}
> +
>  static void gen_smul_dual(TCGv_i32 a, TCGv_i32 b)
>  {
>      TCGv_i32 tmp1 = tcg_temp_new_i32();
> @@ -11998,24 +12011,15 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
>              gen_set_pc_im(dc, dc->pc);
>              /* fall through */
>          default:
> -            if (dc->ss_active) {
> -                gen_step_complete_exception(dc);
> -            } else {
> -                /* FIXME: Single stepping a WFI insn will not halt
> -                   the CPU.  */
> -                gen_exception_internal(EXCP_DEBUG);
> -            }
> +            /* FIXME: Single stepping a WFI insn will not halt the CPU. */
> +            gen_singlestep_exception(dc);
>          }
>          if (dc->condjmp) {
>              /* "Condition failed" instruction codepath. */
>              gen_set_label(dc->condlabel);
>              gen_set_condexec(dc);
>              gen_set_pc_im(dc, dc->pc);
> -            if (dc->ss_active) {
> -                gen_step_complete_exception(dc);
> -            } else {
> -                gen_exception_internal(EXCP_DEBUG);
> -            }
> +            gen_singlestep_exception(dc);
>          }
>      } else {
>          /* While branches must always occur at the end of an IT block,
>
