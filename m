Received: from eggs.gnu.org ([2001:4830:134:3::10]:44975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1froyA-00012P-Gc
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:32:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1froko-0001PI-PJ
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:18:16 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:48924 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1frokm-0000Ok-Hc
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:18:12 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 20 Aug 2018 20:16:08 +0200
Message-Id: <1534789014-8310-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v11 00/46] Add nanoMIPS support - core
 functionality and system mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, dnikolic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

v10->v11:

  - all user-mode patches removed (separate series will be
      created for them)
  - added capability to implement availability control via CP0
      Config3 and Config5 bits
  - refactored accordingly availability control via XNP and MT
  - added availability control via NMS
  - fix for wrong mode switch to M16 now in a separate patch
  - moderate cleanup of disassembler code
  - rebased to the latest code

v9->v10:

  - first 15 patches removed since they are applied now to the
    main tree
  - completely removed connections to and dependance on
      MIPS_HFLAG_M16 in nanoMIPS code
  - completed reworking of nanoMIPS branch handling
  - some fixes and improvements in DSP ASE patches
  - other fixes and improvements that originate from code reviews
  - rebased to the latest code

v8->v9:

  - reoganized (moved/squashed) patches so that clang build bisect
     works (as the result, number of patches dropped from 87 to 84)
  - re-examined and reworked 32-bit nanoMIPS branch instructions
  - minor improvements in commit messages  
  - rebased to the latest code

v7->v8:

  - the series is slightly reorganized so that:
      - patches 1-19 are fixes and improvements that are not
      dependent on the existence of nanoMIPS (even though most
      of them are logicaly connected to (and necessary for)
      nanoMIPS support) - they fix and improve pre-nanoMIPS code
      - patches 20-65 introduce core nanoMIPS functionality, but
      do not contain any dependence on or reference to nanoMIPS
      Linux ABI
      - patches 66-87 mostly deal with Linux user mode-related
      nanoMIPS functionality, therefore dependent on nanoMIPS
      Linux ABI
  - the series will probably be split into three (corresponding
      to the organization mentioned above) in near future
  - added support for availability control via bit config XNP
  - fixed availabitily control for LLWP/SCWP
  - added support for availability control via bit config MT
  - fixed availabitily control for pre-nanoMIPS MT ASE
  - fixed availabitily control for nanoMIPS MT ASE
  - completely removed case-statements defined by integer range
      from translate.c
  - patch on nanoMIPS specifics in ELF headers split into two
  - patch on GT64120-related functionality in nanoMIPS bootloader
      updated with comments and reorganizes with respect to
      endianness
  - replaced one instance of shift/mask with extract32()
  - fixed one instance of missing default case in decoding engine
  - removed several instances of unnecessary default case in
    decoding engine
  - minor tweaks related to variable scope and naming
  - fixed several spelling mistakes in commit messages
  - rebased to the latest code

v6->v7:

  - found a better place for MIPS_ARCH in elf.h
  - improved patch for LLWP and SCWP
  - fixed missing availability control, alignment, usage
    of extract32() in DSP patches
  - added disassembler support for microMIPS and nanoMIPS
  - removed unnecessary addition of one empty line in the
    patch on WR bit
  - improved statx() syscall translation
  - improved nanoMIPS items in binfmt script
  - amended pre-nanoMIPS items in qemu-doc.texi
  - added nanoMIPS items in qemu-doc.texi
  - changed slightly patch order to be logicaly more
    comprehensive 
  - rebased to the latest code
  - NOTE: there will be some sheckpatch.pl errors and warning
    for this series; however, we think those are flase positives
    in these particular circumstances - therefore we will not
    change any patch related to these checkpatch.pl messages

