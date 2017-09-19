Received: from eggs.gnu.org ([2001:4830:134:3::10]:45949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLlU-0005DR-DG
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:52:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLlT-0001T2-FE
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:52:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1duLlT-0001Sg-8b
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:52:51 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 19 Sep 2017 18:52:03 +0200
Message-Id: <20170919165226.23022-5-marcandre.lureau@redhat.com>
In-Reply-To: <20170919165226.23022-1-marcandre.lureau@redhat.com>
References: <20170919165226.23022-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 04/27] libvhost-user: drop dependency on glib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, changpeng.liu@intel.com, f4bug@amsat.org, felipe@nutanix.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

libvhost-user is meant to be free of glib dependency. Make sure it is
by droping qemu/osdep.h (which included glib.h)

This fixes a bad malloc()/g_free() pair.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 contrib/libvhost-user/libvhost-user.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index d27d6303db..50657c5afb 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -13,14 +13,35 @@
  * later.  See the COPYING file in the top-level directory.
  */
=20
-#include <qemu/osdep.h>
+/* this code avoids GLib dependency */
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
+/* usually provided by GLib */
+#ifndef MIN
+#define MIN(x, y) ({                            \
+            typeof(x) _min1 =3D (x);              \
+            typeof(y) _min2 =3D (y);              \
+            (void) (&_min1 =3D=3D &_min2);          \
+            _min1 < _min2 ? _min1 : _min2; })
+#endif
+
 #define VHOST_USER_HDR_SIZE offsetof(VhostUserMsg, payload.u64)
=20
 /* The version of the protocol we support */
@@ -81,7 +102,9 @@ vu_panic(VuDev *dev, const char *msg, ...)
     va_list ap;
=20
     va_start(ap, msg);
-    buf =3D g_strdup_vprintf(msg, ap);
+    if (vasprintf(&buf, msg, ap) < 0) {
+        buf =3D NULL;
+    }
     va_end(ap);
=20
     dev->broken =3D true;
@@ -853,7 +876,7 @@ vu_dispatch(VuDev *dev)
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
