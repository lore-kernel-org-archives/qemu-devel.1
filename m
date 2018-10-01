Received: from eggs.gnu.org ([2001:4830:134:3::10]:57907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g6rr5-0001BQ-CA
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g6rr0-00061q-6j
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:38:55 -0400
Received: from 15.mo5.mail-out.ovh.net ([178.33.107.29]:48729)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g6rqz-000607-Vs
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:38:50 -0400
Received: from player699.ha.ovh.net (unknown [10.109.159.73])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id A64A71F2F16
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 08:38:48 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  1 Oct 2018 08:37:58 +0200
Message-Id: <20181001063803.22330-7-clg@kaod.org>
In-Reply-To: <20181001063803.22330-1-clg@kaod.org>
References: <20181001063803.22330-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 06/11] net: mipsnet: convert SysBus init
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
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Aleksandar Markovic <amarkovic@wavecomp.com>

Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/net/mipsnet.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/net/mipsnet.c b/hw/net/mipsnet.c
index 5a63df7ccb91..03b310427860 100644
--- a/hw/net/mipsnet.c
+++ b/hw/net/mipsnet.c
@@ -236,9 +236,9 @@ static const MemoryRegionOps mipsnet_ioport_ops =3D {
     .impl.max_access_size =3D 4,
 };
=20
-static int mipsnet_sysbus_init(SysBusDevice *sbd)
+static void mipsnet_realize(DeviceState *dev, Error **errp)
 {
-    DeviceState *dev =3D DEVICE(sbd);
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
     MIPSnetState *s =3D MIPS_NET(dev);
=20
     memory_region_init_io(&s->io, OBJECT(dev), &mipsnet_ioport_ops, s,
@@ -249,8 +249,6 @@ static int mipsnet_sysbus_init(SysBusDevice *sbd)
     s->nic =3D qemu_new_nic(&net_mipsnet_info, &s->conf,
                           object_get_typename(OBJECT(dev)), dev->id, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
-
-    return 0;
 }
=20
 static void mipsnet_sysbus_reset(DeviceState *dev)
@@ -267,9 +265,8 @@ static Property mipsnet_properties[] =3D {
 static void mipsnet_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
-    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
=20
-    k->init =3D mipsnet_sysbus_init;
+    dc->realize =3D mipsnet_realize;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     dc->desc =3D "MIPS Simulator network device";
     dc->reset =3D mipsnet_sysbus_reset;
--=20
2.17.1
