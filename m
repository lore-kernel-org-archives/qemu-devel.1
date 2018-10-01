Received: from eggs.gnu.org ([2001:4830:134:3::10]:57724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g6rqj-0000th-GF
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g6rqe-0005Rf-Ug
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:38:33 -0400
Received: from 5.mo179.mail-out.ovh.net ([46.105.43.140]:43920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g6rqe-0005Fa-MI
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:38:28 -0400
Received: from player699.ha.ovh.net (unknown [10.109.159.154])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 3438B100A7D
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 08:38:19 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  1 Oct 2018 08:37:53 +0200
Message-Id: <20181001063803.22330-2-clg@kaod.org>
In-Reply-To: <20181001063803.22330-1-clg@kaod.org>
References: <20181001063803.22330-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 01/11] net: etraxfs_eth: convert SysBus init
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
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>

Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/etraxfs_eth.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/net/etraxfs_eth.c b/hw/net/etraxfs_eth.c
index a6932432b164..64ab3df1ae38 100644
--- a/hw/net/etraxfs_eth.c
+++ b/hw/net/etraxfs_eth.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "hw/cris/etraxfs.h"
@@ -584,14 +585,14 @@ static NetClientInfo net_etraxfs_info =3D {
     .link_status_changed =3D eth_set_link,
 };
=20
-static int fs_eth_init(SysBusDevice *sbd)
+static void etraxfs_eth_realize(DeviceState *dev, Error **errp)
 {
-    DeviceState *dev =3D DEVICE(sbd);
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
     ETRAXFSEthState *s =3D ETRAX_FS_ETH(dev);
=20
     if (!s->dma_out || !s->dma_in) {
-        error_report("Unconnected ETRAX-FS Ethernet MAC");
-        return -1;
+        error_setg(errp, "Unconnected ETRAX-FS Ethernet MAC");
+        return;
     }
=20
     s->dma_out->client.push =3D eth_tx_push;
@@ -611,7 +612,6 @@ static int fs_eth_init(SysBusDevice *sbd)
=20
     tdk_init(&s->phy);
     mdio_attach(&s->mdio_bus, &s->phy, s->phyaddr);
-    return 0;
 }
=20
 static Property etraxfs_eth_properties[] =3D {
@@ -625,9 +625,8 @@ static Property etraxfs_eth_properties[] =3D {
 static void etraxfs_eth_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
-    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
=20
-    k->init =3D fs_eth_init;
+    dc->realize =3D etraxfs_eth_realize;
     dc->props =3D etraxfs_eth_properties;
     /* Reason: pointer properties "dma_out", "dma_in" */
     dc->user_creatable =3D false;
--=20
2.17.1
