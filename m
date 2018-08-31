Received: from eggs.gnu.org ([2001:4830:134:3::10]:46437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fvgqW-0003nM-Ed
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:40:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fvgqT-0002dF-8E
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:40:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59028 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fvgqR-0002bi-89
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:40:05 -0400
References: <20180829153624.12299-1-david@redhat.com>
	<20180829153624.12299-15-david@redhat.com>
	<20180831103855.GC2376@work-vm>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6aabaa18-33f1-dea3-0824-74f78fcb2d0c@redhat.com>
Date: Fri, 31 Aug 2018 12:39:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180831103855.GC2376@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 14/20] memory-device: ids of virtio
 based devices are special
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>


>>  static gint memory_device_addr_sort(gconstpointer a, gconstpointer b)
>>  {
>>      const MemoryDeviceState *md_a = MEMORY_DEVICE(a);
>> @@ -168,6 +184,7 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
>>      for (item = list; item; item = g_slist_next(item)) {
>>          MemoryDeviceState *md = item->data;
>>          const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(OBJECT(md));
>> +        const char *id = memory_device_id(md);
>>          uint64_t md_size, md_addr;
>>  
>>          md_addr = mdc->get_addr(md);
>> @@ -178,8 +195,8 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
>>  
>>          if (ranges_overlap(md_addr, md_size, new_addr, size)) {
>>              if (hint) {
>> -                const DeviceState *d = DEVICE(md);
>> -                error_setg(errp, "address range conflicts with '%s'", d->id);
>> +                error_setg(errp, "address range conflicts with '%s'",
>> +                           id ? id : 0);
> 
> What's that 'id ? id : 0' trick for?

0 -> "", then it actually makes sense :)

I'll fix this up, thanks!


-- 

Thanks,

David / dhildenb
