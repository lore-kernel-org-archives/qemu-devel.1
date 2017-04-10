Received: from eggs.gnu.org ([2001:4830:134:3::10]:37577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cxXjv-0002B1-PE
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 07:44:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cxXjs-0003jX-LM
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 07:44:11 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1491820793-5348-1-git-send-email-peter.maydell@linaro.org>
	<1491820793-5348-5-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c4534e1f-6dc5-e6da-92d3-a303e85e95bb@amsat.org>
Date: Mon, 10 Apr 2017 08:44:04 -0300
MIME-Version: 1.0
In-Reply-To: <1491820793-5348-5-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 4/7] arm: Move
 gen_set_condexec() and gen_set_pc_im() up in the file
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
> Move the utility routines gen_set_condexec() and gen_set_pc_im()
> up in the file, as we will want to use them from a function
> placed earlier in the file than their current location.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/arm/translate.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 870e320..a1a0e73 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -893,6 +893,21 @@ static const uint8_t table_logic_cc[16] = {
>      1, /* mvn */
>  };
>
> +static inline void gen_set_condexec(DisasContext *s)
> +{
> +    if (s->condexec_mask) {
> +        uint32_t val = (s->condexec_cond << 4) | (s->condexec_mask >> 1);
> +        TCGv_i32 tmp = tcg_temp_new_i32();
> +        tcg_gen_movi_i32(tmp, val);
> +        store_cpu_field(tmp, condexec_bits);
> +    }
> +}
> +
> +static inline void gen_set_pc_im(DisasContext *s, target_ulong val)
> +{
> +    tcg_gen_movi_i32(cpu_R[15], val);
> +}
> +
>  /* Set PC and Thumb state from an immediate address.  */
>  static inline void gen_bx_im(DisasContext *s, uint32_t addr)
>  {
> @@ -1069,11 +1084,6 @@ DO_GEN_ST(8, MO_UB)
>  DO_GEN_ST(16, MO_UW)
>  DO_GEN_ST(32, MO_UL)
>
> -static inline void gen_set_pc_im(DisasContext *s, target_ulong val)
> -{
> -    tcg_gen_movi_i32(cpu_R[15], val);
> -}
> -
>  static inline void gen_hvc(DisasContext *s, int imm16)
>  {
>      /* The pre HVC helper handles cases when HVC gets trapped
> @@ -1107,17 +1117,6 @@ static inline void gen_smc(DisasContext *s)
>      s->is_jmp = DISAS_SMC;
>  }
>
> -static inline void
> -gen_set_condexec (DisasContext *s)
> -{
> -    if (s->condexec_mask) {
> -        uint32_t val = (s->condexec_cond << 4) | (s->condexec_mask >> 1);
> -        TCGv_i32 tmp = tcg_temp_new_i32();
> -        tcg_gen_movi_i32(tmp, val);
> -        store_cpu_field(tmp, condexec_bits);
> -    }
> -}
> -
>  static void gen_exception_internal_insn(DisasContext *s, int offset, int excp)
>  {
>      gen_set_condexec(s);
>
