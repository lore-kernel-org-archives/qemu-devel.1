Received: from eggs.gnu.org ([2001:4830:134:3::10]:56485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cgBFK-00022J-Ko
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:16:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cgBFI-0004cX-Qs
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:16:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cgBFI-0004c2-IT
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:16:48 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BF1BE7E9E5
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 14:16:48 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 21 Feb 2017 18:14:45 +0400
Message-Id: <20170221141451.28305-25-marcandre.lureau@redhat.com>
In-Reply-To: <20170221141451.28305-1-marcandre.lureau@redhat.com>
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 24/30] usb: replace handle_destroy with
 unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Curiously, unrealize() is not being used, but it seems more
appropriate than handle_destroy() together with realize(). It is more
ubiquitous destroy name in qemu code base and may throw errors.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/usb.h              | 5 -----
 hw/usb/bus.c                  | 9 +++++----
 hw/usb/dev-audio.c            | 4 ++--
 hw/usb/dev-bluetooth.c        | 4 ++--
 hw/usb/dev-hid.c              | 4 ++--
 hw/usb/dev-hub.c              | 4 ++--
 hw/usb/dev-network.c          | 4 ++--
 hw/usb/dev-smartcard-reader.c | 4 ++--
 hw/usb/dev-uas.c              | 4 ++--
 hw/usb/dev-wacom.c            | 4 ++--
 hw/usb/host-libusb.c          | 4 ++--
 hw/usb/redirect.c             | 4 ++--
 12 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/include/hw/usb.h b/include/hw/usb.h
index c42b29c866..eb28655270 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -291,11 +291,6 @@ typedef struct USBDeviceClass {
     void (*cancel_packet)(USBDevice *dev, USBPacket *p);
=20
     /*
-     * Called when device is destroyed.
-     */
-    void (*handle_destroy)(USBDevice *dev);
-
-    /*
      * Attach the device
      */
     void (*handle_attach)(USBDevice *dev);
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 1dcc35c8f8..efe4b8e1a6 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -136,11 +136,12 @@ USBDevice *usb_device_find_device(USBDevice *dev, u=
int8_t addr)
     return NULL;
 }
=20
-static void usb_device_handle_destroy(USBDevice *dev)
+static void usb_device_unrealize(USBDevice *dev, Error **errp)
 {
     USBDeviceClass *klass =3D USB_DEVICE_GET_CLASS(dev);
-    if (klass->handle_destroy) {
-        klass->handle_destroy(dev);
+
+    if (klass->unrealize) {
+        klass->unrealize(dev, errp);
     }
 }
=20
@@ -291,7 +292,7 @@ static void usb_qdev_unrealize(DeviceState *qdev, Err=
or **errp)
     if (dev->attached) {
         usb_device_detach(dev);
     }
-    usb_device_handle_destroy(dev);
+    usb_device_unrealize(dev, errp);
     if (dev->port) {
         usb_release_port(dev);
     }
diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index 87cab0a3d1..343345235c 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -617,7 +617,7 @@ static void usb_audio_handle_data(USBDevice *dev, USB=
Packet *p)
     }
 }
=20
-static void usb_audio_handle_destroy(USBDevice *dev)
+static void usb_audio_unrealize(USBDevice *dev, Error **errp)
 {
     USBAudioState *s =3D USB_AUDIO(dev);
=20
@@ -683,7 +683,7 @@ static void usb_audio_class_init(ObjectClass *klass, =
void *data)
     k->handle_reset   =3D usb_audio_handle_reset;
     k->handle_control =3D usb_audio_handle_control;
     k->handle_data    =3D usb_audio_handle_data;
-    k->handle_destroy =3D usb_audio_handle_destroy;
+    k->unrealize      =3D usb_audio_unrealize;
     k->set_interface  =3D usb_audio_set_interface;
 }
=20
diff --git a/hw/usb/dev-bluetooth.c b/hw/usb/dev-bluetooth.c
index 91a4a0b8b9..443e3c301d 100644
--- a/hw/usb/dev-bluetooth.c
+++ b/hw/usb/dev-bluetooth.c
@@ -496,7 +496,7 @@ static void usb_bt_out_hci_packet_acl(void *opaque,
     usb_bt_fifo_enqueue(&s->acl, data, len);
 }
