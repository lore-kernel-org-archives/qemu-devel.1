Received: from eggs.gnu.org ([2001:4830:134:3::10]:45851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTlbi-0001Du-Hp
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:37:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTlbe-0007tD-Ci
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:37:42 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gTlbc-0007rh-Lg
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:37:38 -0500
Received: by mail-wr1-x441.google.com with SMTP id p4so11552371wrt.7
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 02:37:36 -0800 (PST)
References: <20181130215221.20554-1-richard.henderson@linaro.org>
	<20181130215221.20554-9-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181130215221.20554-9-richard.henderson@linaro.org>
Date: Mon, 03 Dec 2018 10:37:34 +0000
Message-ID: <875zwa521d.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 08/16] tcg/s390: Remove retranslation
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
>  tcg/s390/tcg-target.inc.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
> index 17c435ade5..96c344142e 100644
> --- a/tcg/s390/tcg-target.inc.c
> +++ b/tcg/s390/tcg-target.inc.c
> @@ -1329,13 +1329,11 @@ static void tgen_branch(TCGContext *s, int cc, TC=
GLabel *l)
>  static void tgen_compare_branch(TCGContext *s, S390Opcode opc, int cc,
>                                  TCGReg r1, TCGReg r2, TCGLabel *l)
>  {
> -    intptr_t off;
> +    intptr_t off =3D 0;
>
>      if (l->has_value) {
>          off =3D l->u.value_ptr - s->code_ptr;
>      } else {
> -        /* We need to keep the offset unchanged for retranslation.  */
> -        off =3D s->code_ptr[1];
>          tcg_out_reloc(s, s->code_ptr + 1, R_390_PC16DBL, l, 2);
>      }
>
> @@ -1347,13 +1345,11 @@ static void tgen_compare_branch(TCGContext *s, S3=
90Opcode opc, int cc,
>  static void tgen_compare_imm_branch(TCGContext *s, S390Opcode opc, int c=
c,
>                                      TCGReg r1, int i2, TCGLabel *l)
>  {
> -    tcg_target_long off;
> +    tcg_target_long off =3D 0;
>
>      if (l->has_value) {
>          off =3D l->u.value_ptr - s->code_ptr;
>      } else {
> -        /* We need to keep the offset unchanged for retranslation.  */
> -        off =3D s->code_ptr[1];
>          tcg_out_reloc(s, s->code_ptr + 1, R_390_PC16DBL, l, 2);
>      }
>
> @@ -1696,7 +1692,6 @@ static void tcg_out_qemu_ld(TCGContext* s, TCGReg d=
ata_reg, TCGReg addr_reg,
>
>      base_reg =3D tcg_out_tlb_read(s, addr_reg, opc, mem_index, 1);
>
> -    /* We need to keep the offset unchanged for retranslation.  */
>      tcg_out16(s, RI_BRC | (S390_CC_NE << 4));
>      label_ptr =3D s->code_ptr;
>      s->code_ptr +=3D 1;
> @@ -1724,7 +1719,6 @@ static void tcg_out_qemu_st(TCGContext* s, TCGReg d=
ata_reg, TCGReg addr_reg,
>
>      base_reg =3D tcg_out_tlb_read(s, addr_reg, opc, mem_index, 0);
>
> -    /* We need to keep the offset unchanged for retranslation.  */
>      tcg_out16(s, RI_BRC | (S390_CC_NE << 4));
>      label_ptr =3D s->code_ptr;
>      s->code_ptr +=3D 1;


--
Alex Benn=C3=A9e
