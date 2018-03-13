Received: from eggs.gnu.org ([2001:4830:134:3::10]:58253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiJ-0005wi-Cq
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiE-0003ci-CN
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:11 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:51056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsiE-0003bh-4j
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:06 -0400
Received: by mail-wm0-x242.google.com with SMTP id w128so868819wmw.0
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:48:05 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:45 +0100
Message-Id: <20180313224719.4954-36-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 35/69] hw/isa/pc87312: Inherit from the abstract
 TYPE_ISA_SUPERIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180308223946.26784-10-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/isa/pc87312.c         | 11 ++++++++++-
 include/hw/isa/pc87312.h |  6 ++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
index fda91fed21..6b8100ff56 100644
--- a/hw/isa/pc87312.c
+++ b/hw/isa/pc87312.c
@@ -270,6 +270,7 @@ static void pc87312_realize(DeviceState *dev, Error **errp)
     ISABus *bus;
     Chardev *chr;
     DriveInfo *drive;
+    Error *local_err = NULL;
     char name[5];
     int i;
 
@@ -279,6 +280,12 @@ static void pc87312_realize(DeviceState *dev, Error **errp)
     isa_register_ioport(isa, &s->io, s->iobase);
     pc87312_hard_reset(s);
 
+    ISA_SUPERIO_GET_CLASS(dev)->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     if (is_parallel_enabled(s)) {
         /* FIXME use a qdev chardev prop instead of parallel_hds[] */
         chr = parallel_hds[0];
@@ -381,7 +388,9 @@ static Property pc87312_properties[] = {
 static void pc87312_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ISASuperIOClass *sc = ISA_SUPERIO_CLASS(klass);
 
+    sc->parent_realize = dc->realize;
     dc->realize = pc87312_realize;
     dc->reset = pc87312_reset;
     dc->vmsd = &vmstate_pc87312;
@@ -392,7 +401,7 @@ static void pc87312_class_init(ObjectClass *klass, void *data)
 
 static const TypeInfo pc87312_type_info = {
     .name          = TYPE_PC87312_SUPERIO,
-    .parent        = TYPE_ISA_DEVICE,
+    .parent        = TYPE_ISA_SUPERIO,
     .instance_size = sizeof(PC87312State),
     .instance_init = pc87312_initfn,
     .class_init    = pc87312_class_init,
diff --git a/include/hw/isa/pc87312.h b/include/hw/isa/pc87312.h
index b65b219a8a..f3761d6fe1 100644
--- a/include/hw/isa/pc87312.h
+++ b/include/hw/isa/pc87312.h
@@ -25,14 +25,16 @@
 #ifndef QEMU_PC87312_H
 #define QEMU_PC87312_H
 
-#include "hw/isa/isa.h"
+#include "hw/isa/superio.h"
 
 
 #define TYPE_PC87312_SUPERIO "pc87312"
 #define PC87312(obj) OBJECT_CHECK(PC87312State, (obj), TYPE_PC87312_SUPERIO)
 
 typedef struct PC87312State {
-    ISADevice dev;
+    /*< private >*/
+    ISASuperIODevice parent_dev;
+    /*< public >*/
 
     uint16_t iobase;
     uint8_t config; /* initial configuration */
-- 
2.14.3
