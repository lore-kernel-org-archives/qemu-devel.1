Received: from eggs.gnu.org ([2001:4830:134:3::10]:41087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRMjc-0001My-TA
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRMja-0006c4-PC
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cRMja-0006bX-H6
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:50 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B789B3A27C
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 17:30:50 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Jan 2017 18:29:54 +0100
Message-Id: <20170111172956.11255-39-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-1-marcandre.lureau@redhat.com>
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 38/40] char: move serial chardev to itw own file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-serial.h |  12 ++
 chardev/char-serial.c | 295 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 chardev/char.c        | 278 +-------------------------------------------=
---
 chardev/Makefile.objs |   1 +
 4 files changed, 310 insertions(+), 276 deletions(-)
 create mode 100644 chardev/char-serial.h
 create mode 100644 chardev/char-serial.c

diff --git a/chardev/char-serial.h b/chardev/char-serial.h
new file mode 100644
index 0000000000..404e3d0305
--- /dev/null
+++ b/chardev/char-serial.h
@@ -0,0 +1,12 @@
+#ifndef CHAR_SERIAL_H
+#define CHAR_SERIAL_H
+
+#ifdef _WIN32
+#define HAVE_CHARDEV_SERIAL 1
+#elif defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)    =
\
+    || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFl=
y__) \
+    || defined(__GLIBC__)
+#define HAVE_CHARDEV_SERIAL 1
+#endif
+
+#endif
diff --git a/chardev/char-serial.c b/chardev/char-serial.c
new file mode 100644
index 0000000000..c2c33bcf7e
--- /dev/null
+++ b/chardev/char-serial.c
@@ -0,0 +1,295 @@
+#include "qemu/osdep.h"
+#include "qemu/sockets.h"
+#include "io/channel-file.h"
+#include "qapi/error.h"
+
+#ifdef _WIN32
+#include "char-win.h"
+#else
+#include <sys/ioctl.h>
+#include <termios.h>
+#include "char-fd.h"
+#endif
+
+#include "char-serial.h"
+
+#ifdef _WIN32
+
+static void qmp_chardev_open_serial(Chardev *chr,
+                                    ChardevBackend *backend,
+                                    bool *be_opened,
+                                    Error **errp)
+{
+    ChardevHostdev *serial =3D backend->u.serial.data;
+
+    win_chr_init(chr, serial->device, errp);
+}
+
+#elif defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)    =
  \
