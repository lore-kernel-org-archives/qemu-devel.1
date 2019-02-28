Received: from eggs.gnu.org ([209.51.188.92]:42186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gzPwF-0000tw-Qr
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:57:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gzPwE-0000bp-E8
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:57:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gzPwD-0000ZM-To
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:57:42 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1SHtkmH011343
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 12:57:40 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qxhwb8vpb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 12:57:39 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 28 Feb 2019 17:57:37 -0000
From: Greg Kurz <groug@kaod.org>
Date: Thu, 28 Feb 2019 18:57:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <155137665241.44413.528147250140332507.stgit@bahia.lan>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] usb-mtp: Fix build with gcc 9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Build fails with gcc 9:

  CC      hw/usb/dev-mtp.o
hw/usb/dev-mtp.c: In function =E2=80=98usb_mtp_write_metadata=E2=80=99:
hw/usb/dev-mtp.c:1754:36: error: taking address of packed member of =E2=80=
=98struct <anonymous>=E2=80=99 may result in an unaligned pointer value [=
-Werror=3Daddress-of-packed-member]
 1754 |                             dataset->filename);
      |                             ~~~~~~~^~~~~~~~~~
cc1: all warnings being treated as errors

The way the MTP protocol encodes strings with a leading 8-bit unsigned
integer containing the string length causes the @filename field of the
packed ObjectInfo structure to be unaligned.

Use a temporary buffer for the utf16 filename instead of passing the
dataset->filename pointer around.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/usb/dev-mtp.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 4ee4fc5a893a..8a0ef7f9f4a8 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1692,13 +1692,25 @@ static void usb_mtp_write_metadata(MTPState *s, u=
int64_t dlen)
     MTPObject *o;
     MTPObject *p =3D usb_mtp_object_lookup(s, s->dataset.parent_handle);
     uint32_t next_handle =3D s->next_handle;
+    uint16_t *utf16_filename;
+    uint8_t filename_len;
=20
     assert(!s->write_pending);
     assert(p !=3D NULL);
=20
-    filename =3D utf16_to_str(MIN(dataset->length,
-                                dlen - offsetof(ObjectInfo, filename)),
-                            dataset->filename);
+    /*
+     * MTP Specification 3.2.3 Strings
+     * Strings in PTP (and thus MTP) consist of standard 2-byte Unicode
+     * characters as defined by ISO 10646. Strings begin with a single, =
8-bit
+     * unsigned integer that identifies the number of characters to foll=
ow (not
+     * bytes).
+     *
+     * This causes dataset->filename to be unaligned.
+     */
+    filename_len =3D MIN(dataset->length, dlen - offsetof(ObjectInfo, fi=
lename));
+    utf16_filename =3D g_memdup(dataset->filename, filename_len * 2);
+    filename =3D utf16_to_str(filename_len, utf16_filename);
+    g_free(utf16_filename);
=20
     if (strchr(filename, '/')) {
         usb_mtp_queue_result(s, RES_PARAMETER_NOT_SUPPORTED, d->trans,
