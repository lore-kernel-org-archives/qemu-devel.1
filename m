Received: from eggs.gnu.org ([209.51.188.92]:46351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1gqjpi-0002Ef-Sg
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 14:23:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1gqjph-0007Im-NG
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 14:23:06 -0500
MIME-Version: 1.0
References: <20181211151945.29137-1-aaron@os.amperecomputing.com>
	<20181211151945.29137-11-aaron@os.amperecomputing.com>
In-Reply-To: <20181211151945.29137-11-aaron@os.amperecomputing.com>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Mon, 4 Feb 2019 20:22:41 +0100
Message-ID: <CABoDooPMwWR3TXxAqzoByeyuaReVmV0NFpWCJr897QL6r7n_nw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v10 10/14] target/arm: Finish
 implementation of PM[X]EVCNTR and PM[X]EVTYPER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <aaron@os.amperecomputing.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Richard Henderson <richard.henderson@linaro.org>, Aaron Lindsay <alindsay@codeaurora.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hello,

On Tue, Dec 11, 2018 at 4:25 PM Aaron Lindsay
<aaron@os.amperecomputing.com> wrote:
>
> Add arrays to hold the registers, the definitions themselves, access
> functions, and logic to reset counters when PMCR.P is set. Update
> filtering code to support counters other than PMCCNTR. Support migration
> with raw read/write functions.
>
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h    |   3 +
>  target/arm/helper.c | 296 +++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 282 insertions(+), 17 deletions(-)
[...]
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index fd2923f033..1b851d1689 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
[...]
> @@ -5301,6 +5526,43 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>          };
>          define_one_arm_cp_reg(cpu, &pmcr);
>          define_one_arm_cp_reg(cpu, &pmcr64);
> +        for (i = 0; i < pmcrn; i++) {
> +            char *pmevcntr_name = g_strdup_printf("PMEVCNTR%d", i);
> +            char *pmevcntr_el0_name = g_strdup_printf("PMEVCNTR%d_EL0", i);
> +            char *pmevtyper_name = g_strdup_printf("PMEVTYPER%d", i);
> +            char *pmevtyper_el0_name = g_strdup_printf("PMEVTYPER%d_EL0", i);
> +            ARMCPRegInfo pmev_regs[] = {
> +                { .name = pmevcntr_name, .cp = 15, .crn = 15,
> +                  .crm = 8 | (3 & (i >> 3)), .opc1 = 0, .opc2 = i & 7,
> +                  .access = PL0_RW, .type = ARM_CP_IO | ARM_CP_ALIAS,
> +                  .readfn = pmevcntr_readfn, .writefn = pmevcntr_writefn,
> +                  .accessfn = pmreg_access },
> +                { .name = pmevcntr_el0_name, .state = ARM_CP_STATE_AA64,
> +                  .opc0 = 3, .opc1 = 3, .crn = 15, .crm = 8 | (3 & (i >> 3)),
> +                  .opc2 = i & 7, .access = PL0_RW, .accessfn = pmreg_access,
> +                  .type = ARM_CP_IO,
> +                  .readfn = pmevcntr_readfn, .writefn = pmevcntr_writefn,
> +                  .raw_readfn = pmevcntr_rawread,
> +                  .raw_writefn = pmevcntr_rawwrite },
> +                { .name = pmevtyper_name, .cp = 15, .crn = 15,
> +                  .crm = 12 | (3 & (i >> 3)), .opc1 = 0, .opc2 = i & 7,
> +                  .access = PL0_RW, .type = ARM_CP_IO | ARM_CP_ALIAS,
> +                  .readfn = pmevtyper_readfn, .writefn = pmevtyper_writefn,
> +                  .accessfn = pmreg_access },
> +                { .name = pmevtyper_el0_name, .state = ARM_CP_STATE_AA64,
> +                  .opc0 = 3, .opc1 = 3, .crn = 15, .crm = 12 | (3 & (i >> 3)),

Looking at ARM documentation, I think the value for crn should be 14
for PMEVCNTR<n>_EL0 and PMEVTYPER<n>_EL0.

Thanks,

Laurent

> +                  .opc2 = i & 7, .access = PL0_RW, .accessfn = pmreg_access,
> +                  .type = ARM_CP_IO,
> +                  .readfn = pmevtyper_readfn, .writefn = pmevtyper_writefn,
> +                  .raw_writefn = pmevtyper_rawwrite },
> +                REGINFO_SENTINEL
> +            };
> +            define_arm_cp_regs(cpu, pmev_regs);
> +            g_free(pmevcntr_name);
> +            g_free(pmevcntr_el0_name);
> +            g_free(pmevtyper_name);
> +            g_free(pmevtyper_el0_name);
> +        }
>  #endif
>          ARMCPRegInfo clidr = {
>              .name = "CLIDR", .state = ARM_CP_STATE_BOTH,
> --
> 2.19.2
>
>
