Received: from eggs.gnu.org ([2001:4830:134:3::10]:44580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1eiEkR-0003cX-LS
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 02:30:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1eiEkO-00031E-Ff
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 02:29:59 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:40888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1eiEkO-0002zd-8c
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 02:29:56 -0500
Received: by mail-wm0-x242.google.com with SMTP id v123so20011431wmd.5
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 23:29:56 -0800 (PST)
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Sun,  4 Feb 2018 15:28:23 +0800
Message-Id: <1517729303-32043-3-git-send-email-whois.zihan.yang@gmail.com>
In-Reply-To: <1517729303-32043-1-git-send-email-whois.zihan.yang@gmail.com>
References: <1517729303-32043-1-git-send-email-whois.zihan.yang@gmail.com>
Subject: [Qemu-devel] [PATCH 2/2] vmmouse: change qdev pointer property to
 qom link
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zihan Yang <whois.zihan.yang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

The ps2_mouse property of vmmouse is still pointer type which
is defined by DEFINE_PROP_PTR. But qdev pointer property should
be avoided. Convert it into QOM link relationship

Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
---
 hw/i386/pc.c      |  2 +-
 hw/i386/vmmouse.c | 19 ++++++++++++-------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index ccc50ba..63f49b2 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1598,7 +1598,7 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
     }
     if (vmmouse) {
         DeviceState *dev = DEVICE(vmmouse);
-        qdev_prop_set_ptr(dev, "ps2_mouse", i8042);
+        object_property_set_link(OBJECT(dev), OBJECT(i8042), "ps2_mouse", NULL);
         qdev_init_nofail(dev);
     }
     port92 = isa_create_simple(isa_bus, "port92");
diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index 65ef553..49d4170 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -26,6 +26,8 @@
 #include "ui/console.h"
 #include "hw/i386/pc.h"
 #include "hw/qdev.h"
+#include "hw/input/pckbd.h"
+#include "qapi/error.h"
 
 /* debug only vmmouse */
 //#define DEBUG_VMMOUSE
@@ -271,10 +273,15 @@ static void vmmouse_realizefn(DeviceState *dev, Error **errp)
     vmport_register(VMMOUSE_DATA, vmmouse_ioport_read, s);
 }
 
-static Property vmmouse_properties[] = {
-    DEFINE_PROP_PTR("ps2_mouse", VMMouseState, ps2_mouse),
-    DEFINE_PROP_END_OF_LIST(),
-};
+static void vmmouse_initfn(Object *obj)
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
@@ -283,15 +290,13 @@ static void vmmouse_class_initfn(ObjectClass *klass, void *data)
     dc->realize = vmmouse_realizefn;
     dc->reset = vmmouse_reset;
     dc->vmsd = &vmstate_vmmouse;
-    dc->props = vmmouse_properties;
-    /* Reason: pointer property "ps2_mouse" */
-    dc->user_creatable = false;
 }
 
 static const TypeInfo vmmouse_info = {
     .name          = TYPE_VMMOUSE,
     .parent        = TYPE_ISA_DEVICE,
     .instance_size = sizeof(VMMouseState),
+    .instance_init = vmmouse_initfn,
     .class_init    = vmmouse_class_initfn,
 };
 
-- 
2.7.4
