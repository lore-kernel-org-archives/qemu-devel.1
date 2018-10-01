Received: from eggs.gnu.org ([2001:4830:134:3::10]:57919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g6rrB-0001Eg-CQ
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:39:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g6rr7-0006A9-2O
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:39:01 -0400
Received: from 8.mo179.mail-out.ovh.net ([46.105.75.26]:59458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g6rr6-00068D-52
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:38:56 -0400
Received: from player699.ha.ovh.net (unknown [10.109.160.239])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id D69061019A0
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 08:38:54 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  1 Oct 2018 08:37:59 +0200
Message-Id: <20181001063803.22330-8-clg@kaod.org>
In-Reply-To: <20181001063803.22330-1-clg@kaod.org>
References: <20181001063803.22330-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 07/11] net: opencores_eth: convert SysBus
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
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Max Filippov <jcmvbkbc@gmail.com>

Cc: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/net/opencores_eth.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index d42b79c08c6a..d6f54f8d8208 100644
--- a/hw/net/opencores_eth.c
+++ b/hw/net/opencores_eth.c
@@ -715,9 +715,9 @@ static const MemoryRegionOps open_eth_desc_ops =3D {
     .write =3D open_eth_desc_write,
 };
=20
-static int sysbus_open_eth_init(SysBusDevice *sbd)
+static void sysbus_open_eth_realize(DeviceState *dev, Error **errp)
 {
-    DeviceState *dev =3D DEVICE(sbd);
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
     OpenEthState *s =3D OPEN_ETH(dev);
=20
     memory_region_init_io(&s->reg_io, OBJECT(dev), &open_eth_reg_ops, s,
@@ -732,7 +732,6 @@ static int sysbus_open_eth_init(SysBusDevice *sbd)
=20
     s->nic =3D qemu_new_nic(&net_open_eth_info, &s->conf,
                           object_get_typename(OBJECT(s)), dev->id, s);
-    return 0;
 }
=20
 static void qdev_open_eth_reset(DeviceState *dev)
@@ -750,9 +749,8 @@ static Property open_eth_properties[] =3D {
 static void open_eth_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
-    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
=20
-    k->init =3D sysbus_open_eth_init;
+    dc->realize =3D sysbus_open_eth_realize;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     dc->desc =3D "Opencores 10/100 Mbit Ethernet";
     dc->reset =3D qdev_open_eth_reset;
--=20
2.17.1
