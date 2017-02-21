Received: from eggs.gnu.org ([2001:4830:134:3::10]:59321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg4gd-0002ys-IS
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:16:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg4gb-00088M-6n
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:16:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cg4gb-00087i-1i
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:16:33 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4D1D8C054C59
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 07:16:33 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 08:16:24 +0100
Message-Id: <1487661385-7720-11-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487661385-7720-1-git-send-email-kraxel@redhat.com>
References: <1487661385-7720-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/11] usb-ccid: move header size check
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

Move up header size check, so we can use header fields in sanity checks
(in followup patches).  Also reword the debug message.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 1487250819-23764-3-git-send-email-kraxel@redhat.com
---
 hw/usb/dev-smartcard-reader.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.=
c
index badcfcb..1acc1fb 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1003,21 +1003,20 @@ static void ccid_handle_bulk_out(USBCCIDState *s,=
 USBPacket *p)
     if (p->iov.size + s->bulk_out_pos > BULK_OUT_DATA_SIZE) {
         goto err;
     }
-    ccid_header =3D (CCID_Header *)s->bulk_out_data;
     usb_packet_copy(p, s->bulk_out_data + s->bulk_out_pos, p->iov.size);
     s->bulk_out_pos +=3D p->iov.size;
+    if (s->bulk_out_pos < 10) {
+        DPRINTF(s, 1, "%s: header incomplete\n", __func__);
+        goto err;
+    }
+
+    ccid_header =3D (CCID_Header *)s->bulk_out_data;
     if (p->iov.size =3D=3D CCID_MAX_PACKET_SIZE) {
         DPRINTF(s, D_VERBOSE,
             "usb-ccid: bulk_in: expecting more packets (%zd/%d)\n",
             p->iov.size, ccid_header->dwLength);
         return;
     }
-    if (s->bulk_out_pos < 10) {
-        DPRINTF(s, 1,
-                "%s: bad USB_TOKEN_OUT length, should be at least 10 byt=
es\n",
-                __func__);
-        goto err;
-    }
=20
     DPRINTF(s, D_MORE_INFO, "%s %x %s\n", __func__,
             ccid_header->bMessageType,
--=20
1.8.3.1
