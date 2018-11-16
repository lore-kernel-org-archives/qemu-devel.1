Received: from eggs.gnu.org ([2001:4830:134:3::10]:38958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNfb0-0001sE-1Y
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 09:59:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNfar-0002X3-K3
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 09:59:41 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNfah-0002P9-6s
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 09:59:30 -0500
Received: by mail-oi1-x242.google.com with SMTP id r127-v6so19850683oie.3
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 06:59:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181105185046.2802-11-aaron@os.amperecomputing.com>
References: <20181105185046.2802-1-aaron@os.amperecomputing.com>
	<20181105185046.2802-11-aaron@os.amperecomputing.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Nov 2018 14:59:03 +0000
Message-ID: <CAFEAcA9ymwu8YzJoBsAP-7==MtxC=tf2YOyV1D5ORRMbVoXS+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 10/12] target/arm: PMU: Set PMCR.N to 4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <aaron@os.amperecomputing.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <alindsay@codeaurora.org>

On 5 November 2018 at 18:52, Aaron Lindsay <aaron@os.amperecomputing.com> wrote:
> This both advertises that we support four counters and enables them
> because the pmu_num_counters() reads this value from PMCR.
>
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> ---
>  target/arm/helper.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index e3ec36490c..11eb62bdda 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1753,7 +1753,7 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
>        .access = PL1_W, .type = ARM_CP_NOP },
>      /* Performance monitors are implementation defined in v7,
>       * but with an ARM recommended set of registers, which we
> -     * follow (although we don't actually implement any counters)
> +     * follow.
>       *
>       * Performance registers fall into three categories:
>       *  (a) always UNDEF in PL0, RW in PL1 (PMINTENSET, PMINTENCLR)
> @@ -5508,10 +5508,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>      }
>      if (arm_feature(env, ARM_FEATURE_V7)) {
>          /* v7 performance monitor control register: same implementor
> -         * field as main ID register, and we implement only the cycle
> -         * count register.
> +         * field as main ID register, and we implement four counters in
> +         * addition to the cycle count register.
>           */
> -        unsigned int i, pmcrn = 0;
> +        unsigned int i, pmcrn = 4;
>          ARMCPRegInfo pmcr = {
>              .name = "PMCR", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 0,
>              .access = PL0_RW,
> @@ -5526,7 +5526,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>              .access = PL0_RW, .accessfn = pmreg_access,
>              .type = ARM_CP_IO,
>              .fieldoffset = offsetof(CPUARMState, cp15.c9_pmcr),
> -            .resetvalue = cpu->midr & 0xff000000,
> +            .resetvalue = (cpu->midr & 0xff000000) | (pmcrn << PMCRN_SHIFT),
>              .writefn = pmcr_write, .raw_writefn = raw_write,
>          };
>          define_one_arm_cp_reg(cpu, &pmcr);
> --

With PMCR.N > 0, this means that MDCR_EL2.HPMN behaviour and
more generally support for the EL2 performance monitor trapping
options in MDCR_EL2 become relevant. But I think we're probably
best off leaving that for a future patchset.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
