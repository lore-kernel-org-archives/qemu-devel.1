Received: from eggs.gnu.org ([2001:4830:134:3::10]:44152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRFI4-0004be-TK
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:33:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRFI2-0006GR-7i
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:33:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cRFI2-0006GF-1J
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:33:54 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 11 Jan 2017 10:33:45 +0100
Message-Id: <1484127227-26496-4-git-send-email-kraxel@redhat.com>
In-Reply-To: <1484127227-26496-1-git-send-email-kraxel@redhat.com>
References: <1484127227-26496-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/5] audio: es1370: add exit function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>, Gerd Hoffmann <kraxel@redhat.com>

From: Li Qiang <liqiang6-s@360.cn>

Currently the es1370 device emulation doesn't have a exit function,
hot unplug this device will leak some memory. Add a exit function to
avoid this.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 585200c9.a968ca0a.1ab80.4c98@mx.google.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/es1370.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 8449b5f..883ec69 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -1041,6 +1041,19 @@ static void es1370_realize(PCIDevice *dev, Error *=
*errp)
     es1370_reset (s);
 }
=20
+static void es1370_exit(PCIDevice *dev)
+{
+    ES1370State *s =3D ES1370(dev);
+    int i;
+
+    for (i =3D 0; i < 2; ++i) {
+        AUD_close_out(&s->card, s->dac_voice[i]);
+    }
+
+    AUD_close_in(&s->card, s->adc_voice);
+    AUD_remove_card(&s->card);
+}
+
 static int es1370_init (PCIBus *bus)
 {
     pci_create_simple (bus, -1, TYPE_ES1370);
@@ -1053,6 +1066,7 @@ static void es1370_class_init (ObjectClass *klass, =
void *data)
     PCIDeviceClass *k =3D PCI_DEVICE_CLASS (klass);
=20
     k->realize =3D es1370_realize;
+    k->exit =3D es1370_exit;
     k->vendor_id =3D PCI_VENDOR_ID_ENSONIQ;
     k->device_id =3D PCI_DEVICE_ID_ENSONIQ_ES1370;
     k->class_id =3D PCI_CLASS_MULTIMEDIA_AUDIO;
--=20
1.8.3.1
