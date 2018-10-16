Received: from eggs.gnu.org ([2001:4830:134:3::10]:42121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1gCTwT-0006nn-CS
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 14:19:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1gCTwP-0003rH-O2
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 14:19:41 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
	id 1gCTwN-0003fg-Pk
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 14:19:37 -0400
From: Kirti Wankhede <kwankhede@nvidia.com>
Date: Tue, 16 Oct 2018 23:42:35 +0530
Message-ID: <1539713558-2453-2-git-send-email-kwankhede@nvidia.com>
In-Reply-To: <1539713558-2453-1-git-send-email-kwankhede@nvidia.com>
References: <1539713558-2453-1-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH v1 1/4] VFIO KABI for migration interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.williamson@redhat.com, cjia@nvidia.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Kirti Wankhede <kwankhede@nvidia.com>

- Added vfio_device_migration_info structure to use interact with vendor
  driver.
- Different flags are used to get or set migration related information
  from/to vendor driver.
Flag VFIO_MIGRATION_PROBE: To query if feature is supported
Flag VFIO_MIGRATION_GET_REGION: To get migration region info
Flag VFIO_MIGRATION_SET_STATE: To convey device state in vendor driver
Flag VFIO_MIGRATION_GET_PENDING: To get pending bytes yet to be migrated
  from vendor driver
Flag VFIO_MIGRATION_GET_BUFFER: On this flag, vendor driver should write
  data to migration region and return number of bytes written in the region
Flag VFIO_MIGRATION_SET_BUFFER: In migration resume path, user space app
  writes to migration region and communicates it to vendor driver with
  this ioctl with this flag.
Flag VFIO_MIGRATION_GET_DIRTY_PFNS: Get bitmap of dirty pages from vendor
  driver from given start address

- Added enum for possible device states.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 linux-headers/linux/vfio.h | 91 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 3615a269d378..8e9045ed9aa8 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -602,6 +602,97 @@ struct vfio_device_ioeventfd {
 
 #define VFIO_DEVICE_IOEVENTFD		_IO(VFIO_TYPE, VFIO_BASE + 16)
 
+/**
+ * VFIO_DEVICE_MIGRATION_INFO - _IOW(VFIO_TYPE, VFIO_BASE + 17,
+ *                              struct vfio_device_migration_info)
+ * Flag VFIO_MIGRATION_PROBE:
+ *      To query if feature is supported
+ *
+ * Flag VFIO_MIGRATION_GET_REGION:
+ *      To get migration region info
+ *      region_index [output] : region index to be used for migration region
+ *      size [output]: size of migration region
+ *
+ * Flag VFIO_MIGRATION_SET_STATE:
+ *      To set device state in vendor driver
+ *      device_state [input] : User space app sends device state to vendor
+ *           driver on state change
+ *
+ * Flag VFIO_MIGRATION_GET_PENDING:
+ *      To get pending bytes yet to be migrated from vendor driver
+ *      threshold_size [Input] : threshold of buffer in User space app.
+ *      pending_precopy_only [output] : pending data which must be migrated in
+ *          precopy phase or in stopped state, in other words - before target
+ *          vm start
+ *      pending_compatible [output] : pending data which may be migrated in any
+ *           phase
+ *      pending_postcopy_only [output] : pending data which must be migrated in
+ *           postcopy phase or in stopped state, in other words - after source
+ *           vm stop
+ *      Sum of pending_precopy_only, pending_compatible and
+ *      pending_postcopy_only is the whole amount of pending data.
+ *
+ * Flag VFIO_MIGRATION_GET_BUFFER:
+ *      On this flag, vendor driver should write data to migration region and
+ *      return number of bytes written in the region.
+ *      bytes_written [output] : number of bytes written in migration buffer by
+ *          vendor driver
+ *
+ * Flag VFIO_MIGRATION_SET_BUFFER
+ *      In migration resume path, user space app writes to migration region and
+ *      communicates it to vendor driver with this ioctl with this flag.
+ *      bytes_written [Input] : number of bytes written in migration buffer by
+ *          user space app.
+ *
+ * Flag VFIO_MIGRATION_GET_DIRTY_PFNS
+ *      Get bitmap of dirty pages from vendor driver from given start address.
+ *      start_addr [Input] : start address
+ *      pfn_count [Input] : Total pfn count from start_addr for which dirty
+ *          bitmap is requested
+ *      dirty_bitmap [Output] : bitmap memory allocated by user space
+ *           application, vendor driver should return the bitmap with bits set
+ *           only for pages to be marked dirty.
+ * Return: 0 on success, -errno on failure.
+ */
+
+struct vfio_device_migration_info {
+	__u32 argsz;
+	__u32 flags;
+#define VFIO_MIGRATION_PROBE            (1 << 0)
+#define VFIO_MIGRATION_GET_REGION       (1 << 1)
+#define VFIO_MIGRATION_SET_STATE        (1 << 2)
+#define VFIO_MIGRATION_GET_PENDING      (1 << 3)
+#define VFIO_MIGRATION_GET_BUFFER       (1 << 4)
+#define VFIO_MIGRATION_SET_BUFFER       (1 << 5)
+#define VFIO_MIGRATION_GET_DIRTY_PFNS   (1 << 6)
+        __u32 region_index;	            /* region index */
+        __u64 size;	                    /* size */
+        __u32 device_state;                 /* VFIO device state */
+        __u64 pending_precopy_only;
+        __u64 pending_compatible;
+        __u64 pending_postcopy_only;
+        __u64 threshold_size;
+        __u64 bytes_written;
+        __u64 start_addr;
+        __u64 pfn_count;
+	__u8  dirty_bitmap[];
+};
+
+enum {
+    VFIO_DEVICE_STATE_NONE,
+    VFIO_DEVICE_STATE_RUNNING,
+    VFIO_DEVICE_STATE_MIGRATION_SETUP,
+    VFIO_DEVICE_STATE_MIGRATION_PRECOPY_ACTIVE,
+    VFIO_DEVICE_STATE_MIGRATION_STOPNCOPY_ACTIVE,
+    VFIO_DEVICE_STATE_MIGRATION_SAVE_COMPLETED,
+    VFIO_DEVICE_STATE_MIGRATION_RESUME,
+    VFIO_DEVICE_STATE_MIGRATION_RESUME_COMPLETED,
+    VFIO_DEVICE_STATE_MIGRATION_FAILED,
+    VFIO_DEVICE_STATE_MIGRATION_CANCELLED,
+};
+
+#define VFIO_DEVICE_MIGRATION_INFO _IO(VFIO_TYPE, VFIO_BASE + 17)
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.7.0
