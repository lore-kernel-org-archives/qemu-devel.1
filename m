Received: from eggs.gnu.org ([2001:4830:134:3::10]:39678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gB1HO-0001cx-W4
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gB1HL-0008Qo-LL
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:14 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:37078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gB1HK-0008Ov-RV
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:11 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Fri, 12 Oct 2018 19:30:19 +0200
Message-Id: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/28] target/riscv: Convert to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mjc@sifive.com, palmer@sifive.com, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de
Cc: qemu-devel@nongnu.org, peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com

Hi,

this patchset converts the RISC-V decoder to decodetree in three major steps:

1) Convert 32-bit instructions to decodetree [Patch 1-14]:
    Many of the gen_* functions are called by the decode functions for 16-bit
    and 32-bit functions. If we move translation code from the gen_*
    functions to the generated trans_* functions of decode-tree, we get a lot of
    duplication. Therefore, we mostly generate calls to the old gen_* function
    which are properly replaced after step 2).

    Each of the trans_ functions are grouped into files corresponding to their
    ISA extension, e.g. addi which is in RV32I is translated in the file
    'trans_rvi.inc.c'.

2) Convert 16-bit instructions to decodetree [Patch 15-17]:
    All 16 bit instructions have a direct mapping to a 32 bit instruction. Thus,
    we convert the arguments in the 16 bit trans_ function to the arguments of
    the corresponding 32 bit instruction and call the 32 bit trans_ function.

3) Remove old manual decoding in gen_* function [Patch 17-28]:
    this move all manual translation code into the trans_* instructions of
    decode tree, such that we can remove the old decode_* functions.

the full tree can be found here:
https://github.com/bkoppelmann/qemu/tree/riscv-dt

Cheers,
Bastian

Bastian Koppelmann (28):
  targer/riscv: Activate decodetree and implemnt LUI & AUIPC
  target/riscv: Convert RVXI branch insns to decodetree
  target/riscv: Convert RVXI load/store insns to decodetree
  target/riscv: Convert RVXI arithmetic insns to decodetree
  target/riscv: Convert RVXI fence insns to decodetree
  target/riscv: Convert RVXI csr insns to decodetree
  target/riscv: Convert RVXM insns to decodetree
  target/riscv: Convert RV32A insns to decodetree
  target/riscv: Convert RV64A insns to decodetree
  target/riscv: Convert RV32F insns to decodetree
  target/riscv: Convert RV64F insns to decodetree
  target/riscv: Convert RV32D insns to decodetree
  target/riscv: Convert RV64D insns to decodetree
  target/riscv: Convert RV priv insns to decodetree
  target/riscv: Convert quadrant 0 of RVXC insns to decodetree
  target/riscv: Convert quadrant 1 of RVXC insns to decodetree
  target/riscv: Convert quadrant 2 of RVXC insns to decodetree
  target/riscv: Remove gen_jalr()
  target/riscv: Replace gen_branch() with trans_branch()
  target/riscv: Replace gen_load() with trans_load()
  target/riscv: Replace gen_store() with trans_store()
  target/riscv: Move gen_arith_imm() decoding into trans_* functions
  target/riscv: make ADD/SUB/OR/XOR/AND insn use arg lists
  target/riscv: Remove shift and slt insn manual decoding
  target/riscv: Remove manual decoding of RV32/64M insn
  target/riscv: Remove gen_system()
  target/riscv: Remove decode_RV32_64G()
  target/riscv: Replace gen_exception_illegal with return false

 target/riscv/Makefile.objs                    |   17 +
 target/riscv/insn16.decode                    |  126 ++
 target/riscv/insn32.decode                    |  255 +++
 .../riscv/insn_trans/trans_privileged.inc.c   |  109 +
 target/riscv/insn_trans/trans_rva.inc.c       |  274 +++
 target/riscv/insn_trans/trans_rvc.inc.c       |  339 ++++
 target/riscv/insn_trans/trans_rvd.inc.c       |  407 ++++
 target/riscv/insn_trans/trans_rvf.inc.c       |  396 ++++
 target/riscv/insn_trans/trans_rvi.inc.c       |  624 ++++++
 target/riscv/insn_trans/trans_rvm.inc.c       |   94 +
 target/riscv/translate.c                      | 1745 ++---------------
 11 files changed, 2827 insertions(+), 1559 deletions(-)
 create mode 100644 target/riscv/insn16.decode
 create mode 100644 target/riscv/insn32.decode
 create mode 100644 target/riscv/insn_trans/trans_privileged.inc.c
 create mode 100644 target/riscv/insn_trans/trans_rva.inc.c
 create mode 100644 target/riscv/insn_trans/trans_rvc.inc.c
 create mode 100644 target/riscv/insn_trans/trans_rvd.inc.c
 create mode 100644 target/riscv/insn_trans/trans_rvf.inc.c
 create mode 100644 target/riscv/insn_trans/trans_rvi.inc.c
 create mode 100644 target/riscv/insn_trans/trans_rvm.inc.c

--
2.19.1
