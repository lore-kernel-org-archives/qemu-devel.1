Received: from eggs.gnu.org ([209.51.188.92]:34329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hFwXs-0000cC-SL
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 04:00:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hFwXr-0001S7-Nl
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 04:00:52 -0400
From: Like Xu <like.xu@linux.intel.com>
Date: Mon, 15 Apr 2019 15:59:45 +0800
Message-Id: <1555315185-16414-3-git-send-email-like.xu@linux.intel.com>
In-Reply-To: <1555315185-16414-1-git-send-email-like.xu@linux.intel.com>
References: <1555315185-16414-1-git-send-email-like.xu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v3 2/2] core/qdev: refactor qdev_get_machine()
 with type assertion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, like.xu@intel.com

To avoid the misuse of qdev_get_machine() if machine hasn't been created yet,
this patch uses qdev_get_machine_uncheck() for obj-common (share with user-only
mode) and adds type assertion to qdev_get_machine() in system-emulation mode.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 hw/core/qdev.c         | 16 +++++++++++++---
 include/hw/qdev-core.h |  1 +
 qom/cpu.c              |  5 +++--
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index f9b6efe..8232216 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -223,7 +223,7 @@ HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
 {
     MachineState *machine;
     MachineClass *mc;
-    Object *m_obj = qdev_get_machine();
+    Object *m_obj = qdev_get_machine_uncheck();
 
     if (object_dynamic_cast(m_obj, TYPE_MACHINE)) {
         machine = MACHINE(m_obj);
@@ -815,7 +815,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
         if (!obj->parent) {
             gchar *name = g_strdup_printf("device[%d]", unattached_count++);
 
-            object_property_add_child(container_get(qdev_get_machine(),
+            object_property_add_child(container_get(qdev_get_machine_uncheck(),
                                                     "/unattached"),
                                       name, obj, &error_abort);
             unattached_parent = true;
@@ -1095,7 +1095,7 @@ void device_reset(DeviceState *dev)
     }
 }
 
-Object *qdev_get_machine(void)
+Object *qdev_get_machine_uncheck(void)
 {
     static Object *dev;
 
@@ -1106,6 +1106,16 @@ Object *qdev_get_machine(void)
     return dev;
 }
 
+Object *qdev_get_machine(void)
+{
+    static Object *dev;
+
+    dev = qdev_get_machine_uncheck();
+    assert(object_dynamic_cast(dev, TYPE_MACHINE) != NULL);
+
+    return dev;
+}
+
 static const TypeInfo device_type_info = {
     .name = TYPE_DEVICE,
     .parent = TYPE_OBJECT,
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 33ed3b8..e7c6a5a 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -429,6 +429,7 @@ const struct VMStateDescription *qdev_get_vmsd(DeviceState *dev);
 
 const char *qdev_fw_name(DeviceState *dev);
 
+Object *qdev_get_machine_uncheck(void);
 Object *qdev_get_machine(void);
 
 /* FIXME: make this a link<> */
diff --git a/qom/cpu.c b/qom/cpu.c
index a8d2958..bb877d5 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -325,9 +325,10 @@ static void cpu_common_parse_features(const char *typename, char *features,
 static void cpu_common_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cpu = CPU(dev);
-    Object *machine = qdev_get_machine();
+    Object *machine = qdev_get_machine_uncheck();
 
-    /* qdev_get_machine() can return something that's not TYPE_MACHINE
+    /*
+     * qdev_get_machine_uncheck() can return something that's not TYPE_MACHINE
      * if this is one of the user-only emulators; in that case there's
      * no need to check the ignore_memory_transaction_failures board flag.
      */
-- 
1.8.3.1
