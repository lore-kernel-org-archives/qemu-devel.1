Received: from eggs.gnu.org ([2001:4830:134:3::10]:60114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d6EJ6-0006vC-WC
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d6EIz-00061c-Ui
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:48:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d6EIz-000609-LA
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:48:17 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v44AiOLo130417
	for <qemu-devel@nongnu.org>; Thu, 4 May 2017 06:48:16 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a7ufatx9k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 06:48:16 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 4 May 2017 11:48:13 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Thu,  4 May 2017 12:48:01 +0200
In-Reply-To: <20170504104806.8120-1-cornelia.huck@de.ibm.com>
References: <20170504104806.8120-1-cornelia.huck@de.ibm.com>
Message-Id: <20170504104806.8120-4-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 3/8] s390x/3270: Add abstract emulated
 ccw-attached 3270 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Yang Chen <bjcyang@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Yang Chen <bjcyang@linux.vnet.ibm.com>

This introduces the infrastructure for the emulated 3270
devices, which will be attached to the virtual-css-bus.

Signed-off-by: Yang Chen <bjcyang@linux.vnet.ibm.com>
Signed-off-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
Reviewed-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/3270-ccw.c         | 99 +++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/Makefile.objs      |  1 +
 include/hw/s390x/3270-ccw.h | 44 ++++++++++++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 hw/s390x/3270-ccw.c
 create mode 100644 include/hw/s390x/3270-ccw.h

diff --git a/hw/s390x/3270-ccw.c b/hw/s390x/3270-ccw.c
new file mode 100644
index 0000000000..47b9e89bb7
--- /dev/null
+++ b/hw/s390x/3270-ccw.c
@@ -0,0 +1,99 @@
+/*
+ * Emulated ccw-attached 3270 implementation
+ *
+ * Copyright 2017 IBM Corp.
+ * Author(s): Yang Chen <bjcyang@linux.vnet.ibm.com>
+ *            Jing Liu <liujbjl@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "cpu.h"
+#include "hw/s390x/css.h"
+#include "hw/s390x/css-bridge.h"
+#include "hw/s390x/3270-ccw.h"
+
+static void emulated_ccw_3270_realize(DeviceState *ds, Error **errp)
+{
+    uint16_t chpid;
+    EmulatedCcw3270Device *dev = EMULATED_CCW_3270(ds);
+    EmulatedCcw3270Class *ck = EMULATED_CCW_3270_GET_CLASS(dev);
+    CcwDevice *cdev = CCW_DEVICE(ds);
+    CCWDeviceClass *cdk = CCW_DEVICE_GET_CLASS(cdev);
+    SubchDev *sch = css_create_virtual_sch(cdev->devno, errp);
+    Error *err = NULL;
+
+    if (!sch) {
+        return;
+    }
+
+    if (!ck->init) {
+        goto out_err;
+    }
+
+    sch->driver_data = dev;
+    cdev->sch = sch;
+    chpid = css_find_free_chpid(sch->cssid);
+
+    if (chpid > MAX_CHPID) {
+        error_setg(&err, "No available chpid to use.");
+        goto out_err;
+    }
+
+    sch->id.reserved = 0xff;
+    sch->id.cu_type = EMULATED_CCW_3270_CU_TYPE;
+    css_sch_build_virtual_schib(sch, (uint8_t)chpid,
+                                EMULATED_CCW_3270_CHPID_TYPE);
+
+    ck->init(dev, &err);
+    if (err) {
+        goto out_err;
+    }
+
+    cdk->realize(cdev, &err);
+    if (err) {
+        goto out_err;
+    }
+
+    return;
+
+out_err:
+    error_propagate(errp, err);
+    css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, NULL);
+    cdev->sch = NULL;
+    g_free(sch);
+}
+
+static Property emulated_ccw_3270_properties[] = {
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void emulated_ccw_3270_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->props = emulated_ccw_3270_properties;
+    dc->bus_type = TYPE_VIRTUAL_CSS_BUS;
+    dc->realize = emulated_ccw_3270_realize;
+    dc->hotpluggable = false;
+}
+
+static const TypeInfo emulated_ccw_3270_info = {
+    .name = TYPE_EMULATED_CCW_3270,
+    .parent = TYPE_CCW_DEVICE,
+    .instance_size = sizeof(EmulatedCcw3270Device),
+    .class_init = emulated_ccw_3270_class_init,
+    .class_size = sizeof(EmulatedCcw3270Class),
+    .abstract = true,
+};
+
+static void emulated_ccw_register(void)
+{
+    type_register_static(&emulated_ccw_3270_info);
+}
+
+type_init(emulated_ccw_register)
diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index 41ac4ec325..36bd4b1645 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -7,6 +7,7 @@ obj-y += sclpcpu.o
 obj-y += ipl.o
 obj-y += css.o
 obj-y += s390-virtio-ccw.o
+obj-y += 3270-ccw.o
 obj-y += virtio-ccw.o
 obj-y += css-bridge.o
 obj-y += ccw-device.o
diff --git a/include/hw/s390x/3270-ccw.h b/include/hw/s390x/3270-ccw.h
new file mode 100644
index 0000000000..45ea515e9f
--- /dev/null
+++ b/include/hw/s390x/3270-ccw.h
@@ -0,0 +1,44 @@
+/*
+ * Emulated ccw-attached 3270 definitions
+ *
+ * Copyright 2017 IBM Corp.
+ * Author(s): Yang Chen <bjcyang@linux.vnet.ibm.com>
+ *            Jing Liu <liujbjl@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef HW_S390X_3270_CCW_H
+#define HW_S390X_3270_CCW_H
+
+#include "hw/sysbus.h"
+#include "hw/s390x/css.h"
+#include "hw/s390x/ccw-device.h"
+
+#define EMULATED_CCW_3270_CU_TYPE 0x3270
+#define EMULATED_CCW_3270_CHPID_TYPE 0x1a
+
+#define TYPE_EMULATED_CCW_3270 "emulated-ccw-3270"
+#define EMULATED_CCW_3270(obj) \
+     OBJECT_CHECK(EmulatedCcw3270Device, (obj), TYPE_EMULATED_CCW_3270)
+#define EMULATED_CCW_3270_CLASS(klass) \
+     OBJECT_CLASS_CHECK(EmulatedCcw3270Class, (klass), TYPE_EMULATED_CCW_3270)
+#define EMULATED_CCW_3270_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(EmulatedCcw3270Class, (obj), TYPE_EMULATED_CCW_3270)
+
+typedef struct EmulatedCcw3270Device {
+    CcwDevice parent_obj;
+} EmulatedCcw3270Device;
+
+typedef struct EmulatedCcw3270Class {
+    CCWDeviceClass parent_class;
+
+    void (*init)(EmulatedCcw3270Device *, Error **);
+    int (*read_payload_3270)(EmulatedCcw3270Device *, uint32_t, uint16_t);
+    int (*write_payload_3270)(EmulatedCcw3270Device *, uint8_t, uint32_t,
+                              uint16_t);
+} EmulatedCcw3270Class;
+
+#endif
-- 
2.11.0
