Received: from eggs.gnu.org ([2001:4830:134:3::10]:45965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gPiY3-0002yO-Ba
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 01:33:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gPiY2-0001py-Cq
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 01:33:11 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gPiY2-0001oW-6d
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 01:33:10 -0500
Received: by mail-pf1-x442.google.com with SMTP id b7so1435558pfi.8
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 22:33:10 -0800 (PST)
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 21 Nov 2018 22:32:52 -0800
Message-Id: <1542868372-2602-3-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1542868372-2602-1-git-send-email-liq3ea@gmail.com>
References: <1542868372-2602-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH 2/2] hw: vmmouse: drop DEFINE_PROP_PTR()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, mark.cave-ayland@ilande.co.uk
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

Use link property instead.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/i386/pc.c      |  2 +-
 hw/i386/vmmouse.c | 17 +++++++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5d3fd86b83..9b343b4fd1 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1549,7 +1549,7 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl, bool no_vmport)
     }
     if (vmmouse) {
         DeviceState *dev = DEVICE(vmmouse);
-        qdev_prop_set_ptr(dev, "ps2_mouse", i8042);
+        object_property_set_link(OBJECT(dev), OBJECT(i8042), "ps2_mouse", NULL);
         qdev_init_nofail(dev);
     }
     port92 = isa_create_simple(isa_bus, TYPE_PORT92);
diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index 5d2d278be4..612675d651 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -27,6 +27,7 @@
 #include "hw/i386/pc.h"
 #include "hw/input/i8042.h"
 #include "hw/qdev.h"
+#include "qapi/error.h"
 
 /* debug only vmmouse */
 //#define DEBUG_VMMOUSE
@@ -272,10 +273,15 @@ static void vmmouse_realizefn(DeviceState *dev, Error **errp)
     vmport_register(VMMOUSE_DATA, vmmouse_ioport_read, s);
 }
 
-static Property vmmouse_properties[] = {
-    DEFINE_PROP_PTR("ps2_mouse", VMMouseState, ps2_mouse),
-    DEFINE_PROP_END_OF_LIST(),
-};
+static void vmmouse_instance_initfn(Object *obj)
+{
+    VMMouseState *s = VMMOUSE(obj);
+
+    object_property_add_link(obj, "ps2_mouse", TYPE_I8042,
+                             (Object **)&s->ps2_mouse,
+                             qdev_prop_allow_set_link_before_realize,
+                             0, &error_abort);
+}
 
 static void vmmouse_class_initfn(ObjectClass *klass, void *data)
 {
@@ -284,8 +290,6 @@ static void vmmouse_class_initfn(ObjectClass *klass, void *data)
     dc->realize = vmmouse_realizefn;
     dc->reset = vmmouse_reset;
     dc->vmsd = &vmstate_vmmouse;
-    dc->props = vmmouse_properties;
-    /* Reason: pointer property "ps2_mouse" */
     dc->user_creatable = false;
 }
 
@@ -293,6 +297,7 @@ static const TypeInfo vmmouse_info = {
     .name          = TYPE_VMMOUSE,
     .parent        = TYPE_ISA_DEVICE,
     .instance_size = sizeof(VMMouseState),
+    .instance_init = vmmouse_instance_initfn,
     .class_init    = vmmouse_class_initfn,
 };
 
-- 
2.11.0
