Received: from eggs.gnu.org ([2001:4830:134:3::10]:55471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gBpPt-0005TQ-IT
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 19:03:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gBpPp-00037E-PS
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 19:03:21 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:57062
	helo=cvs.linux-mips.org) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gBpPj-00032o-W2
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 19:03:14 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
	with ESMTP id S23990757AbeJNXDCHHV0v convert rfc822-to-quoted-printable
	(ORCPT <rfc822;qemu-devel@nongnu.org>);
	Mon, 15 Oct 2018 01:03:02 +0200
Date: Mon, 15 Oct 2018 00:03:00 +0100 (BST)
Sender: "Maciej W. Rozycki" <macro@linux-mips.org>
From: "Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <CAAdtpL5xQYwyR0VxqAhA3dW9ec2KW07n-GKrMCt=UjQqwsuYHQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1810142320320.16498@eddie.linux-mips.org>
References: <20181014142928.2784-1-f4bug@amsat.org> <20181014164140.GB2319@sx9>
	<CAAdtpL5xQYwyR0VxqAhA3dW9ec2KW07n-GKrMCt=UjQqwsuYHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Fredrik Noring <noring@nocrew.org>, Richard Henderson <richard.henderson@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>

On Sun, 14 Oct 2018, Philippe Mathieu-Daud=C3=A9 wrote:

> > > +            gen_move_low32(cpu_LO[acc], t2);
> > > +            gen_move_high32(cpu_HI[acc], t2);
> > > +            if (rd) {
> > > +                gen_move_low32(cpu_gpr[rd], t2);
> >
> > As above, are LO, HI and GPR[rd] sign-extended to 64 bits when requ=
ired?
>=20
>   MADDU rd, rs, rt
>   MADDU rs, rt
>   Multiply the contents of registers rs and rt as unsigned integers,
> and add the doubleword (64-bit)
>   result to multiply/divide registers HI and LO. Also, store the lowe=
r
> 32 bits of the add result in register
>   rd. In the MADDU rs, rt format, the store operation to a general
> register is omitted.
>=20
> This one looks correct.

 Obviously with processors such as the TX49 or the TX79 where GPRs are=20
64-bit for the purpose of integer arithmetic (i.e. any multimedia=20
extension aside) any 32-bit results written to an integer register are=20
implicitly sign-extended to the full 64-bit width of the destination=20
register, as per the requirements of the MIPS architecture.  Otherwise=20
operation of any subsequent 32-bit instruction (other than SLL or SLLV)=
=20
using that that result as an input operand would be unpredictable.  You=
=20
need to respect that in QEMU too.

 So results of individual operations are as in the comments with this=20
code:

	mthi	$0		# HI <- 0
	mtlo	$0		# LO <- 0
	addiu	$2, $0, 1	# $2 <- 1
	lui	$3, 0x4000	# $3 <- 0x40000000
	maddu	$4, $3, $2	# HI <- 0
				# LO <- 0x40000000
				# $4 <- 0x40000000
	maddu	$5, $4, $2	# HI <- 0
				# LO <- 0xffffffff80000000
				# $5 <- 0xffffffff80000000
	maddu	$6, $4, $2	# HI <- 1
				# LO <- 0
				# $6 <- 0

Similarly:

	addiu	$2, $0, 1	# $2 <- 1
	sll	$3, $2, 31	# $3 <- 0xffffffff80000000
	dsll	$4, $2, 31	# $4 <- 0x80000000
	dsll	$5, $3, 0	# $5 <- 0xffffffff80000000
	sll	$6, $3, 0	# $6 <- 0xffffffff80000000
	dsll	$7, $4, 0	# $7 <- 0x80000000
	sll	$8, $4, 0	# $8 <- 0xffffffff80000000
	daddu	$9, $3, $3	# $9 <- 0xffffffff00000000
	addu	$10, $3, $3	# $10 <- 0
	daddu	$11, $4, $4	# $11 <- 0x100000000=20
	addu	$12, $4, $4	# unpredictable!

 HTH,

  Maciej
