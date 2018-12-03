Received: from eggs.gnu.org ([2001:4830:134:3::10]:47768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTlk4-00065x-SB
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:46:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTlk1-0000Dq-00
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:46:20 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gTljz-0000Ce-TG
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:46:16 -0500
Received: by mail-wr1-x442.google.com with SMTP id z5so11591496wrt.11
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 02:46:15 -0800 (PST)
References: <20181130215221.20554-1-richard.henderson@linaro.org>
	<20181130215221.20554-17-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181130215221.20554-17-richard.henderson@linaro.org>
Date: Mon, 03 Dec 2018 10:46:13 +0000
Message-ID: <87tvju3n2i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 16/16] tcg/s390x: Return false on
 failure from patch_reloc
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
> to replace the assert that we're moving.  Also add two checks
> within existing functions that lacked any kind of assert for
> out of range branch.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/s390/tcg-target.inc.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
>
> diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
> index 68a4c60394..39ecf609a1 100644
> --- a/tcg/s390/tcg-target.inc.c
> +++ b/tcg/s390/tcg-target.inc.c
> @@ -377,23 +377,29 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, in=
t type,
>
>      switch (type) {
>      case R_390_PC16DBL:
> -        assert(pcrel2 =3D=3D (int16_t)pcrel2);
> -        tcg_patch16(code_ptr, pcrel2);
> +        if (pcrel2 =3D=3D (int16_t)pcrel2) {
> +            tcg_patch16(code_ptr, pcrel2);
> +            return true;
> +        }
>          break;
>      case R_390_PC32DBL:
> -        assert(pcrel2 =3D=3D (int32_t)pcrel2);
> -        tcg_patch32(code_ptr, pcrel2);
> +        if (pcrel2 =3D=3D (int32_t)pcrel2) {
> +            tcg_patch32(code_ptr, pcrel2);
> +            return true;
> +        }
>          break;
>      case R_390_20:
> -        assert(value =3D=3D sextract64(value, 0, 20));
> -        old =3D *(uint32_t *)code_ptr & 0xf00000ff;
> -        old |=3D ((value & 0xfff) << 16) | ((value & 0xff000) >> 4);
> -        tcg_patch32(code_ptr, old);
> +        if (value =3D=3D sextract64(value, 0, 20)) {
> +            old =3D *(uint32_t *)code_ptr & 0xf00000ff;
> +            old |=3D ((value & 0xfff) << 16) | ((value & 0xff000) >> 4);
> +            tcg_patch32(code_ptr, old);
> +            return true;
> +        }
>          break;
>      default:
>          g_assert_not_reached();
>      }
> -    return true;
> +    return false;
>  }
>
>  /* parse target specific constraints */
> @@ -1334,6 +1340,7 @@ static void tgen_compare_branch(TCGContext *s, S390=
Opcode opc, int cc,
>
>      if (l->has_value) {
>          off =3D l->u.value_ptr - s->code_ptr;
> +        tcg_debug_assert(off =3D=3D (int16_t)off);
>      } else {
>          tcg_out_reloc(s, s->code_ptr + 1, R_390_PC16DBL, l, 2);
>      }
> @@ -1350,6 +1357,7 @@ static void tgen_compare_imm_branch(TCGContext *s, =
S390Opcode opc, int cc,
>
>      if (l->has_value) {
>          off =3D l->u.value_ptr - s->code_ptr;
> +        tcg_debug_assert(off =3D=3D (int16_t)off);
>      } else {
>          tcg_out_reloc(s, s->code_ptr + 1, R_390_PC16DBL, l, 2);
>      }
> @@ -1615,7 +1623,9 @@ static void tcg_out_qemu_ld_slow_path(TCGContext *s=
, TCGLabelQemuLdst *lb)
>      TCGMemOpIdx oi =3D lb->oi;
>      TCGMemOp opc =3D get_memop(oi);
>
> -    patch_reloc(lb->label_ptr[0], R_390_PC16DBL, (intptr_t)s->code_ptr, =
2);
> +    bool ok =3D patch_reloc(lb->label_ptr[0], R_390_PC16DBL,
> +                          (intptr_t)s->code_ptr, 2);
> +    tcg_debug_assert(ok);
>
>      tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_R2, TCG_AREG0);
>      if (TARGET_LONG_BITS =3D=3D 64) {
> @@ -1636,7 +1646,9 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s=
, TCGLabelQemuLdst *lb)
>      TCGMemOpIdx oi =3D lb->oi;
>      TCGMemOp opc =3D get_memop(oi);
>
> -    patch_reloc(lb->label_ptr[0], R_390_PC16DBL, (intptr_t)s->code_ptr, =
2);
> +    bool ok =3D patch_reloc(lb->label_ptr[0], R_390_PC16DBL,
> +                          (intptr_t)s->code_ptr, 2);
> +    tcg_debug_assert(ok);
>
>      tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_R2, TCG_AREG0);
>      if (TARGET_LONG_BITS =3D=3D 64) {


--
Alex Benn=C3=A9e
