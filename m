Received: from eggs.gnu.org ([2001:4830:134:3::10]:42502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <steven.seeger@flightsystems.net>) id 1emQgX-0001Ia-3m
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 16:03:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <steven.seeger@flightsystems.net>) id 1emQgS-00077G-7j
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 16:03:17 -0500
Received: from p3plsmtpa11-06.prod.phx3.secureserver.net
	([68.178.252.107]:59877)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <steven.seeger@flightsystems.net>)
	id 1emQgS-00076u-0Y
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 16:03:12 -0500
From: Steven Seeger <steven.seeger@flightsystems.net>
Reply-To: steven.seeger@flightsystems.net
Date: Thu, 15 Feb 2018 16:03:05 -0500
Message-ID: <3370102.LRrLPoLVVs@wirbelwind>
In-Reply-To: <CAFEAcA_xHpd5_RVp4_Be3wOa_U6YTpN0wiKheMYApuSOkbtjHw@mail.gmail.com>
References: <5193436.NpsRQSl3SI@wirbelwind>
	<CAFEAcA_xHpd5_RVp4_Be3wOa_U6YTpN0wiKheMYApuSOkbtjHw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 01/02] fix issue where a branch to pc+4
 confuses GDB because pc and npc are set to the same value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

On Thursday, February 15, 2018 2:39:34 PM EST Peter Maydell wrote:
> On 15 February 2018 at 19:15, Steven Seeger
> These changes look rather odd -- are you sure they're right?
> This is the code for unconditional taken branch, not annulled, and
> my copy of the sparc architecture manual says that in that case
> the new PC value should be the old nPC value, and the new
> nPC value should be the effective address of the branch target.
> There's nothing in there about branches into your own delay
> slot being a special case. Adding 4 to target like this will
> make the new nPC value be 4 further forward, which would mean
> we'd only execute the branch target instruction once, rather
> than twice (once for it being in the branch delay slot and
> once as the instruction target).
> 
> It's a weird thing to do so I wouldn't be surprised if gdb
> mishandled it. Have you tested against real sparc hardware?
> 
> thanks
> -- PMM

Hi Peter. Thank you for the thoughtful reply. I did not consider the 
possibility that in this case the instruction should execute twice. The issue 
here is that when stepping through code in gdb, after the branch to the delay 
slot, pc==npc. So subsequent steps actually go nowhere. This could maybe be a 
problem with GDB, but I don't think so.

I will have access to real hardware Tuesday and will test this case.

If the instruction should execute twice, then we may need to kick npc in qemu 
in order to alleviate this.

Steven
