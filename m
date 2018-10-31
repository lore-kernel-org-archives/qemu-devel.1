Received: from eggs.gnu.org ([2001:4830:134:3::10]:41313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gHxN4-0003kV-7m
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 16:45:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gHxN1-0000IM-KX
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 16:45:45 -0400
MIME-Version: 1.0
References: <20181031132029.4887-1-kbastian@mail.uni-paderborn.de>
	<20181031132029.4887-26-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20181031132029.4887-26-kbastian@mail.uni-paderborn.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 31 Oct 2018 13:44:48 -0700
Message-ID: <CAKmqyKNKC7TFNYmH242EEbD8y7m3ZSZ+BCA5i+GiqaK5j-u8qg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 25/35] target/riscv: make
 ADD/SUB/OR/XOR/AND insn use arg lists
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org, peer.adelt@hni.uni-paderborn.de, Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Oct 31, 2018 at 6:29 AM Bastian Koppelmann
<kbastian@mail.uni-paderborn.de> wrote:
>
> manual decoding in gen_arith() is not necessary with decodetree. For now
> the function is called trans_arith as the original gen_arith still
> exists. The former will be renamed to gen_arith as soon as the old
> gen_arith can be removed.

This series causes a lot of kernel oops during boot (see below for an
example) and I bisected it to this patch.

