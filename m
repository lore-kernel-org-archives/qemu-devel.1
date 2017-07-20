Received: from eggs.gnu.org ([2001:4830:134:3::10]:39874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dY75S-0007ZF-1r
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dY75N-0005I7-7f
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:45:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dY75N-0005Ht-0r
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:45:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ABB8A7F6B4
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:45:27 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 20 Jul 2017 10:45:22 +0200
Message-Id: <20170720084522.28616-2-kraxel@redhat.com>
In-Reply-To: <20170720084522.28616-1-kraxel@redhat.com>
References: <20170720084522.28616-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/1] usb: Fix build with newer gcc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Eric Blake <eblake@redhat.com>

gcc 7 is pickier about our sources:

hw/usb/bus.c: In function =E2=80=98usb_port_location=E2=80=99:
hw/usb/bus.c:410:66: error: =E2=80=98%d=E2=80=99 directive output may be =
truncated writing between 1 and 11 bytes into a region of size between 0 =
and 15 [-Werror=3Dformat-truncation=3D]
         snprintf(downstream->path, sizeof(downstream->path), "%s.%d",
                                                                  ^~
hw/usb/bus.c:410:9: note: =E2=80=98snprintf=E2=80=99 output between 3 and=
 28 bytes into a destination of size 16
         snprintf(downstream->path, sizeof(downstream->path), "%s.%d",
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                  upstream->path, portnr);
                  ~~~~~~~~~~~~~~~~~~~~~~~

But we know that there are at most 5 levels of USB hubs, with at
most two digits per level; that plus the separating dots means we
use at most 15 bytes (including trailing NUL) of our 16-byte field.
Adding an assertion to show gcc that we checked for truncation is
enough to shut up the false-positive warning.

Inspired by an idea by Dr. David Alan Gilbert <dgilbert@redhat.com>.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20170717151334.17954-1-eblake@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/bus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 5939b273b9..d910f849e7 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -407,8 +407,10 @@ void usb_register_companion(const char *masterbus, U=
SBPort *ports[],
 void usb_port_location(USBPort *downstream, USBPort *upstream, int portn=
r)
 {
     if (upstream) {
-        snprintf(downstream->path, sizeof(downstream->path), "%s.%d",
-                 upstream->path, portnr);
+        int l =3D snprintf(downstream->path, sizeof(downstream->path), "=
%s.%d",
+                         upstream->path, portnr);
+        /* Max string is nn.nn.nn.nn.nn, which fits in 16 bytes */
+        assert(l < sizeof(downstream->path));
         downstream->hubcount =3D upstream->hubcount + 1;
     } else {
         snprintf(downstream->path, sizeof(downstream->path), "%d", portn=
r);
--=20
2.9.3
