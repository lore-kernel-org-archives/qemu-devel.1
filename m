Received: from eggs.gnu.org ([209.51.188.92]:33166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hM6GK-00026N-60
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:36:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hM6GI-000136-3I
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:36:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hM6GG-0000gx-6H
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:36:10 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  2 May 2019 09:35:38 +0200
Message-Id: <20190502073543.4391-3-kraxel@redhat.com>
In-Reply-To: <20190502073543.4391-1-kraxel@redhat.com>
References: <20190502073543.4391-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/7] usb-mtp: fix alignment of access of
 ObjectInfo filename field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

The ObjectInfo struct's "filename" field is following a uint8_t
field in a packed struct and thus has bad alignment for a 16-bit
field. Switch the field to to uint8_t and use the helper function
for accessing unaligned 16-bit data.

Note that although the MTP spec specifies big endian, when transported
over the USB protocol, data is little endian.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-id: 20190415154503.6758-4-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-mtp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 6b7d1296e430..963449ec7de8 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -226,7 +226,7 @@ typedef struct {
     uint32_t assoc_desc;
     uint32_t seq_no; /*unused*/
     uint8_t length; /*part of filename field*/
-    uint16_t filename[0];
+    uint8_t filename[0]; /* UTF-16 encoded */
     char date_created[0]; /*unused*/
     char date_modified[0]; /*unused*/
     char keywords[0]; /*unused*/
@@ -1551,7 +1551,7 @@ static void usb_mtp_cancel_packet(USBDevice *dev, U=
SBPacket *p)
     fprintf(stderr, "%s\n", __func__);
 }
=20
-static char *utf16_to_str(uint8_t len, uint16_t *arr)
+static char *utf16_to_str(uint8_t len, uint8_t *str16)
 {
     wchar_t *wstr =3D g_new0(wchar_t, len + 1);
     int count, dlen;
@@ -1559,7 +1559,7 @@ static char *utf16_to_str(uint8_t len, uint16_t *ar=
r)
=20
     for (count =3D 0; count < len; count++) {
         /* FIXME: not working for surrogate pairs */
-        wstr[count] =3D (wchar_t)arr[count];
+        wstr[count] =3D lduw_le_p(str16 + (count * 2));
     }
     wstr[count] =3D 0;
=20
--=20
2.18.1