+    || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFl=
y__) \
+    || defined(__GLIBC__)
+
+static void tty_serial_init(int fd, int speed,
+                            int parity, int data_bits, int stop_bits)
+{
+    struct termios tty;
+    speed_t spd;
+
+#if 0
+    printf("tty_serial_init: speed=3D%d parity=3D%c data=3D%d stop=3D%d\=
n",
+           speed, parity, data_bits, stop_bits);
+#endif
+    tcgetattr(fd, &tty);
+
+#define check_speed(val) if (speed <=3D val) { spd =3D B##val; break; }
+    speed =3D speed * 10 / 11;
+    do {
+        check_speed(50);
+        check_speed(75);
+        check_speed(110);
+        check_speed(134);
+        check_speed(150);
+        check_speed(200);
+        check_speed(300);
+        check_speed(600);
+        check_speed(1200);
+        check_speed(1800);
+        check_speed(2400);
+        check_speed(4800);
+        check_speed(9600);
+        check_speed(19200);
+        check_speed(38400);
+        /* Non-Posix values follow. They may be unsupported on some syst=
ems. */
+        check_speed(57600);
+        check_speed(115200);
+#ifdef B230400
+        check_speed(230400);
+#endif
+#ifdef B460800
+        check_speed(460800);
+#endif
+#ifdef B500000
+        check_speed(500000);
+#endif
+#ifdef B576000
+        check_speed(576000);
+#endif
+#ifdef B921600
+        check_speed(921600);
+#endif
+#ifdef B1000000
+        check_speed(1000000);
+#endif
+#ifdef B1152000
+        check_speed(1152000);
+#endif
+#ifdef B1500000
+        check_speed(1500000);
+#endif
+#ifdef B2000000
+        check_speed(2000000);
+#endif
+#ifdef B2500000
+        check_speed(2500000);
+#endif
+#ifdef B3000000
+        check_speed(3000000);
+#endif
+#ifdef B3500000
+        check_speed(3500000);
+#endif
+#ifdef B4000000
+        check_speed(4000000);
+#endif
+        spd =3D B115200;
+    } while (0);
+
+    cfsetispeed(&tty, spd);
+    cfsetospeed(&tty, spd);
+
+    tty.c_iflag &=3D ~(IGNBRK | BRKINT | PARMRK | ISTRIP
+                     | INLCR | IGNCR | ICRNL | IXON);
+    tty.c_oflag |=3D OPOST;
+    tty.c_lflag &=3D ~(ECHO | ECHONL | ICANON | IEXTEN | ISIG);
+    tty.c_cflag &=3D ~(CSIZE | PARENB | PARODD | CRTSCTS | CSTOPB);
+    switch (data_bits) {
+    default:
+    case 8:
+        tty.c_cflag |=3D CS8;
+        break;
+    case 7:
+        tty.c_cflag |=3D CS7;
+        break;
+    case 6:
+        tty.c_cflag |=3D CS6;
+        break;
+    case 5:
+        tty.c_cflag |=3D CS5;
+        break;
+    }
+    switch (parity) {
+    default:
+    case 'N':
+        break;
+    case 'E':
+        tty.c_cflag |=3D PARENB;
+        break;
+    case 'O':
+        tty.c_cflag |=3D PARENB | PARODD;
+        break;
+    }
+    if (stop_bits =3D=3D 2) {
+        tty.c_cflag |=3D CSTOPB;
+    }
+
+    tcsetattr(fd, TCSANOW, &tty);
+}
+
+static int tty_serial_ioctl(Chardev *chr, int cmd, void *arg)
+{
+    FDChardev *s =3D FD_CHARDEV(chr);
+    QIOChannelFile *fioc =3D QIO_CHANNEL_FILE(s->ioc_in);
+
+    switch (cmd) {
+    case CHR_IOCTL_SERIAL_SET_PARAMS:
+        {
+            QEMUSerialSetParams *ssp =3D arg;
+            tty_serial_init(fioc->fd,
+                            ssp->speed, ssp->parity,
+                            ssp->data_bits, ssp->stop_bits);
+        }
+        break;
+    case CHR_IOCTL_SERIAL_SET_BREAK:
+        {
+            int enable =3D *(int *)arg;
+            if (enable) {
+                tcsendbreak(fioc->fd, 1);
+            }
+        }
+        break;
+    case CHR_IOCTL_SERIAL_GET_TIOCM:
+        {
+            int sarg =3D 0;
+            int *targ =3D (int *)arg;
+            ioctl(fioc->fd, TIOCMGET, &sarg);
+            *targ =3D 0;
+            if (sarg & TIOCM_CTS) {
+                *targ |=3D CHR_TIOCM_CTS;
+            }
+            if (sarg & TIOCM_CAR) {
+                *targ |=3D CHR_TIOCM_CAR;
+            }
+            if (sarg & TIOCM_DSR) {
+                *targ |=3D CHR_TIOCM_DSR;
+            }
+            if (sarg & TIOCM_RI) {
+                *targ |=3D CHR_TIOCM_RI;
+            }
+            if (sarg & TIOCM_DTR) {
+                *targ |=3D CHR_TIOCM_DTR;
+            }
+            if (sarg & TIOCM_RTS) {
+                *targ |=3D CHR_TIOCM_RTS;
+            }
+        }
+        break;
+    case CHR_IOCTL_SERIAL_SET_TIOCM:
+        {
+            int sarg =3D *(int *)arg;
+            int targ =3D 0;
+            ioctl(fioc->fd, TIOCMGET, &targ);
+            targ &=3D ~(CHR_TIOCM_CTS | CHR_TIOCM_CAR | CHR_TIOCM_DSR
+                     | CHR_TIOCM_RI | CHR_TIOCM_DTR | CHR_TIOCM_RTS);
+            if (sarg & CHR_TIOCM_CTS) {
+                targ |=3D TIOCM_CTS;
+            }
+            if (sarg & CHR_TIOCM_CAR) {
+                targ |=3D TIOCM_CAR;
+            }
+            if (sarg & CHR_TIOCM_DSR) {
+                targ |=3D TIOCM_DSR;
+            }
+            if (sarg & CHR_TIOCM_RI) {
+                targ |=3D TIOCM_RI;
+            }
+            if (sarg & CHR_TIOCM_DTR) {
+                targ |=3D TIOCM_DTR;
+            }
+            if (sarg & CHR_TIOCM_RTS) {
+                targ |=3D TIOCM_RTS;
+            }
+            ioctl(fioc->fd, TIOCMSET, &targ);
+        }
+        break;
+    default:
+        return -ENOTSUP;
+    }
+    return 0;
+}
+
+static void qmp_chardev_open_serial(Chardev *chr,
+                                    ChardevBackend *backend,
+                                    bool *be_opened,
+                                    Error **errp)
+{
+    ChardevHostdev *serial =3D backend->u.serial.data;
+    int fd;
+
+    fd =3D qmp_chardev_open_file_source(serial->device, O_RDWR, errp);
+    if (fd < 0) {
+        return;
+    }
+    qemu_set_nonblock(fd);
+    tty_serial_init(fd, 115200, 'N', 8, 1);
+
+    qemu_chr_open_fd(chr, fd, fd);
+}
+#endif /* __linux__ || __sun__ */
+
+#ifdef HAVE_CHARDEV_SERIAL
+static void qemu_chr_parse_serial(QemuOpts *opts, ChardevBackend *backen=
d,
+                                  Error **errp)
+{
+    const char *device =3D qemu_opt_get(opts, "path");
+    ChardevHostdev *serial;
+
+    if (device =3D=3D NULL) {
+        error_setg(errp, "chardev: serial/tty: no device path given");
+        return;
+    }
+    backend->type =3D CHARDEV_BACKEND_KIND_SERIAL;
+    serial =3D backend->u.serial.data =3D g_new0(ChardevHostdev, 1);
+    qemu_chr_parse_common(opts, qapi_ChardevHostdev_base(serial));
+    serial->device =3D g_strdup(device);
+}
+
+static void char_serial_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->parse =3D qemu_chr_parse_serial;
+    cc->open =3D qmp_chardev_open_serial;
+#ifndef _WIN32
+    cc->chr_ioctl =3D tty_serial_ioctl;
+#endif
+}
+
+
+static const TypeInfo char_serial_type_info =3D {
+    .name =3D TYPE_CHARDEV_SERIAL,
+#ifdef _WIN32
+    .parent =3D TYPE_CHARDEV_WIN,
+#else
+    .parent =3D TYPE_CHARDEV_FD,
+#endif
+    .class_init =3D char_serial_class_init,
+};
+
+static void register_types(void)
+{
+    type_register_static(&char_serial_type_info);
+}
+
+type_init(register_types);
+
+#endif
diff --git a/chardev/char.c b/chardev/char.c
index ac29fcc841..ae0d422b84 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -36,7 +36,6 @@
 #include "qapi-visit.h"
 #include "qemu/base64.h"
 #include "io/channel-socket.h"
