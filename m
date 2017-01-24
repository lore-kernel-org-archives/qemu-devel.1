Received: from eggs.gnu.org ([2001:4830:134:3::10]:42110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVvq1-0004WL-LR
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 02:48:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVvpx-00071e-2Z
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 02:48:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cVvpw-00071B-Q1
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 02:48:16 -0500
Date: Tue, 24 Jan 2017 15:48:11 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170124074811.GC16400@pxdev.xzpeter.org>
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
	<1484917736-32056-11-git-send-email-peterx@redhat.com>
	<20170123121244.78cc7e49@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170123121244.78cc7e49@t450s.home>
Subject: Re: [Qemu-devel] [PATCH RFC v4 10/20] memory: add section range
 info for IOMMU notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, bd.aviv@gmail.com

On Mon, Jan 23, 2017 at 12:12:44PM -0700, Alex Williamson wrote:
> On Fri, 20 Jan 2017 21:08:46 +0800
> Peter Xu <peterx@redhat.com> wrote:
> 
> > In this patch, IOMMUNotifier.{start|end} are introduced to store section
> > information for a specific notifier. When notification occurs, we not
> > only check the notification type (MAP|UNMAP), but also check whether the
> > notified iova is in the range of specific IOMMU notifier, and skip those
> > notifiers if not in the listened range.
> > 
> > When removing an region, we need to make sure we removed the correct
> > VFIOGuestIOMMU by checking the IOMMUNotifier.start address as well.
> > 
> > Suggested-by: David Gibson <david@gibson.dropbear.id.au>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> > changelog (start from vt-d vfio enablement series v3):
> > v4:
> > - introduce memory_region_iommu_notifier_init() [Jason]
> > ---
> >  hw/vfio/common.c      | 12 +++++++++---
> >  hw/virtio/vhost.c     |  4 ++--
> >  include/exec/memory.h | 19 ++++++++++++++++++-
> >  memory.c              |  5 ++++-
> >  4 files changed, 33 insertions(+), 7 deletions(-)
> 
> 
> Acked-by: Alex Williamson <alex.williamson@redhat.com>

Thanks for the ack!

Sorry that I want to tune this patch a bit - I'll loosen the limit on
the range check. The original patch will notify if iova is inside
range (start, end), while I am tuning it to allow the notification
happen as long as (iova, size) and (start, end) has any overlapping.
The diff against this one would be (for your better reference):

------8<-------

diff --git a/memory.c b/memory.c
index 89104b1..80ab3c1 100644
--- a/memory.c
+++ b/memory.c
@@ -1672,9 +1672,15 @@ void memory_region_notify_iommu(MemoryRegion *mr,
     }

     QLIST_FOREACH(iommu_notifier, &mr->iommu_notify, node) {
-        if (iommu_notifier->notifier_flags & request_flags &&
-            iommu_notifier->start <= entry.iova &&
-            iommu_notifier->end >= entry.iova) {
+        /*
+         * Skip the notification if the notification does not overlap
+         * with registered range.
+         */
+        if (iommu_notifier->start > entry.iova + entry.addr_mask + 1 ||
+            iommu_notifier->end < entry.iova) {
+            continue;
+        }
+        if (iommu_notifier->notifier_flags & request_flags) {
             iommu_notifier->notify(iommu_notifier, &entry);
         }
     }

------>8-------

I'll post with the complete patch along with the series's next post.

Thanks,

-- peterx
