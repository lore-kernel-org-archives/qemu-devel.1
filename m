Received: from eggs.gnu.org ([2001:4830:134:3::10]:54548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1f7n01-0005DW-LT
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 15:07:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1f7mzw-0005Dt-Hb
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 15:07:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60170
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1f7mzw-0005DB-C1
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 15:07:36 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3FIx3ag036222
	for <qemu-devel@nongnu.org>; Sun, 15 Apr 2018 15:07:35 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hbv1k4ahc-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 15 Apr 2018 15:07:35 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Sun, 15 Apr 2018 15:07:34 -0400
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Sun, 15 Apr 2018 15:07:21 -0400
In-Reply-To: <1523819244-29954-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1523819244-29954-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Message-Id: <1523819244-29954-3-git-send-email-akrowiak@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 2/5] s390x/ap: base Adjunct Processor (AP)
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net, akrowiak@linux.vnet.ibm.com

This patch introduces the base object for an AP device.

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 hw/s390x/Makefile.objs       |    1 +
 hw/s390x/ap-device.c         |   39 +++++++++++++++++++++++++++++++++++++++
 include/hw/s390x/ap-device.h |   38 ++++++++++++++++++++++++++++++++++++++
 ui/keycodemapdb              |    2 +-
 4 files changed, 79 insertions(+), 1 deletions(-)
 create mode 100644 hw/s390x/ap-device.c
 create mode 100644 include/hw/s390x/ap-device.h

diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index dc704b5..3247a07 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -17,3 +17,4 @@ obj-y += s390-stattrib.o
 obj-$(CONFIG_KVM) += s390-skeys-kvm.o
 obj-$(CONFIG_KVM) += s390-stattrib-kvm.o
 obj-y += s390-ccw.o
+obj-y += ap-device.o
diff --git a/hw/s390x/ap-device.c b/hw/s390x/ap-device.c
new file mode 100644
index 0000000..3cd4bae
--- /dev/null
+++ b/hw/s390x/ap-device.c
@@ -0,0 +1,39 @@
+/*
+ * Adjunct Processor (AP) matrix device
+ *
+ * Copyright 2018 IBM Corp.
+ * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "hw/qdev.h"
+#include "hw/s390x/ap-device.h"
+
+static void ap_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "AP device class";
+    dc->hotpluggable = false;
+}
+
+static const TypeInfo ap_device_info = {
+    .name = AP_DEVICE_TYPE,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(APDevice),
+    .class_size = sizeof(APDeviceClass),
+    .class_init = ap_class_init,
+    .abstract = true,
+};
+
+static void ap_device_register(void)
+{
+    type_register_static(&ap_device_info);
+}
+
+type_init(ap_device_register)
diff --git a/include/hw/s390x/ap-device.h b/include/hw/s390x/ap-device.h
new file mode 100644
index 0000000..693df90
--- /dev/null
+++ b/include/hw/s390x/ap-device.h
@@ -0,0 +1,38 @@
+/*
+ * Adjunct Processor (AP) matrix device interfaces
+ *
+ * Copyright 2018 IBM Corp.
+ * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+#ifndef HW_S390X_AP_DEVICE_H
+#define HW_S390X_AP_DEVICE_H
+
+#define AP_DEVICE_TYPE       "ap-device"
+
+typedef struct APDevice {
+    DeviceState parent_obj;
+} APDevice;
+
+typedef struct APDeviceClass {
+    DeviceClass parent_class;
+} APDeviceClass;
+
+static inline APDevice *to_ap_dev(DeviceState *dev)
+{
+    return container_of(dev, APDevice, parent_obj);
+}
+
+#define AP_DEVICE(obj) \
+    OBJECT_CHECK(APDevice, (obj), AP_DEVICE_TYPE)
+
+#define AP_DEVICE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(APDeviceClass, (obj), AP_DEVICE_TYPE)
+
+#define AP_DEVICE_CLASS(klass) \
+    OBJECT_CLASS_CHECK(APDeviceClass, (klass), AP_DEVICE_TYPE)
+
+#endif /* HW_S390X_AP_DEVICE_H */
diff --git a/ui/keycodemapdb b/ui/keycodemapdb
index 6b3d716..16e5b07 160000
--- a/ui/keycodemapdb
+++ b/ui/keycodemapdb
@@ -1 +1 @@
-Subproject commit 6b3d716e2b6472eb7189d3220552280ef3d832ce
+Subproject commit 16e5b0787687d8904dad2c026107409eb9bfcb95
-- 
1.7.1