v5->v6:

  - used names offset and imm instead of rd and rs when
    appropriate
  - used gen_op_addr_addi when appropriate in one more place
  - avoided usage of tcg_temp_local_new
  - avoided unnecessary sign extension related to addr_add
  - fixed unprotected storing to cpu_gpr[0]
  - removed some unnecessary testing for ISA_NANOMIPS
  - updated patch for LLWP and SCWP
  - extract32 inserted instead of shift/mask in DSP patches
  - removed useless casts from DSP patches
  - reorganized functions to eliminated duplicated loading of
    gpr values into tcg variables in DSP patches
  - check Config1.WR bit for Watch registers only when using
    in runtime
  - removed duplicated check for bad address in PC register
  - added support for statx system call
  - updated script qemu-binfmt-conf.sh for nanoMIPS
  - rebased to the latest code

v4->v5:

  - merged series "Mips maintenance and misc fixes and improvements"
    and this one for easier handling (there are build dependencies)
  - eliminated shadow variables from translate.c
  - replaced shift/mask combination with extract32()
  - added new function gen_op_addr_addi()
  - added patch for LLWP and SCWP
  - added "fall through" comments at appropriate places
  - eliminated micromips flag from I7200 definition
  - numerous other enhancements originating from reviewer's
    comments
  - some of the patches split into two or more for easier
    handling and review
  - rebased to the latest code

v3->v4:

  - added support for nanoMIPS user mode functionality and
    configuration
  - DSP patch split into three for easier review and handling
  - corrected indentation in all decoding engine patches
  - shift/mask replaced with equivalent extract32() in some
    patches
  - added missing default cases in some patches
  - refactored invocation logic aroung decode_nanomips_opc()
  - improved comments before decode_gpr_XXX() utilities
  - all four decode_gpr_XXX() are now in a single patch
  - two patches on updating BadInstr and related registers
    are now merged, and execution logic improved
  - minor formatting corrections
  - rebased to the latest code

v2->v3:

  - added support for nanoMIPS-specifics in ELF headers
  - added support for CP0 Config0.WR bit
  - updated I7200 definition
  - improved indentation of some switch statements
  - slight reorganization of patches (splitting, order)
  - rebased to the latest code

v1->v2:

  - added DSP ASE support
  - added MT ASE support
  - added GDB XML support
  - order of patches changed
  - commit messages and patch title improved across the board
  - obsolete email addresses for authors and cosigners replaced
    with the right ones
  - some functions renamed to reflect better the documentation
  - some macros renamed to reflect better their nanoMIPS nature
  - streamlined formatting
  - some of other reviewer's comments addressed, but the majority
    was not; this is because the focus of this version was on
    completing the functionality as much as possible; remaining
    comments will be addressed in the subsequent versions of this
    series

This series of patches implements recently announced nanoMIPS on QEMU.
nanoMIPS is a variable length ISA containing 16, 32 and 48-bit wide
instructions. It is designed to be portable at assembly level with
other MIPS and microMIPS code, but contains a number of changes that
enhance code density and efficiency. The largest portion of patches
is nanoMIPS decoding engine.

For more information, please refer to the following link:

https://www.mips.com/products/architectures/nanomips/


Aleksandar Markovic (5):
  target/mips: Add preprocessor constants for nanoMIPS
  target/mips: Add placeholder and invocation of decode_nanomips_opc()
  target/mips: Add nanoMIPS decoding and extraction utilities
  elf: Relax MIPS' elf_check_arch() to accept EM_NANOMIPS too
  elf: Don't check FCR31_NAN2008 bit for nanoMIPS

Aleksandar Rikalo (4):
  target/mips: Implement emulation of nanoMIPS LLWP/SCWP pair
  target/mips: Fix pre-nanoMIPS MT ASE instructions availability control
  elf: Add EM_NANOMIPS value as a valid one for e_machine field
  elf: On elf loading, treat both EM_MIPS and EM_NANOMIPS as legal for
    MIPS

Dimitrije Nikolic (2):
  target/mips: Add CP0 Config3 and Config5 fields to DisasContext
    structure
  target/mips: Add availability control via bit NMS

