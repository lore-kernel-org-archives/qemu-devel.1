Received: from eggs.gnu.org ([2001:4830:134:3::10]:37262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cQwJZ-0002sa-Cw
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 08:18:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cQwJU-00033k-67
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 08:18:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cQwJU-00033K-06
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 08:18:08 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 088E961BA4
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 13:18:07 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 10 Jan 2017 14:18:01 +0100
Message-Id: <1484054281-26139-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] es1370: wire up reset via DeviceClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Instead of using qemu_register_reset().
That way we get proper cleanup for free.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/es1370.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 883ec69..fe64c1a 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -1010,9 +1010,9 @@ static const VMStateDescription vmstate_es1370 = {
     }
 };
 
-static void es1370_on_reset (void *opaque)
+static void es1370_on_reset(DeviceState *dev)
 {
-    ES1370State *s = opaque;
+    ES1370State *s = container_of(dev, ES1370State, dev.qdev);
     es1370_reset (s);
 }
 
@@ -1035,7 +1035,6 @@ static void es1370_realize(PCIDevice *dev, Error **errp)
 
     memory_region_init_io (&s->io, OBJECT(s), &es1370_io_ops, s, "es1370", 256);
     pci_register_bar (&s->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
-    qemu_register_reset (es1370_on_reset, s);
 
     AUD_register_card ("es1370", &s->card);
     es1370_reset (s);
@@ -1075,6 +1074,7 @@ static void es1370_class_init (ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
     dc->desc = "ENSONIQ AudioPCI ES1370";
     dc->vmsd = &vmstate_es1370;
+    dc->reset = es1370_on_reset;
 }
 
 static const TypeInfo es1370_info = {
-- 
1.8.3.1
