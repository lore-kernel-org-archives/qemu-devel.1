Received: from eggs.gnu.org ([2001:4830:134:3::10]:43069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSlMu-0002SB-5R
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:10:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSlMt-0005Gx-B3
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:10:16 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gSlMt-0005DO-2K
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:10:15 -0500
Received: by mail-ot1-x342.google.com with SMTP id t5so5586749otk.1
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 08:10:14 -0800 (PST)
MIME-Version: 1.0
References: <20181120212553.8480-1-aaron@os.amperecomputing.com>
	<20181120212553.8480-8-aaron@os.amperecomputing.com>
In-Reply-To: <20181120212553.8480-8-aaron@os.amperecomputing.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 16:10:03 +0000
Message-ID: <CAFEAcA92+6NdqpB+L42cu1Ba7qvvHoLkjSDgcEDLvR=iqpd4gg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 07/13] target-arm: Make PMCEID[01]_EL0
 64 bit registers, add PMCEID[23]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <aaron@os.amperecomputing.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On Tue, 20 Nov 2018 at 21:26, Aaron Lindsay
<aaron@os.amperecomputing.com> wrote:
>
> Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> ---
>  target/arm/cpu.h    |  4 ++--
>  target/arm/helper.c | 12 ++++++++++--
>  2 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 627e5c1995..50de58e4a2 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -837,8 +837,8 @@ struct ARMCPU {
>      uint32_t id_pfr0;
>      uint32_t id_pfr1;
>      uint32_t id_dfr0;
> -    uint32_t pmceid0;
> -    uint32_t pmceid1;
> +    uint64_t pmceid0;
> +    uint64_t pmceid1;
>      uint32_t id_afr0;
>      uint32_t id_mmfr0;
>      uint32_t id_mmfr1;
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 71be6fb578..75f054fe79 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5432,7 +5432,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>              { .name = "PMCEID0", .state = ARM_CP_STATE_AA32,
>                .cp = 15, .opc1 = 0, .crn = 9, .crm = 12, .opc2 = 6,
>                .access = PL0_R, .accessfn = pmreg_access, .type = ARM_CP_CONST,
> -              .resetvalue = cpu->pmceid0 },
> +              .resetvalue = extract64(cpu->pmceid0, 0, 32) },
> +            { .name = "PMCEID2", .state = ARM_CP_STATE_AA32,
> +              .cp = 15, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 4,
> +              .access = PL0_R, .accessfn = pmreg_access, .type = ARM_CP_CONST,
> +              .resetvalue = extract64(cpu->pmceid0, 32, 32) },
>              { .name = "PMCEID0_EL0", .state = ARM_CP_STATE_AA64,
>                .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 12, .opc2 = 6,
>                .access = PL0_R, .accessfn = pmreg_access, .type = ARM_CP_CONST,
> @@ -5440,7 +5444,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>              { .name = "PMCEID1", .state = ARM_CP_STATE_AA32,
>                .cp = 15, .opc1 = 0, .crn = 9, .crm = 12, .opc2 = 7,
>                .access = PL0_R, .accessfn = pmreg_access, .type = ARM_CP_CONST,
> -              .resetvalue = cpu->pmceid1 },
> +              .resetvalue = extract64(cpu->pmceid1, 0, 32) },
> +            { .name = "PMCEID3", .state = ARM_CP_STATE_AA32,
> +              .cp = 15, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 5,
> +              .access = PL0_R, .accessfn = pmreg_access, .type = ARM_CP_CONST,
> +              .resetvalue = extract64(cpu->pmceid1, 32, 32) },
>              { .name = "PMCEID1_EL0", .state = ARM_CP_STATE_AA64,
>                .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 12, .opc2 = 7,
>                .access = PL0_R, .accessfn = pmreg_access, .type = ARM_CP_CONST,
> --

PMCEID2 and PMCEID3 are only defined from ARMv8.1; before that they
are UNDEFINED. So these registers need to be only defined if a
suitable feature bit or ID register field check passes.

thanks
-- PMM
