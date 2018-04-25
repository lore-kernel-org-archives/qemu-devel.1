Received: from eggs.gnu.org ([2001:4830:134:3::10]:40058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fBKP2-0003PH-UD
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:24:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fBKOz-0000LG-Pl
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:24:08 -0400
Date: Wed, 25 Apr 2018 15:23:56 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180425152356.46ee7e04@redhat.com>
In-Reply-To: <1046685642.22350584.1524635112123.JavaMail.zimbra@redhat.com>
References: <20180420123456.22196-1-david@redhat.com>
	<20180420123456.22196-4-david@redhat.com>
	<20180423141928.7e64b380@redhat.com>
	<908f1079-385f-24d3-99ad-152ecd6b01d2@redhat.com>
	<20180424153154.05e79de7@redhat.com>
	<1046685642.22350584.1524635112123.JavaMail.zimbra@redhat.com>
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
To: Pankaj Gupta <pagupta@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Wed, 25 Apr 2018 01:45:12 -0400 (EDT)
Pankaj Gupta <pagupta@redhat.com> wrote:

> >   
> > > >     
> > > >> +    /* we will need a new memory slot for kvm and vhost */
> > > >> +    if (kvm_enabled() && !kvm_has_free_slot(machine)) {
> > > >> +        error_setg(errp, "hypervisor has no free memory slots left");
> > > >> +        return;
> > > >> +    }
> > > >> +    if (!vhost_has_free_slot()) {
> > > >> +        error_setg(errp, "a used vhost backend has no free memory slots
> > > >> left");
> > > >> +        return;
> > > >> +    }  
> > > > move these checks to pre_plug time
> > > >     
> > > >> +
> > > >> +    memory_region_add_subregion(&hpms->mr, addr - hpms->base, mr);  
> > > > missing vmstate registration?  
> > > 
> > > Missed this one: To be called by the caller. Important because e.g. for
> > > virtio-pmem we don't want this (I assume :) ).  
> > if pmem isn't on shared storage, then We'd probably want to migrate
> > it as well, otherwise target would experience data loss.
> > Anyways, I'd just reat it as normal RAM in migration case  
> 
> Main difference between RAM and pmem it acts like combination of RAM and disk.
> Saying this, in normal use-case size would be 100 GB's - few TB's range. 
> I am not sure we really want to migrate it for non-shared storage use-case.
with non shared storage you'd have to migrate it target host but
with shared storage it might be possible to flush it and use directly
from target host. That probably won't work right out of box and would
need some sort of synchronization between src/dst hosts.

The same applies to nv/pc-dimm as well, as backend file easily could be
on pmem storage as well.

Maybe for now we should migrate everything so it would work in case of
non shared NVDIMM on host. And then later add migration-less capability
to all of them.

> One reason why nvdimm added vmstate info could be: still there would be transient
> writes in memory with fake DAX and there is no way(till now) to flush the guest 
> writes. But with virtio-pmem we can flush such writes before migration and automatically
> at destination host with shared disk we will have updated data.
nvdimm has concept of flush address hint (may be not implemented in qemu yet)
but it can flush. The only reason I'm buying into virtio-mem idea
is that would allow async flush queues which would reduce number
of vmexits.

> 
> 
> Thanks,
> Pankaj  
> 
> 
