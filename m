Received: from eggs.gnu.org ([2001:4830:134:3::10]:40717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDEbn-0003Tf-AX
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDEbh-0003qG-1K
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:09:27 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 18 Oct 2018 17:04:12 -0300
Message-Id: <20181018200422.4358-36-ehabkost@redhat.com>
In-Reply-To: <20181018200422.4358-1-ehabkost@redhat.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 35/45] net: etraxfs_eth: add a reset method
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

Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20181001063803.22330-3-clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/net/etraxfs_eth.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/hw/net/etraxfs_eth.c b/hw/net/etraxfs_eth.c
index 64ab3df1ae..36855804db 100644
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
2.18.0.rc1.1.g3f1ff2140
