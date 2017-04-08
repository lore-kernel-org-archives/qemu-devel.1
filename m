Received: from eggs.gnu.org ([2001:4830:134:3::10]:42729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shah.suramya@gmail.com>) id 1cwrUX-00047N-CH
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 10:37:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shah.suramya@gmail.com>) id 1cwrUU-0001pi-6I
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 10:37:29 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:34474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shah.suramya@gmail.com>)
	id 1cwrUT-0001pe-Vd
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 10:37:26 -0400
Received: by mail-pg0-x243.google.com with SMTP id o123so20390293pga.1
	for <qemu-devel@nongnu.org>; Sat, 08 Apr 2017 07:37:25 -0700 (PDT)
From: Suramya Shah <shah.suramya@gmail.com>
Date: Sat,  8 Apr 2017 20:06:39 +0530
Message-Id: <20170408143639.2524-1-shah.suramya@gmail.com>
Subject: [Qemu-devel] [PATCH v2] hw/net: convert "dma" property type from
 ptr to link
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, Suramya Shah <shah.suramya@gmail.com>

The lance device needs pointer to ISA DMA device to operate. But according to
qdev-properties.h, properties of pointer type should be avoided.
A link type property is a good substitution.

Changes since v1
 -changed the code in hw/sparc/sun4m.c which uses the device.

Signed-off-by: Suramya Shah <shah.suramya@gmail.com>
---
 hw/net/lance.c   | 8 ++++++--
 hw/sparc/sun4m.c | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/net/lance.c b/hw/net/lance.c
index 573d724..3996b9c 100644
--- a/hw/net/lance.c
+++ b/hw/net/lance.c
@@ -44,6 +44,7 @@
 #include "pcnet.h"
 #include "trace.h"
 #include "sysemu/sysemu.h"
+#include "qapi/error.h"
 
 #define TYPE_LANCE "lance"
 #define SYSBUS_PCNET(obj) \
@@ -145,10 +146,14 @@ static void lance_instance_init(Object *obj)
     device_add_bootindex_property(obj, &s->conf.bootindex,
                                   "bootindex", "/ethernet-phy@0",
                                   DEVICE(obj), NULL);
+
+    object_property_add_link(obj, "dma", TYPE_LANCE,
+                             (Object **)&d->state.dma_opaque,
+                             qdev_prop_allow_set_link_before_realize,
+                             0, &error_abort);
 }
 
 static Property lance_properties[] = {
-    DEFINE_PROP_PTR("dma", SysBusPCNetState, state.dma_opaque),
     DEFINE_NIC_PROPERTIES(SysBusPCNetState, state.conf),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -164,7 +169,6 @@ static void lance_class_init(ObjectClass *klass, void *data)
     dc->reset = lance_reset;
     dc->vmsd = &vmstate_lance;
     dc->props = lance_properties;
-    /* Reason: pointer property "dma" */
     dc->cannot_instantiate_with_device_add_yet = true;
 }
 
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 873cd7d..9b3f5a5 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -336,7 +336,7 @@ static void lance_init(NICInfo *nd, hwaddr leaddr,
 
     dev = qdev_create(NULL, "lance");
     qdev_set_nic_properties(dev, nd);
-    qdev_prop_set_ptr(dev, "dma", dma_opaque);
+    object_property_set_link(OBJECT(dev), OBJECT(dma_opaque), "dma", NULL);
     qdev_init_nofail(dev);
     s = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(s, 0, leaddr);
-- 
2.9.3
