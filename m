Received: from eggs.gnu.org ([2001:4830:134:3::10]:54571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1flEQA-0008IE-NH
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:17:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1flEQ6-0003yg-9S
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:17:42 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:59449 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1flEQ5-0003gN-T3
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:17:38 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Thu,  2 Aug 2018 16:15:47 +0200
Message-Id: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v6 00/77] Add nanoMIPS support to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, arikalo@wavecomp.com

From: Stefan Markovic <smarkovic@wavecomp.com>

v5->v6:

  - used names offset and imm instead of rd and rs when
  appropriate
  - used gen_op_addr_addi when appropriate in one more place
  - avoided usage of tcg_temp_local_new
  - avoided unnecesary sign extension related to addr_add
  - fixed unprotected storing to cpu_gpr[0]
  - removed some unnecesary testing for ISA_NANOMIPS
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
  - commit messages and patch title improved accross the board
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

Aleksandar Markovic (14):
  MAINTAINERS: Update target/mips maintainer's email addresses
  target/mips: Avoid case statements formulated by ranges
  target/mips: Mark switch fallthroughs with interpretable comments
  target/mips: Fix two instances of shadow variables
  target/mips: Update some CP0 registers bit definitions
  elf: Remove duplicate preprocessor constant definition
  elf: Add ELF flags for MIPS machine variants
  linux-user: Update MIPS syscall numbers up to kernel 4.18 headers
  target/mips: Add preprocessor constants for nanoMIPS
  target/mips: Add placeholder and invocation of decode_nanomips_opc()
  target/mips: Add nanoMIPS decoding and extraction utilities
  elf: Relax MIPS' elf_check_arch() to accept EM_NANOMIPS too
  elf: Don't check FCR31_NAN2008 bit for nanoMIPS
  linux-user: Update syscall_defs.h header for nanoMIPS

Aleksandar Rikalo (13):
  linux-user: Add preprocessor availability control to some syscalls
  target/mips: Implement emulation of nanoMIPS LLWP/SCWP pair
  elf: Add nanoMIPS specific variations in ELF header fields
  linux-user: Add syscall numbers for nanoMIPS
  linux-user: Add target_signal.h header for nanoMIPS
  linux-user: Add termbits.h header for nanoMIPS
  linux-user: Add target_fcntl.h header for nanoMIPS
  linux-user: Add sockbits.h header for nanoMIPS
  linux-user: Add target_syscall.h header for nanoMIPS
  linux-user: Add support for nanoMIPS signal trampoline
  linux-user: Amend support for sigaction() syscall for nanoMIPS
  linux-user: Add support for statx() syscall for all platforms
  linux-user: Add nanoMIPS support in scripts/qemu-binfmt-conf.sh

Dimitrije Nikolic (5):
  linux-user: Add target_cpu.h header for nanoMIPS
  linux-user: Add target_structs.h header for nanoMIPS
  linux-user: Add target_elf.h header for nanoMIPS
  linux-user: Add signal.c for nanoMIPS
  linux-user: Add cpu_loop.c for nanoMIPS

James Hogan (5):
  target/mips: Implement emulation of nanoMIPS EXTW instruction
  target/mips: Adjust exception_resume_pc() for nanoMIPS
  target/mips: Adjust set_hflags_for_handler() for nanoMIPS
  target/mips: Adjust set_pc() for nanoMIPS
  gdbstub: Disable handling of nanoMIPS ISA bit in the MIPS gdbstub

Matthew Fortune (4):
  target/mips: Add emulation of nanoMIPS 16-bit save and restore
    instructions
  target/mips: Implement emulation of nanoMIPS ROTX instruction
  target/mips: Add handling of branch delay slots for nanoMIPS
  mips_malta: Add basic nanoMIPS boot code for MIPS' Malta

Paul Burton (1):
  mips_malta: Setup GT64120 BARs in nanoMIPS bootloader

Stefan Markovic (16):
  target/mips: Add CP0 BadInstrX register
  target/mips: Add gen_op_addr_addi()
  target/mips: Add nanoMIPS DSP ASE opcodes
  target/mips: Implement MT ASE support for nanoMIPS
  target/mips: Add emulation of DSP ASE for nanoMIPS - part 1
  target/mips: Add emulation of DSP ASE for nanoMIPS - part 2
  target/mips: Add emulation of DSP ASE for nanoMIPS - part 3
  target/mips: Add emulation of DSP ASE for nanoMIPS - part 4
  target/mips: Add emulation of DSP ASE for nanoMIPS - part 5
  target/mips: Add emulation of DSP ASE for nanoMIPS - part 6
  target/mips: Add updating BadInstr, BadInstrP, BadInstrX for nanoMIPS
  target/mips: Implement CP0 Config1.WR bit functionality
  mips_malta: Fix semihosting argument passing for nanoMIPS bare metal
  gdbstub: Add XML support for GDB for nanoMIPS
  target/mips: Add definition of nanoMIPS I7200 CPU
  linux-user: Add nanoMIPS linux user mode configuration support

