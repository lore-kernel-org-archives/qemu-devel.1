Received: from eggs.gnu.org ([209.51.188.92]:48448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWoo-0002c2-BV
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWon-0007lp-5T
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:06 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:36557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBWom-0007k0-MH
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:05 -0400
Received: by mail-pg1-x532.google.com with SMTP id 85so7592740pgc.3
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 20:44:04 -0700 (PDT)
Received: from cloudburst.imgcgcw.net ([147.50.13.10])
	by smtp.gmail.com with ESMTPSA id
	z6sm26753214pgo.31.2019.04.02.20.44.00 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 02 Apr 2019 20:44:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Apr 2019 10:43:32 +0700
Message-Id: <20190403034358.21999-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 00/26] tcg: Add CPUClass::tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

There is currently a lot of confusion between foo_cpu_handle_mmu_fault
and tlb_fill.

In particular, foo_cpu_handle_mmu_fault was only defined for user-only,
and its only valid action was to set up the cpu for cpu_loop_exit so
that we can deliver a SIGSEGV to the guest.  And yet, we had code that
tried to return from the host SIGSEGV handler to retry the instruction.

We had, for some targets, a definition of foo_cpu_handle_mmu_fault
for softmmu.  Sometimes this was called from tlb_fill, sometimes not.

Finally, we have a use case for SVE that wants a non-faulting tlb_fill,
so while we're changing the interface, let's go ahead and include that.


r~


Richard Henderson (26):
  tcg: Assert h2g_valid for 32-bit guest on 64-bit host
  tcg: Add CPUClass::tlb_fill
  target/alpha: Convert to CPUClass::tlb_fill
  target/arm: Convert to CPUClass::tlb_fill
  target/cris: Convert to CPUClass::tlb_fill
  target/hppa: Convert to CPUClass::tlb_fill
  target/i386: Convert to CPUClass::tlb_fill
  target/lm32: Convert to CPUClass::tlb_fill
  target/m68k: Convert to CPUClass::tlb_fill
  target/microblaze: Convert to CPUClass::tlb_fill
  target/mips: Convert to CPUClass::tlb_fill
  target/moxie: Convert to CPUClass::tlb_fill
  target/nios2: Convert to CPUClass::tlb_fill
  target/openrisc: Convert to CPUClass::tlb_fill
  target/ppc: Convert to CPUClass::tlb_fill
  target/riscv: Convert to CPUClass::tlb_fill
  target/s390x: Convert to CPUClass::tlb_fill
  target/sh4: Convert to CPUClass::tlb_fill
  target/sparc: Convert to CPUClass::tlb_fill
  target/tilegx: Convert to CPUClass::tlb_fill
  target/tricore: Convert to CPUClass::tlb_fill
  target/unicore32: Convert to CPUClass::tlb_fill
  target/xtensa: Convert to CPUClass::tlb_fill
  tcg: Use CPUClass::tlb_fill in cputlb.c
  tcg: Remove CPUClass::handle_mmu_fault
  tcg: Use tlb_fill probe from tlb_vaddr_to_host

 include/exec/cpu_ldst.h         |  40 +------
 include/exec/exec-all.h         |   9 --
 include/qom/cpu.h               |  12 +-
 target/alpha/cpu.h              |   5 +-
 target/arm/internals.h          |  10 +-
 target/cris/cpu.h               |   5 +-
 target/hppa/cpu.h               |   8 +-
 target/i386/cpu.h               |   5 +-
 target/lm32/cpu.h               |   5 +-
 target/m68k/cpu.h               |   5 +-
 target/microblaze/cpu.h         |   5 +-
 target/mips/internal.h          |   5 +-
 target/moxie/cpu.h              |   5 +-
 target/nios2/cpu.h              |   5 +-
 target/openrisc/cpu.h           |   5 +-
 target/ppc/cpu.h                |   7 +-
 target/riscv/cpu.h              |   5 +-
 target/s390x/internal.h         |   5 +-
 target/sh4/cpu.h                |   5 +-
 target/sparc/cpu.h              |   5 +-
 target/tricore/cpu.h            |   6 +-
 target/unicore32/cpu.h          |   5 +-
 target/xtensa/cpu.h             |   5 +-
 accel/tcg/cputlb.c              |  88 +++++++++++++--
 accel/tcg/user-exec.c           |  46 +++-----
 target/alpha/cpu.c              |   5 +-
 target/alpha/helper.c           |  42 +++----
 target/alpha/mem_helper.c       |  16 ---
 target/arm/cpu.c                |  22 +---
 target/arm/helper.c             |  89 ++++++++-------
 target/arm/op_helper.c          |  29 +----
 target/arm/sve_helper.c         |   6 +-
 target/cris/cpu.c               |   5 +-
 target/cris/helper.c            |  61 ++++++-----
 target/cris/op_helper.c         |  28 -----
 target/hppa/cpu.c               |   5 +-
 target/hppa/mem_helper.c        |  16 ++-
 target/i386/cpu.c               |   5 +-
 target/i386/excp_helper.c       |  53 +++++----
 target/i386/mem_helper.c        |  21 ----
 target/lm32/cpu.c               |   5 +-
 target/lm32/helper.c            |   8 +-
 target/lm32/op_helper.c         |  16 ---
 target/m68k/cpu.c               |   2 +-
 target/m68k/helper.c            |  89 ++++++++-------
 target/m68k/op_helper.c         |  15 ---
 target/microblaze/cpu.c         |   5 +-
 target/microblaze/helper.c      | 134 +++++++++++-----------
 target/microblaze/op_helper.c   |  19 ----
 target/mips/cpu.c               |   5 +-
 target/mips/helper.c            | 109 +++++++++---------
 target/mips/op_helper.c         |  15 ---
 target/moxie/cpu.c              |   5 +-
 target/moxie/helper.c           |  65 +++--------
 target/nios2/cpu.c              |   5 +-
 target/nios2/helper.c           | 173 +++++++++++++----------------
 target/nios2/mmu.c              |  12 --
 target/openrisc/cpu.c           |   5 +-
 target/openrisc/mmu.c           |  69 ++++++------
 target/ppc/mmu_helper.c         |  13 ++-
 target/ppc/translate_init.inc.c |   5 +-
 target/ppc/user_only_helper.c   |  14 ++-
 target/riscv/cpu.c              |   5 +-
 target/riscv/cpu_helper.c       |  50 ++++-----
 target/s390x/cpu.c              |   5 +-
 target/s390x/excp_helper.c      | 150 ++++++++++++++-----------
 target/s390x/mem_helper.c       |  29 -----
 target/sh4/cpu.c                |   5 +-
 target/sh4/helper.c             | 189 +++++++++++++++-----------------
 target/sh4/op_helper.c          |  12 --
 target/sparc/cpu.c              |   5 +-
 target/sparc/ldst_helper.c      |  15 ---
 target/sparc/mmu_helper.c       | 167 ++++++++++++++--------------
 target/tilegx/cpu.c             |  11 +-
 target/tricore/cpu.c            |   1 +
 target/tricore/helper.c         |  23 ++--
 target/tricore/op_helper.c      |  26 -----
 target/unicore32/cpu.c          |   5 +-
 target/unicore32/helper.c       |  23 ----
 target/unicore32/op_helper.c    |  14 ---
 target/unicore32/softmmu.c      |  13 ++-
 target/xtensa/cpu.c             |   5 +-
 target/xtensa/helper.c          |  70 ++++++------
 83 files changed, 1000 insertions(+), 1320 deletions(-)

-- 
2.17.1
