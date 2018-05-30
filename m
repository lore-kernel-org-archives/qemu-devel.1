Received: from eggs.gnu.org ([2001:4830:134:3::10]:57953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fO1lp-0007eO-P4
	for qemu-devel@nongnu.org; Wed, 30 May 2018 10:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fO1lm-0001GG-LC
	for qemu-devel@nongnu.org; Wed, 30 May 2018 10:08:09 -0400
References: <20180517081527.14410-1-david@redhat.com>
	<20180517081527.14410-6-david@redhat.com>
	<20180530151212.47455e78@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b7e1f787-fb65-b64a-9e24-8edfa9d42fe1@redhat.com>
Date: Wed, 30 May 2018 16:08:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180530151212.47455e78@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 05/14] pc: route all memory devices
 through the machine hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 30.05.2018 15:12, Igor Mammedov wrote:
> On Thu, 17 May 2018 10:15:18 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Necessary to hotplug them cleanly later. We could drop the PC_DIMM
>> check, as PC_DIMM are just memory devices, but this approach is cleaner.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/i386/pc.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 510076e156..8bc41ef24b 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -74,6 +74,7 @@
>>  #include "hw/nmi.h"
>>  #include "hw/i386/intel_iommu.h"
>>  #include "hw/net/ne2000-isa.h"
>> +#include "hw/mem/memory-device.h"
>>  
>>  /* debug PC/ISA interrupts */
>>  //#define DEBUG_IRQ
>> @@ -2075,6 +2076,7 @@ static HotplugHandler *pc_get_hotpug_handler(MachineState *machine,
>>                                               DeviceState *dev)
>>  {
>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
>> +        object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE) ||
> you probably could drop TYPE_PC_DIMM above, it's redundant since DIMM
> can be cast to TYPE_MEMORY_DEVICE
> 
> ditto for spapr
> 

Yes, had the same in mind but left it for now this way (basically
because we do special handling for PC_DIMM, so anybody reading this code
is not directly confused)

>>          object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>>          return HOTPLUG_HANDLER(machine);
>>      }
> 


-- 

Thanks,

David / dhildenb
