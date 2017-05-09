Received: from eggs.gnu.org ([2001:4830:134:3::10]:53261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d82tk-0007uw-V7
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:01:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d82tg-0006lf-N9
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:01:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d82tg-0006lB-De
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:01:40 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  9 May 2017 13:01:28 +0200
Message-Id: <20170509110128.27261-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] usb-redir: fix stack overflow in
 usbredir_log_data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: liqiang6-s@360.cn, Gerd Hoffmann <kraxel@redhat.com>

Don't reinvent a broken wheel, just use the hexdump function we have.

Impact: low, broken code doesn't run unless you have debug logging
enabled.

Reported-by: =E6=9D=8E=E5=BC=BA <liqiang6-s@360.cn>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/redirect.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index b001a27f05..ad5ef783a6 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -229,21 +229,10 @@ static void usbredir_log(void *priv, int level, con=
st char *msg)
 static void usbredir_log_data(USBRedirDevice *dev, const char *desc,
     const uint8_t *data, int len)
 {
-    int i, j, n;
-
     if (dev->debug < usbredirparser_debug_data) {
         return;
     }
-
-    for (i =3D 0; i < len; i +=3D j) {
-        char buf[128];
-
-        n =3D sprintf(buf, "%s", desc);
-        for (j =3D 0; j < 8 && i + j < len; j++) {
-            n +=3D sprintf(buf + n, " %02X", data[i + j]);
-        }
-        error_report("%s", buf);
-    }
+    qemu_hexdump((char *)data, stderr, desc, len);
 }
=20
 /*
--=20
2.9.3
