Received: from eggs.gnu.org ([2001:4830:134:3::10]:57190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gFk3V-0003CK-CL
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 14:08:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gFjyZ-0006Ds-L4
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 14:03:23 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:53496
	helo=cvs.linux-mips.org) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gFjyY-0006Ck-KE
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 14:03:19 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
	with ESMTP id S23992735AbeJYSDPX9qdI (ORCPT
	<rfc822;qemu-devel@nongnu.org>); Thu, 25 Oct 2018 20:03:15 +0200
Date: Thu, 25 Oct 2018 19:03:15 +0100 (BST)
Sender: "Maciej W. Rozycki" <macro@linux-mips.org>
From: "Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <20181025170128.GA2309@sx9>
Message-ID: <alpine.LFD.2.21.1810251839110.19280@eddie.linux-mips.org>
References: <20181023203710.GA2239@sx9>
	<9aea2b05-24d7-f845-d899-0c6fec033672@linaro.org>
	<20181025170128.GA2309@sx9>
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
Cc: Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

Hi Fredrik,

> > > Option 3: Extend the mips_opcode::membership field.
> > 
> > It's trivial to extend the field to uint64_t.
> 
> Is the membership field intended to be used? The opcodes for CLZ and CLO
> clash with the R5900 opcodes for MADD1 and MADDU1, resulting in incorrect
> disassembly of MADD1 and MADDU1. For example:
> 
> 	0x70853020 madd1  a2,a0,a1  disassembles into  clz a2 or a1,a0
> 	0x70853021 maddu1 a2,a0,a1  disassembles into  clo a2 or a1,a0
> 
> (CLZ and CLO are members of I32|N55, whereas MADD1 and MADDU1 are EE.)

 It looks like a disassembler bug somewhere then (maybe in your patched 
version only), because the R5900 is not supposed to match I32 (because it 
does not implement the MIPS32 ISA; it's only MIPS I aka I1 with additions 
or MIPS IV aka I4 with exclusions, or anything between with both additions 
and exclusions, with I believe MIPS III aka I3 being the closest match), 
and it is not supposed to match N55 either (because it is obviously not a 
Vr5500 processor).

 Overall this source file is clearly a modified copy of an ancient version 
of the opcode table included with the opcodes library from binutils and I 
think it would benefit from a refresh.  In particular separating an ASE 
field and adding an exclusions field, as it has been done with opcodes, 
would make it much easier to maintain this table.  The table in opcodes is 
already messy due to several exceptions to the alphabetical order (and it 
could be improved a bit I believe), but I find its QEMU version even 
messier.

 HTH,

  Maciej
