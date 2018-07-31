Received: from eggs.gnu.org ([2001:4830:134:3::10]:54618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fkWBR-00010j-38
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 11:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fkWBN-0003vl-Mt
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 11:03:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fkWBN-0003vH-Ew
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 11:03:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD2A9C0587F5
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 15:03:28 +0000 (UTC)
Date: Tue, 31 Jul 2018 12:03:22 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180731150322.GB12380@localhost.localdomain>
References: <1532943701-83614-1-git-send-email-imammedo@redhat.com>
	<20180730202624.GN12380@localhost.localdomain>
	<20180731115340.62149ddc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731115340.62149ddc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-3.0 v2] pc: acpi: fix memory hotplug
 regression by reducing stub SRAT entry size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com

On Tue, Jul 31, 2018 at 11:53:40AM +0200, Igor Mammedov wrote:
> On Mon, 30 Jul 2018 17:26:24 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Mon, Jul 30, 2018 at 11:41:41AM +0200, Igor Mammedov wrote:
> > > Commit 848a1cc1e (hw/acpi-build: build SRAT memory affinity structures for DIMM devices)
> > > broke the first dimm hotplug in following cases:
> > > 
> > >  1: there is no coldplugged dimm in the last numa node
> > >     but there is a coldplugged dimm in another node
> > > 
> > >   -m 4096,slots=4,maxmem=32G               \
> > >   -object memory-backend-ram,id=m0,size=2G \
> > >   -device pc-dimm,memdev=m0,node=0         \
> > >   -numa node,nodeid=0                      \
> > >   -numa node,nodeid=1
> > > 
> > >  2: if order of dimms on CLI is:
> > >        1st plugged dimm in node1
> > >        2nd plugged dimm in node0
> > > 
> > >   -m 4096,slots=4,maxmem=32G               \
> > >   -object memory-backend-ram,size=2G,id=m0 \
> > >   -device pc-dimm,memdev=m0,node=1         \
> > >   -object memory-backend-ram,id=m1,size=2G \
> > >   -device pc-dimm,memdev=m1,node=0         \
> > >   -numa node,nodeid=0                      \
> > >   -numa node,nodeid=1
> > > 
> > > (qemu) object_add memory-backend-ram,id=m2,size=1G
> > > (qemu) device_add pc-dimm,memdev=m2,node=0
> > > 
> > > the first DIMM hotplug to any node except the last one
> > > fails (Windows is unable to online it).
> > > 
> > > Length reduction of stub hotplug memory SRAT entry,
> > > fixes issue for some reason.
> > >   
> > 
> > I'm really bothered by the lack of automated testing for all
> > these NUMA/ACPI corner cases.
> > 
> > This looks like a good candidate for an avocado_qemu test case.
> > Can you show pseudo-code of how exactly the bug fix could be
> > verified, so we can try to write a test case?
> Sadly I do it manually every time I'm suspect a patch would
> affect the feature. On just has to check if a new memory device
> appeared in device manager and it is in working state (started successfully).
> One also need to run it against to test it against windows version
> that supports memory hot-add (DC ed.).
> 
> It's typically what RHEL QE does, and they just found
> a new case which wasn't on test list so proactive measures
> wouldn't work here in any case as we didn't know about
> this particular combination.
> 
> I'm not sure how it will work with upstream avocado though,
> windows testing implies tester would need access to MSDN
> subscription or multiple retail versions to test against.
> So with windows it becomes expensive and complicated
> hence I'd leave this job to QE which has resources and
> upstream would benefit from downstream when a bug is found
> (albeit it's a catch up game).

I don't mean functional testing of Windows guests.  I'm just
looking for a way we can ensure we won't reintroduce this
particular bug later.  We should be able to encode known
requirements of existing guest OSes in test code (especially the
undocumented requirements).

In other words, we need test code that will check if the entry
you are adding below is still present and contains the right
flags, so people won't remove it by mistake.


[...]
> > > @@ -2269,7 +2269,16 @@ static void build_srat_hotpluggable_memory(GArray *table_data, uint64_t base,
> > >          numamem = acpi_data_push(table_data, sizeof *numamem);
> > >  
> > >          if (!info) {
> > > -            build_srat_memory(numamem, cur, end - cur, default_node,
> > > +            /*
> > > +             * Entry is required for Windows to enable memory hotplug in OS
> > > +             * and for Linux to enable SWIOTLB when booted with less than
> > > +             * 4G of RAM. Windows works better if the entry sets proximity
> > > +             * to the highest NUMA node in the machine at the end of the
> > > +             * reserved space.
> > > +             * Memory devices may override proximity set by this entry,
> > > +             * providing _PXM method if necessary.
> > > +             */
> > > +            build_srat_memory(numamem, end - 1, 1, default_node,
> > >                                MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
> > >              break;
> > >          }

-- 
Eduardo
