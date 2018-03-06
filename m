Received: from eggs.gnu.org ([2001:4830:134:3::10]:46739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etJSY-0005sd-0A
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:45:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etJST-00033a-0U
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:45:17 -0500
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:43219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1etJSS-00032y-H6
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:45:12 -0500
Received: by mail-pg0-x230.google.com with SMTP id e9so8748139pgs.10
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 12:45:12 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed,  7 Mar 2018 09:43:35 +1300
Message-Id: <1520369037-37977-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 00/22] Spec conformance bug fixes and
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches@groups.riscv.org>

This is the series of spec conformance bug fixes and code cleanups.
We would like to get this series in after our core changes in v8.2.

- Implements WARL behavior for CSRs that don't support writes
- Improves specification conformance of the page table walker
  - Change access checks from ternary operator to if statements
  - Checks for misaligned PPNs
  - Disallow M-mode or S-mode from fetching from User pages
  - Adds reserved PTE flag check: W or W|X
  - Improves page walker comments and general readability 
- Several trivial code cleanups to hw/riscv
  - Replacing hard coded constants with reference to enums
    or the machine memory maps.
- Adds bounds checks when writing device-tree to ROM

Michael Clark (22):
  RISC-V: Make virt create_fdt interface consistent
  RISC-V: Replace hardcoded constants with enum values
  RISC-V: Make virt board description match spike
  RISC-V: Use ROM base address and size from memory map
  RISC-V: Remove redundant identity_translate from load_elf
  RISC-V: Mark ROM read-only after copying in code and config
  RISC-V: Remove unused class definitions from machines
  RISC-V: Make sure the emulated rom has space for device-tree
  RISC-V: Include hexidecimal instruction in disassembly
  RISC-V: Hold rcu_read_lock when accessing memory directly
  RISC-V: Improve page table walker spec compliance
  RISC-V: Update E order and I extension order
  RISC-V: Make spike and virt header guards more specific
  RISC-V: Make virt header comment title consistent
  RISC-V: Use memory_region_is_ram in atomic pte update
  RISC-V: Remove EM_RISCV ELF_MACHINE indirection from load_elf
  RISC-V: Ingore satp writes and return 0 for reads when no-mmu
  RISC-V: Remove braces from satp case statement with no locals
  RISC-V: riscv-qemu port supports sv39 and sv48
  RISC-V: vectored traps are optional
  RISC-V: No traps on writes to misa,minstret[h],mcycle[h]
  RISC-V: Remove support for adhoc X_COP local-interrupt

 disas/riscv.c                   | 39 +++++++++++----------
 hw/riscv/sifive_clint.c         |  9 ++---
 hw/riscv/sifive_e.c             | 34 ++----------------
 hw/riscv/sifive_u.c             | 65 +++++++++++-----------------------
 hw/riscv/spike.c                | 65 +++++++++++++---------------------
 hw/riscv/virt.c                 | 77 ++++++++++++++---------------------------
 include/hw/riscv/sifive_clint.h |  4 +++
 include/hw/riscv/sifive_e.h     |  9 -----
 include/hw/riscv/sifive_u.h     | 13 +++----
 include/hw/riscv/spike.h        | 16 ++++-----
 include/hw/riscv/virt.h         | 21 ++++-------
 target/riscv/cpu.c              |  2 +-
 target/riscv/cpu.h              |  6 ++--
 target/riscv/cpu_bits.h         |  3 --
 target/riscv/helper.c           | 63 +++++++++++++++++++++++----------
 target/riscv/op_helper.c        | 52 ++++++++++++++--------------
 16 files changed, 193 insertions(+), 285 deletions(-)

-- 
2.7.0
