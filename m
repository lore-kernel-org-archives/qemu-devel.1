Received: from eggs.gnu.org ([2001:4830:134:3::10]:42611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jreinhart@cc-sw.com>) id 1fl0Gv-00028H-1c
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 19:11:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jreinhart@cc-sw.com>) id 1fl0Gt-0001Bm-VW
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 19:11:13 -0400
Received: from mail-yb0-x243.google.com ([2607:f8b0:4002:c09::243]:45036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jreinhart@cc-sw.com>) id 1fl0Gt-0001A2-O9
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 19:11:11 -0400
Received: by mail-yb0-x243.google.com with SMTP id l16-v6so108520ybk.11
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 16:11:11 -0700 (PDT)
MIME-Version: 1.0
From: Jonathon Reinhart <jreinhart@cc-sw.com>
Date: Wed, 1 Aug 2018 19:10:59 -0400
Message-ID: <CAOrZHTTgNLY6UjvgMm_98R9A0-GvCz-1owxOYz-1dN9-kVNmhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [PATCH] qga: Support Unicode paths in guest-file-open
 on win32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>

Currently, the win32 port of QEMU Guest Agent does not properly handle Unicode
paths. The JSON decoder produces a valid UTF-8 path string, but this is passed
directly to CreateFileA, which is expecting an ANSI string and not UTF-8. This
leads to mangled filenames.

This patch follows the example of qmp_guest_set_user_password() and uses
g_utf8_to_utf16() to convert the string to UTF-16 and calls CreateFileW()
explicitly.

Signed-off-by: Jonathon Reinhart <jreinhart@cc-sw.com>
---
 qga/commands-win32.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 98d9735389..416343b97b 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -160,13 +160,15 @@ static void handle_set_nonblocking(HANDLE fh)
 int64_t qmp_guest_file_open(const char *path, bool has_mode,
                             const char *mode, Error **errp)
 {
-    int64_t fd;
+    int64_t fd = -1;
     HANDLE fh;
     HANDLE templ_file = NULL;
     DWORD share_mode = FILE_SHARE_READ;
     DWORD flags_and_attr = FILE_ATTRIBUTE_NORMAL;
     LPSECURITY_ATTRIBUTES sa_attr = NULL;
     OpenFlags *guest_flags;
+    GError *gerr = NULL;
+    wchar_t *w_path = NULL;

     if (!has_mode) {
         mode = "r";
@@ -175,16 +177,21 @@ int64_t qmp_guest_file_open(const char *path,
bool has_mode,
     guest_flags = find_open_flag(mode);
     if (guest_flags == NULL) {
         error_setg(errp, "invalid file open mode");
-        return -1;
+        goto done;
+    }
+
+    w_path = g_utf8_to_utf16(path, -1, NULL, NULL, &gerr);
+    if (!w_path) {
+        goto done;
     }

-    fh = CreateFile(path, guest_flags->desired_access, share_mode, sa_attr,
+    fh = CreateFileW(w_path, guest_flags->desired_access, share_mode, sa_attr,
                     guest_flags->creation_disposition, flags_and_attr,
                     templ_file);
     if (fh == INVALID_HANDLE_VALUE) {
         error_setg_win32(errp, GetLastError(), "failed to open file '%s'",
                          path);
-        return -1;
+        goto done;
     }

     /* set fd non-blocking to avoid common use cases (like reading from a
@@ -196,10 +203,17 @@ int64_t qmp_guest_file_open(const char *path,
bool has_mode,
     if (fd < 0) {
         CloseHandle(fh);
         error_setg(errp, "failed to add handle to qmp handle table");
-        return -1;
+        goto done;
     }

     slog("guest-file-open, handle: % " PRId64, fd);
+
+done:
+    if (gerr) {
+        error_setg(errp, QERR_QGA_COMMAND_FAILED, gerr->message);
+        g_error_free(gerr);
+    }
+    g_free(w_path);
     return fd;
 }

-- 
2.11.0
