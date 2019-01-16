Received: from eggs.gnu.org ([209.51.188.92]:41304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gjnFb-0000YE-75
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 10:37:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gjnFZ-0007h1-VE
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 10:37:06 -0500
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:45624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gjnFZ-0007a7-1o
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 10:37:05 -0500
Date: Wed, 16 Jan 2019 16:36:54 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20190116153654.GA2918@sx9>
References: <cover.1547403692.git.noring@nocrew.org>
	<781155aaf175ea20903c12e26316ea40085457bb.1547403692.git.noring@nocrew.org>
	<BN6PR2201MB12516C7D2E235DA81812DDF0C6810@BN6PR2201MB1251.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR2201MB12516C7D2E235DA81812DDF0C6810@BN6PR2201MB1251.namprd22.prod.outlook.com>
Subject: Re: [Qemu-devel] [PATCH 1/9] target/mips: Require TARGET_MIPS64 for
 R5900 multimedia instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, qemu-devel@nongnu.org

Hi Aleksandar,

> Sorry, I have to disagree with this.

It was, without a doubt, entirely clear that the o32 ABI was going to stay
in after this MMI patch series. In other words, this series does not imply
the removal of o32. This is obvious, as discussed previously, since the o32
ABI is currently the main use case for R5900 QEMU and the reason the R5900
was implemented for QEMU to begin with.

> Processor model must stay the same, and
> Linux ABI should not affect, for example, the number and size of processor
> registers - just like it is the case in reality.

I thought Maciej's reply to you was quite clear on this topic?

> QEMU is an independent software tool - it is for example, a compiler-agnostic
> tool, and the only connection between a compiler and QEMU is the processor
> documentation - and this is the reason they work together so well. They shouldn't
> be "tweaked" and "integrated" to work together - both QEMU and compiler should
> rely only on the processor specification, and should not know anything about the
> other side.

The approach was to implement ABIs and instructions that are actually used,
and leave unused or optional instructions for later. The reverse, removing
ABIs in-use (o32) and focusing on unused instructions (MMIs) does not make
sense, so I will obviously not do that.

> My advice for you is to focus on n32 at the time being.
> 
> o32 can be implemented with the same 64-bit processor model, but in a much
> different way that you attempted some time ago. To avoid waste of our energy
> and time, I am suggesting that we finish n32, and think of o32 in future.

The o32 ABI is more important than n32 now, because o32 is in-use and
ready with Glibc, GCC, GAS and the Linux kernel. n32 is easy to enable
with a three-line patch, so we can actually use both now.

I recommend that we implement limited support for MMIs for n32 and
eventually system mode, and leave it as unsupported for o32 for the time
being. [ Perhaps MMIs for o32 could be implemented with 96-bit registers,
in contrast to the 64-bit registers for n32, but having LW and LQ without
LD seems strange to me. ]

Fredrik
