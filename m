Received: from eggs.gnu.org ([2001:4830:134:3::10]:34443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ej8Cp-0003iZ-V9
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:43:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ej8Co-00038g-W5
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:43:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ej8Co-00038W-NQ
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:42:58 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F00A01B3C5F
	for <qemu-devel@nongnu.org>; Tue,  6 Feb 2018 18:42:57 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 06 Feb 2018 11:42:54 -0700
Message-ID: <20180206184254.14644.3652.stgit@gimli.home>
In-Reply-To: <20180206184101.14644.84734.stgit@gimli.home>
References: <20180206184101.14644.84734.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 01/11] memory/iommu: Add get_attr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alexey Kardashevskiy <aik@ozlabs.ru>

This adds get_attr() to IOMMUMemoryRegionClass, like
iommu_ops::domain_get_attr in the Linux kernel.

This defines the first attribute - IOMMU_ATTR_SPAPR_TCE_FD - which
will be used between the pSeries machine and VFIO-PCI.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 include/exec/memory.h |   22 ++++++++++++++++++++++
 memory.c              |   13 +++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 07c5d6d59796..3ef83991e99a 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -190,6 +190,10 @@ struct MemoryRegionOps {
     const MemoryRegionMmio old_mmio;
 };
 
+enum IOMMUMemoryRegionAttr {
+    IOMMU_ATTR_SPAPR_TCE_FD
+};
+
 typedef struct IOMMUMemoryRegionClass {
     /* private */
     struct DeviceClass parent_class;
@@ -210,6 +214,10 @@ typedef struct IOMMUMemoryRegionClass {
                                 IOMMUNotifierFlag new_flags);
     /* Set this up to provide customized IOMMU replay function */
     void (*replay)(IOMMUMemoryRegion *iommu, IOMMUNotifier *notifier);
+
+    /* Get IOMMU misc attributes */
+    int (*get_attr)(IOMMUMemoryRegion *iommu, enum IOMMUMemoryRegionAttr,
+                    void *data);
 } IOMMUMemoryRegionClass;
 
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
@@ -926,6 +934,20 @@ void memory_region_iommu_replay_all(IOMMUMemoryRegion *iommu_mr);
 void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
                                              IOMMUNotifier *n);
 
+/**
+ * memory_region_iommu_get_attr: return an IOMMU attr if get_attr() is
+ * defined on the IOMMU.
+ *
+ * Returns 0 if succeded, error code otherwise.
+ *
+ * @iommu_mr: the memory region
+ * @attr: the requested attribute
+ * @data: a pointer to the requested attribute data
+ */
+int memory_region_iommu_get_attr(IOMMUMemoryRegion *iommu_mr,
+                                 enum IOMMUMemoryRegionAttr attr,
+                                 void *data);
+
 /**
  * memory_region_name: get a memory region's name
  *
diff --git a/memory.c b/memory.c
index 449a1429b946..a4c603730a8c 100644
--- a/memory.c
+++ b/memory.c
@@ -1922,6 +1922,19 @@ void memory_region_notify_iommu(IOMMUMemoryRegion *iommu_mr,
     }
 }
 
+int memory_region_iommu_get_attr(IOMMUMemoryRegion *iommu_mr,
+                                 enum IOMMUMemoryRegionAttr attr,
+                                 void *data)
+{
+    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
+
+    if (!imrc->get_attr) {
+        return -EINVAL;
+    }
+
+    return imrc->get_attr(iommu_mr, attr, data);
+}
+
 void memory_region_set_log(MemoryRegion *mr, bool log, unsigned client)
 {
     uint8_t mask = 1 << client;
