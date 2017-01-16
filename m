Received: from eggs.gnu.org ([2001:4830:134:3::10]:46447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cT3TM-0007ES-4F
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 04:21:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cT3TH-0007w9-7C
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 04:21:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cT3TH-0007vu-0m
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 04:20:59 -0500
Date: Mon, 16 Jan 2017 17:20:54 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170116092054.GM30108@pxdev.xzpeter.org>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-15-git-send-email-peterx@redhat.com>
	<fad506bc-2398-fef9-b720-7720569ac0a6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fad506bc-2398-fef9-b720-7720569ac0a6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 14/14] intel_iommu: enable vfio
 devices
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

On Mon, Jan 16, 2017 at 02:30:20PM +0800, Jason Wang wrote:

[...]

> >  }
> >  /* Flush IOTLB
> >@@ -2244,15 +2274,34 @@ static void vtd_iommu_notify_flag_changed(MemoryRegion *iommu,
> >                                            IOMMUNotifierFlag new)
> >  {
> >      VTDAddressSpace *vtd_as = container_of(iommu, VTDAddressSpace, iommu);
> >+    IntelIOMMUState *s = vtd_as->iommu_state;
> >+    IntelIOMMUNotifierNode *node = NULL;
> >+    IntelIOMMUNotifierNode *next_node = NULL;
> >-    if (new & IOMMU_NOTIFIER_MAP) {
> >-        error_report("Device at bus %s addr %02x.%d requires iommu "
> >-                     "notifier which is currently not supported by "
> >-                     "intel-iommu emulation",
> >-                     vtd_as->bus->qbus.name, PCI_SLOT(vtd_as->devfn),
> >-                     PCI_FUNC(vtd_as->devfn));
> >+    if (!s->cache_mode_enabled && new & IOMMU_NOTIFIER_MAP) {
> >+        error_report("We need to set cache_mode=1 for intel-iommu to enable "
> >+                     "device assignment with IOMMU protection.");
> >          exit(1);
> >      }
> >+
> >+    /* Add new ndoe if no mapping was exising before this call */
> 
> "node"?

Sorry I missed this one - let me just remove above comment since it
just describes what the codes has done below.

Thanks,

> 
> >+    if (old == IOMMU_NOTIFIER_NONE) {
> >+        node = g_malloc0(sizeof(*node));
> >+        node->vtd_as = vtd_as;
> >+        QLIST_INSERT_HEAD(&s->notifiers_list, node, next);
> >+        return;
> >+    }

-- peterx
