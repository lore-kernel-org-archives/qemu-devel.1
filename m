Received: from eggs.gnu.org ([2001:4830:134:3::10]:54556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gFRX0-0006Kt-Lo
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 18:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gFRWw-0005N5-3y
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 18:21:38 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:40526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gFRWv-0005IG-RC
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 18:21:34 -0400
Received: by mail-pg1-x543.google.com with SMTP id o14-v6so3001265pgv.7
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 15:21:27 -0700 (PDT)
Date: Wed, 24 Oct 2018 15:21:25 -0700 (PDT)
In-Reply-To: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-a68ddfc1-c1f3-4c28-97a5-bf5dfc9db931@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 00/29] target/riscv: Convert to
 decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Michael Clark <mjc@sifive.com>, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, peer.adelt@hni.uni-paderborn.de, Alistair Francis <Alistair.Francis@wdc.com>, richard.henderson@linaro.org, qemu-devel@nongnu.org

On Sat, 20 Oct 2018 00:14:22 PDT (-0700), kbastian@mail.uni-paderborn.de wrote:
> Hi,
>
> this patchset converts the RISC-V decoder to decodetree in three major steps:
>
> 1) Convert 32-bit instructions to decodetree [Patch 1-14]:
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
> 2) Convert 16-bit instructions to decodetree [Patch 15-17]:
>     All 16 bit instructions have a direct mapping to a 32 bit instruction. Thus,
>     we convert the arguments in the 16 bit trans_ function to the arguments of
>     the corresponding 32 bit instruction and call the 32 bit trans_ function.
>
> 3) Remove old manual decoding in gen_* function [Patch 17-28]:
>     this move all manual translation code into the trans_* instructions of
>     decode tree, such that we can remove the old decode_* functions.
>
> the full tree can be found here:
> https://github.com/bkoppelmann/qemu/tree/riscv-dt-v2

Thanks!

I dropped this on top of master and it appears I'm getting a bunch of oops when 
trying to boot Linux.  They're fairly far into the boot process and may be a 
mistake on my end, I was just wondering if you'd booted Linux?

I'll go through the patches and review them.

>
> Cheers,
> Bastian
>
> v1->v2:
>         - ex_shift_amount returns uint32_t
>         - use ctx->env instead of current_cpu->env_ptr
>         - fixed functionspacing
>         - RISCV32 now returns false instead of raising an exception
>         - shift translators now also use gen_arithm_imm()
>         - simplified fence/fence_i as suggested by Richard
>         - simplified gen_amo() with function pointers
>         - rs2 @atom_ld is now decimal
>         - use simplfied gen_amo() with function pointers
>         - REQUIRE_FPU uses do {} while (0)
>         - Add REQUIRE_FPU to arithm helpers
>         - RISCV32 now returns false instead of raising an exception
>         - Add REQUIRE_FPU to arithm helpers
>         - Stack allocate arg_c_* structs
>         - ex_rvc_register returns int
>         - special case of trans_c_addi4spn() returns false
>         - consistently return false for reserved cases instead of raising an
>           exception
>         - simplified trans_c_srli by Richard's suggestion
>         - remove extract_cj() since its result isn't used
>         - trans_branch -> gen_branch
>         - trans_load -> gen_load
>         - removed negative memop check
>         - trans_store -> gen_store
>         - removed negative memop check
>         - trans_arith_imm -> gen_arith_imm
>         - Add missing TARGET_RISC64 checks
>         - Reimplement shift translators that were omited in [0004/0028]
>         - trans_shift -> gen_shift
>         - Add missing TARGET_RISCV64 conditions
>         - trans_arith_w -> gen_arith_w
>         - Add missing gen_exception_illegal
>         - dropped 0028
>
>
> Bastian Koppelmann (29):
>   target/riscv: Move CPURISCVState pointer to DisasContext
>   targer/riscv: Activate decodetree and implemnt LUI & AUIPC
>   target/riscv: Convert RVXI branch insns to decodetree
>   target/riscv: Convert RVXI load/store insns to decodetree
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
>   target/riscv: Remove gen_system()
>   target/riscv: Remove decode_RV32_64G()
>   target/riscv: Rename trans_arith to gen_arith
>
>  target/riscv/Makefile.objs                    |   17 +
>  target/riscv/insn16.decode                    |  126 ++
>  target/riscv/insn32.decode                    |  256 +++
>  .../riscv/insn_trans/trans_privileged.inc.c   |  111 ++
>  target/riscv/insn_trans/trans_rva.inc.c       |  244 +++
>  target/riscv/insn_trans/trans_rvc.inc.c       |  337 ++++
>  target/riscv/insn_trans/trans_rvd.inc.c       |  413 ++++
>  target/riscv/insn_trans/trans_rvf.inc.c       |  402 ++++
>  target/riscv/insn_trans/trans_rvi.inc.c       |  629 ++++++
>  target/riscv/insn_trans/trans_rvm.inc.c       |  125 ++
>  target/riscv/translate.c                      | 1756 ++---------------
>  11 files changed, 2853 insertions(+), 1563 deletions(-)
>  create mode 100644 target/riscv/insn16.decode
>  create mode 100644 target/riscv/insn32.decode
>  create mode 100644 target/riscv/insn_trans/trans_privileged.inc.c
>  create mode 100644 target/riscv/insn_trans/trans_rva.inc.c
>  create mode 100644 target/riscv/insn_trans/trans_rvc.inc.c
>  create mode 100644 target/riscv/insn_trans/trans_rvd.inc.c
>  create mode 100644 target/riscv/insn_trans/trans_rvf.inc.c
>  create mode 100644 target/riscv/insn_trans/trans_rvi.inc.c
>  create mode 100644 target/riscv/insn_trans/trans_rvm.inc.c
