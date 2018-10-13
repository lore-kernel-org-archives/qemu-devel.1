Received: from eggs.gnu.org ([2001:4830:134:3::10]:54741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gBD6F-0006Ba-Fj
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 02:08:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gBD6A-0003MF-GH
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 02:08:31 -0400
Received: from m12-18.163.com ([220.181.12.18]:34211)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gBD68-0003Gi-St
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 02:08:25 -0400
From: Li Qiang <liq3ea@163.com>
Date: Fri, 12 Oct 2018 23:08:09 -0700
Message-Id: <20181013060809.52496-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH] hw: AC97: make it more QOMconventional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/audio/ac97.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 337402e9c6..d799533aa9 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -123,6 +123,10 @@ enum {
 
 #define MUTE_SHIFT 15
 
+#define TYPE_AC97 "AC97"
+#define AC97(obj) \
+    OBJECT_CHECK(AC97LinkState, (obj), TYPE_AC97)
+
 #define REC_MASK 7
 enum {
     REC_MIC = 0,
@@ -1340,7 +1344,7 @@ static void ac97_on_reset (DeviceState *dev)
 
 static void ac97_realize(PCIDevice *dev, Error **errp)
 {
-    AC97LinkState *s = DO_UPCAST (AC97LinkState, dev, dev);
+    AC97LinkState *s = AC97(dev);
     uint8_t *c = s->dev.config;
 
     /* TODO: no need to override */
@@ -1389,7 +1393,7 @@ static void ac97_realize(PCIDevice *dev, Error **errp)
 
 static void ac97_exit(PCIDevice *dev)
 {
-    AC97LinkState *s = DO_UPCAST(AC97LinkState, dev, dev);
+    AC97LinkState *s = AC97(dev);
 
     AUD_close_in(&s->card, s->voice_pi);
     AUD_close_out(&s->card, s->voice_po);
@@ -1399,7 +1403,7 @@ static void ac97_exit(PCIDevice *dev)
 
 static int ac97_init (PCIBus *bus)
 {
-    pci_create_simple (bus, -1, "AC97");
+    pci_create_simple(bus, -1, TYPE_AC97);
     return 0;
 }
 
@@ -1427,7 +1431,7 @@ static void ac97_class_init (ObjectClass *klass, void *data)
 }
 
 static const TypeInfo ac97_info = {
-    .name          = "AC97",
+    .name          = TYPE_AC97,
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof (AC97LinkState),
     .class_init    = ac97_class_init,
-- 
2.17.1
