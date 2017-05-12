Received: from eggs.gnu.org ([2001:4830:134:3::10]:41266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d99aE-0000Kz-2e
	for qemu-devel@nongnu.org; Fri, 12 May 2017 08:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d99aA-00056U-Rs
	for qemu-devel@nongnu.org; Fri, 12 May 2017 08:22:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d99aA-00055z-MC
	for qemu-devel@nongnu.org; Fri, 12 May 2017 08:22:06 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8421851462
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 12:22:05 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 May 2017 14:21:54 +0200
Message-Id: <20170512122158.32032-3-kraxel@redhat.com>
In-Reply-To: <20170512122158.32032-1-kraxel@redhat.com>
References: <20170512122158.32032-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/6] usb-redir: fix stack overflow in
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
Cc: Gerd Hoffmann <kraxel@redhat.com>

Don't reinvent a broken wheel, just use the hexdump function we have.

Impact: low, broken code doesn't run unless you have debug logging
enabled.

Reported-by: =E6=9D=8E=E5=BC=BA <liqiang6-s@360.cn>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20170509110128.27261-1-kraxel@redhat.com
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
