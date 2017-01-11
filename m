Received: from eggs.gnu.org ([2001:4830:134:3::10]:44157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRFI4-0004bh-UO
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:33:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRFI3-0006Gi-TX
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:33:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cRFI3-0006Gb-Nr
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:33:55 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 11 Jan 2017 10:33:46 +0100
Message-Id: <1484127227-26496-5-git-send-email-kraxel@redhat.com>
In-Reply-To: <1484127227-26496-1-git-send-email-kraxel@redhat.com>
References: <1484127227-26496-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/5] audio: ac97: add exit function
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

Currently the ac97 device emulation doesn't have a exit function,
hot unplug this device will leak some memory. Add a exit function to
avoid this.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 58520052.4825ed0a.27a71.6cae@mx.google.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/ac97.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index cbd959e..c306575 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -1387,6 +1387,16 @@ static void ac97_realize(PCIDevice *dev, Error **e=
rrp)
     ac97_on_reset (&s->dev.qdev);
 }
=20
+static void ac97_exit(PCIDevice *dev)
+{
+    AC97LinkState *s =3D DO_UPCAST(AC97LinkState, dev, dev);
+
+    AUD_close_in(&s->card, s->voice_pi);
+    AUD_close_out(&s->card, s->voice_po);
+    AUD_close_in(&s->card, s->voice_mc);
+    AUD_remove_card(&s->card);
+}
+
 static int ac97_init (PCIBus *bus)
 {
     pci_create_simple (bus, -1, "AC97");
@@ -1404,6 +1414,7 @@ static void ac97_class_init (ObjectClass *klass, vo=
id *data)
     PCIDeviceClass *k =3D PCI_DEVICE_CLASS (klass);
=20
     k->realize =3D ac97_realize;
+    k->exit =3D ac97_exit;
     k->vendor_id =3D PCI_VENDOR_ID_INTEL;
     k->device_id =3D PCI_DEVICE_ID_INTEL_82801AA_5;
     k->revision =3D 0x01;
--=20
1.8.3.1
