Received: from eggs.gnu.org ([2001:4830:134:3::10]:36329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYYhB-00039L-Ay
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:42:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYYh7-0005zZ-EV
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:42:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cYYh7-0005z5-9k
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:42:01 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 31 Jan 2017 14:41:42 +0100
Message-Id: <1485870106-25016-7-git-send-email-kraxel@redhat.com>
In-Reply-To: <1485870106-25016-1-git-send-email-kraxel@redhat.com>
References: <1485870106-25016-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/10] ui: fix format specfier in vnc to avoid
 break in build.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Rami Rosen <rami.rosen@intel.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Rami Rosen <rami.rosen@intel.com>

When building qemu after setting _VNC_DEBUG to 1 (see ui/vnc.h),
we get the following error and the build breaks:
...
ui/vnc.c: In function =E2=80=98vnc_client_io_error=E2=80=99:
ui/vnc.c:1262:13: error: format =E2=80=98%d=E2=80=99 expects argument of =
type =E2=80=98int=E2=80=99, but
             VNC_DEBUG("Closing down client sock: ret %d (%s)\n",
             ^
cc1: all warnings being treated as errors
make: *** [ui/vnc.o] Error 1
...

This patch solves this issue by fixing the print format specifier
in vnc_client_io_error() to be %zd, which corresponds to the type
of the "ret" variable.

Signed-off-by: Rami Rosen <rami.rosen@intel.com>
Message-id: 1484039965-25907-1-git-send-email-rami.rosen@intel.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index cf9b597..6854fdb 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1257,7 +1257,7 @@ ssize_t vnc_client_io_error(VncState *vs, ssize_t r=
et, Error **errp)
         if (ret =3D=3D 0) {
             VNC_DEBUG("Closing down client sock: EOF\n");
         } else if (ret !=3D QIO_CHANNEL_ERR_BLOCK) {
-            VNC_DEBUG("Closing down client sock: ret %d (%s)\n",
+            VNC_DEBUG("Closing down client sock: ret %zd (%s)\n",
                       ret, errp ? error_get_pretty(*errp) : "Unknown");
         }
=20
--=20
1.8.3.1
