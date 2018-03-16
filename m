Received: from eggs.gnu.org ([2001:4830:134:3::10]:40189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ewvF6-0007Jb-R6
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ewvF3-0003gS-0u
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:42:20 -0400
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233]:35964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ewvF2-0003g5-QW
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:42:16 -0400
Received: by mail-pg0-x233.google.com with SMTP id i14so4473730pgv.3
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 12:42:16 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Fri, 16 Mar 2018 12:40:57 -0700
Message-Id: <1521229281-73637-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 00/24] RISC-V Post-merge spec conformance
 and cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Palmer Dabbelt <palmer@sifive.com>

This is a series of spec conformance bug fixes and code cleanups
that we would like to get in before the QEMU 2.12 release. This
series does not contain the fix to riscv_isa_string. Previous
versions of this series have been included in the riscv.org QEMU
repository and these changes have had extensive testing running
Fedora for RISC-V, including building QEMU inside of RISC-V QEMU
running SMP Linux.

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

v2

- remove unused class boilerplate retains qom parent_obj
- convert cpu definition towards future model
- honor mstatus.mxr flag in page table walker

v3

- refactor rcu_read_lock in PTE update to use single unlock
- mstatus.mxr is in effect regardless of privilege mode
- remove unnecessary class init from riscv_hart
- set mtval/stval to zero on exceptions without addresses

Michael Clark (24):
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
 target/riscv/helper.c           |  83 +++++++++++++++++++-------
 target/riscv/op_helper.c        |  52 ++++++++---------
 17 files changed, 279 insertions(+), 335 deletions(-)

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

-- 
2.7.0
