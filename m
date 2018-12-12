Received: from eggs.gnu.org ([2001:4830:134:3::10]:59017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gWs0u-0005Zj-Rc
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 19:04:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gWs0u-0004AO-14
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 19:04:32 -0500
MIME-Version: 1.0
References: <cover.1544229872.git.alistair.francis@wdc.com>
	<c1cbe33881d567ee4712128282e6fcc49a5736b5.1544229872.git.alistair.francis@wdc.com>
	<98465a90-99cc-bce6-8cde-5025a30b3785@linaro.org>
	<042678a6-6837-e272-e4fa-eb0a8f265e6b@linaro.org>
In-Reply-To: <042678a6-6837-e272-e4fa-eb0a8f265e6b@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 11 Dec 2018 16:04:03 -0800
Message-ID: <CAKmqyKNGDCkqL1VzdLBm+dwVx6C9PTUP+amzHfZeqTifC1Ef7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v3 19/24] riscv: tcg-target: Add the out op
 decoder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>

On Tue, Dec 11, 2018 at 2:45 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 12/10/18 11:56 AM, Richard Henderson wrote:
> > On 12/7/18 6:49 PM, Alistair Francis wrote:
> >> +    case INDEX_op_neg_i64:
> >> +        tcg_out_opc_imm(s, OPC_SUB, a0, TCG_REG_ZERO, a1);
> >
> > tcg_out_opc_reg.
> >
> >> +    case INDEX_op_mulsh_i32:
> >> +    case INDEX_op_mulsh_i64:
> >> +        tcg_out_opc_imm(s, OPC_MULH, a0, a1, a2);
> >> +        break;
> >> +
> >> +    case INDEX_op_muluh_i32:
> >> +    case INDEX_op_muluh_i64:
> >> +        tcg_out_opc_imm(s, OPC_MULHU, a0, a1, a2);
> >> +        break;
> >
> > Likewise.
>
> Incidentally, catching these sorts of errors is why tcg/s390 puts the format of
> the insn into the enum.  E.g.
>
> /* Emit an opcode with "type-checking" of the format.  */
> #define tcg_out_insn(S, FMT, OP, ...) \
>     glue(tcg_out_insn_,FMT)(S, glue(glue(FMT,_),OP), ## __VA_ARGS__)
>
>     tcg_out_insn(s, RR, AR, a0, a2);
>     tcg_out_insn(s, RRE, AGR, TCG_TMP0, index);
>
> /* All of the following instructions are prefixed with their instruction
>    format...  */
> typedef enum S390Opcode {
>     ...
>     RR_AR       = 0x1a,
>     RRE_AGR     = 0xb908,

That is really cool.

>
>
> I do something similar for tcg/aarch64, although that's more complicated due to
> the wide variety of formats.
>
> Whether you go back and retro-fit this scheme to your existing patch set is up
> to you.  But I think it could be worthwhile.

It looks like I'm ready to send a patch series (instead of an RFC) so
I might leave it for now. There are a range of improvements we can
work on in the future, this can be yet another one.

Alistair

>
>
> r~
