Received: from eggs.gnu.org ([2001:4830:134:3::10]:34864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gSAo2-0003J3-OW
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 20:07:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gSAo1-0002LT-2A
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 20:07:50 -0500
MIME-Version: 1.0
References: <cover.1543352682.git.alistair.francis@wdc.com>
	<aa41323b013a6c77e28d487d49026df36d60e4c5.1543352682.git.alistair.francis@wdc.com>
	<ea1df40c-ce6c-16a0-4256-298f32748c6c@linaro.org>
In-Reply-To: <ea1df40c-ce6c-16a0-4256-298f32748c6c@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 28 Nov 2018 17:06:38 -0800
Message-ID: <CAKmqyKMDJuX=eqbfG2ZLjmVJySf9SGGK2bdhmV6jS_jODGUkTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v2 14/24] riscv: tcg-target: Add branch and
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

On Wed, Nov 28, 2018 at 12:15 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/27/18 1:08 PM, Alistair Francis wrote:
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
> > +
> > +static void tcg_out_call_int(TCGContext *s, tcg_insn_unit *arg, bool tail)
> > +{
> > +    TCGReg link = tail ? TCG_REG_ZERO : TCG_REG_RA;
> > +    ptrdiff_t offset = tcg_pcrel_diff(s, arg);
> > +    if (offset == sextract64(offset, 1, 20) << 1) {
>
> s/20/26/
>
> Seems like there ought to be more shared code between tcg_out_call_int and
> tcg_out_goto_long, really.

I think tcg_out_goto_long can just be removed and replaced with
tcg_out_call() right?

Alistair

>
>
> r~
