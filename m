Received: from eggs.gnu.org ([2001:4830:134:3::10]:57721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1caghq-0001NJ-Dx
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:39:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1caghp-0001sz-GO
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:39:34 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:35818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1caghp-0001sb-Ai
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:39:33 -0500
Received: by mail-wm0-x22e.google.com with SMTP id b65so114048706wmf.0
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 02:39:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <40A49F91-60AF-4CDF-B2B6-B6DC2E93EF78@kent.ac.uk>
References: <24f4e37d0c554e379d13a13026efb36f@ex13-live-mbn2.ad.kent.ac.uk>
	<20170203144615.GD642@stefanha-x1.localdomain>
	<40A49F91-60AF-4CDF-B2B6-B6DC2E93EF78@kent.ac.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Feb 2017 10:39:11 +0000
Message-ID: <CAFEAcA_ePwJUVrEh=jXu9Mup=zRwH=CWTjJsKcT7p7tA41ndtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] TCG semantics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Robbins <er209@kent.ac.uk>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 6 February 2017 at 10:14, Ed Robbins <er209@kent.ac.uk> wrote:
> It seems pretty good. I was surprised that call instructions can
> have arguments/return specified, and wonder if those are normally
> just empty, so that emulation of the target stack/registers just
> carries the args/return in the background. Otherwise TCG must be
> detecting the target's arguments/return for each call which would
> need a clever dataflow analysis, or to follow calling convention
> and just hope, right?

"target" is a tricky word here, because it's unclear whether it
means the guest or the host CPU architecture. Note that tcg/README
always means "TCG target" (ie host) when it says "target", as
per section 2.

The "call" instruction is a call to a host function, so the
only calling convention in play is the host OS's ABI. (This
is what we use for calling C helper functions to implement
more complex bits of the guest emulation.) We don't know or
care about the guest's calling convention, because TCG only
sees things at the level of guest instructions and registers.

> I also am not clear about the precise operation of the byte
> swap instruction, but guess it follows the x86 bswap semantics.

Er, there's more than one definition of how to do byteswaps?
These instructions just swap the bytes in the however-many-bytes
wide lump of data they're defined to operate on. (If the
value type is wider than that lump of data then the insns
are allowed to assume the high bytes are zeroes, ie undefined
result if they're not.) Happy to take patches for clarifying
the docs, though.

thanks
-- PMM
