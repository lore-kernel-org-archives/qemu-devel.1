Received: from eggs.gnu.org ([2001:4830:134:3::10]:49337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fpdoo-0007p0-KO
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:13:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fpdoZ-00028t-EG
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:13:22 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:34382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fpdoY-00026o-VZ
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:13:07 -0400
Received: by mail-oi0-x243.google.com with SMTP id 13-v6so35369632ois.1
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 11:13:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180814165419.9116-1-rka@sysgo.com>
References: <20180814165419.9116-1-rka@sysgo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:12:45 +0100
Message-ID: <CAFEAcA8RQ2X83AQOcvg3acJhJ6ioJ7KtJ=V2iFiUmQh4bF_fmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: crash on conditional instr in
 it block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kapl <rka@sysgo.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 14 August 2018 at 17:54, Roman Kapl <rka@sysgo.com> wrote:
> If an instruction is conditional (like CBZ) and it is executed conditionally
> (using the ITx instruction), a jump to undefined label is generated.
>
> Fix the 'skip on condtion' code to create a new label only if it does not
> already exist. Previously multiple labels were created, but only the last one of
> them was set.

Hi; thanks for the bug report and the patch.

This case (CBZ inside an IT block) is architecturally UNPREDICTABLE,
but we certainly shouldn't crash QEMU.

For ARMv7 we have very wide latitude in what we can do; for ARMv8
the "CONSTRAINED UNPREDICTABLE" part of the Arm ARM limits us a
bit (see section K1.1.7). We can do one of:
 * generate an UNDEFINED exception
 * execute the instruction as if the condition code check had passed
 * execute the instruction as if the condition check failed (ie NOP)
(and we're allowed to behave differently from execution to execution
so "honour the condition code check" is ok too I think).

If we don't UNDEF then we have to be a little careful about the
IT state, but I think we're OK there.

So we could if we like choose to just UNDEF in these cases,
something like:
   if (dc->condexec_mask && thumb_insn_unpredictable_in_it(dc, insn) {
       gen_exception_insn(...)
   }
where we currently check for "always unconditional even in
an IT block" insns.

But I guess that just bringing conditional branches into line
with what we already do for other insns in this category is
a reasonable approach. I have a comment below but otherwise
the patch looks good.

>  target/arm/translate.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index f845da7c63..f7c03a36e6 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -8480,6 +8480,16 @@ static void gen_srs(DisasContext *s,
>      s->base.is_jmp = DISAS_UPDATE;
>  }
>
> +/* Skip this instruction if the condition is true */
> +static void arm_conditional_skip(DisasContext *s, uint32_t cond)
> +{
> +    if (!s->condjmp) {
> +        s->condlabel = gen_new_label();
> +        s->condjmp = 1;
> +    }
> +    arm_gen_test_cc(cond, s->condlabel);
> +}

This is a nice piece of refactoring. I think it would make
more sense to have it do "skip if condition is false", though:
currently every callsite has to xor the condition with 1.

(You could call it arm_skip_insn_unless(), maybe.)

> +
>  static void disas_arm_insn(DisasContext *s, unsigned int insn)
>  {
>      unsigned int cond, val, op1, i, shift, rm, rs, rn, rd, sh;
> @@ -8709,9 +8719,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>      if (cond != 0xe) {
>          /* if not always execute, we generate a conditional jump to
>             next instruction */
> -        s->condlabel = gen_new_label();
> -        arm_gen_test_cc(cond ^ 1, s->condlabel);
> -        s->condjmp = 1;
> +        arm_conditional_skip(s, cond ^ 1);
>      }
>      if ((insn & 0x0f900000) == 0x03000000) {
>          if ((insn & (1 << 21)) == 0) {
> @@ -11205,9 +11213,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
>                  /* Conditional branch.  */
>                  op = (insn >> 22) & 0xf;
>                  /* Generate a conditional jump to next instruction.  */
> -                s->condlabel = gen_new_label();
> -                arm_gen_test_cc(op ^ 1, s->condlabel);
> -                s->condjmp = 1;
> +                arm_conditional_skip(s, op ^ 1);
>
>                  /* offset[11:1] = insn[10:0] */
>                  offset = (insn & 0x7ff) << 1;
> @@ -12131,8 +12137,10 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
>          case 1: case 3: case 9: case 11: /* czb */
>              rm = insn & 7;
>              tmp = load_reg(s, rm);
> -            s->condlabel = gen_new_label();
> -            s->condjmp = 1;
> +            if (!s->condjmp) {
> +                s->condlabel = gen_new_label();
> +                s->condjmp = 1;
> +            }
>              if (insn & (1 << 11))
>                  tcg_gen_brcondi_i32(TCG_COND_EQ, tmp, 0, s->condlabel);
>              else
> @@ -12295,9 +12303,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
>              break;
>          }
>          /* generate a conditional jump to next instruction */
> -        s->condlabel = gen_new_label();
> -        arm_gen_test_cc(cond ^ 1, s->condlabel);
> -        s->condjmp = 1;
> +        arm_conditional_skip(s, cond ^ 1);
>
>          /* jump to the offset */
>          val = (uint32_t)s->pc + 2;
> @@ -12676,9 +12682,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>          uint32_t cond = dc->condexec_cond;
>
>          if (cond != 0x0e) {     /* Skip conditional when condition is AL. */
> -            dc->condlabel = gen_new_label();
> -            arm_gen_test_cc(cond ^ 1, dc->condlabel);
> -            dc->condjmp = 1;
> +            arm_conditional_skip(dc, cond ^ 1);
>          }
>      }
>
> --

thanks
-- PMM
