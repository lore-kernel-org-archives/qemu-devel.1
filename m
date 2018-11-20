Received: from eggs.gnu.org ([2001:4830:134:3::10]:52452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1gPCqE-0005r1-RX
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:41:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1gPCq9-0003L0-3o
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:41:50 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10891)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
	id 1gPCq7-0003ID-8O
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:41:45 -0500
From: Kirti Wankhede <kwankhede@nvidia.com>
Date: Wed, 21 Nov 2018 02:09:39 +0530
Message-ID: <1542746383-18288-2-git-send-email-kwankhede@nvidia.com>
In-Reply-To: <1542746383-18288-1-git-send-email-kwankhede@nvidia.com>
References: <1542746383-18288-1-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/5] VFIO KABI for migration interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.williamson@redhat.com, cjia@nvidia.com
Cc: kevin.tian@intel.com, ziye.yang@intel.com, changpeng.liu@intel.com, yi.l.liu@intel.com, mlevitsk@redhat.com, eskultet@redhat.com, cohuck@redhat.com, dgilbert@redhat.com, jonathan.davies@nutanix.com, eauger@redhat.com, aik@ozlabs.ru, pasic@linux.ibm.com, felipe@nutanix.com, Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com, Ken.Xue@amd.com, zhi.a.wang@intel.com, qemu-devel@nongnu.org, Kirti Wankhede <kwankhede@nvidia.com>

