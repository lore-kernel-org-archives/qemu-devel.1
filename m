Received: from eggs.gnu.org ([2001:4830:134:3::10]:41028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dikl1-0004qb-JG
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:08:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dikl0-0003Rw-N5
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:08:27 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 18 Aug 2017 19:08:16 +0200
Message-Id: <1503076096-14220-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/arm/allwinner: Fix crash with -nodefaults
 -M cubieboard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Beniamino Galvani <b.galvani@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Li Guang <lig.fnst@cn.fujitsu.com>

The allwinner-a10 device uses serial_hds[0] without checking whether
it is available or not. So using the cubieboard with -nodefaults
currently results in a segmentation fault. Fix it by adding a
proper check here.
And while we're at it, mark the device as "user_creatable = false"
since this apparently can not directly be used by the users but has
to be wired up in code instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/allwinner-a10.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index f62a9a3..e152566 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -109,8 +109,10 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sata), 0, s->irq[56]);
 
     /* FIXME use a qdev chardev prop instead of serial_hds[] */
-    serial_mm_init(get_system_memory(), AW_A10_UART0_REG_BASE, 2, s->irq[1],
-                   115200, serial_hds[0], DEVICE_NATIVE_ENDIAN);
+    if (serial_hds[0]) {
+        serial_mm_init(get_system_memory(), AW_A10_UART0_REG_BASE, 2, s->irq[1],
+                       115200, serial_hds[0], DEVICE_NATIVE_ENDIAN);
+    }
 }
 
 static void aw_a10_class_init(ObjectClass *oc, void *data)
@@ -118,6 +120,8 @@ static void aw_a10_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = aw_a10_realize;
+    /* Reason: Needs to be wired up in code, see cubieboard_init() */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo aw_a10_type_info = {
-- 
1.8.3.1
