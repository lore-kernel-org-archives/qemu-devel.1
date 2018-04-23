Received: from eggs.gnu.org ([2001:4830:134:3::10]:57115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fAci7-0002hr-W7
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 10:44:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fAci2-0001jv-7i
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 10:44:56 -0400
References: <20180420123456.22196-1-david@redhat.com>
	<20180420123456.22196-4-david@redhat.com>
	<20180423141928.7e64b380@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6e518802-62cb-126c-7ba4-3313e04befda@redhat.com>
Date: Mon, 23 Apr 2018 16:44:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180423141928.7e64b380@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/3] pc-dimm: factor out address space
 logic into MemoryDevice code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>

On 23.04.2018 14:19, Igor Mammedov wrote:
> On Fri, 20 Apr 2018 14:34:56 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> To be able to reuse MemoryDevice logic from other devices besides
>> pc-dimm, factor the relevant stuff out into the MemoryDevice code.
>>
>> As we don't care about slots for memory devices that are not pc-dimm,
>> don't factor that part out.
> that's not really true, you still consume kvm and vhost slots (whatever it is)
> whenever you map it into address space as ram memory region.
> 
> Also ram_slots currently are (ab)used as flag that user enabled memory
> hotplug via CLI.
>  
>> Most of this patch just moves checks and logic around. While at it, make
>> the code properly detect certain error conditions better (e.g. fragmented
>> memory).
> I'd suggest splitting patch in several smaller ones if possible,
> especially parts that do anything more than just moving code around.
> 
> 
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/i386/pc.c                   |  12 +--
>>  hw/mem/memory-device.c         | 162 ++++++++++++++++++++++++++++++++++++
>>  hw/mem/pc-dimm.c               | 185 +++--------------------------------------
>>  hw/ppc/spapr.c                 |   9 +-
>>  include/hw/mem/memory-device.h |   4 +
>>  include/hw/mem/pc-dimm.h       |  14 +---
>>  6 files changed, 185 insertions(+), 201 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index fa8862af33..1c25546a0c 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1711,7 +1711,7 @@ static void pc_dimm_plug(HotplugHandler *hotplug_dev,
>>          goto out;
>>      }
>>  
>> -    pc_dimm_memory_plug(dev, &pcms->hotplug_memory, mr, align, &local_err);
>> +    pc_dimm_memory_plug(dev, align, &local_err);
> Is there a reason why you are dropping pcms->hotplug_memory argument
> and fall back to qdev_get_machine()?
> 
> I'd rather see it going other direction,
> i.e. move hotplug_memory from PC
> machine to MachineState and then pass it down as argument whenever it's needed.

FWIW, I think I found a way to split this into smaller patches.

The current prototypes will look like this for pc_dimm

void pc_dimm_memory_plug(DeviceState *dev, MachineState *machine,
                         uint64_t align, Error **errp);
void pc_dimm_memory_unplug(DeviceState *dev, MachineState *machine);

I am not sure yet if I'll work on the pre-plug stuff for pc-dimm (I want
to get memory devices running not rewrite all of the pc-dimm memory
hotplug code :) ), but that can be reworked later on easily.

-- 

Thanks,

David / dhildenb
