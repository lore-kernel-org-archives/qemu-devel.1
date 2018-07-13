Received: from eggs.gnu.org ([2001:4830:134:3::10]:47138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdzu1-0004i0-L3
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 11:22:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdzu0-0002FJ-PB
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 11:22:37 -0400
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:44354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fdzu0-0002Ej-B5
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 11:22:36 -0400
Received: by mail-oi0-x232.google.com with SMTP id s198-v6so62877682oih.11
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 08:22:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAB30WPccergMTSWWrwj-WhTCcaMvvW7vnAMO3qvy9b9B53N=zA@mail.gmail.com>
References: <CAB30WPccergMTSWWrwj-WhTCcaMvvW7vnAMO3qvy9b9B53N=zA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jul 2018 16:22:15 +0100
Message-ID: <CAFEAcA8v762p3JSQ=9Vu68-evYS5MMH467pAo8=XZWsw+x6s7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Native Memory Virtualization in qemu-system-aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Loughlin <kevlough@umich.edu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, qemu-discuss <qemu-discuss@nongnu.org>

On 12 July 2018 at 17:48, Kevin Loughlin <kevlough@umich.edu> wrote:
> I know TrustZone has support for memory virtualization in AArch64, but I'm
> looking to create a different model. Namely, I'd like to fully virtualize
> the memory map for the "virt" board.
>
> As a basic example of what I want, assuming an execution environment that
> runs in a 1GB physical address space (0x0 - 0x3FFFFFFF), I'd like to be
> able to switch to a second execution environment with a distinct SW stack
> that runs in the second GB of a board memory (0x40000000 - 0x7FFFFFFF). The
> key points for my desired memory virtualization are the following...
>
>    1. Both of these environments should have distinct virtual address spaces
>    2. The OS in each environment should believe it is running on physical
>    addresses 0x0 - 0x3FFFFFFF in both cases.
>    3. Neither environment should have access to the physical memory state
>    of the other
>
> I initialize distinct AddressSpace and MemoryRegion structures for each of
> these GB blocks. Because all I want is a simple shift of physical address
> for one environment, I hesitate to mirror the (relatively) complex address
> translation process for TrustZone. Does anyone know if it would be better
> to either (a) provide custom read/write functions for the shifted
> MemoryRegion object, or (b) modify the target/arm code, such as adding a
> shift to get_phys_addr() in target/arm/helper.c?

I'm a bit confused about what you're trying to do. Without TrustZone,
by definition there is only one physical address space (ie all of
memory/devices/etc are addressed by a single 64-bit physaddr).
There's no way to cause the CPU to not have access to it.
With TrustZone, you can think of the system as having two physical
address spaces (so to access something you need to specify both
a 64-bit physaddr and the TZ secure/nonsecure bit), and the CPU
and the system design cooperate to enforce that code running in the
nonsecure world can't get at things in the system it should not have
access to.

The whole point of TZ is to allow you to do this sort of partitioning.
Without it there's no way for the system (RAM or whatever) to know which
environment is running on the CPU.

You could in theory design and implement a non-standard extension to
the architecture to do equivalent things to what TZ is doing I suppose,
but that would be a lot of work and a lot of fragile modifications
to QEMU.

thanks
-- PMM
