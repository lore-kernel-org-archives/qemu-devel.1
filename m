Received: from eggs.gnu.org ([2001:4830:134:3::10]:46242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fBU80-0004Rq-1L
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fBU7w-0004ht-Rh
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:47:12 -0400
Received: from mail-pg0-x229.google.com ([2607:f8b0:400e:c05::229]:44235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fBU7w-0004hY-JG
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:47:08 -0400
Received: by mail-pg0-x229.google.com with SMTP id 82so4612389pge.11
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 16:47:08 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Thu, 26 Apr 2018 11:45:03 +1200
Message-Id: <1524699938-6764-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 00/35] QEMU 2.13 Privileged ISA emulation
 updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

This is a series of bug fixes, specification conformance
fixes and CPU feature modularily updates to allow more
precise modelling of the SiFive U Series CPUs (multi-core
application processors with MMU, Supervisor and User modes)
and SiFive E Series CPUs (embedded microcontroller cores
without MMU or Supervisor mode). This series focuses on
correct modelling of Privileged ISA v1.10. Earlier versions
of the code had many unimplemented warnings in the control
and status register code. The version submitted upstream
replaced calls to exit with illegal instruction traps. The
changes in this series focus on implementing correct
behaviour, which in some cases is to ignore writes instead
of trapping, and in other cases traps are generated based
on the presence of CPU features or register settings such
as misa.S and mstatus.TSR/TW/TVM. Several other bugs in
the RISC-V QEMU issue tracker are addresssed.

The branch for this patch series can be found here:

- https://github.com/riscv/riscv-qemu/commits/qemu-2.13-for-upstream

The RISC-V QEMU issues that are not yet resolved upstream:

- https://github.com/riscv/riscv-qemu/issues

Summary of changes

* Implemented TSR, TW and TVM for privileged ISA v1.10
* Update floating-point to correctly mark mstatus.FS dirty.
* Implements WARL behavior for CSRs that don't support writes
  * Past behavior of raising traps was non-conformant
    with the RISC-V Privileged ISA Specition v1.10.
* Sets mtval/stval to zero on exceptions without addresses
  * Past behavior of leaving the last value was non-conformant
    with the RISC-V Privileged ISA Specition v1.10. mtval/stval
    must be set on all exceptions; to zero if not supported.
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
* Honour privileged ISA v1.10 counter enable CSRs.
* Improved specification conformance of the page table walker
  * Change access checks from ternary operator to if statements.
  * Checks for misaligned PPNs.
  * Disallow M-mode or S-mode from fetching from User pages.
  * Adds reserved PTE flag check: W or W|X.
  * Set READ flag for PTE X flag if mstatus.mxr is in effect.
  * Improves page walker comments and code readability .
* Make ROMs read-only and implement device-tree size checks
  * Uses memory_region_init_rom and rom_add_blob_fixed_as
* Adds hexidecimal instruction bytes to disassembly output.
* Several code cleanups
  * Replacing hard-coded constants with enums
  * Dead-code elimination

Testing Coverage

* Linux Fedora SMP mstatus.FS scheduler test: pass
* Linux Fedora SMP MTTCG tests (~22 hr GCC bootstrap): pass
* spike_v1.9.1 bbl/linux-4.6.2 board test: pass
* spike_v1.10 bbl/linux-4.14 board test: pass
* virt bbl/linux-4.16-rc2 board test: pass
* sifive_e board test (HiFive1 binaries): pass
* sifive_u board test (HiFive Unleashed): pending
* riscv-tests: pass
* checkpatch: pass

Changelog

v8

* Use riscv prefix consistently on all cpu helpers
* Add hartid and \n to qemu_log in interrupt logging
* Add missing return statement in gdbstub.c
* Implemented TSR, TW and TVM for privileged ISA v1.10
* Merged Richard Henderson's mstatus.fs dirty fix
* Dropped mstatus.FS workaround
* Implemented traps for s* CSR access on CPUs without S mode
* Implemented traps for pmp* CSR access for CPUs without PMP
* Made local interrupt delivery use atomic updates
* Implemented modular CSR interface supporting atomic accesses
* Implemented privileged ISA v1.10 counter enable CSRs
* Fixed mask for sstatus.mxr field when priv ISA <= v1.9.1
* Fixed User/Supervisor access bug in page table walker refactor
* Updated physical address bits to match the priv ISA specification
* Use memory_region_init_rom and rom_add_blob_fixed_as for mask roms

v7

* Fix typo in mstatus.FS workaround comment
* Remove privilege mode from mstatus.mxr page protection check
* Shift class initialization boilerplate patch hunk to correct patch
* Fix typo in include instruction hex in disassembly commit message

v6

* Added workaround for critical mstatus.FS MTTCG bug
* Added fix for incorrect disassembly of addiw

v5

* Dropped fix for memory allocation bug in riscv_isa_string
* Dropped Hold rcu_read_lock when accessing memory

v4

* Added fix for memory allocation bug in riscv_isa_string
* Trivial fix to remove erroneous comment from translate.c

v3

* Refactor rcu_read_lock in PTE update to use single unlock
* Make mstatus.mxr take effect regardless of privilege mode
* Remove unnecessary class init from riscv_hart
* Set mtval/stval to zero on exceptions without addresses

v2

* Remove unused class boilerplate retains qom parent_obj
* Convert cpu definition towards future model
* Honor mstatus.mxr flag in page table walker

v1

* Initial post merge cleanup patch series

Michael Clark (33):
  RISC-V: Replace hardcoded constants with enum values
  RISC-V: Make virt board description match spike
  RISC-V: Use ROM base address and size from memmap
  RISC-V: Remove identity_translate from load_elf
  RISC-V: Remove unused class definitions
  RISC-V: Include instruction hex in disassembly
  RISC-V: Make some header guards more specific
  RISC-V: Make virt header comment title consistent
  RISC-V: Remove EM_RISCV ELF_MACHINE indirection
  RISC-V: Remove erroneous comment from translate.c
  RISC-V: Mark ROM read-only after copying in code
  RISC-V: Update address bits to support sv39 and sv48
  RISC-V: Improve page table walker spec compliance
  RISC-V: Update E order and I extension order
  RISC-V: Hardwire satp to 0 for no-mmu case
  RISC-V: Make mtvec/stvec ignore vectored traps
  RISC-V: No traps on writes to misa,minstret,mcycle
  RISC-V: Clear mtval/stval on exceptions without info
  RISC-V: Allow S-mode mxr access when priv ISA >= v1.10
  RISC-V: Use [ms]counteren CSRs when priv ISA >= v1.10
  RISC-V: Add mcycle/minstret support for -icount auto
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

Richard Henderson (2):
  RISC-V: Split out mstatus_fs from tb_flags
  RISC-V: Mark mstatus.fs dirty

 disas/riscv.c                           |  39 +-
 hw/riscv/riscv_hart.c                   |   6 -
 hw/riscv/sifive_clint.c                 |  17 +-
 hw/riscv/sifive_e.c                     |  54 +-
 hw/riscv/sifive_plic.c                  |  40 +-
 hw/riscv/sifive_u.c                     |  86 ++--
 hw/riscv/spike.c                        |  99 ++--
 hw/riscv/virt.c                         |  80 +--
 include/hw/riscv/sifive_clint.h         |   4 +
 include/hw/riscv/sifive_e.h             |   5 -
 include/hw/riscv/sifive_plic.h          |   1 -
 include/hw/riscv/sifive_u.h             |   9 +-
 include/hw/riscv/spike.h                |  15 +-
 include/hw/riscv/virt.h                 |  13 +-
 linux-user/signal.c                     |   4 +-
 target/riscv/Makefile.objs              |   2 +-
 target/riscv/cpu.c                      |   8 +-
 target/riscv/cpu.h                      |  84 +--
 target/riscv/cpu_bits.h                 | 690 +++++++++++++------------
 target/riscv/{helper.c => cpu_helper.c} | 173 ++++---
 target/riscv/csr.c                      | 871 ++++++++++++++++++++++++++++++++
 target/riscv/fpu_helper.c               |   6 +-
 target/riscv/gdbstub.c                  |  10 +-
 target/riscv/op_helper.c                | 613 ++--------------------
 target/riscv/translate.c                |  53 +-
 25 files changed, 1700 insertions(+), 1282 deletions(-)
 rename target/riscv/{helper.c => cpu_helper.c} (73%)
 create mode 100644 target/riscv/csr.c

-- 
2.7.0
