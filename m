Received: from eggs.gnu.org ([2001:4830:134:3::10]:54852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8KJ-0001dU-H6
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:19:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8KG-0000Np-E1
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:19:15 -0500
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Sat, 31 Dec 2016 09:18:29 +0800
Message-Id: <20161231011831.4097-3-zxq_yx_007@163.com>
In-Reply-To: <20161231011831.4097-1-zxq_yx_007@163.com>
References: <20161231011831.4097-1-zxq_yx_007@163.com>
Subject: [Qemu-devel] [PATCH 2/4] hw/ppc: QOM'ify e500.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de, peter.maydell@linaro.org, qemu-ppc@nongnu.org

Drop the old SysBus init function and use instance_init

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
---
 hw/ppc/e500.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index cf8b122afe..792bd79d39 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1049,27 +1049,18 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
     boot_info->dt_size = dt_size;
 }
 
-static int e500_ccsr_initfn(SysBusDevice *dev)
+static void e500_ccsr_initfn(Object *obj)
 {
-    PPCE500CCSRState *ccsr;
-
-    ccsr = CCSR(dev);
-    memory_region_init(&ccsr->ccsr_space, OBJECT(ccsr), "e500-ccsr",
+    PPCE500CCSRState *ccsr = CCSR(obj);
+    memory_region_init(&ccsr->ccsr_space, obj, "e500-ccsr",
                        MPC8544_CCSRBAR_SIZE);
-    return 0;
-}
-
-static void e500_ccsr_class_init(ObjectClass *klass, void *data)
-{
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
-    k->init = e500_ccsr_initfn;
 }
 
 static const TypeInfo e500_ccsr_info = {
     .name          = TYPE_CCSR,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(PPCE500CCSRState),
-    .class_init    = e500_ccsr_class_init,
+    .instance_init = e500_ccsr_initfn,
 };
 
 static void e500_register_types(void)
-- 
2.11.0
