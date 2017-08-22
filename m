Received: from eggs.gnu.org ([2001:4830:134:3::10]:52298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkAl6-0003aJ-Ss
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:06:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkAl6-0001nf-0a
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:06:24 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 22 Aug 2017 17:06:15 +0200
Message-Id: <1503414375-21009-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/misc/auxbus.c: Mark the aux-to-i2c-bridge
 device as non-hotpluggable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, KONRAD Frederic <frederic.konrad@adacore.com>, qemu-trivial@nongnu.org

QEMU currently aborts if the user tries to do something like this:

$ aarch64-softmmu/qemu-system-aarch64 -S -M integratorcp -nographic
QEMU 2.9.93 monitor - type 'help' for more information
(qemu) device_add aux-to-i2c-bridge,id=x
(qemu) device_del x
**
ERROR:qemu/qdev-monitor.c:872:qdev_unplug: assertion failed: (hotplug_ctrl)
Aborted (core dumped)

Looks like the device is not hot-pluggable, so let's mark it
accordingly.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/misc/auxbus.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index 8a90ddd..2c62515 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -222,9 +222,17 @@ static inline I2CBus *aux_bridge_get_i2c_bus(AUXTOI2CState *bridge)
     return bridge->i2c_bus;
 }
 
+static void aux_bridge_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->hotpluggable = false;
+}
+
 static const TypeInfo aux_to_i2c_type_info = {
     .name = TYPE_AUXTOI2C,
     .parent = TYPE_DEVICE,
+    .class_init = aux_bridge_class_init,
     .instance_size = sizeof(AUXTOI2CState),
     .instance_init = aux_bridge_init
 };
-- 
1.8.3.1
