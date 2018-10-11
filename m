Received: from eggs.gnu.org ([2001:4830:134:3::10]:41155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAYBA-0008Kp-Cm
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 06:26:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAYB6-00056g-Sd
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 06:26:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gAYB6-0004uU-GC
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 06:26:48 -0400
References: <20181009205652.10605-1-david@redhat.com>
	<20181009205652.10605-8-david@redhat.com>
	<20181011102056.GE2483@work-vm>
From: David Hildenbrand <david@redhat.com>
Message-ID: <73f74218-0b2f-b04b-8da4-a8b58ef06a1e@redhat.com>
Date: Thu, 11 Oct 2018 12:26:30 +0200
MIME-Version: 1.0
In-Reply-To: <20181011102056.GE2483@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 7/7] memory-device: rewrite address
 assignment using ranges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>

>>      if (hint) {
>> -        new_addr = *hint;
>> -        if (new_addr < address_space_start) {
>> +        if (!range_valid(*hint, size)) {
>>              error_setg(errp, "can't add memory device [0x%" PRIx64 ":0x%" PRIx64
>> -                       "] before 0x%" PRIx64, new_addr, size,
>> -                       address_space_start);
>> +                       "], range overflow", *hint, size);
>>              return 0;
>> -        } else if ((new_addr + size) > address_space_end) {
>> +        }
>> +        range_init(&new, *hint, size);
>> +        if (range_starts_before_range(&new, &as)) {
>> +            error_setg(errp, "can't add memory device [0x%" PRIx64 ":0x%" PRIx64
>> +                       "] before 0x%" PRIx64, range_lob(&new), range_size(&new),
>> +                       range_lob(&as));
>> +            return 0;
>> +        } else if (range_ends_after_range(&new, &as)) {
>>              error_setg(errp, "can't add memory device [0x%" PRIx64 ":0x%" PRIx64
>> -                       "] beyond 0x%" PRIx64, new_addr, size,
>> -                       address_space_end);
>> +                       "] beyond 0x%" PRIx64, range_lob(&new), range_size(&new),
>> +                       range_upb(&as));
> 
> Would !range_contains_range be easier here?

Yes, but then we have to change the error message, e.g. to

can't add memory device [...:...], usable range [...:...]

> 
>>              return 0;
>>          }
>>      } else {
>> -        new_addr = address_space_start;
>> +        /* our previous size checks make sure that this never overflows */
> 
> Hmm, which one exactly?

Previous patch in this series, via memory_device_check_addable().

But we can add an explicit check here.

> 
>> +        range_init(&new, range_lob(&as), size);
>>      }



-- 

Thanks,

David / dhildenb
