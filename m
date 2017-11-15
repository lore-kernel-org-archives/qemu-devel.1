Received: from eggs.gnu.org ([2001:4830:134:3::10]:53157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEuwv-00048I-D6
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 05:29:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEuws-0002Om-7d
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 05:29:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eEuws-0002OI-1V
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 05:29:38 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AB65A4E4C1
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 10:29:35 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 15 Nov 2017 11:29:28 +0100
Message-Id: <20171115102928.7878-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] sga: stop using sgabios rom for 2.11+
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

seabios 1.11 got builtin serial console support, so we don't need
sgabios any more.  "-machine graphics=off" should be used instead.
update sga.c accordingly.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/compat.h |  4 ++++
 hw/misc/sga.c       | 26 +++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/hw/compat.h b/include/hw/compat.h
index f96212c49c..1e3ad895db 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -14,6 +14,10 @@
         .driver   = "i82559a",\
         .property = "x-use-alt-device-id",\
         .value    = "false",\
+    },{\
+        .driver   = "sga",\
+        .property = "use-sgabios",\
+        .value    = "true",\
     },
 
 #define HW_COMPAT_2_9 \
diff --git a/hw/misc/sga.c b/hw/misc/sga.c
index 03b006d6f0..bcb4c98554 100644
--- a/hw/misc/sga.c
+++ b/hw/misc/sga.c
@@ -25,6 +25,7 @@
  *
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/pci/pci.h"
 #include "hw/i386/pc.h"
 #include "hw/loader.h"
@@ -37,18 +38,41 @@
 
 typedef struct ISASGAState {
     ISADevice parent_obj;
+    bool use_sgabios;
 } ISASGAState;
 
 static void sga_realizefn(DeviceState *dev, Error **errp)
 {
-    rom_add_vga(SGABIOS_FILENAME);
+    MachineState *machine = MACHINE(qdev_get_machine());
+    ISASGAState *sga = SGA(dev);
+
+    if (sga->use_sgabios) {
+        rom_add_vga(SGABIOS_FILENAME);
+    } else if (machine->enable_graphics) {
+        warn_report("sgabios is deprecated for your machine type, "
+                    "please use -machine graphics=off instead of "
+                    "-device sga");
+        rom_add_vga(SGABIOS_FILENAME);
+    } else {
+        /*
+         * For this machine type we expect SeaBIOS to provide a
+         * serial console for -machine graphics=off.  No need to
+         * do anything here.
+         */
+    }
 }
 
+static Property sga_properties[] = {
+    DEFINE_PROP_BOOL("use-sgabios", ISASGAState, use_sgabios, false),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void sga_class_initfn(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
+    dc->props = sga_properties;
     dc->realize = sga_realizefn;
     dc->desc = "Serial Graphics Adapter";
 }
-- 
2.9.3
