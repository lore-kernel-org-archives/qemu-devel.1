Received: from eggs.gnu.org ([2001:4830:134:3::10]:50381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K70-0002WX-R9
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:23:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K6v-00029A-UC
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:23:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:12157)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1d3K6v-000287-L4
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:23:49 -0400
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Wed, 26 Apr 2017 18:06:35 +0800
Message-Id: <1493201210-14357-6-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [RFC PATCH 05/20] VFIO: add new IOCTL for svm bind
 tasks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, alex.williamson@redhat.com, peterx@redhat.com
Cc: kvm@vger.kernel.org, jasowang@redhat.com, iommu@lists.linux-foundation.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, yi.l.liu@intel.com, jean-philippe.brucker@arm.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>

Add a new IOCTL cmd VFIO_IOMMU_SVM_BIND_TASK attached on container->fd.

On VT-d, this IOCTL cmd would be used to link the guest PASID page table
to host. While for other vendors, it may also be used to support other
kind of SVM bind request. Previously, there is a discussion on it with
ARM engineer. It can be found by the link below. This IOCTL cmd may
support SVM PASID bind request from userspace driver, or page table(cr3)
bind request from guest. These SVM bind requests would be supported by
adding different flags. e.g. VFIO_SVM_BIND_PASID is added to support
PASID bind from userspace driver, VFIO_SVM_BIND_PGTABLE is added to
support page table bind from guest.

https://patchwork.kernel.org/patch/9594231/

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 linux-headers/linux/vfio.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 759b850..9848d63 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -537,6 +537,24 @@ struct vfio_iommu_type1_dma_unmap {
 #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
 #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
 
+/* IOCTL for Shared Virtual Memory Bind */
+struct vfio_device_svm {
+	__u32	argsz;
+#define VFIO_SVM_BIND_PASIDTBL	(1 << 0) /* Bind PASID Table */
+#define VFIO_SVM_BIND_PASID	(1 << 1) /* Bind PASID from userspace driver */
+#define VFIO_SVM_BIND_PGTABLE	(1 << 2) /* Bind guest mmu page table */
+	__u32	flags;
+	__u32	length;
+	__u8	data[];
+};
+
+#define VFIO_SVM_TYPE_MASK	(VFIO_SVM_BIND_PASIDTBL | \
+				VFIO_SVM_BIND_PASID | \
+				VFIO_SVM_BIND_PGTABLE )
+
+#define VFIO_IOMMU_SVM_BIND_TASK	_IO(VFIO_TYPE, VFIO_BASE + 22)
+
+
 /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
 
 /*
-- 
1.9.1
