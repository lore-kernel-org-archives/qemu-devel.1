Received: from eggs.gnu.org ([2001:4830:134:3::10]:48667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dAn96-0003Io-Oq
	for qemu-devel@nongnu.org; Tue, 16 May 2017 20:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dAn91-0001I9-Re
	for qemu-devel@nongnu.org; Tue, 16 May 2017 20:48:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45177
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dAn91-0001Hu-LT
	for qemu-devel@nongnu.org; Tue, 16 May 2017 20:48:51 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4H0mnIm020162
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 20:48:51 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2agc1r8g0d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 20:48:50 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 16 May 2017 18:48:49 -0600
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Wed, 17 May 2017 02:48:07 +0200
In-Reply-To: <20170517004813.58227-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170517004813.58227-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170517004813.58227-8-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v8 07/13] vfio/ccw: vfio based subchannel
 passthrough driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, eric.auger@redhat.com, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>

From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>

We use the IOMMU_TYPE1 of VFIO to realize the subchannels
passthrough, implement a vfio based subchannels passthrough
driver called "vfio-ccw".

Support qemu parameters in the style of:
"-device vfio-ccw,sysfsdev=$mdev_file_path,devno=xx.x.xxxx'

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 default-configs/s390x-softmmu.mak |   1 +
 hw/vfio/Makefile.objs             |   1 +
 hw/vfio/ccw.c                     | 187 ++++++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h     |   1 +
 4 files changed, 190 insertions(+)
 create mode 100644 hw/vfio/ccw.c

diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
index 9615a48f80..18aed56fc0 100644
--- a/default-configs/s390x-softmmu.mak
+++ b/default-configs/s390x-softmmu.mak
@@ -5,4 +5,5 @@ CONFIG_SCLPCONSOLE=y
 CONFIG_TERMINAL3270=y
 CONFIG_S390_FLIC=y
 CONFIG_S390_FLIC_KVM=$(CONFIG_KVM)
+CONFIG_VFIO_CCW=$(CONFIG_LINUX)
 CONFIG_WDT_DIAG288=y
diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
index 05e7fbb93f..c3ab9097f1 100644
--- a/hw/vfio/Makefile.objs
+++ b/hw/vfio/Makefile.objs
@@ -1,6 +1,7 @@
 ifeq ($(CONFIG_LINUX), y)
 obj-$(CONFIG_SOFTMMU) += common.o
 obj-$(CONFIG_PCI) += pci.o pci-quirks.o