-#include "io/channel-file.h"
 #include "io/channel-tls.h"
 #include "sysemu/replay.h"
 #include "qemu/help_option.h"
@@ -46,7 +45,6 @@
 #ifndef _WIN32
 #include <sys/times.h>
 #include <sys/wait.h>
-#include <termios.h>
 #include <sys/ioctl.h>
 #include <sys/resource.h>
 #include <sys/socket.h>
@@ -91,6 +89,7 @@
 #ifdef _WIN32
 #include "char-win.h"
 #endif
+#include "char-serial.h"
=20
 /***********************************************************/
 /* character device */
@@ -656,198 +655,6 @@ void qemu_chr_fe_take_focus(CharBackend *b)
=20
 #ifndef _WIN32
=20
-#if defined(__linux__) || defined(__sun__) || defined(__FreeBSD__) \
-    || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFl=
y__) \
-    || defined(__GLIBC__)
-
-#define HAVE_CHARDEV_SERIAL 1
-
-static void tty_serial_init(int fd, int speed,
-                            int parity, int data_bits, int stop_bits)
-{
-    struct termios tty;
-    speed_t spd;
-
-#if 0
-    printf("tty_serial_init: speed=3D%d parity=3D%c data=3D%d stop=3D%d\=
n",
-           speed, parity, data_bits, stop_bits);
-#endif
-    tcgetattr (fd, &tty);
-
-#define check_speed(val) if (speed <=3D val) { spd =3D B##val; break; }
-    speed =3D speed * 10 / 11;
-    do {
-        check_speed(50);
-        check_speed(75);
-        check_speed(110);
-        check_speed(134);
-        check_speed(150);
-        check_speed(200);
-        check_speed(300);
-        check_speed(600);
-        check_speed(1200);
-        check_speed(1800);
-        check_speed(2400);
-        check_speed(4800);
-        check_speed(9600);
-        check_speed(19200);
-        check_speed(38400);
-        /* Non-Posix values follow. They may be unsupported on some syst=
ems. */
-        check_speed(57600);
-        check_speed(115200);
-#ifdef B230400
-        check_speed(230400);
-#endif
-#ifdef B460800
-        check_speed(460800);
-#endif
-#ifdef B500000
-        check_speed(500000);
-#endif
-#ifdef B576000
-        check_speed(576000);
-#endif
-#ifdef B921600
-        check_speed(921600);
-#endif
-#ifdef B1000000
-        check_speed(1000000);
-#endif
-#ifdef B1152000
-        check_speed(1152000);
-#endif
-#ifdef B1500000
-        check_speed(1500000);
-#endif
-#ifdef B2000000
-        check_speed(2000000);
-#endif
-#ifdef B2500000
-        check_speed(2500000);
-#endif
-#ifdef B3000000
-        check_speed(3000000);
-#endif
-#ifdef B3500000
-        check_speed(3500000);
-#endif
-#ifdef B4000000
-        check_speed(4000000);
-#endif
-        spd =3D B115200;
-    } while (0);
-
-    cfsetispeed(&tty, spd);
-    cfsetospeed(&tty, spd);
-
-    tty.c_iflag &=3D ~(IGNBRK|BRKINT|PARMRK|ISTRIP
-                          |INLCR|IGNCR|ICRNL|IXON);
-    tty.c_oflag |=3D OPOST;
-    tty.c_lflag &=3D ~(ECHO|ECHONL|ICANON|IEXTEN|ISIG);
-    tty.c_cflag &=3D ~(CSIZE|PARENB|PARODD|CRTSCTS|CSTOPB);
-    switch(data_bits) {
-    default:
-    case 8:
-        tty.c_cflag |=3D CS8;
-        break;
-    case 7:
-        tty.c_cflag |=3D CS7;
-        break;
-    case 6:
-        tty.c_cflag |=3D CS6;
-        break;
-    case 5:
-        tty.c_cflag |=3D CS5;
-        break;
-    }
-    switch(parity) {
-    default:
-    case 'N':
-        break;
-    case 'E':
-        tty.c_cflag |=3D PARENB;
-        break;
-    case 'O':
-        tty.c_cflag |=3D PARENB | PARODD;
-        break;
-    }
-    if (stop_bits =3D=3D 2)
-        tty.c_cflag |=3D CSTOPB;
-
-    tcsetattr (fd, TCSANOW, &tty);
-}
-
-static int tty_serial_ioctl(Chardev *chr, int cmd, void *arg)
-{
-    FDChardev *s =3D FD_CHARDEV(chr);
-    QIOChannelFile *fioc =3D QIO_CHANNEL_FILE(s->ioc_in);
-
-    switch(cmd) {
-    case CHR_IOCTL_SERIAL_SET_PARAMS:
-        {
-            QEMUSerialSetParams *ssp =3D arg;
-            tty_serial_init(fioc->fd,
-                            ssp->speed, ssp->parity,
-                            ssp->data_bits, ssp->stop_bits);
-        }
-        break;
-    case CHR_IOCTL_SERIAL_SET_BREAK:
-        {
-            int enable =3D *(int *)arg;
-            if (enable) {
-                tcsendbreak(fioc->fd, 1);
-            }
-        }
-        break;
-    case CHR_IOCTL_SERIAL_GET_TIOCM:
-        {
-            int sarg =3D 0;
-            int *targ =3D (int *)arg;
-            ioctl(fioc->fd, TIOCMGET, &sarg);
-            *targ =3D 0;
-            if (sarg & TIOCM_CTS)
-                *targ |=3D CHR_TIOCM_CTS;
-            if (sarg & TIOCM_CAR)
-                *targ |=3D CHR_TIOCM_CAR;
-            if (sarg & TIOCM_DSR)
-                *targ |=3D CHR_TIOCM_DSR;
-            if (sarg & TIOCM_RI)
-                *targ |=3D CHR_TIOCM_RI;
-            if (sarg & TIOCM_DTR)
-                *targ |=3D CHR_TIOCM_DTR;
-            if (sarg & TIOCM_RTS)
-                *targ |=3D CHR_TIOCM_RTS;
-        }
-        break;
-    case CHR_IOCTL_SERIAL_SET_TIOCM:
-        {
-            int sarg =3D *(int *)arg;
-            int targ =3D 0;
-            ioctl(fioc->fd, TIOCMGET, &targ);
-            targ &=3D ~(CHR_TIOCM_CTS | CHR_TIOCM_CAR | CHR_TIOCM_DSR
-                     | CHR_TIOCM_RI | CHR_TIOCM_DTR | CHR_TIOCM_RTS);
-            if (sarg & CHR_TIOCM_CTS)
-                targ |=3D TIOCM_CTS;
-            if (sarg & CHR_TIOCM_CAR)
-                targ |=3D TIOCM_CAR;
-            if (sarg & CHR_TIOCM_DSR)
-                targ |=3D TIOCM_DSR;
-            if (sarg & CHR_TIOCM_RI)
-                targ |=3D TIOCM_RI;
-            if (sarg & CHR_TIOCM_DTR)
-                targ |=3D TIOCM_DTR;
-            if (sarg & CHR_TIOCM_RTS)
-                targ |=3D TIOCM_RTS;
-            ioctl(fioc->fd, TIOCMSET, &targ);
-        }
-        break;
-    default:
-        return -ENOTSUP;
-    }
-    return 0;
-}
-#endif /* __linux__ || __sun__ */
-
 #if defined(__linux__)
