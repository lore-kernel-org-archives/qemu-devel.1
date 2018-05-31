Received: from eggs.gnu.org ([2001:4830:134:3::10]:38017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1fOIaj-0000WU-Bj
	for qemu-devel@nongnu.org; Thu, 31 May 2018 04:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1fOIai-0002Hx-Au
	for qemu-devel@nongnu.org; Thu, 31 May 2018 04:05:49 -0400
Message-ID: <5B0FAC9E.6090306@huawei.com>
Date: Thu, 31 May 2018 16:04:46 +0800
From: Shannon Zhao <zhaoshenglong@huawei.com>
MIME-Version: 1.0
References: <1527750994-14360-1-git-send-email-zhaoshenglong@huawei.com>
	<84171c12-e281-8de5-ec3d-ac0aaf3c3dbb@redhat.com>
In-Reply-To: <84171c12-e281-8de5-ec3d-ac0aaf3c3dbb@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] KVM: GIC: Fix memory leak due to calling
 kvm_init_irq_routing twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, shannon.zhaosl@gmail.com, qemu-devel@nongnu.org



On 2018/5/31 15:54, Auger Eric wrote:
> Hi Shannon,
> 
> On 05/31/2018 09:16 AM, Shannon Zhao wrote:
>> kvm_irqchip_create called by kvm_init will call kvm_init_irq_routing to
>> initialize global capability variables. If we call kvm_init_irq_routing in
>> GIC realize function, previous allocated memory will leak.
>>
>> Fix this by deleting the unnecessary call.
>>
>> Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
> openpic_kvm seems to suffer the same leak. Don't you want to fix it as
> well?
> 
I have a look at below patch of openpic_kvm which says on ppc it doesn't
call kvm_irqchip_create. So no such issue for it.

commit d85937e683f6ff4d68293cb24c780fb1f6820d2c
Author: Scott Wood <scottwood@freescale.com>
Date:   Wed Jun 12 15:32:51 2013 -0500

    kvm/openpic: in-kernel mpic support

> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
Thanks.

> Thanks
> 
> Eric
>> ---
>>  hw/intc/arm_gic_kvm.c   | 1 -
>>  hw/intc/arm_gicv3_kvm.c | 1 -
>>  2 files changed, 2 deletions(-)
>>
>> diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
>> index 6f467e6..204369d 100644
>> --- a/hw/intc/arm_gic_kvm.c
>> +++ b/hw/intc/arm_gic_kvm.c
>> @@ -572,7 +572,6 @@ static void kvm_arm_gic_realize(DeviceState *dev, Error **errp)
>>  
>>      if (kvm_has_gsi_routing()) {
>>          /* set up irq routing */
>> -        kvm_init_irq_routing(kvm_state);
>>          for (i = 0; i < s->num_irq - GIC_INTERNAL; ++i) {
>>              kvm_irqchip_add_irq_route(kvm_state, i, 0, i);
>>          }
>> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
>> index 001d82b..aa4c7c5 100644
>> --- a/hw/intc/arm_gicv3_kvm.c
>> +++ b/hw/intc/arm_gicv3_kvm.c
>> @@ -813,7 +813,6 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>>  
>>      if (kvm_has_gsi_routing()) {
>>          /* set up irq routing */
>> -        kvm_init_irq_routing(kvm_state);
>>          for (i = 0; i < s->num_irq - GIC_INTERNAL; ++i) {
>>              kvm_irqchip_add_irq_route(kvm_state, i, 0, i);
>>          }
>>
> 
> .
> 

-- 
Shannon
