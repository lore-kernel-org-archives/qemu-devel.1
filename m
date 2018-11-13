Received: from eggs.gnu.org ([2001:4830:134:3::10]:37223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gMhXX-00013k-7y
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 17:52:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gMhXT-0006f1-EN
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 17:52:11 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gMhXT-0006eq-AG
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 17:52:07 -0500
Received: by mail-yb1-f193.google.com with SMTP id d18-v6so6131349yba.4
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 14:52:07 -0800 (PST)
MIME-Version: 1.0
References: <1542135956-3780-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<CAAdtpL4cd2i0ZgL_hyPc9wgp5-=v5qeExmAnpdr0XZ97_5cwjg@mail.gmail.com>
In-Reply-To: <CAAdtpL4cd2i0ZgL_hyPc9wgp5-=v5qeExmAnpdr0XZ97_5cwjg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 13 Nov 2018 23:51:54 +0100
Message-ID: <CAAdtpL7JsA90236QX5vCLeE1ma0hZ75-BLwwC=+Nc2Di9utDSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/mips: Disable R5900 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Stefan Markovic <smarkovic@wavecomp.com>, Fredrik Noring <noring@nocrew.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

On Tue, Nov 13, 2018 at 8:29 PM Philippe Mathieu-Daud=C3=A9
<philippe@mathieu-daude.net> wrote:
> On Tue, Nov 13, 2018 at 8:08 PM Aleksandar Markovic
> <aleksandar.markovic@rt-rk.com> wrote:
> >
> > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> >
> > Disable R5900 support. There are some outstanding issues related
> > to ABI support and emulation accuracy, that were not understood
> > well during review process. Disable to avoid backward compatibility
> > issues.

If the issues you mentioned are "the R5900 tcg opcodes are not
implemented correctly", then this patch is OK, because no cpu can use
the R5900 opcodes.

At some point while reading your reviews, I understood the R5900
patches introduced incorrect behaviors for the non-R5900 cpus. In this
case this patch wouldn't suffice.

> Can you add:
>
> This reverts commit ed4f49ba9bb56ebca6987b1083255daf6c89b5de.
>
> Or
>
> Fixes: ed4f49ba9
>
> when applying?

Hoping I misinterpreted your reviews, then this patch is OK.
With one of the suggested comments:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Then we will fix this for the 4.0 release.

Regards,

Phil.

> >
> > Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
> > ---
> >  target/mips/translate_init.inc.c | 59 --------------------------------=
--------
> >  1 file changed, 59 deletions(-)
> >
> > diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_i=
nit.inc.c
> > index 85da4a2..acab097 100644
> > --- a/target/mips/translate_init.inc.c
> > +++ b/target/mips/translate_init.inc.c
> > @@ -411,65 +411,6 @@ const mips_def_t mips_defs[] =3D
> >          .mmu_type =3D MMU_TYPE_R4000,
> >      },
> >      {
> > -        /*
> > -         * The Toshiba TX System RISC TX79 Core Architecture manual
> > -         *
> > -         * https://wiki.qemu.org/File:C790.pdf
> > -         *
> > -         * describes the C790 processor that is a follow-up to the R59=
00.
> > -         * There are a few notable differences in that the R5900 FPU
> > -         *
> > -         * - is not IEEE 754-1985 compliant,
> > -         * - does not implement double format, and
> > -         * - its machine code is nonstandard.
> > -         */
> > -        .name =3D "R5900",
> > -        .CP0_PRid =3D 0x00002E00,
> > -        /* No L2 cache, icache size 32k, dcache size 32k, uncached coh=
erency. */
> > -        .CP0_Config0 =3D (0x3 << 9) | (0x3 << 6) | (0x2 << CP0C0_K0),
> > -        .CP0_Status_rw_bitmask =3D 0xF4C79C1F,
> > -#ifdef CONFIG_USER_ONLY
> > -        /*
> > -         * R5900 hardware traps to the Linux kernel for IEEE 754-1985 =
and LL/SC
> > -         * emulation. For user only, QEMU is the kernel, so we emulate=
 the traps
> > -         * by simply emulating the instructions directly.
> > -         *
> > -         * Note: Config1 is only used internally, the R5900 has only C=
onfig0.
> > -         */
> > -        .CP0_Config1 =3D (1 << CP0C1_FP) | (47 << CP0C1_MMU),
> > -        .CP0_LLAddr_rw_bitmask =3D 0xFFFFFFFF,
> > -        .CP0_LLAddr_shift =3D 4,
> > -        .CP1_fcr0 =3D (0x38 << FCR0_PRID) | (0x0 << FCR0_REV),
> > -        .CP1_fcr31 =3D 0,
> > -        .CP1_fcr31_rw_bitmask =3D 0x0183FFFF,
> > -#else
> > -        /*
> > -         * The R5900 COP1 FPU implements single-precision floating-poi=
nt
> > -         * operations but is not entirely IEEE 754-1985 compatible. In
> > -         * particular,
> > -         *
> > -         * - NaN (not a number) and +/- infinities are not supported;
> > -         * - exception mechanisms are not fully supported;
> > -         * - denormalized numbers are not supported;
> > -         * - rounding towards nearest and +/- infinities are not suppo=
rted;
> > -         * - computed results usually differs in the least significant=
 bit;
> > -         * - saturations can differ more than the least significant bi=
t.
> > -         *
> > -         * Since only rounding towards zero is supported, the two leas=
t
> > -         * significant bits of FCR31 are hardwired to 01.
> > -         *
> > -         * FPU emulation is disabled here until it is implemented.
> > -         *
> > -         * Note: Config1 is only used internally, the R5900 has only C=
onfig0.
> > -         */
> > -        .CP0_Config1 =3D (47 << CP0C1_MMU),
> > -#endif /* !CONFIG_USER_ONLY */
> > -        .SEGBITS =3D 32,
> > -        .PABITS =3D 32,
> > -        .insn_flags =3D CPU_R5900 | ASE_MMI,
> > -        .mmu_type =3D MMU_TYPE_R4000,
> > -    },
> > -    {
> >          /* A generic CPU supporting MIPS32 Release 6 ISA.
> >             FIXME: Support IEEE 754-2008 FP.
> >                    Eventually this should be replaced by a real CPU mod=
el. */
> > --
> > 2.7.4
> >
> >
