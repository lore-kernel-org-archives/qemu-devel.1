Received: from eggs.gnu.org ([2001:4830:134:3::10]:40199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fAaxb-0006Mi-F4
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fAaxY-00053W-DH
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:52:47 -0400
References: <20180420123456.22196-1-david@redhat.com>
	<20180420123456.22196-4-david@redhat.com>
	<20180423141928.7e64b380@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <908f1079-385f-24d3-99ad-152ecd6b01d2@redhat.com>
Date: Mon, 23 Apr 2018 14:52:37 +0200
MIME-Version: 1.0
In-Reply-To: <20180423141928.7e64b380@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/3] pc-dimm: factor out address space
 logic into MemoryDevice code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>


> 
>> +    /* we will need a new memory slot for kvm and vhost */
>> +    if (kvm_enabled() && !kvm_has_free_slot(machine)) {
>> +        error_setg(errp, "hypervisor has no free memory slots left");
>> +        return;
>> +    }
>> +    if (!vhost_has_free_slot()) {
>> +        error_setg(errp, "a used vhost backend has no free memory slots left");
>> +        return;
>> +    }
> move these checks to pre_plug time
> 
>> +
>> +    memory_region_add_subregion(&hpms->mr, addr - hpms->base, mr);
> missing vmstate registration?

Missed this one: To be called by the caller. Important because e.g. for
virtio-pmem we don't want this (I assume :) ).

Thanks!


-- 

Thanks,

David / dhildenb
