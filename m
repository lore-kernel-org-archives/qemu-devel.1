Received: from eggs.gnu.org ([2001:4830:134:3::10]:36667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSPU-0005P0-J2
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:56:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSPT-0000j2-LC
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:56:20 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSPT-0006zA-Ah
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:56:19 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO6-0007J4-Qe
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:54:54 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:24 +0000
Message-Id: <20181213145445.17935-17-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/37] nvram/ds1225y: Convert sysbus init
 function to realize function
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

Use DeviceClass rather than SysBusDeviceClass in
nvram_sysbus_class_init().

Cc: pbonzini@redhat.com
Cc: marcandre.lureau@redhat.com

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20181130093852.20739-15-maozhongyi@cmss.chinamobile.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/nvram/ds1225y.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/nvram/ds1225y.c b/hw/nvram/ds1225y.c
index ad7345f2882..b6ef463db0a 100644
--- a/hw/nvram/ds1225y.c
+++ b/hw/nvram/ds1225y.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "trace.h"
+#include "qemu/error-report.h"
 
 typedef struct {
     MemoryRegion iomem;
@@ -113,7 +114,7 @@ typedef struct {
     NvRamState nvram;
 } SysBusNvRamState;
 
-static int nvram_sysbus_initfn(SysBusDevice *dev)
+static void nvram_sysbus_realize(DeviceState *dev, Error **errp)
 {
     SysBusNvRamState *sys = DS1225Y(dev);
     NvRamState *s = &sys->nvram;
@@ -123,20 +124,18 @@ static int nvram_sysbus_initfn(SysBusDevice *dev)
 
     memory_region_init_io(&s->iomem, OBJECT(s), &nvram_ops, s,
                           "nvram", s->chip_size);
-    sysbus_init_mmio(dev, &s->iomem);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
 
     /* Read current file */
     file = s->filename ? fopen(s->filename, "rb") : NULL;
     if (file) {
         /* Read nvram contents */
         if (fread(s->contents, s->chip_size, 1, file) != 1) {
-            printf("nvram_sysbus_initfn: short read\n");
+            error_report("nvram_sysbus_realize: short read");
         }
         fclose(file);
     }
     nvram_post_load(s, 0);
-
-    return 0;
 }
 
 static Property nvram_sysbus_properties[] = {
@@ -148,9 +147,8 @@ static Property nvram_sysbus_properties[] = {
 static void nvram_sysbus_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = nvram_sysbus_initfn;
+    dc->realize = nvram_sysbus_realize;
     dc->vmsd = &vmstate_nvram;
     dc->props = nvram_sysbus_properties;
 }
-- 
2.19.2
