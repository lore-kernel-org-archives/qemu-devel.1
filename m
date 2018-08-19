Received: from eggs.gnu.org ([2001:4830:134:3::10]:33195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frT2k-0006aF-NH
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 15:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frT2h-0007r3-QA
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 15:07:16 -0400
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:38183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1frT2h-0007qj-IY
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 15:07:15 -0400
Received: by mail-oi0-x22d.google.com with SMTP id v8-v6so22213739oie.5
	for <qemu-devel@nongnu.org>; Sun, 19 Aug 2018 12:07:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a00c8c39-1feb-df43-7020-6df97d4d07f9@linaro.org>
References: <CAFEAcA-psdr-AagwvRnVTH7Q-ZN+g1y8+ja3C7wHFOWApaw6Ag@mail.gmail.com>
	<a00c8c39-1feb-df43-7020-6df97d4d07f9@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 19 Aug 2018 20:06:54 +0100
Message-ID: <CAFEAcA9-1x-Hp+T+ZW+xHLu2yaG9gVwB4CB1Tm3Lnc3WFP7gig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 August 2018 at 18:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 08/19/2018 03:19 AM, Peter Maydell wrote:
>> Hi; I've been playing around this weekend with writing a QEMU
>> model for a music player I have (an XDuoo X3). This has a MIPS
>> SoC, and its boot process is that the SoC's boot rom loads the
>> guest binary into the CPU's icache and dcache (by playing tricks
>> with the cache tag bits so that it appears to be precached content
>> for a particular physaddr range). The guest binary then runs
>> purely out of cache, until it can initialise the real SDRAM and
>> relocate itself into that.
>>
>> Unfortunately this causes problems for QEMU, because the guest
>> binary expects that while it is running out of the icache at
>> addresses 0x80000000-0x80004000 it can happily write data to the
>> SDRAM at that address without overwriting its own code. Since
>> QEMU isn't modelling caches at all, the writes cause the guest
>> to corrupt its own code and it falls over.
>>
>> Does anybody have any suggestions for how we could model this
>> kind of thing?
>
> I assume there are different virtual addresses, or different physical windows
> by which SDRAM is written while the relevant cache lines are pinned?  If so, it
> should be possible to create little ram segments that are mapped into the
> physical+virtual space somewhere with the cache pinning.

MIPS has the thing where vaddr 0x80000000..0x9fffffff is the
"unmapped cached" segment giving a view of the 0x00000000..0x1fffffff
physaddr space, and 0xa0000000..0xbfffffff is the "unmapped uncached"
segment view on to the same physaddrs. So it executes out of 0x80000000
and writes direct to the SDRAM (and to MMIO devices) via 0xa0000000.

I have a hack where the target/mips code maps in a RAM
memory region and then marks it enabled/disabled, and
also special-cases the virt-to-phys lookup so a lookup
of a vaddr at 0x80000000 resolves to a physaddr of
0x80000000 rather than 0 the way it usually would.
(It's hacky because I'm special-casing assuming the
whole 16K of cache is mapped this way or none is, and
also I've borrowed an IMPDEF 'cache' insn to signal
enabling the mapping and haven't yet figured out when
I should turn it off...but it's good enough to get me
past the bit of guest code that was a problem.)

thanks
-- PMM
