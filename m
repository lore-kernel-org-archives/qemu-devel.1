Received: from eggs.gnu.org ([2001:4830:134:3::10]:58005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g6rrS-0001Qb-DO
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:39:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g6rrO-0006Yb-40
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:39:18 -0400
Received: from 2.mo6.mail-out.ovh.net ([46.105.76.65]:51269)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g6rrN-0006XT-SG
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:39:13 -0400
Received: from player699.ha.ovh.net (unknown [10.109.160.62])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id B7EE61843CB
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 08:39:12 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  1 Oct 2018 08:38:02 +0200
Message-Id: <20181001063803.22330-11-clg@kaod.org>
In-Reply-To: <20181001063803.22330-1-clg@kaod.org>
References: <20181001063803.22330-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 10/11] net: stellaris_enet: add a reset
 method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/net/stellaris_enet.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
index 3ee1e0f8a43f..b3375ebb459c 100644
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
2.17.1
