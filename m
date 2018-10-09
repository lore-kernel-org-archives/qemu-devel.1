Received: from eggs.gnu.org ([2001:4830:134:3::10]:58281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1g9sG4-0001LD-Eh
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1g9sFW-0003um-LW
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:41:08 -0400
MIME-Version: 1.0
References: <1538579266-8389-1-git-send-email-edgar.iglesias@gmail.com>
	<1538579266-8389-11-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA9b4O4HrMwNTgbZ7JYdO=S3dnzC8ayabBEpKY5=DyBMog@mail.gmail.com>
	<20181008213407.GF4229@toto>
	<CAFEAcA__7wJ-4mNe3rKe4T+gDUbdBH+rB-DHE+fddmjVzG2=Eg@mail.gmail.com>
	<20181009131736.GT4229@toto>
In-Reply-To: <20181009131736.GT4229@toto>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Tue, 9 Oct 2018 15:40:13 +0200
Message-ID: <CABoDooObRovXo+Bw9tJWHy61vhTkysJx1D7016qhYgs1=O7ztA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 10/12] target/arm: Add the Cortex-A72
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: edgar.iglesias@xilinx.com
Cc: Peter Maydell <peter.maydell@linaro.org>, figlesia@xilinx.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, frasse.iglesias@gmail.com, alistair@alistair23.me, Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, frederic.konrad@adacore.com, qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

Hello,

On Tue, Oct 9, 2018 at 3:19 PM Edgar E. Iglesias
<edgar.iglesias@xilinx.com> wrote:
>
> Another A72 related thing I wanted to check with you. A month or two ago I was
> looking at an issue with Linux running very slowly on our models.
> Something that popped up was that Linux was running a couple of spectre related
> "workarounds" and "hardening" sequences on the QEMU A72s.
>
> There are a couple of bits in the ID_AARCH64_PFR0 register that
> Linux checks before enabling the sequences but I never found any
> documentation of them in the specs. Bits 56 and 60.
>
> In Linux these are refered to as:
> ID_AA64PFR0_CSV2_SHIFT
> ID_AA64PFR0_CSV3_SHIFT
>
> This is what we have in our tree:
>
>     cpu->gic_vprebits = 5;
>     define_arm_cp_regs(cpu, cortex_a57_a53_cp_reginfo);
>
>     /* Xilinx FIXUPs.  */
>     /* These indicate the BP hardening and KPTI aren't needed.  */
>     cpu->id_aa64pfr0 |= (uint64_t)1 << 56; /* BP.  */
>     cpu->id_aa64pfr0 |= (uint64_t)1 << 60; /* KPTI.  */
> }
>
> Do you know what these are?
> Should we be setting these in QEMU?

These fields are publicly documented in the system register specification:

https://developer.arm.com/products/architecture/cpu-architecture/a-profile/exploration-tools

These are ARMv8.5 fields, I don't think these should be set by default
for Cortex-A72. Of course nothing prevents you from defining a
specific CPU with these fields set to boot faster :-)  Or perhaps add
a property to override the default value of these registers?


Laurent
