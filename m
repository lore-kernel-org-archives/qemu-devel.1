Received: from eggs.gnu.org ([2001:4830:134:3::10]:49910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dCznx-0004jt-Hu
	for qemu-devel@nongnu.org; Mon, 22 May 2017 22:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dCznv-0005EO-VI
	for qemu-devel@nongnu.org; Mon, 22 May 2017 22:44:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dCznv-0005EB-M8
	for qemu-devel@nongnu.org; Mon, 22 May 2017 22:44:11 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 May 2017 10:43:51 +0800
Message-Id: <1495507439-1784-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1495507439-1784-1-git-send-email-jasowang@redhat.com>
References: <1495507439-1784-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/9] net/tap: Replace tap-haiku.c and tap-aix.c
 by a generic tap-stub.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The files tap-haiku.c and tap-aix.c are identical (except one line
of error message). We should avoid such code duplication, so replace
these by a generic tap-stub.c file instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/Makefile.objs | 15 +++++-----
 net/tap-aix.c     | 88 -------------------------------------------------=
------
 net/tap-haiku.c   | 87 -------------------------------------------------=
-----
 net/tap-stub.c    | 87 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
 4 files changed, 95 insertions(+), 182 deletions(-)
 delete mode 100644 net/tap-aix.c
 delete mode 100644 net/tap-haiku.c
 create mode 100644 net/tap-stub.c

diff --git a/net/Makefile.objs b/net/Makefile.objs
index 2e2fd43..67ba5e2 100644
--- a/net/Makefile.objs
+++ b/net/Makefile.objs
@@ -3,13 +3,7 @@ common-obj-y +=3D socket.o
 common-obj-y +=3D dump.o
 common-obj-y +=3D eth.o
 common-obj-$(CONFIG_L2TPV3) +=3D l2tpv3.o
-common-obj-$(CONFIG_POSIX) +=3D tap.o vhost-user.o
-common-obj-$(CONFIG_LINUX) +=3D tap-linux.o
-common-obj-$(CONFIG_WIN32) +=3D tap-win32.o
-common-obj-$(CONFIG_BSD) +=3D tap-bsd.o
-common-obj-$(CONFIG_SOLARIS) +=3D tap-solaris.o
-common-obj-$(CONFIG_AIX) +=3D tap-aix.o
-common-obj-$(CONFIG_HAIKU) +=3D tap-haiku.o
+common-obj-$(CONFIG_POSIX) +=3D vhost-user.o
 common-obj-$(CONFIG_SLIRP) +=3D slirp.o
 common-obj-$(CONFIG_VDE) +=3D vde.o
 common-obj-$(CONFIG_NETMAP) +=3D netmap.o
@@ -20,3 +14,10 @@ common-obj-y +=3D colo-compare.o
 common-obj-y +=3D colo.o
 common-obj-y +=3D filter-rewriter.o
 common-obj-y +=3D filter-replay.o
