Received: from eggs.gnu.org ([2001:4830:134:3::10]:54180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fF6jY-0003mk-AH
	for qemu-devel@nongnu.org; Sat, 05 May 2018 19:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fF6jT-0003Ve-Uy
	for qemu-devel@nongnu.org; Sat, 05 May 2018 19:36:56 -0400
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236]:44997)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fF6jT-0003Un-Oy
	for qemu-devel@nongnu.org; Sat, 05 May 2018 19:36:51 -0400
Received: by mail-pg0-x236.google.com with SMTP id 82-v6so17771093pge.11
	for <qemu-devel@nongnu.org>; Sat, 05 May 2018 16:36:51 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Sun,  6 May 2018 11:35:05 +1200
Message-Id: <1525563325-62963-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/20] RISC-V: QEMU 2.13 Privileged ISA
 emulation updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Alistair Francis <alistair.francis@xilinx.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

The following changes since commit c8b7e627b4269a3bc3ae41d9f420547a47e6d9b9:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-05-04' into staging (2018-05-04 14:42:46 +0100)

are available in the git repository at:

  https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-2.13-pull-20180506

for you to fetch changes up to 5aec3247c190f10654250203a1742490ae7343a2:

  RISC-V: Mark ROM read-only after copying in code (2018-05-06 10:54:21 +1200)

----------------------------------------------------------------
RISC-V: QEMU 2.13 Privileged ISA emulation updates

Several code cleanups, minor specification conformance changes,
fixes to make ROM read-only and add device-tree size checks.

* Honour privileged ISA v1.10 counter enable CSRs.
* Implements WARL behavior for CSRs that don't support writes
  * Past behavior of raising traps was non-conformant
    with the RISC-V Privileged ISA Specification v1.10.
* Allow S-mode access to sstatus.MXR when priv ISA >= v1.10
* Sets mtval/stval to zero on exceptions without addresses
  * Past behavior of leaving the last value was non-conformant
    with the RISC-V Privileged ISA Specition v1.10. mtval/stval
    must be set on all exceptions; to zero if not supported.
* Make ROMs read-only and implement device-tree size checks
  * Uses memory_region_init_rom and rom_add_blob_fixed_as
* Adds hexidecimal instruction bytes to disassembly output.
* Fixes missing break statement for rv128 disassembly.
* Several code cleanups
  * Replacing hard-coded constants with enums
  * Dead-code elimination

This is an incremental pull that contains 20 reviewed changes out
of 38 changes currently queued in the qemu-2.13-for-upstream branch.

----------------------------------------------------------------
Michael Clark (20):
      RISC-V: Replace hardcoded constants with enum values
      RISC-V: Make virt board description match spike
      RISC-V: Use ROM base address and size from memmap
      RISC-V: Remove identity_translate from load_elf
      RISC-V: Remove unused class definitions
      RISC-V: Include instruction hex in disassembly
      RISC-V: Fix missing break statement in disassembler
      RISC-V: Make some header guards more specific
      RISC-V: Make virt header comment title consistent
      RISC-V: Remove EM_RISCV ELF_MACHINE indirection
      RISC-V: Remove erroneous comment from translate.c
      RISC-V: Update E and I extension order
      RISC-V: Hardwire satp to 0 for no-mmu case
      RISC-V: Clear mtval/stval on exceptions without info
      RISC-V: Allow S-mode mxr access when priv ISA >= v1.10
      RISC-V: Use [ms]counteren CSRs when priv ISA >= v1.10
      RISC-V: Add mcycle/minstret support for -icount auto
      RISC-V: Make mtvec/stvec ignore vectored traps
      RISC-V: No traps on writes to misa,minstret,mcycle
      RISC-V: Mark ROM read-only after copying in code

 disas/riscv.c                   |  42 ++++++------
 hw/riscv/riscv_hart.c           |   6 --
 hw/riscv/sifive_clint.c         |   9 +--
 hw/riscv/sifive_e.c             |  54 +++------------
 hw/riscv/sifive_u.c             |  91 ++++++++++---------------
 hw/riscv/spike.c                | 104 +++++++++++++----------------
 hw/riscv/virt.c                 |  85 +++++++++---------------
 include/hw/riscv/sifive_clint.h |   4 ++
 include/hw/riscv/sifive_e.h     |   5 --
 include/hw/riscv/sifive_u.h     |   9 ++-
 include/hw/riscv/spike.h        |  15 ++---
 include/hw/riscv/virt.h         |  17 ++---
 target/riscv/cpu.c              |   2 +-
 target/riscv/cpu.h              |   8 +--
 target/riscv/helper.c           |   8 +++
 target/riscv/op_helper.c        | 143 +++++++++++++++++++++++++++++-----------
 target/riscv/translate.c        |   3 +-
 17 files changed, 287 insertions(+), 318 deletions(-)

-- 
2.7.0
