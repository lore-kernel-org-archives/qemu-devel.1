Received: from eggs.gnu.org ([2001:4830:134:3::10]:37799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fBKGx-0007hV-4u
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fBKGu-0005dC-0s
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:15:47 -0400
From: David Hildenbrand <david@redhat.com>
References: <20180420123456.22196-1-david@redhat.com>
	<20180423143147.6b4df2ac@redhat.com>
	<459116211.21924603.1524497545197.JavaMail.zimbra@redhat.com>
	<20180424160011.47475594@redhat.com>
	<a048d777-38e5-a44a-c401-a5509ca29e37@redhat.com>
	<20180425141535.5000bcb8@redhat.com>
	<50c25d28-4cac-1e68-c149-e7a5ba8b0f40@redhat.com>
Message-ID: <04f968d4-cc3d-1b7b-3d70-f75014ba2742@redhat.com>
Date: Wed, 25 Apr 2018 15:15:32 +0200
MIME-Version: 1.0
In-Reply-To: <50c25d28-4cac-1e68-c149-e7a5ba8b0f40@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] pc-dimm: factor out MemoryDevice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>


>>> So this happens before any hotplug handler is called. Everything works
>>> just fine. What you don't like about this is the qdev_get_machine(). I
>>> also don't like it but in the short term I don't see any problem with
>>> it. It is resource allocation and not a "device plug" in the typical form.
>>
>> It's not qdev_get_machine() that's issue, it's layer violation,
>> where child device is allocating and mapping resources of one of its parents.
> 
> Quite simple: introduce a function at the machine where the child can
> "request" to get an address and "request" to plug/unplug a region.
> 
> Or what would be wrong about that?
> 

To extend on such an idea (looking at virtio_bus_device_plugged()
getting called from virtio realize functions)

Make the machine implement some new interface "MemoryDeviceManager".
>From virtio-mem/pmem realize, call a function like memory_device_plugged().

Lookup the machine (qdev_get_machine() or walk all the way up until we
find one that implements MemoryDeviceManager) and call
pre_plugged/plugged/unplugged.

We could hide that in a new device class TYPE_VIRTIO_MEMORY_DEVICE.

Opinions? Completely nonsense? :) Alternatives?

-- 

Thanks,

David / dhildenb
