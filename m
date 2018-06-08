Received: from eggs.gnu.org ([2001:4830:134:3::10]:56413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fRH7a-0004oW-Hz
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 09:08:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fRH7V-0006QI-To
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 09:08:02 -0400
References: <20180517081527.14410-1-david@redhat.com>
	<20180517081527.14410-5-david@redhat.com>
	<20180530150806.061c26b9@redhat.com>
	<5dcb16e5-b9b9-d07d-dfe3-98724e911f83@redhat.com>
	<20180531161310.52ea9507@redhat.com>
	<e451e0d6-a181-b027-cdb7-f44beb11b37c@redhat.com>
	<20180607154455.6eab4e24@redhat.com>
	<5dda6237-88d8-f0f8-58d2-af996368cea4@redhat.com>
	<20180608142442.0d97b7c6@redhat.com>
	<397d37ee-b3a8-dae0-37d1-fd3c942448c2@redhat.com>
	<20180608155432-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d6966aa8-54e5-8036-3603-069fbbb88c2a@redhat.com>
Date: Fri, 8 Jun 2018 15:07:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180608155432-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 04/14] pc: prepare for multi stage
 hotplug handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>

On 08.06.2018 14:55, Michael S. Tsirkin wrote:
> On Fri, Jun 08, 2018 at 02:32:09PM +0200, David Hildenbrand wrote:
>>
>>>>> if (TYPE_PC_DIMM) {
>>>>>     pc_dimm_plug()
>>>>>     /* do here additional concrete machine specific things */
>>>>> } else if (TYPE_VIRTIO_MEM) {
>>>>>     virtio_mem_plug() <- do forwarding in there
>>>>>     /* and do here additional concrete machine specific things */
>>>>> } else if (TYPE_CPU) {
>>>>>     cpu_plug()
>>>>>     /* do here additional concrete machine specific things */
>>>>> }  
>>>>
>>>> That will result in a lot of duplicate code - for every machine we
>>>> support (dimm/virtio-mem/virtio-pmem/*add more memory devices here*) -
>>>> virtio-mem and virtio-pmem could most probably share the code.
>>> maybe or maybe not, depending on if pmem endups as memory device or
>>> separate controller. And even with duplication, machine code would
>>> be easy to follow just down one explicit call chain.
>>
>> Not 100% convinced but I am now going into that direction.
> 
> Can this go into DeviceClass? Failover has the same need to
> allocate/free resources for vfio without a full realize/unrealize.
> 

Conceptually, I would have called here something like

virtio_mem_plug() ...

Which would end up calling memory_device_plug() and triggering the
target hotplug handler.

I assume this can also be done from a device class callback.

So we would need a total of 3 callbacks for

a) pre_plug
b) plug
c) unplug

In addition, unplug requests might be necessary, so

d) unplug_request

>> -- 
>>
>> Thanks,
>>
>> David / dhildenb


-- 

Thanks,

David / dhildenb
