Received: from eggs.gnu.org ([2001:4830:134:3::10]:39243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fUqM0-00075l-AZ
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 05:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fUqLz-0000YZ-80
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 05:21:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44358 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fUqLz-0000XZ-0u
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 05:21:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A30324000D08
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 09:21:38 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 18 Jun 2018 11:21:31 +0200
Message-Id: <20180618092132.7253-3-kraxel@redhat.com>
In-Reply-To: <20180618092132.7253-1-kraxel@redhat.com>
References: <20180618092132.7253-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/3] Revert "usb: release the created buses"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The USB device don't hold the bus. There is no ASAN related reports
anymore.

This reverts commit cd7bc87868d534f95e928cad98e2a52df7695771.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20180613172815.32738-3-marcandre.lureau@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-storage.c | 16 ----------------
 hw/usb/dev-uas.c     |  2 --
 2 files changed, 18 deletions(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 47b992f403..c99398b7f6 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -588,13 +588,6 @@ static const struct SCSIBusInfo usb_msd_scsi_info_bo=
t =3D {
     .load_request =3D usb_msd_load_request,
 };
=20
-static void usb_msd_unrealize_storage(USBDevice *dev, Error **errp)
-{
-    MSDState *s =3D USB_STORAGE_DEV(dev);
-
-    object_unref(OBJECT(&s->bus));
-}
-
 static void usb_msd_storage_realize(USBDevice *dev, Error **errp)
 {
     MSDState *s =3D USB_STORAGE_DEV(dev);
@@ -642,13 +635,6 @@ static void usb_msd_storage_realize(USBDevice *dev, =
Error **errp)
     s->scsi_dev =3D scsi_dev;
 }
=20
-static void usb_msd_bot_unrealize(USBDevice *dev, Error **errp)
-{
-    MSDState *s =3D USB_STORAGE_DEV(dev);
-
-    object_unref(OBJECT(&s->bus));
-}
-
 static void usb_msd_bot_realize(USBDevice *dev, Error **errp)
 {
     MSDState *s =3D USB_STORAGE_DEV(dev);
@@ -712,7 +698,6 @@ static void usb_msd_class_storage_initfn(ObjectClass =
*klass, void *data)
     USBDeviceClass *uc =3D USB_DEVICE_CLASS(klass);
=20
     uc->realize =3D usb_msd_storage_realize;
-    uc->unrealize =3D usb_msd_unrealize_storage;
     dc->props =3D msd_properties;
 }
=20
@@ -775,7 +760,6 @@ static void usb_msd_class_bot_initfn(ObjectClass *kla=
ss, void *data)
     USBDeviceClass *uc =3D USB_DEVICE_CLASS(klass);
=20
     uc->realize =3D usb_msd_bot_realize;
-    uc->unrealize =3D usb_msd_bot_unrealize;
     uc->attached_settable =3D true;
 }
=20
diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index aaf5a88095..be566cad02 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -896,8 +896,6 @@ static void usb_uas_unrealize(USBDevice *dev, Error *=
*errp)
     UASDevice *uas =3D USB_UAS(dev);
=20
     qemu_bh_delete(uas->status_bh);
-
-    object_unref(OBJECT(&uas->bus));
 }
=20
 static void usb_uas_realize(USBDevice *dev, Error **errp)
--=20
2.9.3
