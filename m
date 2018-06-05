Received: from eggs.gnu.org ([2001:4830:134:3::10]:58070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fQ83i-0001kx-Ds
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fQ83e-0004Vt-DH
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:15:18 -0400
Received: from [107.173.13.209] (port=41403 helo=ozlabs.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fQ83e-0004VH-0G
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:15:14 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue,  5 Jun 2018 19:15:08 +1000
Message-Id: <20180605091508.14129-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [RFC PATCH qemu] qdev: Use "string" for QOM string
 properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>

For QOM properties QEMU uses "string", for example:

{"execute": "qom-list", "arguments": {"path": "/machine"}}
[{'return': [{'type': 'string', 'name': 'append'},  {'type': 'string', 'name': 'kernel'}]

However for the device properties copied from DEVICE_CLASS(class)->props,
"str" is used for a type (vnet0 is "-device virtio-net-pci,id=vnet0"):

{"execute": "qom-list", "arguments": {"path": "/machine/peripheral/vnet0"}}
ret=[{'return': [{'name': 'tx', 'type': 'str'}]

This changes string type when adding them to QOM property list so
we get one string type in QMP.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

Not a huge improvement and might actually break something but since
I got that far I decided to post this anyway :)

The alternatives are: 1) do nothing 2) do this:

 const PropertyInfo qdev_prop_string = {
-    .name  = "str",
+    .name  = "string",
     .release = release_string,
     .get   = get_string,
     .set   = set_string,
 };


---
 hw/core/qdev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index f6f9247..2895693 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -687,7 +687,7 @@ static void qdev_property_add_legacy(DeviceState *dev, Property *prop,
     }
 
     name = g_strdup_printf("legacy-%s", prop->name);
-    object_property_add(OBJECT(dev), name, "str",
+    object_property_add(OBJECT(dev), name, "string",
                         prop->info->print ? qdev_get_legacy_property : prop->info->get,
                         NULL,
                         NULL,
@@ -711,6 +711,7 @@ void qdev_property_add_static(DeviceState *dev, Property *prop,
 {
     Error *local_err = NULL;
     Object *obj = OBJECT(dev);
+    const char *proptype;
 
     if (prop->info->create) {
         prop->info->create(obj, prop, &local_err);
@@ -723,7 +724,11 @@ void qdev_property_add_static(DeviceState *dev, Property *prop,
         if (!prop->info->get && !prop->info->set) {
             return;
         }
-        object_property_add(obj, prop->name, prop->info->name,
+        proptype = prop->info->name;
+        if (0 == strncmp(proptype, "str", 3)) {
+            proptype = "string";
+        }
+        object_property_add(obj, prop->name, proptype,
                             prop->info->get, prop->info->set,
                             prop->info->release,
                             prop, &local_err);
-- 
2.11.0
