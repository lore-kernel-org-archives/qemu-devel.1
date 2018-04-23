Received: from eggs.gnu.org ([2001:4830:134:3::10]:44999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fAeRu-0002fD-NV
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fAeRr-0006Tu-Kh
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:36:18 -0400
References: <20180420123456.22196-1-david@redhat.com>
	<20180423143147.6b4df2ac@redhat.com>
	<459116211.21924603.1524497545197.JavaMail.zimbra@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <34c59acd-6222-a8be-bb60-3567d2e71502@redhat.com>
Date: Mon, 23 Apr 2018 18:35:55 +0200
MIME-Version: 1.0
In-Reply-To: <459116211.21924603.1524497545197.JavaMail.zimbra@redhat.com>
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
To: Pankaj Gupta <pagupta@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>

On 23.04.2018 17:32, Pankaj Gupta wrote:
> 
> Hi Igor,
> 
>>
>>> Right now we can only map PCDIMM/NVDIMM into guest address space. In the
>>> future, we might want to do the same for virtio devices - e.g.
>>> virtio-pmem or virtio-mem. Especially, they should be able to live side
>>> by side to each other.
>>>
>>> E.g. the virto based memory devices regions will not be exposed via ACPI
>>> and friends. They will be detected just like other virtio devices and
>>> indicate the applicable memory region. This makes it possible to also use
>>> them on architectures without memory device detection support (e.g. s390x).
>>>
>>> Let's factor out the memory device code into a MemoryDevice interface.
>> A couple of high level questions as relevant code is not here:
>>
>>   1. what would hotplug/unplug call chain look like in case of virtio-pmem
>>   device
>>      (reason I'm asking is that pmem being PCI device would trigger
>>       PCI bus hotplug controller and then it somehow should piggyback
>>       to Machine provided hotplug handlers, so I wonder what kind of
>>       havoc it would cause on hotplug infrastructure)
> 
> For first phase we are using 'virtio-pmem' as cold added devices. AFAIU
> 'VirtioDeviceClass' being parent class and 'hotplug/unplug' methods implemented 
> for virtio-pmem device. So, pci bus hotplug/unplug should call the corresponding
> functions?
> 
>>
>>   2. why not use PCI bar mapping mechanism to do mapping since pmem is PCI
>>   device?
> 
> I think even we use if as PCI BAR mapping with PCI we still need free guest physical 
> address to provide to VM for mapping the memory range. For that there needs to 
> be coordination between PCDIMM and VIRTIO pci device? Also, if we use RAM from QEMU 
> address space tied to big region(system_memory) memory accounting gets easier and at single place.
> 
> Honestly speaking I don't think there will be much difference between the two approaches? unless
> I am missing something important?

The difference by gluing virtio devices to architecture specific
technologies will be unnecessary complicated. (my humble opinion)

-- 

Thanks,

David / dhildenb
