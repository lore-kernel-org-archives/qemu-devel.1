Received: from eggs.gnu.org ([2001:4830:134:3::10]:41168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDEcO-000443-0F
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:10:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDEcM-0004Ui-A0
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:10:04 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 18 Oct 2018 17:04:21 -0300
Message-Id: <20181018200422.4358-45-ehabkost@redhat.com>
In-Reply-To: <20181018200422.4358-1-ehabkost@redhat.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 44/45] net: xgmac: convert SysBus init method to
 a realize method
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

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20181001063803.22330-12-clg@kaod.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/net/xgmac.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/net/xgmac.c b/hw/net/xgmac.c
index fa001563d3..63f5a62ebf 100644
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
2.18.0.rc1.1.g3f1ff2140
