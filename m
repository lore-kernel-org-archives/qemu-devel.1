Received: from eggs.gnu.org ([2001:4830:134:3::10]:45782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1St-0007VO-Tv
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:44:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1St-0006sO-5q
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:44:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dO1Ss-0006s1-VK
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:44:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DAF5B1F59F
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 12:44:01 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Jun 2017 14:41:54 +0200
Message-Id: <20170622124204.19407-22-marcandre.lureau@redhat.com>
In-Reply-To: <20170622124204.19407-1-marcandre.lureau@redhat.com>
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 21/31] usb-hub: use DIV_ROUND_UP
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

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/usb/dev-hub.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index e82a6a6c44..752e30c305 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -109,7 +109,7 @@ static const USBDescIface desc_iface_hub =3D {
         {
             .bEndpointAddress      =3D USB_DIR_IN | 0x01,
             .bmAttributes          =3D USB_ENDPOINT_XFER_INT,
-            .wMaxPacketSize        =3D 1 + (NUM_PORTS + 7) / 8,
+            .wMaxPacketSize        =3D 1 + DIV_ROUND_UP(NUM_PORTS, 8),
             .bInterval             =3D 0xff,
         },
     }
@@ -442,14 +442,14 @@ static void usb_hub_handle_control(USBDevice *dev, =
USBPacket *p,
             data[2] =3D NUM_PORTS;
=20
             /* fill DeviceRemovable bits */
-            limit =3D ((NUM_PORTS + 1 + 7) / 8) + 7;
+            limit =3D DIV_ROUND_UP(NUM_PORTS + 1, 8) + 7;
             for (n =3D 7; n < limit; n++) {
                 data[n] =3D 0x00;
                 var_hub_size++;
             }
=20
             /* fill PortPwrCtrlMask bits */
-            limit =3D limit + ((NUM_PORTS + 7) / 8);
+            limit =3D limit + DIV_ROUND_UP(NUM_PORTS, 8);
             for (;n < limit; n++) {
                 data[n] =3D 0xff;
                 var_hub_size++;
@@ -477,7 +477,7 @@ static void usb_hub_handle_data(USBDevice *dev, USBPa=
cket *p)
             unsigned int status;
             uint8_t buf[4];
             int i, n;
-            n =3D (NUM_PORTS + 1 + 7) / 8;
+            n =3D DIV_ROUND_UP(NUM_PORTS + 1, 8);
             if (p->iov.size =3D=3D 1) { /* FreeBSD workaround */
                 n =3D 1;
             } else if (n > p->iov.size) {
--=20
2.13.1.395.gf7b71de06
