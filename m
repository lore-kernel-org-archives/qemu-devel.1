Received: from eggs.gnu.org ([2001:4830:134:3::10]:38241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fJLzV-0001Re-NX
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:43:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fJLzS-0000XI-Iw
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:42:57 -0400
Received: from mail-by2nam01on0085.outbound.protection.outlook.com
	([104.47.34.85]:62818
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <edgari@xilinx.com>) id 1fJLzS-0000Wd-5q
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:42:54 -0400
Date: Thu, 17 May 2018 18:42:39 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20180517164239.xyy2gbi5j2uuppix@toto>
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
	<20180516185146.30708-37-edgar.iglesias@gmail.com>
	<796ed3f8-6a5d-371f-791d-071f4d6f2cdd@amsat.org>
	<e4a2fa3b-eaa7-be39-71ec-ad3e0420afb2@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e4a2fa3b-eaa7-be39-71ec-ad3e0420afb2@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v3 36/38] target-microblaze: Use
 tcg_gen_movcond in eval_cond_jmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org, richard.henderson@linaro.org, peter.maydell@linaro.org, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, frasse.iglesias@gmail.com, alistair@alistair23.me, frederic.konrad@adacore.com

On Thu, May 17, 2018 at 11:48:35AM -0300, Philippe Mathieu-Daud=E9 wrote:
> Hi Edgar,
>=20
> On 05/17/2018 11:22 AM, Philippe Mathieu-Daud=E9 wrote:
> > On 05/16/2018 03:51 PM, Edgar E. Iglesias wrote:
> >> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> >>
> >> Cleanup eval_cond_jmp to use tcg_gen_movcond_i64().
> >> No functional change.
> >>
> >> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> >> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> >> ---
> >>  target/microblaze/translate.c | 16 ++++++++++------
> >>  1 file changed, 10 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/target/microblaze/translate.c b/target/microblaze/transla=
te.c
> >> index a846797d9c..78c2855ff0 100644
> >> --- a/target/microblaze/translate.c
> >> +++ b/target/microblaze/translate.c
> >> @@ -1171,12 +1171,16 @@ static inline void eval_cc(DisasContext *dc, u=
nsigned int cc,
> >> =20
> >>  static void eval_cond_jmp(DisasContext *dc, TCGv_i64 pc_true, TCGv_i6=
4 pc_false)
> >>  {
> >> -    TCGLabel *l1 =3D gen_new_label();
> >> -    /* Conditional jmp.  */
> >> -    tcg_gen_mov_i64(cpu_SR[SR_PC], pc_false);
> >> -    tcg_gen_brcondi_i32(TCG_COND_EQ, env_btaken, 0, l1);
> >> -    tcg_gen_mov_i64(cpu_SR[SR_PC], pc_true);
> >> -    gen_set_label(l1);
> >> +    TCGv_i64 tmp_btaken =3D tcg_temp_new_i64();
> >> +    TCGv_i64 tmp_zero =3D tcg_const_i64(0);
>=20
> Why not use cpu_R[0] directly?
>=20
> I wonder, maybe the current model doesn't not have R0 hardwired to 0?

It does but cpu_R[0] is 32bit so we would still need a temp to extend it...

Cheers,
Edgar

>=20
> >> +
> >> +    tcg_gen_extu_i32_i64(tmp_btaken, env_btaken);
> >=20
> > env_btaken is i32, ok.
> >=20
> > Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> >=20
> >> +    tcg_gen_movcond_i64(TCG_COND_NE, cpu_SR[SR_PC],
> >> +                        tmp_btaken, tmp_zero,
> >> +                        pc_true, pc_false);
>=20
> So we could drop a temp, using:
>=20
>         tcg_gen_movcond_i64(TCG_COND_NE, cpu_SR[SR_PC],
>                             tmp_btaken, cpu_R[0],
>                             pc_true, pc_false);
>=20
> >> +
> >> +    tcg_temp_free_i64(tmp_btaken);
> >> +    tcg_temp_free_i64(tmp_zero);
> >>  }
> >> =20
> >>  static void dec_bcc(DisasContext *dc)
> >>
