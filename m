Received: from eggs.gnu.org ([2001:4830:134:3::10]:57235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUz5E-0003LC-95
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUz5B-0004Ek-5F
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:40:56 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:39682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fUz5A-0004EK-TV
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:40:53 -0400
Received: by mail-pf0-x244.google.com with SMTP id r11-v6so8604974pfl.6
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 11:40:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Jun 2018 08:40:24 -1000
Message-Id: <20180618184046.6270-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/22] target/openrisc improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: shorne@gmail.com

This is almost a grab-bag of little improvements to the port.

patches 1-3:
  Fix singlestepping for gdbstub.  This has apparently never
  worked, as the first commit has the same bug of not advancing
  the pc when stepping.

patches 4:
  Link more TBs.

patches 5-6:
  Exit the TB after l.mtspr insns.  In particular, storing to
  SR changes exception state so we want to return to the main
  loop to recognize any pending interrupts immediately.

patches 8-18:
  Reorganize TLB handling.  There is a fundamental bug that is
  fixed in patch 13.  However the bug has been hidden by extra
  TLB flushing elsewhere in the port.  I remove some unnecessary
  indirection that the port inherited from somewhere -- probably
  the MIPS port.  Finally, I present the QEMU TLB a unified view
  of the OpenRISC split I/D TLB.

patch 19:
  Split out disassembly from translation.

patch 20:
  Add qemu-or1k to qemu-binfmt-conf.sh.

patches 21-22:
  Implement signal handling for linux-user.

Richard Henderson (22):
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
  target/openrisc: Add support in scripts/qemu-binfmt-conf.sh
  linux-user: Implement signals for openrisc
  linux-user: Fix struct sigaltstack for openrisc

 linux-user/openrisc/target_signal.h  |   2 +-
 linux-user/openrisc/target_syscall.h |  28 +--
 target/openrisc/cpu.h                |  61 +++---
 target/openrisc/helper.h             |   4 +-
 linux-user/openrisc/signal.c         | 212 ++++++++-----------
 linux-user/signal.c                  |   2 +-
 target/openrisc/cpu.c                |  17 +-
 target/openrisc/disas.c              | 170 +++++++++++++++
 target/openrisc/interrupt.c          |  36 +++-
 target/openrisc/interrupt_helper.c   |  35 +---
 target/openrisc/machine.c            |  44 +---
 target/openrisc/mmu.c                | 275 +++++++++---------------
 target/openrisc/mmu_helper.c         |  40 ----
 target/openrisc/sys_helper.c         |  85 ++++----
 target/openrisc/translate.c          | 298 ++++++++++-----------------
 scripts/qemu-binfmt-conf.sh          |  10 +-
 target/openrisc/Makefile.objs        |   5 +-
 17 files changed, 589 insertions(+), 735 deletions(-)
 create mode 100644 target/openrisc/disas.c
 delete mode 100644 target/openrisc/mmu_helper.c

-- 
2.17.1
