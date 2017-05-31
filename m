Received: from eggs.gnu.org ([2001:4830:134:3::10]:52985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4BU-0006aS-Ke
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4BT-0004ti-MD
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:01:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dG4BT-0004ta-Gb
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:01:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A7447F6A0
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 14:01:10 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 31 May 2017 17:56:51 +0400
Message-Id: <20170531135709.345-28-marcandre.lureau@redhat.com>
In-Reply-To: <20170531135709.345-1-marcandre.lureau@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 27/45] bcm2835_fb: use {get,
 set}_uint() for "vcram-size" and "vcram-base"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Both properties are defined with DEFINE_PROP_UINT32().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/arm/bcm2835_peripherals.c | 9 ++++-----
 hw/arm/raspi.c               | 4 ++--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 369ef1e3bd..b168c6f83e 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -126,7 +126,7 @@ static void bcm2835_peripherals_realize(DeviceState *=
dev, Error **errp)
     Object *obj;
     MemoryRegion *ram;
     Error *err =3D NULL;
-    uint32_t ram_size, vcram_size;
+    uint64_t ram_size, vcram_size;
     int n;
=20
     obj =3D object_property_get_link(OBJECT(dev), "ram", &err);
@@ -208,15 +208,14 @@ static void bcm2835_peripherals_realize(DeviceState=
 *dev, Error **errp)
                                INTERRUPT_ARM_MAILBOX));
=20
     /* Framebuffer */
-    vcram_size =3D (uint32_t)object_property_get_int(OBJECT(s), "vcram-s=
ize",
-                                                   &err);
+    vcram_size =3D object_property_get_uint(OBJECT(s), "vcram-size", &er=
r);
     if (err) {
         error_propagate(errp, err);
         return;
     }
=20
-    object_property_set_int(OBJECT(&s->fb), ram_size - vcram_size,
-                            "vcram-base", &err);
+    object_property_set_uint(OBJECT(&s->fb), ram_size - vcram_size,
+                             "vcram-base", &err);
     if (err) {
         error_propagate(errp, err);
         return;
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 2b295f14c4..32cdc98c6d 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -153,8 +153,8 @@ static void raspi2_init(MachineState *machine)
     qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
     object_property_set_bool(OBJECT(carddev), true, "realized", &error_f=
atal);
=20
-    vcram_size =3D object_property_get_int(OBJECT(&s->soc), "vcram-size"=
,
-                                         &error_abort);
+    vcram_size =3D object_property_get_uint(OBJECT(&s->soc), "vcram-size=
",
+                                          &error_abort);
     setup_boot(machine, 2, machine->ram_size - vcram_size);
 }
=20
--=20
2.13.0.91.g00982b8dd
