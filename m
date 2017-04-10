Received: from eggs.gnu.org ([2001:4830:134:3::10]:53361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cxeSq-000083-4U
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 14:55:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cxeSl-00015c-Fl
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 14:55:00 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1491844419-12485-1-git-send-email-peter.maydell@linaro.org>
	<1491844419-12485-7-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d8517799-0767-dd58-175b-f8908a94e598@amsat.org>
Date: Mon, 10 Apr 2017 15:54:50 -0300
MIME-Version: 1.0
In-Reply-To: <1491844419-12485-7-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 6/9] arm: Abstract out "are we
 singlestepping" test to utility function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>

On 04/10/2017 02:13 PM, Peter Maydell wrote:
> We now test for "are we singlestepping" in several places and
> it's not a trivial check because we need to care about both
> architectural singlestep and QEMU gdbstub singlestep. We're
> also about to add another place that needs to make this check,
> so pull the condition out into a function.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 87fd702..f28c4ca 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -309,6 +309,17 @@ static void gen_singlestep_exception(DisasContext *s)
>      }
>  }
>
> +static inline bool is_singlestepping(DisasContext *s)
> +{
> +    /* Return true if we are singlestepping either because of
> +     * architectural singlestep or QEMU gdbstub singlestep. This does
> +     * not include the command line '-singlestep' mode which is rather
> +     * misnamed as it only means "one instruction per TB" and doesn't
> +     * affect the code we generate.
> +     */

This comment is very welcome :)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +    return s->singlestep_enabled || s->ss_active;
> +}
> +
>  static void gen_smul_dual(TCGv_i32 a, TCGv_i32 b)
>  {
>      TCGv_i32 tmp1 = tcg_temp_new_i32();
> @@ -4104,7 +4115,7 @@ static inline void gen_goto_tb(DisasContext *s, int n, target_ulong dest)
>
>  static inline void gen_jmp (DisasContext *s, uint32_t dest)
>  {
> -    if (unlikely(s->singlestep_enabled || s->ss_active)) {
> +    if (unlikely(is_singlestepping(s))) {
>          /* An indirect jump so that we still trigger the debug exception.  */
>          if (s->thumb)
>              dest |= 1;
> @@ -11970,9 +11981,8 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
>              ((dc->pc >= next_page_start - 3) && insn_crosses_page(env, dc));
>
>      } while (!dc->is_jmp && !tcg_op_buf_full() &&
> -             !cs->singlestep_enabled &&
> +             !is_singlestepping(dc) &&
>               !singlestep &&
> -             !dc->ss_active &&
>               !end_of_page &&
>               num_insns < max_insns);
>
> @@ -11989,7 +11999,7 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
>         instruction was a conditional branch or trap, and the PC has
>         already been written.  */
>      gen_set_condexec(dc);
> -    if (unlikely(cs->singlestep_enabled || dc->ss_active)) {
> +    if (unlikely(is_singlestepping(dc))) {
>          /* Unconditional and "condition passed" instruction codepath. */
>          switch (dc->is_jmp) {
>          case DISAS_SWI:
> @@ -12067,7 +12077,7 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
>          /* "Condition failed" instruction codepath for the branch/trap insn */
>          gen_set_label(dc->condlabel);
>          gen_set_condexec(dc);
> -        if (unlikely(cs->singlestep_enabled || dc->ss_active)) {
> +        if (unlikely(is_singlestepping(dc))) {
>              gen_set_pc_im(dc, dc->pc);
>              gen_singlestep_exception(dc);
>          } else {
>
