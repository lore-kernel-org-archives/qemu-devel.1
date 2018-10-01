Received: from eggs.gnu.org ([2001:4830:134:3::10]:57972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g6rrM-0001LU-KU
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:39:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g6rrH-0006Rn-OG
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:39:12 -0400
Received: from 18.mo1.mail-out.ovh.net ([46.105.35.72]:41663)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g6rrH-0006QE-GZ
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:39:07 -0400
Received: from player699.ha.ovh.net (unknown [10.109.160.239])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 685C2138DD8
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 08:39:06 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  1 Oct 2018 08:38:01 +0200
Message-Id: <20181001063803.22330-10-clg@kaod.org>
In-Reply-To: <20181001063803.22330-1-clg@kaod.org>
References: <20181001063803.22330-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 09/11] net: stellaris_enet: convert SysBus
 init method to a realize method
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
 hw/net/stellaris_enet.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
index 165562d7886a..3ee1e0f8a43f 100644
--- a/hw/net/stellaris_enet.c
+++ b/hw/net/stellaris_enet.c
@@ -473,9 +473,9 @@ static NetClientInfo net_stellaris_enet_info =3D {
     .receive =3D stellaris_enet_receive,
 };
=20
-static int stellaris_enet_init(SysBusDevice *sbd)
+static void stellaris_enet_realize(DeviceState *dev, Error **errp)
 {
-    DeviceState *dev =3D DEVICE(sbd);
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
     stellaris_enet_state *s =3D STELLARIS_ENET(dev);
=20
     memory_region_init_io(&s->mmio, OBJECT(s), &stellaris_enet_ops, s,
@@ -489,7 +489,6 @@ static int stellaris_enet_init(SysBusDevice *sbd)
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
=20
     stellaris_enet_reset(s);
-    return 0;
 }
=20
 static Property stellaris_enet_properties[] =3D {
@@ -500,9 +499,8 @@ static Property stellaris_enet_properties[] =3D {
 static void stellaris_enet_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
-    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
=20
-    k->init =3D stellaris_enet_init;
+    dc->realize =3D stellaris_enet_realize;
     dc->props =3D stellaris_enet_properties;
     dc->vmsd =3D &vmstate_stellaris_enet;
 }
--=20
2.17.1
