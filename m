Received: from eggs.gnu.org ([2001:4830:134:3::10]:58832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPGF3-0001Qf-7S
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 19:19:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPGE7-0003cZ-L8
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 19:18:44 -0500
MIME-Version: 1.0
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<bd8f5c781f7086c5b26e1bd4c8e6570b5534b22d.1542321076.git.alistair.francis@wdc.com>
	<f56a1b1c-8cc8-7e85-c88b-3894e4628d6b@linaro.org>
In-Reply-To: <f56a1b1c-8cc8-7e85-c88b-3894e4628d6b@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 20 Nov 2018 16:18:12 -0800
Message-ID: <CAKmqyKMJm-hcBLeP5-hWW-0Sru8ggFVWFZRCiHhZ4romx-ej4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v1 16/23] riscv: tcg-target: Add slowpath
 load and store instructions
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

On Fri, Nov 16, 2018 at 1:24 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/15/18 11:36 PM, Alistair Francis wrote:
> > +static void tcg_out_mb(TCGContext *s, TCGArg a0)
> > +{
> > +    static const RISCVInsn fence[] = {
> > +        [0 ... TCG_MO_ALL] = OPC_FENCE_RW_RW,
> > +        [TCG_MO_LD_LD]     = OPC_FENCE_R_R,
> > +        [TCG_MO_ST_LD]     = OPC_FENCE_W_R,
> > +        [TCG_MO_LD_ST]     = OPC_FENCE_R_W,
> > +        [TCG_MO_ST_ST]     = OPC_FENCE_W_W,
> > +        [TCG_BAR_LDAQ]     = OPC_FENCE_R_RW,
> > +        [TCG_BAR_STRL]     = OPC_FENCE_RW_W,
> > +        [TCG_BAR_SC]       = OPC_FENCE_RW_RW,
> > +    };
> > +    tcg_out32(s, fence[a0 & TCG_MO_ALL]);
> > +}
> > +
>
> TCG_MO_* and TCG_BAR_* are two different bitmasks, or'ed together.
> Which you've separated by "& TCG_MO_ALL".  Thus the TCG_BAR_* constants should
> not appear in this table.
>
>
> > +static void * const qemu_ld_helpers[16] = {
> > +    [MO_UB]   = helper_ret_ldub_mmu,
> > +    [MO_SB]   = helper_ret_ldsb_mmu,
> > +    [MO_LEUW] = helper_le_lduw_mmu,
> > +    [MO_LESW] = helper_le_ldsw_mmu,
> > +    [MO_LEUL] = helper_le_ldul_mmu,
> > +    [MO_LESL] = helper_le_ldsl_mmu,
> > +    [MO_LEQ]  = helper_le_ldq_mmu,
> > +    [MO_BEUW] = helper_be_lduw_mmu,
> > +    [MO_BESW] = helper_be_ldsw_mmu,
> > +    [MO_BEUL] = helper_be_ldul_mmu,
> > +    [MO_BESL] = helper_be_ldsl_mmu,
> > +    [MO_BEQ]  = helper_be_ldq_mmu,
> > +};
>
> The LESL and BESL functions will not be present for rv32 -> link error.  Here
> you do need an ifdef.
>
> > +        } else {
> > +            adj = cmp_off - sextract32(cmp_off, 0, 12);
> > +            tcg_debug_assert(add_off - adj >= -0x1000
> > +                             && add_off - adj < 0x1000);
> > +
> > +            tcg_out_opc_upper(s, OPC_LUI, base, adj);
> > +            tcg_out_opc_reg(s, OPC_ADD, base, TCG_REG_ZERO, TCG_AREG0);
>
> base, base, TCG_AREG0.
>
> > +    /* Compare masked address with the TLB entry. */
> > +    label_ptr[0] = s->code_ptr;
> > +    tcg_out_opc_branch(s, OPC_BNE, TCG_REG_TMP0, TCG_REG_TMP1, 0);
>
> Another case of a potential out-of-range branch.
>
> It might be worthwhile to move all of this out-of-line from the start, where
> that branch will always be short.  See
>
> http://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg02234.html

That does look cool, but it's not in the tree yet.

Otherwise can we directly just call tcg_out_brcond()?

PS: Thanks for your review. I have gone through most of your comments.
I now don't see any segfaults when running. My guest still doesn't
boot, but it's getting further then it used to :)

Alistair

>
>
> r~
