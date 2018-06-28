Received: from eggs.gnu.org ([2001:4830:134:3::10]:39830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYNDe-0004te-JF
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYNDa-0007cW-LW
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:38 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:39722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYNDa-0007cC-Dx
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:34 -0400
Received: by mail-pl0-x243.google.com with SMTP id s24-v6so2007931plq.6
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 20:03:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 27 Jun 2018 20:03:07 -0700
Message-Id: <20180628030330.15615-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 00/23] target/openrisc improvements
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

Changes since v2:
  * Fix missing mtspr break.
  * Reorg print_insn_or1k and interrupt logging to the start.
  * Adjust exit after mtspr; fixing smp kernel crash.
  * Fix signals patch based on Larent's review.


r~


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

 linux-user/openrisc/target_signal.h  |   2 +-
 linux-user/openrisc/target_syscall.h |  28 +--
 target/openrisc/cpu.h                |  61 +++---
 target/openrisc/helper.h             |   4 +-
 linux-user/openrisc/signal.c         | 213 +++++++------------
 linux-user/signal.c                  |   2 +-
 target/openrisc/cpu.c                |  17 +-
 target/openrisc/disas.c              | 170 +++++++++++++++
 target/openrisc/interrupt.c          |  36 +++-
 target/openrisc/interrupt_helper.c   |  35 +--
 target/openrisc/machine.c            |  44 +---
 target/openrisc/mmu.c                | 275 +++++++++---------------
 target/openrisc/mmu_helper.c         |  40 ----
 target/openrisc/sys_helper.c         |  90 ++++----
 target/openrisc/translate.c          | 305 ++++++++++-----------------
 scripts/qemu-binfmt-conf.sh          |  10 +-
 target/openrisc/Makefile.objs        |   5 +-
 17 files changed, 591 insertions(+), 746 deletions(-)
 create mode 100644 target/openrisc/disas.c
 delete mode 100644 target/openrisc/mmu_helper.c

-- 
2.17.1
