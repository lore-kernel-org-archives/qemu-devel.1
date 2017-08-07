Received: from eggs.gnu.org ([2001:4830:134:3::10]:45174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dejC5-00035R-B9
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:39:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dejC0-0006YU-EL
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:39:45 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  7 Aug 2017 15:39:12 +0100
Message-Id: <1502116754-18867-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] loader: Handle ELF files with overlapping
 zero-init data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, Hua Yanghao <huayanghao@gmail.com>

For embedded systems, notably ARM, one common use of ELF file
segments is that the 'physical addresses' represent load addresses
and the 'virtual addresses' execution addresses, such that the load
addresses are packed into ROM or flash, and the relocation and
zero-initialization of data is done at runtime.  This means that the
'memsz' in the segment header represents the runtime size of the
segment, but the size that needs to be loaded is only the 'filesz'. 
In particular, paddr+memsz may overlap with another segment to be
loaded, as in this example:

0x70000001 off    0x00007f68 vaddr 0x00008150 paddr 0x00008150 align 2**2
         filesz 0x00000008 memsz 0x00000008 flags r--
    LOAD off    0x000000f4 vaddr 0x00000000 paddr 0x00000000 align 2**2
         filesz 0x00000124 memsz 0x00000124 flags r--
    LOAD off    0x00000218 vaddr 0x00000400 paddr 0x00000400 align 2**3
         filesz 0x00007d58 memsz 0x00007d58 flags r-x
    LOAD off    0x00007f70 vaddr 0x20000140 paddr 0x00008158 align 2**3
         filesz 0x00000a80 memsz 0x000022f8 flags rw-
    LOAD off    0x000089f0 vaddr 0x20002438 paddr 0x00008bd8 align 2**0
         filesz 0x00000000 memsz 0x00004000 flags rw-
    LOAD off    0x000089f0 vaddr 0x20000000 paddr 0x20000000 align 2**0
         filesz 0x00000000 memsz 0x00000140 flags rw-

where the segment at paddr 0x8158 has a memsz of 0x2258 and
would overlap with the segment at paddr 0x8bd8 if QEMU's loader
tried to honour it. (At runtime the segments will not overlap
since their vaddrs are more widely spaced than their paddrs.)

Currently if you try to load an ELF file like this with QEMU then
it will fail with an error "rom: requested regions overlap",
because we create a ROM image for each segment using the memsz
as the size.

This patchset adds support for ELF files using this scheme, by
truncating the zero-initialized part of the segment if it would
overlap another segment.  This will retain the existing loader
behaviour for all ELF files we currently accept, and also accept ELF
files which only need 'filesz' bytes to be loaded.

Patch 2 deals with a vaguely related issue which is that if the ELF
file specified a zero-length segment we would happily try to create
a zero-length ROM blob, which could then falsely trigger the
ROM-overlap check. (The zero-length case is more common after patch
1 has done its truncation thing, but I have seen real-world ELF
files with both filesz and memsz zero...)

thanks
-- PMM

Peter Maydell (2):
  loader: Handle ELF files with overlapping zero-initialized data
  loader: Ignore zero-sized ELF segments

 include/hw/elf_ops.h | 72 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 65 insertions(+), 7 deletions(-)

-- 
2.7.4
