Received: from eggs.gnu.org ([2001:4830:134:3::10]:53670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gHRyC-0000xu-LB
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gHRy9-00085Y-6r
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:14:00 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 30 Oct 2018 12:13:46 +0100
Message-Id: <20181030111348.14713-3-kraxel@redhat.com>
In-Reply-To: <20181030111348.14713-1-kraxel@redhat.com>
References: <20181030111348.14713-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] add QemuSupportState to DeviceClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

So we can tag device support state.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/qdev-core.h | 2 ++
 hw/core/qdev.c         | 8 +++++++-
 qdev-monitor.c         | 7 +++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index a24d0dd566..ff6bd3f08f 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -3,6 +3,7 @@
 
 #include "qemu/queue.h"
 #include "qemu/bitmap.h"
+#include "qemu/support-state.h"
 #include "qom/object.h"
 #include "hw/irq.h"
 #include "hw/hotplug.h"
@@ -105,6 +106,7 @@ typedef struct DeviceClass {
      */
     bool user_creatable;
     bool hotpluggable;
+    QemuSupportState supported;
 
     /* callbacks */
     DeviceReset reset;
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 6b3cc55b27..e788fca257 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -133,11 +133,17 @@ DeviceState *qdev_create(BusState *bus, const char *name)
 
 DeviceState *qdev_try_create(BusState *bus, const char *type)
 {
+    DeviceClass *dc;
     DeviceState *dev;
 
-    if (object_class_by_name(type) == NULL) {
+    dc = DEVICE_CLASS(object_class_by_name(type));
+    if (dc == NULL) {
         return NULL;
     }
+    if (qemu_is_deprecated(&dc->supported) ||
+        qemu_is_obsolete(&dc->supported)) {
+        qemu_warn_support_state("device", type, &dc->supported);
+    }
     dev = DEVICE(object_new(type));
     if (!dev) {
         return NULL;
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 802c18a74e..63cb43691c 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -128,6 +128,9 @@ static void qdev_print_devinfo(DeviceClass *dc)
     if (!dc->user_creatable) {
         out_printf(", no-user");
     }
+    if (dc->supported.state != SUPPORT_STATE_UNKNOWN) {
+        out_printf(", %s", SupportState_str(dc->supported.state));
+    }
     out_printf("\n");
 }
 
@@ -579,6 +582,10 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
     if (!dc) {
         return NULL;
     }
+    if (qemu_is_deprecated(&dc->supported) ||
+        qemu_is_obsolete(&dc->supported)) {
+        qemu_warn_support_state("device", driver, &dc->supported);
+    }
 
     /* find bus */
     path = qemu_opt_get(opts, "bus");
-- 
2.9.3
