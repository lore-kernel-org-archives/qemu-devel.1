Received: from eggs.gnu.org ([2001:4830:134:3::10]:57851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g6rqu-0000z5-Ez
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:38:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g6rqn-0005lq-UY
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:38:42 -0400
Received: from 3.mo3.mail-out.ovh.net ([46.105.44.175]:51919)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g6rqn-0005et-OD
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:38:37 -0400
Received: from player699.ha.ovh.net (unknown [10.109.160.153])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id E02571D8DB4
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 08:38:35 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  1 Oct 2018 08:37:56 +0200
Message-Id: <20181001063803.22330-5-clg@kaod.org>
In-Reply-To: <20181001063803.22330-1-clg@kaod.org>
References: <20181001063803.22330-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 04/11] net: lance: convert SysBus init
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/net/lance.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/net/lance.c b/hw/net/lance.c
index a08d5ac6a848..f987b2fd180f 100644
--- a/hw/net/lance.c
+++ b/hw/net/lance.c
@@ -97,9 +97,9 @@ static const VMStateDescription vmstate_lance =3D {
     }
 };
=20
-static int lance_init(SysBusDevice *sbd)
+static void lance_realize(DeviceState *dev, Error **errp)
 {
-    DeviceState *dev =3D DEVICE(sbd);
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
     SysBusPCNetState *d =3D SYSBUS_PCNET(dev);
     PCNetState *s =3D &d->state;
=20
@@ -115,7 +115,6 @@ static int lance_init(SysBusDevice *sbd)
     s->phys_mem_read =3D ledma_memory_read;
     s->phys_mem_write =3D ledma_memory_write;
     pcnet_common_init(dev, s, &net_lance_info);
-    return 0;
 }
=20
 static void lance_reset(DeviceState *dev)
@@ -144,9 +143,8 @@ static Property lance_properties[] =3D {
 static void lance_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
-    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
=20
-    k->init =3D lance_init;
+    dc->realize =3D lance_realize;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     dc->fw_name =3D "ethernet";
     dc->reset =3D lance_reset;
--=20
2.17.1
