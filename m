Received: from eggs.gnu.org ([2001:4830:134:3::10]:46531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbE6-0001xr-J5
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:24:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbE0-0001RI-UG
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:24:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYbE0-0001R1-Ks
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:24:08 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Jan 2017 20:21:21 +0400
Message-Id: <20170131162122.29408-41-marcandre.lureau@redhat.com>
In-Reply-To: <20170131162122.29408-1-marcandre.lureau@redhat.com>
References: <20170131162122.29408-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 40/41] char: move parallel chardev in its own
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Eric Blake <eblake@redhat.com>
---
 chardev/char-parallel.h |  32 +++++
 chardev/char-parallel.c | 316 ++++++++++++++++++++++++++++++++++++++++++=
++++++
 chardev/char.c          | 287 +-----------------------------------------=
-
 chardev/Makefile.objs   |   1 +
 4 files changed, 350 insertions(+), 286 deletions(-)
 create mode 100644 chardev/char-parallel.h
 create mode 100644 chardev/char-parallel.c

diff --git a/chardev/char-parallel.h b/chardev/char-parallel.h
new file mode 100644
index 0000000000..26742f9d5c
--- /dev/null
+++ b/chardev/char-parallel.h
@@ -0,0 +1,32 @@
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
+#ifndef CHAR_PARALLEL_H
+#define CHAR_PARALLEL_H
+
+#if defined(__linux__) || defined(__FreeBSD__) || \
+    defined(__FreeBSD_kernel__) || defined(__DragonFly__)
+#define HAVE_CHARDEV_PARPORT 1
+#endif
+
+#endif /* CHAR_PARALLEL_H */
diff --git a/chardev/char-parallel.c b/chardev/char-parallel.c
new file mode 100644
index 0000000000..3fa22ce29d
--- /dev/null
+++ b/chardev/char-parallel.c
@@ -0,0 +1,316 @@
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
+#include "qemu/osdep.h"
+#include "sysemu/char.h"
+#include "qapi/error.h"
+#include <sys/ioctl.h>
+
+#ifdef CONFIG_BSD
+#if defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
+#include <dev/ppbus/ppi.h>
+#include <dev/ppbus/ppbconf.h>
+#elif defined(__DragonFly__)
+#include <dev/misc/ppi/ppi.h>
+#include <bus/ppbus/ppbconf.h>
+#endif
+#else
+#ifdef __linux__
+#include <linux/ppdev.h>
+#include <linux/parport.h>
+#endif
+#endif
+
+#include "char-fd.h"
+#include "char-parallel.h"
+
+#if defined(__linux__)
+
+typedef struct {
+    Chardev parent;
+    int fd;
+    int mode;
+} ParallelChardev;
+
+#define PARALLEL_CHARDEV(obj) \
+    OBJECT_CHECK(ParallelChardev, (obj), TYPE_CHARDEV_PARALLEL)
+
+static int pp_hw_mode(ParallelChardev *s, uint16_t mode)
+{
+    if (s->mode !=3D mode) {
+        int m =3D mode;
+        if (ioctl(s->fd, PPSETMODE, &m) < 0) {
+            return 0;
+        }
+        s->mode =3D mode;
+    }
+    return 1;
+}
+
+static int pp_ioctl(Chardev *chr, int cmd, void *arg)
+{
+    ParallelChardev *drv =3D PARALLEL_CHARDEV(chr);
+    int fd =3D drv->fd;
+    uint8_t b;
+
+    switch (cmd) {
+    case CHR_IOCTL_PP_READ_DATA:
+        if (ioctl(fd, PPRDATA, &b) < 0) {
+            return -ENOTSUP;
+        }
+        *(uint8_t *)arg =3D b;
+        break;
+    case CHR_IOCTL_PP_WRITE_DATA:
+        b =3D *(uint8_t *)arg;
+        if (ioctl(fd, PPWDATA, &b) < 0) {
+            return -ENOTSUP;
+        }
+        break;
+    case CHR_IOCTL_PP_READ_CONTROL:
+        if (ioctl(fd, PPRCONTROL, &b) < 0) {
+            return -ENOTSUP;
+        }
+        /* Linux gives only the lowest bits, and no way to know data
+           direction! For better compatibility set the fixed upper
+           bits. */
+        *(uint8_t *)arg =3D b | 0xc0;
+        break;
+    case CHR_IOCTL_PP_WRITE_CONTROL:
+        b =3D *(uint8_t *)arg;
+        if (ioctl(fd, PPWCONTROL, &b) < 0) {
+            return -ENOTSUP;
+        }
+        break;
+    case CHR_IOCTL_PP_READ_STATUS:
+        if (ioctl(fd, PPRSTATUS, &b) < 0) {
+            return -ENOTSUP;
+        }
+        *(uint8_t *)arg =3D b;
+        break;
+    case CHR_IOCTL_PP_DATA_DIR:
+        if (ioctl(fd, PPDATADIR, (int *)arg) < 0) {
+            return -ENOTSUP;
+        }
+        break;
+    case CHR_IOCTL_PP_EPP_READ_ADDR:
+        if (pp_hw_mode(drv, IEEE1284_MODE_EPP | IEEE1284_ADDR)) {
+            struct ParallelIOArg *parg =3D arg;
+            int n =3D read(fd, parg->buffer, parg->count);
+            if (n !=3D parg->count) {
+                return -EIO;
+            }
+        }
+        break;
+    case CHR_IOCTL_PP_EPP_READ:
+        if (pp_hw_mode(drv, IEEE1284_MODE_EPP)) {
+            struct ParallelIOArg *parg =3D arg;
+            int n =3D read(fd, parg->buffer, parg->count);
+            if (n !=3D parg->count) {
+                return -EIO;
+            }
+        }
+        break;
+    case CHR_IOCTL_PP_EPP_WRITE_ADDR:
+        if (pp_hw_mode(drv, IEEE1284_MODE_EPP | IEEE1284_ADDR)) {
+            struct ParallelIOArg *parg =3D arg;
+            int n =3D write(fd, parg->buffer, parg->count);
+            if (n !=3D parg->count) {
+                return -EIO;
+            }
+        }
+        break;
+    case CHR_IOCTL_PP_EPP_WRITE:
+        if (pp_hw_mode(drv, IEEE1284_MODE_EPP)) {
+            struct ParallelIOArg *parg =3D arg;
+            int n =3D write(fd, parg->buffer, parg->count);
+            if (n !=3D parg->count) {
+                return -EIO;
+            }
+        }
+        break;
+    default:
+        return -ENOTSUP;
+    }
+    return 0;
+}
+
+static void qemu_chr_open_pp_fd(Chardev *chr,
+                                int fd,
+                                bool *be_opened,
+                                Error **errp)
+{
+    ParallelChardev *drv =3D PARALLEL_CHARDEV(chr);
+
+    if (ioctl(fd, PPCLAIM) < 0) {
+        error_setg_errno(errp, errno, "not a parallel port");
+        close(fd);
+        return;
+    }
+
+    drv->fd =3D fd;
+    drv->mode =3D IEEE1284_MODE_COMPAT;
+}
+#endif /* __linux__ */
+
+#if defined(__FreeBSD__) || defined(__FreeBSD_kernel__) || defined(__Dra=
gonFly__)
+
+typedef struct {
+    Chardev parent;
+    int fd;
+} ParallelChardev;
+
+#define PARALLEL_CHARDEV(obj)                                   \
+    OBJECT_CHECK(ParallelChardev, (obj), TYPE_CHARDEV_PARALLEL)
+
+static int pp_ioctl(Chardev *chr, int cmd, void *arg)
+{
+    ParallelChardev *drv =3D PARALLEL_CHARDEV(chr);
+    uint8_t b;
+
+    switch (cmd) {
+    case CHR_IOCTL_PP_READ_DATA:
+        if (ioctl(drv->fd, PPIGDATA, &b) < 0) {
+            return -ENOTSUP;
+        }
+        *(uint8_t *)arg =3D b;
+        break;
+    case CHR_IOCTL_PP_WRITE_DATA:
+        b =3D *(uint8_t *)arg;
+        if (ioctl(drv->fd, PPISDATA, &b) < 0) {
+            return -ENOTSUP;
+        }
+        break;
+    case CHR_IOCTL_PP_READ_CONTROL:
+        if (ioctl(drv->fd, PPIGCTRL, &b) < 0) {
+            return -ENOTSUP;
+        }
+        *(uint8_t *)arg =3D b;
+        break;
+    case CHR_IOCTL_PP_WRITE_CONTROL:
+        b =3D *(uint8_t *)arg;
+        if (ioctl(drv->fd, PPISCTRL, &b) < 0) {
+            return -ENOTSUP;
+        }
+        break;
+    case CHR_IOCTL_PP_READ_STATUS:
+        if (ioctl(drv->fd, PPIGSTATUS, &b) < 0) {
+            return -ENOTSUP;
+        }
+        *(uint8_t *)arg =3D b;
+        break;
+    default:
+        return -ENOTSUP;
+    }
+    return 0;
+}
+
+static void qemu_chr_open_pp_fd(Chardev *chr,
+                                int fd,
+                                bool *be_opened,
+                                Error **errp)
+{
+    ParallelChardev *drv =3D PARALLEL_CHARDEV(chr);
+    drv->fd =3D fd;
+    *be_opened =3D false;
+}
+#endif
+
+#ifdef HAVE_CHARDEV_PARPORT
+static void qmp_chardev_open_parallel(Chardev *chr,
+                                      ChardevBackend *backend,
+                                      bool *be_opened,
+                                      Error **errp)
+{
+    ChardevHostdev *parallel =3D backend->u.parallel.data;
+    int fd;
+
+    fd =3D qmp_chardev_open_file_source(parallel->device, O_RDWR, errp);
+    if (fd < 0) {
+        return;
+    }
+    qemu_chr_open_pp_fd(chr, fd, be_opened, errp);
+}
+
+static void qemu_chr_parse_parallel(QemuOpts *opts, ChardevBackend *back=
end,
+                                    Error **errp)
+{
+    const char *device =3D qemu_opt_get(opts, "path");
+    ChardevHostdev *parallel;
+
+    if (device =3D=3D NULL) {
+        error_setg(errp, "chardev: parallel: no device path given");
+        return;
+    }
+    backend->type =3D CHARDEV_BACKEND_KIND_PARALLEL;
+    parallel =3D backend->u.parallel.data =3D g_new0(ChardevHostdev, 1);
+    qemu_chr_parse_common(opts, qapi_ChardevHostdev_base(parallel));
+    parallel->device =3D g_strdup(device);
+}
+
+static void char_parallel_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->parse =3D qemu_chr_parse_parallel;
+    cc->open =3D qmp_chardev_open_parallel;
+#if defined(__linux__)
+    cc->chr_ioctl =3D pp_ioctl;
+#elif defined(__FreeBSD__) || defined(__FreeBSD_kernel__) || \
+    defined(__DragonFly__)
+    cc->chr_ioctl =3D pp_ioctl;
+#endif
+}
+
+static void char_parallel_finalize(Object *obj)
+{
+#if defined(__linux__)
+    Chardev *chr =3D CHARDEV(obj);
+    ParallelChardev *drv =3D PARALLEL_CHARDEV(chr);
+    int fd =3D drv->fd;
+
+    pp_hw_mode(drv, IEEE1284_MODE_COMPAT);
+    ioctl(fd, PPRELEASE);
+    close(fd);
+    qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
+#elif defined(__FreeBSD__) || defined(__FreeBSD_kernel__) || \
+    defined(__DragonFly__)
+    /* FIXME: close fd? */
+#endif
+}
+
+static const TypeInfo char_parallel_type_info =3D {
+    .name =3D TYPE_CHARDEV_PARALLEL,
+    .parent =3D TYPE_CHARDEV,
+    .instance_size =3D sizeof(ParallelChardev),
+    .instance_finalize =3D char_parallel_finalize,
+    .class_init =3D char_parallel_class_init,
+};
+
+static void register_types(void)
+{
+    type_register_static(&char_parallel_type_info);
+}
+
+type_init(register_types);
+
+#endif
diff --git a/chardev/char.c b/chardev/char.c
index faba68db21..a9daf9956c 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -53,19 +53,6 @@
 #include <arpa/inet.h>
 #include <netdb.h>
 #include <sys/select.h>
