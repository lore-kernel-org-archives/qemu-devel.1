Received: from eggs.gnu.org ([2001:4830:134:3::10]:57592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1coiQq-0007vF-Pr
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 23:20:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1coiQl-0000p4-SB
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 23:20:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45291
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1coiQl-0000ny-Lt
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 23:19:55 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2H3JJBq008044
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 23:19:55 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 297seue3w3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 23:19:54 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 16 Mar 2017 21:19:54 -0600
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Fri, 17 Mar 2017 04:19:22 +0100
In-Reply-To: <20170317031928.40189-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170317031928.40189-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170317031928.40189-6-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 05/11] s390x/css: device support for
 s390-ccw passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

In order to support subchannels pass-through, we introduce a s390
subchannel device called "s390-ccw" to hold the real subchannel info.
The s390-ccw devices inherit from the abstract CcwDevice which connect
to the existing virtual-css-bus.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 hw/s390x/Makefile.objs |   1 +
 hw/s390x/s390-ccw.c    | 125 +++++++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/s390-ccw.h    |  38 +++++++++++++++
 3 files changed, 164 insertions(+)
 create mode 100644 hw/s390x/s390-ccw.c
 create mode 100644 hw/s390x/s390-ccw.h

diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index 41ac4ec..72a3d37 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -13,3 +13,4 @@ obj-y += ccw-device.o
 obj-y += s390-pci-bus.o s390-pci-inst.o
 obj-y += s390-skeys.o
 obj-$(CONFIG_KVM) += s390-skeys-kvm.o
+obj-y += s390-ccw.o
diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
new file mode 100644
index 0000000..9b6de68
--- /dev/null
+++ b/hw/s390x/s390-ccw.c
@@ -0,0 +1,125 @@
+/*
+ * s390 CCW Assignment Support
+ *
+ * Copyright 2017 IBM Corp
+ * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+ *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
+ *            Pierre Morel <pmorel@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2
+ * or (at your option) any later version. See the COPYING file in the
+ * top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "libgen.h"
+#include "hw/s390x/css.h"
+#include "hw/s390x/css-bridge.h"
+#include "s390-ccw.h"
+
+static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
+                                  char *sysfsdev,
+                                  Error **errp)
+{
+    char dev_path[PATH_MAX], *tmp;
+    unsigned int cssid, ssid, devid;
+
+    if (!sysfsdev) {
+        error_setg(errp, "No host device provided");
+        error_append_hint(errp, "Use -vfio-ccw,sysfsdev=PATH_TO_DEVICE\n");
+        return;
+    }
+
+    if (!realpath(sysfsdev, dev_path)) {
+        error_setg(errp, "Host device '%s' not found", sysfsdev);
+        return;
+    }
+
+    cdev->mdevid = g_strdup(basename(dev_path));
+
+    tmp = basename(dirname(dev_path));
+    sscanf(tmp, "%2x.%1x.%4x", &cssid, &ssid, &devid);
+
+    cdev->hostid.cssid = cssid;
+    cdev->hostid.ssid = ssid;
+    cdev->hostid.devid = devid;
+    cdev->hostid.valid = true;
+}
+
+static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
+{
+    CcwDevice *ccw_dev = CCW_DEVICE(cdev);
+    DeviceState *parent = DEVICE(ccw_dev);
+    BusState *qbus = qdev_get_parent_bus(parent);
+    VirtualCssBus *cbus = VIRTUAL_CSS_BUS(qbus);
+    SubchDev *sch;
+    int ret;
+
+    s390_ccw_get_dev_info(cdev, sysfsdev, errp);
+    if (*errp) {
+        return;
+    }
+
+    sch = css_create_sch(ccw_dev->bus_id, false, cbus->squash_mcss, errp);
+    if (!sch) {
+        return;
+    }
+
+    sch->driver_data = cdev;
+
+    ret = css_sch_build_schib(sch, &cdev->hostid);
+    if (ret) {
+        error_setg(errp, "%s: Failed to build initial schib: %d",
+                   __func__, ret);
+        css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, NULL);
+        g_free(sch);
+        return;
+    }
+    css_generate_sch_crws(sch->cssid, sch->ssid, sch->schid,
+                          parent->hotplugged, 1);
+
+    ccw_dev->sch = sch;
+
+    return;
+}
+
+static void s390_ccw_unrealize(S390CCWDevice *cdev, Error **errp)
+{
+    CcwDevice *ccw_dev = CCW_DEVICE(cdev);
+    SubchDev *sch = ccw_dev->sch;
+
+    if (sch) {
+        css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, NULL);
+        g_free(sch);
+        ccw_dev->sch = NULL;
+    }
+
+    g_free(cdev->mdevid);
+}
+
+static void s390_ccw_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    S390CCWDeviceClass *cdc = S390_CCW_DEVICE_CLASS(klass);
+
+    dc->bus_type = TYPE_VIRTUAL_CSS_BUS;
+    cdc->realize = s390_ccw_realize;
+    cdc->unrealize = s390_ccw_unrealize;
+}
+
+static const TypeInfo s390_ccw_info = {
+    .name          = TYPE_S390_CCW,
+    .parent        = TYPE_CCW_DEVICE,
+    .instance_size = sizeof(S390CCWDevice),
+    .class_size    = sizeof(S390CCWDeviceClass),
+    .class_init    = s390_ccw_class_init,
+    .abstract      = true,
+};
+
+static void register_s390_ccw_type(void)
+{
+    type_register_static(&s390_ccw_info);
+}
+
+type_init(register_s390_ccw_type)
diff --git a/hw/s390x/s390-ccw.h b/hw/s390x/s390-ccw.h
new file mode 100644
index 0000000..b58d8e9
--- /dev/null
+++ b/hw/s390x/s390-ccw.h
@@ -0,0 +1,38 @@
+/*
+ * s390 CCW Assignment Support
+ *
+ * Copyright 2017 IBM Corp.
+ * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+ *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef HW_S390_CCW_H
+#define HW_S390_CCW_H
+
+#include "hw/s390x/ccw-device.h"
+
+#define TYPE_S390_CCW "s390-ccw"
+#define S390_CCW_DEVICE(obj) \
+    OBJECT_CHECK(S390CCWDevice, (obj), TYPE_S390_CCW)
+#define S390_CCW_DEVICE_CLASS(klass) \
+    OBJECT_CLASS_CHECK(S390CCWDeviceClass, (klass), TYPE_S390_CCW)
+#define S390_CCW_DEVICE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(S390CCWDeviceClass, (obj), TYPE_S390_CCW)
+
+typedef struct S390CCWDevice {
+    CcwDevice parent_obj;
+    CssDevId hostid;
+    char *mdevid;
+} S390CCWDevice;
+
+typedef struct S390CCWDeviceClass {
+    CCWDeviceClass parent_class;
+    void (*realize)(S390CCWDevice *dev, char *sysfsdev, Error **errp);
+    void (*unrealize)(S390CCWDevice *dev, Error **errp);
+} S390CCWDeviceClass;
+
+#endif
-- 
2.8.4
