Received: from eggs.gnu.org ([2001:4830:134:3::10]:46814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUkB-0003Bg-5I
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:04:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk8-0006i0-8t
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:59 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:03:03 +1100
Message-Id: <20170112020327.24882-44-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 43/67] hw/ppc: QOM'ify e500.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, xiaoqiang zhao <zxq_yx_007@163.com>, David Gibson <david@gibson.dropbear.id.au>

From: xiaoqiang zhao <zxq_yx_007@163.com>

Drop the old SysBus init function and use instance_init

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/e500.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index cf8b122..792bd79 100644
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
2.9.3
