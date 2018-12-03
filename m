Received: from eggs.gnu.org ([2001:4830:134:3::10]:47432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTliL-0004c3-T6
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:44:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTliL-00079i-2u
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:44:33 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gTliK-000794-T9
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:44:33 -0500
Received: by mail-wr1-x443.google.com with SMTP id 96so11619052wrb.2
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 02:44:32 -0800 (PST)
References: <20181130215221.20554-1-richard.henderson@linaro.org>
	<20181130215221.20554-16-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181130215221.20554-16-richard.henderson@linaro.org>
Date: Mon, 03 Dec 2018 10:44:30 +0000
Message-ID: <87va4a3n5d.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 15/16] tcg/ppc: Return false on failure
 from patch_reloc
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

> The reloc_pc{14,24}_val routines retain their asserts.
> Use these directly within the slow paths.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/ppc/tcg-target.inc.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
> index 860b0d36e1..8c1cfdd7ac 100644
> --- a/tcg/ppc/tcg-target.inc.c
> +++ b/tcg/ppc/tcg-target.inc.c
> @@ -193,9 +193,14 @@ static uint32_t reloc_pc24_val(tcg_insn_unit *pc, tc=
g_insn_unit *target)
>      return disp & 0x3fffffc;
>  }
>
> -static void reloc_pc24(tcg_insn_unit *pc, tcg_insn_unit *target)
> +static bool reloc_pc24(tcg_insn_unit *pc, tcg_insn_unit *target)
>  {
> -    *pc =3D (*pc & ~0x3fffffc) | reloc_pc24_val(pc, target);
> +    ptrdiff_t disp =3D tcg_ptr_byte_diff(target, pc);
> +    if (in_range_b(disp)) {
> +        *pc =3D (*pc & ~0x3fffffc) | (disp & 0x3fffffc);
> +        return true;
> +    }
> +    return false;
>  }
>
>  static uint16_t reloc_pc14_val(tcg_insn_unit *pc, tcg_insn_unit *target)
> @@ -205,9 +210,14 @@ static uint16_t reloc_pc14_val(tcg_insn_unit *pc, tc=
g_insn_unit *target)
>      return disp & 0xfffc;
>  }
>
> -static void reloc_pc14(tcg_insn_unit *pc, tcg_insn_unit *target)
> +static bool reloc_pc14(tcg_insn_unit *pc, tcg_insn_unit *target)
>  {
> -    *pc =3D (*pc & ~0xfffc) | reloc_pc14_val(pc, target);
> +    ptrdiff_t disp =3D tcg_ptr_byte_diff(target, pc);
> +    if (disp =3D=3D (int16_t) disp) {
> +        *pc =3D (*pc & ~0xfffc) | (disp & 0xfffc);
> +        return true;
> +    }
> +    return false;
>  }
>
>  /* parse target specific constraints */
> @@ -524,11 +534,9 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int=
 type,
>
>      switch (type) {
>      case R_PPC_REL14:
> -        reloc_pc14(code_ptr, target);
> -        break;
> +        return reloc_pc14(code_ptr, target);
>      case R_PPC_REL24:
> -        reloc_pc24(code_ptr, target);
> -        break;
> +        return reloc_pc24(code_ptr, target);
>      case R_PPC_ADDR16:
>          /* We are abusing this relocation type.  This points to a pair
>             of insns, addis + load.  If the displacement is small, we
> @@ -540,7 +548,9 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int =
type,
>          } else {
>              int16_t lo =3D value;
>              int hi =3D value - lo;
> -            assert(hi + lo =3D=3D value);
> +            if (hi + lo !=3D value) {
> +                return false;
> +            }
>              code_ptr[0] =3D deposit32(code_ptr[0], 0, 16, hi >> 16);
>              code_ptr[1] =3D deposit32(code_ptr[1], 0, 16, lo);
>          }
> @@ -1638,7 +1648,7 @@ static void tcg_out_qemu_ld_slow_path(TCGContext *s=
, TCGLabelQemuLdst *lb)
>      TCGMemOp opc =3D get_memop(oi);
>      TCGReg hi, lo, arg =3D TCG_REG_R3;
>
> -    reloc_pc14(lb->label_ptr[0], s->code_ptr);
> +    **lb->label_ptr |=3D reloc_pc14_val(*lb->label_ptr, s->code_ptr);
>
>      tcg_out_mov(s, TCG_TYPE_PTR, arg++, TCG_AREG0);
>
> @@ -1683,7 +1693,7 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s=
, TCGLabelQemuLdst *lb)
>      TCGMemOp s_bits =3D opc & MO_SIZE;
>      TCGReg hi, lo, arg =3D TCG_REG_R3;
>
> -    reloc_pc14(lb->label_ptr[0], s->code_ptr);
> +    **lb->label_ptr |=3D reloc_pc14_val(*lb->label_ptr, s->code_ptr);
>
>      tcg_out_mov(s, TCG_TYPE_PTR, arg++, TCG_AREG0);


--
Alex Benn=C3=A9e