James Hogan (1):
  target/mips: Implement emulation of nanoMIPS EXTW instruction

Matthew Fortune (3):
  target/mips: Implement emulation of nanoMIPS ROTX instruction
  disas: Add support for nanoMIPS platform
  mips_malta: Add basic nanoMIPS boot code for Malta board

Paul Burton (1):
  mips_malta: Add setting up GT64120 BARs to the nanoMIPS bootloader

Stefan Markovic (15):
  target/mips: Add nanoMIPS DSP ASE opcodes
  target/mips: Prevent switching mode related to Config3 ISA bit for
    nanoMIPS
  target/mips: Add emulation of nanoMIPS 16-bit branch instructions
  target/mips: Add emulation of nanoMIPS 16-bit save and restore
    instructions
  target/mips: Add emulation of nanoMIPS 32-bit branch instructions
  target/mips: Implement MT ASE support for nanoMIPS
  target/mips: Add emulation of DSP ASE for nanoMIPS - part 1
  target/mips: Add emulation of DSP ASE for nanoMIPS - part 2
  target/mips: Add emulation of DSP ASE for nanoMIPS - part 3
  target/mips: Add emulation of DSP ASE for nanoMIPS - part 4
  target/mips: Add emulation of DSP ASE for nanoMIPS - part 5
  target/mips: Add emulation of DSP ASE for nanoMIPS - part 6
  target/mips: Add updating BadInstr and BadInstrX for nanoMIPS
  mips_malta: Fix semihosting argument passing for nanoMIPS bare metal
  target/mips: Add definition of nanoMIPS I7200 CPU

Yongbok Kim (15):
  target/mips: Add nanoMIPS base instruction set opcodes
  target/mips: Add emulation of nanoMIPS 16-bit arithmetic instructions
  target/mips: Add emulation of nanoMIPS 16-bit shift instructions
  target/mips: Add emulation of nanoMIPS 16-bit misc instructions
  target/mips: Add emulation of nanoMIPS 16-bit load and store
    instructions
  target/mips: Add emulation of nanoMIPS 16-bit logic instructions
  target/mips: Add emulation of some common nanoMIPS 32-bit instructions
  target/mips: Add emulation of nanoMIPS instructions MOVE.P and
    MOVE.PREV
  target/mips: Add emulation of nanoMIPS 48-bit instructions
  target/mips: Add emulation of nanoMIPS FP instructions
  target/mips: Add emulation of misc nanoMIPS instructions (pool32a0)
  target/mips: Add emulation of misc nanoMIPS instructions (pool32axf)
  target/mips: Add emulation of misc nanoMIPS instructions (p_lsx)
  target/mips: Add emulation of nanoMIPS 32-bit load and store
    instructions
  target/mips: Fix ERET/ERETNC behavior related to ADEL exception

 MAINTAINERS                      |     2 +
 disas/Makefile.objs              |     1 +
 disas/mips.c                     |    90 +-
 disas/nanomips.cpp               | 15812 +++++++++++++++++++++++++++++++++++++
 disas/nanomips.h                 |  1100 +++
 hw/mips/mips_malta.c             |   212 +-
 include/disas/bfd.h              |     1 +
 include/elf.h                    |     2 +
 include/hw/elf_ops.h             |     8 +
 linux-user/elfload.c             |     2 +
 linux-user/mips/cpu_loop.c       |    28 +-
 target/mips/cpu.c                |    11 +-
 target/mips/cpu.h                |     2 +
 target/mips/helper.c             |    16 +
 target/mips/helper.h             |     2 +
 target/mips/mips-defs.h          |     4 +
 target/mips/op_helper.c          |    98 +-
 target/mips/translate.c          |  4983 +++++++++++-
 target/mips/translate_init.inc.c |    39 +
 19 files changed, 22330 insertions(+), 83 deletions(-)
 create mode 100644 disas/nanomips.cpp
 create mode 100644 disas/nanomips.h

-- 
2.7.4
