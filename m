Received: from eggs.gnu.org ([2001:4830:134:3::10]:42992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPhTF-0003FG-0i
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 23:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPhTE-0008Fn-4o
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 23:47:21 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
	<149838651980.6497.760840816251179741.stgit@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a87f52f9-8afc-a4ee-5f65-682dcbc2f08a@twiddle.net>
Date: Mon, 26 Jun 2017 20:47:10 -0700
MIME-Version: 1.0
In-Reply-To: <149838651980.6497.760840816251179741.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v9 26/26] target: [tcg,
 arm] Port to generic translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 06/25/2017 03:28 AM, Lluís Vilanova wrote:
> +static TranslatorOps aarch64_translator_ops = {
> +    .init_disas_context = aarch64_trblock_init_disas_context,
> +    .insn_start = aarch64_trblock_insn_start,
> +    .breakpoint_check = aarch64_trblock_breakpoint_check,
> +    .disas_insn = aarch64_trblock_disas_insn,
> +    .tb_stop = aarch64_trblock_tb_stop,
> +    .disas_flags = aarch64_trblock_disas_flags,
> +};

const.

> +void gen_intermediate_code_a64(DisasContextBase *db, CPUState *cpu,
>                                  TranslationBlock *tb)
>   {
> +    translate_block(&aarch64_translator_ops, db, cpu, &cpu_env, tb);
>   }
...
>   /* generate intermediate code for basic block 'tb'.  */
>   void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
>   {
>       DisasContext dc1, *dc = &dc1;
>       DisasContextBase *db = &dc->base;
>   
>       /* generate intermediate code */
>   
> @@ -12202,97 +12214,11 @@ void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
>        * the A32/T32 complexity to do with conditional execution/IT blocks/etc.
>        */
>       if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
> +        gen_intermediate_code_a64(db, cpu, tb);
>           return;
> +    } else {
> +        translate_block(&arm_translator_ops, db, cpu, &cpu_env, tb);
>       }

There's really no point in keeping gen_intermediate_code_a64 is there.

This is better written as

   translate_block((ARM_TBFLAG_AARCH64_STATE(tb->flags)
                    ? &aarch64_translator_ops
                    : &arm_translator_ops),
                   &dc->base, cpu, tb);


r~
