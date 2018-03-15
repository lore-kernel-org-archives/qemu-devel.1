Received: from eggs.gnu.org ([2001:4830:134:3::10]:48289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1ewcFQ-0001TT-N1
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 19:25:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1ewcFM-0008Uy-Iu
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 19:25:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41042
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1ewcFM-0008Ul-E4
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 19:25:20 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2FNLLwl002405
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 19:25:19 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gr0f348yv-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 19:25:19 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Thu, 15 Mar 2018 17:25:18 -0600
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Thu, 15 Mar 2018 19:24:55 -0400
In-Reply-To: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Message-Id: <1521156300-19296-3-git-send-email-akrowiak@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 2/7] s390x/ap: base Adjunct Processor (AP)
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
 hw/s390x/ap-device.c         |   38 ++++++++++++++++++++++++++++++++++++++
 include/hw/s390x/ap-device.h |   38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 0 deletions(-)
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
index 0000000..448f6db
--- /dev/null
+++ b/hw/s390x/ap-device.c
@@ -0,0 +1,38 @@
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
-- 
1.7.1
