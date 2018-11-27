Received: from eggs.gnu.org ([2001:4830:134:3::10]:58864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gRaCL-0007tK-2m
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:02:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gRaCF-0007bE-EE
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:02:29 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gRaCE-0007aa-MN
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:02:23 -0500
Received: by mail-pl1-x644.google.com with SMTP id k8so4712675pls.11
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 02:02:22 -0800 (PST)
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 27 Nov 2018 02:02:03 -0800
Message-Id: <1543312923-3074-3-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1543312923-3074-1-git-send-email-liq3ea@gmail.com>
References: <1543312923-3074-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH v2 2/2] hw: vmmouse: drop DEFINE_PROP_PTR()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, armbru@redhat.com, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, mark.cave-ayland@ilande.co.uk
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

Use link property instead.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---

Change since v1: use error_abort in object_property_set_link()

 hw/i386/pc.c      |  3 ++-
 hw/i386/vmmouse.c | 17 +++++++++++------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 73c7b777a0..64f0f233b8 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1552,7 +1552,8 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl, bool no_vmport)
     }
     if (vmmouse) {
         DeviceState *dev = DEVICE(vmmouse);
-        qdev_prop_set_ptr(dev, "ps2_mouse", i8042);
+        object_property_set_link(OBJECT(dev), OBJECT(i8042),
+                                 "ps2_mouse", &error_abort);
         qdev_init_nofail(dev);
     }
     port92 = isa_create_simple(isa_bus, TYPE_PORT92);
diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index 4412eaf604..f63aac6673 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -27,6 +27,7 @@
 #include "hw/i386/pc.h"
 #include "hw/input/i8042.h"
 #include "hw/qdev.h"
+#include "qapi/error.h"
 
 /* debug only vmmouse */
 //#define DEBUG_VMMOUSE
@@ -271,10 +272,15 @@ static void vmmouse_realizefn(DeviceState *dev, Error **errp)
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
@@ -283,8 +289,6 @@ static void vmmouse_class_initfn(ObjectClass *klass, void *data)
     dc->realize = vmmouse_realizefn;
     dc->reset = vmmouse_reset;
     dc->vmsd = &vmstate_vmmouse;
-    dc->props = vmmouse_properties;
-    /* Reason: pointer property "ps2_mouse" */
     dc->user_creatable = false;
 }
 
@@ -292,6 +296,7 @@ static const TypeInfo vmmouse_info = {
     .name          = TYPE_VMMOUSE,
     .parent        = TYPE_ISA_DEVICE,
     .instance_size = sizeof(VMMouseState),
+    .instance_init = vmmouse_instance_initfn,
     .class_init    = vmmouse_class_initfn,
 };
 
-- 
2.11.0
