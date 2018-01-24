Received: from eggs.gnu.org ([2001:4830:134:3::10]:50901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeUR8-0004MW-PQ
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:26:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeUR3-0001ZZ-Rz
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:26:34 -0500
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b]:41678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eeUR3-0001Z7-KX
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:26:29 -0500
Received: by mail-pf0-x22b.google.com with SMTP id c6so4358969pfi.8
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 15:26:29 -0800 (PST)
Received: from cloudburst.twiddle.net (174-21-6-47.tukw.qwest.net.
	[174.21.6.47]) by smtp.gmail.com with ESMTPSA id
	z19sm9760028pfh.185.2018.01.24.15.26.26 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Jan 2018 15:26:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 24 Jan 2018 15:25:40 -0800
Message-Id: <20180124232625.30105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 00/45] hppa-softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

A third revision.  Changes since last:

  * sh4 build failure fixed (needed clang to see it)
  * checkpatch whitespace errors fixed.
  * Still updates to IIR, IOR, ISR when !PSW[Q]
  * Fix fcnv instruction masks.
  * Implement probe insn.

The middle three points progress in booting hpux-11.
Booting Linux still works.


r~


Helge Deller (5):
  target/hppa: Skeleton support for hppa-softmmu
  target/hppa: Implement halt and reset instructions
  target/hppa: Fix comment
  target/hppa: Implement LDSID for system mode
  hw/hppa: Implement DINO system board

Richard Henderson (40):
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
  target/hppa: Optimize for flat addressing space
  target/hppa: Add system registers to gdbstub
  target/hppa: Add migration for the cpu
  target/hppa: Implement B,GATE insn
  target/hppa: Only use EXCP_DTLB_MISS
  qom: Add MMU_DEBUG_LOAD
  target/hppa: Use MMU_DEBUG_LOAD when reloading for CR[IIR]
  target/hppa: Increase number of temp regs
  target/hppa: Implement a pause instruction
  target/hppa: Implement STWA
  target/hppa: Enable MTTCG
  pc-bios: Add hppa-firmware.img and git submodule
  hw/hppa: Add MAINTAINERS entry
  target/hppa: Fix 32-bit operand masks for 0E FCVT
  target/hppa: Implement PROBE for system mode

 Makefile                         |    3 +-
 Makefile.objs                    |    1 +
 hw/hppa/hppa_hardware.h          |   40 +
 hw/hppa/hppa_sys.h               |   24 +
 include/qom/cpu.h                |    3 +-
 include/sysemu/arch_init.h       |    1 +
 linux-user/hppa/target_cpu.h     |    2 +-
 target/hppa/cpu.h                |  282 ++++-
 target/hppa/helper.h             |   43 +-
 arch_init.c                      |    2 +
 hw/hppa/dino.c                   |  518 ++++++++++
 hw/hppa/machine.c                |  282 +++++
 hw/hppa/pci.c                    |   90 ++
 linux-user/main.c                |   28 +-
 linux-user/signal.c              |    4 +-
 target/hppa/cpu.c                |   56 +-
 target/hppa/gdbstub.c            |  187 +++-
 target/hppa/helper.c             |  120 +--
 target/hppa/int_helper.c         |  264 +++++
 target/hppa/machine.c            |  181 ++++
 target/hppa/mem_helper.c         |  350 +++++++
 target/hppa/op_helper.c          |  154 ++-
 target/hppa/translate.c          | 2108 ++++++++++++++++++++++++++++----------
 target/sh4/op_helper.c           |    2 +
 .gitmodules                      |    3 +
 MAINTAINERS                      |    1 +
 configure                        |    1 +
 default-configs/hppa-softmmu.mak |   14 +
 hw/hppa/Makefile.objs            |    1 +
 hw/hppa/trace-events             |    4 +
 pc-bios/hppa-firmware.img        |  Bin 0 -> 461352 bytes
 roms/seabios-hppa                |    1 +
 target/hppa/Makefile.objs        |    4 +-
 33 files changed, 4069 insertions(+), 705 deletions(-)
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
 create mode 100755 pc-bios/hppa-firmware.img
 create mode 160000 roms/seabios-hppa

-- 
2.14.3
