Received: from eggs.gnu.org ([2001:4830:134:3::10]:39257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fRKtT-000787-Li
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fRKtQ-0008Iy-Lx
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:09:43 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri,  8 Jun 2018 18:09:26 +0100
Message-Id: <20180608170933.9137-2-berrange@redhat.com>
In-Reply-To: <20180608170933.9137-1-berrange@redhat.com>
References: <20180608170933.9137-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/8] util: add helper APIs for dealing with
 inotify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-trivial@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>

The inotify userspace API for reading events is quite horrible, so it is
useful to wrap it in a more friendly API to avoid duplicating code
across many users in QEMU.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 MAINTAINERS            |   6 ++
 include/qemu/inotify.h |  49 +++++++++++++++
 util/Makefile.objs     |   1 +
 util/inotify.c         | 138 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 194 insertions(+)
 create mode 100644 include/qemu/inotify.h
 create mode 100644 util/inotify.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 41cd3736a9..3610479af7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1766,6 +1766,12 @@ F: include/qemu/sockets.h
 F: util/qemu-sockets.c
 F: qapi/sockets.json
=20
+Inotify
+M: Daniel P. Berrange <berrange@redhat.com>
+S: Odd fixes
+F: util/inotify.c
+F: include/qemu/inotify.h
+
 Throttling infrastructure
 M: Alberto Garcia <berto@igalia.com>
 S: Supported
diff --git a/include/qemu/inotify.h b/include/qemu/inotify.h
new file mode 100644
index 0000000000..d78d04c5bb
--- /dev/null
+++ b/include/qemu/inotify.h
@@ -0,0 +1,49 @@
+/*
+ * QEMU inotify helper
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
+ *
+ */
+
+#ifndef QEMU_INOTIFY_H
+#define QEMU_INOTIFY_H
+
+#include "qemu-common.h"
+#ifdef CONFIG_INOTIFY1
+#include <sys/inotify.h>
+#endif
+
+
+typedef struct QInotify QInotify;
+
+typedef void (*QInotifyHandler)(int wd,
+                                   uint32_t mask,
+                                   const char *name,
+                                   void *opaque);
+
+QInotify *qemu_inotify_new(QInotifyHandler cb,
+                           void *opaque,
+                           GDestroyNotify ffcb,
+                           Error **errp);
+
+void qemu_inotify_free(QInotify *in);
+
+int qemu_inotify_add_watch(QInotify *in,
+                           const char *path,
+                           uint32_t mask,
+                           Error **errp);
+
+#endif /* QEMU_INOTIFY_H */
diff --git a/util/Makefile.objs b/util/Makefile.objs
index e1c3fed4dc..4c1b44d019 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -48,4 +48,5 @@ util-obj-y +=3D range.o
 util-obj-y +=3D stats64.o
 util-obj-y +=3D systemd.o
 util-obj-y +=3D iova-tree.o
+util-obj-y +=3D inotify.o
 util-obj-$(CONFIG_LINUX) +=3D vfio-helpers.o
diff --git a/util/inotify.c b/util/inotify.c
new file mode 100644
index 0000000000..dd9c194bea
--- /dev/null
+++ b/util/inotify.c
@@ -0,0 +1,138 @@
+/*
+ * QEMU inotify helper
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/inotify.h"
+#include "qemu/main-loop.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+
+struct QInotify {
+    int fd;
+    QInotifyHandler cb;
+    void *opaque;
+    GDestroyNotify ffcb;
+};
+
+#ifdef CONFIG_INOTIFY1
+static void qemu_inotify_watch(void *arg)
+{
+    QInotify *in =3D arg;
+    char buf[4096]
+        __attribute__ ((aligned(__alignof__(struct inotify_event))));
+    int used =3D 0;
+    int len =3D read(in->fd, buf, sizeof(buf));
+
+    if (len < 0) {
+        if (errno !=3D EAGAIN) {
+            error_report("Failure monitoring inotify FD, disabling event=
s");
+            goto error;
+        }
+
+        /* no more events right now */
+        return;
+    }
+
+    /* Loop over all events in the buffer */
+    while (used < len) {
+        struct inotify_event *ev =3D
+            (struct inotify_event *)buf + used;
+
+        in->cb(ev->wd, ev->mask, ev->name, in->opaque);
+
+        used +=3D sizeof(struct inotify_event) + ev->len;
+    }
+
+    return;
+
+ error:
+    qemu_set_fd_handler(in->fd, NULL, NULL, NULL);
+    close(in->fd);
+    in->fd =3D -1;
+}
+#endif
+
+QInotify *qemu_inotify_new(QInotifyHandler cb,
+                           void *opaque,
+                           GDestroyNotify ffcb,
+                           Error **errp)
+{
+#ifdef CONFIG_INOTIFY1
+    QInotify *in =3D g_new0(QInotify, 1);
+
+    in->fd =3D inotify_init1(IN_NONBLOCK);
+    if (in->fd =3D=3D -1) {
+        error_setg_errno(errp, errno,
+                         "Unable to initialize inotify");
+        g_free(in);
+        return NULL;
+    }
+    in->cb =3D cb;
+    in->opaque =3D opaque;
+    in->ffcb =3D ffcb;
+
+    qemu_set_fd_handler(in->fd, qemu_inotify_watch, NULL, in);
+
+    return in;
+#else
+    error_setg(errp, "Inotify not available on this platform");
+    return NULL;
+#endif
+
+}
+
+
+void qemu_inotify_free(QInotify *in)
+{
+    if (!in) {
+        return;
+    }
+
+    if (in->ffcb) {
+        in->ffcb(in->opaque);
+    }
+
+    if (in->fd !=3D -1) {
+        qemu_set_fd_handler(in->fd, NULL, NULL, NULL);
+        close(in->fd);
+        g_free(in);
+    }
+}
+
+
+int qemu_inotify_add_watch(QInotify *in,
+                           const char *path,
+                           uint32_t mask,
+                           Error **errp)
+{
+#ifdef CONFIG_INOTIFY1
+    int rv;
+    rv =3D inotify_add_watch(in->fd, path, mask);
+    if (rv < 0) {
+        error_setg_errno(errp, errno, "Unable to watch '%s'", path);
+        return -1;
+    }
+
+    return rv;
+#else
+    error_setg(errp, "Inotify not available on this platform");
+    return -1;
+#endif
+}
--=20
2.17.0
