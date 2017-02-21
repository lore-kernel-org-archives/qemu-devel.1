Received: from eggs.gnu.org ([2001:4830:134:3::10]:59308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg4gd-0002yj-8Y
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:16:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg4ga-000886-RH
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:16:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cg4ga-00087S-Lf
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:16:32 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E653496D6
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 07:16:32 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 08:16:25 +0100
Message-Id: <1487661385-7720-12-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487661385-7720-1-git-send-email-kraxel@redhat.com>
References: <1487661385-7720-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/11] usb-ccid: add check message size checks
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

Check message size too when figuring whenever we should expect more data.
Fix debug message to show useful data, p->iov.size is fixed anyway if we
land there, print how much we got meanwhile instead.

Also check announced message size against actual message size.  That
is a more general fix for CVE-2017-5898 than commit "c7dfbf3 usb: ccid:
check ccid apdu length".

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 1487250819-23764-4-git-send-email-kraxel@redhat.com
---
 hw/usb/dev-smartcard-reader.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.=
c
index 1acc1fb..7cd4ed0 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1011,12 +1011,19 @@ static void ccid_handle_bulk_out(USBCCIDState *s,=
 USBPacket *p)
     }
=20
     ccid_header =3D (CCID_Header *)s->bulk_out_data;
-    if (p->iov.size =3D=3D CCID_MAX_PACKET_SIZE) {
+    if ((s->bulk_out_pos - 10 < ccid_header->dwLength) &&
+        (p->iov.size =3D=3D CCID_MAX_PACKET_SIZE)) {
         DPRINTF(s, D_VERBOSE,
-            "usb-ccid: bulk_in: expecting more packets (%zd/%d)\n",
-            p->iov.size, ccid_header->dwLength);
+                "usb-ccid: bulk_in: expecting more packets (%d/%d)\n",
+                s->bulk_out_pos - 10, ccid_header->dwLength);
         return;
     }
+    if (s->bulk_out_pos - 10 !=3D ccid_header->dwLength) {
+        DPRINTF(s, 1,
+                "usb-ccid: bulk_in: message size mismatch (got %d, expec=
ted %d)\n",
+                s->bulk_out_pos - 10, ccid_header->dwLength);
+        goto err;
+    }
=20
     DPRINTF(s, D_MORE_INFO, "%s %x %s\n", __func__,
             ccid_header->bMessageType,
--=20
1.8.3.1
