Received: from eggs.gnu.org ([2001:4830:134:3::10]:53731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fcd7a-00050x-1E
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 16:50:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fcd7W-0005kX-UX
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 16:50:58 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:60877 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fcd7W-0005jb-JA
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 16:50:54 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon,  9 Jul 2018 22:49:58 +0200
Message-Id: <1531169431-10772-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 00/33] Add nanoMIPS support to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: f4bug@amsat.org, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

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

Aleksandar Markovic (1):
  target/mips: Add ELF flags for MIPS machine variants

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

Stefan Markovic (6):
  target/mips: Implement MT ASE support for nanoMIPS
  target/mips: Implement DSP ASE support for nanoMIPS
  target/mips: Add updating CP0 BadInstrX register for nanoMIPs only
  mips_malta: Fix semihosting argument passing for nanoMIPS bare metal
  gdbstub: Add XML support for GDB for nanoMIPS
  target/mips: Add definition of nanoMIPS I7200 CPU

Yongbok Kim (16):
  target/mips: Add nanoMIPS OPCODE table
  target/mips: Add decode_nanomips_opc() function
  target/mips: Add emulation of nanoMIPS 16-bit load and store
    instructions
  target/mips: Add emulation of nanoMIPS 16-bit logic instructions
  target/mips: Add emulation of some common nanoMIPS 32-bit instructions
  target/mips: Add emulation of nanoMIPS 48-bit instructions
  target/mips: Add emulation of nanoMIPS FP instructions
  target/mips: Add emulation of misc nanoMIPS instructions (pool32a0)
  target/mips: Add emulation of misc nanoMIPS instructions (pool32axf)
  target/mips: Add emulation of misc nanoMIPS instructions (pool p_lsx)
  target/mips: Add emulation of nanoMIPS 32-bit load and store
    instructions
  target/mips: Add emulation of nanoMIPS branch instructions
  target/mips: Implement emualtion of nanoMIPS LLWP/SCWP pair
  target/mips: Add updating BadInstr and BadInstrP registers for
    nanoMIPS
  target/mips: Adjust behavior of Config3's ISAOnExc bit for nanoMIPS
  target/mips: Fix ERET/ERETNC behavior related to ADEL exception

 MAINTAINERS                      |    3 +-
 gdb-xml/nanomips-cp0.xml         |   13 +
 gdb-xml/nanomips-cpu.xml         |   44 +
 gdb-xml/nanomips-dsp.xml         |   20 +
 gdb-xml/nanomips-fpu.xml         |   45 +
 gdb-xml/nanomips-linux.xml       |   20 +
 hw/mips/mips_malta.c             |  153 +-
 include/elf.h                    |   24 +
 linux-user/mips/cpu_loop.c       |   25 +-
 target/mips/cpu.h                |    2 +
 target/mips/gdbstub.c            |   13 +-
 target/mips/helper.c             |   35 +-
 target/mips/helper.h             |    4 +
 target/mips/mips-defs.h          |    4 +
 target/mips/op_helper.c          |  147 +-
 target/mips/translate.c          | 7303 ++++++++++++++++++++++++++++++--------
 target/mips/translate_init.inc.c |   37 +
 17 files changed, 6454 insertions(+), 1438 deletions(-)
 create mode 100644 gdb-xml/nanomips-cp0.xml
 create mode 100644 gdb-xml/nanomips-cpu.xml
 create mode 100644 gdb-xml/nanomips-dsp.xml
 create mode 100644 gdb-xml/nanomips-fpu.xml
 create mode 100644 gdb-xml/nanomips-linux.xml

-- 
2.7.4
