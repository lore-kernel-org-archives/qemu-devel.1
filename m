Received: from eggs.gnu.org ([2001:4830:134:3::10]:57826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g6rqo-0000w7-9I
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g6rqi-0005Yd-Jw
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:38:38 -0400
Received: from 8.mo1.mail-out.ovh.net ([178.33.110.239]:34884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g6rqi-0005Ws-Bt
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:38:32 -0400
Received: from player699.ha.ovh.net (unknown [10.109.146.137])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id AC178138DC7
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 08:38:30 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  1 Oct 2018 08:37:55 +0200
Message-Id: <20181001063803.22330-4-clg@kaod.org>
In-Reply-To: <20181001063803.22330-1-clg@kaod.org>
References: <20181001063803.22330-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 03/11] net: lan9118: convert SysBus init
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
 hw/net/lan9118.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index b9032dac595f..a6269d9463b1 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -1320,9 +1320,9 @@ static NetClientInfo net_lan9118_info =3D {
     .link_status_changed =3D lan9118_set_link,
 };
=20
-static int lan9118_init1(SysBusDevice *sbd)
+static void lan9118_realize(DeviceState *dev, Error **errp)
 {
-    DeviceState *dev =3D DEVICE(sbd);
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
     lan9118_state *s =3D LAN9118(dev);
     QEMUBH *bh;
     int i;
@@ -1349,8 +1349,6 @@ static int lan9118_init1(SysBusDevice *sbd)
     s->timer =3D ptimer_init(bh, PTIMER_POLICY_DEFAULT);
     ptimer_set_freq(s->timer, 10000);
     ptimer_set_limit(s->timer, 0xffff, 1);
-
-    return 0;
 }
=20
 static Property lan9118_properties[] =3D {
@@ -1362,12 +1360,11 @@ static Property lan9118_properties[] =3D {
 static void lan9118_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
-    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
=20
-    k->init =3D lan9118_init1;
     dc->reset =3D lan9118_reset;
     dc->props =3D lan9118_properties;
     dc->vmsd =3D &vmstate_lan9118;
+    dc->realize =3D lan9118_realize;
 }
=20
 static const TypeInfo lan9118_info =3D {
--=20
2.17.1
