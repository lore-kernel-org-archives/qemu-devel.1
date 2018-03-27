Received: from eggs.gnu.org ([2001:4830:134:3::10]:39633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f0sdL-00004v-UD
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 13:43:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f0sdJ-0005rH-DV
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 13:43:43 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:35866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1f0sdJ-0005qy-3z
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 13:43:41 -0400
Received: by mail-oi0-x235.google.com with SMTP id t16-v6so19949276oih.3
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 10:43:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3cc72690-683f-a264-033c-25a2947f40fe@linaro.org>
References: <1521926678-76539-1-git-send-email-mjc@sifive.com>
	<3cc72690-683f-a264-033c-25a2947f40fe@linaro.org>
From: Michael Clark <mjc@sifive.com>
Date: Tue, 27 Mar 2018 10:43:39 -0700
Message-ID: <CAHNT7Ntgkq+j1LfO9rGQPyS+qG0YHtXAtd4ZiGc6q3j8HJJ7yQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1] RISC-V: RISC-V TCG backend work in
 progress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, Palmer Dabbelt <palmer@sifive.com>

On Tue, Mar 27, 2018 at 3:52 AM, Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 03/25/2018 05:24 AM, Michael Clark wrote:
> > Running with `-d in_asm,op,op_opt,out_asm` is very helpful
> > for debugging. Note: due to a limitation in QEMU, the backend
> > disassembler is not compiled, unless the backend matches
> > the front-end, so `scripts/disas-objdump.pl` is required
> > to decode the emmitted RISC-V assembly when using the x86_64
> > front-end.
>
> Certainly not.  The configure mistake, I think, is
>
> -  riscv)
> +  riscv*)
>      disas_config "RISCV"
>
> because for host $ARCH is going to be riscv64 not riscv.


Oh my mistake. Thanks for pointing this out. I'll fix this in v2.


