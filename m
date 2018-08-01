Received: from eggs.gnu.org ([2001:4830:134:3::10]:46441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1fkrLj-00011S-2Y
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1fkrLe-0002dD-6v
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:39:35 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:65449)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1fkrLd-0002Z7-Qu
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:39:30 -0400
Date: Wed, 1 Aug 2018 15:39:23 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20180801133922.GC2371@localhost.localdomain>
References: <20180707194137.GB14409@localhost.localdomain>
	<alpine.LFD.2.21.1808010159390.4967@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1808010159390.4967@eddie.linux-mips.org>
Subject: Re: [Qemu-devel] [RFC] target/mips: Initial support for MIPS R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Maciej W. Rozycki" <macro@linux-mips.org>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <aleksandar.markovic@mips.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>

Thank you for your review, Maciej,

> > The MIPS R5900 is normally taken to be MIPS3, but it has MOVN, MOVZ and PREF
> > defined in MIPS4 which is why ISA_MIPS4 is chosen for this patch.
> 
>  It also has several instructions removed, so I don't think you can really 
> just mark it MIPS IV without special-casing those instructions, or the 
> emulation won't be accurate (and consequently programs that use them won't 
> trigger exceptions that they are supposed to).

Agreed. However, complete and perfect emulation of the R5900 will require a
substantial amount of work. What level is suitable for an initial patch?

> > Some flags in the mips_defs array are marked FIXME as I don't know the
> > proper values.
> 
>  Well, the FPU is non-standard so until you implement it I'd rather kept 
> it disabled and then all the FPU-related settings can go for now.  For the 
> rest see below.

The kernel traps FPU instructions to emulate them accurately, and unless the
FPU is enabled here the QEMU Linux user space emulator crashes with "illegal
hardware instruction" on valid programs. Can QEMU be instructed to emulate
the FPU only for Linux user space programs as opposed to hardware emulation?

> > --- a/target/mips/translate_init.inc.c
> > +++ b/target/mips/translate_init.inc.c
> > @@ -411,6 +411,26 @@ const mips_def_t mips_defs[] =
> >          .mmu_type = MMU_TYPE_R4000,
> >      },
> >      {
> > +        .name = "R5900",
> > +        .CP0_PRid = 0x00003800,
> > +        /* No L2 cache, icache size 32k, dcache size 32k, uncached coherency. */
> > +        .CP0_Config0 = (1 << 17) | (0x3 << 9) | (0x3 << 6) | (0x2 << CP0C0_K0),
> > +        /* Note: Config1 is only used internally, the R5900 has only Config0. */
> > +        .CP0_Config1 = (1 << CP0C1_FP) | (47 << CP0C1_MMU),
> 
>  So I'd clear CP0C1_FP then; also make sure accessing CP0.Config1 from 
> emulated code does what it does on actual hardware.
> 
> > +        .CP0_LLAddr_rw_bitmask = 0xFFFFFFFF,	/* FIXME */
> > +        .CP0_LLAddr_shift = 4,			/* FIXME */
> 
>  No LL/SC in the R5900, so the LLAddr settings can go.

Again, the kernel emulates LL/SC so I suppose some kind indication is needed
for that in the QEMU Linux user space emulator?

> > +        .SYNCI_Step = 16,			/* FIXME */
> 
>  SYNCI is MIPS32r2+, so this can go.
> 
> > +        .CCRes = 2,				/* FIXME */
> 
>  Likewise, CCRes is MIPS32r2+, so this can go.

Sure!

> > +        .CP0_Status_rw_bitmask = 0x3678FFFF,	/* FIXME */
> 
>  This has to indicate which bits in CP0.Status are writable.  Check with 
> the manual and/or actual hardware.

The TX79 manual describes the writable bits on pages 4.16-4.18, and it seems
0xF4C79C1F would be those.

> > +        .CP1_fcr0 = (0x38 << FCR0_PRID) | (0x0 << FCR0_REV),
> > +        .CP1_fcr31 = 0,
> > +        .CP1_fcr31_rw_bitmask = 0x0183FFFF,	/* FIXME */
> 
>  This is all FPU stuff and it can go.
> 
> > +        .SEGBITS = 40,				/* FIXME */
> 
>  This is the number of virtual address bits.  Determined by the highest 
> writable CP0.EntryHi.VPN2 bit.

VPN2 is bits 31:13 and so it is 19 bits wide, according to page 4.14 of the
TX79 manual.

> > +        .PABITS = 36,				/* FIXME */
> 
>  Likewise physical address bits.  Determined by the highest writable 
> CP0.EntryLo0.PFN and CP0.EntryLo1.PFN bit.

PFN is bits 25:6 and so it is 20 bits wide, according to page 4.8 of the
TX79 manual.

> > +        .insn_flags = CPU_R5900,
> > +        .mmu_type = MMU_TYPE_R4000,		/* FIXME */
> 
>  This looks right to me.

Good. :)

>  FWIW; I don't have any authority for QEMU maintenance.

The MAINTAINERS file indicates that Aurelien Jarno and Aleksandar Markovic
have authority over the MIPS emulation (CCed to this post).

Fredrik
