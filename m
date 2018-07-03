Received: from eggs.gnu.org ([2001:4830:134:3::10]:37539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1faLhJ-0008Lg-9h
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 09:50:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1faLhF-0000nh-Qd
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 09:50:25 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:33739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1faLhF-0000m7-IS
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 09:50:21 -0400
Received: by mail-pl0-x244.google.com with SMTP id 6-v6so1088287plb.0
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 06:50:21 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Tue,  3 Jul 2018 22:50:02 +0900
Message-Id: <20180703135003.7485-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 00/25] OpenRISC updates for 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Development <qemu-devel@nongnu.org>, Stafford Horne <shorne@gmail.com>

Hello Peter,

Trying again to send this series, just one difference here so just sending the
single patch.

Changes since v2:
 - Use PAGE_ instead of PROT_ flags in MMU patches to fix windows build.


Please consider for pull:

The following changes since commit 646f34fa5482e495483de230b4cf0f2ae4fd2781:

  tcg: Fix --disable-tcg build breakage (2018-07-02 13:42:05 +0100)

are available in the Git repository at:

  git@github.com:stffrdhrn/qemu.git tags/pull-or-20180703

for you to fetch changes up to dfc84745bbaa0fea2abc8575dd349f6e4bb7edc7:

  target/openrisc: Fix writes to interrupt mask register (2018-07-03 22:40:33 +0900)

----------------------------------------------------------------
OpenRISC cleanups and Fixes for QEMU 3.0

Mostly patches from Richard Henderson fixing multiple things:
 * Fix singlestepping in GDB.
 * Use more TB linking.
 * Fixes to exit TB after updating SPRs to enable registering of state
   changes.
 * Significant optimizations and refactors to the TLB
 * Split out disassembly from translation.
 * Add qemu-or1k to qemu-binfmt-conf.sh.
 * Implement signal handling for linux-user.

Then there are a few fixups from me:
 * Fix delay slot detections to match hardware, this was masking a bug
   in the linus kernel.
 * Fix stores to the PIC mask register

----------------------------------------------------------------

Richard Henderson (23):
  target/openrisc: Fix mtspr shadow gprs
  target/openrisc: Add print_insn_or1k
  target/openrisc: Log interrupts
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
  target/openrisc: Increase the TLB size
  target/openrisc: Reorg tlb lookup
  target/openrisc: Add support in scripts/qemu-binfmt-conf.sh
  linux-user: Implement signals for openrisc
  linux-user: Fix struct sigaltstack for openrisc

Stafford Horne (2):
  target/openrisc: Fix delay slot exception flag to match spec
  target/openrisc: Fix writes to interrupt mask register

 linux-user/openrisc/signal.c         | 217 ++++++++-----------
 linux-user/openrisc/target_signal.h  |   2 +-
 linux-user/openrisc/target_syscall.h |  28 +--
 linux-user/signal.c                  |   2 +-
 scripts/qemu-binfmt-conf.sh          |  10 +-
 target/openrisc/Makefile.objs        |   5 +-
 target/openrisc/cpu.c                |  17 +-
 target/openrisc/cpu.h                |  61 +++---
 target/openrisc/disas.c              | 170 +++++++++++++++
 target/openrisc/helper.h             |   4 +-
 target/openrisc/interrupt.c          |  55 +++--
 target/openrisc/interrupt_helper.c   |  35 +---
 target/openrisc/machine.c            |  44 +---
 target/openrisc/mmu.c                | 279 +++++++++---------------
 target/openrisc/mmu_helper.c         |  40 ----
 target/openrisc/sys_helper.c         |  84 ++++----
 target/openrisc/translate.c          | 303 ++++++++++-----------------
 17 files changed, 603 insertions(+), 753 deletions(-)
 create mode 100644 target/openrisc/disas.c
 delete mode 100644 target/openrisc/mmu_helper.c

-- 
2.17.0