=20
 #define HAVE_CHARDEV_PARPORT 1
@@ -1036,10 +843,6 @@ static void qemu_chr_open_pp_fd(Chardev *chr,
 }
 #endif
=20
-#else /* _WIN32 */
-
-#define HAVE_CHARDEV_SERIAL 1
-
 #endif /* !_WIN32 */
=20
 int qemu_chr_wait_connected(Chardev *chr, Error **errp)
@@ -1216,24 +1019,6 @@ void qemu_chr_parse_common(QemuOpts *opts, Chardev=
Common *backend)
     backend->logappend =3D qemu_opt_get_bool(opts, "logappend", false);
 }
=20
-#ifdef HAVE_CHARDEV_SERIAL
-static void qemu_chr_parse_serial(QemuOpts *opts, ChardevBackend *backen=
d,
-                                  Error **errp)
-{
-    const char *device =3D qemu_opt_get(opts, "path");
-    ChardevHostdev *serial;
-
-    backend->type =3D CHARDEV_BACKEND_KIND_SERIAL;
-    if (device =3D=3D NULL) {
-        error_setg(errp, "chardev: serial/tty: no device path given");
-        return;
-    }
-    serial =3D backend->u.serial.data =3D g_new0(ChardevHostdev, 1);
-    qemu_chr_parse_common(opts, qapi_ChardevHostdev_base(serial));
-    serial->device =3D g_strdup(device);
-}
-#endif
-
 #ifdef HAVE_CHARDEV_PARPORT
 static void qemu_chr_parse_parallel(QemuOpts *opts, ChardevBackend *back=
end,
                                     Error **errp)