-#ifdef CONFIG_BSD
-#if defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
-#include <dev/ppbus/ppi.h>
-#include <dev/ppbus/ppbconf.h>
-#elif defined(__DragonFly__)
-#include <dev/misc/ppi/ppi.h>
-#include <bus/ppbus/ppbconf.h>
-#endif
-#else
-#ifdef __linux__
-#include <linux/ppdev.h>
-#include <linux/parport.h>
-#endif
 #ifdef __sun__
 #include <sys/ethernet.h>
 #include <sys/sockio.h>
@@ -78,17 +65,16 @@
 #include <netinet/tcp.h>
 #endif
 #endif
-#endif
=20
 #include "qemu/sockets.h"
 #include "ui/qemu-spice.h"
=20
 #include "char-mux.h"
-#include "char-fd.h"
 #include "char-io.h"
 #ifdef _WIN32
 #include "char-win.h"
 #endif
+#include "char-parallel.h"
 #include "char-serial.h"
=20
 /***********************************************************/
@@ -653,198 +639,6 @@ void qemu_chr_fe_take_focus(CharBackend *b)
     }
 }
=20
-#ifndef _WIN32
-
-#if defined(__linux__)
-
-#define HAVE_CHARDEV_PARPORT 1
-
-typedef struct {
-    Chardev parent;
-    int fd;
-    int mode;
-} ParallelChardev;
-
-#define PARALLEL_CHARDEV(obj) \
-    OBJECT_CHECK(ParallelChardev, (obj), TYPE_CHARDEV_PARALLEL)
-
-static int pp_hw_mode(ParallelChardev *s, uint16_t mode)
-{
-    if (s->mode !=3D mode) {
-	int m =3D mode;
-        if (ioctl(s->fd, PPSETMODE, &m) < 0)
-            return 0;
-	s->mode =3D mode;
-    }
-    return 1;
-}
-
-static int pp_ioctl(Chardev *chr, int cmd, void *arg)
-{
-    ParallelChardev *drv =3D PARALLEL_CHARDEV(chr);
-    int fd =3D drv->fd;
-    uint8_t b;
-
-    switch(cmd) {
-    case CHR_IOCTL_PP_READ_DATA:
-        if (ioctl(fd, PPRDATA, &b) < 0)
-            return -ENOTSUP;
-        *(uint8_t *)arg =3D b;
-        break;
-    case CHR_IOCTL_PP_WRITE_DATA:
-        b =3D *(uint8_t *)arg;
-        if (ioctl(fd, PPWDATA, &b) < 0)
-            return -ENOTSUP;
-        break;
-    case CHR_IOCTL_PP_READ_CONTROL:
-        if (ioctl(fd, PPRCONTROL, &b) < 0)
-            return -ENOTSUP;
-	/* Linux gives only the lowest bits, and no way to know data
-	   direction! For better compatibility set the fixed upper
-	   bits. */
-        *(uint8_t *)arg =3D b | 0xc0;
-        break;
-    case CHR_IOCTL_PP_WRITE_CONTROL:
-        b =3D *(uint8_t *)arg;
-        if (ioctl(fd, PPWCONTROL, &b) < 0)
-            return -ENOTSUP;
-        break;
-    case CHR_IOCTL_PP_READ_STATUS:
-        if (ioctl(fd, PPRSTATUS, &b) < 0)
-            return -ENOTSUP;
-        *(uint8_t *)arg =3D b;
-        break;
-    case CHR_IOCTL_PP_DATA_DIR:
-        if (ioctl(fd, PPDATADIR, (int *)arg) < 0)
-            return -ENOTSUP;
-        break;
-    case CHR_IOCTL_PP_EPP_READ_ADDR:
-	if (pp_hw_mode(drv, IEEE1284_MODE_EPP|IEEE1284_ADDR)) {
-	    struct ParallelIOArg *parg =3D arg;
-	    int n =3D read(fd, parg->buffer, parg->count);
-	    if (n !=3D parg->count) {
-		return -EIO;
-	    }
-	}
-        break;
-    case CHR_IOCTL_PP_EPP_READ:
-	if (pp_hw_mode(drv, IEEE1284_MODE_EPP)) {
-	    struct ParallelIOArg *parg =3D arg;
-	    int n =3D read(fd, parg->buffer, parg->count);
-	    if (n !=3D parg->count) {
-		return -EIO;
-	    }
-	}
-        break;
-    case CHR_IOCTL_PP_EPP_WRITE_ADDR:
-	if (pp_hw_mode(drv, IEEE1284_MODE_EPP|IEEE1284_ADDR)) {
-	    struct ParallelIOArg *parg =3D arg;
-	    int n =3D write(fd, parg->buffer, parg->count);
-	    if (n !=3D parg->count) {
-		return -EIO;
-	    }
-	}
-        break;
-    case CHR_IOCTL_PP_EPP_WRITE:
-	if (pp_hw_mode(drv, IEEE1284_MODE_EPP)) {
-	    struct ParallelIOArg *parg =3D arg;
-	    int n =3D write(fd, parg->buffer, parg->count);
-	    if (n !=3D parg->count) {
-		return -EIO;
-	    }
-	}
-        break;
-    default:
-        return -ENOTSUP;
-    }
-    return 0;
-}
-
-static void qemu_chr_open_pp_fd(Chardev *chr,
-                                int fd,
-                                bool *be_opened,
-                                Error **errp)
-{
-    ParallelChardev *drv =3D PARALLEL_CHARDEV(chr);
-
-    if (ioctl(fd, PPCLAIM) < 0) {
-        error_setg_errno(errp, errno, "not a parallel port");
-        close(fd);
-        return;
-    }
-
-    drv->fd =3D fd;
-    drv->mode =3D IEEE1284_MODE_COMPAT;
-}
-#endif /* __linux__ */
-
-#if defined(__FreeBSD__) || defined(__FreeBSD_kernel__) || defined(__Dra=
gonFly__)
-
-#define HAVE_CHARDEV_PARPORT 1
-
-typedef struct {
-    Chardev parent;
-    int fd;
-} ParallelChardev;
-
-#define PARALLEL_CHARDEV(obj)                                   \
-    OBJECT_CHECK(ParallelChardev, (obj), TYPE_CHARDEV_PARALLEL)
-
-static int pp_ioctl(Chardev *chr, int cmd, void *arg)
-{
-    ParallelChardev *drv =3D PARALLEL_CHARDEV(chr);
-    uint8_t b;
-
-    switch (cmd) {
-    case CHR_IOCTL_PP_READ_DATA:
-        if (ioctl(drv->fd, PPIGDATA, &b) < 0) {
-            return -ENOTSUP;
-        }
-        *(uint8_t *)arg =3D b;
-        break;
-    case CHR_IOCTL_PP_WRITE_DATA:
-        b =3D *(uint8_t *)arg;
-        if (ioctl(drv->fd, PPISDATA, &b) < 0) {
-            return -ENOTSUP;
-        }
-        break;
-    case CHR_IOCTL_PP_READ_CONTROL:
-        if (ioctl(drv->fd, PPIGCTRL, &b) < 0) {
-            return -ENOTSUP;
-        }
-        *(uint8_t *)arg =3D b;
-        break;
-    case CHR_IOCTL_PP_WRITE_CONTROL:
-        b =3D *(uint8_t *)arg;
-        if (ioctl(drv->fd, PPISCTRL, &b) < 0) {
-            return -ENOTSUP;
-        }
-        break;
-    case CHR_IOCTL_PP_READ_STATUS:
-        if (ioctl(drv->fd, PPIGSTATUS, &b) < 0) {
-            return -ENOTSUP;
-        }
-        *(uint8_t *)arg =3D b;
-        break;
-    default:
-        return -ENOTSUP;
-    }
-    return 0;
-}
-
-static void qemu_chr_open_pp_fd(Chardev *chr,
-                                int fd,
-                                bool *be_opened,
-                                Error **errp)
-{
-    ParallelChardev *drv =3D PARALLEL_CHARDEV(chr);
-    drv->fd =3D fd;
-    *be_opened =3D false;
-}
-#endif
-
-#endif /* !_WIN32 */
-
 int qemu_chr_wait_connected(Chardev *chr, Error **errp)
 {
     ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
@@ -1019,24 +813,6 @@ void qemu_chr_parse_common(QemuOpts *opts, ChardevC=
ommon *backend)
     backend->logappend =3D qemu_opt_get_bool(opts, "logappend", false);
 }
