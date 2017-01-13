Received: from eggs.gnu.org ([2001:4830:134:3::10]:37073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRz0j-0006xV-4K
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 05:23:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRz0g-0005MJ-G3
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 05:23:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cRz0g-0005M5-9v
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 05:23:02 -0500
Date: Fri, 13 Jan 2017 18:22:53 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170113102253.GY4450@pxdev.xzpeter.org>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-8-git-send-email-peterx@redhat.com>
	<eb0051ab-b555-4df0-c2d6-4230e395fa15@redhat.com>
	<20170113092345.GX4450@pxdev.xzpeter.org>
	<57b08710-837f-26b7-1559-937b66c880d1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57b08710-837f-26b7-1559-937b66c880d1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 07/14] memory: add section range
 info for IOMMU notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, alex.williamson@redhat.com, bd.aviv@gmail.com

On Fri, Jan 13, 2017 at 05:37:43PM +0800, Jason Wang wrote:

[...]

> >>>diff --git a/memory.c b/memory.c
> >>>index 2bfc37f..e88bb54 100644
> >>>--- a/memory.c
> >>>+++ b/memory.c
> >>>@@ -1671,7 +1671,9 @@ void memory_region_notify_iommu(MemoryRegion *mr,
> >>>      }
> >>>      QLIST_FOREACH(iommu_notifier, &mr->iommu_notify, node) {
> >>>-        if (iommu_notifier->notifier_flags & request_flags) {
> >>>+        if (iommu_notifier->notifier_flags & request_flags &&
> >>>+            iommu_notifier->start <= entry.iova &&
> >>>+            iommu_notifier->end >= entry.iova) {
> >>>              iommu_notifier->notify(iommu_notifier, &entry);
> >>>          }
> >>>      }
> >>This seems breaks vhost device IOTLB. How about keep the the behavior
> >>somehow?
> >Thanks to point out. How about I squash this into this patch?
> >
> >--------8<--------
> >diff --git a/memory.c b/memory.c
> >index e88bb54..6de02dd 100644
> >--- a/memory.c
> >+++ b/memory.c
> >@@ -1608,8 +1608,14 @@ void memory_region_register_iommu_notifier(MemoryRegion *mr,
> >          return;
> >      }
> >+    if (n->start == 0 && n->end == 0) {
> >+        /* If these are not specified, we listen to the whole range */
> >+        n->end = (hwaddr)(-1);
> >+    }
> >+
> >      /* We need to register for at least one bitfield */
> >      assert(n->notifier_flags != IOMMU_NOTIFIER_NONE);
> >+    assert(n->start <= n->end);
> >      QLIST_INSERT_HEAD(&mr->iommu_notify, n, node);
> >      memory_region_update_iommu_notify_flags(mr);
> >  }
> >-------->8--------
> >
> >-- peterx
> 
> This should work, or you can introduce a memory_region_iommu_notifier_init()
> to force user to explicitly initialize start and end.

Hmm, this sounds better, considering that IOMMUNotifier is getting
more fields to be inited. Thanks,

-- peterx
