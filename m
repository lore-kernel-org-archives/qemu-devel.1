Received: from eggs.gnu.org ([2001:4830:134:3::10]:37739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gEezr-0005kb-87
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:32:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gEezn-0007fY-3a
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:32:11 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:36832
	helo=cvs.linux-mips.org) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gEezm-0007ZX-NC
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:32:06 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
	with ESMTP id S23994612AbeJVSb5gtqAL (ORCPT
	<rfc822;qemu-devel@nongnu.org>); Mon, 22 Oct 2018 20:31:57 +0200
Date: Mon, 22 Oct 2018 19:31:57 +0100 (BST)
Sender: "Maciej W. Rozycki" <macro@linux-mips.org>
From: "Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <20181022172343.GB2331@sx9>
Message-ID: <alpine.LFD.2.21.1810221901170.19280@eddie.linux-mips.org>
References: <cover.1540134918.git.noring@nocrew.org>
	<BN6PR2201MB125165723113459889A6EC59C6F40@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20181022172343.GB2331@sx9>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

Hi Maciej,

> > I added ASE_MMI flag along with INSN_R5900, I think this fits better in
> > the overall MIPS for QEMU design.
> 
> Maciej -- can we add "MMI" under "ASEs implemented" in the kernel too,
> even if it is a vendor-specific architecture extension that normally
> isn't counted as an ASE? QEMU simply calls these "vendor specific ASEs".

 I have no authority to approve such a change for the kernel, but it looks 
reasonable to me and I will support you with it, with one reservation 
however.  As this is an ISA extension in the vendor-specific space, I 
think it belongs to a vendor-specific namespace, so as to make it clear it 
is not a generic architectural feature and also to avoid name clashes.

 So it has to be called Toshiba MMI or suchlike, similarly to how I 
requested that for the Longsoon MMI feature in a recent binutils review 
(cf <https://sourceware.org/ml/binutils/2018-07/msg00201.html> and 
binutils commit 8095d2f70e1a ("MIPS/GAS: Split Loongson MMI Instructions 
from loongson2f/3a")), with all the consequences throughout.

> Aleksandar -- please or ASE_MMI to insn_flags here:
> 
> --- a/target/mips/translate_init.inc.c
> +++ b/target/mips/translate_init.inc.c
> @@ -466,7 +466,7 @@ const mips_def_t mips_defs[] =
>  #endif /* !CONFIG_USER_ONLY */
>          .SEGBITS = 32,
>          .PABITS = 32,
> -        .insn_flags = CPU_R5900,
> +        .insn_flags = CPU_R5900 | ASE_MMI,
>          .mmu_type = MMU_TYPE_R4000,
>      },
>      {

 So I think it better be called ASE_TOSHIBA_MMI here.

> Strictly speaking, MADD, MADDU, MULT, MULTU, MULT1, MULTU1, DIV1, DIVU1,
> MADD1, MADDU1, MFHI1, MFLO1, MTHI1 and MTLO1 are not part of what the
> Toshiba TX System RISC TX79 Core Architecture manual specifies as
> "Multimedia Instructions", section B.3.2, on page B-3, even though
> their opcodes are covered by TX79_CLASS_MMI and the decode_tx79_mmi
> function. Can we adjust ASE_MMI for QEMU accordingly?

 NB all but pipeline 1 instructions of these are also implemented by other 
members of the TXx9 family.  They seem to be referred to as just "multiply 
and multiply-add instructions" in the TX79 manual (cf Section B.3.1).

> Also, doesn't it make sense to cover LQ and SQ with ASE_MMI as well, as
> those two really are MMIs?

 And they're certainly listed as such in the TX79 manual (cf Section 
B.3.2).

> Regarding the R5900 FPU: It appears reasonable to introduce an ELF ABI
> variant for the nonstandard R5900 FPU.

 Indeed and in particular given that the R5900 does not produce any FPU 
exceptions it should be quite straightforward for the Linux kernel to 
recognise this specific ABI annotation with ELF binaries and switch its FP 
environment between R5900 native float and IEEE 754 emulated float 
accordingly.  We could then make QEMU run in the user emulation mode do 
the same.

 Of course all the pieces of the toolchain as well as the dynamic loader 
in use would have to taught to prevent incompatible pieces of hard float 
code from being used together.

  Maciej
