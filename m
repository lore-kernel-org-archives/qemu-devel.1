Received: from eggs.gnu.org ([2001:4830:134:3::10]:41782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cj0DK-0003eM-Ig
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:06:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cj0DJ-0001jI-HZ
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:06:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cj0DJ-0001j8-BP
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:06:25 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D0C380F93
	for <qemu-devel@nongnu.org>; Wed,  1 Mar 2017 09:06:25 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  1 Mar 2017 13:04:49 +0400
Message-Id: <20170301090453.11075-25-marcandre.lureau@redhat.com>
In-Reply-To: <20170301090453.11075-1-marcandre.lureau@redhat.com>
References: <20170301090453.11075-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 24/28] usb: release the created buses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Leaks spotted by ASAN.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-storage.c | 16 ++++++++++++++++
 hw/usb/dev-uas.c     |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index c607f7606d..74b7856278 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -589,6 +589,13 @@ static const struct SCSIBusInfo usb_msd_scsi_info_bo=
t =3D {
     .load_request =3D usb_msd_load_request,
 };
=20
+static void usb_msd_unrealize_storage(USBDevice *dev, Error **errp)
+{
+    MSDState *s =3D USB_STORAGE_DEV(dev);
+
+    object_unref(OBJECT(&s->bus));
+}
+
 static void usb_msd_realize_storage(USBDevice *dev, Error **errp)
 {
     MSDState *s =3D USB_STORAGE_DEV(dev);
@@ -635,6 +642,13 @@ static void usb_msd_realize_storage(USBDevice *dev, =
Error **errp)
     s->scsi_dev =3D scsi_dev;
 }
=20
+static void usb_msd_unrealize_bot(USBDevice *dev, Error **errp)
+{
+    MSDState *s =3D USB_STORAGE_DEV(dev);
+
+    object_unref(OBJECT(&s->bus));
+}
+
 static void usb_msd_realize_bot(USBDevice *dev, Error **errp)
 {
     MSDState *s =3D USB_STORAGE_DEV(dev);
@@ -755,6 +769,7 @@ static void usb_msd_class_initfn_storage(ObjectClass =
*klass, void *data)
     USBDeviceClass *uc =3D USB_DEVICE_CLASS(klass);
=20
     uc->realize =3D usb_msd_realize_storage;
+    uc->unrealize =3D usb_msd_unrealize_storage;
     dc->props =3D msd_properties;
 }
=20
@@ -817,6 +832,7 @@ static void usb_msd_class_initfn_bot(ObjectClass *kla=
ss, void *data)
     USBDeviceClass *uc =3D USB_DEVICE_CLASS(klass);
=20
     uc->realize =3D usb_msd_realize_bot;
+    uc->unrealize =3D usb_msd_unrealize_bot;
     uc->attached_settable =3D true;
 }
=20
diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index 3b26655889..fffc424396 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -896,6 +896,8 @@ static void usb_uas_unrealize(USBDevice *dev, Error *=
*errp)
     UASDevice *uas =3D USB_UAS(dev);
=20
     qemu_bh_delete(uas->status_bh);
+
+    object_unref(OBJECT(&uas->bus));
 }
=20
 static void usb_uas_realize(USBDevice *dev, Error **errp)
--=20
2.12.0.rc2.3.gc93709801
