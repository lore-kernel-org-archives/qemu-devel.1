Received: from eggs.gnu.org ([2001:4830:134:3::10]:43365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cilO1-0001kj-Ny
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:16:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cilO1-00037w-28
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:16:29 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cilO0-00034e-Rs
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:16:28 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cilNz-0003Vm-Qi
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:16:27 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Feb 2017 17:16:13 +0000
Message-Id: <1488302176-19463-19-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1488302176-19463-1-git-send-email-peter.maydell@linaro.org>
References: <1488302176-19463-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 18/21] qdev: Have qdev_set_parent_bus() handle
 devices already on a bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Instead of qdev_set_parent_bus() silently doing the wrong
thing if it's handed a device that's already on a bus,
have it remove the device from the old bus and add it to
the new one. This is useful for the raspi2 sdcard.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-id: 1488293711-14195-2-git-send-email-peter.maydell@linaro.org
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
