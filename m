Received: from eggs.gnu.org ([2001:4830:134:3::10]:41836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gRPqZ-0007Ll-LZ
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 17:59:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gRPqY-0005o5-Qm
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 17:59:19 -0500
MIME-Version: 1.0
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<f1a7d2617c26c1745fafe13bbe3bc3b042c14217.1542321076.git.alistair.francis@wdc.com>
	<23831afc-0ebf-5802-e8e2-6ce48dd340f9@linaro.org>
	<CAKmqyKP5cCRZujTm+OvoNZWNwPhJirPLA7PjurbovnN8RYCcgQ@mail.gmail.com>
	<8bacdaca-94c2-d2c7-3af7-b98517a98b64@linaro.org>
In-Reply-To: <8bacdaca-94c2-d2c7-3af7-b98517a98b64@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 26 Nov 2018 14:58:50 -0800
Message-ID: <CAKmqyKM-+HDbUGNjZjS5f0HaqzOpsms3j3+wVgo7gjvL-JT0CQ@mail.gmail.com>
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

On Tue, Nov 20, 2018 at 11:40 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/21/18 12:49 AM, Alistair Francis wrote:
> > On Fri, Nov 16, 2018 at 1:14 AM Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> On 11/15/18 11:36 PM, Alistair Francis wrote:
> >>> +static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
> >>> +                           TCGReg arg2, TCGLabel *l)
> >>> +{
> >>> +    RISCVInsn op = tcg_brcond_to_riscv[cond].op;
> >>> +    bool swap = tcg_brcond_to_riscv[cond].swap;
> >>> +
> >>> +    tcg_out_opc_branch(s, op, swap ? arg2 : arg1, swap ? arg1 : arg2, 0);
> >>
> >> You might want to tcg_debug_assert(op != 0) here.
> >>
> >>> +    if (l->has_value) {
> >>> +        reloc_sbimm12(s->code_ptr - 1, l->u.value_ptr);
> >>
> >> I'm concerned about the conditional branch range.  +-4K isn't much to work
> >> with.  The minimum we have for other hosts is +-32K.
> >>
> >> We have two options: (1) greatly reduce the max size of the TB for this host;
> >> (2) be prepared to emit a 2 insn sequence: conditional branch across
> >> unconditional branch, with forward branches that turn out to be small patched
> >> with a nop.
> >>
> >> FWIW, the first case would be done via modification of tcg_op_buf_full.  You
> >> might have to go as low as 500 opcodes, I'm not sure.
> >
> > How do we do option 2?
>
> If l->has_value, just check the actual range.  But of course backward branching
> isn't that common in tcg generated code.  Most branches within the TB are short
> forward branches, but we also don't know how short is short.
>
> But every TB begins with a test of env->exit_code and a conditional branch to
> the end of the block, where we place some code to return to the main loop and
> return the pointer to the TB at which we exited.  Thus every TB has a branch
> that spans the size of the entire TB.
>
> So, invent (or repurpose) an R_RISCV_FOO value.  It doesn't matter which
> because it's private within tcg/riscv/.  Just add some commentary.  (See e.g.
> tcg/sparc/ and its use of R_SPARC_13.)
>
> While generating code, emit the conditional branch as normal; leave the unknown
> destination 0 for now.  Emit a nop as the second insn.
>
> When resolving R_RISCV_FOO, if the conditional branch is in range, great!  Just
> patch it.  If it is out of range, then you need to edit the conditional branch
> to reverse the condition (insn ^ (1 << 12)) and branch to pc+8, i.e. over the
> next instruction.  Which was a nop during generation, but you will now install
> jal r0,dest going to the real destination.

Ok, I think I have done this correctly. I have something that compiles and runs.

I'll send a second RFC out sometime this week. It won't be based on
your latest patches and it's still missing some things but I want to
keep this moving along.

Thanks so much for your help Richard!

Alistair

>
>
> r~
