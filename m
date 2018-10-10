Received: from eggs.gnu.org ([2001:4830:134:3::10]:41058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gAHti-0004UA-1T
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 13:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gAHte-0006Ny-Ob
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 13:03:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1gAHte-0006NT-Fo
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 13:03:42 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9AGxUkg136540
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 13:03:41 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2n1jqhgct6-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 13:03:41 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Wed, 10 Oct 2018 11:03:39 -0600
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Wed, 10 Oct 2018 13:03:06 -0400
In-Reply-To: <20181010170309.12045-1-akrowiak@linux.ibm.com>
References: <20181010170309.12045-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20181010170309.12045-5-akrowiak@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v11 4/6] s390x/ap: base Adjunct Processor (AP)
 object model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net, akrowiak@linux.vnet.ibm.com, fiuczy@linux.ibm.com, mimu@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>

Introduces the base object model for virtualizing AP devices.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Tested-by: Pierre Morel<pmorel@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
---
 MAINTAINERS                  | 12 ++++++
 hw/s390x/Makefile.objs       |  2 +
 hw/s390x/ap-bridge.c         | 78 ++++++++++++++++++++++++++++++++++++
 hw/s390x/ap-device.c         | 38 ++++++++++++++++++
 hw/s390x/s390-virtio-ccw.c   |  4 ++
 include/hw/s390x/ap-bridge.h | 19 +++++++++
 include/hw/s390x/ap-device.h | 22 ++++++++++
 7 files changed, 175 insertions(+)
 create mode 100644 hw/s390x/ap-bridge.c
 create mode 100644 hw/s390x/ap-device.c
 create mode 100644 include/hw/s390x/ap-bridge.h
 create mode 100644 include/hw/s390x/ap-device.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3275cc6bbed1..b9984242820b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1207,6 +1207,18 @@ F: include/hw/s390x/s390-ccw.h
 T: git git://github.com/cohuck/qemu.git s390-next
 L: qemu-s390x@nongnu.org
 
+vfio-ap
+M: Christian Borntraeger <borntraeger@de.ibm.com>
+M: Tony Krowiak <akrowiak@linux.ibm.com>
+M: Halil Pasic <pasic@linux.ibm.com>
+M: Pierre Morel <pmorel@linux.ibm.com>
+S: Supported
+F: hw/s390x/ap-device.c
+F: hw/s390x/ap-bridge.c
+F: include/hw/s390x/ap-device.h
+F: include/hw/s390x/ap-bridge.h
+L: qemu-s390x@nongnu.org
+
 vhost
 M: Michael S. Tsirkin <mst@redhat.com>
 S: Supported
diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index 5dbc00ce9b45..49cae2f5c4bd 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -31,3 +31,5 @@ obj-$(CONFIG_TCG) += tod-qemu.o
 obj-$(CONFIG_KVM) += s390-skeys-kvm.o
 obj-$(CONFIG_KVM) += s390-stattrib-kvm.o
 obj-y += s390-ccw.o
+obj-y += ap-device.o
+obj-y += ap-bridge.o
diff --git a/hw/s390x/ap-bridge.c b/hw/s390x/ap-bridge.c
new file mode 100644
index 000000000000..3795d30dd7c9
--- /dev/null
+++ b/hw/s390x/ap-bridge.c
@@ -0,0 +1,78 @@
+/*
+ * ap bridge
+ *
+ * Copyright 2018 IBM Corp.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "qemu/bitops.h"
+#include "hw/s390x/ap-bridge.h"
+#include "cpu.h"
+
+static char *ap_bus_get_dev_path(DeviceState *dev)
+{
+    /* at most one */
+    return g_strdup_printf("/1");
+}
+
+static void ap_bus_class_init(ObjectClass *oc, void *data)
+{
+    BusClass *k = BUS_CLASS(oc);
+
+    k->get_dev_path = ap_bus_get_dev_path;
+    /* More than one ap device does not make sense */
+    k->max_dev = 1;
+}
+
+static const TypeInfo ap_bus_info = {
+    .name = TYPE_AP_BUS,
+    .parent = TYPE_BUS,
+    .instance_size = 0,
+    .class_init = ap_bus_class_init,
+};
+
+void s390_init_ap(void)
+{
+    DeviceState *dev;
+
+    /* If no AP instructions then no need for AP bridge */
+    if (!s390_has_feat(S390_FEAT_AP)) {
+        return;
+    }
+
+    /* Create bridge device */
+    dev = qdev_create(NULL, TYPE_AP_BRIDGE);
+    object_property_add_child(qdev_get_machine(), TYPE_AP_BRIDGE,
+                              OBJECT(dev), NULL);
+    qdev_init_nofail(dev);
+
+    /* Create bus on bridge device */
+    qbus_create(TYPE_AP_BUS, dev, TYPE_AP_BUS);
+ }
+
+static void ap_bridge_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+}
+
+static const TypeInfo ap_bridge_info = {
+    .name          = TYPE_AP_BRIDGE,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = 0,
+    .class_init    = ap_bridge_class_init,
+};
+
+static void ap_register(void)
+{
+    type_register_static(&ap_bridge_info);
+    type_register_static(&ap_bus_info);
+}
+
+type_init(ap_register)
diff --git a/hw/s390x/ap-device.c b/hw/s390x/ap-device.c
new file mode 100644
index 000000000000..f5ac8db96826
--- /dev/null
+++ b/hw/s390x/ap-device.c
@@ -0,0 +1,38 @@
+/*
+ * Adjunct Processor (AP) matrix device
+ *
+ * Copyright 2018 IBM Corp.
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
+    .class_size = sizeof(DeviceClass),
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
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 53fd7c975f64..a0615a8b35f5 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -32,6 +32,7 @@
 #include "ipl.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/css-bridge.h"
+#include "hw/s390x/ap-bridge.h"
 #include "migration/register.h"
 #include "cpu_models.h"
 #include "hw/nmi.h"
@@ -263,6 +264,9 @@ static void ccw_init(MachineState *machine)
     /* init the SIGP facility */
     s390_init_sigp();
 
+    /* create AP bridge and bus(es) */
+    s390_init_ap();
+
     /* get a BUS */
     css_bus = virtual_css_bus_init();
     s390_init_ipl_dev(machine->kernel_filename, machine->kernel_cmdline,
diff --git a/include/hw/s390x/ap-bridge.h b/include/hw/s390x/ap-bridge.h
new file mode 100644
index 000000000000..470e439a98ed
--- /dev/null
+++ b/include/hw/s390x/ap-bridge.h
@@ -0,0 +1,19 @@
+/*
+ * ap bridge
+ *
+ * Copyright 2018 IBM Corp.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef HW_S390X_AP_BRIDGE_H
+#define HW_S390X_AP_BRIDGE_H
+
+#define TYPE_AP_BRIDGE "ap-bridge"
+#define TYPE_AP_BUS "ap-bus"
+
+void s390_init_ap(void);
+
+#endif
diff --git a/include/hw/s390x/ap-device.h b/include/hw/s390x/ap-device.h
new file mode 100644
index 000000000000..765e9082a3db
--- /dev/null
+++ b/include/hw/s390x/ap-device.h
@@ -0,0 +1,22 @@
+/*
+ * Adjunct Processor (AP) matrix device interfaces
+ *
+ * Copyright 2018 IBM Corp.
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
+#define AP_DEVICE(obj) \
+    OBJECT_CHECK(APDevice, (obj), AP_DEVICE_TYPE)
+
+#endif /* HW_S390X_AP_DEVICE_H */
-- 
2.19.0.221.g150f307
