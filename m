Received: from eggs.gnu.org ([2001:4830:134:3::10]:42409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fT83E-0005Jt-M4
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 11:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fT83D-0001Gr-I9
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 11:51:12 -0400
References: <20180530150806.061c26b9@redhat.com>
	<5dcb16e5-b9b9-d07d-dfe3-98724e911f83@redhat.com>
	<20180531161310.52ea9507@redhat.com>
	<e451e0d6-a181-b027-cdb7-f44beb11b37c@redhat.com>
	<20180607154455.6eab4e24@redhat.com>
	<5dda6237-88d8-f0f8-58d2-af996368cea4@redhat.com>
	<20180608142442.0d97b7c6@redhat.com>
	<397d37ee-b3a8-dae0-37d1-fd3c942448c2@redhat.com>
	<20180608155432-mutt-send-email-mst@kernel.org>
	<d6966aa8-54e5-8036-3603-069fbbb88c2a@redhat.com>
	<20180608181004-mutt-send-email-mst@kernel.org>
	<a68853da-a664-84ae-c5bd-4e79b967bb65@redhat.com>
	<20180613174825.1eebef6c@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c84ffb85-628f-4ece-e231-d0d7d45144c9@redhat.com>
Date: Wed, 13 Jun 2018 17:51:01 +0200
MIME-Version: 1.0
In-Reply-To: <20180613174825.1eebef6c@redhat.com>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>

On 13.06.2018 17:48, Igor Mammedov wrote:
> On Wed, 13 Jun 2018 12:58:46 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 08.06.2018 17:12, Michael S. Tsirkin wrote:
>>> On Fri, Jun 08, 2018 at 03:07:53PM +0200, David Hildenbrand wrote:  
>>>> On 08.06.2018 14:55, Michael S. Tsirkin wrote:  
>>>>> On Fri, Jun 08, 2018 at 02:32:09PM +0200, David Hildenbrand wrote:  
>>>>>>  
>>>>>>>>> if (TYPE_PC_DIMM) {
>>>>>>>>>     pc_dimm_plug()
>>>>>>>>>     /* do here additional concrete machine specific things */
>>>>>>>>> } else if (TYPE_VIRTIO_MEM) {
>>>>>>>>>     virtio_mem_plug() <- do forwarding in there
>>>>>>>>>     /* and do here additional concrete machine specific things */
>>>>>>>>> } else if (TYPE_CPU) {
>>>>>>>>>     cpu_plug()
>>>>>>>>>     /* do here additional concrete machine specific things */
>>>>>>>>> }    
>>>>>>>>
>>>>>>>> That will result in a lot of duplicate code - for every machine we
>>>>>>>> support (dimm/virtio-mem/virtio-pmem/*add more memory devices here*) -
>>>>>>>> virtio-mem and virtio-pmem could most probably share the code.  
>>>>>>> maybe or maybe not, depending on if pmem endups as memory device or
>>>>>>> separate controller. And even with duplication, machine code would
>>>>>>> be easy to follow just down one explicit call chain.  
>>>>>>
>>>>>> Not 100% convinced but I am now going into that direction.  
>>>>>
>>>>> Can this go into DeviceClass? Failover has the same need to
>>>>> allocate/free resources for vfio without a full realize/unrealize.
>>>>>  
>>>>
>>>> Conceptually, I would have called here something like
>>>>
>>>> virtio_mem_plug() ...
>>>>
>>>> Which would end up calling memory_device_plug() and triggering the
>>>> target hotplug handler.
>>>>
>>>> I assume this can also be done from a device class callback.
>>>>
>>>> So we would need a total of 3 callbacks for
>>>>
>>>> a) pre_plug
>>>> b) plug
>>>> c) unplug
>>>>
>>>> In addition, unplug requests might be necessary, so
>>>>
>>>> d) unplug_request  
>>>
>>>
>>> Right - basically HotplugHandlerClass.  
>>
>> Looking into this idea:
>>
>> What I would have right now (conceptually)
>>
>> if (TYPE_PC_DIMM) {
>>     pc_dimm_plug(machine);
>> } else if (TYPE_CPU) {
>>     cpu_plug(machine);
>> } else if (TYPE_VIRTIO_MEM) {
>>     virtio_mem_plug(machine);
>> }
>>
>> Instead you want something like:
>>
>> if (TYPE_PC_DIMM) {
>>     pc_dimm_plug(machine);
>> } else if (TYPE_CPU) {
>>     cpu_plug(machine);
>> // igor requested an explicit list here, we could also check for
>> // DEVICE_CLASS(device)->plug and make it generic
>> } else if (TYPE_VIRTIO_MEM) {
>>     DEVICE_CLASS(device)->plug(machine);
>>     // call bus hotplug handler if necessary, or let the previous call
>>     // handle it?
> not exactly this, I suggested following:
> 
>       [ ... specific to machine_foo wiring ...]
> 
>       virtio_mem_plug() {
>          [... some machine specific wiring ...]
> 
>          bus_hotplug_ctrl = qdev_get_bus_hotplug_handler()
>          bus_hotplug_ctrl->plug(bus_hotplug_ctrl, dev)
> 
>          [... some more machine specific wiring ...]
>       }
> 
>       [ ... specific to machine_foo wiring ...]
> 
> i.e. device itself doesn't participate in attaching to external entities,
> those entities (machine or bus controller virtio device is attached to)
> do wiring on their own within their own domain.

I am fine with this, but Michael asked if this ("virtio_mem_plug()")
could go via new DeviceClass functions. Michael, would that also work
for your use case?


-- 

Thanks,

David / dhildenb
