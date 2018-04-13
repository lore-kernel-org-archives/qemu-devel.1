Received: from eggs.gnu.org ([2001:4830:134:3::10]:45087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f6zHH-0002Bj-9Z
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:02:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f6zHD-0008Lk-CM
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:02:11 -0400
References: <1522160122-10744-1-git-send-email-eric.auger@redhat.com>
	<1522160122-10744-9-git-send-email-eric.auger@redhat.com>
	<CAFEAcA_O3QK0t5DHfnAFEOHv_yyxvL9HZX+0geHs0ibVVwTbNQ@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <57b01152-1179-9735-eb6a-a9dbfc933a6c@redhat.com>
Date: Fri, 13 Apr 2018 16:01:49 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_O3QK0t5DHfnAFEOHv_yyxvL9HZX+0geHs0ibVVwTbNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Christoffer Dall <cdall@kernel.org>, Shannon Zhao <zhaoshenglong@huawei.com>

Hi Peter,

On 13/04/18 15:41, Peter Maydell wrote:
> On 27 March 2018 at 15:15, Eric Auger <eric.auger@redhat.com> wrote:
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
> 
> Maybe we should make the 2nd redist region go up to a slightly
> rounder address rather than making it exactly big enough to get
> us up to 512 CPUs? (Why 512, by the way?)
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
> 
> I think it would be better to explicitly check "do we have
> support for split redistributors" rather than looking at
> KVM_MAX_VCPUS. It's not impossible that a distro kernel
> might have chosen to backport support for one but not the
> other.

The issue is we have race here:
to check whether the new ATTR is supported I need to query the GICV3 KVM
device. This later is created in the GICv3 initialize. But to initialize
the VGIC I need the VCPUs to be created. And to create the VCPUs I need
to check their max number. Or do I miss somethinh?

The KVM device create dry-run mode cannot be used here. I would need to
really create the KVM device and then delete it. The issue is there is
no kvm device DELETE ioctl at kernel level since KVM devices are deleted
on VM deletion if I understand correctly. Adding a KVM device delete at
kernel level may not be straightforward as I suspect some
simplifications could be made in KVM device deletion knowing the VM was
under deletion.

Thanks

Eric
> 
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
>> --
>> 2.5.5
> 
> thanks
> -- PMM
> 