=20
-static void usb_bt_handle_destroy(USBDevice *dev)
+static void usb_bt_unrealize(USBDevice *dev, Error **errp)
 {
     struct USBBtState *s =3D (struct USBBtState *) dev->opaque;
=20
@@ -559,7 +559,7 @@ static void usb_bt_class_initfn(ObjectClass *klass, v=
oid *data)
     uc->handle_reset   =3D usb_bt_handle_reset;
     uc->handle_control =3D usb_bt_handle_control;
     uc->handle_data    =3D usb_bt_handle_data;
-    uc->handle_destroy =3D usb_bt_handle_destroy;
+    uc->unrealize      =3D usb_bt_unrealize;
     dc->vmsd =3D &vmstate_usb_bt;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
 }
diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index dda0bf0df0..c40019df96 100644
--- a/hw/usb/dev-hid.c
+++ b/hw/usb/dev-hid.c
@@ -690,7 +690,7 @@ static void usb_hid_handle_data(USBDevice *dev, USBPa=
cket *p)
     }
 }
=20
-static void usb_hid_handle_destroy(USBDevice *dev)
+static void usb_hid_unrealize(USBDevice *dev, Error **errp)
 {
     USBHIDState *us =3D USB_HID(dev);
=20
@@ -785,7 +785,7 @@ static void usb_hid_class_initfn(ObjectClass *klass, =
void *data)
     uc->handle_reset   =3D usb_hid_handle_reset;
     uc->handle_control =3D usb_hid_handle_control;
     uc->handle_data    =3D usb_hid_handle_data;
-    uc->handle_destroy =3D usb_hid_handle_destroy;
+    uc->unrealize      =3D usb_hid_unrealize;
     uc->handle_attach  =3D usb_desc_attach;
 }
=20
diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index a33f21cb38..9fe7333946 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -497,7 +497,7 @@ static void usb_hub_handle_data(USBDevice *dev, USBPa=
cket *p)
     }
 }
=20
-static void usb_hub_handle_destroy(USBDevice *dev)
+static void usb_hub_unrealize(USBDevice *dev, Error **errp)
 {
     USBHubState *s =3D (USBHubState *)dev;
     int i;
@@ -575,7 +575,7 @@ static void usb_hub_class_initfn(ObjectClass *klass, =
void *data)
     uc->handle_reset   =3D usb_hub_handle_reset;
     uc->handle_control =3D usb_hub_handle_control;
     uc->handle_data    =3D usb_hub_handle_data;
-    uc->handle_destroy =3D usb_hub_handle_destroy;
+    uc->unrealize      =3D usb_hub_unrealize;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name =3D "hub";
     dc->vmsd =3D &vmstate_usb_hub;
diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
index c0f1193ba9..85fc81bf43 100644
--- a/hw/usb/dev-network.c
+++ b/hw/usb/dev-network.c
@@ -1324,7 +1324,7 @@ static void usbnet_cleanup(NetClientState *nc)
     s->nic =3D NULL;
 }
=20
-static void usb_net_handle_destroy(USBDevice *dev)
+static void usb_net_unrealize(USBDevice *dev, Error **errp)
 {
     USBNetState *s =3D (USBNetState *) dev;
=20
@@ -1428,7 +1428,7 @@ static void usb_net_class_initfn(ObjectClass *klass=
, void *data)
     uc->handle_reset   =3D usb_net_handle_reset;
     uc->handle_control =3D usb_net_handle_control;
     uc->handle_data    =3D usb_net_handle_data;
-    uc->handle_destroy =3D usb_net_handle_destroy;
+    uc->unrealize      =3D usb_net_unrealize;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     dc->fw_name =3D "network";
     dc->vmsd =3D &vmstate_usb_net;
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.=
c
index 7cd4ed0d17..757b8b3f5a 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1163,7 +1163,7 @@ static void ccid_handle_data(USBDevice *dev, USBPac=
ket *p)
     }
 }
=20
-static void ccid_handle_destroy(USBDevice *dev)
+static void ccid_unrealize(USBDevice *dev, Error **errp)
 {
     USBCCIDState *s =3D USB_CCID_DEV(dev);
=20
@@ -1470,7 +1470,7 @@ static void ccid_class_initfn(ObjectClass *klass, v=
oid *data)
     uc->handle_reset   =3D ccid_handle_reset;
     uc->handle_control =3D ccid_handle_control;
     uc->handle_data    =3D ccid_handle_data;
-    uc->handle_destroy =3D ccid_handle_destroy;
+    uc->unrealize      =3D ccid_unrealize;
     dc->desc =3D "CCID Rev 1.1 smartcard reader";
     dc->vmsd =3D &ccid_vmstate;
     dc->props =3D ccid_properties;
diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index da2fb7017e..3b26655889 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -891,7 +891,7 @@ static void usb_uas_handle_data(USBDevice *dev, USBPa=
cket *p)
     }
 }
