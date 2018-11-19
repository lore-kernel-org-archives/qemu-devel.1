Received: from eggs.gnu.org ([2001:4830:134:3::10]:59829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gOsdA-0003mD-1W
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 18:07:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gOsd9-0007i2-5U
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 18:07:00 -0500
MIME-Version: 1.0
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<ccb312eb986d846b1b0aa0be062833e5ae1bb5f4.1542321076.git.alistair.francis@wdc.com>
	<687076b9-a5ca-2821-3e24-8b08363f1b5c@linaro.org>
In-Reply-To: <687076b9-a5ca-2821-3e24-8b08363f1b5c@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 19 Nov 2018 15:06:31 -0800
Message-ID: <CAKmqyKPsnX+RR1A6BTdXZ4-WFix5o9OKpXLyffe8Y_erZ=kYDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v1 17/23] riscv: tcg-target: Add direct load
 and store instructions
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

On Fri, Nov 16, 2018 at 9:10 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/15/18 11:36 PM, Alistair Francis wrote:
> > +    tcg_out_opc_reg(s, OPC_ADD, base, TCG_GUEST_BASE_REG, addr_regl);
>
> Should avoid this when guest_base == 0, which happens fairly regularly for a
> 64-bit guest.
>
> > +        /* Prefer to load from offset 0 first, but allow for overlap.  */
> > +        if (TCG_TARGET_REG_BITS == 64) {
> > +            tcg_out_opc_imm(s, OPC_LD, lo, base, 0);
> > +        } else {
> > +            tcg_out_opc_imm(s, OPC_LW, lo, base, 0);
> > +            tcg_out_opc_imm(s, OPC_LW, hi, base, 4);
> > +        }
>
> Comment sounds like two lines of code that's missing.

I can't figure out what this comment should be for. Why would we want
to prefer loading with an offset 0?

Alistair

>
> > +    const TCGMemOp bswap = opc & MO_BSWAP;
> > +
> > +    /* TODO: Handle byte swapping */
>
> Should assert rather than emit bad code.
>
> I do still plan to change tcg to allow backends to *not* handle byte swapping
> if they don't want.  This will make the i386 and arm32 backends less icky.
>
>
> r~
