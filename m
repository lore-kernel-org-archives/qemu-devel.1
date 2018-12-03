Received: from eggs.gnu.org ([2001:4830:134:3::10]:47242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTlhf-00049h-C0
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:43:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTlhc-0005sI-7d
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:43:51 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55699)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gTlhc-0005r0-1V
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:43:48 -0500
Received: by mail-wm1-x344.google.com with SMTP id y139so5196690wmc.5
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 02:43:47 -0800 (PST)
References: <20181130215221.20554-1-richard.henderson@linaro.org>
	<20181130215221.20554-15-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181130215221.20554-15-richard.henderson@linaro.org>
Date: Mon, 03 Dec 2018 10:43:44 +0000
Message-ID: <87wooq3n6n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 14/16] tcg/arm: Return false on failure
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

> This does require an extra two checks within the slow paths
> to replace the assert that we're moving.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/arm/tcg-target.inc.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
> index deefa20fbf..49f57d655e 100644
> --- a/tcg/arm/tcg-target.inc.c
> +++ b/tcg/arm/tcg-target.inc.c
> @@ -187,10 +187,14 @@ static const uint8_t tcg_cond_to_arm_cond[] =3D {
>      [TCG_COND_GTU] =3D COND_HI,
>  };
>
> -static inline void reloc_pc24(tcg_insn_unit *code_ptr, tcg_insn_unit *ta=
rget)
> +static inline bool reloc_pc24(tcg_insn_unit *code_ptr, tcg_insn_unit *ta=
rget)
>  {
>      ptrdiff_t offset =3D (tcg_ptr_byte_diff(target, code_ptr) - 8) >> 2;
> -    *code_ptr =3D (*code_ptr & ~0xffffff) | (offset & 0xffffff);
> +    if (offset =3D=3D sextract32(offset, 0, 24)) {
> +        *code_ptr =3D (*code_ptr & ~0xffffff) | (offset & 0xffffff);
> +        return true;
> +    }
> +    return false;
>  }
>
>  static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
> @@ -199,7 +203,7 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int =
type,
>      tcg_debug_assert(addend =3D=3D 0);
>
>      if (type =3D=3D R_ARM_PC24) {
> -        reloc_pc24(code_ptr, (tcg_insn_unit *)value);
> +        return reloc_pc24(code_ptr, (tcg_insn_unit *)value);
>      } else if (type =3D=3D R_ARM_PC13) {
>          intptr_t diff =3D value - (uintptr_t)(code_ptr + 2);
>          tcg_insn_unit insn =3D *code_ptr;
> @@ -213,7 +217,11 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int=
 type,
>          } else {
>              int rd =3D extract32(insn, 12, 4);
>              int rt =3D rd =3D=3D TCG_REG_PC ? TCG_REG_TMP : rd;
> -            assert(diff >=3D 0x1000 && diff < 0x100000);
> +
> +            if (diff < 0x1000 || diff >=3D 0x100000) {
> +                return false;
> +            }
> +
>              /* add rt, pc, #high */
>              *code_ptr++ =3D ((insn & 0xf0000000) | (1 << 25) | ARITH_ADD
>                             | (TCG_REG_PC << 16) | (rt << 12)
> @@ -1372,7 +1380,8 @@ static void tcg_out_qemu_ld_slow_path(TCGContext *s=
, TCGLabelQemuLdst *lb)
>      TCGMemOp opc =3D get_memop(oi);
>      void *func;
>
> -    reloc_pc24(lb->label_ptr[0], s->code_ptr);
> +    bool ok =3D reloc_pc24(lb->label_ptr[0], s->code_ptr);
> +    tcg_debug_assert(ok);
>
>      argreg =3D tcg_out_arg_reg32(s, TCG_REG_R0, TCG_AREG0);
>      if (TARGET_LONG_BITS =3D=3D 64) {
> @@ -1432,7 +1441,8 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s=
, TCGLabelQemuLdst *lb)
>      TCGMemOpIdx oi =3D lb->oi;
>      TCGMemOp opc =3D get_memop(oi);
>
> -    reloc_pc24(lb->label_ptr[0], s->code_ptr);
> +    bool ok =3D reloc_pc24(lb->label_ptr[0], s->code_ptr);
> +    tcg_debug_assert(ok);
>
>      argreg =3D TCG_REG_R0;
>      argreg =3D tcg_out_arg_reg32(s, argreg, TCG_AREG0);


--
Alex Benn=C3=A9e
