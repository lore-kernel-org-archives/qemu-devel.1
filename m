Received: from eggs.gnu.org ([2001:4830:134:3::10]:56894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fuDHB-0005XX-92
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 04:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fuDH9-0004n6-Fa
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 04:53:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58064 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fuDH9-0004mx-9X
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 04:53:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EAE27807689D
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 08:53:30 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 27 Aug 2018 10:53:20 +0200
Message-Id: <20180827085320.9732-13-kraxel@redhat.com>
In-Reply-To: <20180827085320.9732-1-kraxel@redhat.com>
References: <20180827085320.9732-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/12] util: promote qemu_egl_rendernode_open()
 to libqemuutil
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

vhost-user-gpu will share the same code to open a DRM node.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180713130916.4153-20-marcandre.lureau@redhat.com>

[ kraxel: buildfix: util/drm.o must be CONFIG_OPENGL not CONFIG_LINUX ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/qemu/drm.h |  6 +++++
 ui/egl-helpers.c   | 51 ++---------------------------------------
 util/drm.c         | 66 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 MAINTAINERS        |  1 +
 util/Makefile.objs |  1 +
 5 files changed, 76 insertions(+), 49 deletions(-)
 create mode 100644 include/qemu/drm.h
 create mode 100644 util/drm.c

diff --git a/include/qemu/drm.h b/include/qemu/drm.h
new file mode 100644
index 0000000000..4c3e622f5c
--- /dev/null
+++ b/include/qemu/drm.h
@@ -0,0 +1,6 @@
+#ifndef QEMU_DRM_H_
+#define QEMU_DRM_H_
+
+int qemu_drm_rendernode_open(const char *rendernode);
+
+#endif
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 71b6a97bd1..4f475142fc 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -15,9 +15,7 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
 #include "qemu/osdep.h"
-#include <glob.h>
-#include <dirent.h>
-
+#include "qemu/drm.h"
 #include "qemu/error-report.h"
 #include "ui/console.h"
 #include "ui/egl-helpers.h"
@@ -147,57 +145,12 @@ int qemu_egl_rn_fd;
 struct gbm_device *qemu_egl_rn_gbm_dev;
 EGLContext qemu_egl_rn_ctx;
=20
-static int qemu_egl_rendernode_open(const char *rendernode)
-{
-    DIR *dir;
-    struct dirent *e;
-    int r, fd;
-    char *p;
-
-    if (rendernode) {
-        return open(rendernode, O_RDWR | O_CLOEXEC | O_NOCTTY | O_NONBLO=
CK);
-    }
-
-    dir =3D opendir("/dev/dri");
-    if (!dir) {
-        return -1;
-    }
-
-    fd =3D -1;
-    while ((e =3D readdir(dir))) {
-        if (e->d_type !=3D DT_CHR) {
-            continue;
-        }
-
-        if (strncmp(e->d_name, "renderD", 7)) {
-            continue;
-        }
-
-        p =3D g_strdup_printf("/dev/dri/%s", e->d_name);
-
-        r =3D open(p, O_RDWR | O_CLOEXEC | O_NOCTTY | O_NONBLOCK);
-        if (r < 0) {
-            g_free(p);
-            continue;
-        }
-        fd =3D r;
-        g_free(p);
-        break;
-    }
-
-    closedir(dir);
-    if (fd < 0) {
-        return -1;
-    }
-    return fd;
-}
-
 int egl_rendernode_init(const char *rendernode, DisplayGLMode mode)
 {
     qemu_egl_rn_fd =3D -1;
     int rc;
=20
-    qemu_egl_rn_fd =3D qemu_egl_rendernode_open(rendernode);
+    qemu_egl_rn_fd =3D qemu_drm_rendernode_open(rendernode);
     if (qemu_egl_rn_fd =3D=3D -1) {
         error_report("egl: no drm render node available");
         goto err;
diff --git a/util/drm.c b/util/drm.c
new file mode 100644
index 0000000000..a23ff24538
--- /dev/null
+++ b/util/drm.c
@@ -0,0 +1,66 @@
+/*
+ * Copyright (C) 2015-2016 Gerd Hoffmann <kraxel@redhat.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
+ */
+#include "qemu/osdep.h"
+#include "qemu/drm.h"
+
+#include <glob.h>
+#include <dirent.h>
+
+int qemu_drm_rendernode_open(const char *rendernode)
+{
+    DIR *dir;
+    struct dirent *e;
+    int r, fd;
+    char *p;
+
+    if (rendernode) {
+        return open(rendernode, O_RDWR | O_CLOEXEC | O_NOCTTY | O_NONBLO=
CK);
+    }
+
+    dir =3D opendir("/dev/dri");
+    if (!dir) {
+        return -1;
+    }
+
+    fd =3D -1;
+    while ((e =3D readdir(dir))) {
+        if (e->d_type !=3D DT_CHR) {
+            continue;
+        }
+
+        if (strncmp(e->d_name, "renderD", 7)) {
+            continue;
+        }
+
+        p =3D g_strdup_printf("/dev/dri/%s", e->d_name);
+
+        r =3D open(p, O_RDWR | O_CLOEXEC | O_NOCTTY | O_NONBLOCK);
+        if (r < 0) {
+            g_free(p);
+            continue;
+        }
+        fd =3D r;
+        g_free(p);
+        break;
+    }
+
+    closedir(dir);
+    if (fd < 0) {
+        return -1;
+    }
+    return fd;
+}
diff --git a/MAINTAINERS b/MAINTAINERS
index 6902a568f4..282d6a8ae5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1566,6 +1566,7 @@ S: Odd Fixes
 F: ui/
 F: include/ui/
 F: qapi/ui.json
+F: util/drm.c
=20
 Cocoa graphics
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/util/Makefile.objs b/util/Makefile.objs
index e1c3fed4dc..4726d262d8 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -49,3 +49,4 @@ util-obj-y +=3D stats64.o
 util-obj-y +=3D systemd.o
 util-obj-y +=3D iova-tree.o
 util-obj-$(CONFIG_LINUX) +=3D vfio-helpers.o
+util-obj-$(CONFIG_OPENGL) +=3D drm.o
--=20
2.9.3
