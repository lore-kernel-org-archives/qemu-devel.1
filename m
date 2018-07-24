Received: from eggs.gnu.org ([2001:4830:134:3::10]:39744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fi1Kt-0001vb-Jb
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:43:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fi1Kq-0000WP-E1
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:42:59 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45796 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fi1Kq-0000Vf-1p
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:42:56 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 24 Jul 2018 19:31:12 +0200
Message-Id: <1532453527-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v4 00/55] Add nanoMIPS support to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

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

Aleksandar Markovic (7):
  target/mips: Add preprocessor constants for nanoMIPS
  target/mips: Add placeholder and invocation of decode_nanomips_opc()
  target/mips: Add nanoMIPS decoding and extraction utilities
  target/mips: Add updating BadInstr, BadInstrP, BadInstrX for nanoMIPS
  elf: Add nanoMIPS specific variations in ELF header fields
  elf: Relax MIPS' elf_check_arch() to accept EM_NANOMIPS too
  elf: Don't check FCR31_NAN2008 bit for nanoMIPS

Aleksandar Rikalo (8):
  linux-user: Add syscall numbers for nanoMIPS
  linux-user: Add target_signal.h header for nanoMIPS
  linux-user: Add termbits.h header for nanoMIPS
  linux-user: Update syscall_defs.h header for nanoMIPS
  linux-user: Add target_fcntl.h header for nanoMIPS
  linux-user: Add sockbits.h header for nanoMIPS
  linux-user: Add target_syscall.h header for nanoMIPS
  linux-user: Amend sigaction syscall support for nanoMIPS

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

Matthew Fortune (3):
  target/mips: Implement emulation of nanoMIPS ROTX instruction
  target/mips: Add handling of branch delay slots for nanoMIPS
  mips_malta: Add basic nanoMIPS boot code for MIPS' Malta

Paul Burton (1):
  mips_malta: Setup GT64120 BARs in nanoMIPS bootloader

Stefan Markovic (10):
  target/mips: Add nanoMIPS DSP ASE opcodes
  target/mips: Implement MT ASE support for nanoMIPS
  target/mips: Add emulation of DSP ASE for nanoMIPS - part 1
  target/mips: Add emulation of DSP ASE for nanoMIPS - part 2
  target/mips: Add emulation of DSP ASE for nanoMIPS - part 3
  target/mips: Implement CP0 Config0.WR bit functionality
  mips_malta: Fix semihosting argument passing for nanoMIPS bare metal
  gdbstub: Add XML support for GDB for nanoMIPS
  target/mips: Add definition of nanoMIPS I7200 CPU
  linux-user: Add nanoMIPS linux user mode configuration support

Yongbok Kim (16):
  target/mips: Add nanoMIPS base instruction set opcodes
  target/mips: Add emulation of misc nanoMIPS 16-bit instructions
  target/mips: Add emulation of nanoMIPS 16-bit load and store
    instructions
  target/mips: Add emulation of nanoMIPS 16-bit logic instructions
  target/mips: Add emulation of nanoMIPS 16-bit save and restore
    instructions
  target/mips: Add emulation of some common nanoMIPS 32-bit instructions
  target/mips: Add emulation of nanoMIPS 48-bit instructions
  target/mips: Add emulation of nanoMIPS FP instructions
  target/mips: Add emulation of misc nanoMIPS instructions (pool32a0)
  target/mips: Add emulation of misc nanoMIPS instructions (pool32axf)
  target/mips: Add emulation of misc nanoMIPS instructions (pool p_lsx)
  target/mips: Add emulation of nanoMIPS 32-bit load and store
    instructions
  target/mips: Add emulation of nanoMIPS branch instructions
  target/mips: Implement emulation of nanoMIPS LLWP/SCWP pair
  target/mips: Adjust behavior of Config3's ISAOnExc bit for nanoMIPS
  target/mips: Fix ERET/ERETNC behavior related to ADEL exception

 MAINTAINERS                             |    3 +-
 configure                               |   13 +-
 default-configs/nanomips-linux-user.mak |    1 +
 gdb-xml/nanomips-cp0.xml                |   13 +
 gdb-xml/nanomips-cpu.xml                |   44 +
 gdb-xml/nanomips-dsp.xml                |   20 +
 gdb-xml/nanomips-fpu.xml                |   45 +
 gdb-xml/nanomips-linux.xml              |   20 +
 hw/mips/mips_malta.c                    |  153 +-
 include/elf.h                           |   20 +
 linux-user/elfload.c                    |    2 +
 linux-user/mips/cpu_loop.c              |   36 +-
 linux-user/mips/signal.c                |   36 +-
 linux-user/mips/termbits.h              |    4 +
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
 linux-user/syscall.c                    |    2 +-
 linux-user/syscall_defs.h               |   57 +-
 target/mips/cpu.h                       |    2 +
 target/mips/gdbstub.c                   |   13 +-
 target/mips/helper.c                    |   43 +-
 target/mips/helper.h                    |    4 +
 target/mips/mips-defs.h                 |    4 +
 target/mips/op_helper.c                 |  147 +-
 target/mips/translate.c                 | 4899 +++++++++++++++++++++++++++++--
 target/mips/translate_init.inc.c        |   40 +
 35 files changed, 5783 insertions(+), 243 deletions(-)
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
2.7.4
