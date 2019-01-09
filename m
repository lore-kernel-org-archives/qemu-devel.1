Received: from eggs.gnu.org ([209.51.188.92]:41822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1ghDKm-0000Y2-6C
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:51:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1ghDAs-0004Cf-6j
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:41:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1ghDAq-0004B7-E4
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:41:34 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x09CXowL045772
	for <qemu-devel@nongnu.org>; Wed, 9 Jan 2019 07:41:30 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pwepfq73v-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 07:41:30 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Wed, 9 Jan 2019 12:41:28 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed,  9 Jan 2019 13:41:19 +0100
In-Reply-To: <1547037680-21458-1-git-send-email-pmorel@linux.ibm.com>
References: <1547037680-21458-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1547037680-21458-3-git-send-email-pmorel@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v1 2/3] vfio/pci: Get real IOMMU information
 from container
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: walling@linux.ibm.com
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, pasic@linux.ibm.com, thuth@redhat.com

When the vfio_iommu_type1 supports the VFIO_IOMMU_INFO_CAPABILITIES
and the capability ID VFIO_IOMMU_INFO_CAP_DMA we can use an ioctl
to retrieve this information from the real IOMMU device.

Let's use this information to add the host window associated with
the container.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 hw/vfio/common.c | 73 +++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 56 insertions(+), 17 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7c185e5a..fd7e991 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1036,6 +1036,61 @@ static void vfio_put_address_space(VFIOAddressSpace *space)
     }
 }
 
+static void vfio_iommu_type1_get_info(int fd, VFIOContainer *container)
+{
+    struct vfio_iommu_type1_info *info;
+    size_t argsz = sizeof(*info);
+    struct vfio_info_cap_header *hdr;
+    struct vfio_iommu_cap_dma *dma_info;
+    int ret = 0;
+
+    info = g_malloc0(argsz);
+
+retry:
+    info->argsz = argsz;
+    info->flags = VFIO_IOMMU_INFO_CAPABILITIES;
+
+    ret = ioctl(fd, VFIO_IOMMU_GET_INFO, info);
+    /* Ignore errors */
+    if (ret) {
+        goto out;
+    }
+    if (!(info->flags & VFIO_IOMMU_INFO_PGSIZES)) {
+        info->iova_pgsizes = 4096;
+    }
+
+    if (info->argsz > argsz) {
+        argsz = info->argsz;
+        info = g_realloc(info, argsz);
+
+        goto retry;
+    }
+    if (info->argsz != argsz) {
+        goto out;
+    }
+    /* Now we have the capabilities */
+    hdr = (struct vfio_info_cap_header *)((unsigned char *)info +
+                                          sizeof(struct vfio_iommu_type1_info) +
+                                          info->cap_offset);
+    do {
+        dma_info = (struct vfio_iommu_cap_dma *) (hdr);
+        if (hdr->id == VFIO_IOMMU_INFO_CAP_DMA) {
+            vfio_host_win_add(container, 0,
+                              dma_info->dma_end - dma_info->dma_start,
+                              info->iova_pgsizes);
+            container->pgsizes = info->iova_pgsizes;
+            return;
+        }
+        hdr = (struct vfio_info_cap_header *)((unsigned char *) dma_info +
+                                              hdr->next);
+    } while (hdr->next);
+out:
+    /* Assume 4k IOVA page size */
+    vfio_host_win_add(container, 0, (hwaddr)-1,  4096);
+    container->pgsizes = 4096;
+    return;
+}
+
 static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
                                   Error **errp)
 {
@@ -1104,7 +1159,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU) ||
         ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU)) {
         bool v2 = !!ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU);
-        struct vfio_iommu_type1_info info;
 
         ret = ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &fd);
         if (ret) {
@@ -1121,22 +1175,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
             goto free_container_exit;
         }
 
-        /*
-         * FIXME: This assumes that a Type1 IOMMU can map any 64-bit
-         * IOVA whatsoever.  That's not actually true, but the current
-         * kernel interface doesn't tell us what it can map, and the
-         * existing Type1 IOMMUs generally support any IOVA we're
-         * going to actually try in practice.
-         */
-        info.argsz = sizeof(info);
-        ret = ioctl(fd, VFIO_IOMMU_GET_INFO, &info);
-        /* Ignore errors */
-        if (ret || !(info.flags & VFIO_IOMMU_INFO_PGSIZES)) {
-            /* Assume 4k IOVA page size */
-            info.iova_pgsizes = 4096;
-        }
-        vfio_host_win_add(container, 0, (hwaddr)-1, info.iova_pgsizes);
-        container->pgsizes = info.iova_pgsizes;
+        vfio_iommu_type1_get_info(fd, container);
     } else if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_IOMMU) ||
                ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_v2_IOMMU)) {
         struct vfio_iommu_spapr_tce_info info;
-- 
2.7.4