+
+tap-obj-$(CONFIG_LINUX) =3D tap-linux.o
+tap-obj-$(CONFIG_BSD) =3D tap-bsd.o
+tap-obj-$(CONFIG_SOLARIS) =3D tap-solaris.o
+tap-obj-y ?=3D tap-stub.o
+common-obj-$(CONFIG_POSIX) +=3D tap.o $(tap-obj-y)
+common-obj-$(CONFIG_WIN32) +=3D tap-win32.o
diff --git a/net/tap-aix.c b/net/tap-aix.c
deleted file mode 100644
index 0e6da63..0000000
--- a/net/tap-aix.c
+++ /dev/null
@@ -1,88 +0,0 @@
-/*
- * QEMU System Emulator
- *
- * Copyright (c) 2003-2008 Fabrice Bellard
- *
- * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
- * of this software and associated documentation files (the "Software"),=
 to deal
- * in the Software without restriction, including without limitation the=
 rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be includ=
ed in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
- * THE SOFTWARE.
- */
-
-#include "qemu/osdep.h"
-#include "qapi/error.h"
-#include "tap_int.h"
-
-int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
-             int vnet_hdr_required, int mq_required, Error **errp)
-{
-    error_setg(errp, "no tap on AIX");
-    return -1;
-}
-
-void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
-{
-}
-
-int tap_probe_vnet_hdr(int fd)
-{
-    return 0;
-}
-
-int tap_probe_has_ufo(int fd)
-{
-    return 0;
-}
-
-int tap_probe_vnet_hdr_len(int fd, int len)
-{
-    return 0;
-}
-
-void tap_fd_set_vnet_hdr_len(int fd, int len)
-{
-}
-
-int tap_fd_set_vnet_le(int fd, int is_le)
-{
-    return -EINVAL;
-}
-
-int tap_fd_set_vnet_be(int fd, int is_be)
-{
-    return -EINVAL;
-}
-
-void tap_fd_set_offload(int fd, int csum, int tso4,
-                        int tso6, int ecn, int ufo)
-{
-}
-
-int tap_fd_enable(int fd)
-{
-    return -1;
-}
-
-int tap_fd_disable(int fd)
-{
-    return -1;
-}
-
-int tap_fd_get_ifname(int fd, char *ifname)
-{
-    return -1;
-}
-
diff --git a/net/tap-haiku.c b/net/tap-haiku.c
deleted file mode 100644
index b27e57e..0000000
--- a/net/tap-haiku.c
+++ /dev/null
@@ -1,87 +0,0 @@
-/*
- * QEMU System Emulator
- *
- * Copyright (c) 2003-2008 Fabrice Bellard
- *
- * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
- * of this software and associated documentation files (the "Software"),=
 to deal
- * in the Software without restriction, including without limitation the=
 rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be includ=
ed in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
- * THE SOFTWARE.
- */
-
-#include "qemu/osdep.h"
-#include "qapi/error.h"
-#include "tap_int.h"
-
-int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
-             int vnet_hdr_required, int mq_required, Error **errp)
-{
-    error_setg(errp, "no tap on Haiku");
-    return -1;
-}
-
-void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
-{
-}
-
-int tap_probe_vnet_hdr(int fd)
-{
-    return 0;
-}
-
-int tap_probe_has_ufo(int fd)
-{
-    return 0;
-}
-
-int tap_probe_vnet_hdr_len(int fd, int len)
-{
-    return 0;
-}
-
-void tap_fd_set_vnet_hdr_len(int fd, int len)
-{
-}
-
-int tap_fd_set_vnet_le(int fd, int is_le)
-{
-    return -EINVAL;
-}
-
-int tap_fd_set_vnet_be(int fd, int is_be)
-{
-    return -EINVAL;
-}
-
-void tap_fd_set_offload(int fd, int csum, int tso4,
-                        int tso6, int ecn, int ufo)
-{
-}
-
-int tap_fd_enable(int fd)
-{
-    return -1;
-}
-
-int tap_fd_disable(int fd)
-{
-    return -1;
-}
-
-int tap_fd_get_ifname(int fd, char *ifname)
-{
-    return -1;
-}
diff --git a/net/tap-stub.c b/net/tap-stub.c
new file mode 100644
index 0000000..a9ab8f8
--- /dev/null
+++ b/net/tap-stub.c
@@ -0,0 +1,87 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "tap_int.h"
+
+int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
+             int vnet_hdr_required, int mq_required, Error **errp)
+{
+    error_setg(errp, "tap is not supported in this build");
+    return -1;
+}
+
+void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
+{
+}
+
+int tap_probe_vnet_hdr(int fd)
+{
+    return 0;
+}
+
+int tap_probe_has_ufo(int fd)
+{
+    return 0;
+}
+
+int tap_probe_vnet_hdr_len(int fd, int len)
+{
+    return 0;
+}
+
+void tap_fd_set_vnet_hdr_len(int fd, int len)
+{
+}
+
+int tap_fd_set_vnet_le(int fd, int is_le)
+{
+    return -EINVAL;
+}
+
+int tap_fd_set_vnet_be(int fd, int is_be)
+{
+    return -EINVAL;
+}
+
+void tap_fd_set_offload(int fd, int csum, int tso4,
+                        int tso6, int ecn, int ufo)
+{
+}
+
+int tap_fd_enable(int fd)
+{
+    return -1;
+}
+
+int tap_fd_disable(int fd)
+{
+    return -1;
+}
+
+int tap_fd_get_ifname(int fd, char *ifname)
+{
+    return -1;
+}
--=20
2.7.4
