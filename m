Received: from eggs.gnu.org ([2001:4830:134:3::10]:51582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cw5sb-0006nH-Gr
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cw5sW-0000vz-V5
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:47:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cw5sW-0000vb-M6
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:47:04 -0400
Date: Thu, 6 Apr 2017 19:46:47 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170406114647.GC3981@pxdev.xzpeter.org>
References: <1491462524-1617-1-git-send-email-peterx@redhat.com>
	<1491462524-1617-4-git-send-email-peterx@redhat.com>
	<4e552edd-dae8-d0ea-c5b1-4c6cabaf2867@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e552edd-dae8-d0ea-c5b1-4c6cabaf2867@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 3/9] memory: provide iommu_replay_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com, Marcel Apfelbaum <marcel@redhat.com>, bd.aviv@gmail.com, David Gibson <david@gibson.dropbear.id.au>

On Thu, Apr 06, 2017 at 12:52:19PM +0200, Auger Eric wrote:
> Hi Peter,
> 
> On 06/04/2017 09:08, Peter Xu wrote:
> > This is an "global" version of exising memory_region_iommu_replay() - we
> s/exising/existing
> > announce the translations to all the registered notifiers, instead of a
> > specific one.
> > 
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/exec/memory.h | 8 ++++++++
> >  memory.c              | 9 +++++++++
> >  2 files changed, 17 insertions(+)
> > 
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index 07e43da..fb7dff3 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -713,6 +713,14 @@ void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
> >                                  bool is_write);
> >  
> >  /**
> > + * memory_region_iommu_replay_all: replay existing IOMMU translations
> > + * to all the notifiers registered.
> > + *
> > + * @mr: the memory region to observe
> > + */
> > +void memory_region_iommu_replay_all(MemoryRegion *mr);
> > +
> > +/**
> >   * memory_region_unregister_iommu_notifier: unregister a notifier for
> >   * changes to IOMMU translation entries.
> >   *
> > diff --git a/memory.c b/memory.c
> > index 7496b3d..b4ed67b 100644
> > --- a/memory.c
> > +++ b/memory.c
> > @@ -1642,6 +1642,15 @@ void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
> >      }
> >  }
> >  
> > +void memory_region_iommu_replay_all(MemoryRegion *mr)
> > +{
> > +    IOMMUNotifier *notifier;
> > +
> > +    IOMMU_NOTIFIER_FOREACH(notifier, mr) {
> > +        memory_region_iommu_replay(mr, notifier, false);
> It is not fully clear to me what is the consequence of setting
> is_write=false always?

I am not quite sure about it either, on why we are having the is_write
parameter on memory_region_iommu_replay(). It's there since the first
commit that introduced the interface:

    commit a788f227ef7bd2912fcaacdfe13d13ece2998149
    Author: David Gibson <david@gibson.dropbear.id.au>
    Date:   Wed Sep 30 12:13:55 2015 +1000

    memory: Allow replay of IOMMU mapping notifications

However imho that should be a check against page RW permissions, which
seems unecessary during replay. Or say, not sure whether below patch
would be good (as a standalone one besides current patch/series):

------8<------

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 6b33b9f..d008a4b 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -488,7 +488,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
         QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
 
         memory_region_register_iommu_notifier(giommu->iommu, &giommu->n);
-        memory_region_iommu_replay(giommu->iommu, &giommu->n, false);
+        memory_region_iommu_replay(giommu->iommu, &giommu->n);
 
         return;
     }
diff --git a/include/exec/memory.h b/include/exec/memory.h
index c4fc94d..5ab0151 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -725,11 +725,8 @@ void memory_region_register_iommu_notifier(MemoryRegion *mr,
  *
  * @mr: the memory region to observe
  * @n: the notifier to which to replay iommu mappings
- * @is_write: Whether to treat the replay as a translate "write"
- *     through the iommu
  */
-void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
-                                bool is_write);
+void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n);
 
 /**
  * memory_region_iommu_replay_all: replay existing IOMMU translations
diff --git a/memory.c b/memory.c
index b782d5b..155ca1c 100644
--- a/memory.c
+++ b/memory.c
@@ -1620,8 +1620,7 @@ uint64_t memory_region_iommu_get_min_page_size(MemoryRegion *mr)
     return TARGET_PAGE_SIZE;
 }
 
-void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
-                                bool is_write)
+void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n)
 {
     hwaddr addr, granularity;
     IOMMUTLBEntry iotlb;
@@ -1635,7 +1634,13 @@ void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
     granularity = memory_region_iommu_get_min_page_size(mr);
 
     for (addr = 0; addr < memory_region_size(mr); addr += granularity) {
-        iotlb = mr->iommu_ops->translate(mr, addr, is_write);
+        /*
+         * For a replay, we don't need to do permission check.
+         * Assuming a "read" operation here to make sure we will pass
+         * the check (in case we don't have write permission on the
+         * page).
+         */
+        iotlb = mr->iommu_ops->translate(mr, addr, false);
         if (iotlb.perm != IOMMU_NONE) {
             n->notify(n, &iotlb);
         }
@@ -1653,7 +1658,7 @@ void memory_region_iommu_replay_all(MemoryRegion *mr)
     IOMMUNotifier *notifier;
 
     IOMMU_NOTIFIER_FOREACH(notifier, mr) {
-        memory_region_iommu_replay(mr, notifier, false);
+        memory_region_iommu_replay(mr, notifier);
     }
 }

----->8------

Thanks,

-- peterx
