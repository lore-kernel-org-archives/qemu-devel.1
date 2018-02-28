Received: from eggs.gnu.org ([2001:4830:134:3::10]:35531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1er8cF-00048I-Mk
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:46:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1er8cC-0003je-IY
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:46:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1er8cC-0003hZ-Cf
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:46:16 -0500
From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 28 Feb 2018 13:46:00 -0700
Message-ID: <20180228204600.26629.36569.stgit@gimli.home>
In-Reply-To: <20180228201837.26629.3346.stgit@gimli.home>
References: <20180228201837.26629.3346.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 4/5] vfio: Update linux header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, alex.williamson@redhat.com, peterx@redhat.com, eric.auger@redhat.com

Update with proposed ioeventfd API.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 linux-headers/linux/vfio.h |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 4312e961ffd3..c9d7e2db132e 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -503,6 +503,33 @@ struct vfio_pci_hot_reset {
 
 #define VFIO_DEVICE_PCI_HOT_RESET	_IO(VFIO_TYPE, VFIO_BASE + 13)
 
+/**
+ * VFIO_DEVICE_IOEVENTFD - _IOW(VFIO_TYPE, VFIO_BASE + 16,
+ *                              struct vfio_device_ioeventfd)
+ *
+ * Perform a write to the device at the specified device fd offset, with
+ * the specified data and width when the provided eventfd is triggered.
+ * vfio bus drivers may not support this for all regions, or at all.
+ * vfio-pci currently only enables support for BAR regions and excludes
+ * the MSI-X vector table.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+struct vfio_device_ioeventfd {
+	__u32	argsz;
+	__u32	flags;
+#define VFIO_DEVICE_IOEVENTFD_8		(1 << 0) /* 1-byte write */
+#define VFIO_DEVICE_IOEVENTFD_16	(1 << 1) /* 2-byte write */
+#define VFIO_DEVICE_IOEVENTFD_32	(1 << 2) /* 4-byte write */
+#define VFIO_DEVICE_IOEVENTFD_64	(1 << 3) /* 8-byte write */
+#define VFIO_DEVICE_IOEVENTFD_SIZE_MASK	(0xf)
+	__u64	offset;			/* device fd offset of write */
+	__u64	data;			/* data to be written */
+	__s32	fd;			/* -1 for de-assignment */
+};
+
+#define VFIO_DEVICE_IOEVENTFD		_IO(VFIO_TYPE, VFIO_BASE + 16)
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
