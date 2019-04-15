Received: from eggs.gnu.org ([209.51.188.92]:44094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hG3nY-0000qt-UT
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hG3nX-0007tZ-8W
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:45:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hG3nV-0007bB-1O
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:45:30 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon, 15 Apr 2019 16:45:02 +0100
Message-Id: <20190415154503.6758-3-berrange@redhat.com>
In-Reply-To: <20190415154503.6758-1-berrange@redhat.com>
References: <20190415154503.6758-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] usb-mtp: fix bounds check for guest
 provided filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Bandan Das <bsd@redhat.com>, Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The ObjectInfo struct has a variable length array containing the UTF-16
encoded filename. The number of characters of trailing data is given by
the 'length' field in the struct and this must be validated against the
size of the data packet received from the guest.

Since the data is UTF-16, we must convert the byte count we have to a
character count before validating. This must take care to truncate if
a malicious guest sent an odd number of bytes.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 hw/usb/dev-mtp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 838cd74da6..6b7d1296e4 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1699,12 +1699,19 @@ static void usb_mtp_write_metadata(MTPState *s, u=
int64_t dlen)
     MTPObject *o;
     MTPObject *p =3D usb_mtp_object_lookup(s, s->dataset.parent_handle);
     uint32_t next_handle =3D s->next_handle;
+    size_t filename_chars =3D dlen - offsetof(ObjectInfo, filename);
+
+    /*
+     * filename is utf-16. We're intentionally doing
+     * integer division to truncate if malicious guest
+     * sent an odd number of bytes.
+     */
+    filename_chars /=3D 2;
=20
     assert(!s->write_pending);
     assert(p !=3D NULL);
=20
-    filename =3D utf16_to_str(MIN(dataset->length,
-                                dlen - offsetof(ObjectInfo, filename)),
+    filename =3D utf16_to_str(MIN(dataset->length, filename_chars),
                             dataset->filename);
=20
     if (strchr(filename, '/')) {
--=20
2.20.1
