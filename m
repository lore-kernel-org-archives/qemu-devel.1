Received: from eggs.gnu.org ([2001:4830:134:3::10]:40056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dgvIA-0000QP-HA
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 11:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dgvI5-0003kT-ME
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 11:59:06 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1dgvI5-0003jV-Cb
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 11:59:01 -0400
Received: by mail-wm0-x243.google.com with SMTP id x64so11895426wmg.1
	for <qemu-devel@nongnu.org>; Sun, 13 Aug 2017 08:58:59 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Sun, 13 Aug 2017 18:58:47 +0300
Message-Id: <20170813155849.11368-2-sameeh@daynix.com>
In-Reply-To: <20170813155849.11368-1-sameeh@daynix.com>
References: <20170813155849.11368-1-sameeh@daynix.com>
Subject: [Qemu-devel] [PATCH 1/3] qga: Channel: Add functions for checking
 serial status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Cc: yan@daynix.com

From: Sameeh Jubran <sjubran@redhat.com>

This commit adds functions to check if the serial is
connected/disconnected or else if it has been attached or detached.

Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
---
 qga/channel-posix.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 qga/channel-win32.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 qga/channel.h       |  9 ++++++++
 3 files changed, 123 insertions(+)

diff --git a/qga/channel-posix.c b/qga/channel-posix.c
index 3f34465..d307cf4 100644
--- a/qga/channel-posix.c
+++ b/qga/channel-posix.c
@@ -295,3 +295,57 @@ void ga_channel_free(GAChannel *c)
     }
     g_free(c);
 }
+
+static bool is_serial_present(GAChannelMethod method, const gchar *path,
+    int *error_code)
+{
+    int fd = -1;
+    bool ret = true;
+
+    assert(error_code);
+    *error_code = 0;
+
+    switch (method) {
+    case GA_CHANNEL_VIRTIO_SERIAL:
+        fd = qemu_open(path, O_RDWR | O_NONBLOCK
+#ifndef CONFIG_SOLARIS
+            | O_ASYNC
+#endif
+        );
+        break;
+    case GA_CHANNEL_ISA_SERIAL:
+        fd = qemu_open(path, O_RDWR | O_NOCTTY | O_NONBLOCK);
+        break;
+    default:
+        ret = false;
+    }
+    if (fd < 0) {
+        *error_code = errno;
+        ret = false;
+    } else {
+        close(fd);
+    }
+    return ret;
+}
+
+bool ga_channel_serial_is_present(GAChannelMethod method, const gchar *path)
+{
+    int error_code = 0;
+    return is_serial_present(method, path, &error_code) ||
+        error_code == EBUSY;
+}
+
+bool ga_channel_was_serial_attached(GAChannelMethod method, const gchar *path,
+    bool is_serial_attached)
+{
+    int error_code = 0;
+    return !is_serial_attached &&
+        is_serial_present(method, path, &error_code);
+}
+bool ga_channel_was_serial_detached(GAChannelMethod method, const gchar *path,
+    bool is_serial_attached)
+{
+    int error_code = 0;
+    return is_serial_attached && !is_serial_present(method, path, &error_code)
+        && error_code == ENOENT;
+}
diff --git a/qga/channel-win32.c b/qga/channel-win32.c
index 7e6dc4d..2d51bee 100644
--- a/qga/channel-win32.c
+++ b/qga/channel-win32.c
@@ -354,3 +354,63 @@ void ga_channel_free(GAChannel *c)
     g_free(c->rstate.buf);
     g_free(c);
 }
+
+static bool is_serial_present(GAChannelMethod method, const gchar *path,
+    DWORD *err)
+{
+    gchar newpath[MAXPATHLEN] = { 0 };
+    bool ret = false;
+
+    assert(err);
+
+    if (method != GA_CHANNEL_VIRTIO_SERIAL && method != GA_CHANNEL_ISA_SERIAL) {
+        g_critical("unsupported communication method");
+        return false;
+    }
+
+    if (method == GA_CHANNEL_ISA_SERIAL) {
+        snprintf(newpath, sizeof(newpath), "\\\\.\\%s", path);
+    } else {
+        g_strlcpy(newpath, path, sizeof(newpath));
+    }
+
+    HANDLE handle = CreateFile(newpath, GENERIC_READ | GENERIC_WRITE, 0, NULL,
+        OPEN_EXISTING,
+        FILE_FLAG_NO_BUFFERING | FILE_FLAG_OVERLAPPED, NULL);
+
+    if (handle == INVALID_HANDLE_VALUE) {
+        *err = GetLastError();
+        ret = false;
+    } else {
+        ret = true;
+    }
+
+    CloseHandle(handle);
+    return ret;
+}
+
+bool ga_channel_serial_is_present(GAChannelMethod method, const gchar *path)
+{
+    DWORD err_code;
+    return is_serial_present(method, path, &err_code) ||
+        err_code == ERROR_ACCESS_DENIED;
+}
+
+bool ga_channel_was_serial_attached(GAChannelMethod method, const gchar *path,
+    bool is_serial_attached)
+{
+    DWORD err_code;
+    return !is_serial_attached && is_serial_present(method, path, &err_code);
+}
+
+bool ga_channel_was_serial_detached(GAChannelMethod method, const gchar *path,
+    bool is_serial_attached)
+{
+    DWORD err_code = NO_ERROR;
+        /* In order to make sure the serial that qemu-ga uses is the one that
+         * was detached. We'll get the error ERROR_FILE_NOT_FOUND when
+         * attempting to call CreateFile with the serial path.
+        */
+       return is_serial_attached && !is_serial_present(method, path, &err_code)
+           && err_code == ERROR_FILE_NOT_FOUND;
+}
diff --git a/qga/channel.h b/qga/channel.h
index 1778416..acb3d73 100644
--- a/qga/channel.h
+++ b/qga/channel.h
@@ -12,6 +12,10 @@
 #ifndef QGA_CHANNEL_H
 #define QGA_CHANNEL_H
 
+#ifndef _WIN32
+#define SUBSYSTEM_VIRTIO_SERIAL "virtio-ports";
+#define SUBSYSTEM_ISA_SERIAL "isa-serial";
+#endif
 
 typedef struct GAChannel GAChannel;
 
@@ -30,5 +34,10 @@ GAChannel *ga_channel_new(GAChannelMethod method, const gchar *path,
 void ga_channel_free(GAChannel *c);
 GIOStatus ga_channel_read(GAChannel *c, gchar *buf, gsize size, gsize *count);
 GIOStatus ga_channel_write_all(GAChannel *c, const gchar *buf, gsize size);
+bool ga_channel_serial_is_present(GAChannelMethod method, const gchar *path);
+bool ga_channel_was_serial_attached(GAChannelMethod method, const gchar *path,
+    bool is_serial_attached);
+bool ga_channel_was_serial_detached(GAChannelMethod method, const gchar *path,
+    bool is_serial_attached);
 
 #endif
-- 
2.9.4
