Received: from eggs.gnu.org ([2001:4830:134:3::10]:44817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBoNH-0001u6-Pt
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 17:56:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBoNE-0000QY-47
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 17:56:35 -0400
Received: from mail-yb1-f172.google.com ([209.85.219.172]:44713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBoNC-0000MK-IX
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 17:56:31 -0400
Received: by mail-yb1-f172.google.com with SMTP id x5-v6so6793049ybl.11
	for <qemu-devel@nongnu.org>; Sun, 14 Oct 2018 14:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20181014142928.2784-1-f4bug@amsat.org> <20181014164140.GB2319@sx9>
In-Reply-To: <20181014164140.GB2319@sx9>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 14 Oct 2018 23:56:17 +0200
Message-ID: <CAAdtpL5xQYwyR0VxqAhA3dW9ec2KW07n-GKrMCt=UjQqwsuYHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/mips: Support Toshiba specific
 three-operand MADD and MADDU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>, Richard Henderson <richard.henderson@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, Aurelien Jarno <aurelien@aurel32.net>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>

Hi Fredrik,

On Sun, Oct 14, 2018 at 6:41 PM Fredrik Noring <noring@nocrew.org> wrote:
>
> Hi Philippe,
>
> > --- a/target/mips/translate.c
> > +++ b/target/mips/translate.c
> > @@ -3843,6 +3843,46 @@ static void gen_mul_txx9(DisasContext *ctx, uint=
32_t opc,
>
> What about documenting MADD and MADDU along with MULT and MULTU in the
> note above?

OK.

>
> > +    case OPC_MADD:
>
> This case is unreachable, because gen_mul_txx9 will never be called for
> OPC_MADD.

Well... I was going to send my R3900 branch but you sent your R5900
branch which clashes with mine for a single #define.
I posted a series to avoid this clash [*]: "mips: Increase the
insn_flags holder size and clean mips-defs.h" so we could both work
together.
Unfortunately Aleksandar prefer I don't base my series on top of
yours, so I'm blocked waiting your to enter.

I did rebase mine on yours to avoid duplicated efforts, and your
series was easier to review, less than 10 patchs.
Since I'm modelling a SoC (QEMU system part) mine is quite bigger.

I then realized the 3.0 merge window is closing (so I now have to wait
for the 3.1 to open in January), and I might have less time to spend
on this.
So I started to look at what patches I could salvage (a patch open
posted on the mailing list is still better than a phantom one IMHO,
even if WIP or invalid).

That's true it is not reachable, it lacks the INSN_R3900 definition,
used by the R3900 mips_def_t.

I'll stop bothering with this until the code is reachable (my branch posted=
).

[*] https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg04072.html

>
> > +            TCGv_i64 t2 =3D tcg_temp_new_i64();
> > +            TCGv_i64 t3 =3D tcg_temp_new_i64();
>
> The MADD (and MADDU) instructions are defined to multiply 32-bit integers
> in the C790 manual. Are 64-bit integers required to perform this with QEM=
U?

tcg_gen_mul_i32() store the multiplication result in a 32bit register.

If you look at "Table 3-8. Multiply, multiply / add instructions
(R3000A extended instruction set)":

  MADD rd, rs, rt
  MADD rs, rt
  Multiply the contents of registers rs and rt as two=E2=80=99s complement
integers, and add the doubleword
  (64-bit) result to multiply/divide registers HI and LO. Also, store
the lower 32 bits of the add result
  in register rd. In the MADD rs, rt format, the store operation to a
general register is omitted.

To be able to use the 64-bit result we need to use tcg_gen_mul_i64().

> > +            gen_move_low32(cpu_LO[acc], t2);
> > +            gen_move_high32(cpu_HI[acc], t2);
> > +            if (rd) {
> > +                gen_move_low32(cpu_gpr[rd], t2);
>
> Are LO, HI and GPR[rd] sign-extended to 64 bits when required?

tcg_gen_mul_i64() seems to use unsigned internally (calling
tcg_gen_mulu2_i32()).

So this one might be wrong.
(Richard can you confirm?)

>
> > +    case OPC_MADDU:
>
> As above, this case is unreachable, because gen_mul_txx9 will never be
> called for OPC_MADDU.
>
> > +            gen_move_low32(cpu_LO[acc], t2);
> > +            gen_move_high32(cpu_HI[acc], t2);
> > +            if (rd) {
> > +                gen_move_low32(cpu_gpr[rd], t2);
>
> As above, are LO, HI and GPR[rd] sign-extended to 64 bits when required?

  MADDU rd, rs, rt
  MADDU rs, rt
  Multiply the contents of registers rs and rt as unsigned integers,
and add the doubleword (64-bit)
  result to multiply/divide registers HI and LO. Also, store the lower
32 bits of the add result in register
  rd. In the MADDU rs, rt format, the store operation to a general
register is omitted.

This one looks correct.

>
> Fredrik

Thanks for your review,

Phil.
