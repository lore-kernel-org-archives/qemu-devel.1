Received: from eggs.gnu.org ([2001:4830:134:3::10]:45529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTla6-0007fB-Vo
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:36:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTla3-0005Ko-S1
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:36:02 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gTla3-0005Gy-M7
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:35:59 -0500
Received: by mail-wm1-x342.google.com with SMTP id r24so6627356wmh.0
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 02:35:59 -0800 (PST)
References: <20181130215221.20554-1-richard.henderson@linaro.org>
	<20181130215221.20554-8-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181130215221.20554-8-richard.henderson@linaro.org>
Date: Mon, 03 Dec 2018 10:35:57 +0000
Message-ID: <877egq5242.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 07/16] tcg/ppc: Fold away "noaddr"
 branch routines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> There is no longer a need for preserving branch offset operands,
> as we no longer re-translate.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/ppc/tcg-target.inc.c | 25 +++++++------------------
>  1 file changed, 7 insertions(+), 18 deletions(-)
>
> diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
> index c2f729ee8f..2e2a22f579 100644
> --- a/tcg/ppc/tcg-target.inc.c
> +++ b/tcg/ppc/tcg-target.inc.c
> @@ -210,18 +210,6 @@ static void reloc_pc14(tcg_insn_unit *pc, tcg_insn_u=
nit *target)
>      *pc =3D (*pc & ~0xfffc) | reloc_pc14_val(pc, target);
>  }
>
> -static inline void tcg_out_b_noaddr(TCGContext *s, int insn)
> -{
> -    unsigned retrans =3D *s->code_ptr & 0x3fffffc;
> -    tcg_out32(s, insn | retrans);
> -}
> -
> -static inline void tcg_out_bc_noaddr(TCGContext *s, int insn)
> -{
> -    unsigned retrans =3D *s->code_ptr & 0xfffc;
> -    tcg_out32(s, insn | retrans);
> -}
> -
>  /* parse target specific constraints */
>  static const char *target_parse_constraint(TCGArgConstraint *ct,
>                                             const char *ct_str, TCGType t=
ype)
> @@ -1179,11 +1167,11 @@ static void tcg_out_setcond(TCGContext *s, TCGTyp=
e type, TCGCond cond,
>  static void tcg_out_bc(TCGContext *s, int bc, TCGLabel *l)
>  {
>      if (l->has_value) {
> -        tcg_out32(s, bc | reloc_pc14_val(s->code_ptr, l->u.value_ptr));
> +        bc |=3D reloc_pc14_val(s->code_ptr, l->u.value_ptr);
>      } else {
>          tcg_out_reloc(s, s->code_ptr, R_PPC_REL14, l, 0);
> -        tcg_out_bc_noaddr(s, bc);
>      }
> +    tcg_out32(s, bc);
>  }
>
>  static void tcg_out_brcond(TCGContext *s, TCGCond cond,
> @@ -1771,7 +1759,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TC=
GArg *args, bool is_64)
>
>      /* Load a pointer into the current opcode w/conditional branch-link.=
 */
>      label_ptr =3D s->code_ptr;
> -    tcg_out_bc_noaddr(s, BC | BI(7, CR_EQ) | BO_COND_FALSE | LK);
> +    tcg_out32(s, BC | BI(7, CR_EQ) | BO_COND_FALSE | LK);
>
>      rbase =3D TCG_REG_R3;
>  #else  /* !CONFIG_SOFTMMU */
> @@ -1846,7 +1834,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TC=
GArg *args, bool is_64)
>
>      /* Load a pointer into the current opcode w/conditional branch-link.=
 */
>      label_ptr =3D s->code_ptr;
> -    tcg_out_bc_noaddr(s, BC | BI(7, CR_EQ) | BO_COND_FALSE | LK);
> +    tcg_out32(s, BC | BI(7, CR_EQ) | BO_COND_FALSE | LK);
>
>      rbase =3D TCG_REG_R3;
>  #else  /* !CONFIG_SOFTMMU */
> @@ -2044,13 +2032,14 @@ static void tcg_out_op(TCGContext *s, TCGOpcode o=
pc, const TCGArg *args,
>      case INDEX_op_br:
>          {
>              TCGLabel *l =3D arg_label(args[0]);
> +            uint32_t insn =3D B;
>
>              if (l->has_value) {
> -                tcg_out_b(s, 0, l->u.value_ptr);
> +                insn |=3D reloc_pc24_val(s->code_ptr, l->u.value_ptr);
>              } else {
>                  tcg_out_reloc(s, s->code_ptr, R_PPC_REL24, l, 0);
> -                tcg_out_b_noaddr(s, B);
>              }
> +            tcg_out32(s, insn);
>          }
>          break;
>      case INDEX_op_ld8u_i32:


--
Alex Benn=C3=A9e
