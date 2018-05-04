Received: from eggs.gnu.org ([2001:4830:134:3::10]:48413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fEZNK-0002eU-QJ
	for qemu-devel@nongnu.org; Fri, 04 May 2018 07:59:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fEZNH-0004hd-H1
	for qemu-devel@nongnu.org; Fri, 04 May 2018 07:59:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1fEZNH-0004fm-8W
	for qemu-devel@nongnu.org; Fri, 04 May 2018 07:59:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6995130CB6EF
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 11:59:40 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E2D9601A3
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 11:59:40 +0000 (UTC)
Date: Fri, 4 May 2018 07:59:39 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <707535368.26497376.1525435179689.JavaMail.zimbra@redhat.com>
In-Reply-To: <0c67b8f1-163f-1f69-d2e0-cb50133af7d3@redhat.com>
References: <20180420123456.22196-1-david@redhat.com>
	<1046685642.22350584.1524635112123.JavaMail.zimbra@redhat.com>
	<20180425152356.46ee7e04@redhat.com>
	<709141862.22620677.1524664609218.JavaMail.zimbra@redhat.com>
	<20180425172639.3e4d8ca1@redhat.com>
	<212695685.22833607.1524728271984.JavaMail.zimbra@redhat.com>
	<20180504111323.7cb4c7c8@redhat.com>
	<0c67b8f1-163f-1f69-d2e0-cb50133af7d3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: David Hildenbrand <david@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>



> > 
> >>>>>>>>>> +
> >>>>>>>>>> +    memory_region_add_subregion(&hpms->mr, addr - hpms->base,
> >>>>>>>>>> mr);
> >>>>>>>>> missing vmstate registration?
> >>>>>>>>
> >>>>>>>> Missed this one: To be called by the caller. Important because e.g.
> >>>>>>>> for
> >>>>>>>> virtio-pmem we don't want this (I assume :) ).
> >>>>>>> if pmem isn't on shared storage, then We'd probably want to migrate
> >>>>>>> it as well, otherwise target would experience data loss.
> >>>>>>> Anyways, I'd just reat it as normal RAM in migration case
> >>>>>>
> >>>>>> Main difference between RAM and pmem it acts like combination of RAM
> >>>>>> and
> >>>>>> disk.
> >>>>>> Saying this, in normal use-case size would be 100 GB's - few TB's
> >>>>>> range.
> >>>>>> I am not sure we really want to migrate it for non-shared storage
> >>>>>> use-case.
> >>>>> with non shared storage you'd have to migrate it target host but
> >>>>> with shared storage it might be possible to flush it and use directly
> >>>>> from target host. That probably won't work right out of box and would
> >>>>> need some sort of synchronization between src/dst hosts.
> >>>>
> >>>> Shared storage should work out of the box.
> >>>> Only thing is data in destination
> >>>> host will be cache cold and existing pages in cache should be
> >>>> invalidated
> >>>> first.
> >>>> But if we migrate entire fake DAX RAMstate it will populate destination
> >>>> host page
> >>>> cache including pages while were idle in source host. This would
> >>>> unnecessarily
> >>>> create entropy in destination host.
> >>>>
> >>>> To me this feature don't make much sense. Problem which we are solving
> >>>> is:
> >>>> Efficiently use guest RAM.
> >>> What would live migration handover flow look like in case of
> >>> guest constantly dirting memory provided by virtio-pmem and
> >>> and sometimes issuing async flush req along with it?
> >>
> >> Dirty entire pmem (disk) at once not a usual scenario. Some part of
> >> disk/pmem
> >> would get dirty and we need to handle that. I just want to say moving
> >> entire
> >> pmem (disk) is not efficient solution because we are using this solution
> >> to
> >> manage guest memory efficiently. Otherwise it will be like any block
> >> device copy
> >> with non-shared storage.
> > not sure if we can use block layer analogy here.
> > 
> >>>>> The same applies to nv/pc-dimm as well, as backend file easily could be
> >>>>> on pmem storage as well.
> >>>>
> >>>> Are you saying backing file is in actual actual nvdimm hardware? we
> >>>> don't
> >>>> need
> >>>> emulation at all.
> >>> depends on if file is on DAX filesystem, but your argument about
> >>> migrating huge 100Gb- TB's range applies in this case as well.
> >>>   
> >>>>   
> >>>>>
> >>>>> Maybe for now we should migrate everything so it would work in case of
> >>>>> non shared NVDIMM on host. And then later add migration-less capability
> >>>>> to all of them.
> >>>>
> >>>> not sure I agree.
> >>> So would you inhibit migration in case of non shared backend storage,
> >>> to avoid loosing data since they aren't migrated?
> >>
> >> I am just thinking what features we want to support with pmem. And live
> >> migration
> >> with shared storage is the one which comes to my mind.
> >>
> >> If live migration with non-shared storage is what we want to support (I
> >> don't know
> >> yet) we can add this? Even with shared storage it would copy entire pmem
> >> state?
> > Perhaps we should register vmstate like for normal ram and use something
> > similar to
> >   http://lists.gnu.org/archive/html/qemu-devel/2018-04/msg00003.html this
> > to skip shared memory on migration.
> > In this case we could use this for pc-dimms as well.
> > 
> > David,
> >  what's your take on it?
> 
> (I assume you were talking to David Gilbert, but still my take on it :))
> 
> "shared RAM" use in that context is rather "shared between processes",
> no? What would be the benefit of enabling migration for a ramblock but
> then again blocking it off?
> 
> Anyhow, I think this detail discussion is way to early right now. Pankaj
> has some other problems to solve before moving on to migration (yes,
> migration is important to keep in mind but not the top priority right
> now). And I would consider migration in this context as the next step
> once we have the basics sorted out (flushing, threads ...)

Right. Still it would be very helpful to have Dave Gilbert's inputs on 
this ongoing discussion. That would clear some doubts regarding expectation 
for this type of memory from live migration point of view.

Then we can discuss in more details after we have first version accepted 
and start optimization for live migration. 

Thanks,
Pankaj
