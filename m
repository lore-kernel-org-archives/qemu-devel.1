Received: from eggs.gnu.org ([2001:4830:134:3::10]:45406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEfRE-0003Tw-2A
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 15:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEfR0-0006P8-9p
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 15:00:21 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:20013)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEfQx-0006ML-Ob
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 15:00:12 -0400
Date: Mon, 22 Oct 2018 21:00:07 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181022190007.GD2331@sx9>
References: <cover.1540134918.git.noring@nocrew.org>
	<BN6PR2201MB125165723113459889A6EC59C6F40@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20181022172343.GB2331@sx9>
	<BN6PR2201MB12517EFDBB682826E06B8998C6F40@BN6PR2201MB1251.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR2201MB12517EFDBB682826E06B8998C6F40@BN6PR2201MB1251.namprd22.prod.outlook.com>
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
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi Aleksandar,

> Pull request with 32 patches from this series is already sent, and I would
> like to avoid sending v2 of that request. Let's wait for some time until
> the pull request is hopefully accepted. There will be most likely another
> one at the beginning of the next week.
> 
> We are appoaching QEMU 3.1 soft freeze (Oct 30), and at this point we
> would like to stabilize the code, and to integrate only crucial patches.
> I suggest that you create a new series "target/mips: Amend R5900 support".
> It should be based on the code submitted in the pull request. Place the
> most crucial patches as the first ones, at the beginning of the series.

The R5900 testsuite in tests/tcg/mips/mipsr5900 fails unless ASE_MMI is
part of insn_flags for the R5900:

--- a/target/mips/translate_init.inc.c
+++ b/target/mips/translate_init.inc.c
@@ -466,7 +466,7 @@ const mips_def_t mips_defs[] =
 #endif /* !CONFIG_USER_ONLY */
         .SEGBITS = 32,
         .PABITS = 32,
-        .insn_flags = CPU_R5900,
+        .insn_flags = CPU_R5900 | ASE_MMI,
         .mmu_type = MMU_TYPE_R4000,
     },
     {

Perhaps that is the only (somewhat) crucial problem, depending on how the
testsuites are used, of course.

The other ASE_MMI changes and the disassembly of MULT1 and MULTU1 can wait,
as can R5900 support for MADD, MADDU, MADD1 and MADDU1, in my opinion.

> FPU changes are too risky at this stage od 3.1 development cycle, and I
> would leave them for QEMU 3.2+.

Agreed! As Maciej just noted, there are also toolchain issues that need
to be addressed for the R5900 FPU.

Fredrik
