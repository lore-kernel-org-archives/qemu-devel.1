Received: from eggs.gnu.org ([2001:4830:134:3::10]:49780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gTuEv-0003vU-KH
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 14:50:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gTuEs-0006yk-Jo
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 14:50:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gTuEs-0006xy-BW
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 14:50:42 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A781C02834D
	for <qemu-devel@nongnu.org>; Mon,  3 Dec 2018 19:50:41 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  3 Dec 2018 20:50:38 +0100
Message-Id: <20181203195039.29597-2-kraxel@redhat.com>
In-Reply-To: <20181203195039.29597-1-kraxel@redhat.com>
References: <20181203195039.29597-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] usb-mtp: fix utf16_to_str
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Make utf16_to_str return an allocated string.  Remove the assumtion that
the number of string bytes equals the number of utf16 chars (which is
only true for ascii chars).  Instead call wcstombs twice, once to figure
the storage size and once for the actual conversion (as suggested by the
wcstombs manpage).

FIXME: surrogate pairs are not working correctly.  Pre-existing bug,
fixing that is left for another day.

Reported-by: Michael Hanselmann <public@hansmi.ch>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-id: 20181203101045.27976-2-kraxel@redhat.com
---
 hw/usb/dev-mtp.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 00a3691bae..0f6a9702ef 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1593,17 +1593,23 @@ static void usb_mtp_cancel_packet(USBDevice *dev,=
 USBPacket *p)
     fprintf(stderr, "%s\n", __func__);
 }
=20
-static void utf16_to_str(uint8_t len, uint16_t *arr, char *name)
+static char *utf16_to_str(uint8_t len, uint16_t *arr)
 {
-    int count;
-    wchar_t *wstr =3D g_new0(wchar_t, len);
+    wchar_t *wstr =3D g_new0(wchar_t, len + 1);
+    int count, dlen;
+    char *dest;
=20
     for (count =3D 0; count < len; count++) {
+        /* FIXME: not working for surrogate pairs */
         wstr[count] =3D (wchar_t)arr[count];
     }
+    wstr[count] =3D 0;
=20
-    wcstombs(name, wstr, len);
+    dlen =3D wcstombs(NULL, wstr, 0) + 1;
+    dest =3D g_malloc(dlen);
+    wcstombs(dest, wstr, dlen);
     g_free(wstr);
+    return dest;
 }
=20
 /* Wrapper around write, returns 0 on failure */
@@ -1703,7 +1709,7 @@ static void usb_mtp_write_metadata(MTPState *s)
 {
     MTPData *d =3D s->data_out;
     ObjectInfo *dataset =3D (ObjectInfo *)d->data;
-    char *filename =3D g_new0(char, dataset->length);
+    char *filename;
     MTPObject *o;
     MTPObject *p =3D usb_mtp_object_lookup(s, s->dataset.parent_handle);
     uint32_t next_handle =3D s->next_handle;
@@ -1711,7 +1717,7 @@ static void usb_mtp_write_metadata(MTPState *s)
     assert(!s->write_pending);
     assert(p !=3D NULL);
=20
-    utf16_to_str(dataset->length, dataset->filename, filename);
+    filename =3D utf16_to_str(dataset->length, dataset->filename);
=20
     o =3D usb_mtp_object_lookup_name(p, filename, dataset->length);
     if (o !=3D NULL) {
--=20
2.9.3
