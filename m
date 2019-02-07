Received: from eggs.gnu.org ([209.51.188.92]:52388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1grlf1-00025M-Ft
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:32:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1grleu-00008l-Cd
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:32:19 -0500
References: <20190205173306.20483-1-eric.auger@redhat.com>
	<20190205173306.20483-11-eric.auger@redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA8392B2D8D@lhreml524-mbs.china.huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <49dfe0ee-7afb-6639-3a4e-f4317073feba@redhat.com>
Date: Thu, 7 Feb 2019 16:25:08 +0100
MIME-Version: 1.0
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA8392B2D8D@lhreml524-mbs.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 10/18] hw/arm/virt: Bump the 255GB
 initial RAM limit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>, "david@redhat.com" <david@redhat.com>
Cc: "dgilbert@redhat.com" <dgilbert@redhat.com>, "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>, "drjones@redhat.com" <drjones@redhat.com>

Hi Shameer,

On 2/7/19 4:19 PM, Shameerali Kolothum Thodi wrote:
> Hi Eric,
> 
>> -----Original Message-----
>> From: Eric Auger [mailto:eric.auger@redhat.com]
>> Sent: 05 February 2019 17:33
>> To: eric.auger.pro@gmail.com; eric.auger@redhat.com;
>> qemu-devel@nongnu.org; qemu-arm@nongnu.org; peter.maydell@linaro.org;
>> Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> imammedo@redhat.com; david@redhat.com
>> Cc: dgilbert@redhat.com; david@gibson.dropbear.id.au; drjones@redhat.com
>> Subject: [PATCH v6 10/18] hw/arm/virt: Bump the 255GB initial RAM limit
>>
>> Now we have the extended memory map (high IO regions beyond the
>> scalable RAM) and dynamic IPA range support at KVM/ARM level
>> we can bump the legacy 255GB initial RAM limit. The actual maximum
>> RAM size now depends on the physical CPU and host kernel.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/arm/virt.c | 26 +++++++-------------------
>>  1 file changed, 7 insertions(+), 19 deletions(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index b90ffc2e5d..f01886da22 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -93,22 +93,9 @@
>>
>>  #define PLATFORM_BUS_NUM_IRQS 64
>>
>> -/* RAM limit in GB. Since VIRT_MEM starts at the 1GB mark, this means
>> - * RAM can go up to the 256GB mark, leaving 256GB of the physical
>> - * address space unallocated and free for future use between 256G and 512G.
>> - * If we need to provide more RAM to VMs in the future then we need to:
>> - *  * allocate a second bank of RAM starting at 2TB and working up
>> - *  * fix the DT and ACPI table generation code in QEMU to correctly
>> - *    report two split lumps of RAM to the guest
>> - *  * fix KVM in the host kernel to allow guests with >40 bit address spaces
>> - * (We don't want to fill all the way up to 512GB with RAM because
>> - * we might want it for non-RAM purposes later. Conversely it seems
>> - * reasonable to assume that anybody configuring a VM with a quarter
>> - * of a terabyte of RAM will be doing it on a host with more than a
>> - * terabyte of physical address space.)
>> - */
>> -#define RAMLIMIT_GB 255
>> -#define RAMLIMIT_BYTES (RAMLIMIT_GB * 1024ULL * 1024 * 1024)
>> +/* Legacy RAM limit in GB (< version 4.0) */
>> +#define LEGACY_RAMLIMIT_GB 255
>> +#define LEGACY_RAMLIMIT_BYTES (LEGACY_RAMLIMIT_GB * GiB)
>>
>>  /* Addresses and sizes of our components.
>>   * 0..128MB is space for a flash device so we can run bootrom code such as
>> UEFI.
>> @@ -149,7 +136,7 @@ static const MemMapEntry a15memmap[] = {
>>      [VIRT_PCIE_MMIO] =          { 0x10000000, 0x2eff0000 },
>>      [VIRT_PCIE_PIO] =           { 0x3eff0000, 0x00010000 },
>>      [VIRT_PCIE_ECAM] =          { 0x3f000000, 0x01000000 },
>> -    [VIRT_MEM] =                { 0x40000000, RAMLIMIT_BYTES },
>> +    [VIRT_MEM] =                { 0x40000000,
>> LEGACY_RAMLIMIT_BYTES },
>>  };
>>
>>  /*
>> @@ -1483,8 +1470,9 @@ static void machvirt_init(MachineState *machine)
>>
>>      vms->smp_cpus = smp_cpus;
>>
>> -    if (machine->ram_size > vms->memmap[VIRT_MEM].size) {
>> -        error_report("mach-virt: cannot model more than %dGB RAM",
>> RAMLIMIT_GB);
>> +    if (!vms->extended_memmap && machine->ram_size >
>> LEGACY_RAMLIMIT_GB) {
> 
> Just hit this while testing, should this check be against LEGACY_RAMLIMIT_BYTES?
Definitively, my mistake. Thank you for spotting that.

Thanks

Eric
> 
> Thanks,
> Shameer
> 
>> +        error_report("mach-virt: cannot model more than %dGB RAM",
>> +                     LEGACY_RAMLIMIT_GB);
>>          exit(1);
>>      }
>>
>> --
>> 2.20.1
> 
