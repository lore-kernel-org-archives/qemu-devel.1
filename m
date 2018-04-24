Received: from eggs.gnu.org ([2001:4830:134:3::10]:43233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fAy3A-00019Y-2l
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 09:32:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fAy34-0003Fy-FF
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 09:32:04 -0400
Date: Tue, 24 Apr 2018 15:31:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180424153154.05e79de7@redhat.com>
In-Reply-To: <908f1079-385f-24d3-99ad-152ecd6b01d2@redhat.com>
References: <20180420123456.22196-1-david@redhat.com>
	<20180420123456.22196-4-david@redhat.com>
	<20180423141928.7e64b380@redhat.com>
	<908f1079-385f-24d3-99ad-152ecd6b01d2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: David Hildenbrand <david@redhat.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Mon, 23 Apr 2018 14:52:37 +0200
David Hildenbrand <david@redhat.com> wrote:

> >   
> >> +    /* we will need a new memory slot for kvm and vhost */
> >> +    if (kvm_enabled() && !kvm_has_free_slot(machine)) {
> >> +        error_setg(errp, "hypervisor has no free memory slots left");
> >> +        return;
> >> +    }
> >> +    if (!vhost_has_free_slot()) {
> >> +        error_setg(errp, "a used vhost backend has no free memory slots left");
> >> +        return;
> >> +    }  
> > move these checks to pre_plug time
> >   
> >> +
> >> +    memory_region_add_subregion(&hpms->mr, addr - hpms->base, mr);  
> > missing vmstate registration?  
> 
> Missed this one: To be called by the caller. Important because e.g. for
> virtio-pmem we don't want this (I assume :) ).
if pmem isn't on shared storage, then We'd probably want to migrate
it as well, otherwise target would experience data loss.
Anyways, I'd just reat it as normal RAM in migration case

> 
> Thanks!
> 
> 
