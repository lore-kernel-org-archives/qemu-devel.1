Received: from eggs.gnu.org ([2001:4830:134:3::10]:59483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gF506-000123-9o
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gF4nM-0008Vd-EE
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:05:04 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:40702
	helo=cvs.linux-mips.org) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gF4nM-0007uW-0A
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:05:00 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
	with ESMTP id S23994640AbeJWWEesdz8Y convert rfc822-to-quoted-printable
	(ORCPT <rfc822;qemu-devel@nongnu.org>);
	Wed, 24 Oct 2018 00:04:34 +0200
Date: Tue, 23 Oct 2018 23:04:34 +0100 (BST)
Sender: "Maciej W. Rozycki" <macro@linux-mips.org>
From: "Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <20181023192525.GC2244@sx9>
Message-ID: <alpine.LFD.2.21.1810232158120.19280@eddie.linux-mips.org>
References: <cover.1540134918.git.noring@nocrew.org>
	<BN6PR2201MB125165723113459889A6EC59C6F40@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20181023192525.GC2244@sx9>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Subject: Re: [Qemu-devel] [PATCH v8 00/38] target/mips: Limited support for
 the R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi Fredrik,

> > target/mips/translate.c:4888:38: error: passing argument 3 of
> > =E2=80=98tcg_gen_add2_i32=E2=80=99 from incompatible pointer type
> > [-Werror=3Dincompatible-pointer-types]
> >              tcg_gen_add2_i32(t2, t3, cpu_LO[acc], cpu_HI[acc], t2,=
 t3);
> >                                       ^~~~~~
>=20
> Would you know if any MIPS ISA have LO and HI registers that are not
> 32-bit? In QEMU they can obviously be either 32-bit or 64-bit, which
> causes the compilation error here.

 Actually with all 64-bit MIPS ISAs HI/LO are a pair of 64-bit register=
s,=20
that is with MIPS III, MIPS IV, and then MIPS64 R1 to R5 ISAs (base R6 =
ISA=20
removed the MD accumulator, although it has been retained along with th=
e 3=20
other ones in the DSP ASE).

 The R5900 CPU is an oddball here, having no 64-bit multiply or divide=20
instructions, however documentation indicates these registers are still=
=20
64-bit as far as the base instruction set is concerned, i.e. it says yo=
u=20
can actually write the upper halves with any bit patterns explicitly wi=
th=20
the MTHI and MTLO instructions.  And then they're really 128-bit as far=
 as=20
the full instruction set of the R5900 is concerned, for all the pipelin=
e 1=20
MD instructions operate on bits 95:64 and some MMI instructions operate=
 on=20
the full 128-bit width of the accumulator.

 Interestingly enough architecturally trying to use HI/LO values that a=
re=20
not properly sign-extended 32-bit numbers does not make the operation o=
f=20
32-bit multiply-accumulate instructions unpredictable, as they are=20
specified to simply ignore the upper 32 bits of a 64-bit value containe=
d=20
there, and the the TX79 manual follows.

 This is unlike with the GPR inputs to all MD instructions, which=20
architecturally have to be sign-extended.  Contrariwise, the TX79 manua=
l=20
says that GPR inputs to the unsigned variants of MD instructions have t=
o=20
be zero-extended, and I do hope this is just an editorial mistake and=20
hardware does not follow (especially as the description of MULTU on pag=
e=20
A-87 disagress in this regard with one on page B-25, and all the releva=
nt=20
pseudocode operation specifications consistently use NotWordValue as th=
e=20
input validation condition, although that has been nowhere actually=20
formally defined).  Otherwise lots of software would break and you'd ha=
ve=20
to use a DSLL32/DSRL32 instruction pair every time before feeding the=20
result of other 32-bit calculations to those instructions.

 BTW, notice that the pseudocode operation specification of the TX79 MD=
=20
instructions does clearly indicate the sign-extension of output HI/LO=20
contents, e.g. for MULTU we have:

    prod         <- (0 || GPR[rs]31..0) * (0 || GPR[rt]31..0)
    LO63..0      <- (prod 31)32 || prod31..0
    HI63..0      <- (prod 63)32 || prod63..32
    GPR[rd]63..0 <- (prod 31)32 || prod31..0

 HTH,

  Maciej
