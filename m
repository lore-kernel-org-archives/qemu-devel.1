Received: from eggs.gnu.org ([2001:4830:134:3::10]:42239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d6bzA-0001IJ-SI
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:05:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d6bz9-0000FC-Ot
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:05:24 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1434721636-25357-1-git-send-email-peter.maydell@linaro.org>
	<1434721636-25357-8-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <57d182c1-291b-458a-d03c-f920ad8f0f14@amsat.org>
Date: Fri, 5 May 2017 09:05:14 -0300
MIME-Version: 1.0
In-Reply-To: <1434721636-25357-8-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 07/12] target-arm: Add support for Cortex-R5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>

Hi Peter,

On 06/16/2015 09:36 PM, Peter Crosthwaite wrote:
> Introduce a CPU model for the Cortex R5 processor. ARMv7 with MPU,
> and both thumb and ARM div instructions.
>
> Also implement dummy ATCM and BTCM. These CPs are defined for R5 but
> don't have a lot of meaning in QEMU yet. Raz them so the guest can
> proceed if they are read. The TCM registers will return a size of 0,
> indicating no TCM.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Message-id: efe213163e6800578494aba864ac30329de4d396.1434501320.git.peter.crosthwaite@xilinx.com
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target-arm/cpu.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/target-arm/cpu.c b/target-arm/cpu.c
> index eb10f59..b3d07ac 100644
> --- a/target-arm/cpu.c
> +++ b/target-arm/cpu.c
> @@ -856,6 +856,43 @@ static void arm_v7m_class_init(ObjectClass *oc, void *data)
>      cc->cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt;
>  }
>
> +static const ARMCPRegInfo cortexr5_cp_reginfo[] = {
> +    /* Dummy the TCM region regs for the moment */
> +    { .name = "ATCM", .cp = 15, .opc1 = 0, .crn = 9, .crm = 1, .opc2 = 0,
> +      .access = PL1_RW, .type = ARM_CP_CONST },
> +    { .name = "BTCM", .cp = 15, .opc1 = 0, .crn = 9, .crm = 1, .opc2 = 1,
> +      .access = PL1_RW, .type = ARM_CP_CONST },
> +    REGINFO_SENTINEL
> +};
> +
> +static void cortex_r5_initfn(Object *obj)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    set_feature(&cpu->env, ARM_FEATURE_V7);
> +    set_feature(&cpu->env, ARM_FEATURE_THUMB_DIV);
> +    set_feature(&cpu->env, ARM_FEATURE_ARM_DIV);
> +    set_feature(&cpu->env, ARM_FEATURE_V7MP);
> +    set_feature(&cpu->env, ARM_FEATURE_MPU);
> +    cpu->midr = 0x411fc153; /* r1p3 */

I'm unable to find the revision r1p3 of the Cortex-R5 Technical 
Reference Manual. Checking on developer.arm.com the last public revision 
is r1p2. Any clue?

Regards,

Phil.

> +    cpu->id_pfr0 = 0x0131;
> +    cpu->id_pfr1 = 0x001;
> +    cpu->id_dfr0 = 0x010400;
> +    cpu->id_afr0 = 0x0;
> +    cpu->id_mmfr0 = 0x0210030;
> +    cpu->id_mmfr1 = 0x00000000;
> +    cpu->id_mmfr2 = 0x01200000;
> +    cpu->id_mmfr3 = 0x0211;
> +    cpu->id_isar0 = 0x2101111;
> +    cpu->id_isar1 = 0x13112111;
> +    cpu->id_isar2 = 0x21232141;
> +    cpu->id_isar3 = 0x01112131;
> +    cpu->id_isar4 = 0x0010142;
> +    cpu->id_isar5 = 0x0;
> +    cpu->mp_is_up = true;
> +    define_arm_cp_regs(cpu, cortexr5_cp_reginfo);
> +}
> +
>  static const ARMCPRegInfo cortexa8_cp_reginfo[] = {
>      { .name = "L2LOCKDOWN", .cp = 15, .crn = 9, .crm = 0, .opc1 = 1, .opc2 = 0,
>        .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
> @@ -1249,6 +1286,7 @@ static const ARMCPUInfo arm_cpus[] = {
>                               .class_init = arm_v7m_class_init },
>      { .name = "cortex-m4",   .initfn = cortex_m4_initfn,
>                               .class_init = arm_v7m_class_init },
> +    { .name = "cortex-r5",   .initfn = cortex_r5_initfn },
>      { .name = "cortex-a8",   .initfn = cortex_a8_initfn },
>      { .name = "cortex-a9",   .initfn = cortex_a9_initfn },
>      { .name = "cortex-a15",  .initfn = cortex_a15_initfn },
>
