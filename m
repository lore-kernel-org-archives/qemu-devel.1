Received: from eggs.gnu.org ([2001:4830:134:3::10]:54102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gB0Um-0007Ot-90
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gB0Uh-00021R-9Y
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:41:00 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:44207 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gB0Ug-00010M-TY
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:40:55 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 12 Oct 2018 18:39:08 +0200
Message-Id: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 00/28] Misc MIPS fixes and improvements for
 October 2018
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, laurent@vivier.eu, riku.voipio@iki.fi

From: Aleksandar Markovic <amarkovic@wavecomp.com>

This series contains support for MIPS ABI flags in elf.h,
MIPS-specifics of prctl(), hardware page table walker,
DSP R3 availability control, and emulation of nanoMIPS
EVA instructions. It also contains support for WatchHi,
MemoryMapID, SAARI, and SAAR registers, ITU updates,
implementation of DRAM, and I6500 core configuration.

Most of the patches were developed a while ago, but were
not submitted to this list for various reasons.

v4->v5:

  - added four patches for MIPS-specific prctl() support
  - added patch on reset state for PWxxx register
  - added patch on adding Config2 content to DisasContext
  - minor improvements in several patches

v3->v4:

  - added hardware page table walker (five patches)
  - added separate patch on MemoryMapID
  - added patch on updating mips32r6-generic
  - added patch on updating MIPS64R2-generic
  - added patch on improving DSP R2/R3-related naming
  - added patch on SELEQZ.<D|S> SELNEZ.<D|S> fixing

v2->v3:

  - added patch on extending WatchHi registers
  - added patch on MemoryMapID, SAARI, and SAAR registers
  - added patch on ITU updates wrt SAAR
  - added patch on Data Scratch Pad RAM
  - added patch on I6500 core configuration
  - corrected the patch on nanoMIPS EVA opcodes

v1->v2:

  - added three patches on MIPS-specifics in elf.h

Dimitrije Nikolic (2):
  target/mips: Add opcodes for nanoMIPS EVA instructions
  target/mips: Implement emulation of nanoMIPS EVA instructions

Matthew Fortune (1):
  target/mips: Fix emulation of microMIPS R6 <SELEQZ|SELNEZ>.<D|S>

Stefan Markovic (11):
  elf: Fix PT_MIPS_XXX constants
  elf: Add MIPS_ABI_FP_XXX constants
  elf: Add Mips_elf_abiflags_v0 structure
  linux-user: Add MIPS-specific prctl() options
  linux-user: Add infrastructure for handling MIPS-specific prctl()
  linux-user: Add fields that correspond to kernel arch_elf_state
  linux-user: Add the field for kernel thread info flags
  target/mips: Add bit definitions for DSP R3 ASE
  target/mips: Add availability control for DSP R3 ASE
  target/mips: Improve DSP R2/R3-related naming
  target/mips: Add CP0 Config2 to DisasContext

Yongbok Kim (14):
  target/mips: Add CPO PWBase register
  target/mips: Add CPO PWField register
  target/mips: Add CPO PWSize register
  target/mips: Add CPO PWCtl register
  target/mips: Add reset state for PWSize and PWField registers
  target/mips: Implement hardware page table walker
  target/mips: Extend WatchHi registers
  target/mips: Add CPO MemoryMapID register
  target/mips: Add CP0 SAARI and SAAR registers
  hw/mips: Update ITU to utilise SAARI/SAAR registers
  hw/mips: Add Data Scratch Pad RAM
  target/mips: Add DEC feature to mips32r6-generic CPU
  target/mips: Add MSA ASE to MIPS64R2-generic CPU
  target/mips: Add I6500 core configuration

 default-configs/mips-softmmu-common.mak |   1 +
 hw/mips/cps.c                           |   9 +
 hw/mips/mips_malta.c                    |  31 ++
 hw/misc/Makefile.objs                   |   1 +
 hw/misc/mips_itu.c                      |  72 +++-
 include/elf.h                           |  30 +-
 include/hw/mips/cps.h                   |   2 +
 include/hw/misc/mips_itu.h              |   7 +
 linux-user/mips/target_syscall.h        |   4 +
 linux-user/qemu.h                       |  21 ++
 linux-user/syscall.c                    |   8 +
 target/mips/cpu.h                       |  40 ++-
 target/mips/helper.c                    | 369 +++++++++++++++++++-
 target/mips/helper.h                    |  12 +
 target/mips/internal.h                  |  15 +-
 target/mips/machine.c                   |  16 +-
 target/mips/mips-defs.h                 |   3 +-
 target/mips/op_helper.c                 | 158 ++++++++-
 target/mips/translate.c                 | 593 ++++++++++++++++++++++++++------
 target/mips/translate_init.inc.c        |  62 +++-
 20 files changed, 1323 insertions(+), 131 deletions(-)

-- 
2.7.4
