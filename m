Received: from eggs.gnu.org ([2001:4830:134:3::10]:51037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1g9rtr-0001O1-CI
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1g9rtn-0004Hm-C3
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:18:11 -0400
Date: Tue, 9 Oct 2018 15:17:36 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20181009131736.GT4229@toto>
References: <1538579266-8389-1-git-send-email-edgar.iglesias@gmail.com>
	<1538579266-8389-11-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA9b4O4HrMwNTgbZ7JYdO=S3dnzC8ayabBEpKY5=DyBMog@mail.gmail.com>
	<20181008213407.GF4229@toto>
	<CAFEAcA__7wJ-4mNe3rKe4T+gDUbdBH+rB-DHE+fddmjVzG2=Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFEAcA__7wJ-4mNe3rKe4T+gDUbdBH+rB-DHE+fddmjVzG2=Eg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v1 10/12] target/arm: Add the Cortex-A72
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>, Alistair Francis <alistair@alistair23.me>, Francisco Iglesias <frasse.iglesias@gmail.com>, figlesia@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

On Tue, Oct 09, 2018 at 10:30:01AM +0100, Peter Maydell wrote:
> On 8 October 2018 at 22:34, Edgar E. Iglesias <edgar.iglesias@xilinx.com> wrote:
> > On Mon, Oct 08, 2018 at 02:10:29PM +0100, Peter Maydell wrote:
> >> On 3 October 2018 at 16:07, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> >> > From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> >> >
> >> > Add the ARM Cortex-A72.
> >> >
> >> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> 
> >> > +    cpu->midr = 0x410fd083;
> >> > +    cpu->revidr = 0x00000000;
> >> > +    cpu->reset_fpsid = 0x41034080;
> >> > +    cpu->mvfr0 = 0x10110222;
> >> > +    cpu->mvfr1 = 0x12111111;
> >> > +    cpu->mvfr2 = 0x00000043;
> >> > +    cpu->ctr = 0x8444c004;
> >> > +    cpu->reset_sctlr = 0x00c50838;
> >>
> >> Do you happen to have the hardware to hand to check what the
> >> top 4 bits of the reset value of SCTLR_ELx are? I think they
> >> should be 0x3 -- the Arm ARM says that [29:28] are RES1 (as
> >> does the A72 TRM, though its top level summary table lists
> >> 0x00c50838 as the reset value for some of the SCTLR_ELx.)
> >>
> >> QEMU may have the wrong value for A53/A57 here too, I suspect.
> >
> > I don't have access to the A72s at the moment but looking at logs
> > it seems to be 0x00c50838 for both the A53 and A72.
> > Looking at "Table 4-118 SCTLR bit assignments" in the A72 TRM,
> > bits [30:28] seem to have been allocated. Bit 30 depends on
> > configuration inputs to the core and [29:28] seem to be hard-coded
> > to zero.
> 
> Ah, this is a 32-bit view vs 64-bit view thing. In 32-bit,
> SCTLR[28] is TRE (TEX remap enable), and SCTLR[29] is AFE
> (access flag enable), and both are resets-to-zero.
> HSCTLR[28] and [29] are both reserved, RES1.
> In 64-bit, SCTLR_EL1[29:28] are RES1 in ARMv8.1 and v8.0, and
> have new meanings assigned in v8.2 and v8.3.
> SCTLR_EL2[29:28] and SCTLR_EL3[29:28] are reserved, RES1.
> 
> For QEMU at the moment we don't deal with this, and so we
> have only the one reset value, cpu->reset_sctlr, which we use
> for both the SCTLR_EL1 and SCTLR_EL3 resets. Our HSCTLR/SCTLR_EL2
> resets to zero, and we don't allow for the 64-bit and 32-bit views
> not necessarily being the same value.

Aha, I see. I'll leave as is then and we can fix the 64 bit stuff later I guess.

Another A72 related thing I wanted to check with you. A month or two ago I was
looking at an issue with Linux running very slowly on our models.
Something that popped up was that Linux was running a couple of spectre related
"workarounds" and "hardening" sequences on the QEMU A72s.

There are a couple of bits in the ID_AARCH64_PFR0 register that
Linux checks before enabling the sequences but I never found any
documentation of them in the specs. Bits 56 and 60.

In Linux these are refered to as:
ID_AA64PFR0_CSV2_SHIFT
ID_AA64PFR0_CSV3_SHIFT

This is what we have in our tree:

    cpu->gic_vprebits = 5;
    define_arm_cp_regs(cpu, cortex_a57_a53_cp_reginfo);

    /* Xilinx FIXUPs.  */
    /* These indicate the BP hardening and KPTI aren't needed.  */
    cpu->id_aa64pfr0 |= (uint64_t)1 << 56; /* BP.  */
    cpu->id_aa64pfr0 |= (uint64_t)1 << 60; /* KPTI.  */
}

Do you know what these are?
Should we be setting these in QEMU?

Cheers,
Edgar
