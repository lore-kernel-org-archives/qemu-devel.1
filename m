Received: from eggs.gnu.org ([2001:4830:134:3::10]:58068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g6rrg-0001b8-BO
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g6rra-0006nw-Gf
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:39:32 -0400
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:57869)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g6rrX-0006gF-DR
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:39:24 -0400
Received: from player699.ha.ovh.net (unknown [10.109.146.19])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 1645016323C
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 08:39:19 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  1 Oct 2018 08:38:03 +0200
Message-Id: <20181001063803.22330-12-clg@kaod.org>
In-Reply-To: <20181001063803.22330-1-clg@kaod.org>
References: <20181001063803.22330-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 11/11] net: xgmac: convert SysBus init
 method to a realize method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org, Rob Herring <robh@kernel.org>

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/net/xgmac.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/net/xgmac.c b/hw/net/xgmac.c
index fa001563d3de..63f5a62ebf1b 100644
--- a/hw/net/xgmac.c
+++ b/hw/net/xgmac.c
@@ -374,9 +374,9 @@ static NetClientInfo net_xgmac_enet_info =3D {
     .receive =3D eth_rx,
 };
=20
-static int xgmac_enet_init(SysBusDevice *sbd)
+static void xgmac_enet_realize(DeviceState *dev, Error **errp)
 {
-    DeviceState *dev =3D DEVICE(sbd);
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
     XgmacState *s =3D XGMAC(dev);
=20
     memory_region_init_io(&s->iomem, OBJECT(s), &enet_mem_ops, s,
@@ -397,8 +397,6 @@ static int xgmac_enet_init(SysBusDevice *sbd)
                                  (s->conf.macaddr.a[2] << 16) |
                                  (s->conf.macaddr.a[1] << 8) |
                                   s->conf.macaddr.a[0];
-
-    return 0;
 }
=20
 static Property xgmac_properties[] =3D {
@@ -408,10 +406,9 @@ static Property xgmac_properties[] =3D {
=20
 static void xgmac_enet_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *sbc =3D SYS_BUS_DEVICE_CLASS(klass);
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
-    sbc->init =3D xgmac_enet_init;
+    dc->realize =3D xgmac_enet_realize;
     dc->vmsd =3D &vmstate_xgmac;
     dc->props =3D xgmac_properties;
 }
--=20
2.17.1
