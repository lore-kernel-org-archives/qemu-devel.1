Received: from eggs.gnu.org ([209.51.188.92]:37667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLNo-0004zz-V7
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLNn-0004EL-HW
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:04 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:41243)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtLNn-0004CM-7k
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:03 -0500
Received: by mail-pl1-x643.google.com with SMTP id k15so327256pls.8
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 15:53:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 15:52:30 -0800
Message-Id: <20190211235258.542-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 00/28] target/arm: Implement ARMv8.5-MemTag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Based-on: <20190204131228.25949-1-richard.henderson@linaro.org>
aka "[PATCH v3 0/4] target/arm: Implement ARMv8.5-BTI".

The full tree is available at

  https://github.org/rth7680/qemu.git tgt-arm-mte

Major changes since v2:

* LDG, STG, ST2G, LDGM, STGM STZGM instructions updated.

  The new definition of these functions allows me to clean TBI
  within the translator, without having to have the helpers dig
  back down into TCR to determine this.  Removing strip_tbi from
  mte_helper.c does make things a bit cleaner.

* Add GMID_EL1, trap MTE register accesses to EL[23] as required.

Major changes since v1:

* Updates to a newer revision of the spec.  I know there is still work to
  do here: another argument to STG, ST2G, and a new STZGM insn.

* User emulation adds an x-tagged-pages property.  Without that, all pages
  are MemAttr != Tagged and so all accesses unchecked.  I am not turning
  off SCTLR_EL1.ATA0, so even without x-tagged-pages the program has access
  to tag generation (e.g. the IRG insn).

* System emulation is new, though effectively untested.  I need to fiddle
  around with the kernel to see what I can put together there.

  What I can see is:

  address-space: cpu-tag-memory-0
    0000000000000000-07fffffffffffffe (prio 0, i/o): tag-memory
      0000000002000000-0000000009ffffff (prio 0, ram): mach-virt.tag

  address-space: cpu-memory-0
    0000000000000000-ffffffffffffffff (prio 0, i/o): system
      0000000040000000-000000013fffffff (prio 0, ram): mach-virt.ram

* New checks for alignment and page permissions before allowing
  access to the tag memory.


r~


Richard Henderson (28):
  target/arm: Split out arm_sctlr
  target/arm: Split helper_msr_i_pstate into 3
  target/arm: Add clear_pstate_bits, share gen_ss_advance
  target/arm: Add MTE_ACTIVE to tb_flags
  target/arm: Extract TCMA with ARMVAParameters
  target/arm: Add MTE system registers
  target/arm: Assert no manual change to CACHED_PSTATE_BITS
  target/arm: Add helper_mte_check{1,2}
  target/arm: Suppress tag check for sp+offset
  target/arm: Implement the IRG instruction
  target/arm: Implement ADDG, SUBG instructions
  target/arm: Implement the GMI instruction
  target/arm: Implement the SUBP instruction
  target/arm: Define arm_cpu_do_unaligned_access for CONFIG_USER_ONLY
  target/arm: Implement LDG, STG, ST2G instructions
  target/arm: Implement the STGP instruction
  target/arm: Implement the LDGM and STGM instructions
  target/arm: Implement the access tag cache flushes
  target/arm: Clean address for DC ZVA
  target/arm: Implement data cache set allocation tags
  target/arm: Set PSTATE.TCO on exception entry
  tcg: Introduce target-specific page data for user-only
  target/arm: Cache the Tagged bit for a page in MemTxAttrs
  target/arm: Create tagged ram when MTE is enabled
  target/arm: Add allocation tag storage for user mode
  target/arm: Add allocation tag storage for system mode
  target/arm: Enable MTE
  tests/tcg/aarch64: Add mte smoke tests

 include/exec/cpu-all.h            |  10 +-
 target/arm/cpu.h                  |  52 ++-
 target/arm/helper-a64.h           |  19 +
 target/arm/helper.h               |   3 -
 target/arm/internals.h            |  44 +++
 target/arm/translate.h            |  36 ++
 accel/tcg/translate-all.c         |  28 ++
 hw/arm/virt.c                     |  33 ++
 linux-user/mmap.c                 |  10 +-
 linux-user/syscall.c              |   4 +-
 target/arm/cpu.c                  |  31 +-
 target/arm/cpu64.c                |  19 +
 target/arm/helper-a64.c           |  30 ++
 target/arm/helper.c               | 229 +++++++++--
 target/arm/mte_helper.c           | 617 ++++++++++++++++++++++++++++++
 target/arm/op_helper.c            |  80 +---
 target/arm/translate-a64.c        | 390 +++++++++++++++----
 target/arm/translate.c            |  11 -
 tests/tcg/aarch64/mte-1.c         |  27 ++
 tests/tcg/aarch64/mte-2.c         |  39 ++
 target/arm/Makefile.objs          |   2 +-
 tests/tcg/aarch64/Makefile.target |   4 +
 22 files changed, 1517 insertions(+), 201 deletions(-)
 create mode 100644 target/arm/mte_helper.c
 create mode 100644 tests/tcg/aarch64/mte-1.c
 create mode 100644 tests/tcg/aarch64/mte-2.c

-- 
2.17.2
