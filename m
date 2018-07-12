Received: from eggs.gnu.org ([2001:4830:134:3::10]:34211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevlough@umich.edu>) id 1fdem9-0006GK-EL
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 12:49:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevlough@umich.edu>) id 1fdem4-0000n7-IY
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 12:49:05 -0400
MIME-Version: 1.0
From: Kevin Loughlin <kevlough@umich.edu>
Date: Thu, 12 Jul 2018 12:48:42 -0400
Message-ID: <CAB30WPccergMTSWWrwj-WhTCcaMvvW7vnAMO3qvy9b9B53N=zA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Native Memory Virtualization in qemu-system-aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-discuss@nongnu.org

I know TrustZone has support for memory virtualization in AArch64, but I'm
looking to create a different model. Namely, I'd like to fully virtualize
the memory map for the "virt" board.

As a basic example of what I want, assuming an execution environment that
runs in a 1GB physical address space (0x0 - 0x3FFFFFFF), I'd like to be
able to switch to a second execution environment with a distinct SW stack
that runs in the second GB of a board memory (0x40000000 - 0x7FFFFFFF). The
key points for my desired memory virtualization are the following...

   1. Both of these environments should have distinct virtual address spaces
   2. The OS in each environment should believe it is running on physical
   addresses 0x0 - 0x3FFFFFFF in both cases.
   3. Neither environment should have access to the physical memory state
   of the other

I initialize distinct AddressSpace and MemoryRegion structures for each of
these GB blocks. Because all I want is a simple shift of physical address
for one environment, I hesitate to mirror the (relatively) complex address
translation process for TrustZone. Does anyone know if it would be better
to either (a) provide custom read/write functions for the shifted
MemoryRegion object, or (b) modify the target/arm code, such as adding a
shift to get_phys_addr() in target/arm/helper.c?

Thanks in advance,

Kevin
