Received: from eggs.gnu.org ([2001:4830:134:3::10]:49781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gTuEv-0003vV-KY
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 14:50:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gTuEs-0006yW-By
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 14:50:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gTuEs-0006x1-4i
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 14:50:42 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 15C1B3002607
	for <qemu-devel@nongnu.org>; Mon,  3 Dec 2018 19:50:41 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  3 Dec 2018 20:50:39 +0100
Message-Id: <20181203195039.29597-3-kraxel@redhat.com>
In-Reply-To: <20181203195039.29597-1-kraxel@redhat.com>
References: <20181203195039.29597-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] usb-mtp: outlaw slashes in filenames
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

Slash is unix directory separator, so they are not allowed in filenames.
Note this also stops the classic escape via "../".

Fixes: CVE-2018-16867
Reported-by: Michael Hanselmann <public@hansmi.ch>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20181203101045.27976-3-kraxel@redhat.com
---
 hw/usb/dev-mtp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 0f6a9702ef..100b7171f4 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1719,6 +1719,12 @@ static void usb_mtp_write_metadata(MTPState *s)
=20
     filename =3D utf16_to_str(dataset->length, dataset->filename);
=20
+    if (strchr(filename, '/')) {
+        usb_mtp_queue_result(s, RES_PARAMETER_NOT_SUPPORTED, d->trans,
+                             0, 0, 0, 0);
+        return;
+    }
+
     o =3D usb_mtp_object_lookup_name(p, filename, dataset->length);
     if (o !=3D NULL) {
         next_handle =3D o->handle;
--=20
2.9.3
