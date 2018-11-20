Received: from eggs.gnu.org ([2001:4830:134:3::10]:41570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gP76d-0007O8-2U
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:34:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gP76Z-0001qn-7U
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:34:22 -0500
References: <20181105102044.20547-1-david@redhat.com>
	<20181105102044.20547-10-david@redhat.com>
	<20181119180934.08f4570c@redhat.com>
	<90a755cf-bee5-fcbb-b1ff-0ed3cfff960d@redhat.com>
	<20181120151345.667f6b7b@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b6d7d705-87e7-7a6a-0343-5dd64c1ef1be@redhat.com>
Date: Tue, 20 Nov 2018 15:34:10 +0100
MIME-Version: 1.0
In-Reply-To: <20181120151345.667f6b7b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 09/10] pci/shpc: perform unplug via the
 hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

On 20.11.18 15:13, Igor Mammedov wrote:
> On Tue, 20 Nov 2018 11:11:46 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>>>> diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
>>>> index c634353b06..7c667bc97c 100644
>>>> --- a/hw/pci-bridge/pcie_pci_bridge.c
>>>> +++ b/hw/pci-bridge/pcie_pci_bridge.c
>>>> @@ -150,6 +150,19 @@ static void pcie_pci_bridge_plug_cb(HotplugHandler *hotplug_dev,
>>>>      shpc_device_plug_cb(hotplug_dev, dev, errp);
>>>>  }
>>>>  
>>>> +static void pcie_pci_bridge_unplug_cb(HotplugHandler *hotplug_dev,
>>>> +                                      DeviceState *dev, Error **errp)
>>>> +{
>>>> +    PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
>>>> +
>>>> +    if (!shpc_present(pci_hotplug_dev)) {
>>>> +        error_setg(errp, "standard hotplug controller has been disabled for "
>>>> +                   "this %s", TYPE_PCIE_PCI_BRIDGE_DEV);  
>>> Is it possible to reach here at all?  
>>
>> Right, this should right now not be possible. I'll turn this into an
>>
>> g_assert(shpc_present(pci_hotplug_dev));
>>
>> (if we every support surprise removal, we'll have to rethink either way)
>>
>>>   
>>>> +        return;
>>>> +    }
>>>> +    shpc_device_unplug_cb(hotplug_dev, dev, errp);
>>>> +}  
>>>
>>> you probably can share this function impl. with pci_bridge_dev_unplug_cb()
>>> if you use object_get_typename().  
>>
>> The same holds for all three functions (+ later pre_plug), however can
>> we be sure there won't be differences in the near future?
>>
>> If we don't expect these functions to differ, I can add a patch to
>> factor the existing two functions (plug/unplug) out.
> I'm not sure if they will differ or not in future,
> but right now it looks as premature splitting.
> It might be better to have a single function now and split it later
> when it is necessary.
> 

Indeed, I already went ahead and sent a new version including the
suggested re-factoring.

Thanks!

-- 

Thanks,

David / dhildenb
