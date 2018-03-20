Received: from eggs.gnu.org ([2001:4830:134:3::10]:39852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eyPhx-0007kv-1S
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 18:26:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eyPht-0000Vq-2Z
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 18:26:17 -0400
Received: from mail-pl0-x22f.google.com ([2607:f8b0:400e:c01::22f]:35857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eyPhs-0000VA-P8
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 18:26:12 -0400
Received: by mail-pl0-x22f.google.com with SMTP id 61-v6so1914358plf.3
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 15:26:12 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Tue, 20 Mar 2018 15:25:22 -0700
Message-Id: <1521584722-39133-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/25] RISC-V Post-merge spec conformance and
 cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The following changes since commit f1a63fcfcd92c88be8942b5ae71aef9749a4f135:

  Update version for v2.12.0-rc0 release (2018-03-20 19:04:22 +0000)

are available in the git repository at:

  https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-2.12-fixes

for you to fetch changes up to e1a247183ac0816284dfda61423f7030b6686679:

  RISC-V: Remove erroneous comment from translate.c (2018-03-20 14:34:13 -0700)

- ----------------------------------------------------------------
This is a series of spec conformance bug fixes and code cleanups
that we would like to get in before the QEMU 2.12 release.

* Implements WARL behavior for CSRs that don't support writes
* Improves specification conformance of the page table walker
  * Change access checks from ternary operator to if statements
  * Checks for misaligned PPNs
  * Disallow M-mode or S-mode from fetching from User pages
  * Adds reserved PTE flag check: W or W|X
  * Set READ flag for PTE X flag if mstatus.mxr is in effect
  * Improves page walker comments and general readability
* Several trivial code cleanups to hw/riscv
  * Replacing hard coded constants with reference to enums
    or the machine memory maps.
  * Remove unnecessary class initialization boilerplate
* Adds bounds checks when writing device-tree to ROM
* Updates the cpu model to use a more modern interface
* Sets mtval/stval to zero on exceptions without addresses
* Fixes memory allocation bug in riscv_isa_string

v4

* added fix for memory allocation bug in riscv_isa_string

v3

* refactor rcu_read_lock in PTE update to use single unlock
* mstatus.mxr is in effect regardless of privilege mode
* remove unnecessary class init from riscv_hart
* set mtval/stval to zero on exceptions without addresses

v2

* remove unused class boilerplate retains qom parent_obj
* convert cpu definition towards future model
* honor mstatus.mxr flag in page table walker

v1

* initial post merge cleanup patch series

- ----------------------------------------------------------------
Michael Clark (25):
      RISC-V: Make virt create_fdt interface consistent
      RISC-V: Replace hardcoded constants with enum values
      RISC-V: Make virt board description match spike
      RISC-V: Use ROM base address and size from memmap
      RISC-V: Remove identity_translate from load_elf
      RISC-V: Mark ROM read-only after copying in code
      RISC-V: Remove unused class definitions
      RISC-V: Make sure rom has space for fdt
      RISC-V: Include intruction hex in disassembly
      RISC-V: Hold rcu_read_lock when accessing memory
      RISC-V: Improve page table walker spec compliance
      RISC-V: Update E order and I extension order
      RISC-V: Make some header guards more specific
      RISC-V: Make virt header comment title consistent
      RISC-V: Use memory_region_is_ram in pte update
      RISC-V: Remove EM_RISCV ELF_MACHINE indirection
      RISC-V: Hardwire satp to 0 for no-mmu case
      RISC-V: Remove braces from satp case statement
      RISC-V: riscv-qemu port supports sv39 and sv48
      RISC-V: vectored traps are optional
      RISC-V: No traps on writes to misa,minstret,mcycle
      RISC-V: Remove support for adhoc X_COP interrupt
      RISC-V: Convert cpu definition towards future model
      RISC-V: Clear mtval/stval on exceptions without info
      RISC-V: Remove erroneous comment from translate.c

 disas/riscv.c                   |  39 +++++++------
 hw/riscv/riscv_hart.c           |   6 --
 hw/riscv/sifive_clint.c         |   9 +--
 hw/riscv/sifive_e.c             |  34 +----------
 hw/riscv/sifive_u.c             |  65 +++++++--------------
 hw/riscv/spike.c                |  65 ++++++++-------------
 hw/riscv/virt.c                 |  77 +++++++++----------------
 include/hw/riscv/sifive_clint.h |   4 ++
 include/hw/riscv/sifive_e.h     |   5 --
 include/hw/riscv/sifive_u.h     |   9 ++-
 include/hw/riscv/spike.h        |  15 ++---
 include/hw/riscv/virt.h         |  17 +++---
 target/riscv/cpu.c              | 125 ++++++++++++++++++++++------------------
 target/riscv/cpu.h              |   6 +-
 target/riscv/cpu_bits.h         |   3 -
 target/riscv/helper.c           |  84 ++++++++++++++++++++-------
 target/riscv/op_helper.c        |  52 ++++++++---------
 target/riscv/translate.c        |   1 -
 18 files changed, 281 insertions(+), 335 deletions(-)
-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQR8mZMOsXzYugc9Xvpr8dezV+8+TwUCWrGJWgAKCRBr8dezV+8+
Tw34AJ9QquvDTCdzOS6k2bfUvCppUaQ3KACghKuKfhjypUM7L5SM9CuvKPovfNc=
=SI2p
-----END PGP SIGNATURE-----
