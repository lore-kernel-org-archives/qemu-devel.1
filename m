Received: from eggs.gnu.org ([2001:4830:134:3::10]:42947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1fkg1c-0004Pz-JC
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 21:34:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1fkg1X-0001R8-NK
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 21:34:04 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:53766
	helo=cvs.linux-mips.org) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1fkg1X-0001Pu-DZ
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 21:33:59 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
	with ESMTP id S23993072AbeHABduYNdzY (ORCPT
	<rfc822;qemu-devel@nongnu.org>); Wed, 1 Aug 2018 03:33:50 +0200
Date: Wed, 1 Aug 2018 02:33:50 +0100 (BST)
Sender: "Maciej W. Rozycki" <macro@linux-mips.org>
From: "Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <20180707194137.GB14409@localhost.localdomain>
Message-ID: <alpine.LFD.2.21.1808010159390.4967@eddie.linux-mips.org>
References: <20180707194137.GB14409@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [RFC] target/mips: Initial support for MIPS R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>

On Sat, 7 Jul 2018, Fredrik Noring wrote:

> The MIPS R5900 is normally taken to be MIPS3, but it has MOVN, MOVZ and PREF
> defined in MIPS4 which is why ISA_MIPS4 is chosen for this patch.

 It also has several instructions removed, so I don't think you can really 
just mark it MIPS IV without special-casing those instructions, or the 
emulation won't be accurate (and consequently programs that use them won't 
trigger exceptions that they are supposed to).

> Some flags in the mips_defs array are marked FIXME as I don't know the
> proper values.

 Well, the FPU is non-standard so until you implement it I'd rather kept 
it disabled and then all the FPU-related settings can go for now.  For the 
rest see below.

> --- a/target/mips/translate_init.inc.c
> +++ b/target/mips/translate_init.inc.c
> @@ -411,6 +411,26 @@ const mips_def_t mips_defs[] =
>          .mmu_type = MMU_TYPE_R4000,
>      },
>      {
> +        .name = "R5900",
> +        .CP0_PRid = 0x00003800,
> +        /* No L2 cache, icache size 32k, dcache size 32k, uncached coherency. */
> +        .CP0_Config0 = (1 << 17) | (0x3 << 9) | (0x3 << 6) | (0x2 << CP0C0_K0),
> +        /* Note: Config1 is only used internally, the R5900 has only Config0. */
> +        .CP0_Config1 = (1 << CP0C1_FP) | (47 << CP0C1_MMU),

 So I'd clear CP0C1_FP then; also make sure accessing CP0.Config1 from 
emulated code does what it does on actual hardware.

> +        .CP0_LLAddr_rw_bitmask = 0xFFFFFFFF,	/* FIXME */
> +        .CP0_LLAddr_shift = 4,			/* FIXME */

 No LL/SC in the R5900, so the LLAddr settings can go.

> +        .SYNCI_Step = 16,			/* FIXME */

 SYNCI is MIPS32r2+, so this can go.

> +        .CCRes = 2,				/* FIXME */

 Likewise, CCRes is MIPS32r2+, so this can go.

> +        .CP0_Status_rw_bitmask = 0x3678FFFF,	/* FIXME */

 This has to indicate which bits in CP0.Status are writable.  Check with 
the manual and/or actual hardware.

> +        .CP1_fcr0 = (0x38 << FCR0_PRID) | (0x0 << FCR0_REV),
> +        .CP1_fcr31 = 0,
> +        .CP1_fcr31_rw_bitmask = 0x0183FFFF,	/* FIXME */

 This is all FPU stuff and it can go.

> +        .SEGBITS = 40,				/* FIXME */

 This is the number of virtual address bits.  Determined by the highest 
writable CP0.EntryHi.VPN2 bit.

> +        .PABITS = 36,				/* FIXME */

 Likewise physical address bits.  Determined by the highest writable 
CP0.EntryLo0.PFN and CP0.EntryLo1.PFN bit.

> +        .insn_flags = CPU_R5900,
> +        .mmu_type = MMU_TYPE_R4000,		/* FIXME */

 This looks right to me.

 FWIW; I don't have any authority for QEMU maintenance.

  Maciej
