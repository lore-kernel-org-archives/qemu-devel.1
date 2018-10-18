Received: from eggs.gnu.org ([2001:4830:134:3::10]:41015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDEc8-0003qm-V5
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:09:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDEc7-0004RC-VN
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:09:48 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 18 Oct 2018 17:04:17 -0300
Message-Id: <20181018200422.4358-41-ehabkost@redhat.com>
In-Reply-To: <20181018200422.4358-1-ehabkost@redhat.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 40/45] net: opencores_eth: convert SysBus init
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

Cc: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20181001063803.22330-8-clg@kaod.org>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/net/opencores_eth.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index d42b79c08c..d6f54f8d82 100644
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
2.18.0.rc1.1.g3f1ff2140
