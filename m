Received: from eggs.gnu.org ([2001:4830:134:3::10]:55561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vijay.kilari@gmail.com>) id 1cfhLm-0000MQ-6P
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 01:21:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vijay.kilari@gmail.com>) id 1cfhLl-0003CE-2P
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 01:21:30 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8618+LGejFq6SpBEwGrNpfamBBX3MFWjss-ZxJ7Xk8mg@mail.gmail.com>
References: <1487313115-9510-1-git-send-email-vijay.kilari@gmail.com>
	<1487313115-9510-3-git-send-email-vijay.kilari@gmail.com>
	<CAFEAcA8618+LGejFq6SpBEwGrNpfamBBX3MFWjss-ZxJ7Xk8mg@mail.gmail.com>
From: Vijay Kilari <vijay.kilari@gmail.com>
Date: Mon, 20 Feb 2017 11:51:24 +0530
Message-ID: <CALicx6tqxXZxBTxYvF55ydBg5CB1to3MsEkhaohucx4EAZcEJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Christoffer Dall <christoffer.dall@linaro.org>, Eric Auger <eric.auger@redhat.com>, Pavel Fedin <p.fedin@samsung.com>, Marc Zyngier <marc.zyngier@arm.com>, QEMU Developers <qemu-devel@nongnu.org>, Vijaya Kumar K <Vijaya.Kumar@cavium.com>

Hi Peter,

On Fri, Feb 17, 2017 at 7:25 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 17 February 2017 at 06:31,  <vijay.kilari@gmail.com> wrote:
>> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
>>
>> To Save and Restore ICC_SRE_EL1 register introduce vmstate
>> subsection and load only if non-zero.
>> Also initialize icc_sre_el1 with to 0x7 in pre_load
>> function.
>>
>> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
>> ---
>>  hw/intc/arm_gicv3_common.c         | 32 ++++++++++++++++++++++++++++++++
>>  include/hw/intc/arm_gicv3_common.h |  1 +
>>  2 files changed, 33 insertions(+)
>>
>> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
>> index 16b9b0f..e62480e 100644
>> --- a/hw/intc/arm_gicv3_common.c
>> +++ b/hw/intc/arm_gicv3_common.c
>> @@ -70,6 +70,34 @@ static const VMStateDescription vmstate_gicv3_cpu_virt = {
>>      }
>>  };
>>
>> +static int icc_sre_el1_reg_pre_load(void *opaque)
>> +{
>> +    GICv3CPUState *cs = opaque;
>> +
>> +    /* By default enable SRE and disable IRQ & FIQ bypass. */
>> +    cs->icc_sre_el1 = 0x7;
>
> Why do we need the pre_load function? I would have
> expected that reset would have given us these defaults
> already.
>
>> +    return 0;
>> +}
>> +
>> +static bool icc_sre_el1_reg_needed(void *opaque)
>> +{
>> +    GICv3CPUState *cs = opaque;
>> +
>> +    return cs->icc_sre_el1 != 0;
>
> I expected this to say "we need to transfer the value if
> it isn't 0x7" (since the current situation of migration
> is "we assume that the value is 0x7").
>
> Something should probably fail inbound migration for TCG
> if the value isn't 0x7, for that matter.
>
> Is there a situation where KVM might allow a value other
> than 0x7?

In KVM, the SRE_EL1 value is 0x1. During save, value
read from KVM is 0x1 though we reset to 0x7.

>
>> +}
>> +
>> +const VMStateDescription vmstate_gicv3_cpu_sre_el1 = {
>> +    .name = "arm_gicv3_cpu/sre_el1",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .pre_load = icc_sre_el1_reg_pre_load,
>> +    .needed = icc_sre_el1_reg_needed,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_UINT64(icc_sre_el1, GICv3CPUState),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>  static const VMStateDescription vmstate_gicv3_cpu = {
>>      .name = "arm_gicv3_cpu",
>>      .version_id = 1,
>> @@ -100,6 +128,10 @@ static const VMStateDescription vmstate_gicv3_cpu = {
>>      .subsections = (const VMStateDescription * []) {
>>          &vmstate_gicv3_cpu_virt,
>>          NULL
>> +    },
>> +    .subsections = (const VMStateDescription * []) {
>> +        &vmstate_gicv3_cpu_sre_el1,
>> +        NULL
>>      }
>>  };
>>
>> diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
>> index 4156051..bccdfe1 100644
>> --- a/include/hw/intc/arm_gicv3_common.h
>> +++ b/include/hw/intc/arm_gicv3_common.h
>> @@ -172,6 +172,7 @@ struct GICv3CPUState {
>>      uint8_t gicr_ipriorityr[GIC_INTERNAL];
>>
>>      /* CPU interface */
>> +    uint64_t icc_sre_el1;
>>      uint64_t icc_ctlr_el1[2];
>>      uint64_t icc_pmr_el1;
>>      uint64_t icc_bpr[3];
>> --
>> 1.9.1
>
> thanks
> -- PMM
