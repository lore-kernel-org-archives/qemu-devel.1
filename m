Received: from eggs.gnu.org ([209.51.188.92]:56238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMBjM-0002Ce-Ti
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMBjL-0000ki-UI
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:26:32 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMBjK-0000j7-3C
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:26:31 -0400
Received: by mail-wm1-x344.google.com with SMTP id b10so2825623wmj.4
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 06:26:29 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id h9sm7135382wmb.5.2019.05.02.06.26.27
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 06:26:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id F151D1FF87
	for <qemu-devel@nongnu.org>; Thu,  2 May 2019 14:26:26 +0100 (BST)
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-13-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190501050536.15580-13-richard.henderson@linaro.org>
Date: Thu, 02 May 2019 14:26:26 +0100
Message-ID: <87ef5h56nx.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 12/29] tcg/aarch64: Implement
 tcg_out_dupm_vec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/aarch64/tcg-target.inc.c | 38 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index 4a3cfa778a..411fb463ac 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -381,6 +381,9 @@ typedef enum {
>      I3207_BLR       =3D 0xd63f0000,
>      I3207_RET       =3D 0xd65f0000,
>
> +    /* AdvSIMD load/store single structure.  */
> +    I3303_LD1R      =3D 0x0d40c000,
> +

I can't recall where these magic numbers come from again? The (moving)
section numbers of the ARM ARM?

I was hoping the XML had a bit more guidance on the encoding names but
we get:

    <iclass name=3D"No offset" oneof=3D"2" id=3D"LD1R_asisdlso_R1" no_encod=
ings=3D"1" isa=3D"A64">
and
    <iclass name=3D"Post-index" oneof=3D"2" id=3D"as_post_index" no_encodin=
gs=3D"2" isa=3D"A64">

Although the instruction does have:

   <instructionsection id=3D"LD1R_advsimd" title=3D"LD1R -- A64" type=3D"in=
struction">


>      /* Load literal for loading the address at pc-relative offset */
>      I3305_LDR       =3D 0x58000000,
>      I3305_LDR_v64   =3D 0x5c000000,
> @@ -414,6 +417,8 @@ typedef enum {
>      I3312_LDRVQ     =3D 0x3c000000 | 3 << 22 | 0 << 30,
>      I3312_STRVQ     =3D 0x3c000000 | 2 << 22 | 0 << 30,
>
> +
> +
>      I3312_TO_I3310  =3D 0x00200800,
>      I3312_TO_I3313  =3D 0x01000000,
>
> @@ -566,7 +571,14 @@ static inline uint32_t tcg_in32(TCGContext *s)
>  #define tcg_out_insn(S, FMT, OP, ...) \
>      glue(tcg_out_insn_,FMT)(S, glue(glue(glue(I,FMT),_),OP), ##
> __VA_ARGS__)

The above is basically a winge as to what do we really get out of this
"type checking"?

>
> -static void tcg_out_insn_3305(TCGContext *s, AArch64Insn insn, int imm19=
, TCGReg rt)
> +static void tcg_out_insn_3303(TCGContext *s, AArch64Insn insn, bool q,
> +                              TCGReg rt, TCGReg rn, unsigned size)
> +{
> +    tcg_out32(s, insn | (rt & 0x1f) | (rn << 5) | (size << 10) | (q << 3=
0));
> +}
> +
> +static void tcg_out_insn_3305(TCGContext *s, AArch64Insn insn,
> +                              int imm19, TCGReg rt)
>  {
>      tcg_out32(s, insn | (imm19 & 0x7ffff) << 5 | rt);
>  }
> @@ -825,7 +837,29 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType t=
ype, unsigned vece,
>  static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
>                               TCGReg r, TCGReg base, intptr_t offset)
>  {
> -    return false;
> +    if (offset !=3D 0) {
> +        AArch64Insn add_insn =3D I3401_ADDI;
> +        TCGReg temp =3D TCG_REG_TMP;
> +
> +        if (offset < 0) {
> +            add_insn =3D I3401_SUBI;
> +            offset =3D -offset;
> +        }
> +        if (offset <=3D 0xfff) {
> +            tcg_out_insn_3401(s, add_insn, 1, temp, base, offset);
> +        } else if (offset <=3D 0xffffff) {
> +            tcg_out_insn_3401(s, add_insn, 1, temp, base, offset & 0xfff=
000);
> +            if (offset & 0xfff) {
> +                tcg_out_insn_3401(s, add_insn, 1, temp, base, offset & 0=
xfff);
> +            }
> +        } else {
> +            tcg_out_movi(s, TCG_TYPE_PTR, temp, offset);
> +            tcg_out_insn(s, 3502, ADD, 1, temp, temp, base);
> +        }
> +        base =3D temp;
> +    }
> +    tcg_out_insn(s, 3303, LD1R, type =3D=3D TCG_TYPE_V128, r, base, vece=
);
> +    return true;
>  }
>
>  static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,


--
Alex Benn=C3=A9e