=20
-static void usb_uas_handle_destroy(USBDevice *dev)
+static void usb_uas_unrealize(USBDevice *dev, Error **errp)
 {
     UASDevice *uas =3D USB_UAS(dev);
=20
@@ -944,7 +944,7 @@ static void usb_uas_class_initfn(ObjectClass *klass, =
void *data)
     uc->handle_reset   =3D usb_uas_handle_reset;
     uc->handle_control =3D usb_uas_handle_control;
     uc->handle_data    =3D usb_uas_handle_data;
-    uc->handle_destroy =3D usb_uas_handle_destroy;
+    uc->unrealize      =3D usb_uas_unrealize;
     uc->attached_settable =3D true;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     dc->fw_name =3D "storage";
diff --git a/hw/usb/dev-wacom.c b/hw/usb/dev-wacom.c
index c4702dbba0..bf70013059 100644
--- a/hw/usb/dev-wacom.c
+++ b/hw/usb/dev-wacom.c
@@ -329,7 +329,7 @@ static void usb_wacom_handle_data(USBDevice *dev, USB=
Packet *p)
     }
 }
=20
-static void usb_wacom_handle_destroy(USBDevice *dev)
+static void usb_wacom_unrealize(USBDevice *dev, Error **errp)
 {
     USBWacomState *s =3D (USBWacomState *) dev;
=20
@@ -364,7 +364,7 @@ static void usb_wacom_class_init(ObjectClass *klass, =
void *data)
     uc->handle_reset   =3D usb_wacom_handle_reset;
     uc->handle_control =3D usb_wacom_handle_control;
     uc->handle_data    =3D usb_wacom_handle_data;
-    uc->handle_destroy =3D usb_wacom_handle_destroy;
+    uc->unrealize      =3D usb_wacom_unrealize;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
     dc->desc =3D "QEMU PenPartner Tablet";
     dc->vmsd =3D &vmstate_usb_wacom;
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 7791c6d520..c9876a5b0f 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1065,7 +1065,7 @@ static void usb_host_instance_init(Object *obj)
                                   &udev->qdev, NULL);
 }
=20
-static void usb_host_handle_destroy(USBDevice *udev)
+static void usb_host_unrealize(USBDevice *udev, Error **errp)
 {
     USBHostDevice *s =3D USB_HOST_DEVICE(udev);
=20
@@ -1568,7 +1568,7 @@ static void usb_host_class_initfn(ObjectClass *klas=
s, void *data)
     uc->handle_data    =3D usb_host_handle_data;
     uc->handle_control =3D usb_host_handle_control;
     uc->handle_reset   =3D usb_host_handle_reset;
-    uc->handle_destroy =3D usb_host_handle_destroy;
+    uc->unrealize      =3D usb_host_unrealize;
     uc->flush_ep_queue =3D usb_host_flush_ep_queue;
     uc->alloc_streams  =3D usb_host_alloc_streams;
     uc->free_streams   =3D usb_host_free_streams;
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 860f5c35eb..0efe62f725 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -1427,7 +1427,7 @@ static void usbredir_cleanup_device_queues(USBRedir=
Device *dev)
     }
 }
=20
-static void usbredir_handle_destroy(USBDevice *udev)
+static void usbredir_unrealize(USBDevice *udev, Error **errp)
 {
     USBRedirDevice *dev =3D USB_REDIRECT(udev);
     Chardev *chr =3D qemu_chr_fe_get_driver(&dev->cs);
@@ -2513,7 +2513,7 @@ static void usbredir_class_initfn(ObjectClass *klas=
s, void *data)
=20
     uc->realize        =3D usbredir_realize;
     uc->product_desc   =3D "USB Redirection Device";
-    uc->handle_destroy =3D usbredir_handle_destroy;
+    uc->unrealize      =3D usbredir_unrealize;
     uc->cancel_packet  =3D usbredir_cancel_packet;
     uc->handle_reset   =3D usbredir_handle_reset;
     uc->handle_data    =3D usbredir_handle_data;
--=20
2.11.0.295.gd7dffce1c.dirty
