Received: from eggs.gnu.org ([2001:4830:134:3::10]:53743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gCUSm-0000fS-JO
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 14:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gCUSi-0001HA-9h
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 14:53:03 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:61403)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gCUSi-0001CI-0J
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 14:53:00 -0400
Date: Tue, 16 Oct 2018 20:52:50 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181016185250.GC2323@sx9>
References: <20181014142928.2784-1-f4bug@amsat.org> <20181014164140.GB2319@sx9>
	<CAAdtpL5xQYwyR0VxqAhA3dW9ec2KW07n-GKrMCt=UjQqwsuYHQ@mail.gmail.com>
	<alpine.LFD.2.21.1810142320320.16498@eddie.linux-mips.org>
	<20181015170202.GB2364@sx9>
	<BN6PR2201MB125130DFBDFBBE67B4CD57A9C6FE0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20181016181916.GB2323@sx9>
	<300f223b-2013-5e31-0dd1-cd9adf0948ba@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <300f223b-2013-5e31-0dd1-cd9adf0948ba@linaro.org>
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
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, "Maciej W. Rozycki" <macro@linux-mips.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>

Hi Richard,

> > /* global register indices */
> > static TCGv cpu_gpr[32], cpu_PC;
> > static TCGv cpu_HI[MIPS_DSP_ACC], cpu_LO[MIPS_DSP_ACC];
> > 
> > One option is to create a new array such as
> > 
> > static TCGv_i64 mmi_gpr[32];
> > 
> > that represents the upper 64 bits of each GPR. Then cpu_gpr must be of
> > a 64-bit type too, even when QEMU runs in 32-bit user mode. The R5900
> > does not implement CP0.Status.UX in hardware, though, so system mode is
> > 64 bits, regardless.
> 
> I would not implement r5900 for mips32 in that case,
> I would implement it only for TARGET_MIPS64.

R5900 Linux implements the O32 ABI, which is why 32-bit QEMU user-mode is
very useful. Perhaps a better alternative is to define the MMI registers
as 128-bit, similar to

static TCGv_u128 mmi_gpr[32];

and then copy cpu_gpr to/from mmi_gpr as needed when running the MMIs?

Fredrik