@@ -1677,39 +1462,7 @@ QemuOptsList qemu_chardev_opts =3D {
     },
 };
=20
-#ifdef _WIN32
-
-static void qmp_chardev_open_serial(Chardev *chr,
-                                    ChardevBackend *backend,
-                                    bool *be_opened,
-                                    Error **errp)
-{
-    ChardevHostdev *serial =3D backend->u.serial.data;
-
-    win_chr_init(chr, serial->device, errp);
-}
-
-#else /* WIN32 */
-
-#ifdef HAVE_CHARDEV_SERIAL
-static void qmp_chardev_open_serial(Chardev *chr,
-                                    ChardevBackend *backend,
-                                    bool *be_opened,
-                                    Error **errp)
-{
-    ChardevHostdev *serial =3D backend->u.serial.data;
-    int fd;
-
-    fd =3D qmp_chardev_open_file_source(serial->device, O_RDWR, errp);
-    if (fd < 0) {
-        return;
-    }
-    qemu_set_nonblock(fd);
-    tty_serial_init(fd, 115200, 'N', 8, 1);
-
-    qemu_chr_open_fd(chr, fd, fd);
-}
-#endif
+#ifndef _WIN32
=20
 #ifdef HAVE_CHARDEV_PARPORT
 static void qmp_chardev_open_parallel(Chardev *chr,
@@ -1767,30 +1520,6 @@ static const TypeInfo char_parallel_type_info =3D =
{
=20
 #endif /* WIN32 */
=20
-#ifdef HAVE_CHARDEV_SERIAL
-
-static void char_serial_class_init(ObjectClass *oc, void *data)
-{
-    ChardevClass *cc =3D CHARDEV_CLASS(oc);
-
-    cc->parse =3D qemu_chr_parse_serial;
-    cc->open =3D qmp_chardev_open_serial;
-#ifndef _WIN32
-    cc->chr_ioctl =3D tty_serial_ioctl;
-#endif
-}
-
-static const TypeInfo char_serial_type_info =3D {
-    .name =3D TYPE_CHARDEV_SERIAL,
-#ifdef _WIN32
-    .parent =3D TYPE_CHARDEV_WIN,
-#else
-    .parent =3D TYPE_CHARDEV_FD,
-#endif
-    .class_init =3D char_serial_class_init,
-};
-#endif
-
 bool qemu_chr_has_feature(Chardev *chr,
                           ChardevFeature feature)
 {
@@ -1892,9 +1621,6 @@ void qemu_chr_cleanup(void)
 static void register_types(void)
 {
     type_register_static(&char_type_info);
-#ifdef HAVE_CHARDEV_SERIAL
-    type_register_static(&char_serial_type_info);
-#endif
 #ifdef HAVE_CHARDEV_PARPORT
     type_register_static(&char_parallel_type_info);
 #endif
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index b2c14fe795..45fc8af0c4 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -8,6 +8,7 @@ chardev-obj-y +=3D char-null.o
 chardev-obj-y +=3D char-pipe.o
 chardev-obj-$(CONFIG_POSIX) +=3D char-pty.o
 chardev-obj-y +=3D char-ringbuf.o
+chardev-obj-y +=3D char-serial.o
 chardev-obj-y +=3D char-socket.o
 chardev-obj-y +=3D char-stdio.o
 chardev-obj-y +=3D char-udp.o
--=20
2.11.0
