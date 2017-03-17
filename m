Received: from eggs.gnu.org ([2001:4830:134:3::10]:56850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1coqBs-0003nq-Ul
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1coqBo-00079R-HI
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:37:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:56985)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1coqBo-00076s-5s
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:37:00 -0400
From: Lan Tianyu <tianyu.lan@intel.com>
Date: Fri, 17 Mar 2017 19:29:15 +0800
Message-Id: <1489750157-17401-3-git-send-email-tianyu.lan@intel.com>
In-Reply-To: <1489750157-17401-1-git-send-email-tianyu.lan@intel.com>
References: <1489750157-17401-1-git-send-email-tianyu.lan@intel.com>
Subject: [Qemu-devel] [RFC PATCH 2/4] Xen: add a dummy vIOMMU to
 create/destroy vIOMMU in Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xensource.com, qemu-devel@nongnu.org
Cc: chao.gao@intel.com, kevin.tian@intel.com, sstabellini@kernel.org, anthony.perard@citrix.com, Lan Tianyu <tianyu.lan@intel.com>

From: Chao Gao <chao.gao@intel.com>

Since adding a dynamic sysbus device is forbidden, so choose TYPE_DEVICE
as parent class.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 hw/xen/Makefile.objs |   1 +
 hw/xen/xen_viommu.c  | 116 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+)
 create mode 100644 hw/xen/xen_viommu.c

diff --git a/hw/xen/Makefile.objs b/hw/xen/Makefile.objs
index d367094..e37d808 100644
--- a/hw/xen/Makefile.objs
+++ b/hw/xen/Makefile.objs
@@ -3,3 +3,4 @@ common-obj-$(CONFIG_XEN_BACKEND) += xen_backend.o xen_devconfig.o
 
 obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen-host-pci-device.o
 obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen_pt.o xen_pt_config_init.o xen_pt_graphics.o xen_pt_msi.o
+obj-$(CONFIG_XEN) += xen_viommu.o
diff --git a/hw/xen/xen_viommu.c b/hw/xen/xen_viommu.c
new file mode 100644
index 0000000..9bf9158
--- /dev/null
+++ b/hw/xen/xen_viommu.c
@@ -0,0 +1,116 @@
+/*
+ * Xen virtual IOMMU (virtual VT-D)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+
+#include "hw/qdev-core.h"
+#include "hw/sysbus.h"
+#include "hw/xen/xen.h"
+#include "hw/xen/xen_backend.h"
+
+#define TYPE_XEN_VIOMMU_DEVICE "xen_viommu"
+#define  XEN_VIOMMU_DEVICE(obj) \
+    OBJECT_CHECK(XenVIOMMUState, (obj), TYPE_XEN_VIOMMU_DEVICE)
+
+typedef struct XenVIOMMUState XenVIOMMUState;
+
+struct XenVIOMMUState {
+    DeviceState dev;
+    uint32_t id;
+    uint64_t cap;
+    uint64_t base_addr;
+};
+
+static void xen_viommu_realize(DeviceState *dev, Error **errp)
+{
+    int rc;
+    uint64_t cap;
+    char *dom;
+    char viommu_path[1024];
+    XenVIOMMUState *s = XEN_VIOMMU_DEVICE(dev);
+
+    s->id = -1;
+    
+    /* Read vIOMMU attributes from Xenstore. */
+    dom = xs_get_domain_path(xenstore, xen_domid);
+    snprintf(viommu_path, sizeof(viommu_path), "%s/viommu", dom);
+    rc = xenstore_read_uint64(viommu_path, "base_addr", &s->base_addr);  
+    if (rc) {
+        error_report("Can't get base address of vIOMMU");
+        exit(1);
+    }
+
+    rc = xenstore_read_uint64(viommu_path, "cap", &s->cap);
+    if (rc) {
+        error_report("Can't get capabilities of vIOMMU");
+        exit(1);
+    }
+
+    rc = xc_viommu_query_cap(xen_xc, xen_domid, &cap);
+    if (rc) {
+        exit(1);
+    }
+
+
+    if ((cap & s->cap) != cap) {
+        error_report("xen: Unsupported capability %lx", s->cap);
+        exit(1);
+    }
+
+    rc = xc_viommu_create(xen_xc, xen_domid, s->base_addr, s->cap, &s->id);
+    if (rc) {
+        s->id = -1;
+        error_report("xen: failed(%d) to create viommu ", rc);
+        exit(1);
+    }
+}
+
+static void xen_viommu_instance_finalize(Object *o)
+{
+    int rc;
+    XenVIOMMUState *s = XEN_VIOMMU_DEVICE(o);
+
+    if (s->id != -1) {
+        rc = xc_viommu_destroy(xen_xc, xen_domid, s->id); 
+        if (rc) {
+            error_report("xen: failed(%d) to destroy viommu ", rc);
+        }
+    }
+}
+
+static void xen_viommu_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    dc->hotpluggable = false;
+    dc->realize = xen_viommu_realize;
+}
+
+static const TypeInfo xen_viommu_info = {
+    .name              = TYPE_XEN_VIOMMU_DEVICE,
+    .parent            = TYPE_SYS_BUS_DEVICE,
+    .instance_size     = sizeof(XenVIOMMUState),
+    .instance_finalize = xen_viommu_instance_finalize,
+    .class_init        = xen_viommu_class_init,
+};
+
+static void xen_viommu_register_types(void)
+{
+    type_register_static(&xen_viommu_info); 
+}
+
+type_init(xen_viommu_register_types);
-- 
1.8.3.1