> > +int cpu_signal_handler(int host_signum, void *pinfo,
> > +                       void *puc)
> > +{
> > +    siginfo_t *info = pinfo;
> > +    ucontext_t *uc = puc;
> > +    greg_t pc = uc->uc_mcontext.__gregs[REG_PC];
> > +    int is_write = 0;
>
> You're going to have to fill this in for many guests to work.  A data
> write to
> the same page for which we have executed code will fire here.
>
> If your host kernel does not supply the proper info via ucontext_t or
> siginfo_t
> (highly recommended, assuming the hardware reports this as part of the
> fault),
> then you'll need to do something as brute force as reading from the host
> PC and
> disassembling to see if it was a host store insn.
>

Apparently we don't have this in our ucontext and changing it would require
an ABI change. It seems siginfo_t only contains sa_addr. We have space
reserved in ucontext. If we were to add it to our ucontext, we could use 0
for unknown. It seems we'll need to use the host PC and disassemble the
instruction.


> I believe you can see this with e.g. sparc from our
> linux-user-test-0.3.tgz on
> the qemu wiki.
>
> > +/* optional instructions */
> > +#define TCG_TARGET_HAS_goto_ptr         1
> > +#define TCG_TARGET_HAS_movcond_i32      0
>
> Future: Does your real hardware do what the arch manual describes and
> predicate
> a jump across a single register move instruction?  Either way, for output
> code
> density you may wish to implement
>
>         movcond_i32  out,x,y,in,out,cc
> as
>         bcc     x, y, .+8
>         mov     out, in
>
> rather than allow the tcg middle-end to expand to a 5 insn sequence.  See
> e.g.
> i386, ppc, s390 where we do exactly this when the hardware does not
> support a
> real conditional move insn.


Okay I'll implement movcond as a bcc +8 and mv.

> +    if ((ct & TCG_CT_CONST_N12) && val >= -2047 && val <= 2047) {
>
> +2048?


We use this constraint for a negatable immediate and the constraint is only
applied to sub. We have no subi, so we implement subi as addi rd, rs1, -imm

    case INDEX_op_sub_i32:
        if (c2) {
            tcg_out_opc_imm(s, is32bit ? OPC_ADDI : OPC_ADDIW, a0, a1, -a2);
        } else {
            tcg_out_opc_reg(s, is32bit ? OPC_SUB : OPC_SUBW, a0, a1, a2);
        }
        break;



> > +/* Type-S */
> > +
> > +static int32_t encode_simm12(uint32_t imm)
> > +{
> > +    return ((imm << 20) >> 25) << 25 | ((imm << 27) >> 27) << 7;
>
> Probably more legible as
>
>   extract32(imm, 0, 5) << 7 | extract32(imm, 5, 7) << 25


I can change these to extract32.

I actually wrote code to generate these from instruction set metadata so
that I could avoid manual transcription errors


> > +/* Type-SB */
> > +
> > +static int32_t encode_sbimm12(uint32_t imm)
> > +{
> > +    return ((imm << 19) >> 31) << 31 | ((imm << 21) >> 26) << 25 |
> > +           ((imm << 27) >> 28) << 8 | ((imm << 20) >> 31) << 7;
> > +}
>
> Similarly.
>
> > +static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
> > +                         tcg_target_long val)
> > +{
> > +    tcg_target_long lo = sextract64(val, 0, 12);
> > +    tcg_target_long hi = val - lo;
> > +
> > +    RISCVInsn add32_op = TCG_TARGET_REG_BITS == 64 ? OPC_ADDIW :
> OPC_ADDI;
> > +
> > +    if (val == lo) {
> > +        tcg_out_opc_imm(s, OPC_ADDI, rd, TCG_REG_ZERO, val);
> > +    } else if (val && !(val & (val - 1))) {
> > +        /* power of 2 */
> > +        tcg_out_opc_imm(s, OPC_ADDI, rd, TCG_REG_ZERO, 1);
> > +        tcg_out_opc_imm(s, OPC_SLLI, rd, rd, ctz64(val));
> > +    } else if (TCG_TARGET_REG_BITS == 64 &&
> > +               !(val >> 31 == 0 || val >> 31 == -1)) {
> > +        int shift = 12 + ctz64(hi >> 12);
> > +        hi >>= shift;
> > +        tcg_out_movi(s, type, rd, hi);
> > +        tcg_out_opc_imm(s, OPC_SLLI, rd, rd, shift);
> > +        if (lo != 0) {
> > +            tcg_out_opc_imm(s, OPC_ADDI, rd, rd, lo);
> > +        }
>
> Future: The other special case that happens frequently is loading of a
> 64-bit
> host address.  E.g. for exit_tb after goto_tb, the address of the TB
> itself.
> You will want to test to see if auipc+addi can load the value before
> falling
> back to the full 64-bit constant load.
>

Good idea. I'll implement auipc+addi


> Future: I'll note that your worst-case here is 8 insns.  Consider using the
> constant pool instead of really long sequences.


I was thinking about using the constant pool. I'm in two minds about it,
given the load to use latency vs icache bandwidth. It would need some
benchmarking.


> > +static void tcg_out_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
> > +                         TCGReg addr, intptr_t offset)
> > +{
> > +    int32_t imm12 = sextract32(offset, 0, 12);
> > +    if (offset != imm12) {
> > +        if (addr == TCG_REG_ZERO) {
> > +            addr = TCG_REG_TMP0;
> > +        }
> > +        tcg_out_movi(s, TCG_TYPE_PTR, addr, offset - imm12);
> > +    }
>
> This isn't right.  You need to add offset to the original ADDR, not
> overwrite
> it.  Something like
>
>     tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset - imm12);
>     if (addr != TCG_REG_ZERO) {
>         tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP0, TCG_REG_TMP0, addr);
>     }
>     addr = TCG_REG_TMP0;


Thanks. This probably explains the bugs I am seeing.

> +static void tcg_out_jump_internal(TCGContext *s, tcg_insn_unit *arg,
> bool tail)
> > +{
> > +    TCGReg link = tail ? TCG_REG_ZERO : TCG_REG_RA;
> > +    ptrdiff_t offset = tcg_pcrel_diff(s, arg);
> > +    if (offset == sextract64(offset, 1, 12)) {
>

Alsom these tests need to shift the extract 1 bit left, so it was emitting
the far jump.


> > +        /* short jump: -4094 to 4096 */
> > +        tcg_out_opc_jump(s, OPC_JAL, link, offset);
>
> Err... the direct JAL encodes a 21-bit constant.  What's the 4k test for?


Brain fade.


> > +    } else if (offset == sextract64(offset, 1, 31)) {
>

should be:

} else if (offset == sextract64(offset, 1, 31) << 1) {

> +        /* long jump: -2147483646 to 2147483648 */
> > +        tcg_out_opc_upper(s, OPC_AUIPC, TCG_REG_TMP0, 0);
> > +        tcg_out_opc_imm(s, OPC_JALR, link, TCG_REG_TMP0, 0);
> > +        reloc_call(s->code_ptr - 2, arg);
>
> Check for riscv32 here, to avoid the real compare and elide the 64-bit
> case?


Will do.


> > +    } else {
> > +        /* far jump: 64-bit */
> > +        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0,
> (tcg_target_long)arg);
> > +        tcg_out_opc_imm(s, OPC_JALR, link, TCG_REG_TMP0, 0);
>
> Fold the final 12 bits into the JALR?


Good idea.


> > +static void tcg_out_mb(TCGContext *s, TCGArg a0)
> > +{
> > +    static const RISCVInsn fence[] = {
> > +        [0 ... TCG_MO_ALL] = OPC_FENCE_RW_RW,
> > +        [TCG_MO_LD_LD]     = OPC_FENCE_R_R,
> > +        [TCG_MO_ST_LD]     = OPC_FENCE_W_R,
> > +        [TCG_MO_LD_ST]     = OPC_FENCE_R_W,
> > +        [TCG_MO_ST_ST]     = OPC_FENCE_W_W,
> > +        [TCG_BAR_LDAQ]     = OPC_FENCE_RW_R,
> > +        [TCG_BAR_STRL]     = OPC_FENCE_W_RW,
> > +        [TCG_BAR_SC]       = OPC_FENCE_RW_RW,
> > +    };
> > +    tcg_out32(s, fence[a0 & TCG_MO_ALL]);
>
> This is wrong.  In particular, TCG_BAR_* is irrelevant to OPC_FENCE.
> More, TCG_MO_* are bit combinations.  A good mapping might be
>
>     uint32_t insn = OPC_FENCE;
>     if (a0 & TCG_MO_LD_LD) {
>         insn |= (1 << 25) | (1 << 21);  /* PR | SR */
>     }
>     if (a0 & TCG_MO_ST_LD) {
>         insn |= (1 << 24) | (1 << 21);  /* PW | SR */
>     }
>     if (a0 & TCG_MO_LD_ST) {
>         insn |= (1 << 25) | (1 << 20);  /* PR | SW */
>     }
>     if (a0 & TCG_MO_ST_ST) {
>         insn |= (1 << 24) | (1 << 20);  /* PW | SW */
>     }
>
> You could fold this into a table, but it's moderately clear like this.


Okay. Thanks. I'll look at the linux kernel barrier implementation. There
has been some discussion on the linux kernel mailing list about barriers...


> > +    case MO_Q:
> > +        /* Prefer to load from offset 0 first, but allow for overlap.
> */
> > +        if (TCG_TARGET_REG_BITS == 64) {
> > +            tcg_out_opc_imm(s, OPC_LD, lo, base, 0);
> > +        } else {
> > +            tcg_out_opc_imm(s, OPC_LW, lo, base, 0);
> > +            tcg_out_opc_imm(s, OPC_LW, hi, base, 4);
>
> Without extra constraints, you have to care for LO (or HI) overlapping
> BASE.
>
> > +    case INDEX_op_goto_tb:
> > +        if (s->tb_jmp_insn_offset) {
> > +            /* direct jump method */
> > +            s->tb_jmp_insn_offset[a0] = tcg_current_code_size(s);
> > +            /* should align on 64-bit boundary for atomic patching */
> > +            tcg_out_opc_upper(s, OPC_AUIPC, TCG_REG_TMP0, 0);
> > +            tcg_out_opc_imm(s, OPC_JALR, TCG_REG_ZERO, TCG_REG_TMP0, 0);
>
> You're not actually using this path yet, right?
> Probably better to remove it for now until all of the other pieces are
> present.
>

I'm not sure. I'll instrument it. I remember seeing reloc_call being called
but i'm not sure how these are generated. I'll read the TCG code...


> > +    case INDEX_op_br:
> > +        tcg_out_reloc(s, s->code_ptr, R_RISCV_CALL, arg_label(a0), 0);
> > +        tcg_out_opc_upper(s, OPC_AUIPC, TCG_REG_TMP0, 0);
> > +        tcg_out_opc_imm(s, OPC_JALR, TCG_REG_ZERO, TCG_REG_TMP0, 0);
>
> You should be able to just use JAL here.  1MB range should be smaller than
> any
> one TB.  There is never a BR opcode between different TB; that's the
> GOTO_TB
> opcode.
>

Okay great.

Thanks for the detailed feedback...
