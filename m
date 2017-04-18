Received: from eggs.gnu.org ([2001:4830:134:3::10]:41497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d0NY1-000501-CG
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 03:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d0NXy-0005HX-4p
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 03:27:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d0NXx-0005HQ-SJ
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 03:27:34 -0400
Date: Tue, 18 Apr 2017 15:27:17 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170418072717.GD22226@pxdev.xzpeter.org>
References: <1492428730-13438-1-git-send-email-peterx@redhat.com>
	<1492428730-13438-8-git-send-email-peterx@redhat.com>
	<A2975661238FB949B60364EF0F2C257439054049@shsmsx102.ccr.corp.intel.com>
	<20170418045400.GC22226@pxdev.xzpeter.org>
	<A2975661238FB949B60364EF0F2C2574390540D1@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C2574390540D1@shsmsx102.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 7/7] intel_iommu: support passthrough
 (PT)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Tue, Apr 18, 2017 at 06:02:44AM +0000, Liu, Yi L wrote:
> > > Hi Peter,
> > >
> > > Skip address space switching is a good idea to support Passthru mode.
> > > However, without the address space, the vfio notifier would not be
> > > registered, thus vIOMMU emulator has no way to connect to host. It is
> > > no harm if there is only map/unmap notifier. But if we have more
> > > notifiers other than map/unmap, it may be a problem.
> > >
> > > I think we need to reconsider it here.
> > 
> > For now I think as switching is good to us in general. Could I know more context
> > about this? Would it be okay to work on top of this in the future?
> > 
> 
> Let me explain. For vSVM enabling, it needs to add new notifier to bind gPASID table
> to host. If an assigned device uses SVM in guest, as designed guest IOMMU driver would
> set "pt" for it. This is to make sure the host second-level page table stores GPA->HPA
> mapping. So that pIOMMU can do nested translation to achieve gVA->GPA GPA->HPA 
> mapping.

That should mean that in the guest it will only enable first level
translation, while in the host it'll be nested (first + second)? Then
you should be trapping the guest extended context entry invalidation,
then pass the PASID table pointer downward to the host IOMMU, am I
correct?

> 
> So the situation is if we want to keep GPA->HPA mapping, we should skip address space
> switch, but the vfio listener would not know vIOMMU is added, so no vfio notifier would
> be registered. But if we do the switch, the GPA->HPA mapping is unmapped. And need
> another way to build the GPA->HPA mapping.

If my understanding above is correct, current IOMMU notifier may not
satisfy your need. If you see the current notify interface, it's
delivering IOMMUTLBEntry. I suspect it only suites for IOTLB
notifications, but not if you want to pass some pointer (one GPA)
downward somewhere.

> 
> I think we may have two choice here. Pls let me know your ideas.
> 
> 1. skip the switch for "pt" mode, find other way to register vfio notifiers. not sure if this
> is workable. Just a quick thought.
> 
> 2. do the switch, and rebuild GPA->HPA mapping if device use "pt" mode. For this option,
> I also have two way to build the GPA->HPA mapping.
> a) walk all the memory region sections in address_space_memory, and build the mapping.
> address_space_memory.dispatch->map.sections, sections stores all the mapped sections.
> 
> b) let guest iommu driver mimics a 1:1 mapping for the devices use "pt" mode. in this way,
> the GPA->HPA mapping could be setup by walking the guest SL page table. This is consistent
> with your vIOVA replay solution.

I'll prefer (1). Reason explained above.

> 
> Also I'm curious if Tianyu's fault report framework needs to register new notifiers.

For Tianyu's case, I feel like we need other kind of notifier as well,
but not the current IOTLB one. And, of course in this case it'll be in
an reverted direction, which is from device to vIOMMU.

(I am thinking whether it's a good time now to let any PCI device able
 to fetch its direct owner IOMMU object, then it can register anything
 it want onto that object maybe?)

Thanks,

-- 
Peter Xu
