Received: from eggs.gnu.org ([2001:4830:134:3::10]:47721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1frRl8-0007Lg-8I
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 13:45:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1frRl3-0001Ma-Bf
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 13:45:02 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:36359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1frRl3-0001M9-49
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 13:44:57 -0400
Received: by mail-pg1-x530.google.com with SMTP id h12-v6so5676861pgs.3
	for <qemu-devel@nongnu.org>; Sun, 19 Aug 2018 10:44:56 -0700 (PDT)
References: <CAFEAcA-psdr-AagwvRnVTH7Q-ZN+g1y8+ja3C7wHFOWApaw6Ag@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a00c8c39-1feb-df43-7020-6df97d4d07f9@linaro.org>
Date: Sun, 19 Aug 2018 10:44:51 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-psdr-AagwvRnVTH7Q-ZN+g1y8+ja3C7wHFOWApaw6Ag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] any suggestions for how to handle guests which
 expect to be executing out of icache?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 08/19/2018 03:19 AM, Peter Maydell wrote:
> Hi; I've been playing around this weekend with writing a QEMU
> model for a music player I have (an XDuoo X3). This has a MIPS
> SoC, and its boot process is that the SoC's boot rom loads the
> guest binary into the CPU's icache and dcache (by playing tricks
> with the cache tag bits so that it appears to be precached content
> for a particular physaddr range). The guest binary then runs
> purely out of cache, until it can initialise the real SDRAM and
> relocate itself into that.
> 
> Unfortunately this causes problems for QEMU, because the guest
> binary expects that while it is running out of the icache at
> addresses 0x80000000-0x80004000 it can happily write data to the
> SDRAM at that address without overwriting its own code. Since
> QEMU isn't modelling caches at all, the writes cause the guest
> to corrupt its own code and it falls over.
> 
> Does anybody have any suggestions for how we could model this
> kind of thing?

I assume there are different virtual addresses, or different physical windows
by which SDRAM is written while the relevant cache lines are pinned?  If so, it
should be possible to create little ram segments that are mapped into the
physical+virtual space somewhere with the cache pinning.


r~