Yongbok Kim (19):
  target/mips: Don't update BadVAddr register in Debug Mode
  target/mips: Check ELPA flag only in some cases of MFHC0 and MTHC0
  target/mips: Add nanoMIPS base instruction set opcodes
  target/mips: Add emulation of nanoMIPS 16-bit arithmetic instructions
  target/mips: Add emulation of nanoMIPS 16-bit branch instructions
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
  target/mips: Add emulation of nanoMIPS 32-bit branch instructions
  target/mips: Fix ERET/ERETNC behavior related to ADEL exception

 .mailmap                                |    7 +-
 MAINTAINERS                             |   12 +-
 configure                               |   13 +-
 default-configs/nanomips-linux-user.mak |    1 +
 gdb-xml/nanomips-cp0.xml                |   13 +
 gdb-xml/nanomips-cpu.xml                |   44 +
 gdb-xml/nanomips-dsp.xml                |   20 +
 gdb-xml/nanomips-fpu.xml                |   45 +
 gdb-xml/nanomips-linux.xml              |   20 +
 hw/mips/mips_malta.c                    |  153 +-
 include/elf.h                           |   44 +-
 linux-user/elfload.c                    |    2 +
 linux-user/mips/cpu_loop.c              |   36 +-
 linux-user/mips/signal.c                |   36 +-
 linux-user/mips/syscall_nr.h            |    9 +
 linux-user/mips/termbits.h              |    4 +
 linux-user/mips64/syscall_nr.h          |   18 +
 linux-user/nanomips/cpu_loop.c          |    1 +
 linux-user/nanomips/signal.c            |    1 +
 linux-user/nanomips/sockbits.h          |    1 +
 linux-user/nanomips/syscall_nr.h        |  275 ++
 linux-user/nanomips/target_cpu.h        |   21 +
 linux-user/nanomips/target_elf.h        |   14 +
 linux-user/nanomips/target_fcntl.h      |   38 +
 linux-user/nanomips/target_signal.h     |   22 +
 linux-user/nanomips/target_structs.h    |    1 +
 linux-user/nanomips/target_syscall.h    |   30 +
 linux-user/nanomips/termbits.h          |    1 +
 linux-user/strace.c                     |   14 +-
 linux-user/syscall.c                    |  129 +-
 linux-user/syscall_defs.h               |   95 +-
 scripts/qemu-binfmt-conf.sh             |   12 +-
 target/mips/cpu.h                       |  160 +-
 target/mips/gdbstub.c                   |   13 +-
 target/mips/helper.c                    |   36 +-
 target/mips/helper.h                    |    2 +
 target/mips/machine.c                   |    5 +-
 target/mips/mips-defs.h                 |    4 +
 target/mips/op_helper.c                 |  113 +-
 target/mips/translate.c                 | 4887 ++++++++++++++++++++++++++++++-
 target/mips/translate_init.inc.c        |   39 +
 41 files changed, 6145 insertions(+), 246 deletions(-)
 create mode 100644 default-configs/nanomips-linux-user.mak
 create mode 100644 gdb-xml/nanomips-cp0.xml
 create mode 100644 gdb-xml/nanomips-cpu.xml
 create mode 100644 gdb-xml/nanomips-dsp.xml
 create mode 100644 gdb-xml/nanomips-fpu.xml
 create mode 100644 gdb-xml/nanomips-linux.xml
 create mode 100644 linux-user/nanomips/cpu_loop.c
 create mode 100644 linux-user/nanomips/signal.c
 create mode 100644 linux-user/nanomips/sockbits.h
 create mode 100644 linux-user/nanomips/syscall_nr.h
 create mode 100644 linux-user/nanomips/target_cpu.h
 create mode 100644 linux-user/nanomips/target_elf.h
 create mode 100644 linux-user/nanomips/target_fcntl.h
 create mode 100644 linux-user/nanomips/target_signal.h
 create mode 100644 linux-user/nanomips/target_structs.h
 create mode 100644 linux-user/nanomips/target_syscall.h
 create mode 100644 linux-user/nanomips/termbits.h

-- 
1.9.1
