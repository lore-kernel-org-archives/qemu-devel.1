Received: from eggs.gnu.org ([2001:4830:134:3::10]:37500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fhf1a-0005Eg-Fy
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 13:53:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fhf1X-0002Ag-D2
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 13:53:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42986 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fhf1X-0002AM-5g
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 13:53:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A37E681663F9
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 17:53:29 +0000 (UTC)
References: <20180705115943.29402-1-david@redhat.com>
	<20180723162355.55212c75@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1b31dbfd-c1c0-8f18-f82b-f044e1a88c5b@redhat.com>
Date: Mon, 23 Jul 2018 19:53:22 +0200
MIME-Version: 1.0
In-Reply-To: <20180723162355.55212c75@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 00/11] memory-device: complete
 refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 23.07.2018 16:23, Igor Mammedov wrote:
> On Thu,  5 Jul 2018 13:59:32 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> This is another part of the original series
>>     [PATCH v4 00/14] MemoryDevice: use multi stage hotplug handlers
>> And is based on
>>     [PATCH v3 0/4] pc-dimm: pre_plug "slot" and "addr" assignment
>>
>> This series completes refactoring of pre_plug, plug and unplug logic of
>> memory devices. With this as a basis, one can easily have e.g. virtio
>> based memory devices (virtio-mem, virtio-pmem, virtio-fs?) with minor
>> modifications on e.g. x86 and s390x.
>>
>> Unfortunately, the "addr" property is already used for virtio devices, so
>> we will have to deal with device specific properties. So
>> set_addr() for memory devices is introduced to handle that (we already
>> have get_addr()).
>>
>> The only way I see to avoid that would be for virtio based devices to
>> introduce an indirection:
>>
>> E.g. right now for my virtio-mem prototype:
>> ... -object memory-backend-ram,id=mem0,size=8G \
>>     -device virtio-mem-pci,id=vm0,memdev=mem0,node=0,phys-addr=0x12345
> Though it seems inconvenient to have different property name,
> it is not dimm device (even though it shares GPA resource)
> so it is fine for it to have it's own set of properties.
> (might make error reporting a bit ugly)

Same opinion here, that's why I prefer this approach.

> 
> Also what about usecase of mmio based virtio (ARM)?

Can you elaborate?

> 
> 
>> To something like:
>> ... -object memory-backend-ram,id=mem0,size=8G \
>>     -object virtio-mem-backend,id=vmb0,memdev=mem0,addr=0x12345 \
>>     -device virtio-mem-pci,id=vm0,vmem=vmb0 \
> it's broken conceptually,
> backends should deal only with host resource allocation while
> 'addr' is device model property and belongs to a frontend.

Agreed.

> 
>> Or something like (that might be interesting for virtio-pmem):
>> ... -device virtio-mem-pci \ /* a virtio-mem bus */
>>     -object memory-backend-ram,id=mem0,size=8G \
>>     -device virtio-mem-backend,memdev=mem0,addr=0x12345 \
> did you mean  ^^^^ virtio-pmem device?
> 
> Is it a separate controller and memory resource design
> connected together somehow?

Yes, for this example s/mem/pmem/ of course (copy paste). virtio-mem and
virtio-pmem are two separate device types with their own set of
controllers (if any).

I favor the original approach (above).


-- 

Thanks,

David / dhildenb