[    3.292000] Unable to handle kernel paging request at virtual
address ffffffa078a9401d
[    3.292000] Oops [#2]
[    3.292000] Modules linked in:
[    3.292000] CPU: 0 PID: 64 Comm: systemd-journal Tainted: G      D
         4.18.0-riscv #1
[    3.292000] sepc: ffffffe00057e266 ra : ffffffe000136094 sp :
ffffffe078aa9d10
[    3.292000]  gp : ffffffe00078eb98 tp : ffffffe078a81180 t0 :
00000000000001f8
[    3.292000]  t1 : 0000000000000022 t2 : 0000000000000000 s0 :
ffffffe078aa9d20
[    3.292000]  s1 : ffffffe078a81180 a0 : ffffffa078a9401d a1 :
0000004000000136
[    3.292000]  a2 : 0000000000000001 a3 : 0000000000000000 a4 :
ffffffc00000001d
[    3.292000]  a5 : ffffffe078a94000 a6 : ffffffe00000b508 a7 :
0000003fff89ce87
[    3.292000]  s2 : 0000000000000153 s3 : ffffffe078aa9e98 s4 :
0000002aaaac44e0
[    3.292000]  s5 : 0000000000000000 s6 : 0000000000000000 s7 :
0000000000000153
[    3.292000]  s8 : 0000000000000153 s9 : 0000003fff89ce87 s10:
0000003fff89cea5
[    3.292000]  s11: ffffffe078a18d00 t3 : 000000003e264cd7 t4 :
0000000000000078
[    3.292000]  t5 : 000000000000006d t6 : ffffffe078a94153
[    3.292000] sstatus: 0000000000000120 sbadaddr: ffffffa078a9401d
scause: 000000000000000d
[    3.296000] ---[ end trace 3cae92dc85ff86eb ]---
[FAILED] Failed to start Journal Service.

Alistair

>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
> ---
> v2 -> v3:
>     - &arith -> &r
>
>  target/riscv/insn32.decode              |  3 ++-
>  target/riscv/insn_trans/trans_rvi.inc.c | 21 ++++++----------
>  target/riscv/translate.c                | 33 ++++++++++++++-----------
>  3 files changed, 27 insertions(+), 30 deletions(-)
>
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 70e00412b6..520954e9c6 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -36,11 +36,12 @@
>  # Argument sets:
>  &b    imm rs2 rs1
>  &i    imm rs1 rd
> +&r    rd rs1 rs2
>  &shift     shamt rs1 rd
>  &atomic    aq rl rs2 rs1 rd
>
>  # Formats 32:
> -@r       .......   ..... ..... ... ..... .......                   %rs2 %rs1 %rd
> +@r       .......   ..... ..... ... ..... ....... &r                %rs2 %rs1 %rd
>  @i       ............    ..... ... ..... ....... &i      imm=%imm_i     %rs1 %rd
>  @b       .......   ..... ..... ... ..... ....... &b      imm=%imm_b %rs2 %rs1
>  @s       .......   ..... ..... ... ..... .......         imm=%imm_s %rs2 %rs1
> diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
> index 8bd2752f31..5b5999954a 100644
> --- a/target/riscv/insn_trans/trans_rvi.inc.c
> +++ b/target/riscv/insn_trans/trans_rvi.inc.c
> @@ -301,14 +301,12 @@ static bool trans_srai(DisasContext *ctx, arg_srai *a)
>
>  static bool trans_add(DisasContext *ctx, arg_add *a)
>  {
> -    gen_arith(ctx, OPC_RISC_ADD, a->rd, a->rs1, a->rs2);
> -    return true;
> +    return trans_arith(ctx, a, &tcg_gen_add_tl);
>  }
>
>  static bool trans_sub(DisasContext *ctx, arg_sub *a)
>  {
> -    gen_arith(ctx, OPC_RISC_SUB, a->rd, a->rs1, a->rs2);
> -    return true;
> +    return trans_arith(ctx, a, &tcg_gen_sub_tl);
>  }
>
>  static bool trans_sll(DisasContext *ctx, arg_sll *a)
> @@ -331,8 +329,7 @@ static bool trans_sltu(DisasContext *ctx, arg_sltu *a)
>
>  static bool trans_xor(DisasContext *ctx, arg_xor *a)
>  {
> -    gen_arith(ctx, OPC_RISC_XOR, a->rd, a->rs1, a->rs2);
> -    return true;
> +    return trans_arith(ctx, a, &tcg_gen_xor_tl);
>  }
>
>  static bool trans_srl(DisasContext *ctx, arg_srl *a)
> @@ -349,14 +346,12 @@ static bool trans_sra(DisasContext *ctx, arg_sra *a)
>
>  static bool trans_or(DisasContext *ctx, arg_or *a)
>  {
> -    gen_arith(ctx, OPC_RISC_OR, a->rd, a->rs1, a->rs2);
> -    return true;
> +    return trans_arith(ctx, a, &tcg_gen_or_tl);
>  }
>
>  static bool trans_and(DisasContext *ctx, arg_and *a)
>  {
> -    gen_arith(ctx, OPC_RISC_AND, a->rd, a->rs1, a->rs2);
> -    return true;
> +    return trans_arith(ctx, a, &tcg_gen_and_tl);
>  }
>
>  #ifdef TARGET_RISCV64
> @@ -405,14 +400,12 @@ static bool trans_sraiw(DisasContext *ctx, arg_sraiw *a)
>
>  static bool trans_addw(DisasContext *ctx, arg_addw *a)
>  {
> -    gen_arith(ctx, OPC_RISC_ADDW, a->rd, a->rs1, a->rs2);
> -    return true;
> +    return trans_arith(ctx, a, &tcg_gen_add_tl);
>  }
>
>  static bool trans_subw(DisasContext *ctx, arg_subw *a)
>  {
> -    gen_arith(ctx, OPC_RISC_SUBW, a->rd, a->rs1, a->rs2);
> -    return true;
> +    return trans_arith(ctx, a, &tcg_gen_sub_tl);
>  }
>
>  static bool trans_sllw(DisasContext *ctx, arg_sllw *a)
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index de60686df4..a781aba08c 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -192,12 +192,6 @@ static void gen_arith(DisasContext *ctx, uint32_t opc, int rd, int rs1,
>      gen_get_gpr(source2, rs2);
>
>      switch (opc) {
> -    CASE_OP_32_64(OPC_RISC_ADD):
> -        tcg_gen_add_tl(source1, source1, source2);
> -        break;
> -    CASE_OP_32_64(OPC_RISC_SUB):
> -        tcg_gen_sub_tl(source1, source1, source2);
> -        break;
>  #if defined(TARGET_RISCV64)
>      case OPC_RISC_SLLW:
>          tcg_gen_andi_tl(source2, source2, 0x1F);
> @@ -214,9 +208,6 @@ static void gen_arith(DisasContext *ctx, uint32_t opc, int rd, int rs1,
>      case OPC_RISC_SLTU:
>          tcg_gen_setcond_tl(TCG_COND_LTU, source1, source1, source2);
>          break;
> -    case OPC_RISC_XOR:
> -        tcg_gen_xor_tl(source1, source1, source2);
> -        break;
>  #if defined(TARGET_RISCV64)
>      case OPC_RISC_SRLW:
>          /* clear upper 32 */
> @@ -242,12 +233,6 @@ static void gen_arith(DisasContext *ctx, uint32_t opc, int rd, int rs1,
>          tcg_gen_andi_tl(source2, source2, TARGET_LONG_BITS - 1);
>          tcg_gen_sar_tl(source1, source1, source2);
>          break;
> -    case OPC_RISC_OR:
> -        tcg_gen_or_tl(source1, source1, source2);
> -        break;
> -    case OPC_RISC_AND:
> -        tcg_gen_and_tl(source1, source1, source2);
> -        break;
>      CASE_OP_32_64(OPC_RISC_MUL):
>          tcg_gen_mul_tl(source1, source1, source2);
>          break;
> @@ -644,6 +629,24 @@ static void gen_addiw(TCGv ret, TCGv arg1, TCGv arg2)
>  }
>  #endif
>
> +static bool trans_arith(DisasContext *ctx, arg_r *a,
> +                        void(*func)(TCGv, TCGv, TCGv))
> +{
> +    TCGv source1, source2;
> +    source1 = tcg_temp_new();
> +    source2 = tcg_temp_new();
> +
> +    gen_get_gpr(source1, a->rs1);
> +    gen_get_gpr(source2, a->rs2);
> +
> +    (*func)(source1, source1, source2);
> +
> +    gen_set_gpr(a->rd, source1);
> +    tcg_temp_free(source1);
> +    tcg_temp_free(source2);
> +    return true;
> +}
> +
>  /* Include insn module translation function */
>  #include "insn_trans/trans_rvi.inc.c"
>  #include "insn_trans/trans_rvm.inc.c"
> --
> 2.19.1
>
>
