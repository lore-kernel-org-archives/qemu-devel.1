Received: from eggs.gnu.org ([2001:4830:134:3::10]:57878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g6rqy-00015T-OQ
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:38:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g6rqu-0005v6-Fj
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:38:48 -0400
Received: from 2.mo69.mail-out.ovh.net ([178.33.251.80]:34894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g6rqu-0005sP-8v
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:38:44 -0400
Received: from player699.ha.ovh.net (unknown [10.109.159.152])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 87EF42DE11
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 08:38:42 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  1 Oct 2018 08:37:57 +0200
Message-Id: <20181001063803.22330-6-clg@kaod.org>
In-Reply-To: <20181001063803.22330-1-clg@kaod.org>
References: <20181001063803.22330-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 05/11] net: milkymist_minimac2: convert
 SysBus init method to a realize method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Michael Walle <michael@walle.cc>

Cc: Michael Walle <michael@walle.cc>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/net/milkymist-minimac2.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/net/milkymist-minimac2.c b/hw/net/milkymist-minimac2.c
index 3eaa19dfde92..7ef1daee41ec 100644
--- a/hw/net/milkymist-minimac2.c
+++ b/hw/net/milkymist-minimac2.c
@@ -452,9 +452,9 @@ static NetClientInfo net_milkymist_minimac2_info =3D =
{
     .receive =3D minimac2_rx,
 };
=20
-static int milkymist_minimac2_init(SysBusDevice *sbd)
+static void milkymist_minimac2_realize(DeviceState *dev, Error **errp)
 {
-    DeviceState *dev =3D DEVICE(sbd);
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
     MilkymistMinimac2State *s =3D MILKYMIST_MINIMAC2(dev);
     size_t buffers_size =3D TARGET_PAGE_ALIGN(3 * MINIMAC2_BUFFER_SIZE);
=20
@@ -479,8 +479,6 @@ static int milkymist_minimac2_init(SysBusDevice *sbd)
     s->nic =3D qemu_new_nic(&net_milkymist_minimac2_info, &s->conf,
                           object_get_typename(OBJECT(dev)), dev->id, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
-
-    return 0;
 }
=20
 static const VMStateDescription vmstate_milkymist_minimac2_mdio =3D {
@@ -521,9 +519,8 @@ static Property milkymist_minimac2_properties[] =3D {
 static void milkymist_minimac2_class_init(ObjectClass *klass, void *data=
)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
-    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
=20
-    k->init =3D milkymist_minimac2_init;
+    dc->realize =3D milkymist_minimac2_realize;
     dc->reset =3D milkymist_minimac2_reset;
     dc->vmsd =3D &vmstate_milkymist_minimac2;
     dc->props =3D milkymist_minimac2_properties;
--=20
2.17.1
