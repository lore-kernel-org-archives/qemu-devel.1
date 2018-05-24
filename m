Received: from eggs.gnu.org ([2001:4830:134:3::10]:51750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1fLmRg-0000n0-7s
	for qemu-devel@nongnu.org; Thu, 24 May 2018 05:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1fLmRb-0006Fq-1N
	for qemu-devel@nongnu.org; Thu, 24 May 2018 05:22:04 -0400
Message-ID: <5B0683FB.4000602@huawei.com>
Date: Thu, 24 May 2018 17:20:59 +0800
From: Shannon Zhao <zhaoshenglong@huawei.com>
MIME-Version: 1.0
References: <1527047633-12368-1-git-send-email-zhaoshenglong@huawei.com>
	<1527047633-12368-2-git-send-email-zhaoshenglong@huawei.com>
	<acca5b80-f527-bc39-0b63-147e53affb4b@redhat.com>
In-Reply-To: <acca5b80-f527-bc39-0b63-147e53affb4b@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V3 2/2] arm_gicv3_kvm: kvm_dist_get/put:
 skip the registers banked by GICR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, shannon.zhaosl@gmail.com



On 2018/5/24 17:04, Auger Eric wrote:
> Hi Shannon,
> 
> On 05/23/2018 05:53 AM, Shannon Zhao wrote:
>> While we skip the GIC_INTERNAL irqs, we don't change the register offset
>> accordingly. This will overlap the GICR registers value and leave the
>> last GIC_INTERNAL irq's registers out of update.
>>
>> Fix this by skipping the registers banked by GICR.
>>
>> Also for migration compatibility if the migration source (old version
>> qemu) doesn't send gicd_no_shift_bug = 1 to destination, then we shift
>> the data of PPI to get the right data for SPI.
>>
>> Fixes: 367b9f527becdd20ddf116e17a3c0c2bbc486920
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
>> ---
>> Changes in V3: add migration compatibility and fix code style
>> ---
>>  hw/intc/arm_gicv3_common.c         | 36 ++++++++++++++++++++++++
>>  hw/intc/arm_gicv3_kvm.c            | 56 +++++++++++++++++++++++++++++++++++++-
>>  include/hw/intc/arm_gicv3_common.h |  1 +
>>  3 files changed, 92 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
>> index 7b54d52..f93e5d2 100644
>> --- a/hw/intc/arm_gicv3_common.c
>> +++ b/hw/intc/arm_gicv3_common.c
>> @@ -141,6 +141,38 @@ static const VMStateDescription vmstate_gicv3_cpu = {
>>      }
>>  };
>>  
>> +static int gicv3_gicd_no_shift_bug_pre_load(void *opaque)
>> +{
>> +    GICv3State *cs = opaque;
>> +
>> +   /*
>> +    * If the gicd_no_shift_bug subsection is not transferred this
>> +    * means gicd_no_shift_bug is 0x0 (which might not be the same as
>> +    * our reset value).
>> +    */
>> +    cs->gicd_no_shift_bug = 0x0;
>> +    return 0;
>> +}
>> +
>> +static bool gicv3_gicd_no_shift_bug_needed(void *opaque)
>> +{
>> +    GICv3State *cs = opaque;
>> +
>> +    return cs->gicd_no_shift_bug;
>> +}
>> +
>> +const VMStateDescription vmstate_gicv3_gicd_no_shift_bug = {
>> +    .name = "arm_gicv3/gicd_no_shift_bug",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .pre_load = gicv3_gicd_no_shift_bug_pre_load,
>> +    .needed = gicv3_gicd_no_shift_bug_needed,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_BOOL(gicd_no_shift_bug, GICv3State),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>  static const VMStateDescription vmstate_gicv3 = {
>>      .name = "arm_gicv3",
>>      .version_id = 1,
>> @@ -165,6 +197,10 @@ static const VMStateDescription vmstate_gicv3 = {
>>          VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, GICv3State, num_cpu,
>>                                               vmstate_gicv3_cpu, GICv3CPUState),
>>          VMSTATE_END_OF_LIST()
>> +    },
>> +    .subsections = (const VMStateDescription * []) {
>> +        &vmstate_gicv3_gicd_no_shift_bug,
>> +        NULL
>>      }
>>  };
>>  
>> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
>> index 3536795..bd961f1 100644
>> --- a/hw/intc/arm_gicv3_kvm.c
>> +++ b/hw/intc/arm_gicv3_kvm.c
>> @@ -136,6 +136,12 @@ static void kvm_dist_get_priority(GICv3State *s, uint32_t offset, uint8_t *bmp)
>>      int irq;
>>  
>>      field = (uint32_t *)bmp;
>> +    /* For the KVM GICv3, affinity routing is always enabled, and the first 8
>> +     * GICD_IPRIORITYR<n> registers are always RAZ/WI. The corresponding
>> +     * functionality is replaced by GICR_IPRIORITYR<n>. So it doesn't need to
>> +     * sync them.
>> +     */
>> +    offset += (8 * sizeof(uint32_t));
> Now I am unclear about the semantics of the s->gicd_ipriority & friends.
> With that change, is it supposed to contain only the states of SPIs or
> contain the RAZ states of PPI/SGIs + states of SPIs. The array is
> dimensionned to contain states for PPI/SGI+SPIs, right? In other words,
> shouldn't we also shift field?
> 
Yes, it should also shift the field. But not sure if this will affect
the new to old migration scenario. Let me think about this.

> Thanks
> 
> Eric
>>      for_each_dist_irq_reg(irq, s->num_irq, 8) {
>>          kvm_gicd_access(s, offset, &reg, false);
>>          *field = reg;
>> @@ -149,7 +155,18 @@ static void kvm_dist_put_priority(GICv3State *s, uint32_t offset, uint8_t *bmp)
>>      uint32_t reg, *field;
>>      int irq;
>>  
>> -    field = (uint32_t *)bmp;
>> +    if (!s->gicd_no_shift_bug) {
>> +        field = (uint32_t *)(bmp + 8 * sizeof(uint32_t));
>> +    } else {
>> +        field = (uint32_t *)bmp;
>> +    }
>> +
>> +    /* For the KVM GICv3, affinity routing is always enabled, and the first 8
>> +     * GICD_IPRIORITYR<n> registers are always RAZ/WI. The corresponding
>> +     * functionality is replaced by GICR_IPRIORITYR<n>. So it doesn't need to
>> +     * sync them.
>> +     */
>> +    offset += (8 * sizeof(uint32_t));
> in the old to new migration scenario, IIUC,
> bmp contains state of 32 internal PPI/SGI(RAZ) + s->num_irq-32 SPIs
> Here aren't you "putting" the RAZ state of the 32 PPI/SGIs into the
> first 32 SPIs here?
> 
Please see above code, this new version patch I add a flag for migration
compat suggested as Peter. If it migrates from old qemu, the
gicd_no_shift_bug will be 0, then it will shift the bmp, while that will
drop the data of PPI/SGI and also the last 32 SPIs info will be empty.
None of current machines use last 32 SPIs, so it's fine for the moment.

Thanks,
-- 
Shannon
