Received: from eggs.gnu.org ([209.51.188.92]:36800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1giqmt-0005OD-Le
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 20:11:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1giqms-0000ht-NR
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 20:11:35 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:33783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1giqms-0000hA-FH
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 20:11:34 -0500
Received: by mail-pl1-x641.google.com with SMTP id z23so9365984plo.0
	for <qemu-devel@nongnu.org>; Sun, 13 Jan 2019 17:11:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 14 Jan 2019 12:11:05 +1100
Message-Id: <20190114011122.5995-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 00/17] target/arm: Implement ARMv8.5-MemTag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>, Will Deacon <will.deacon@arm.com>, dave.martin@arm.com, szabolcs.nagy@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com

Based-on: 20190110124951.15473-1-richard.henderson@linaro.org
aka the TBID patch set, which itself is based on the BTI patch set.

The full tree is available at

  https://github.org/rth7680/qemu.git tgt-arm-mte

This extension isl also spelled MTE in the ARM.

This patch set only attempts to implement linux-user emulation.
For system emulation, I still miss the new cache flushing insns (easy)
and the out-of-band physical memory for the allocation tags (harder).

>From a few mis-steps in writing the test cases for the extension,
I might suggest that some future kernel's userland ABI for this have
TCR.TCMA0 = 1, so that legacy code that is *not* MTE aware can use
a frame pointer without accidentally tripping left over stack tags.
(As seen in patch 5, SP+OFF is unchecked per the ISA but FP+OFF is not.)

OTOH, depending on the application, that does make it easier for an
attack vector to clean the tag off the top of a pointer to bypass
store checking.  So, tricky.


r~


Cc: Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: dave.martin@arm.com
Cc: szabolcs.nagy@arm.com
Cc: catalin.marinas@arm.com
Cc: mark.rutland@arm.com

Richard Henderson (17):
  target/arm: Add MTE_ACTIVE to tb_flags
  target/arm: Extract TCMA with ARMVAParameters
  target/arm: Add MTE system registers
  target/arm: Fill in helper_mte_check
  target/arm: Suppress tag check for sp+offset
  target/arm: Implement the IRG instruction
  target/arm: Implement ADDG, SUBG instructions
  target/arm: Implement the GMI instruction
  target/arm: Implement the SUBP instruction
  target/arm: Implement LDG, STG, ST2G instructions
  target/arm: Implement the STGP instruction
  target/arm: Implement the LDGV and STGV instructions
  target/arm: Set PSTATE.TCO on exception entry
  tcg: Introduce target-specific page data for user-only
  target/arm: Add allocation tag storage for user-only
  target/arm: Enable MTE
  tests/tcg/aarch64: Add mte smoke tests

 include/exec/cpu-all.h            |  10 +-
 target/arm/cpu.h                  |  18 ++
 target/arm/helper-a64.h           |  11 +
 target/arm/internals.h            |  22 ++
 target/arm/translate.h            |  13 ++
 accel/tcg/translate-all.c         |  28 +++
 linux-user/mmap.c                 |  10 +-
 linux-user/syscall.c              |   4 +-
 target/arm/cpu.c                  |  10 +
 target/arm/cpu64.c                |   1 +
 target/arm/helper.c               |  99 ++++++--
 target/arm/mte_helper.c           | 369 ++++++++++++++++++++++++++++++
 target/arm/translate-a64.c        | 305 ++++++++++++++++++++----
 tests/tcg/aarch64/mte-1.c         |  27 +++
 tests/tcg/aarch64/mte-2.c         |  39 ++++
 target/arm/Makefile.objs          |   2 +-
 tests/tcg/aarch64/Makefile.target |   4 +
 17 files changed, 907 insertions(+), 65 deletions(-)
 create mode 100644 target/arm/mte_helper.c
 create mode 100644 tests/tcg/aarch64/mte-1.c
 create mode 100644 tests/tcg/aarch64/mte-2.c

-- 
2.17.2
