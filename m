Received: from eggs.gnu.org ([209.51.188.92]:45117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gzf5h-0006jP-Bk
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:08:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gzf5g-0004ej-5U
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:08:29 -0500
References: <20190228150324.25973-1-eric.auger@redhat.com>
	<20190228150324.25973-11-eric.auger@redhat.com>
	<20190228172938.1993ed57@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <b27b4a41-6967-9535-2a3f-467a5d54c491@redhat.com>
Date: Fri, 1 Mar 2019 11:08:17 +0100
MIME-Version: 1.0
In-Reply-To: <20190228172938.1993ed57@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v10 10/10] hw/arm/virt: Bump the 255GB
 initial RAM limit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, david@redhat.com, dgilbert@redhat.com, david@gibson.dropbear.id.au, drjones@redhat.com, pbonzini@redhat.com

Hi Igor,

On 2/28/19 5:29 PM, Igor Mammedov wrote:
> On Thu, 28 Feb 2019 16:03:24 +0100
> Eric Auger <eric.auger@redhat.com> wrote:
> 
>> Now we have the extended memory map (high IO regions beyond the
>> scalable RAM) and dynamic IPA range support at KVM/ARM level
>> we can bump the legacy 255GB initial RAM limit. The actual maximum
>> RAM size now depends on the physical CPU and host kernel, in
>> accelerated mode. In TCG mode, it depends on the VCPU
>> AA64MMFR0.PARANGE.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>> v7 -> v8:
>> - TCG PAMAX check moved in a separate patch
>>
>> v6 -> v7
>> - handle TCG case
>> - set_memmap modifications moved to previous patches
>> ---
>>  hw/arm/virt.c | 21 +--------------------
>>  1 file changed, 1 insertion(+), 20 deletions(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index a3da75a5ae..a45f0fcf79 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -95,21 +95,8 @@
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
>>  #define RAMBASE GiB
>> +/* Legacy RAM limit in GB (< version 4.0) */
>>  #define LEGACY_RAMLIMIT_GB 255
>>  #define LEGACY_RAMLIMIT_BYTES (LEGACY_RAMLIMIT_GB * GiB)
> do we need to keep these couple around?
> 
> it's used only in
>  [VIRT_MEM] = { RAMBASE, LEGACY_RAMLIMIT_BYTES },
> and doesn't have any effect whatsoever.
> I'd set initial  VIRT_MEM.size to 0 and drop LEGACY_RAMLIMIT_*
> maybe add comment above entry that size is defined by ram_size

in virt_set_memmap I was checking if (high_io_base < 256 GiB) then
high_io_base = 256GiB. Maybe this 256GiB value comes out of the blue and
I should also replace it with vms->memmap[VIRT_MEM].base +
LEGACY_RAMLIMIT_BYTES.
We maintain some kind of compatibility with the old memmap so I prefer
to keep this info somewhere.

I added a comment though:
/* Actual RAM size depends on initial RAM and device memory options */

Thanks

Eric


> 
>>  
>> @@ -1515,12 +1502,6 @@ static void machvirt_init(MachineState *machine)
>>  
>>      vms->smp_cpus = smp_cpus;
>>  
>> -    if (machine->ram_size > vms->memmap[VIRT_MEM].size) {
>> -        error_report("mach-virt: cannot model more than %dGB RAM",
>> -                     LEGACY_RAMLIMIT_GB);
>> -        exit(1);
>> -    }
>> -
>>      if (vms->virt && kvm_enabled()) {
>>          error_report("mach-virt: KVM does not support providing "
>>                       "Virtualization extensions to the guest CPU");
> 
