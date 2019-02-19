Received: from eggs.gnu.org ([209.51.188.92]:33466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1gwCyP-00068w-1G
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 16:30:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1gwCyM-0005ga-6i
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 16:30:40 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
	id 1gwCyL-0005b8-BF
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 16:30:37 -0500
From: Kirti Wankhede <kwankhede@nvidia.com>
Date: Wed, 20 Feb 2019 02:53:16 +0530
Message-ID: <1550611400-13703-2-git-send-email-kwankhede@nvidia.com>
In-Reply-To: <1550611400-13703-1-git-send-email-kwankhede@nvidia.com>
References: <1550611400-13703-1-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 1/5] VFIO KABI for migration interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.williamson@redhat.com, cjia@nvidia.com
Cc: kevin.tian@intel.com, ziye.yang@intel.com, changpeng.liu@intel.com, yi.l.liu@intel.com, mlevitsk@redhat.com, eskultet@redhat.com, cohuck@redhat.com, dgilbert@redhat.com, jonathan.davies@nutanix.com, eauger@redhat.com, aik@ozlabs.ru, pasic@linux.ibm.com, felipe@nutanix.com, Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com, Ken.Xue@amd.com, zhi.a.wang@intel.com, yan.y.zhao@intel.com, yulei.zhang@intel.com, qemu-devel@nongnu.org, Kirti Wankhede <kwankhede@nvidia.com>

- Defined MIGRATION region type and sub-type.
- Used 2 bits to define VFIO device states.
    Bit 0 => 0/1 => _STOPPED/_RUNNING
    Bit 1 => 0/1 => _RESUMING/_SAVING
    Combination of these bits defines VFIO device's state during migration
    _RUNNING => Normal VFIO device running state.
    _STOPPED => VFIO device stopped.
    _SAVING | _RUNNING => vCPUs are running, VFIO device is running but start
                          saving state of device i.e. pre-copy state
    _SAVING | _STOPPED => vCPUs are stoppped, VFIO device should be stopped, and
                          save device state,i.e. stop-n-copy state
    _RESUMING => VFIO device resuming state.
- Defined vfio_device_migration_info structure which will be placed at 0th
  offset of migration region to get/set VFIO device related information.
  Defined members of structure and usage on read/write access:
    * device_state: (write only)
        To convey VFIO device state to be transitioned to.
    * pending bytes: (read only)
        To get pending bytes yet to be migrated for VFIO device
    * data_offset: (read/write)
        To get or set data offset in migration from where data exist
        during _SAVING and _RESUMING state
    * data_size: (write only)
        To convey size of data copied in migration region during _RESUMING
        state
    * start_pfn, page_size, total_pfns: (write only)
        To get bitmap of dirty pages from vendor driver from given
        start address for total_pfns.
    * copied_pfns: (read only)
        To get number of pfns bitmap copied in migration region.
        Vendor driver should copy the bitmap with bits set only for
        pages to be marked dirty in migration region. Vendor driver
        should return 0 if there are 0 pages dirty in requested
        range.

Migration region looks like:
 ------------------------------------------------------------------
|vfio_device_migration_info|    data section                      |
|                          |     ///////////////////////////////  |
 ------------------------------------------------------------------
 ^                              ^                              ^
 offset 0-trapped part        data.offset                 data.size

Data section is always followed by vfio_device_migration_info
structure in the region, so data.offset will always be none-0.
Offset from where data is copied is decided by kernel driver, data
section can be trapped or mapped depending on how kernel driver
defines data section. If mmapped, then data.offset should be page
aligned, where as initial section which contain
vfio_device_migration_info structure might not end at offset which
is page aligned.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 linux-headers/linux/vfio.h | 65 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 12a7b1dc53c8..1b12a9b95e00 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -368,6 +368,71 @@ struct vfio_region_gfx_edid {
  */
 #define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
 
+/* Migration region type and sub-type */
+#define VFIO_REGION_TYPE_MIGRATION	        (2)
+#define VFIO_REGION_SUBTYPE_MIGRATION	        (1)
+
+/**
+ * Structure vfio_device_migration_info is placed at 0th offset of
+ * VFIO_REGION_SUBTYPE_MIGRATION region to get/set VFIO device related migration
+ * information. Field accesses from this structure are only supported at their
+ * native width and alignment, otherwise should return error.
+ *
+ * device_state: (write only)
+ *      To indicate vendor driver the state VFIO device should be transitioned
+ *      to. If device state transition fails, write to this field return error.
+ *      It consists of 2 bits.
+ *      - If bit 0 set, indicates _RUNNING state. When its reset, that indicates
+ *        _STOPPED state. When device is changed to _STOPPED, driver should stop
+ *        device before write returns.
+ *      - If bit 1 set, indicates _SAVING state. When its reset, that indicates
+ *        _RESUMING state.
+ *
+ * pending bytes: (read only)
+ *      Read pending bytes yet to be migrated from vendor driver
+ *
+ * data_offset: (read/write)
+ *      User application should read data_offset in migration region from where
+ *      user application should read data during _SAVING state.
+ *      User application would write data_offset in migration region from where
+ *      user application is had written data during _RESUMING state.
+ *
+ * data_size: (write only)
+ *      User application should write size of data copied in migration region
+ *      during _RESUMING state.
+ *
+ * start_pfn: (write only)
+ *      Start address pfn to get bitmap of dirty pages from vendor driver duing
+ *      _SAVING state.
+ *
+ * page_size: (write only)
+ *      User application should write the page_size of pfn.
+ *
+ * total_pfns: (write only)
+ *      Total pfn count from start_pfn for which dirty bitmap is requested.
+ *
+ * copied_pfns: (read only)
+ *      pfn count for which dirty bitmap is copied to migration region.
+ *      Vendor driver should copy the bitmap with bits set only for pages to be
+ *      marked dirty in migration region.
+ *      Vendor driver should return 0 if there are 0 pages dirty in requested
+ *      range.
+ */
+
+struct vfio_device_migration_info {
+        __u32 device_state;         /* VFIO device state */
+#define VFIO_DEVICE_STATE_RUNNING   (1 << 0)
+#define VFIO_DEVICE_STATE_SAVING    (1 << 1)
+        __u32 reserved;
+        __u64 pending_bytes;
+        __u64 data_offset;
+        __u64 data_size;
+        __u64 start_pfn;
+        __u64 page_size;
+        __u64 total_pfns;
+        __u64 copied_pfns;
+} __attribute__((packed));
+
 /*
  * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
  * which allows direct access to non-MSIX registers which happened to be within
-- 
2.7.0
