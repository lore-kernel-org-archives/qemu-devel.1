Received: from eggs.gnu.org ([2001:4830:134:3::10]:53304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fTSjQ-0005w9-7R
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:56:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fTSjO-0007Ad-Pr
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:56:08 -0400
References: <1528879723-24675-1-git-send-email-eric.auger@redhat.com>
	<1528879723-24675-4-git-send-email-eric.auger@redhat.com>
	<20180614133215.khbod4vx4w6drh2x@kamzik.brq.redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <38a734ec-e813-03c9-d110-50dd327a60be@redhat.com>
Date: Thu, 14 Jun 2018 15:55:56 +0200
MIME-Version: 1.0
In-Reply-To: <20180614133215.khbod4vx4w6drh2x@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/9] hw/intc/arm_gicv3: Introduce
 redist-region-count array property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: wei@redhat.com, peter.maydell@linaro.org, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, qemu-devel@nongnu.org, christoffer.dall@arm.com, qemu-arm@nongnu.org, zhaoshenglong@huawei.com, lersek@redhat.com, eric.auger.pro@gmail.com

Hi Drew,

On 06/14/2018 03:32 PM, Andrew Jones wrote:
> On Wed, Jun 13, 2018 at 10:48:37AM +0200, Eric Auger wrote:
>> To prepare for multiple redistributor regions, we introduce
>> an array of uint32_t properties that stores the redistributor
>> count of each redistributor region.
>>
>> Non accelerated VGICv3 only supports a single redistributor region.
>> The capacity of all redist regions is checked against the number of
>> vcpus.
>>
>> Machvirt is updated to set those properties, ie. a single
>> redistributor region with count set to the number of vcpus
>> capped by 123.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>> v2 -> v3:
>> - add missing return in arm_gic_realize
>> - in gicv3_init_irqs_and_mmio, compute/check rdist_capacity first
>> - rdist region 0 size set to MIN(smp_cpus, redist0_capacity)
>> - add GICV3_REDIST_SIZE
>> ---
>>  hw/arm/virt.c                      | 11 ++++++++++-
>>  hw/intc/arm_gicv3.c                | 12 +++++++++++-
>>  hw/intc/arm_gicv3_common.c         | 38 +++++++++++++++++++++++++++++++++-----
>>  hw/intc/arm_gicv3_kvm.c            |  9 +++++++--
>>  include/hw/intc/arm_gicv3_common.h |  8 ++++++--
>>  5 files changed, 67 insertions(+), 11 deletions(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index f0a4fa0..2885d18 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -522,6 +522,15 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
>>      if (!kvm_irqchip_in_kernel()) {
>>          qdev_prop_set_bit(gicdev, "has-security-extensions", vms->secure);
>>      }
>> +
>> +    if (type == 3) {
>> +        uint32_t redist0_capacity =
>> +                    vms->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
>> +        uint32_t redist0_count = MIN(smp_cpus, redist0_capacity);
>> +
>> +        qdev_prop_set_uint32(gicdev, "len-redist-region-count", 1);
> 
> I don't see where this property is defined or used.

This is due to the fact we have an array property. nb_redist_regions is
the storage of this value. len-redist-region-count is the name of the
field (size of the array) from the user point of view.

DEFINE_PROP_ARRAY("redist-region-count", GICv3State, nb_redist_regions,
                      redist_region_count, qdev_prop_uint32, uint32_t),

see len-db-voltage property in hw/arm/vexpress.c and
hw/misc/arm_sysctl.c for a similar usage.

Thanks

Eric


> 
>> +        qdev_prop_set_uint32(gicdev, "redist-region-count[0]", redist0_count);
>> +    }
>>      qdev_init_nofail(gicdev);
>>      gicbusdev = SYS_BUS_DEVICE(gicdev);
>>      sysbus_mmio_map(gicbusdev, 0, vms->memmap[VIRT_GIC_DIST].base);
>> @@ -1321,7 +1330,7 @@ static void machvirt_init(MachineState *machine)
>>       * many redistributors we can fit into the memory map.
>>       */
>>      if (vms->gic_version == 3) {
>> -        virt_max_cpus = vms->memmap[VIRT_GIC_REDIST].size / 0x20000;
>> +        virt_max_cpus = vms->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
>>      } else {
>>          virt_max_cpus = GIC_NCPU;
>>      }
>> diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
>> index 479c667..7044133 100644
>> --- a/hw/intc/arm_gicv3.c
>> +++ b/hw/intc/arm_gicv3.c
>> @@ -373,7 +373,17 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
>>          return;
>>      }
>>  
>> -    gicv3_init_irqs_and_mmio(s, gicv3_set_irq, gic_ops);
>> +    if (s->nb_redist_regions != 1) {
>> +        error_setg(errp, "VGICv3 redist region number(%d) not equal to 1",
>> +                   s->nb_redist_regions);
>> +        return;
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
>> index 864b7c6..ff326b3 100644
>> --- a/hw/intc/arm_gicv3_common.c
>> +++ b/hw/intc/arm_gicv3_common.c
>> @@ -247,11 +247,22 @@ static const VMStateDescription vmstate_gicv3 = {
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
>> +    for (i = 0; i < s->nb_redist_regions; i++) {
>> +        rdist_capacity += s->redist_region_count[i];
>> +    }
>> +    if (rdist_capacity < s->num_cpu) {
>> +        error_setg(errp, "Capacity of the redist regions(%d) "
>> +                   "is less than number of vcpus(%d)",
>> +                   rdist_capacity, s->num_cpu);
>> +        return;
>> +    }
>> +
>>      /* For the GIC, also expose incoming GPIO lines for PPIs for each CPU.
>>       * GPIO array layout is thus:
>>       *  [0..N-1] spi
>> @@ -277,11 +288,18 @@ void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
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
>> +                              ops ? &ops[1] : NULL, s, name,
>> +                              s->redist_region_count[i] * GICV3_REDIST_SIZE);
>> +        sysbus_init_mmio(sbd, &s->iomem_redist[i]);
>> +        g_free(name);
>> +    }
>>  }
>>  
>>  static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
>> @@ -363,6 +381,13 @@ static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
>>      }
>>  }
>>  
>> +static void arm_gicv3_finalize(Object *obj)
>> +{
>> +    GICv3State *s = ARM_GICV3_COMMON(obj);
>> +
>> +    g_free(s->redist_region_count);
>> +}
>> +
>>  static void arm_gicv3_common_reset(DeviceState *dev)
>>  {
>>      GICv3State *s = ARM_GICV3_COMMON(dev);
>> @@ -467,6 +492,8 @@ static Property arm_gicv3_common_properties[] = {
>>      DEFINE_PROP_UINT32("num-irq", GICv3State, num_irq, 32),
>>      DEFINE_PROP_UINT32("revision", GICv3State, revision, 3),
>>      DEFINE_PROP_BOOL("has-security-extensions", GICv3State, security_extn, 0),
>> +    DEFINE_PROP_ARRAY("redist-region-count", GICv3State, nb_redist_regions,
>> +                      redist_region_count, qdev_prop_uint32, uint32_t),
>>      DEFINE_PROP_END_OF_LIST(),
>>  };
>>  
>> @@ -488,6 +515,7 @@ static const TypeInfo arm_gicv3_common_type = {
>>      .instance_size = sizeof(GICv3State),
>>      .class_size = sizeof(ARMGICv3CommonClass),
>>      .class_init = arm_gicv3_common_class_init,
>> +    .instance_finalize = arm_gicv3_finalize,
>>      .abstract = true,
>>      .interfaces = (InterfaceInfo []) {
>>          { TYPE_ARM_LINUX_BOOT_IF },
>> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
>> index 46d9afb..ed7b719 100644
>> --- a/hw/intc/arm_gicv3_kvm.c
>> +++ b/hw/intc/arm_gicv3_kvm.c
>> @@ -770,7 +770,11 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>>          return;
>>      }
>>  
>> -    gicv3_init_irqs_and_mmio(s, kvm_arm_gicv3_set_irq, NULL);
>> +    gicv3_init_irqs_and_mmio(s, kvm_arm_gicv3_set_irq, NULL, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>>  
>>      for (i = 0; i < s->num_cpu; i++) {
>>          ARMCPU *cpu = ARM_CPU(qemu_get_cpu(i));
>> @@ -794,7 +798,8 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>>  
>>      kvm_arm_register_device(&s->iomem_dist, -1, KVM_DEV_ARM_VGIC_GRP_ADDR,
>>                              KVM_VGIC_V3_ADDR_TYPE_DIST, s->dev_fd, 0);
>> -    kvm_arm_register_device(&s->iomem_redist, -1, KVM_DEV_ARM_VGIC_GRP_ADDR,
>> +    kvm_arm_register_device(&s->iomem_redist[0], -1,
>> +                            KVM_DEV_ARM_VGIC_GRP_ADDR,
>>                              KVM_VGIC_V3_ADDR_TYPE_REDIST, s->dev_fd, 0);
>>  
>>      if (kvm_has_gsi_routing()) {
>> diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
>> index d75b49d..b798486 100644
>> --- a/include/hw/intc/arm_gicv3_common.h
>> +++ b/include/hw/intc/arm_gicv3_common.h
>> @@ -35,6 +35,8 @@
>>  #define GICV3_MAXIRQ 1020
>>  #define GICV3_MAXSPI (GICV3_MAXIRQ - GIC_INTERNAL)
>>  
>> +#define GICV3_REDIST_SIZE 0x20000
>> +
>>  /* Number of SGI target-list bits */
>>  #define GICV3_TARGETLIST_BITS 16
>>  
>> @@ -210,7 +212,9 @@ struct GICv3State {
>>      /*< public >*/
>>  
>>      MemoryRegion iomem_dist; /* Distributor */
>> -    MemoryRegion iomem_redist; /* Redistributors */
>> +    MemoryRegion *iomem_redist; /* Redistributor Regions */
>> +    uint32_t *redist_region_count; /* redistributor count within each region */
>> +    uint32_t nb_redist_regions; /* number of redist regions */
>>  
>>      uint32_t num_cpu;
>>      uint32_t num_irq;
>> @@ -292,6 +296,6 @@ typedef struct ARMGICv3CommonClass {
>>  } ARMGICv3CommonClass;
>>  
>>  void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
>> -                              const MemoryRegionOps *ops);
>> +                              const MemoryRegionOps *ops, Error **errp);
>>  
>>  #endif
>> -- 
>> 2.5.5
>>
>>
> 
> Thanks,
> drew 
> 
