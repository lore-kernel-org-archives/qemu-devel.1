Received: from eggs.gnu.org ([2001:4830:134:3::10]:51336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gMeiN-0007XK-0b
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 14:51:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gMeYk-0006wV-WD
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 14:41:18 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:43091)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gMeYk-0006wD-N7
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 14:41:14 -0500
Received: by mail-yb1-f195.google.com with SMTP id h187-v6so5877844ybg.10
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 11:41:14 -0800 (PST)
MIME-Version: 1.0
References: <20181113193510.24862-1-richard.henderson@linaro.org>
In-Reply-To: <20181113193510.24862-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 13 Nov 2018 20:41:01 +0100
Message-ID: <CAAdtpL49Es9_GqG2RdrR8n36Vbo7iShvzvGqeYPR1qT_=XWCwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/i386: Generate #UD when applying
 LOCK to a register destination
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Tue, Nov 13, 2018 at 8:36 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Fixes a TCG crash due to attempting the atomic operation without
> having set up the address first.  This does not attempt to fix
> all of the other missing checks for LOCK.
>
> Fixes: a7cee522f35
> Fixes: https://bugs.launchpad.net/qemu/+bug/1803160
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  target/i386/translate.c | 35 ++++++++++++++++++++---------------
>  1 file changed, 20 insertions(+), 15 deletions(-)
>
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index f8bc7680af..0dd5fbe45c 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -1268,10 +1268,30 @@ static void gen_helper_fp_arith_STN_ST0(int op, i=
nt opreg)
>      }
>  }
>
> +static void gen_exception(DisasContext *s, int trapno, target_ulong cur_=
eip)
> +{
> +    gen_update_cc_op(s);
> +    gen_jmp_im(s, cur_eip);
> +    gen_helper_raise_exception(cpu_env, tcg_const_i32(trapno));
> +    s->base.is_jmp =3D DISAS_NORETURN;
> +}
> +
> +/* Generate #UD for the current instruction.  The assumption here is tha=
t
> +   the instruction is known, but it isn't allowed in the current cpu mod=
e.  */
> +static void gen_illegal_opcode(DisasContext *s)
> +{
> +    gen_exception(s, EXCP06_ILLOP, s->pc_start - s->cs_base);
> +}
> +
>  /* if d =3D=3D OR_TMP0, it means memory operand (address in A0) */
>  static void gen_op(DisasContext *s1, int op, TCGMemOp ot, int d)
>  {
>      if (d !=3D OR_TMP0) {
> +        if (s1->prefix & PREFIX_LOCK) {
> +            /* Lock prefix when destination is not memory.  */
> +            gen_illegal_opcode(s1);
> +            return;
> +        }
>          gen_op_mov_v_reg(s1, ot, s1->T0, d);
>      } else if (!(s1->prefix & PREFIX_LOCK)) {
>          gen_op_ld_v(s1, ot, s1->T0, s1->A0);
> @@ -2469,21 +2489,6 @@ static void gen_leave(DisasContext *s)
>      gen_op_mov_reg_v(s, a_ot, R_ESP, s->T1);
>  }
>
> -static void gen_exception(DisasContext *s, int trapno, target_ulong cur_=
eip)
> -{
> -    gen_update_cc_op(s);
> -    gen_jmp_im(s, cur_eip);
> -    gen_helper_raise_exception(cpu_env, tcg_const_i32(trapno));
> -    s->base.is_jmp =3D DISAS_NORETURN;
> -}
> -
> -/* Generate #UD for the current instruction.  The assumption here is tha=
t
> -   the instruction is known, but it isn't allowed in the current cpu mod=
e.  */
> -static void gen_illegal_opcode(DisasContext *s)
> -{
> -    gen_exception(s, EXCP06_ILLOP, s->pc_start - s->cs_base);
> -}
> -
>  /* Similarly, except that the assumption here is that we don't decode
>     the instruction at all -- either a missing opcode, an unimplemented
>     feature, or just a bogus instruction stream.  */
> --
> 2.17.2
>
