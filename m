Received: from eggs.gnu.org ([209.51.188.92]:35908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gthNI-00018J-QZ
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 18:22:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gthNH-0004cx-D8
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 18:22:00 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:43687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gthNH-0004bK-6s
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 18:21:59 -0500
Received: by mail-pl1-x644.google.com with SMTP id f90so193852plb.10
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 15:21:58 -0800 (PST)
Date: Tue, 12 Feb 2019 15:21:56 -0800 (PST)
In-Reply-To: <20190123092538.8004-1-kbastian@mail.uni-paderborn.de>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-0fc7cd00-deda-4e41-abb3-c78657c4f0f1@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 00/35] target/riscv: Convert to
 decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: sagark@eecs.berkeley.edu, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-riscv@nongnu.org, peer.adelt@hni.uni-paderborn.de, richard.henderson@linaro.org, qemu-devel@nongnu.org

On Wed, 23 Jan 2019 01:25:03 PST (-0800), Bastian Koppelmann wrote:
> Hi,
>
> this patchset converts the RISC-V decoder to decodetree in four major steps:
>
> 1) Convert 32-bit instructions to decodetree [Patch 1-16]:
>     Many of the gen_* functions are called by the decode functions for 16-bit
>     and 32-bit functions. If we move translation code from the gen_*
>     functions to the generated trans_* functions of decode-tree, we get a lot of
>     duplication. Therefore, we mostly generate calls to the old gen_* function
>     which are properly replaced after step 2).
>
>     Each of the trans_ functions are grouped into files corresponding to their
>     ISA extension, e.g. addi which is in RV32I is translated in the file
>     'trans_rvi.inc.c'.
>
> 2) Convert 16-bit instructions to decodetree [Patch 17-19]:
>     All 16 bit instructions have a direct mapping to a 32 bit instruction. Thus,
>     we convert the arguments in the 16 bit trans_ function to the arguments of
>     the corresponding 32 bit instruction and call the 32 bit trans_ function.
>
> 3) Remove old manual decoding in gen_* function [Patch 20-30]:
>     this move all manual translation code into the trans_* instructions of
>     decode tree, such that we can remove the old decode_* functions.
>
> 4) Simplify RVC by reusing as much as possible from the RVG decoder as suggested
>    by Richard. [Patch 31-35]
>
> full tree available at
> https://github.com/bkoppelmann/qemu/tree/riscv-dt-v6
>
> Cheers,
> Bastian
>
> v5 -> v6:
>     - fixed funky indentation
>
>
> Bastian Koppelmann (35):
>   target/riscv: Move CPURISCVState pointer to DisasContext
>   target/riscv: Activate decodetree and implemnt LUI & AUIPC
>   target/riscv: Convert RVXI branch insns to decodetree
>   target/riscv: Convert RV32I load/store insns to decodetree
>   target/riscv: Convert RV64I load/store insns to decodetree
>   target/riscv: Convert RVXI arithmetic insns to decodetree
>   target/riscv: Convert RVXI fence insns to decodetree
>   target/riscv: Convert RVXI csr insns to decodetree
>   target/riscv: Convert RVXM insns to decodetree
>   target/riscv: Convert RV32A insns to decodetree
>   target/riscv: Convert RV64A insns to decodetree
>   target/riscv: Convert RV32F insns to decodetree
>   target/riscv: Convert RV64F insns to decodetree
>   target/riscv: Convert RV32D insns to decodetree
>   target/riscv: Convert RV64D insns to decodetree
>   target/riscv: Convert RV priv insns to decodetree
>   target/riscv: Convert quadrant 0 of RVXC insns to decodetree
>   target/riscv: Convert quadrant 1 of RVXC insns to decodetree
>   target/riscv: Convert quadrant 2 of RVXC insns to decodetree
>   target/riscv: Remove gen_jalr()
>   target/riscv: Remove manual decoding from gen_branch()
>   target/riscv: Remove manual decoding from gen_load()
>   target/riscv: Remove manual decoding from gen_store()
>   target/riscv: Move gen_arith_imm() decoding into trans_* functions
>   target/riscv: make ADD/SUB/OR/XOR/AND insn use arg lists
>   target/riscv: Remove shift and slt insn manual decoding
>   target/riscv: Remove manual decoding of RV32/64M insn
>   target/riscv: Rename trans_arith to gen_arith
>   target/riscv: Remove gen_system()
>   target/riscv: Remove decode_RV32_64G()
>   target/riscv: Convert @cs_2 insns to share translation functions
>   target/riscv: Convert @cl_d, @cl_w, @cs_d, @cs_w insns
>   target/riscv: Splice fsw_sd and flw_ld for riscv32 vs riscv64
>   target/riscv: Splice remaining compressed insn pairs for riscv32 vs
>     riscv64
>   target/riscv: Remaining rvc insn reuse 32 bit translators
>
>  target/riscv/Makefile.objs                    |   22 +
>  target/riscv/insn16-32.decode                 |   31 +
>  target/riscv/insn16-64.decode                 |   33 +
>  target/riscv/insn16.decode                    |  114 ++
>  target/riscv/insn32-64.decode                 |   72 +
>  target/riscv/insn32.decode                    |  203 ++
>  .../riscv/insn_trans/trans_privileged.inc.c   |  110 +
>  target/riscv/insn_trans/trans_rva.inc.c       |  207 ++
>  target/riscv/insn_trans/trans_rvc.inc.c       |  149 ++
>  target/riscv/insn_trans/trans_rvd.inc.c       |  388 ++++
>  target/riscv/insn_trans/trans_rvf.inc.c       |  388 ++++
>  target/riscv/insn_trans/trans_rvi.inc.c       |  568 ++++++
>  target/riscv/insn_trans/trans_rvm.inc.c       |  107 +
>  target/riscv/translate.c                      | 1781 ++---------------
>  14 files changed, 2611 insertions(+), 1562 deletions(-)
>  create mode 100644 target/riscv/insn16-32.decode
>  create mode 100644 target/riscv/insn16-64.decode
>  create mode 100644 target/riscv/insn16.decode
>  create mode 100644 target/riscv/insn32-64.decode
>  create mode 100644 target/riscv/insn32.decode
>  create mode 100644 target/riscv/insn_trans/trans_privileged.inc.c
>  create mode 100644 target/riscv/insn_trans/trans_rva.inc.c
>  create mode 100644 target/riscv/insn_trans/trans_rvc.inc.c
>  create mode 100644 target/riscv/insn_trans/trans_rvd.inc.c
>  create mode 100644 target/riscv/insn_trans/trans_rvf.inc.c
>  create mode 100644 target/riscv/insn_trans/trans_rvi.inc.c
>  create mode 100644 target/riscv/insn_trans/trans_rvm.inc.c

Do you, by any chance, have a v7?  It looks like there's quite a few merge 
conflicts here, and while I'm OK fixing them I don't want to do it if you 
already have.
