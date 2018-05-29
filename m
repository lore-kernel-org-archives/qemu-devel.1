Received: from eggs.gnu.org ([2001:4830:134:3::10]:54966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fNeuG-0005lX-AO
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:43:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fNeuF-000847-8w
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:43:20 -0400
References: <1526222114-5324-1-git-send-email-eric.auger@redhat.com>
	<1526222114-5324-8-git-send-email-eric.auger@redhat.com>
	<CAFEAcA9772Q3OG-YfzLwGWcZ_L5evC7qP_PXqSi8bVr-p-PhJA@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <9f0bcfee-31ee-1f2d-1949-6cf986f22ac6@redhat.com>
Date: Tue, 29 May 2018 15:43:09 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9772Q3OG-YfzLwGWcZ_L5evC7qP_PXqSi8bVr-p-PhJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 7/7] hw/arm/virt: Register two
 redistributor regions when necessary
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

Hi,

On 05/22/2018 02:43 PM, Peter Maydell wrote:
> On 13 May 2018 at 15:35, Eric Auger <eric.auger@redhat.com> wrote:
>> With a VGICv3 KVM device, if the number of vcpus exceeds the
>> capacity of the legacy redistributor region (123 redistributors),
>> we now attempt to register the second redistributor region. This
>> extends the number of vcpus to 512 assuming the host kernel supports:
>> - up to 512 vcpus

I just noticed virt_machine_class_init still clamps the max_cpus to 255.
This is checked in vl.c

Do we want the 3.0 machine expose more than 255 vcpus, 512 for instance?
I understand this mc->max_cpus is something rather static, that is
refined afterwards.

Note the comment in virt_machine_class_init suggest 255 is the max QEMU
supports but I can see that pc_q35.c sets the max_cpus to 288 already.

Thanks

Eric

>> - VGICv3 KVM device group/attribute:
>>   KVM_DEV_ARM_VGIC_GRP_ADDR/KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION
>>
>> In case the host kernel does not support the registration of several
>> redistributor regions, the GICv3 device initialization fails
>> with a proper error message and qemu exits.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/arm/virt.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index f35962a..8d43c51 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -531,6 +531,7 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
>>      SysBusDevice *gicbusdev;
>>      const char *gictype;
>>      int type = vms->gic_version, i;
>> +    uint32_t nb_redist_regions = 0;
>>
>>      gictype = (type == 3) ? gicv3_class_name() : gic_class_name();
>>
>> @@ -546,15 +547,26 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
>>      }
>>
>>      if (type == 3) {
>> -        qdev_prop_set_uint32(gicdev, "len-redist-region-count", 1);
>> +        nb_redist_regions = virt_gicv3_redist_region_count(vms);
>> +
>> +        qdev_prop_set_uint32(gicdev, "len-redist-region-count",
>> +                             nb_redist_regions);
>>          qdev_prop_set_uint32(gicdev , "redist-region-count[0]",
>>                               vms->memmap[VIRT_GIC_REDIST].size / 0x20000);
>> +
>> +        if (nb_redist_regions == 2) {
>> +            qdev_prop_set_uint32(gicdev , "redist-region-count[1]",
> 
> Stray extra space before comma.
> 
>> +                                 vms->memmap[VIRT_GIC_REDIST2].size / 0x20000);
> 
> This is going to ask for more redistributors than we want (cf
> earlier review comment).
> 
>> +        }
>>      }
>>      qdev_init_nofail(gicdev);
>>      gicbusdev = SYS_BUS_DEVICE(gicdev);
>>      sysbus_mmio_map(gicbusdev, 0, vms->memmap[VIRT_GIC_DIST].base);
>>      if (type == 3) {
>>          sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_REDIST].base);
>> +        if (nb_redist_regions == 2) {
>> +            sysbus_mmio_map(gicbusdev, 2, vms->memmap[VIRT_GIC_REDIST2].base);
>> +        }
>>      } else {
>>          sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_CPU].base);
>>      }
>> @@ -1346,6 +1358,7 @@ static void machvirt_init(MachineState *machine)
>>       */
>>      if (vms->gic_version == 3) {
>>          virt_max_cpus = vms->memmap[VIRT_GIC_REDIST].size / 0x20000;
>> +        virt_max_cpus += vms->memmap[VIRT_GIC_REDIST2].size / 0x20000;
> 
> Slight pity that we can't determine whether we can support multiple
> redistributor regions here, but I guess it's not a big deal.
> 
>>      } else {
>>          virt_max_cpus = GIC_NCPU;
>>      }
>> --
>> 2.5.5
> 
> thanks
> -- PMM
> 
