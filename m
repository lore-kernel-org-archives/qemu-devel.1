Received: from eggs.gnu.org ([2001:4830:134:3::10]:57680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqjWl-0001kp-Ae
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:31:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqjWj-0006Nn-9U
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:31:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43011)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fqjWh-0006NH-9n
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:31:12 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 17 Aug 2018 15:30:25 -0300
Message-Id: <20180817183026.32662-3-ehabkost@redhat.com>
In-Reply-To: <20180817183026.32662-1-ehabkost@redhat.com>
References: <20180817183026.32662-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] sysbus: always allow
 explicit_ofw_unit_address() to override address generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Some SysBusDevices either use sysbus_init_mmio() without
sysbus_mmio_map() or the first MMIO memory region doesn't represent the
bus address, causing a firmware device path with an invalid address to
be generated.

SysBusDeviceClass does provide a virtual explicit_ofw_unit_address()
method that can be used to override this process, but it was originally intended
only as as a fallback option meaning that any existing MMIO memory regions still
take priority whilst determining the firmware device address.

There is currently only one user of explicit_ofw_unit_address() and that
is the PCI expander bridge (PXB) device which has no MMIO/PIO resources
defined. This enables us to allow explicit_ofw_unit_address() to take
priority without affecting backwards compatibility, allowing the address
to be customised as required.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Message-Id: <20180805112850.26063-2-mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/sysbus.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 3c8e53b188..7ac36ad3e7 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -293,16 +293,8 @@ static char *sysbus_get_fw_dev_path(DeviceState *dev)
 {
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
     SysBusDeviceClass *sbc = SYS_BUS_DEVICE_GET_CLASS(s);
-    /* for the explicit unit address fallback case: */
     char *addr, *fw_dev_path;
 
-    if (s->num_mmio) {
-        return g_strdup_printf("%s@" TARGET_FMT_plx, qdev_fw_name(dev),
-                               s->mmio[0].addr);
-    }
-    if (s->num_pio) {
-        return g_strdup_printf("%s@i%04x", qdev_fw_name(dev), s->pio[0]);
-    }
     if (sbc->explicit_ofw_unit_address) {
         addr = sbc->explicit_ofw_unit_address(s);
         if (addr) {
@@ -311,6 +303,13 @@ static char *sysbus_get_fw_dev_path(DeviceState *dev)
             return fw_dev_path;
         }
     }
+    if (s->num_mmio) {
+        return g_strdup_printf("%s@" TARGET_FMT_plx, qdev_fw_name(dev),
+                               s->mmio[0].addr);
+    }
+    if (s->num_pio) {
+        return g_strdup_printf("%s@i%04x", qdev_fw_name(dev), s->pio[0]);
+    }
     return g_strdup(qdev_fw_name(dev));
 }
 
-- 
2.18.0.rc1.1.g3f1ff2140
