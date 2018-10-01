Received: from eggs.gnu.org ([2001:4830:134:3::10]:57938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g6rrG-0001Hf-EH
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:39:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g6rrB-0006IP-Ej
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:39:06 -0400
Received: from 9.mo1.mail-out.ovh.net ([178.32.108.172]:56382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g6rrB-0006Gk-7S
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:39:01 -0400
Received: from player699.ha.ovh.net (unknown [10.109.159.132])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 1C21F136149
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 08:39:00 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  1 Oct 2018 08:38:00 +0200
Message-Id: <20181001063803.22330-9-clg@kaod.org>
In-Reply-To: <20181001063803.22330-1-clg@kaod.org>
References: <20181001063803.22330-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 08/11] net: smc91c111: convert SysBus init
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
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/net/smc91c111.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index d2fd2040e81c..99da2d92973e 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -766,9 +766,9 @@ static NetClientInfo net_smc91c111_info =3D {
     .receive =3D smc91c111_receive,
 };
=20
-static int smc91c111_init1(SysBusDevice *sbd)
+static void smc91c111_realize(DeviceState *dev, Error **errp)
 {
-    DeviceState *dev =3D DEVICE(sbd);
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
     smc91c111_state *s =3D SMC91C111(dev);
=20
     memory_region_init_io(&s->mmio, OBJECT(s), &smc91c111_mem_ops, s,
@@ -780,7 +780,6 @@ static int smc91c111_init1(SysBusDevice *sbd)
                           object_get_typename(OBJECT(dev)), dev->id, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
     /* ??? Save/restore.  */
-    return 0;
 }
=20
 static Property smc91c111_properties[] =3D {
@@ -791,9 +790,8 @@ static Property smc91c111_properties[] =3D {
 static void smc91c111_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
-    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
=20
-    k->init =3D smc91c111_init1;
+    dc->realize =3D smc91c111_realize;
     dc->reset =3D smc91c111_reset;
     dc->vmsd =3D &vmstate_smc91c111;
     dc->props =3D smc91c111_properties;
--=20
2.17.1
