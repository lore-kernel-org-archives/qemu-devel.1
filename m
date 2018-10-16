Received: from eggs.gnu.org ([2001:4830:134:3::10]:42070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gCTwN-0006kT-Mo
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 14:19:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gCTwH-0003hG-Q0
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 14:19:33 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:49895)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gCTw9-0003bs-VC
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 14:19:24 -0400
Date: Tue, 16 Oct 2018 20:19:16 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181016181916.GB2323@sx9>
References: <20181014142928.2784-1-f4bug@amsat.org> <20181014164140.GB2319@sx9>
	<CAAdtpL5xQYwyR0VxqAhA3dW9ec2KW07n-GKrMCt=UjQqwsuYHQ@mail.gmail.com>
	<alpine.LFD.2.21.1810142320320.16498@eddie.linux-mips.org>
	<20181015170202.GB2364@sx9>
	<BN6PR2201MB125130DFBDFBBE67B4CD57A9C6FE0@BN6PR2201MB1251.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR2201MB125130DFBDFBBE67B4CD57A9C6FE0@BN6PR2201MB1251.namprd22.prod.outlook.com>
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
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>

Hi Aleksandar,

> A peculiar case of DMULTU would be interesting.

Agreed, DMULTU would be good to test as well. (DMULTU isn't part of the
R5900 ISA, though.)

> It would be nice to implement just a single instruction from MMI, let's
> say PAND, and have a test for it.

Most if not all multimedia instructions operate on 128-bit GPRs, which
means all GPRs need to be extended. I suppose there are several ways to
implement this. The definitions in target/mips/translate.c are:

/* global register indices */
static TCGv cpu_gpr[32], cpu_PC;
static TCGv cpu_HI[MIPS_DSP_ACC], cpu_LO[MIPS_DSP_ACC];

One option is to create a new array such as

static TCGv_i64 mmi_gpr[32];

that represents the upper 64 bits of each GPR. Then cpu_gpr must be of
a 64-bit type too, even when QEMU runs in 32-bit user mode. The R5900
does not implement CP0.Status.UX in hardware, though, so system mode is
64 bits, regardless.

Interestingly, LO and HI are also extended to 128 bits, where the upper
64 bits are used for the I1 pipeline instructions MULT1, etc.

Additionally, a special SA register contains the shift amount used by
the 256-bit funnel shift multimedia instruction QFSRV.

What are your thoughts on making these register extensions in QEMU?

Fredrik
