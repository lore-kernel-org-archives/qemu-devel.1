Received: from eggs.gnu.org ([209.51.188.92]:39620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJkYT-0005l5-K7
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJkYQ-0007My-Et
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:01:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJkYQ-0006XE-5A
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:01:10 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 25 Apr 2019 17:00:51 -0300
Message-Id: <20190425200051.19906-5-ehabkost@redhat.com>
In-Reply-To: <20190425200051.19906-1-ehabkost@redhat.com>
References: <20190425200051.19906-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] qdev-hotplug: Don't check type of
 qdev_get_machine()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Like Xu <like.xu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>

Now that qdev_get_machine_hotplug_handler() is only compiled in
softmmu mode, we don't need to check if qdev_gt_machine() is
really of type TYPE_MACHINE.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/qdev-hotplug.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/hw/core/qdev-hotplug.c b/hw/core/qdev-hotplug.c
index 8ab31043a7..017500c1e1 100644
--- a/hw/core/qdev-hotplug.c
+++ b/hw/core/qdev-hotplug.c
@@ -35,16 +35,11 @@ void qbus_set_bus_hotplug_handler(BusState *bus, Error **errp)
 
 HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
 {
-    MachineState *machine;
-    MachineClass *mc;
-    Object *m_obj = qdev_get_machine();
+    MachineState *machine = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
 
-    if (object_dynamic_cast(m_obj, TYPE_MACHINE)) {
-        machine = MACHINE(m_obj);
-        mc = MACHINE_GET_CLASS(machine);
-        if (mc->get_hotplug_handler) {
-            return mc->get_hotplug_handler(machine, dev);
-        }
+    if (mc->get_hotplug_handler) {
+        return mc->get_hotplug_handler(machine, dev);
     }
 
     return NULL;
-- 
2.18.0.rc1.1.g3f1ff2140
