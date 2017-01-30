Received: from eggs.gnu.org ([2001:4830:134:3::10]:38639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCE6-0006Nh-TL
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:42:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCE4-0007DJ-MT
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:42:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYCE4-0007C8-Cw
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:42:32 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 739F1635E2
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 13:42:32 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 30 Jan 2017 17:39:44 +0400
Message-Id: <20170130133954.31353-32-marcandre.lureau@redhat.com>
In-Reply-To: <20170130133954.31353-1-marcandre.lureau@redhat.com>
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 31/41] char: move win-stdio into its own file
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
Acked-by: Eric Blake <eblake@redhat.com>
---
 chardev/char-win-stdio.h |  29 ++++++
 chardev/char-win-stdio.c | 266 +++++++++++++++++++++++++++++++++++++++++=
++++++
 chardev/char.c           | 231 +---------------------------------------
 chardev/Makefile.objs    |   1 +
 4 files changed, 298 insertions(+), 229 deletions(-)
 create mode 100644 chardev/char-win-stdio.h
 create mode 100644 chardev/char-win-stdio.c

diff --git a/chardev/char-win-stdio.h b/chardev/char-win-stdio.h
new file mode 100644
index 0000000000..d7314f734d
--- /dev/null
+++ b/chardev/char-win-stdio.h
@@ -0,0 +1,29 @@
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
+#ifndef CHAR_WIN_STDIO_H
+#define CHAR_WIN_STDIO_H
+
+#define TYPE_CHARDEV_WIN_STDIO "chardev-win-stdio"
+
+#endif /* CHAR_WIN_STDIO_H */
diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
new file mode 100644
index 0000000000..eb44afc17a
--- /dev/null
+++ b/chardev/char-win-stdio.c
@@ -0,0 +1,266 @@
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
+#include "qapi/error.h"
+#include "char-win.h"
+#include "char-win-stdio.h"
+
+typedef struct {
+    Chardev parent;
+    HANDLE  hStdIn;
+    HANDLE  hInputReadyEvent;
+    HANDLE  hInputDoneEvent;
+    HANDLE  hInputThread;
+    uint8_t win_stdio_buf;
+} WinStdioChardev;
+
+#define WIN_STDIO_CHARDEV(obj)                                          =
\
+    OBJECT_CHECK(WinStdioChardev, (obj), TYPE_CHARDEV_WIN_STDIO)
+
+static void win_stdio_wait_func(void *opaque)
+{
+    Chardev *chr =3D CHARDEV(opaque);
+    WinStdioChardev *stdio =3D WIN_STDIO_CHARDEV(opaque);
+    INPUT_RECORD       buf[4];
+    int                ret;
+    DWORD              dwSize;
+    int                i;
+
+    ret =3D ReadConsoleInput(stdio->hStdIn, buf, ARRAY_SIZE(buf), &dwSiz=
e);
+
+    if (!ret) {
+        /* Avoid error storm */
+        qemu_del_wait_object(stdio->hStdIn, NULL, NULL);
+        return;
+    }
+
+    for (i =3D 0; i < dwSize; i++) {
+        KEY_EVENT_RECORD *kev =3D &buf[i].Event.KeyEvent;
+
+        if (buf[i].EventType =3D=3D KEY_EVENT && kev->bKeyDown) {
+            int j;
+            if (kev->uChar.AsciiChar !=3D 0) {
+                for (j =3D 0; j < kev->wRepeatCount; j++) {
+                    if (qemu_chr_be_can_write(chr)) {
+                        uint8_t c =3D kev->uChar.AsciiChar;
+                        qemu_chr_be_write(chr, &c, 1);
+                    }
+                }
+            }
+        }
+    }
+}
+
+static DWORD WINAPI win_stdio_thread(LPVOID param)
+{
+    WinStdioChardev *stdio =3D WIN_STDIO_CHARDEV(param);
+    int                ret;
+    DWORD              dwSize;
+
+    while (1) {
+
+        /* Wait for one byte */
+        ret =3D ReadFile(stdio->hStdIn, &stdio->win_stdio_buf, 1, &dwSiz=
e, NULL);
+
+        /* Exit in case of error, continue if nothing read */
+        if (!ret) {
+            break;
+        }
+        if (!dwSize) {
+            continue;
+        }
+
+        /* Some terminal emulator returns \r\n for Enter, just pass \n *=
/
+        if (stdio->win_stdio_buf =3D=3D '\r') {
+            continue;
+        }
+
+        /* Signal the main thread and wait until the byte was eaten */
+        if (!SetEvent(stdio->hInputReadyEvent)) {
+            break;
+        }
+        if (WaitForSingleObject(stdio->hInputDoneEvent, INFINITE)
+            !=3D WAIT_OBJECT_0) {
+            break;
+        }
+    }
+
+    qemu_del_wait_object(stdio->hInputReadyEvent, NULL, NULL);
+    return 0;
+}
+
+static void win_stdio_thread_wait_func(void *opaque)
+{
+    Chardev *chr =3D CHARDEV(opaque);
+    WinStdioChardev *stdio =3D WIN_STDIO_CHARDEV(opaque);
+
+    if (qemu_chr_be_can_write(chr)) {
+        qemu_chr_be_write(chr, &stdio->win_stdio_buf, 1);
+    }
+
+    SetEvent(stdio->hInputDoneEvent);
+}
+
+static void qemu_chr_set_echo_win_stdio(Chardev *chr, bool echo)
+{
+    WinStdioChardev *stdio =3D WIN_STDIO_CHARDEV(chr);
+    DWORD              dwMode =3D 0;
+
+    GetConsoleMode(stdio->hStdIn, &dwMode);
+
+    if (echo) {
+        SetConsoleMode(stdio->hStdIn, dwMode | ENABLE_ECHO_INPUT);
+    } else {
+        SetConsoleMode(stdio->hStdIn, dwMode & ~ENABLE_ECHO_INPUT);
+    }
+}
+
+static void qemu_chr_open_stdio(Chardev *chr,
+                                ChardevBackend *backend,
+                                bool *be_opened,
+                                Error **errp)
+{
+    WinStdioChardev *stdio =3D WIN_STDIO_CHARDEV(chr);
+    DWORD              dwMode;
+    int                is_console =3D 0;
+
+    stdio->hStdIn =3D GetStdHandle(STD_INPUT_HANDLE);
+    if (stdio->hStdIn =3D=3D INVALID_HANDLE_VALUE) {
+        error_setg(errp, "cannot open stdio: invalid handle");
+        return;
+    }
+
+    is_console =3D GetConsoleMode(stdio->hStdIn, &dwMode) !=3D 0;
+
+    if (is_console) {
+        if (qemu_add_wait_object(stdio->hStdIn,
+                                 win_stdio_wait_func, chr)) {
+            error_setg(errp, "qemu_add_wait_object: failed");
+            goto err1;
+        }
+    } else {
+        DWORD   dwId;
+
+        stdio->hInputReadyEvent =3D CreateEvent(NULL, FALSE, FALSE, NULL=
);
+        stdio->hInputDoneEvent  =3D CreateEvent(NULL, FALSE, FALSE, NULL=
);
+        if (stdio->hInputReadyEvent =3D=3D INVALID_HANDLE_VALUE
+            || stdio->hInputDoneEvent =3D=3D INVALID_HANDLE_VALUE) {
+            error_setg(errp, "cannot create event");
+            goto err2;
+        }
+        if (qemu_add_wait_object(stdio->hInputReadyEvent,
+                                 win_stdio_thread_wait_func, chr)) {
+            error_setg(errp, "qemu_add_wait_object: failed");
+            goto err2;
+        }
+        stdio->hInputThread     =3D CreateThread(NULL, 0, win_stdio_thre=
ad,
+                                               chr, 0, &dwId);
+
+        if (stdio->hInputThread =3D=3D INVALID_HANDLE_VALUE) {
+            error_setg(errp, "cannot create stdio thread");
+            goto err3;
+        }
+    }
+
+    dwMode |=3D ENABLE_LINE_INPUT;
+
+    if (is_console) {
+        /* set the terminal in raw mode */
+        /* ENABLE_QUICK_EDIT_MODE | ENABLE_EXTENDED_FLAGS */
+        dwMode |=3D ENABLE_PROCESSED_INPUT;
+    }
+
+    SetConsoleMode(stdio->hStdIn, dwMode);
+
+    qemu_chr_set_echo_win_stdio(chr, false);
+
+    return;
+
+err3:
+    qemu_del_wait_object(stdio->hInputReadyEvent, NULL, NULL);
+err2:
+    CloseHandle(stdio->hInputReadyEvent);
+    CloseHandle(stdio->hInputDoneEvent);
+err1:
+    qemu_del_wait_object(stdio->hStdIn, NULL, NULL);
+}
+
+static void char_win_stdio_finalize(Object *obj)
+{
+    WinStdioChardev *stdio =3D WIN_STDIO_CHARDEV(obj);
+
+    if (stdio->hInputReadyEvent !=3D INVALID_HANDLE_VALUE) {
+        CloseHandle(stdio->hInputReadyEvent);
+    }
+    if (stdio->hInputDoneEvent !=3D INVALID_HANDLE_VALUE) {
+        CloseHandle(stdio->hInputDoneEvent);
+    }
+    if (stdio->hInputThread !=3D INVALID_HANDLE_VALUE) {
+        TerminateThread(stdio->hInputThread, 0);
+    }
+}
+
+static int win_stdio_write(Chardev *chr, const uint8_t *buf, int len)
+{
+    HANDLE  hStdOut =3D GetStdHandle(STD_OUTPUT_HANDLE);
+    DWORD   dwSize;
+    int     len1;
+
+    len1 =3D len;
+
+    while (len1 > 0) {
+        if (!WriteFile(hStdOut, buf, len1, &dwSize, NULL)) {
+            break;
+        }
+        buf  +=3D dwSize;
+        len1 -=3D dwSize;
+    }
+
+    return len - len1;
+}
+
+static void char_win_stdio_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->open =3D qemu_chr_open_stdio;
+    cc->chr_write =3D win_stdio_write;
+    cc->chr_set_echo =3D qemu_chr_set_echo_win_stdio;
+}
+
+static const TypeInfo char_win_stdio_type_info =3D {
+    .name =3D TYPE_CHARDEV_WIN_STDIO,
+    .parent =3D TYPE_CHARDEV,
+    .instance_size =3D sizeof(WinStdioChardev),
+    .instance_finalize =3D char_win_stdio_finalize,
+    .class_init =3D char_win_stdio_class_init,
+    .abstract =3D true,
+};
+
+static void register_types(void)
+{
+    type_register_static(&char_win_stdio_type_info);
+}
+
+type_init(register_types);
diff --git a/chardev/char.c b/chardev/char.c
index b80fcae028..8393bb0294 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -90,6 +90,7 @@
 #include "char-io.h"
 #ifdef _WIN32
 #include "char-win.h"
