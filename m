Received: from eggs.gnu.org ([2001:4830:134:3::10]:44654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fBghg-0005E8-0l
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:12:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fBghb-0007X7-38
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:12:51 -0400
References: <20180426103430.768-1-david@redhat.com>
	<17e55323-8266-2bed-780a-3559d87c8c56@gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2cd9a5dd-80d4-80d3-ed58-99dc280bc1dd@redhat.com>
Date: Thu, 26 Apr 2018 15:12:35 +0200
MIME-Version: 1.0
In-Reply-To: <17e55323-8266-2bed-780a-3559d87c8c56@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] pc-dimm: fix error messages if no slots
 were defined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Cc: Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 26.04.2018 13:41, Marcel Apfelbaum wrote:
> Hi David,
> 
> On 26/04/2018 13:34, David Hildenbrand wrote:
>> If not slots were defined we try to allocate an empty bitmap, which
> 
> not -> no
> 
>> fails.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>
>> This fixes the queued patch "exec: Allow memory regions with size 0"
>>
>>  hw/mem/pc-dimm.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
>> index 0119c68e01..f2c140947d 100644
>> --- a/hw/mem/pc-dimm.c
>> +++ b/hw/mem/pc-dimm.c
>> @@ -118,9 +118,15 @@ static int pc_dimm_slot2bitmap(Object *obj, void *opaque)
>>  
>>  int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp)
>>  {
>> -    unsigned long *bitmap = bitmap_new(max_slots);
>> +    unsigned long *bitmap;
>>      int slot = 0;
>>  
>> +    if (max_slots <= 0) {
>> +        error_setg(errp, "no free slots available");
> 
> Maybe a better error message would be "no slots were allocated"
> since max_slots is 0.

I am using the same error message as if there are no more slots
available. If can change it to "no slots where allocated, please specify
the 'slots' option.

Using max_slots would be wrong.

Thanks!

> 
> Thanks,
> Marcel
> 
>> +        return slot;
>> +    }
>> +
>> +    bitmap = bitmap_new(max_slots);
>>      object_child_foreach(qdev_get_machine(), pc_dimm_slot2bitmap, bitmap);
>>  
>>      /* check if requested slot is not occupied */
>>


-- 

Thanks,

David / dhildenb
