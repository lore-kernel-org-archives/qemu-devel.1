Received: from eggs.gnu.org ([2001:4830:134:3::10]:44019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gH9j3-0000IL-3B
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:45:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gH9iv-0000wM-Pt
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:45:08 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:32776
	helo=cvs.linux-mips.org) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gH9iv-0000vu-GR
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:45:01 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
	with ESMTP id S23990824AbeJ2Po5OedB- (ORCPT
	<rfc822;qemu-devel@nongnu.org>); Mon, 29 Oct 2018 16:44:57 +0100
Date: Mon, 29 Oct 2018 15:44:57 +0000 (GMT)
Sender: "Maciej W. Rozycki" <macro@linux-mips.org>
From: "Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <BN6PR2201MB1251F9D0D28E1177AF8E6B8DC6F30@BN6PR2201MB1251.namprd22.prod.outlook.com>
Message-ID: <alpine.LFD.2.21.1810291514390.1741@eddie.linux-mips.org>
References: <20181014142928.2784-1-f4bug@amsat.org> <20181014164140.GB2319@sx9>
	<CAAdtpL5xQYwyR0VxqAhA3dW9ec2KW07n-GKrMCt=UjQqwsuYHQ@mail.gmail.com>
	<alpine.LFD.2.21.1810142320320.16498@eddie.linux-mips.org>
	<20181015170202.GB2364@sx9>
	<BN6PR2201MB125130DFBDFBBE67B4CD57A9C6FE0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20181016181916.GB2323@sx9>
	<300f223b-2013-5e31-0dd1-cd9adf0948ba@linaro.org>
	<BN6PR2201MB12512B1ED5C412208990CC5FC6F20@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<BN6PR2201MB1251A375F642CB64E85135EFC6F30@BN6PR2201MB1251.namprd22.prod.outlook.com>,
	<20181029145106.GA2294@sx9>
	<BN6PR2201MB1251F9D0D28E1177AF8E6B8DC6F30@BN6PR2201MB1251.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Fredrik Noring <noring@nocrew.org>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>

On Mon, 29 Oct 2018, Aleksandar Markovic wrote:

> > > Without TARGET_MIPS64, we can't say we emulate R5900 - we are emulating
> > > some other CPU that never existed.
> > >
> > > Convince me that I am wrong.
> > 
> > R5900 O32 is usable.
> 
> Absolutely not. This kind of emulation infidelity can't be in QEMU 
> upstream. Even one step further, this should be forbidden, impossible to 
> build.

 What do you mean by "R5900 o32 is not usable unless TARGET_MIPS64"?

 The user emulation mode does not emulate a CPU, it emulates an OS's user 
ABI.  None of the MIPS/Linux user ABIs exposes the privileged context and 
the user instruction set is also defined by the ABI, as far as both 
limitations (e.g. in o32 no MIPS III instructions are allowed, though 
32-bit MIPS IV ones are) and extensions (e.g. many FPU instructions, LL/SC 
and RDHWR implemented even if missing from hardware) are concerned.

 So user emulation is never going to be an accurate CPU emulation anyway.

 The R5900 specifically indeed has no way to enforce the o32 instruction 
set, unlike all the other MIPS CPUs, but that has to be considered a 
quirk, because the operation of the disallowed instructions is 
unpredictable in o32 anyway and the first context switch when actually 
executing real Linux rather than QEMU user emulation would clobber user 
registers.  And I don't think we need to define unpredictable operation in 
hardware-specific way, it may well send SIGILL telling the user they did 
something wrong (as opposed to silent context corruption observed with 
real hw).

 If you spoke about system emulation, then that would be a different 
matter and I would tend to agree, noting however that even there QEMU does 
not emulate all aspects of the architecture anyway, so it's always an 
approximation defined such as to fit the people's needs.

 What is this discussion about anyway?  Do you require now for new CPU 
subarchitecture acceptance that the whole instruction set has been 
implemented with the first submission?  I don't think that was the case in 
the past and even artificial inexisting CPUs have been created (which 
still are there AFAICT), but maybe I'm missing something, and of course 
the rules may change.

  Maciej
