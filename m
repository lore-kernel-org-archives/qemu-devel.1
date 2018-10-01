Received: from eggs.gnu.org ([2001:4830:134:3::10]:56330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g6tgr-0006gT-Km
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g6tgm-0007Cn-RF
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:36:29 -0400
References: <20180926094219.20322-1-david@redhat.com>
	<20180926094219.20322-18-david@redhat.com>
	<9be6d517-615d-34ef-f6f4-4d478ef21944@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <4dbec139-f71e-ad41-e336-6621ffd6e4ac@redhat.com>
Date: Mon, 1 Oct 2018 10:36:10 +0200
MIME-Version: 1.0
In-Reply-To: <9be6d517-615d-34ef-f6f4-4d478ef21944@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 17/24] memory-device: add class function
 get_device_id()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, qemu-devel@nongnu.org
Cc: Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 30/09/2018 18:19, Auger Eric wrote:
> Hi David,
> 
> On 9/26/18 11:42 AM, David Hildenbrand wrote:
>> When reporting the id of virtio-based memory devices, we always have to
>> take the one of the proxy device (parent), not the one of the memory
>> device directly.
>>
>> Let's generalize this by allowing memory devices to specify an optional
>> "get_device_id" function. This id can then be used to report errors to the
>> user from memory-device.c code, without having to special case e.g.
>> virtio devices. Provide a default function that can be overridden.
>>
>> While at it, properly treat id == NULL and report "(unnamed)" instead.
>>
>> Details:
>>
>> When the user creates a virtio device (e.g.  virtio-balloon-pci), two
>> devices are actually created.
>>
>> 1. Virtio proxy device (e.g. TYPE_VIRTIO_BALLOON_PCI)
>> 2. The "real" virtio device (e.g. TYPE_VIRTIO_BALLOON).
>>
>> 1. aliases all properties of 2, so 2. can be properly configured using 1.
>> 1. gets the device ID set specified by the user. 2. gets no ID set.
> s/set// ?
>>
>> If we want to make 2. a MemoryDevice but report errors/information to the
> to be reworded?
>> user, we always have to report the id of 1. (because that's the device the
>> user instantiated and configured).

Both parts slightly reworded.

>>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/mem/memory-device.c         | 19 +++++++++++++++++--
>>  include/hw/mem/memory-device.h |  5 +++++
>>  2 files changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
>> index cf85199a72..6dc40e8764 100644
>> --- a/hw/mem/memory-device.c
>> +++ b/hw/mem/memory-device.c
>> @@ -174,8 +174,10 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
>>  
>>          if (ranges_overlap(md_addr, md_size, new_addr, size)) {
>>              if (hint) {
>> -                const DeviceState *d = DEVICE(md);
>> -                error_setg(errp, "address range conflicts with '%s'", d->id);
>> +                const char *id = mdc->get_device_id(md);
>> +
>> +                error_setg(errp, "address range conflicts with '%s'",
> address range conflicts with memory device id='%s"?

Yes, I can do that.

Thanks!


-- 

Thanks,

David / dhildenb
