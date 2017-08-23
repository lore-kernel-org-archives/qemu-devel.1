Received: from eggs.gnu.org ([2001:4830:134:3::10]:43278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkYOC-00057R-4g
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:20:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkYOB-0006bO-5q
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:20:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dkYOA-0006b3-VH
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:20:19 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Aug 2017 18:19:39 +0200
Message-Id: <20170823162004.27337-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170823162004.27337-1-marcandre.lureau@redhat.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/27] libvhost-user: drop dependency on glib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: changpeng.liu@intel.com, felipe@nutanix.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

libvhost-user is meant to be free of glib dependency. Make sure it is
by droping qemu/osdep.h (which included glib.h)

This fixes a bad malloc()/g_free() pair.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index 35fa0c5e56..bb294c6ef7 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -13,11 +13,22 @@
  * later.  See the COPYING file in the top-level directory.
  */
=20
-#include <qemu/osdep.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <stdarg.h>
+#include <errno.h>
+#include <string.h>
+#include <assert.h>
+#include <inttypes.h>
+#include <sys/types.h>
+#include <sys/socket.h>
 #include <sys/eventfd.h>
+#include <sys/mman.h>
 #include <linux/vhost.h>
=20
 #include "qemu/atomic.h"
+#include "qemu/compiler.h"
=20
 #include "libvhost-user.h"
=20
@@ -34,6 +45,14 @@
         }                                       \
     } while (0)
=20
+#ifndef MIN
+#define MIN(x, y) ({                            \
+        typeof(x) _min1 =3D (x);                  \
+        typeof(y) _min2 =3D (y);                  \
+        (void) (&_min1 =3D=3D &_min2);              \
+        _min1 < _min2 ? _min1 : _min2; })
+#endif
+
 static const char *
 vu_request_to_string(int req)
 {
@@ -81,7 +100,7 @@ vu_panic(VuDev *dev, const char *msg, ...)
     va_list ap;
=20
     va_start(ap, msg);
-    buf =3D g_strdup_vprintf(msg, ap);
+    vasprintf(&buf, msg, ap);
     va_end(ap);
=20
     dev->broken =3D true;
@@ -840,7 +859,7 @@ vu_dispatch(VuDev *dev)
     success =3D true;
=20
 end:
-    g_free(vmsg.data);
+    free(vmsg.data);
     return success;
 }
=20
--=20
2.14.1.146.gd35faa819
