Received: from eggs.gnu.org ([2001:4830:134:3::10]:59220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gQDQM-00053N-N5
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:31:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gQDQJ-0005qE-Hx
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:31:17 -0500
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:29923)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gQDQF-0005EQ-RJ
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:31:13 -0500
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Fri, 23 Nov 2018 23:30:40 +0800
Message-Id: <20181123153040.18933-22-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181123153040.18933-1-maozhongyi@cmss.chinamobile.com>
References: <20181123153040.18933-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH v2 21/21] core/sysbus: remove the
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
 hw/core/sysbus.c    | 15 +++++----------
 include/hw/sysbus.h |  3 ---
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 7ac36ad3e7..9f9edbcab9 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -201,18 +201,13 @@ void sysbus_init_ioports(SysBusDevice *dev, uint32_t ioport, uint32_t size)
     }
 }
 
-/* TODO remove once all sysbus devices have been converted to realize */
+/* The purpose of preserving this empty realize function
+ * is to prevent the parent_realize field of some subclasses
+ * from being set to NULL to break the normal init/realize
+ * of some devices.
+ */
 static void sysbus_realize(DeviceState *dev, Error **errp)
 {
-    SysBusDevice *sd = SYS_BUS_DEVICE(dev);
-    SysBusDeviceClass *sbc = SYS_BUS_DEVICE_GET_CLASS(sd);
-
-    if (!sbc->init) {
-        return;
-    }
-    if (sbc->init(sd) < 0) {
-        error_setg(errp, "Device initialization failed");
-    }
 }
 
 DeviceState *sysbus_create_varargs(const char *name,
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
