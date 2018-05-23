Received: from eggs.gnu.org ([2001:4830:134:3::10]:41929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHSU-0007lC-5q
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHSQ-0000Qy-TV
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:16:50 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:35798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fLHSQ-0000QM-Lw
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:16:46 -0400
Received: by mail-pg0-x243.google.com with SMTP id 11-v6so6941254pge.2
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 17:16:46 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 23 May 2018 12:14:47 +1200
Message-Id: <1527034517-7851-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 00/30] QEMU 2.13 RISC-V updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>

This is a series of bug fixes, specification conformance
fixes and CPU feature modularily updates to allow more
precise modelling of the SiFive U Series CPUs (multi-core
application processors with MMU, Supervisor and User modes)
and SiFive E Series CPUs (embedded microcontroller cores
without MMU or Supervisor mode). This series adds several
updates to CPU features such as writable 'misa', minimal
hypervisor support for mstatus.TSR/TW/TVM, a new modular
interface for truly atomic CSRs, bug fixes and several
new features such as separate firmware and kernel payload.

These changes are available in the RISC-V GitHub repo:

- https://github.com/riscv/riscv-qemu/tree/qemu-2.13-for-upstream

Summary of changes

* Support separate firmware and kernel payload
  * Can use -bios bbl -kernel vmlinux on 'virt' machine
* Add infrastructure to support runtime 'misa' writes
* Implemented TSR, TW and TVM for privileged ISA v1.10
* Update floating-point to correctly mark mstatus.FS dirty.
* Made PMP (Physical Memory Protection) an optional CPU feature.
* Disabled access to s* CSRs on cores without misa.S set.
* Added CSR feature predicates to improve CPU emulation support
  and to allow for easier CPU model differentiation.
  * SiFive U series application processors (MMU, S-mode, U-mode)
  * SiFive E series embedded microcontrollers (no MMU, U-mode)
* Add non-trapping interface to CSRs so that gdbstub.c can
  accesses CSRs without longjmp being called.
* Implements an interface for atomic CSR accesses and convert
  accesses to 'mip' and 'sip' to the atomic interface:
  * The previous implementation using separate methods for
    csr_read_helper and csr_write_helper was incompatible
    with atomic CSR accesses. The previous implementation
    used monolithic switch statements and was not modular.
  * Add public API so that CPUs can implement custom CSRs.
* Replaces locks with atomic lock-free updates for interrupt
  * Reduce idle Linux SMP CPU usage by up to 35%.
  * Increases CPU performance under load by up to 15%.
* Improved specification conformance of the page table walker
  * Change access checks from ternary operator to if statements.
  * Checks for misaligned PPNs.
  * Disallow M-mode or S-mode from fetching from User pages.
  * Adds reserved PTE flag check: W or W|X.
  * Set READ flag for PTE X flag if mstatus.mxr is in effect.
  * Improves page walker comments and code readability .

Testing Coverage

* Linux Fedora SMP mstatus.FS scheduler test: pass
* Linux Fedora SMP MTTCG tests (~22 hr GCC bootstrap): pass
* spike_v1.9.1 bbl/linux-4.6.2 board test: pass
* spike_v1.10 bbl/linux-4.14 board test: pass
* virt bbl/linux-4.16-rc2 board test: pass
* sifive_e board test (HiFive1 binaries): pass
* sifive_u board test (HiFive Unleashed): pass
* riscv-tests: pass
* checkpatch: pass

Kito Cheng (1):
  RISC-V: linux-user support for RVE ABI

Michael Clark (27):
  RISC-V: Update address bits to support sv39 and sv48
  RISC-V: Improve page table walker spec compliance
  RISC-V: Use atomic_cmpxchg to update PLIC bitmaps
  RISC-V: Simplify riscv_cpu_local_irqs_pending
  RISC-V: Allow setting and clearing multiple irqs
  RISC-V: Move non-ops from op_helper to cpu_helper
  RISC-V: Update CSR and interrupt definitions
  RISC-V: Implement modular CSR helper interface
  RISC-V: Implement atomic mip/sip CSR updates
  RISC-V: Implement existential predicates for CSRs
  RISC-V: Implement mstatus.TSR/TW/TVM
  RISC-V: Add public API for the CSR dispatch table
  RISC-V: Add hartid and \n to interrupt logging
  RISC-V: Use riscv prefix consistently on cpu helpers
  RISC-V: Replace __builtin_popcount with ctpop8 in PLIC
  RISC-V: Add missing free for plic_hart_config
  RISC-V: Allow interrupt controllers to claim interrupts
  RISC-V: Add misa to DisasContext
  RISC-V: Add misa.MAFD checks to translate
  RISC-V: Add misa runtime write support
  RISC-V: Fix CLINT timecmp low 32-bit writes
  RISC-V: Fix PLIC pending bitfield reads
  RISC-V: Enable second UART on sifive_e and sifive_u
  RISC-V: Remove unnecessary disassembler constraints
  elf: Add RISC-V PSABI ELF header defines
  RISC-V: Don't add NULL bootargs to device-tree
  RISC-V: Support separate firmware and kernel payload

Richard Henderson (2):
  RISC-V: Split out mstatus_fs from tb_flags
  RISC-V: Mark mstatus.fs dirty

 disas/riscv.c                           | 138 -----
 hw/riscv/Makefile.objs                  |   1 +
 hw/riscv/boot.c                         | 172 ++++++
 hw/riscv/sifive_clint.c                 |  16 +-
 hw/riscv/sifive_e.c                     |   4 +-
 hw/riscv/sifive_plic.c                  |  72 +--
 hw/riscv/sifive_u.c                     |   8 +-
 hw/riscv/spike.c                        |   6 +-
 hw/riscv/virt.c                         |  73 +--
 include/elf.h                           |   8 +
 include/hw/riscv/boot.h                 |  30 ++
 include/hw/riscv/sifive_plic.h          |   1 -
 linux-user/riscv/cpu_loop.c             |  14 +-
 linux-user/riscv/signal.c               |   4 +-
 target/riscv/Makefile.objs              |   2 +-
 target/riscv/cpu.c                      |   8 +-
 target/riscv/cpu.h                      |  98 +++-
 target/riscv/cpu_bits.h                 | 701 +++++++++++++-----------
 target/riscv/{helper.c => cpu_helper.c} | 177 ++++--
 target/riscv/cpu_user.h                 |   3 +-
 target/riscv/csr.c                      | 921 ++++++++++++++++++++++++++++++++
 target/riscv/fpu_helper.c               |   6 +-
 target/riscv/gdbstub.c                  |  10 +-
 target/riscv/op_helper.c                | 680 ++---------------------
 target/riscv/translate.c                | 286 ++++++++--
 25 files changed, 2103 insertions(+), 1336 deletions(-)
 create mode 100644 hw/riscv/boot.c
 create mode 100644 include/hw/riscv/boot.h
 rename target/riscv/{helper.c => cpu_helper.c} (74%)
 create mode 100644 target/riscv/csr.c

-- 
2.7.0
