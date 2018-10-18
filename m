Received: from eggs.gnu.org ([2001:4830:134:3::10]:41121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDEcK-00040u-PS
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:10:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDEcK-0004U5-38
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:10:00 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 18 Oct 2018 17:04:20 -0300
Message-Id: <20181018200422.4358-44-ehabkost@redhat.com>
In-Reply-To: <20181018200422.4358-1-ehabkost@redhat.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 43/45] net: stellaris_enet: add a reset method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20181001063803.22330-11-clg@kaod.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/net/stellaris_enet.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
index 3ee1e0f8a4..b3375ebb45 100644
--- a/hw/net/stellaris_enet.c
+++ b/hw/net/stellaris_enet.c
@@ -457,8 +457,10 @@ static const MemoryRegionOps stellaris_enet_ops =3D =
{
     .endianness =3D DEVICE_NATIVE_ENDIAN,
 };
=20
-static void stellaris_enet_reset(stellaris_enet_state *s)
+static void stellaris_enet_reset(DeviceState *dev)
 {
+    stellaris_enet_state *s =3D  STELLARIS_ENET(dev);
+
     s->mdv =3D 0x80;
     s->rctl =3D SE_RCTL_BADCRC;
     s->im =3D SE_INT_PHY | SE_INT_MD | SE_INT_RXER | SE_INT_FOV | SE_INT=
_TXEMP
@@ -487,8 +489,6 @@ static void stellaris_enet_realize(DeviceState *dev, =
Error **errp)
     s->nic =3D qemu_new_nic(&net_stellaris_enet_info, &s->conf,
                           object_get_typename(OBJECT(dev)), dev->id, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
-
-    stellaris_enet_reset(s);
 }
=20
 static Property stellaris_enet_properties[] =3D {
@@ -501,6 +501,7 @@ static void stellaris_enet_class_init(ObjectClass *kl=
ass, void *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
     dc->realize =3D stellaris_enet_realize;
+    dc->reset =3D stellaris_enet_reset;
     dc->props =3D stellaris_enet_properties;
     dc->vmsd =3D &vmstate_stellaris_enet;
 }
--=20
2.18.0.rc1.1.g3f1ff2140
