Received: from eggs.gnu.org ([2001:4830:134:3::10]:55955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1dBado-00072q-G2
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:39:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1dBadj-0005Ci-NT
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:39:56 -0400
Received: from mga05.intel.com ([192.55.52.43]:42023)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1dBadj-0005CR-FE
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:39:51 -0400
Date: Fri, 19 May 2017 13:23:38 +0800
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Message-ID: <20170519052338.GA10952@sky-dev>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
	<1493201210-14357-10-git-send-email-yi.l.liu@linux.intel.com>
	<5c64416d-7d8a-f1a6-64f9-cb0bf1d95a4a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c64416d-7d8a-f1a6-64f9-cb0bf1d95a4a@intel.com>
Subject: Re: [Qemu-devel] [RFC PATCH 09/20] Memory: introduce
 iommu_ops->record_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.williamson@redhat.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org, jean-philippe.brucker@arm.com, jasowang@redhat.com, iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com, tianyu.lan@intel.com

Hi Alex,

What's your opinion with Tianyu's question? Is it accepatable
to use VFIO API in intel_iommu emulator?

Thanks,
Yi L
On Fri, Apr 28, 2017 at 02:46:16PM +0800, Lan Tianyu wrote:
> On 2017年04月26日 18:06, Liu, Yi L wrote:
> > With vIOMMU exposed to guest, vIOMMU emulator needs to do translation
> > between host and guest. e.g. a device-selective TLB flush, vIOMMU
> > emulator needs to replace guest SID with host SID so that to limit
> > the invalidation. This patch introduces a new callback
> > iommu_ops->record_device() to notify vIOMMU emulator to record necessary
> > information about the assigned device.
> 
> This patch is to prepare to translate guest sbdf to host sbdf.
> 
> Alex:
> 	Could we add a new vfio API to do such translation? This will be more
> straight forward than storing host sbdf in the vIOMMU device model.
> 
> > 
> > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> > ---
> >  include/exec/memory.h | 11 +++++++++++
> >  memory.c              | 12 ++++++++++++
> >  2 files changed, 23 insertions(+)
> > 
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index 7bd13ab..49087ef 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -203,6 +203,8 @@ struct MemoryRegionIOMMUOps {
> >                                  IOMMUNotifierFlag new_flags);
> >      /* Set this up to provide customized IOMMU replay function */
> >      void (*replay)(MemoryRegion *iommu, IOMMUNotifier *notifier);
> > +    void (*record_device)(MemoryRegion *iommu,
> > +                          void *device_info);
> >  };
> >  
> >  typedef struct CoalescedMemoryRange CoalescedMemoryRange;
> > @@ -708,6 +710,15 @@ void memory_region_notify_iommu(MemoryRegion *mr,
> >  void memory_region_notify_one(IOMMUNotifier *notifier,
> >                                IOMMUTLBEntry *entry);
> >  
> > +/*
> > + * memory_region_notify_device_record: notify IOMMU to record assign
> > + * device.
> > + * @mr: the memory region to notify
> > + * @ device_info: device information
> > + */
> > +void memory_region_notify_device_record(MemoryRegion *mr,
> > +                                        void *info);
> > +
> >  /**
> >   * memory_region_register_iommu_notifier: register a notifier for changes to
> >   * IOMMU translation entries.
> > diff --git a/memory.c b/memory.c
> > index 0728e62..45ef069 100644
> > --- a/memory.c
> > +++ b/memory.c
> > @@ -1600,6 +1600,18 @@ static void memory_region_update_iommu_notify_flags(MemoryRegion *mr)
> >      mr->iommu_notify_flags = flags;
> >  }
> >  
> > +void memory_region_notify_device_record(MemoryRegion *mr,
> > +                                        void *info)
> > +{
> > +    assert(memory_region_is_iommu(mr));
> > +
> > +    if (mr->iommu_ops->record_device) {
> > +        mr->iommu_ops->record_device(mr, info);
> > +    }
> > +
> > +    return;
> > +}
> > +
> >  void memory_region_register_iommu_notifier(MemoryRegion *mr,
> >                                             IOMMUNotifier *n)
> >  {
> > 
> 
> 
