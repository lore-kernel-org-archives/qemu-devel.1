Received: from eggs.gnu.org ([2001:4830:134:3::10]:57273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fWeFt-0007Ie-Rn
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 04:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fWeFq-0001mV-RS
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 04:50:49 -0400
Received: from chuckie.co.uk ([82.165.15.123]:44525
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fWeFq-0001kj-Kz
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 04:50:46 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sat, 23 Jun 2018 09:50:27 +0100
Message-Id: <20180623085028.29553-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180623085028.29553-1-mark.cave-ayland@ilande.co.uk>
References: <20180623085028.29553-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 1/2] sysbus: always allow
 explicit_ofw_unit_address() to override address generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lersek@redhat.com, marcel@redhat.com, armbru@redhat.com, mst@redhat.com

Some SysBusDevices either use sysbus_init_mmio() without sysbus_mmio_map() or
the first MMIO memory region doesn't represent the bus address, causing an invalid
firmware device path to be generated.

SysBusDeviceClass does provide a virtual explicit_ofw_unit_address() method that
can be used to override this process, but it is only considered as a fallback
option meaning that any existing MMIO memory regions still take priority whilst
determining the firmware device address.

As any class defining explicit_ofw_unit_address() has explicitly requested a
specialised behaviour then it should be used in preference to the default
implementation rather than being used as a fallback.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/core/sysbus.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index ecfb0cfc0e..1ee0c162f4 100644
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
2.11.0