- Defined MIGRATION region type and sub-type.
- Defined VFIO device states during migration process.
- Defined vfio_device_migration_info structure which will be placed at 0th
  offset of migration region to get/set VFIO device related information.
  Defined actions and members of structure usage for each action:
    * To convey VFIO device state to be transitioned to.
    * To get pending bytes yet to be migrated for VFIO device
    * To ask driver to write data to migration region and return number of bytes
      written in the region
    * In migration resume path, user space app writes to migration region and
      communicates it to vendor driver.
    * Get bitmap of dirty pages from vendor driver from given start address

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 linux-headers/linux/vfio.h | 130 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 3615a269d378..a6e45cb2cae2 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -301,6 +301,10 @@ struct vfio_region_info_cap_type {
 #define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
 #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
 
+/* Migration region type and sub-type */
+#define VFIO_REGION_TYPE_MIGRATION	        (1 << 30)
+#define VFIO_REGION_SUBTYPE_MIGRATION	        (1)
+
 /*
  * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
  * which allows direct access to non-MSIX registers which happened to be within
@@ -602,6 +606,132 @@ struct vfio_device_ioeventfd {
 
 #define VFIO_DEVICE_IOEVENTFD		_IO(VFIO_TYPE, VFIO_BASE + 16)
 
+/**
+ * VFIO device states :
+ * VFIO User space application should set the device state to indicate vendor
+ * driver in which state the VFIO device should transitioned.
+ * - VFIO_DEVICE_STATE_NONE:
+ *   State when VFIO device is initialized but not yet running.
+ * - VFIO_DEVICE_STATE_RUNNING:
+ *   Transition VFIO device in running state, that is, user space application or
+ *   VM is active.
+ * - VFIO_DEVICE_STATE_MIGRATION_SETUP:
+ *   Transition VFIO device in migration setup state. This is used to prepare
+ *   VFIO device for migration while application or VM and vCPUs are still in
+ *   running state.
+ * - VFIO_DEVICE_STATE_MIGRATION_PRECOPY:
+ *   When VFIO user space application or VM is active and vCPUs are running,
+ *   transition VFIO device in pre-copy state.
+ * - VFIO_DEVICE_STATE_MIGRATION_STOPNCOPY:
+ *   When VFIO user space application or VM is stopped and vCPUs are halted,
+ *   transition VFIO device in stop-and-copy state.
+ * - VFIO_DEVICE_STATE_MIGRATION_SAVE_COMPLETED:
+ *   When VFIO user space application has copied data provided by vendor driver.
+ *   This state is used by vendor driver to clean up all software state that was
+ *   setup during MIGRATION_SETUP state.
+ * - VFIO_DEVICE_STATE_MIGRATION_RESUME:
+ *   Transition VFIO device to resume state, that is, start resuming VFIO device
+ *   when user space application or VM is not running and vCPUs are halted.
+ * - VFIO_DEVICE_STATE_MIGRATION_RESUME_COMPLETED:
+ *   When user space application completes iterations of providing device state
+ *   data, transition device in resume completed state.
+ * - VFIO_DEVICE_STATE_MIGRATION_FAILED:
+ *   Migration process failed due to some reason, transition device to failed
+ *   state. If migration process fails while saving at source, resume device at
+ *   source. If migration process fails while resuming application or VM at
+ *   destination, stop restoration at destination and resume at source.
+ * - VFIO_DEVICE_STATE_MIGRATION_CANCELLED:
+ *   User space application has cancelled migration process either for some
+ *   known reason or due to user's intervention. Transition device to Cancelled
+ *   state, that is, resume device state as it was during running state at
+ *   source.
+ */
+
+enum {
+    VFIO_DEVICE_STATE_NONE,
+    VFIO_DEVICE_STATE_RUNNING,
+    VFIO_DEVICE_STATE_MIGRATION_SETUP,
+    VFIO_DEVICE_STATE_MIGRATION_PRECOPY,
+    VFIO_DEVICE_STATE_MIGRATION_STOPNCOPY,
+    VFIO_DEVICE_STATE_MIGRATION_SAVE_COMPLETED,
+    VFIO_DEVICE_STATE_MIGRATION_RESUME,
+    VFIO_DEVICE_STATE_MIGRATION_RESUME_COMPLETED,
+    VFIO_DEVICE_STATE_MIGRATION_FAILED,
+    VFIO_DEVICE_STATE_MIGRATION_CANCELLED,
+};
+
+/**
+ * Structure vfio_device_migration_info is placed at 0th offset of
+ * VFIO_REGION_SUBTYPE_MIGRATION region to get/set VFIO device related migration
+ * information.
+ *
+ * Action Set state:
+ *      To tell vendor driver the state VFIO device should be transitioned to.
+ *      device_state [input] : User space app sends device state to vendor
+ *           driver on state change, the state to which VFIO device should be
+ *           transitioned to.
+ *
+ * Action Get pending bytes:
+ *      To get pending bytes yet to be migrated from vendor driver
+ *      pending.threshold_size [Input] : threshold of buffer in User space app.
+ *      pending.precopy_only [output] : pending data which must be migrated in
+ *          precopy phase or in stopped state, in other words - before target
+ *          user space application or VM start. In case of migration, this
+ *          indicates pending bytes to be transfered while application or VM or
+ *          vCPUs are active and running.
+ *      pending.compatible [output] : pending data which may be migrated any
+ *          time , either when application or VM is active and vCPUs are active
+ *          or when application or VM is halted and vCPUs are halted.
+ *      pending.postcopy_only [output] : pending data which must be migrated in
+ *           postcopy phase or in stopped state, in other words - after source
+ *           application or VM stopped and vCPUs are halted.
+ *      Sum of pending.precopy_only, pending.compatible and
+ *      pending.postcopy_only is the whole amount of pending data.
+ *
+ * Action Get buffer:
+ *      On this action, vendor driver should write data to migration region and
+ *      return number of bytes written in the region.
+ *      data.offset [output] : offset in the region from where data is written.
+ *      data.size [output] : number of bytes written in migration buffer by
+ *          vendor driver.
+ *
+ * Action Set buffer:
+ *      In migration resume path, user space app writes to migration region and
+ *      communicates it to vendor driver with this action.
+ *      data.offset [Input] : offset in the region from where data is written.
+ *      data.size [Input] : number of bytes written in migration buffer by
+ *          user space app.
+ *
+ * Action Get dirty pages bitmap:
+ *      Get bitmap of dirty pages from vendor driver from given start address.
+ *      dirty_pfns.start_addr [Input] : start address
+ *      dirty_pfns.total [Input] : Total pfn count from start_addr for which
+ *          dirty bitmap is requested
+ *      dirty_pfns.copied [Output] : pfn count for which dirty bitmap is copied
+ *          to migration region.
+ *      Vendor driver should copy the bitmap with bits set only for pages to be
+ *      marked dirty in migration region.
+ */
+
+struct vfio_device_migration_info {
+        __u32 device_state;         /* VFIO device state */
+        struct {
+            __u64 precopy_only;
+            __u64 compatible;
+            __u64 postcopy_only;
+            __u64 threshold_size;
+        } pending;
+        struct {
+            __u64 offset;           /* offset */
+            __u64 size;             /* size */
+        } data;
+        struct {
+            __u64 start_addr;
+            __u64 total;
+            __u64 copied;
+        } dirty_pfns;
+} __attribute__((packed));
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.7.0
