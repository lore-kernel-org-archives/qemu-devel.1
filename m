Received: from eggs.gnu.org ([2001:4830:134:3::10]:52865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMS-0001pI-UJ
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:09:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMQ-00030q-82
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:09:04 -0500
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:55551)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMP-0002xC-FH
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:09:02 -0500
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Mon, 19 Nov 2018 20:08:20 +0800
Message-Id: <20181119120820.29878-23-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH 22/22] core/sysbus: remove the
 SysBusDeviceClass::init path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, ehabkost@redhat.com, thuth@redhat.com, pbonzini@redhat.com, armbru@redhat.com, peter.maydell@linaro.org, richard.henderson@linaro.org, alistair.francis@wdc.com, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Currently, all sysbus devices have been converted to realize(),
so remove this path.

Cc: ehabkost@redhat.com
Cc: thuth@redhat.com
Cc: pbonzini@redhat.com
Cc: armbru@redhat.com
Cc: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org
Cc: alistair.francis@wdc.com

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
---
 hw/core/sysbus.c    | 15 ---------------
 include/hw/sysbus.h |  3 ---
 2 files changed, 18 deletions(-)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 7ac36ad3e7..030ad426c1 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -201,20 +201,6 @@ void sysbus_init_ioports(SysBusDevice *dev, uint32_t ioport, uint32_t size)
     }
 }
 
-/* TODO remove once all sysbus devices have been converted to realize */
-static void sysbus_realize(DeviceState *dev, Error **errp)
-{
-    SysBusDevice *sd = SYS_BUS_DEVICE(dev);
-    SysBusDeviceClass *sbc = SYS_BUS_DEVICE_GET_CLASS(sd);
-
-    if (!sbc->init) {
-        return;
-    }
-    if (sbc->init(sd) < 0) {
-        error_setg(errp, "Device initialization failed");
-    }
-}
-
 DeviceState *sysbus_create_varargs(const char *name,
                                    hwaddr addr, ...)
 {
@@ -327,7 +313,6 @@ MemoryRegion *sysbus_address_space(SysBusDevice *dev)
 static void sysbus_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
-    k->realize = sysbus_realize;
     k->bus_type = TYPE_SYSTEM_BUS;
     /*
      * device_add plugs devices into a suitable bus.  For "real" buses,
diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index 0b59a3b8d6..1aedcf05c9 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -38,9 +38,6 @@ typedef struct SysBusDevice SysBusDevice;
 typedef struct SysBusDeviceClass {
     /*< private >*/
     DeviceClass parent_class;
-    /*< public >*/
-
-    int (*init)(SysBusDevice *dev);
 
     /*
      * Let the sysbus device format its own non-PIO, non-MMIO unit address.
-- 
2.17.1
