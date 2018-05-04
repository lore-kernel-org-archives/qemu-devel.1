Received: from eggs.gnu.org ([2001:4830:134:3::10]:54592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fEZnu-0001Mp-8j
	for qemu-devel@nongnu.org; Fri, 04 May 2018 08:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fEZnp-00038l-Ay
	for qemu-devel@nongnu.org; Fri, 04 May 2018 08:27:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59998 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fEZnp-00034h-4Q
	for qemu-devel@nongnu.org; Fri, 04 May 2018 08:27:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 810F281A88AD
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 12:26:59 +0000 (UTC)
Date: Fri, 4 May 2018 13:26:51 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180504122651.GC2611@work-vm>
References: <20180420123456.22196-1-david@redhat.com>
	<20180423141928.7e64b380@redhat.com>
	<908f1079-385f-24d3-99ad-152ecd6b01d2@redhat.com>
	<20180424153154.05e79de7@redhat.com>
	<1046685642.22350584.1524635112123.JavaMail.zimbra@redhat.com>
	<20180425152356.46ee7e04@redhat.com>
	<709141862.22620677.1524664609218.JavaMail.zimbra@redhat.com>
	<20180425172639.3e4d8ca1@redhat.com>
	<212695685.22833607.1524728271984.JavaMail.zimbra@redhat.com>
	<20180504111323.7cb4c7c8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504111323.7cb4c7c8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/3] virtio-pmem: should we make it
 migratable???
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

* Igor Mammedov (imammedo@redhat.com) wrote:
> On Thu, 26 Apr 2018 03:37:51 -0400 (EDT)
> Pankaj Gupta <pagupta@redhat.com> wrote:
> 
> trimming CC list to keep people that might be interested in the topic
> and renaming thread to reflect it.
> 
> > > > > > > > >> +
> > > > > > > > >> +    memory_region_add_subregion(&hpms->mr, addr - hpms->base,
> > > > > > > > >> mr);  
> > > > > > > > > missing vmstate registration?  
> > > > > > > > 
> > > > > > > > Missed this one: To be called by the caller. Important because e.g.
> > > > > > > > for
> > > > > > > > virtio-pmem we don't want this (I assume :) ).  
> > > > > > > if pmem isn't on shared storage, then We'd probably want to migrate
> > > > > > > it as well, otherwise target would experience data loss.
> > > > > > > Anyways, I'd just reat it as normal RAM in migration case  
> > > > > > 
> > > > > > Main difference between RAM and pmem it acts like combination of RAM
> > > > > > and
> > > > > > disk.
> > > > > > Saying this, in normal use-case size would be 100 GB's - few TB's
> > > > > > range.
> > > > > > I am not sure we really want to migrate it for non-shared storage
> > > > > > use-case.  
> > > > > with non shared storage you'd have to migrate it target host but
> > > > > with shared storage it might be possible to flush it and use directly
> > > > > from target host. That probably won't work right out of box and would
> > > > > need some sort of synchronization between src/dst hosts.  
> > > > 
> > > > Shared storage should work out of the box.
> > > > Only thing is data in destination
> > > > host will be cache cold and existing pages in cache should be invalidated
> > > > first.
> > > > But if we migrate entire fake DAX RAMstate it will populate destination
> > > > host page
> > > > cache including pages while were idle in source host. This would
> > > > unnecessarily
> > > > create entropy in destination host.
> > > > 
> > > > To me this feature don't make much sense. Problem which we are solving is:
> > > > Efficiently use guest RAM.  
> > > What would live migration handover flow look like in case of
> > > guest constantly dirting memory provided by virtio-pmem and
> > > and sometimes issuing async flush req along with it?  
> > 
> > Dirty entire pmem (disk) at once not a usual scenario. Some part of disk/pmem
> > would get dirty and we need to handle that. I just want to say moving entire
> > pmem (disk) is not efficient solution because we are using this solution to
> > manage guest memory efficiently. Otherwise it will be like any block device copy
> > with non-shared storage.   
> not sure if we can use block layer analogy here.
> 
> > > > > The same applies to nv/pc-dimm as well, as backend file easily could be
> > > > > on pmem storage as well.  
> > > > 
> > > > Are you saying backing file is in actual actual nvdimm hardware? we don't
> > > > need
> > > > emulation at all.  
> > > depends on if file is on DAX filesystem, but your argument about
> > > migrating huge 100Gb- TB's range applies in this case as well.
> > >   
> > > >   
> > > > > 
> > > > > Maybe for now we should migrate everything so it would work in case of
> > > > > non shared NVDIMM on host. And then later add migration-less capability
> > > > > to all of them.  
> > > > 
> > > > not sure I agree.  
> > > So would you inhibit migration in case of non shared backend storage,
> > > to avoid loosing data since they aren't migrated?  
> > 
> > I am just thinking what features we want to support with pmem. And live migration
> > with shared storage is the one which comes to my mind.
> > 
> > If live migration with non-shared storage is what we want to support (I don't know
> > yet) we can add this? Even with shared storage it would copy entire pmem state?
> Perhaps we should register vmstate like for normal ram and use something similar to
>   http://lists.gnu.org/archive/html/qemu-devel/2018-04/msg00003.html this
> to skip shared memory on migration.
> In this case we could use this for pc-dimms as well.
> 
> David,
>  what's your take on it?

My feel is that something is going to have to migrate it, I'm just not
sure how.
So let me just check I understand:
  a) It's potentially huge
  b) It's a RAMBlock
  c) It's backed by ????
     c1) Something machine local - i.e. a physical lump of flash in a
         socket rather than something sharable by machines?
  d) It can potentially be rapidly changing as the guest writes to it?

Dave

> > Thanks,
> > Pankaj
> >  
> > > 
> > >   
> > > > > > One reason why nvdimm added vmstate info could be: still there would be
> > > > > > transient
> > > > > > writes in memory with fake DAX and there is no way(till now) to flush
> > > > > > the
> > > > > > guest
> > > > > > writes. But with virtio-pmem we can flush such writes before migration
> > > > > > and
> > > > > > automatically
> > > > > > at destination host with shared disk we will have updated data.  
> > > > > nvdimm has concept of flush address hint (may be not implemented in qemu
> > > > > yet)
> > > > > but it can flush. The only reason I'm buying into virtio-mem idea
> > > > > is that would allow async flush queues which would reduce number
> > > > > of vmexits.  
> > > > 
> > > > Thats correct.
> > > > 
> > > > Thanks,
> > > > Pankaj
> > > > 
> > > >    
> > > 
> > > 
> > >   
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
