Received: from eggs.gnu.org ([2001:4830:134:3::10]:34813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbt2-0002Ru-IC
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbsy-0003Fi-IH
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:06:56 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:49663)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Yongbok.Kim@mips.com>)
	id 1fVbsy-0003BT-BL
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:06:52 -0400
From: Yongbok Kim <yongbok.kim@mips.com>
Date: Wed, 20 Jun 2018 13:05:45 +0100
Message-ID: <20180620120620.12806-1-yongbok.kim@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 00/35] nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, Aleksandar.Markovic@mips.com, James.Hogan@mips.com, Paul.Burton@mips.com, Matthew.Fortune@mips.com, Stefan.Markovic@mips.com

This series of patches is implementing recently announced nanoMIPS on QEMU.
nanoMIPS is a variable length ISA containing 16, 32 and 48 bit wide 
instructions. It is designed to be portable at assembly level with other MIPS
and microMIPS code, but contains a number of changes which enhance code density
and efficiency.
Most of nanoMIPS instructions exist in another MIPS ISAs. Therefore the large
portion of patches is decoding nanoMIPS opcodes.

More patches will be added later after this. 

For more information please refer following link.
https://www.mips.com/products/architectures/nanomips/


James Hogan (5):
  target/mips: Implement nanoMIPS EXTW instruction
  target/mips: Fix nanoMIPS exception_resume_pc
  target/mips: Fix nanoMIPS set_hflags_for_handler
  target/mips: Fix nanoMIPS set_pc
  target/mips: Disable gdbstub nanoMIPS ISA bit

Matthew Fortune (4):
  target/mips: Add nanoMIPS save and restore
  target/mips: Add has_isa_mode
  target/mips: Add nanoMIPS rotx instruction
  hw/mips: Add basic nanoMIPS boot code

Paul Burton (1):
  mips_malta: Setup GT64120 BARs in nanoMIPS bootloader

Stefan Markovic (3):
  target/mips: Add nanoMIPS CP0_BadInstrX register
  hw/mips: Fix semihosting argument passing for nanoMIPS bare metal
  target/mips: Add I7200 CPU

Yongbok Kim (22):
  target/mips: Raise a RI when given fs is n/a from CTC1
  target/mips: Fix microMIPS on reset
  target/mips: Add nanoMIPS OPCODE table
  target/mips: Add decode_nanomips_opc()
  target/mips: Add nanoMIPS 16bit ld/st instructions
  target/mips: Add nanoMIPS pool16c instructions
  target/mips: Add nanoMIPS 32bit instructions
  target/mips: Add nanoMIPS 48bit instructions
  target/mips: Add nanoMIPS pool32f instructions
  target/mips: Add nanoMIPS pool32a0 instructions
  target/mips: Add nanoMIPS pool32axf instructions
  target/mips: Update gen_flt_ldst()
  target/mips: Add nanoMIPS p_lsx instructions
  target/mips: Add nanoMIPS load store instructions
  target/mips: Add nanoMIPS branch instructions
  target/mips: Implement nanoMIPS LLWP/SCWP pair
  target/mips: Fix not to update BadVAddr in Debug Mode
  target/mips: Fix data type for offset
  target/mips: Update BadInstr{P} regs on nanoMIPS
  target/mips: Config3.ISAOnExc is read only in nanoMIPS
  target/mips: Fix ERET/ERETNC can cause ADEL exception
  target/mips: Fix gdbstub to read/write 64 bit FP registers

 hw/mips/mips_malta.c             |  153 +-
 include/elf.h                    |    1 +
 linux-user/mips/cpu_loop.c       |   25 +-
 target/mips/cpu.h                |    3 +
 target/mips/gdbstub.c            |   16 +-
 target/mips/helper.c             |   39 +-
 target/mips/helper.h             |    4 +
 target/mips/machine.c            |    1 +
 target/mips/mips-defs.h          |    4 +
 target/mips/op_helper.c          |  166 ++-
 target/mips/translate.c          | 3017 +++++++++++++++++++++++++++++++++++++-
 target/mips/translate_init.inc.c |   37 +
 12 files changed, 3408 insertions(+), 58 deletions(-)

-- 
1.9.1
