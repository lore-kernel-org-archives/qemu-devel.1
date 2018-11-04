Received: from eggs.gnu.org ([2001:4830:134:3::10]:33898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gJICq-0000av-HQ
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 08:12:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gJICn-0008L3-EH
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 08:12:44 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:44382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gJICn-0008D8-6B
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 08:12:41 -0500
Date: Sun, 4 Nov 2018 14:12:36 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181104131236.GA30862@sx9>
References: <cover.1541174426.git.noring@nocrew.org>
	<fa2941ee17c35fba2512ab530bde3a1807d5769e.1541174426.git.noring@nocrew.org>
	<1001e61e-b6c0-1a41-9e9f-e2fd5a51f7b5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1001e61e-b6c0-1a41-9e9f-e2fd5a51f7b5@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 1/2] target/mips: Fix decoding mechanism of
 R5900 MFLO1, MFHI1, MTLO1 and MTHI1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, "Maciej W. Rozycki" <macro@linux-mips.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

Thank you for your reviews, Philippe and Richard,

> > +    switch (opc) {
> > +    case TX79_MMI_MFHI1:
> > +#if defined(TARGET_MIPS64)
> > +        tcg_gen_ext32s_tl(cpu_gpr[reg], cpu_HI[1]);
> > +#else
> > +        tcg_gen_mov_tl(cpu_gpr[reg], cpu_HI[1]);
> > +#endif
> 
> You do not need this ifdef.  This is already done in tcg/tcg-op.h:
> 
> $ grep tcg_gen_ext32s_tl tcg/tcg-op.h
> #define tcg_gen_ext32s_tl tcg_gen_ext32s_i64
> #define tcg_gen_ext32s_tl tcg_gen_mov_i32

It appears the correct function is tcg_gen_mov_tl because the TX79 manual
says

	MFHI:  GPR[rd]63..0 <- HI63..0
	MFLO:  GPR[rd]63..0 <- LO63..0
	MTHI:  HI63..0 <- GPR[rs]63..0
	MTLO:  LO63..0 <- GPR[rs]63..0
	MFHI1: GPR[rd]63..0 <- HI127..64
	MFLO1: GPR[rd]63..0 <- LO127..64
	MTHI1: HI127..64 <- GPR[rs]63..0
	MTLO1: LO127..64 <- GPR[rs]63..0

so the GPR is copied to/from in full in all cases. This is slightly
different to how acc = 1 is handled in gen_HILO.

Fredrik
