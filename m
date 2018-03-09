Received: from eggs.gnu.org ([2001:4830:134:3::10]:55558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eu9Q5-0003pB-VU
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 23:14:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eu9Q2-0006mm-Pj
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 23:14:13 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:36287)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eu9Q2-0006mV-Iv
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 23:14:10 -0500
Received: by mail-pl0-x243.google.com with SMTP id 61-v6so4612821plf.3
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 20:14:10 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Fri,  9 Mar 2018 17:12:22 +1300
Message-Id: <1520568765-58189-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/23] RISC-V Post-merge spec conformance
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
Cc: Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Paolo Bonzini <pbonzini@redhat.com>

Apparently there is at least one logic bug in amongst this
set of 23 patches. I'll shout you a beer if you can find it.
I found one myself so there was probably at least two.

Hey, it boots SMP Linux here, but I think it needs more testing.

This is a series of spec conformance bug fixes and code cleanups.
We would like to get this series in after our core changes in v8.2.

* Implements WARL behavior for CSRs that don't support writes
* Improves specification conformance of the page table walker
  * Change access checks from ternary operator to if statements
  * Checks for misaligned PPNs
  * Disallow M-mode or S-mode from fetching from User pages
  * Adds reserved PTE flag check: W or W|X
  * Adds prot read if mode is not U and mstatus.mxr is set
  * Improves page walker comments and general readability 
* Several trivial code cleanups to hw/riscv
  * Replacing hard coded constants with reference to enums
    or the machine memory maps.
* Adds bounds checks when writing device-tree to ROM
* Updates the cpu model to use a more modern interface

v2

- remove unused class boilerplate retains qom parent_obj
- convert cpu definition towards future model
- honor mstatus.mxr flag in page table walker

Michael Clark (23):
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

 disas/riscv.c                   |  39 +++++++------
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
 target/riscv/helper.c           |  65 +++++++++++++++------
 target/riscv/op_helper.c        |  52 ++++++++---------
 16 files changed, 263 insertions(+), 327 deletions(-)

-- 
2.7.0
