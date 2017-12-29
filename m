Received: from eggs.gnu.org ([2001:4830:134:3::10]:50497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoCu-0002jZ-Tr
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoCr-0004TJ-Nt
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:31:52 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:41768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUoCr-0004T3-IG
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:31:49 -0500
Received: by mail-pg0-x244.google.com with SMTP id 77so7332859pgd.8
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:31:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Dec 2017 22:31:07 -0800
Message-Id: <20171229063145.29167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/38] Add hppa-softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de

Over the past 3 months, Helge and I have extended the existing support
for hppa-linux-user to handle system mode as well.  Helge has done all
of the board-level hw/hppa work as well as adapting SeaBIOS for use
with hppa.  Sources for the latter are at

  https://github.com/hdeller/seabios-hppa.git

With this patch set, we are able to install debian 8 from cdrom.

We do encounter problems beyond that, with py3compile, but this
patch set is large enough already.


r~


Helge Deller (2):
  target/hppa: Skeleton support for hppa-softmmu
  target/hppa: Fix comment

Richard Henderson (36):
  target/hppa: Define the rest of the PSW
  target/hppa: Disable gateway page emulation for system mode
  target/hppa: Define hardware exception types
  target/hppa: Split address size from register size
  target/hppa: Implement mmu_idx from IA privilege level
  target/hppa: Implement the system mask instructions
  target/hppa: Add space registers
  target/hppa: Add control registers
  target/hppa: Adjust insn mask for mfctl,w
  target/hppa: Implement rfi
  target/hppa: Fill in hppa_cpu_do_interrupt/hppa_cpu_exec_interrupt
  target/hppa: Implement unaligned access trap
  target/hppa: Use space registers in data operations
  target/hppa: Do not set cs_base to iaoq_b
  target/hppa: Avoid privilege level decrease during branches
  target/hppa: Implement IASQ
  target/hppa: Implement tlb_fill
  target/hppa: Implement external interrupts
  target/hppa: Implement the interval timer
  target/hppa: Log unimplemented instructions
  target/hppa: Implement I*TLBA and I*TLBP insns
  target/hppa: Implement P*TLB and P*TLBE insns
  target/hppa: Implement LDWA
  target/hppa: Implement LPA
  target/hppa: Implement LCI
  target/hppa: Implement SYNCDMA insn
  target/hppa: Implement a halt instruction
  hw/hppa: Implement DINO system board
  target/hppa: Optimize for flat addressing space
  target/hppa: Add system registers to gdbstub
  target/hppa: Add migration for the cpu
  target/hppa: Implement B,GATE insn
  target/hppa: Only use EXCP_DTLB_MISS
  qom: Add MMU_DEBUG_LOAD
  target/hppa: Use MMU_DEBUG_LOAD when reloading for CR[IIR]
  target/hppa: Increase number of temp regs

 Makefile.objs                    |    1 +
 hw/hppa/hppa_hardware.h          |   64 ++
 hw/hppa/hppa_sys.h               |   24 +
 include/qom/cpu.h                |    3 +-
 include/sysemu/arch_init.h       |    1 +
 linux-user/hppa/target_cpu.h     |    2 +-
 target/hppa/cpu.h                |  277 +++++-
 target/hppa/helper.h             |   43 +-
 arch_init.c                      |    2 +
 hw/hppa/dino.c                   |  520 ++++++++++
 hw/hppa/machine.c                |  249 +++++
 hw/hppa/pci.c                    |   90 ++
 linux-user/main.c                |   28 +-
 linux-user/signal.c              |    4 +-
 target/hppa/cpu.c                |   52 +-
 target/hppa/gdbstub.c            |  187 +++-
 target/hppa/helper.c             |  120 +--
 target/hppa/int_helper.c         |  263 +++++
 target/hppa/machine.c            |  181 ++++
 target/hppa/mem_helper.c         |  340 +++++++
 target/hppa/op_helper.c          |  126 ++-
 target/hppa/translate.c          | 1984 +++++++++++++++++++++++++++-----------
 default-configs/hppa-softmmu.mak |   14 +
 hw/hppa/Makefile.objs            |    1 +
 hw/hppa/trace-events             |    4 +
 target/hppa/Makefile.objs        |    4 +-
 26 files changed, 3894 insertions(+), 690 deletions(-)
 create mode 100644 hw/hppa/hppa_hardware.h
 create mode 100644 hw/hppa/hppa_sys.h
 create mode 100644 hw/hppa/dino.c
 create mode 100644 hw/hppa/machine.c
 create mode 100644 hw/hppa/pci.c
 create mode 100644 target/hppa/int_helper.c
 create mode 100644 target/hppa/machine.c
 create mode 100644 target/hppa/mem_helper.c
 create mode 100644 default-configs/hppa-softmmu.mak
 create mode 100644 hw/hppa/Makefile.objs
 create mode 100644 hw/hppa/trace-events

-- 
2.14.3