+#include "char-win-stdio.h"
 #endif
=20
 #define TCP_MAX_FDS 16
@@ -1474,19 +1475,6 @@ static void qemu_chr_open_pp_fd(Chardev *chr,
=20
 #define HAVE_CHARDEV_SERIAL 1
=20
-typedef struct {
-    Chardev parent;
-    HANDLE  hStdIn;
-    HANDLE  hInputReadyEvent;
-    HANDLE  hInputDoneEvent;
-    HANDLE  hInputThread;
-    uint8_t win_stdio_buf;
-} WinStdioChardev;
-
-#define TYPE_CHARDEV_WIN_STDIO "chardev-win-stdio"
-#define WIN_STDIO_CHARDEV(obj)                                  \
-    OBJECT_CHECK(WinStdioChardev, (obj), TYPE_CHARDEV_WIN_STDIO)
-
 #define MAXCONNECT 1
 #define NTIMEOUT 5000
=20
@@ -1588,215 +1576,6 @@ static const TypeInfo char_console_type_info =3D =
{
     .class_init =3D char_console_class_init,
 };
=20
-static int win_stdio_write(Chardev *chr, const uint8_t *buf, int len)
-{
-    HANDLE  hStdOut =3D GetStdHandle(STD_OUTPUT_HANDLE);
-    DWORD   dwSize;
-    int     len1;
-
-    len1 =3D len;
-
-    while (len1 > 0) {
-        if (!WriteFile(hStdOut, buf, len1, &dwSize, NULL)) {
-            break;
-        }
-        buf  +=3D dwSize;
-        len1 -=3D dwSize;
-    }
-
-    return len - len1;
-}
-
-static void win_stdio_wait_func(void *opaque)
-{
-    Chardev *chr =3D CHARDEV(opaque);
-    WinStdioChardev *stdio =3D WIN_STDIO_CHARDEV(opaque);
-    INPUT_RECORD       buf[4];
-    int                ret;
-    DWORD              dwSize;
-    int                i;
-
-    ret =3D ReadConsoleInput(stdio->hStdIn, buf, ARRAY_SIZE(buf), &dwSiz=
e);
-
-    if (!ret) {
-        /* Avoid error storm */
-        qemu_del_wait_object(stdio->hStdIn, NULL, NULL);
-        return;
-    }
-
-    for (i =3D 0; i < dwSize; i++) {
-        KEY_EVENT_RECORD *kev =3D &buf[i].Event.KeyEvent;
-
-        if (buf[i].EventType =3D=3D KEY_EVENT && kev->bKeyDown) {
-            int j;
-            if (kev->uChar.AsciiChar !=3D 0) {
-                for (j =3D 0; j < kev->wRepeatCount; j++) {
-                    if (qemu_chr_be_can_write(chr)) {
-                        uint8_t c =3D kev->uChar.AsciiChar;
-                        qemu_chr_be_write(chr, &c, 1);
-                    }
-                }
-            }
-        }
-    }
-}
-
-static DWORD WINAPI win_stdio_thread(LPVOID param)
-{
-    WinStdioChardev *stdio =3D WIN_STDIO_CHARDEV(param);
-    int                ret;
-    DWORD              dwSize;
-
-    while (1) {
-
-        /* Wait for one byte */
-        ret =3D ReadFile(stdio->hStdIn, &stdio->win_stdio_buf, 1, &dwSiz=
e, NULL);
-
-        /* Exit in case of error, continue if nothing read */
-        if (!ret) {
-            break;
-        }
-        if (!dwSize) {
-            continue;
-        }
-
-        /* Some terminal emulator returns \r\n for Enter, just pass \n *=
/
-        if (stdio->win_stdio_buf =3D=3D '\r') {
-            continue;
-        }
-
-        /* Signal the main thread and wait until the byte was eaten */
-        if (!SetEvent(stdio->hInputReadyEvent)) {
-            break;
-        }
-        if (WaitForSingleObject(stdio->hInputDoneEvent, INFINITE)
-            !=3D WAIT_OBJECT_0) {
-            break;
-        }
-    }
-
-    qemu_del_wait_object(stdio->hInputReadyEvent, NULL, NULL);
-    return 0;
-}
-
-static void win_stdio_thread_wait_func(void *opaque)
-{
-    Chardev *chr =3D CHARDEV(opaque);
-    WinStdioChardev *stdio =3D WIN_STDIO_CHARDEV(opaque);
-
-    if (qemu_chr_be_can_write(chr)) {
-        qemu_chr_be_write(chr, &stdio->win_stdio_buf, 1);
-    }
-
-    SetEvent(stdio->hInputDoneEvent);
-}
-
-static void qemu_chr_set_echo_win_stdio(Chardev *chr, bool echo)
-{
-    WinStdioChardev *stdio =3D WIN_STDIO_CHARDEV(chr);
-    DWORD              dwMode =3D 0;
-
-    GetConsoleMode(stdio->hStdIn, &dwMode);
-
-    if (echo) {
-        SetConsoleMode(stdio->hStdIn, dwMode | ENABLE_ECHO_INPUT);
-    } else {
-        SetConsoleMode(stdio->hStdIn, dwMode & ~ENABLE_ECHO_INPUT);
-    }
-}
-
-static void char_win_stdio_finalize(Object *obj)
-{
-    WinStdioChardev *stdio =3D WIN_STDIO_CHARDEV(obj);
-
-    if (stdio->hInputReadyEvent !=3D INVALID_HANDLE_VALUE) {
-        CloseHandle(stdio->hInputReadyEvent);
-    }
-    if (stdio->hInputDoneEvent !=3D INVALID_HANDLE_VALUE) {
-        CloseHandle(stdio->hInputDoneEvent);
-    }
-    if (stdio->hInputThread !=3D INVALID_HANDLE_VALUE) {
-        TerminateThread(stdio->hInputThread, 0);
-    }
-}
-
-static const TypeInfo char_win_stdio_type_info =3D {
-    .name =3D TYPE_CHARDEV_WIN_STDIO,
-    .parent =3D TYPE_CHARDEV,
-    .instance_size =3D sizeof(WinStdioChardev),
-    .instance_finalize =3D char_win_stdio_finalize,
-    .abstract =3D true,
-};
-
-static void qemu_chr_open_stdio(Chardev *chr,
-                                ChardevBackend *backend,
-                                bool *be_opened,
-                                Error **errp)
-{
-    WinStdioChardev *stdio =3D WIN_STDIO_CHARDEV(chr);
-    DWORD              dwMode;
-    int                is_console =3D 0;
-
-    stdio->hStdIn =3D GetStdHandle(STD_INPUT_HANDLE);
-    if (stdio->hStdIn =3D=3D INVALID_HANDLE_VALUE) {
-        error_setg(errp, "cannot open stdio: invalid handle");
-        return;
-    }
-
-    is_console =3D GetConsoleMode(stdio->hStdIn, &dwMode) !=3D 0;
-
-    if (is_console) {
-        if (qemu_add_wait_object(stdio->hStdIn,
-                                 win_stdio_wait_func, chr)) {
-            error_setg(errp, "qemu_add_wait_object: failed");
-            goto err1;
-        }
-    } else {
-        DWORD   dwId;
-           =20
-        stdio->hInputReadyEvent =3D CreateEvent(NULL, FALSE, FALSE, NULL=
);
-        stdio->hInputDoneEvent  =3D CreateEvent(NULL, FALSE, FALSE, NULL=
);
-        if (stdio->hInputReadyEvent =3D=3D INVALID_HANDLE_VALUE
-            || stdio->hInputDoneEvent =3D=3D INVALID_HANDLE_VALUE) {
-            error_setg(errp, "cannot create event");
-            goto err2;
-        }
-        if (qemu_add_wait_object(stdio->hInputReadyEvent,
-                                 win_stdio_thread_wait_func, chr)) {
-            error_setg(errp, "qemu_add_wait_object: failed");
-            goto err2;
-        }
-        stdio->hInputThread     =3D CreateThread(NULL, 0, win_stdio_thre=
ad,
-                                               chr, 0, &dwId);
-
-        if (stdio->hInputThread =3D=3D INVALID_HANDLE_VALUE) {
-            error_setg(errp, "cannot create stdio thread");
-            goto err3;
-        }
-    }
-
-    dwMode |=3D ENABLE_LINE_INPUT;
-
-    if (is_console) {
-        /* set the terminal in raw mode */
-        /* ENABLE_QUICK_EDIT_MODE | ENABLE_EXTENDED_FLAGS */
-        dwMode |=3D ENABLE_PROCESSED_INPUT;
-    }
-
-    SetConsoleMode(stdio->hStdIn, dwMode);
-
-    qemu_chr_set_echo_win_stdio(chr, false);
-
-    return;
-
-err3:
-    qemu_del_wait_object(stdio->hInputReadyEvent, NULL, NULL);
-err2:
-    CloseHandle(stdio->hInputReadyEvent);
-    CloseHandle(stdio->hInputDoneEvent);
-err1:
-    qemu_del_wait_object(stdio->hStdIn, NULL, NULL);
-}
 #endif /* !_WIN32 */
=20
 /***********************************************************/
@@ -2785,11 +2564,8 @@ static void char_stdio_class_init(ObjectClass *oc,=
 void *data)
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
     cc->parse =3D qemu_chr_parse_stdio;
+#ifndef _WIN32
     cc->open =3D qemu_chr_open_stdio;
-#ifdef _WIN32
-    cc->chr_write =3D win_stdio_write;
-    cc->chr_set_echo =3D qemu_chr_set_echo_win_stdio;
-#else
     cc->chr_set_echo =3D qemu_chr_set_echo_stdio;
 #endif
 }
@@ -3955,9 +3731,6 @@ void qemu_chr_cleanup(void)
 static void register_types(void)
 {
     type_register_static(&char_type_info);
-#ifdef _WIN32
-    type_register_static(&char_win_stdio_type_info);
-#endif
     type_register_static(&char_socket_type_info);
     type_register_static(&char_udp_type_info);
     type_register_static(&char_file_type_info);
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index bdf5a112a7..3c4a328de8 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -5,3 +5,4 @@ chardev-obj-y +=3D char-mux.o
 chardev-obj-y +=3D char-null.o
 chardev-obj-y +=3D char-ringbuf.o
 chardev-obj-$(CONFIG_WIN32) +=3D char-win.o
+chardev-obj-$(CONFIG_WIN32) +=3D char-win-stdio.o
--=20
2.11.0.295.gd7dffce1c.dirty
