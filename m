Received: from eggs.gnu.org ([2001:4830:134:3::10]:36948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gHqQj-000427-9f
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:21:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gHqQf-0002NU-QM
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:21:04 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Wed, 31 Oct 2018 14:19:54 +0100
Message-Id: <20181031132029.4887-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 00/35] target/riscv: Convert to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com, kbastian@mail.uni-paderborn.de, Alistair.Francis@wdc.com
Cc: richard.henderson@linaro.org, peer.adelt@hni.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org

Hi,

this patchset converts the RISC-V decoder to decodetree in four major steps:

1) Convert 32-bit instructions to decodetree [Patch 1-16]:
    Many of the gen_* functions are called by the decode functions for 16-bit
    and 32-bit functions. If we move translation code from the gen_*
    functions to the generated trans_* functions of decode-tree, we get a lot of
    duplication. Therefore, we mostly generate calls to the old gen_* function
    which are properly replaced after step 2).

    Each of the trans_ functions are grouped into files corresponding to their
    ISA extension, e.g. addi which is in RV32I is translated in the file
    'trans_rvi.inc.c'.

2) Convert 16-bit instructions to decodetree [Patch 17-19]:
    All 16 bit instructions have a direct mapping to a 32 bit instruction. Thus,
    we convert the arguments in the 16 bit trans_ function to the arguments of
    the corresponding 32 bit instruction and call the 32 bit trans_ function.

3) Remove old manual decoding in gen_* function [Patch 20-30]:
    this move all manual translation code into the trans_* instructions of
    decode tree, such that we can remove the old decode_* functions.

4) Simply RVC by reusing as much as possible from the RVG decoder as suggested
   by Richard. [Patch 31-35]

this series depends on the decodetree patches by Richard:
https://github.com/rth7680/qemu/tree/decodetree

full tree available at
https://github.com/bkoppelmann/qemu/tree/riscv-dt-v3

Cheers,
Bastian

v2 -> v3:
   - ex_shift_amount returns int
   - dropped insn argument of trans_foo functions
   - removal of AUIPC moved to 0002
   - &branch -> &b
   - split 0004 into two patches for RV32 and RV64
   - moved 64-bit only insn to insn64.decode
   - removed %pred/%succ
   - dropped TARGET_RISCV64 requirement for fclass_d
   - illegal instruction call replaced with return false
   - trans_c_flw_ld and trans_c_fsw_sd now return false for now, as we
     cannot use the insn argument anymore for manual decoding. We fix this
     in a later patch when rvc is properly split up into insn16-32.decode
     and insn16-64.decode.
   - special case of trans_c_addi4spn() returns false in this patch
   - simplified trans_c_srai by Richard's suggestion
   - Since trans_c_flw_ld and trans_c_fsw_sd still rely on the old decoder
     we need to keep gen_load(). Thus we renamed it to gen_load_c.
   - Since trans_c_flw_ld and trans_c_fsw_sd still rely on the old decoder
     we need to keep gen_store(). Thus we renamed it to gen_store_c.
   - tcg_memop_lookup is now only used by TARGET_RISCV64 insn so we wrapped
     it in a ifdef
   - trans_srli/srai now use tcg_gen_shri/srai_tl
   - trans_addiw uses its own gen_addiw function which properly extends the
     result
   - &arith_imm -> &i
   - &arith -> &r
   - trans_mulw now uses gen_mulw which properly sign extends the result
   - gen_arith_w -> gen_arith_div_w
   - gen_arith_div_w properly sign extends the resul


Bastian Koppelmann (35):
  target/riscv: Move CPURISCVState pointer to DisasContext
  target/riscv: Activate decodetree and implemnt LUI & AUIPC
  target/riscv: Convert RVXI branch insns to decodetree
  target/riscv: Convert RV32I load/store insns to decodetree
  target/riscv: Convert RV64I load/store insns to decodetree
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
  target/riscv: Remove manual decoding from gen_branch()
  target/riscv: Remove manual decoding from gen_load()
  target/riscv: Remove manual decoding from gen_store()
  target/riscv: Move gen_arith_imm() decoding into trans_* functions
  target/riscv: make ADD/SUB/OR/XOR/AND insn use arg lists
  target/riscv: Remove shift and slt insn manual decoding
  target/riscv: Remove manual decoding of RV32/64M insn
  target/riscv: Rename trans_arith to gen_arith
  target/riscv: Remove gen_system()
  target/riscv: Remove decode_RV32_64G()
  target/riscv: Convert @cs_2 insns to share translation functions
  target/riscv: Convert @cl_d, @cl_w, @cs_d, @cs_w insns
  target/riscv: Splice fsw_sd and flw_ld for riscv32 vs riscv64
  target/riscv: Splice remaining compressed insn pairs for riscv32 vs
    riscv64
  target/riscv: Remaining rvc insn reuse 32 bit translators

 target/riscv/Makefile.objs                    |   22 +
 target/riscv/insn16-32.decode                 |   31 +
 target/riscv/insn16-64.decode                 |   33 +
 target/riscv/insn16.decode                    |  114 ++
 target/riscv/insn32.decode                    |  203 ++
 target/riscv/insn64.decode                    |   72 +
 .../riscv/insn_trans/trans_privileged.inc.c   |  108 +
 target/riscv/insn_trans/trans_rva.inc.c       |  203 ++
 target/riscv/insn_trans/trans_rvc.inc.c       |  149 ++
 target/riscv/insn_trans/trans_rvd.inc.c       |  388 ++++
 target/riscv/insn_trans/trans_rvf.inc.c       |  388 ++++
 target/riscv/insn_trans/trans_rvi.inc.c       |  584 ++++++
 target/riscv/insn_trans/trans_rvm.inc.c       |  107 +
 target/riscv/translate.c                      | 1771 ++---------------
 14 files changed, 2615 insertions(+), 1558 deletions(-)
 create mode 100644 target/riscv/insn16-32.decode
 create mode 100644 target/riscv/insn16-64.decode
 create mode 100644 target/riscv/insn16.decode
 create mode 100644 target/riscv/insn32.decode
 create mode 100644 target/riscv/insn64.decode
 create mode 100644 target/riscv/insn_trans/trans_privileged.inc.c
 create mode 100644 target/riscv/insn_trans/trans_rva.inc.c
 create mode 100644 target/riscv/insn_trans/trans_rvc.inc.c
 create mode 100644 target/riscv/insn_trans/trans_rvd.inc.c
 create mode 100644 target/riscv/insn_trans/trans_rvf.inc.c
 create mode 100644 target/riscv/insn_trans/trans_rvi.inc.c
 create mode 100644 target/riscv/insn_trans/trans_rvm.inc.c

-- 
2.19.1
