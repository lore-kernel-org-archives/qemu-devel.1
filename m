Received: from eggs.gnu.org ([2001:4830:134:3::10]:40577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDEbT-0003EF-19
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:09:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDEbR-0003WA-4s
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:09:06 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 18 Oct 2018 17:04:11 -0300
Message-Id: <20181018200422.4358-35-ehabkost@redhat.com>
In-Reply-To: <20181018200422.4358-1-ehabkost@redhat.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 34/45] net: etraxfs_eth: convert SysBus init
 method to a realize method
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20181001063803.22330-2-clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/net/etraxfs_eth.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/net/etraxfs_eth.c b/hw/net/etraxfs_eth.c
index a6932432b1..64ab3df1ae 100644
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
2.18.0.rc1.1.g3f1ff2140
