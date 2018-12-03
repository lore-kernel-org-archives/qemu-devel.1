Received: from eggs.gnu.org ([2001:4830:134:3::10]:46183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTld2-00016D-RX
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:39:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTld0-0002bg-Ji
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:39:04 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gTld0-0002b9-Dx
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:39:02 -0500
Received: by mail-wm1-x342.google.com with SMTP id z18so5204521wmc.4
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 02:39:02 -0800 (PST)
References: <20181130215221.20554-1-richard.henderson@linaro.org>
	<20181130215221.20554-10-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181130215221.20554-10-richard.henderson@linaro.org>
Date: Mon, 03 Dec 2018 10:39:00 +0000
Message-ID: <874lbu51yz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 09/16] tcg/sparc: Remove retranslation
 code
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
>  tcg/sparc/tcg-target.inc.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
> index 04bdc3df5e..671a04c54b 100644
> --- a/tcg/sparc/tcg-target.inc.c
> +++ b/tcg/sparc/tcg-target.inc.c
> @@ -639,13 +639,11 @@ static void tcg_out_bpcc0(TCGContext *s, int scond,=
 int flags, int off19)
>
>  static void tcg_out_bpcc(TCGContext *s, int scond, int flags, TCGLabel *=
l)
>  {
> -    int off19;
> +    int off19 =3D 0;
>
>      if (l->has_value) {
>          off19 =3D INSN_OFF19(tcg_pcrel_diff(s, l->u.value_ptr));
>      } else {
> -        /* Make sure to preserve destinations during retranslation.  */
> -        off19 =3D *s->code_ptr & INSN_OFF19(-1);
>          tcg_out_reloc(s, s->code_ptr, R_SPARC_WDISP19, l, 0);
>      }
>      tcg_out_bpcc0(s, scond, flags, off19);
> @@ -685,13 +683,11 @@ static void tcg_out_brcond_i64(TCGContext *s, TCGCo=
nd cond, TCGReg arg1,
>  {
>      /* For 64-bit signed comparisons vs zero, we can avoid the compare. =
 */
>      if (arg2 =3D=3D 0 && !is_unsigned_cond(cond)) {
> -        int off16;
> +        int off16 =3D 0;
>
>          if (l->has_value) {
>              off16 =3D INSN_OFF16(tcg_pcrel_diff(s, l->u.value_ptr));
>          } else {
> -            /* Make sure to preserve destinations during retranslation. =
 */
> -            off16 =3D *s->code_ptr & INSN_OFF16(-1);
>              tcg_out_reloc(s, s->code_ptr, R_SPARC_WDISP16, l, 0);
>          }
>          tcg_out32(s, INSN_OP(0) | INSN_OP2(3) | BPR_PT | INSN_RS1(arg1)


--
Alex Benn=C3=A9e
