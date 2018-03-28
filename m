Received: from eggs.gnu.org ([2001:4830:134:3::10]:59375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f14sI-0005DZ-7m
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 02:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f14sH-0004jx-9i
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 02:47:58 -0400
References: <1522160122-10744-1-git-send-email-eric.auger@redhat.com>
	<1522160122-10744-9-git-send-email-eric.auger@redhat.com>
	<5ABB13BC.8060809@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <578156db-afbd-a4d7-3899-ec96e2cfd8fb@redhat.com>
Date: Wed, 28 Mar 2018 08:47:36 +0200
MIME-Version: 1.0
In-Reply-To: <5ABB13BC.8060809@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 8/8] hw/arm/virt: Allow up to 512 vcpus along
 with KVM VGICv3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: wei@redhat.com, marc.zyngier@arm.com, drjones@redhat.com, cdall@kernel.org

Hi Shannon,

On 28/03/18 06:02, Shannon Zhao wrote:
> 
> 
> On 2018/3/27 22:15, Eric Auger wrote:
>> With KVM acceleration and if KVM VGICV3 supports to set multiple
>> redistributor regions, we now allow up to 512 vcpus.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/arm/virt.c         | 17 ++++++++++++++++-
>>  include/hw/arm/virt.h |  1 +
>>  2 files changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 8258f6f..cdb1a75 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -149,8 +149,10 @@ static const MemMapEntry a15memmap[] = {
>>      [VIRT_PCIE_PIO] =           { 0x3eff0000, 0x00010000 },
>>      [VIRT_PCIE_ECAM] =          { 0x3f000000, 0x01000000 },
>>      [VIRT_MEM] =                { 0x40000000, RAMLIMIT_BYTES },
>> +    /* Allows 512 - 123 additional vcpus (each 2x64kB) */
>> +    [VIRT_GIC_REDIST2] =        { 0x4000000000ULL, 0x30A0000LL },
> One concern that this will limit the guest ram size to RAMLIMIT_BYTES.
> If we want to support larger ram size in the future, this may be a problem.
There is comment before  #define RAMLIMIT_GB 255
saying that RAM extension should rather happen at 2TB base.
"../.. We don't want to fill all the way up to 512GB with RAM because
 * we might want it for non-RAM purposes later"

This REDIST2 region could also be allocated at the top of the [256GB -
512GB] region.

I will start working on extending the RAM as suggested by this comment.

Thanks

Eric

> 
>>      /* Second PCIe window, 512GB wide at the 512GB boundary */
>> -    [VIRT_PCIE_MMIO_HIGH] =   { 0x8000000000ULL, 0x8000000000ULL },
>> +    [VIRT_PCIE_MMIO_HIGH] =     { 0x8000000000ULL, 0x8000000000ULL },
>>  };
>>  
>>  static const int a15irqmap[] = {
>> @@ -553,6 +555,11 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
>>          agcc->register_redist_region((GICv3State *)gicdev,
>>                                   vms->memmap[VIRT_GIC_REDIST].base,
>>                                   vms->memmap[VIRT_GIC_REDIST].size >> 17);
>> +        if (vms->smp_cpus > 123) {
>> +            agcc->register_redist_region((GICv3State *)gicdev,
>> +                     vms->memmap[VIRT_GIC_REDIST2].base,
>> +                                 vms->memmap[VIRT_GIC_REDIST2].size >> 17);
>> +        }
>>      } else {
>>          sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_CPU].base);
>>      }
>> @@ -1284,6 +1291,14 @@ static void machvirt_init(MachineState *machine)
>>       */
>>      if (vms->gic_version == 3) {
>>          virt_max_cpus = vms->memmap[VIRT_GIC_REDIST].size / 0x20000;
>> +        if (kvm_max_vcpus(kvm_state) > 255) {
>> +            /*
>> +             * VGICv3 KVM device capability to set multiple redistributor
>> +             * was introduced at the same time KVM_MAX_VCPUS was bumped
>> +             * from 255 to 512
>> +             */
>> +            virt_max_cpus += vms->memmap[VIRT_GIC_REDIST2].size / 0x20000;
>> +        }
>>      } else {
>>          virt_max_cpus = GIC_NCPU;
>>      }
>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
>> index d168291..801a4ad 100644
>> --- a/include/hw/arm/virt.h
>> +++ b/include/hw/arm/virt.h
>> @@ -60,6 +60,7 @@ enum {
>>      VIRT_GIC_V2M,
>>      VIRT_GIC_ITS,
>>      VIRT_GIC_REDIST,
>> +    VIRT_GIC_REDIST2,
>>      VIRT_UART,
>>      VIRT_MMIO,
>>      VIRT_RTC,
>>
> 
