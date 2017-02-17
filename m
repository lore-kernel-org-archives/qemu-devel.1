Received: from eggs.gnu.org ([2001:4830:134:3::10]:48915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ceeER-0005lp-Fv
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:49:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ceeEQ-0006uE-Bf
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:49:35 -0500
References: <1487313115-9510-1-git-send-email-vijay.kilari@gmail.com>
	<1487313115-9510-3-git-send-email-vijay.kilari@gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <1373f592-b2f3-e686-7517-51c51e7bb898@redhat.com>
Date: Fri, 17 Feb 2017 09:49:22 +0100
MIME-Version: 1.0
In-Reply-To: <1487313115-9510-3-git-send-email-vijay.kilari@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 2/5] hw/intc/arm_gicv3_kvm: Add
 ICC_SRE_EL1 register to vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: vijay.kilari@gmail.com, qemu-arm@nongnu.org, peter.maydell@linaro.org, christoffer.dall@linaro.org
Cc: p.fedin@samsung.com, marc.zyngier@arm.com, qemu-devel@nongnu.org, Vijaya Kumar K <Vijaya.Kumar@cavium.com>

Hi,

On 17/02/2017 07:31, vijay.kilari@gmail.com wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
> 
> To Save and Restore ICC_SRE_EL1 register introduce vmstate
> subsection and load only if non-zero.
> Also initialize icc_sre_el1 with to 0x7 in pre_load
> function.
> 
> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
> ---
>  hw/intc/arm_gicv3_common.c         | 32 ++++++++++++++++++++++++++++++++
>  include/hw/intc/arm_gicv3_common.h |  1 +
>  2 files changed, 33 insertions(+)
> 
> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
> index 16b9b0f..e62480e 100644
> --- a/hw/intc/arm_gicv3_common.c
> +++ b/hw/intc/arm_gicv3_common.c
> @@ -70,6 +70,34 @@ static const VMStateDescription vmstate_gicv3_cpu_virt = {
>      }
>  };
>  
> +static int icc_sre_el1_reg_pre_load(void *opaque)
> +{
> +    GICv3CPUState *cs = opaque;
> +
> +    /* By default enable SRE and disable IRQ & FIQ bypass. */
> +    cs->icc_sre_el1 = 0x7;
> +    return 0;
> +}
> +
> +static bool icc_sre_el1_reg_needed(void *opaque)
> +{
> +    GICv3CPUState *cs = opaque;
> +
> +    return cs->icc_sre_el1 != 0;
Don't you tell that the reset value is always != 0. In that case the
subsection will be always sent, right?

If we don't want to send it for TCG, shouldn't we compare against 0xf
(TCG reset value you mentioned in a previous email)

Thanks

Eric
> +}
> +
> +const VMStateDescription vmstate_gicv3_cpu_sre_el1 = {
> +    .name = "arm_gicv3_cpu/sre_el1",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .pre_load = icc_sre_el1_reg_pre_load,
> +    .needed = icc_sre_el1_reg_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT64(icc_sre_el1, GICv3CPUState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_gicv3_cpu = {
>      .name = "arm_gicv3_cpu",
>      .version_id = 1,
> @@ -100,6 +128,10 @@ static const VMStateDescription vmstate_gicv3_cpu = {
>      .subsections = (const VMStateDescription * []) {
>          &vmstate_gicv3_cpu_virt,
>          NULL
> +    },
> +    .subsections = (const VMStateDescription * []) {
> +        &vmstate_gicv3_cpu_sre_el1,
> +        NULL
>      }
>  };
>  
> diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
> index 4156051..bccdfe1 100644
> --- a/include/hw/intc/arm_gicv3_common.h
> +++ b/include/hw/intc/arm_gicv3_common.h
> @@ -172,6 +172,7 @@ struct GICv3CPUState {
>      uint8_t gicr_ipriorityr[GIC_INTERNAL];
>  
>      /* CPU interface */
> +    uint64_t icc_sre_el1;
>      uint64_t icc_ctlr_el1[2];
>      uint64_t icc_pmr_el1;
>      uint64_t icc_bpr[3];
> 
