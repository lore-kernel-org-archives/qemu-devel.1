Received: from eggs.gnu.org ([2001:4830:134:3::10]:57663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g6rqh-0000tf-NG
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g6rqc-0005OL-SN
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:38:31 -0400
Received: from 8.mo68.mail-out.ovh.net ([46.105.74.219]:48821)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g6rqc-0005Mh-JU
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:38:26 -0400
Received: from player699.ha.ovh.net (unknown [10.109.146.5])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 536A6FBFC1
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 08:38:25 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  1 Oct 2018 08:37:54 +0200
Message-Id: <20181001063803.22330-3-clg@kaod.org>
In-Reply-To: <20181001063803.22330-1-clg@kaod.org>
References: <20181001063803.22330-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 02/11] net: etraxfs_eth: add a reset method
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
---
 hw/net/etraxfs_eth.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/hw/net/etraxfs_eth.c b/hw/net/etraxfs_eth.c
index 64ab3df1ae38..36855804dba0 100644
--- a/hw/net/etraxfs_eth.c
+++ b/hw/net/etraxfs_eth.c
@@ -127,7 +127,7 @@ tdk_write(struct qemu_phy *phy, unsigned int req, uns=
igned int data)
 }
=20
 static void
-tdk_init(struct qemu_phy *phy)
+tdk_reset(struct qemu_phy *phy)
 {
     phy->regs[0] =3D 0x3100;
     /* PHY Id.  */
@@ -136,9 +136,6 @@ tdk_init(struct qemu_phy *phy)
     /* Autonegotiation advertisement reg.  */
     phy->regs[4] =3D 0x01E1;
     phy->link =3D 1;
-
-    phy->read =3D tdk_read;
-    phy->write =3D tdk_write;
 }
=20
 struct qemu_mdio
@@ -585,6 +582,27 @@ static NetClientInfo net_etraxfs_info =3D {
     .link_status_changed =3D eth_set_link,
 };
=20
+static void etraxfs_eth_reset(DeviceState *dev)
+{
+    ETRAXFSEthState *s =3D ETRAX_FS_ETH(dev);
+
+    memset(s->regs, 0, sizeof(s->regs));
+    memset(s->macaddr, 0, sizeof(s->macaddr));
+    s->duplex_mismatch =3D 0;
+
+    s->mdio_bus.mdc =3D 0;
+    s->mdio_bus.mdio =3D 0;
+    s->mdio_bus.state =3D 0;
+    s->mdio_bus.drive =3D 0;
+    s->mdio_bus.cnt =3D 0;
+    s->mdio_bus.addr =3D 0;
+    s->mdio_bus.opc =3D 0;
+    s->mdio_bus.req =3D 0;
+    s->mdio_bus.data =3D 0;
+
+    tdk_reset(&s->phy);
+}
+
 static void etraxfs_eth_realize(DeviceState *dev, Error **errp)
 {
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
@@ -609,8 +627,8 @@ static void etraxfs_eth_realize(DeviceState *dev, Err=
or **errp)
                           object_get_typename(OBJECT(s)), dev->id, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
=20
-
-    tdk_init(&s->phy);
+    s->phy.read =3D tdk_read;
+    s->phy.write =3D tdk_write;
     mdio_attach(&s->mdio_bus, &s->phy, s->phyaddr);
 }
=20
@@ -627,6 +645,7 @@ static void etraxfs_eth_class_init(ObjectClass *klass=
, void *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
     dc->realize =3D etraxfs_eth_realize;
+    dc->reset =3D etraxfs_eth_reset;
     dc->props =3D etraxfs_eth_properties;
     /* Reason: pointer properties "dma_out", "dma_in" */
     dc->user_creatable =3D false;
--=20
2.17.1
