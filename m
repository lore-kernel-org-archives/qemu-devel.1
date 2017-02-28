Received: from eggs.gnu.org ([2001:4830:134:3::10]:47637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cijBP-0001VE-5I
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:55:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cijBO-0005dY-7x
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:55:19 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Feb 2017 14:55:08 +0000
Message-Id: <1488293711-14195-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1488293711-14195-1-git-send-email-peter.maydell@linaro.org>
References: <1488293711-14195-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/4] qdev: Have qdev_set_parent_bus() handle
 devices already on a bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Clement Deschamps <clement.deschamps@antfield.fr>, Paolo Bonzini <pbonzini@redhat.com>

Instead of qdev_set_parent_bus() silently doing the wrong
thing if it's handed a device that's already on a bus,
have it remove the device from the old bus and add it to
the new one. This is useful for the raspi2 sdcard.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/qdev.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 06ba02e..923e626 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -102,9 +102,23 @@ static void bus_add_child(BusState *bus, DeviceState *child)
 
 void qdev_set_parent_bus(DeviceState *dev, BusState *bus)
 {
+    bool replugging = dev->parent_bus != NULL;
+
+    if (replugging) {
+        /* Keep a reference to the device while it's not plugged into
+         * any bus, to avoid it potentially evaporating when it is
+         * dereffed in bus_remove_child().
+         */
+        object_ref(OBJECT(dev));
+        bus_remove_child(dev->parent_bus, dev);
+        object_unref(OBJECT(dev->parent_bus));
+    }
     dev->parent_bus = bus;
     object_ref(OBJECT(bus));
     bus_add_child(bus, dev);
+    if (replugging) {
+        object_unref(OBJECT(dev));
+    }
 }
 
 /* Create a new device.  This only initializes the device state
-- 
2.7.4
