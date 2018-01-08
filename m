Received: from eggs.gnu.org ([2001:4830:134:3::10]:58562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eYgZC-00086w-QJ
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 18:10:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eYgZ9-0007Nj-FL
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 18:10:54 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:63193)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eYgZ9-0007Jl-1n
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 18:10:51 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  9 Jan 2018 00:10:42 +0100
Message-Id: <20180108231048.23966-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 0/6] target/m68k: supervisor mode (part 2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

This series introduces the MC68040 MMU.

But first of all, we need to modify the prototype
of tlb_fill() and handle_mmu_fault handler to pass
the size of the access. MC68040 stores this value
in the exception stack frame.

Following patches add:
- MMU page table and fault handlers,
- Transparent Translation Registers
- instruction "moves" to move data
  between user and kernel space
- instructions pflush/ptest, to flush TLB and
  convert virtual address to physical address
- "info tlb" HMP command

I have tested it doesn't break QEMU linux-user mode
emulation and coldfire softmmu machine.

With the help of these patches I'm able to start
a debian etch-m68k, but the following patches
are still missing in master:
- m68k softfloat series
- Quadra 800 machine emulation series
  (VIA emulation, Nubus emulation,
   ESCC control/data address bit selector,
   video card emulation, ESP Pseudo-DMA,
   SWIM floppy controller, Apple Sound Chip
   emulation, and some big-endian fixes for
   dp8393x)

Laurent Vivier (6):
  accel/tcg: add size paremeter in tlb_fill()
  target/m68k: add MC68040 MMU
  target/m68k: add Transparent Translation
  target/m68k: add moves
  target/m68k: add pflush/ptest
  target/m68k: add HMP command "info tlb"

 accel/tcg/cputlb.c            |  13 +-
 accel/tcg/softmmu_template.h  |  14 +-
 accel/tcg/user-exec.c         |   2 +-
 hmp-commands-info.hx          |   2 +-
 include/exec/exec-all.h       |   6 +-
 include/qom/cpu.h             |   2 +-
 target/alpha/cpu.h            |   2 +-
 target/alpha/helper.c         |   4 +-
 target/alpha/mem_helper.c     |   6 +-
 target/arm/cpu.c              |   4 +-
 target/arm/op_helper.c        |   4 +-
 target/cris/cpu.h             |   2 +-
 target/cris/helper.c          |   4 +-
 target/cris/op_helper.c       |   6 +-
 target/hppa/cpu.h             |   3 +-
 target/hppa/helper.c          |   2 +-
 target/hppa/op_helper.c       |   2 +-
 target/i386/cpu.h             |   2 +-
 target/i386/excp_helper.c     |   4 +-
 target/i386/mem_helper.c      |   6 +-
 target/lm32/cpu.h             |   2 +-
 target/lm32/helper.c          |   2 +-
 target/lm32/op_helper.c       |   6 +-
 target/m68k/cpu.c             |   4 +-
 target/m68k/cpu.h             | 129 +++++++-
 target/m68k/helper.c          | 673 +++++++++++++++++++++++++++++++++++++++++-
 target/m68k/helper.h          |   4 +
 target/m68k/monitor.c         |  22 ++
 target/m68k/op_helper.c       | 102 ++++++-
 target/m68k/qregs.def         |   2 +
 target/m68k/translate.c       | 112 +++++++
 target/microblaze/cpu.h       |   2 +-
 target/microblaze/helper.c    |   4 +-
 target/microblaze/op_helper.c |   6 +-
 target/mips/helper.c          |   2 +-
 target/mips/internal.h        |   2 +-
 target/mips/op_helper.c       |  10 +-
 target/moxie/cpu.h            |   2 +-
 target/moxie/helper.c         |  10 +-
 target/nios2/cpu.h            |   2 +-
 target/nios2/helper.c         |   6 +-
 target/nios2/mmu.c            |   6 +-
 target/openrisc/cpu.h         |   2 +-
 target/openrisc/mmu.c         |   8 +-
 target/openrisc/mmu_helper.c  |   6 +-
 target/ppc/cpu.h              |   2 +-
 target/ppc/mmu_helper.c       |   4 +-
 target/ppc/user_only_helper.c |   2 +-
 target/s390x/excp_helper.c    |   4 +-
 target/s390x/internal.h       |   2 +-
 target/s390x/mem_helper.c     |   8 +-
 target/sh4/cpu.h              |   2 +-
 target/sh4/helper.c           |   4 +-
 target/sh4/op_helper.c        |   6 +-
 target/sparc/cpu.h            |   2 +-
 target/sparc/ldst_helper.c    |   6 +-
 target/sparc/mmu_helper.c     |   6 +-
 target/tilegx/cpu.c           |   4 +-
 target/tricore/op_helper.c    |   4 +-
 target/unicore32/cpu.h        |   2 +-
 target/unicore32/helper.c     |   2 +-
 target/unicore32/op_helper.c  |   6 +-
 target/unicore32/softmmu.c    |   2 +-
 target/xtensa/op_helper.c     |   4 +-
 64 files changed, 1156 insertions(+), 132 deletions(-)

-- 
2.14.3
