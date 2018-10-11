Received: from eggs.gnu.org ([2001:4830:134:3::10]:52337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gAZ4I-0005Nb-5Y
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:23:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gAZ4E-0007JX-4M
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:23:49 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:50714 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gAZ4D-000748-Ld
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:23:46 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 11 Oct 2018 13:22:05 +0200
Message-Id: <1539256947-22807-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v4 00/22] Misc MIPS fixes and improvements for
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

This series contains support for MIPS ABI flags in elf.h, hardware
page table walker, DSP R3 availability control, and emulation of
nanoMIPS EVA instructions. It also contains support for WatchHi,
MemoryMapID, SAARI, and SAAR registers, ITU updates, implementation
of DRAM, and I6500 core configuration.

MIPS ABI flags will be used in near future for linux user mode
support for certain MIPS-specific parts of prctl() system call.

All patches were developed a while ago, but were not submitted to
this list for various reasons.

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
  target/mips: Fix emulation of microMIPS R6 SELEQZ.<D|S> SELNEZ.<D|S>

Stefan Markovic (6):
  elf: Fix PT_MIPS_XXX constants
  elf: Add MIPS_ABI_FP_XXX constants
  elf: Add Mips_elf_abiflags_v0 structure
  target/mips: Add bit definitions for DSP R3 ASE
  target/mips: Add availability control for DSP R3 ASE
  target/mips: Improve DSP R2/R3-related naming

Yongbok Kim (13):
  target/mips: Add CPO PWBase register
  target/mips: Add CPO PWField register
  target/mips: Add CPO PWSize register
  target/mips: Add CPO PWCtl register
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
 hw/misc/mips_itu.c                      |  72 ++++-
 include/elf.h                           |  30 +-
 include/hw/mips/cps.h                   |   2 +
 include/hw/misc/mips_itu.h              |   7 +
 target/mips/cpu.h                       |  40 ++-
 target/mips/helper.c                    | 369 +++++++++++++++++++++-
 target/mips/helper.h                    |  12 +
 target/mips/internal.h                  |  15 +-
 target/mips/machine.c                   |  12 +-
 target/mips/mips-defs.h                 |   3 +-
 target/mips/op_helper.c                 | 158 +++++++++-
 target/mips/translate.c                 | 524 +++++++++++++++++++++++++-------
 target/mips/translate_init.inc.c        |  60 +++-
 17 files changed, 1218 insertions(+), 128 deletions(-)

-- 
2.7.4
