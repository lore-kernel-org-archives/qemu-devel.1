Received: from eggs.gnu.org ([2001:4830:134:3::10]:57661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fMwQP-0008PQ-3x
	for qemu-devel@nongnu.org; Sun, 27 May 2018 10:13:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fMwQL-0004M5-SI
	for qemu-devel@nongnu.org; Sun, 27 May 2018 10:13:33 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:46532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fMwQL-0004Lt-MH
	for qemu-devel@nongnu.org; Sun, 27 May 2018 10:13:29 -0400
Received: by mail-pl0-x243.google.com with SMTP id 30-v6so5726731pld.13
	for <qemu-devel@nongnu.org>; Sun, 27 May 2018 07:13:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 27 May 2018 09:13:04 -0500
Message-Id: <20180527141324.11937-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 00/20] target/openrisc improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>

This is almost a grab-bag of little improvements to the port.

patches 1-3:
  Fix singlestepping for gdbstub.  This has apparently never
  worked, as the first commit has the same bug of not advancing
  the pc when stepping.

patches 4-5:
  Exit the TB after l.mtspr insns.  In particular, storing to
  SR changes exception state so we want to return to the main
  loop to recognize any pending interrupts immediately.

patches 6-19:
  Reorganize TLB handling.  There is a fundamental bug that is
  fixed in patch 13.  However the bug has been hidden by extra
  TLB flushing elsewhere in the port.  I remove some unnecessary
  indirection that the port inherited from somewhere -- probably
  the MIPS port.  Finally, I present the QEMU TLB a unified view
  of the OpenRISC split I/D TLB.

patch 20:
  Split out disassembly from translation.

patch 21:
  Add qemu-or1k to qemu-binfmt-conf.sh.


r~


Richard Henderson (20):
  target/openrisc: Remove DISAS_JUMP & DISAS_TB_JUMP
  target/openrisc: Use exit_tb instead of CPU_INTERRUPT_EXITTB
  target/openrisc: Fix singlestep_enabled
  target/openrisc: Link more translation blocks
  target/openrisc: Split out is_user
  target/openrisc: Exit the TB after l.mtspr
  target/openrisc: Form the spr index from tcg
  target/openrisc: Merge tlb allocation into CPUOpenRISCState
  target/openrisc: Remove indirect function calls for mmu
  target/openrisc: Merge mmu_helper.c into mmu.c
  target/openrisc: Reduce tlb to a single dimension
  target/openrisc: Fix tlb flushing in mtspr
  target/openrisc: Fix cpu_mmu_index
  target/openrisc: Use identical sizes for ITLB and DTLB
  target/openrisc: Stub out handle_mmu_fault for softmmu
  target/openrisc: Log interrupts
  target/openrisc: Increase the TLB size
  target/openrisc: Reorg tlb lookup
  target/openrisc: Add print_insn_or1k
  target/or1k: Add support in scripts/qemu-binfmt-conf.sh

 target/openrisc/cpu.h              |  61 +++---
 target/openrisc/helper.h           |   4 +-
 target/openrisc/cpu.c              |  16 +-
 target/openrisc/disas.c            | 171 +++++++++++++++++
 target/openrisc/interrupt.c        |  36 ++--
 target/openrisc/interrupt_helper.c |  35 +---
 target/openrisc/machine.c          |  39 +---
 target/openrisc/mmu.c              | 275 ++++++++++----------------
 target/openrisc/mmu_helper.c       |  40 ----
 target/openrisc/sys_helper.c       |  85 ++++----
 target/openrisc/translate.c        | 298 ++++++++++-------------------
 scripts/qemu-binfmt-conf.sh        |  10 +-
 target/openrisc/Makefile.objs      |   5 +-
 13 files changed, 492 insertions(+), 583 deletions(-)
 create mode 100644 target/openrisc/disas.c
 delete mode 100644 target/openrisc/mmu_helper.c

-- 
2.17.0
