Received: from eggs.gnu.org ([2001:4830:134:3::10]:41777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPFmJ-0002lX-Hy
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 18:50:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPFmI-0004Kx-IP
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 18:49:59 -0500
MIME-Version: 1.0
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<f1a7d2617c26c1745fafe13bbe3bc3b042c14217.1542321076.git.alistair.francis@wdc.com>
	<23831afc-0ebf-5802-e8e2-6ce48dd340f9@linaro.org>
In-Reply-To: <23831afc-0ebf-5802-e8e2-6ce48dd340f9@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 20 Nov 2018 15:49:29 -0800
Message-ID: <CAKmqyKP5cCRZujTm+OvoNZWNwPhJirPLA7PjurbovnN8RYCcgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v1 15/23] riscv: tcg-target: Add branch and
 jump instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org

On Fri, Nov 16, 2018 at 1:14 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/15/18 11:36 PM, Alistair Francis wrote:
> > +static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
> > +                           TCGReg arg2, TCGLabel *l)
> > +{
> > +    RISCVInsn op = tcg_brcond_to_riscv[cond].op;
> > +    bool swap = tcg_brcond_to_riscv[cond].swap;
> > +
> > +    tcg_out_opc_branch(s, op, swap ? arg2 : arg1, swap ? arg1 : arg2, 0);
>
> You might want to tcg_debug_assert(op != 0) here.
>
> > +    if (l->has_value) {
> > +        reloc_sbimm12(s->code_ptr - 1, l->u.value_ptr);
>
> I'm concerned about the conditional branch range.  +-4K isn't much to work
> with.  The minimum we have for other hosts is +-32K.
>
> We have two options: (1) greatly reduce the max size of the TB for this host;
> (2) be prepared to emit a 2 insn sequence: conditional branch across
> unconditional branch, with forward branches that turn out to be small patched
> with a nop.
>
> FWIW, the first case would be done via modification of tcg_op_buf_full.  You
> might have to go as low as 500 opcodes, I'm not sure.

How do we do option 2?

>
> > +static inline void tcg_out_goto(TCGContext *s, tcg_insn_unit *target)
> > +{
> > +    ptrdiff_t offset = tcg_pcrel_diff(s, target);
> > +    tcg_debug_assert(offset == sextract64(offset, 0, 26));
> > +    tcg_out_opc_jump(s, OPC_JAL, TCG_REG_ZERO, offset);
> > +}
> > +
> > +static inline void tcg_out_goto_long(TCGContext *s, tcg_insn_unit *target)
> > +{
> > +    ptrdiff_t offset = tcg_pcrel_diff(s, target);
> > +
> > +    if (offset == sextract64(offset, 0, 26)) {
> > +        tcg_out_opc_jump(s, OPC_JAL, TCG_REG_ZERO, offset);
> > +    } else {
> > +        tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP0, (intptr_t)target);
> > +        tcg_out_opc_jump(s, OPC_JAL, TCG_REG_TMP0, 0);
> > +    }
> > +}
>
> How are these to be used?  I guess I'll find out...

It's called on a exit TB op. I'm not sure if that's correct though.

Alistair

>
> > +static void tcg_out_call_int(TCGContext *s, tcg_insn_unit *arg, bool tail)
> > +{
> > +    TCGReg link = tail ? TCG_REG_ZERO : TCG_REG_RA;
> > +    ptrdiff_t offset = tcg_pcrel_diff(s, arg);
> > +    if (offset == sextract32(offset, 1, 20) << 1) {
>
> sextract64.
>
> > +        /* short jump: -2097150 to 2097152 */
> > +        tcg_out_opc_jump(s, OPC_JAL, link, offset);
> > +    } else if (TCG_TARGET_REG_BITS == 32 ||
> > +        offset == sextract32(offset, 1, 31) << 1) {
>
> sextract64.
>
> > +        /* long jump: -2147483646 to 2147483648 */
> > +        tcg_out_opc_upper(s, OPC_AUIPC, TCG_REG_TMP0, 0);
> > +        tcg_out_opc_imm(s, OPC_JALR, link, TCG_REG_TMP0, 0);
> > +        reloc_call(s->code_ptr - 2, arg);
> > +    } else if (TCG_TARGET_REG_BITS == 64) {
> > +        /* far jump: 64-bit */
> > +        tcg_target_long imm = sextract32((tcg_target_long)arg, 0, 12);
> > +        tcg_target_long base = (tcg_target_long)arg - imm;
> > +        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, base);
> > +        tcg_out_opc_imm(s, OPC_JALR, link, TCG_REG_TMP0, imm);
>
>
> r~
