Received: from eggs.gnu.org ([2001:4830:134:3::10]:36418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSP7-000541-Jk
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSP6-0008Us-HR
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:57 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSP6-0006zA-8Q
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:56 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSOA-0007Ke-B8
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:54:58 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:31 +0000
Message-Id: <20181213145445.17935-24-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 23/37] core/sysbus: remove the
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

From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

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
Message-id: 20181130093852.20739-22-maozhongyi@cmss.chinamobile.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/sysbus.h |  3 ---
 hw/core/sysbus.c    | 15 +++++----------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index 0b59a3b8d60..1aedcf05c92 100644
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
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 7ac36ad3e70..9f9edbcab96 100644
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
-- 
2.19.2