+obj-$(CONFIG_VFIO_CCW) += ccw.o
 obj-$(CONFIG_SOFTMMU) += platform.o
 obj-$(CONFIG_VFIO_XGMAC) += calxeda-xgmac.o
 obj-$(CONFIG_VFIO_AMD_XGBE) += amd-xgbe.o
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
new file mode 100644
index 0000000000..7d2497cee6
--- /dev/null
+++ b/hw/vfio/ccw.c
@@ -0,0 +1,187 @@
+/*
+ * vfio based subchannel assignment support
+ *
+ * Copyright 2017 IBM Corp.
+ * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+ *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
+ *            Pierre Morel <pmorel@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or(at
+ * your option) any version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#include <linux/vfio.h>
+#include <sys/ioctl.h>
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "hw/vfio/vfio.h"
+#include "hw/vfio/vfio-common.h"
+#include "hw/s390x/s390-ccw.h"
+#include "hw/s390x/ccw-device.h"
+
+#define TYPE_VFIO_CCW "vfio-ccw"
+typedef struct VFIOCCWDevice {
+    S390CCWDevice cdev;
+    VFIODevice vdev;
+} VFIOCCWDevice;
+
+static void vfio_ccw_compute_needs_reset(VFIODevice *vdev)
+{
+    vdev->needs_reset = false;
+}
+
+/*
+ * We don't need vfio_hot_reset_multi and vfio_eoi operations for
+ * vfio_ccw device now.
+ */
+struct VFIODeviceOps vfio_ccw_ops = {
+    .vfio_compute_needs_reset = vfio_ccw_compute_needs_reset,
+};
+
+static void vfio_ccw_reset(DeviceState *dev)
+{
+    CcwDevice *ccw_dev = DO_UPCAST(CcwDevice, parent_obj, dev);
+    S390CCWDevice *cdev = DO_UPCAST(S390CCWDevice, parent_obj, ccw_dev);
+    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
+
+    ioctl(vcdev->vdev.fd, VFIO_DEVICE_RESET);
+}
+
+static void vfio_put_device(VFIOCCWDevice *vcdev)
+{
+    g_free(vcdev->vdev.name);
+    vfio_put_base_device(&vcdev->vdev);
+}
+
+static VFIOGroup *vfio_ccw_get_group(S390CCWDevice *cdev, Error **errp)
+{
+    char *tmp, group_path[PATH_MAX];
+    ssize_t len;
+    int groupid;
+
+    tmp = g_strdup_printf("/sys/bus/css/devices/%x.%x.%04x/%s/iommu_group",
+                          cdev->hostid.cssid, cdev->hostid.ssid,
+                          cdev->hostid.devid, cdev->mdevid);
+    len = readlink(tmp, group_path, sizeof(group_path));
+    g_free(tmp);
+
+    if (len <= 0 || len >= sizeof(group_path)) {
+        error_setg(errp, "vfio: no iommu_group found");
+        return NULL;
+    }
+
+    group_path[len] = 0;
+
+    if (sscanf(basename(group_path), "%d", &groupid) != 1) {
+        error_setg(errp, "vfio: failed to read %s", group_path);
+        return NULL;
+    }
+
+    return vfio_get_group(groupid, &address_space_memory, errp);
+}
+
+static void vfio_ccw_realize(DeviceState *dev, Error **errp)
+{
+    VFIODevice *vbasedev;
+    VFIOGroup *group;
+    CcwDevice *ccw_dev = DO_UPCAST(CcwDevice, parent_obj, dev);
+    S390CCWDevice *cdev = DO_UPCAST(S390CCWDevice, parent_obj, ccw_dev);
+    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
+    S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
+    Error *err = NULL;
+
+    /* Call the class init function for subchannel. */
+    if (cdc->realize) {
+        cdc->realize(cdev, vcdev->vdev.sysfsdev, &err);
+        if (err) {
+            goto out_err_propagate;
+        }
+    }
+
+    group = vfio_ccw_get_group(cdev, &err);
+    if (!group) {
+        goto out_group_err;
+    }
+
+    vcdev->vdev.ops = &vfio_ccw_ops;
+    vcdev->vdev.type = VFIO_DEVICE_TYPE_CCW;
+    vcdev->vdev.name = g_strdup_printf("%x.%x.%04x", cdev->hostid.cssid,
+                                       cdev->hostid.ssid, cdev->hostid.devid);
+    QLIST_FOREACH(vbasedev, &group->device_list, next) {
+        if (strcmp(vbasedev->name, vcdev->vdev.name) == 0) {
+            error_setg(&err, "vfio: subchannel %s has already been attached",
+                       vcdev->vdev.name);
+            goto out_device_err;
+        }
+    }
+
+    if (vfio_get_device(group, cdev->mdevid, &vcdev->vdev, &err)) {
+        goto out_device_err;
+    }
+
+    return;
+
+out_device_err:
+    vfio_put_group(group);
+out_group_err:
+    if (cdc->unrealize) {
+        cdc->unrealize(cdev, NULL);
+    }
+out_err_propagate:
+    error_propagate(errp, err);
+}
+
+static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
+{
+    CcwDevice *ccw_dev = DO_UPCAST(CcwDevice, parent_obj, dev);
+    S390CCWDevice *cdev = DO_UPCAST(S390CCWDevice, parent_obj, ccw_dev);
+    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
+    S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
+    VFIOGroup *group = vcdev->vdev.group;
+
+    vfio_put_device(vcdev);
+    vfio_put_group(group);
+
+    if (cdc->unrealize) {
+        cdc->unrealize(cdev, errp);
+    }
+}
+
+static Property vfio_ccw_properties[] = {
+    DEFINE_PROP_STRING("sysfsdev", VFIOCCWDevice, vdev.sysfsdev),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static const VMStateDescription vfio_ccw_vmstate = {
+    .name = TYPE_VFIO_CCW,
+    .unmigratable = 1,
+};
+
+static void vfio_ccw_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->props = vfio_ccw_properties;
+    dc->vmsd = &vfio_ccw_vmstate;
+    dc->desc = "VFIO-based subchannel assignment";
+    dc->realize = vfio_ccw_realize;
+    dc->unrealize = vfio_ccw_unrealize;
+    dc->reset = vfio_ccw_reset;
+}
+
+static const TypeInfo vfio_ccw_info = {
+    .name = TYPE_VFIO_CCW,
+    .parent = TYPE_S390_CCW,
+    .instance_size = sizeof(VFIOCCWDevice),
+    .class_init = vfio_ccw_class_init,
+};
+
+static void register_vfio_ccw_type(void)
+{
+    type_register_static(&vfio_ccw_info);
+}
+
+type_init(register_vfio_ccw_type)
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index c582de18c9..9521013d52 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -45,6 +45,7 @@
 enum {
     VFIO_DEVICE_TYPE_PCI = 0,
     VFIO_DEVICE_TYPE_PLATFORM = 1,
+    VFIO_DEVICE_TYPE_CCW = 2,
 };
 
 typedef struct VFIOMmap {
-- 
2.11.2