=20
-#ifdef HAVE_CHARDEV_PARPORT
-static void qemu_chr_parse_parallel(QemuOpts *opts, ChardevBackend *back=
end,
-                                    Error **errp)
-{
-    const char *device =3D qemu_opt_get(opts, "path");
-    ChardevHostdev *parallel;
-
-    backend->type =3D CHARDEV_BACKEND_KIND_PARALLEL;
-    if (device =3D=3D NULL) {
-        error_setg(errp, "chardev: parallel: no device path given");
-        return;
-    }
-    parallel =3D backend->u.parallel.data =3D g_new0(ChardevHostdev, 1);
-    qemu_chr_parse_common(opts, qapi_ChardevHostdev_base(parallel));
-    parallel->device =3D g_strdup(device);
-}
-#endif
-
 static const ChardevClass *char_get_class(const char *driver, Error **er=
rp)
 {
     ObjectClass *oc;
@@ -1484,64 +1260,6 @@ QemuOptsList qemu_chardev_opts =3D {
     },
 };
=20
-#ifndef _WIN32
-
-#ifdef HAVE_CHARDEV_PARPORT
-static void qmp_chardev_open_parallel(Chardev *chr,
-                                      ChardevBackend *backend,
-                                      bool *be_opened,
-                                      Error **errp)
-{
-    ChardevHostdev *parallel =3D backend->u.parallel.data;
-    int fd;
-
-    fd =3D qmp_chardev_open_file_source(parallel->device, O_RDWR, errp);
-    if (fd < 0) {
-        return;
-    }
-    qemu_chr_open_pp_fd(chr, fd, be_opened, errp);
-}
-
-static void char_parallel_class_init(ObjectClass *oc, void *data)
-{
-    ChardevClass *cc =3D CHARDEV_CLASS(oc);
-
-    cc->parse =3D qemu_chr_parse_parallel;
-    cc->open =3D qmp_chardev_open_parallel;
-#if defined(__linux__)
-    cc->chr_ioctl =3D pp_ioctl;
-#elif defined(__FreeBSD__) || defined(__FreeBSD_kernel__) || defined(__D=
ragonFly__)
-    cc->chr_ioctl =3D pp_ioctl;
-#endif
-}
-
-static void char_parallel_finalize(Object *obj)
-{
-#if defined(__linux__)
-    Chardev *chr =3D CHARDEV(obj);
-    ParallelChardev *drv =3D PARALLEL_CHARDEV(chr);
-    int fd =3D drv->fd;
-
-    pp_hw_mode(drv, IEEE1284_MODE_COMPAT);
-    ioctl(fd, PPRELEASE);
-    close(fd);
-    qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
-#elif defined(__FreeBSD__) || defined(__FreeBSD_kernel__) || defined(__D=
ragonFly__)
-    /* FIXME: close fd? */
-#endif
-}
-
-static const TypeInfo char_parallel_type_info =3D {
-    .name =3D TYPE_CHARDEV_PARALLEL,
-    .parent =3D TYPE_CHARDEV,
-    .instance_size =3D sizeof(ParallelChardev),
-    .instance_finalize =3D char_parallel_finalize,
-    .class_init =3D char_parallel_class_init,
-};
-#endif
-
-#endif /* WIN32 */
-
 bool qemu_chr_has_feature(Chardev *chr,
                           ChardevFeature feature)
 {
@@ -1643,9 +1361,6 @@ void qemu_chr_cleanup(void)
 static void register_types(void)
 {
     type_register_static(&char_type_info);
-#ifdef HAVE_CHARDEV_PARPORT
-    type_register_static(&char_parallel_type_info);
-#endif
=20
     /* this must be done after machine init, since we register FEs with =
muxes
      * as part of realize functions like serial_isa_realizefn when -nogr=
aphic
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index 45fc8af0c4..1feda0f0ed 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -5,6 +5,7 @@ chardev-obj-y +=3D char-file.o
 chardev-obj-y +=3D char-io.o
 chardev-obj-y +=3D char-mux.o
 chardev-obj-y +=3D char-null.o
+chardev-obj-$(CONFIG_POSIX) +=3D char-parallel.o
 chardev-obj-y +=3D char-pipe.o
 chardev-obj-$(CONFIG_POSIX) +=3D char-pty.o
 chardev-obj-y +=3D char-ringbuf.o
--=20
2.11.0.295.gd7dffce1c.dirty
