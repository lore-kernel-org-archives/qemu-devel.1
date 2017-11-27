Received: from eggs.gnu.org ([2001:4830:134:3::10]:43909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eJB9o-0007rC-BV
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 23:36:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eJB9n-0004ye-3T
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 23:36:36 -0500
Received: from mga06.intel.com ([134.134.136.31]:29419)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eJB9m-0004w1-Nn
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 23:36:35 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Mon, 27 Nov 2017 12:35:17 +0800
Message-Id: <20171127043517.22441-4-haozhong.zhang@intel.com>
In-Reply-To: <20171127043517.22441-1-haozhong.zhang@intel.com>
References: <20171127043517.22441-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v3 3/3] nvdimm: add 'unarmed' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Xiao Guangrong <guangrong.xiao@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Currently the only vNVDIMM backend can guarantee the guest write
persistence is device DAX on Linux, because no host-side kernel cache
is involved in the guest access to it. The approach to detect whether
the backend is device DAX needs to access sysfs, which may not work
with SELinux.

Instead, we add the 'unarmed' option to device 'nvdimm', so that users
or management utils, which have enough knowledge about the backend,
can control the unarmed flag in guest ACPI NFIT via this option. The
guest Linux NVDIMM driver, for example, will mark the corresponding
vNVDIMM device read-only if the unarmed flag in guest NFIT is set.

The default value of 'unarmed' option is 'off' in order to keep the
backwards compatibility.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
 docs/nvdimm.txt         | 15 +++++++++++++++
 hw/acpi/nvdimm.c        |  7 +++++++
 hw/mem/nvdimm.c         | 26 ++++++++++++++++++++++++++
 include/hw/mem/nvdimm.h |  9 +++++++++
 4 files changed, 57 insertions(+)

diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
index 21249dd062..e903d8bb09 100644
--- a/docs/nvdimm.txt
+++ b/docs/nvdimm.txt
@@ -138,3 +138,18 @@ backend of vNVDIMM:
 
  -object memory-backend-file,id=mem1,share=on,mem-path=/dev/dax0.0,size=4G,align=2M
  -device nvdimm,id=nvdimm1,memdev=mem1
+
+Guest Data Persistence
+----------------------
+
+Though QEMU supports multiple types of vNVDIMM backends on Linux,
+currently the only one that can guarantee the guest write persistence
+is the device DAX on the real NVDIMM device (e.g., /dev/dax0.0), to
+which all guest access do not involve any host-side kernel cache.
+
+When using other types of backends, it's suggested to set 'unarmed'
+option of '-device nvdimm' to 'on', which sets the unarmed flag of the
+guest NVDIMM region mapping structure.  This unarmed flag indicates
+guest software that this vNVDIMM device contains a region that cannot
+accept persistent writes. In result, for example, the guest Linux
+NVDIMM driver, marks such vNVDIMM device as read-only.
diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 6ceea196e7..e55ff2cd12 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -138,6 +138,8 @@ struct NvdimmNfitMemDev {
 } QEMU_PACKED;
 typedef struct NvdimmNfitMemDev NvdimmNfitMemDev;
 
+#define ACPI_NFIT_MEM_NOT_ARMED     (1 << 3)
+
 /*
  * NVDIMM Control Region Structure
  *
@@ -284,6 +286,7 @@ static void
 nvdimm_build_structure_memdev(GArray *structures, DeviceState *dev)
 {
     NvdimmNfitMemDev *nfit_memdev;
+    NVDIMMDevice *nvdimm = NVDIMM(OBJECT(dev));
     uint64_t size = object_property_get_uint(OBJECT(dev), PC_DIMM_SIZE_PROP,
                                              NULL);
     int slot = object_property_get_int(OBJECT(dev), PC_DIMM_SLOT_PROP,
@@ -312,6 +315,10 @@ nvdimm_build_structure_memdev(GArray *structures, DeviceState *dev)
 
     /* Only one interleave for PMEM. */
     nfit_memdev->interleave_ways = cpu_to_le16(1);
+
+    if (nvdimm->unarmed) {
+        nfit_memdev->flags |= ACPI_NFIT_MEM_NOT_ARMED;
+    }
 }
 
 /*
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 618c3d677b..61e677f92f 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
+#include "qapi-visit.h"
 #include "hw/mem/nvdimm.h"
 
 static void nvdimm_get_label_size(Object *obj, Visitor *v, const char *name,
@@ -64,11 +65,36 @@ out:
     error_propagate(errp, local_err);
 }
 
+static bool nvdimm_get_unarmed(Object *obj, Error **errp)
+{
+    NVDIMMDevice *nvdimm = NVDIMM(obj);
+
+    return nvdimm->unarmed;
+}
+
+static void nvdimm_set_unarmed(Object *obj, bool value, Error **errp)
+{
+    NVDIMMDevice *nvdimm = NVDIMM(obj);
+    Error *local_err = NULL;
+
+    if (memory_region_size(&nvdimm->nvdimm_mr)) {
+        error_setg(&local_err, "cannot change property value");
+        goto out;
+    }
+
+    nvdimm->unarmed = value;
+
+ out:
+    error_propagate(errp, local_err);
+}
+
 static void nvdimm_init(Object *obj)
 {
     object_property_add(obj, NVDIMM_LABLE_SIZE_PROP, "int",
                         nvdimm_get_label_size, nvdimm_set_label_size, NULL,
                         NULL, NULL);
+    object_property_add_bool(obj, NVDIMM_UNARMED_PROP,
+                             nvdimm_get_unarmed, nvdimm_set_unarmed, NULL);
 }
 
 static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm, Error **errp)
diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index 28e68ddf59..7fd87c4e1c 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -49,6 +49,7 @@
                                                TYPE_NVDIMM)
 
 #define NVDIMM_LABLE_SIZE_PROP "label-size"
+#define NVDIMM_UNARMED_PROP    "unarmed"
 
 struct NVDIMMDevice {
     /* private */
@@ -74,6 +75,14 @@ struct NVDIMMDevice {
      * guest via ACPI NFIT and _FIT method if NVDIMM hotplug is supported.
      */
     MemoryRegion nvdimm_mr;
+
+    /*
+     * The 'on' value results in the unarmed flag set in ACPI NFIT,
+     * which can be used to notify guest implicitly that the host
+     * backend (e.g., files on HDD, /dev/pmemX, etc.) cannot guarantee
+     * the guest write persistence.
+     */
+    bool unarmed;
 };
 typedef struct NVDIMMDevice NVDIMMDevice;
 
-- 
2.14.1
