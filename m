Received: from eggs.gnu.org ([2001:4830:134:3::10]:34579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cHEue-0006JG-5K
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 14:08:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cHEua-0001bR-V0
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 14:08:24 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cHEua-0001Zq-LC
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 14:08:20 -0500
Received: by mail-wm0-f67.google.com with SMTP id a20so1150262wme.2
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 11:07:57 -0800 (PST)
MIME-Version: 1.0
References: <5850b689.68219d0a.9be2d.9b07@mx.google.com>
In-Reply-To: <5850b689.68219d0a.9be2d.9b07@mx.google.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 14 Dec 2016 19:06:45 +0000
Message-ID: <CAJ+F1CLibABvciw2Qo06KLbcYqA3ReYGKPxhgAH4ZG1dQy7ZAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] audio: ac97: add exit function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, kraxel@redhat.com, qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>

Hi

On Wed, Dec 14, 2016 at 6:03 AM Li Qiang <liq3ea@gmail.com> wrote:

From: Li Qiang <liqiang6-s@360.cn>

Currently the ac97 device emulation doesn't have a exit function,
hot unplug this device will leak some memory. Add a exit function to
avoid this.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
---

Changes since the v1:
close the streams

 hw/audio/ac97.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index cbd959e..efa20b5 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -1387,6 +1387,23 @@ static void ac97_realize(PCIDevice *dev, Error
**errp)
     ac97_on_reset (&s->dev.qdev);
 }

+static void ac97_exit(PCIDevice *dev)
+{
+    AC97LinkState *s =3D DO_UPCAST(AC97LinkState, dev, dev);
+
+    if (s->voice_pi) {
+        AUD_close_in (&s->card, s->voice_pi);
+    }
+    if (s->voice_po) {
+        AUD_close_out (&s->card, s->voice_po);
+    }
+    if (s->voice_mc) {
+        AUD_close_in (&s->card, s->voice_mc);
+    }
+


You don't need to check if the pointer is non-null, same for es1370

Regarding style (space before parentheses), I think it's best to use qemu
style (no space), even if the file uses its own style.


+    AUD_remove_card (&s->card);
+}
+
 static int ac97_init (PCIBus *bus)
 {
     pci_create_simple (bus, -1, "AC97");
@@ -1404,6 +1421,7 @@ static void ac97_class_init (ObjectClass *klass, void
*data)
     PCIDeviceClass *k =3D PCI_DEVICE_CLASS (klass);

     k->realize =3D ac97_realize;
+    k->exit =3D ac97_exit;
     k->vendor_id =3D PCI_VENDOR_ID_INTEL;
     k->device_id =3D PCI_DEVICE_ID_INTEL_82801AA_5;
     k->revision =3D 0x01;
--
1.8.3.1

--=20
Marc-Andr=C3=A9 Lureau
