Received: from eggs.gnu.org ([2001:4830:134:3::10]:40453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fNacB-0000hp-MH
	for qemu-devel@nongnu.org; Tue, 29 May 2018 05:08:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fNacA-0003PT-H5
	for qemu-devel@nongnu.org; Tue, 29 May 2018 05:08:23 -0400
References: <1526222114-5324-1-git-send-email-eric.auger@redhat.com>
	<1526222114-5324-4-git-send-email-eric.auger@redhat.com>
	<CAFEAcA8yo_NKY=mHNYFFTA1+eR-731ePUb5hDum0ubUM2XOxxg@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <929ce9c7-afae-7978-ed35-3789fcbf026a@redhat.com>
Date: Tue, 29 May 2018 11:08:08 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8yo_NKY=mHNYFFTA1+eR-731ePUb5hDum0ubUM2XOxxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 3/7] hw/intc/arm_gicv3: Introduce
 redist-region-count array property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Christoffer Dall <christoffer.dall@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>

Hi Peter,
On 05/22/2018 02:27 PM, Peter Maydell wrote:
> On 13 May 2018 at 15:35, Eric Auger <eric.auger@redhat.com> wrote:
>> To prepare for multiple redistributor regions, we introduce
>> an array of uint32_t properties that stores the redistributor
>> count of each redistributor region.
>>
>> Non accelerated VGICv3 only supports a single redistributor region.
>> The capacity of all redist regions is checked against the number of
>> vcpus.
>>
>> Machvirt is updated to set the count to 123 vcpus for the unique
>> redistributor region we currently have.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/arm/virt.c                      |  6 ++++++
>>  hw/intc/arm_gicv3.c                | 11 ++++++++++-
>>  hw/intc/arm_gicv3_common.c         | 35 ++++++++++++++++++++++++++++++-----
>>  hw/intc/arm_gicv3_kvm.c            |  9 +++++++--
>>  include/hw/intc/arm_gicv3_common.h |  6 ++++--
>>  5 files changed, 57 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 11b9f59..c9d842d 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -525,6 +525,12 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
>>      if (!kvm_irqchip_in_kernel()) {
>>          qdev_prop_set_bit(gicdev, "has-security-extensions", vms->secure);
>>      }
>> +
>> +    if (type == 3) {
>> +        qdev_prop_set_uint32(gicdev, "len-redist-region-count", 1);
>> +        qdev_prop_set_uint32(gicdev , "redist-region-count[0]",
>> +                             vms->memmap[VIRT_GIC_REDIST].size / 0x20000);
> 
> We used to create a region which had num_cpu redistributors in it;
> won't this cause us to create one which has as many redistributors
> as will fit in the space ?
Is that an issue? From a machine perspective the whole region is
reserved for rdist. dt and ACPI will expose this whole region and the
device will use a subset of it? I agree I need to document this change
in the commit message though.
> 
>> +    }
>>      qdev_init_nofail(gicdev);
>>      gicbusdev = SYS_BUS_DEVICE(gicdev);
>>      sysbus_mmio_map(gicbusdev, 0, vms->memmap[VIRT_GIC_DIST].base);
>> diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
>> index 479c667..38d57ac 100644
>> --- a/hw/intc/arm_gicv3.c
>> +++ b/hw/intc/arm_gicv3.c
>> @@ -373,7 +373,16 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
>>          return;
>>      }
>>
>> -    gicv3_init_irqs_and_mmio(s, gicv3_set_irq, gic_ops);
>> +    if (s->nb_redist_regions != 1) {
>> +        error_setg(errp, "VGICv3 redist region number(%d) not equal to 1",
>> +                   s->nb_redist_regions);
> 
> Missing 'return' ?
yes!
> 
>> +    }
>> +
>> +    gicv3_init_irqs_and_mmio(s, gicv3_set_irq, gic_ops, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>>
>>      gicv3_init_cpuif(s);
>>  }
>> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
>> index 7b54d52..f405ae1 100644
>> --- a/hw/intc/arm_gicv3_common.c
>> +++ b/hw/intc/arm_gicv3_common.c
>> @@ -169,9 +169,10 @@ static const VMStateDescription vmstate_gicv3 = {
>>  };
>>
>>  void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
>> -                              const MemoryRegionOps *ops)
>> +                              const MemoryRegionOps *ops, Error **errp)
>>  {
>>      SysBusDevice *sbd = SYS_BUS_DEVICE(s);
>> +    int rdist_capacity = 0;
>>      int i;
>>
>>      /* For the GIC, also expose incoming GPIO lines for PPIs for each CPU.
>> @@ -199,11 +200,25 @@ void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
>>
>>      memory_region_init_io(&s->iomem_dist, OBJECT(s), ops, s,
>>                            "gicv3_dist", 0x10000);
>> -    memory_region_init_io(&s->iomem_redist, OBJECT(s), ops ? &ops[1] : NULL, s,
>> -                          "gicv3_redist", 0x20000 * s->num_cpu);
>> -
>>      sysbus_init_mmio(sbd, &s->iomem_dist);
>> -    sysbus_init_mmio(sbd, &s->iomem_redist);
>> +
>> +    s->iomem_redist = g_new0(MemoryRegion, s->nb_redist_regions);
>> +    for (i = 0; i < s->nb_redist_regions; i++) {
>> +        char *name = g_strdup_printf("gicv3_redist_region[%d]", i);
>> +
>> +        memory_region_init_io(&s->iomem_redist[i], OBJECT(s),
>> +                              ops ? &ops[1] : NULL, s,
>> +                              name, 0x20000 * s->redist_region_count[i]);
>> +        sysbus_init_mmio(sbd, &s->iomem_redist[i]);
>> +        rdist_capacity += s->redist_region_count[i];
>> +        g_free(name);
>> +    }
>> +    if (rdist_capacity < s->num_cpu) {
>> +        error_setg(errp, "Capacity of the redist regions(%d) "
>> +                   "is less than number of vcpus(%d)",
>> +                   rdist_capacity, s->num_cpu);
> 
> It would be better to make this check before we create a lot of
> memory regions, I think. (Though I'm very unsure of the rules about
> how to unwind what you've done in a realize method that's about to fail;
> we probably get it wrong a lot and don't care because realize failure
> is fatal for most uses of most devices.)
I moved the rdist_capacity computation and check at the beginning of the
function. Anyway if the num_cpu rdists cannot fit in the rdist regions,
this is fatal. virt calls qdev_init_nofail(gicdev);

Thanks

Eric
> 
>> +    }
>> +
>>  }
>>
>>  static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
> 
> thanks
> -- PMM
> 
