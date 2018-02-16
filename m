Received: from eggs.gnu.org ([2001:4830:134:3::10]:59430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emgKG-0001BU-SB
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:45:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emgKF-0005Nu-SE
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:45:20 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1emgKF-0005NW-Hn
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:45:19 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Feb 2018 13:45:15 +0000
Message-Id: <20180216134516.6269-2-peter.maydell@linaro.org>
In-Reply-To: <20180216134516.6269-1-peter.maydell@linaro.org>
References: <20180216134516.6269-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] hw/sysbus.h: New sysbus_init_child()
 helper function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

If you're using the increasingly-common QOM style of
having container devices create their child objects
in-place, you end up with a lot of boilerplate in the
container's init function:

  object_initialize() to init the child
  object_property_add_child() to make the child a
    child of the parent
  qdev_set_parent_bus() to put the child on the
    sysbus default bus

If you forget the second of these then things sort of
work but trying to add a child to the child will segfault;
if you forget the third then the device won't get reset.

Provide a helper function sysbus_init_child() which
does all these things for you, reducing the boilerplate
and making it harder to get wrong.

Code that used to look like this:
    object_initialize(&s->ic, sizeof(s->ic), TYPE_BCM2835_IC);
    object_property_add_child(obj, "ic", OBJECT(&s->ic), NULL);
    qdev_set_parent_bus(DEVICE(&s->ic), sysbus_get_default());
can now look like this:
    sysbus_init_child(obj, "ic", &s->ic, sizeof(s->ic), TYPE_BCM2835_IC);

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/sysbus.h | 12 ++++++++++++
 hw/core/sysbus.c    | 14 ++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index e88bb6dae0..6095e24e86 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -118,4 +118,16 @@ static inline DeviceState *sysbus_try_create_simple(const char *name,
     return sysbus_try_create_varargs(name, addr, irq, NULL);
 }
 
+/**
+ * sysbus_init_child: in-place initialize and parent a SysBus device
+ * @parent: object to parent the device to
+ * @childname: name to use as the child property name
+ * @child: child object
+ * @childsize: size of the storage for the object
+ * @childtype: type name of the child
+ */
+void sysbus_init_child(Object *parent, const char *childname,
+                       void *child, size_t childsize,
+                       const char *childtype);
+
 #endif /* HW_SYSBUS_H */
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 5d0887f499..acfa52dc68 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -21,6 +21,7 @@
 #include "hw/sysbus.h"
 #include "monitor/monitor.h"
 #include "exec/address-spaces.h"
+#include "qapi/error.h"
 
 static void sysbus_dev_print(Monitor *mon, DeviceState *dev, int indent);
 static char *sysbus_get_fw_dev_path(DeviceState *dev);
@@ -372,6 +373,19 @@ BusState *sysbus_get_default(void)
     return main_system_bus;
 }
 
+void sysbus_init_child(Object *parent, const char *childname,
+                       void *child, size_t childsize,
+                       const char *childtype)
+{
+    object_initialize(child, childsize, childtype);
+    /* error_abort is fine here because this can only fail for
+     * programming-error reasons: child already parented, or
+     * parent already has a child with the given name.
+     */
+    object_property_add_child(parent, childname, OBJECT(child), &error_abort);
+    qdev_set_parent_bus(DEVICE(child), sysbus_get_default());
+}
+
 static void sysbus_register_types(void)
 {
     type_register_static(&system_bus_info);
-- 
2.16.1
