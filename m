Received: from eggs.gnu.org ([2001:4830:134:3::10]:58804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gQDQ8-0004nd-3I
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:31:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gQDQ5-0005IE-1m
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:31:03 -0500
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:27228)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gQDQ4-00059H-53
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:31:00 -0500
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Fri, 23 Nov 2018 23:30:33 +0800
Message-Id: <20181123153040.18933-15-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181123153040.18933-1-maozhongyi@cmss.chinamobile.com>
References: <20181123153040.18933-1-maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 14/21] nvram/ds1225y: Convert sysbus init
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
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, pbonzini@redhat.com, marcandre.lureau@redhat.com, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Use DeviceClass rather than SysBusDeviceClass in
nvram_sysbus_class_init().

Cc: pbonzini@redhat.com
Cc: marcandre.lureau@redhat.com

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/nvram/ds1225y.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/nvram/ds1225y.c b/hw/nvram/ds1225y.c
index ad7345f288..b6ef463db0 100644
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
2.17.1
