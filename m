Received: from eggs.gnu.org ([2001:4830:134:3::10]:38581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fBDF0-0002Kb-H7
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 01:45:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fBDEx-0002vP-Ef
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 01:45:18 -0400
Date: Wed, 25 Apr 2018 01:45:12 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <1046685642.22350584.1524635112123.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180424153154.05e79de7@redhat.com>
References: <20180420123456.22196-1-david@redhat.com>
	<20180420123456.22196-4-david@redhat.com>
	<20180423141928.7e64b380@redhat.com>
	<908f1079-385f-24d3-99ad-152ecd6b01d2@redhat.com>
	<20180424153154.05e79de7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: David Hildenbrand <david@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>


> 
> > >   
> > >> +    /* we will need a new memory slot for kvm and vhost */
> > >> +    if (kvm_enabled() && !kvm_has_free_slot(machine)) {
> > >> +        error_setg(errp, "hypervisor has no free memory slots left");
> > >> +        return;
> > >> +    }
> > >> +    if (!vhost_has_free_slot()) {
> > >> +        error_setg(errp, "a used vhost backend has no free memory slots
> > >> left");
> > >> +        return;
> > >> +    }
> > > move these checks to pre_plug time
> > >   
> > >> +
> > >> +    memory_region_add_subregion(&hpms->mr, addr - hpms->base, mr);
> > > missing vmstate registration?
> > 
> > Missed this one: To be called by the caller. Important because e.g. for
> > virtio-pmem we don't want this (I assume :) ).
> if pmem isn't on shared storage, then We'd probably want to migrate
> it as well, otherwise target would experience data loss.
> Anyways, I'd just reat it as normal RAM in migration case

Main difference between RAM and pmem it acts like combination of RAM and disk.
Saying this, in normal use-case size would be 100 GB's - few TB's range. 
I am not sure we really want to migrate it for non-shared storage use-case.

One reason why nvdimm added vmstate info could be: still there would be transient
writes in memory with fake DAX and there is no way(till now) to flush the guest 
writes. But with virtio-pmem we can flush such writes before migration and automatically
at destination host with shared disk we will have updated data.


Thanks,
Pankaj  
