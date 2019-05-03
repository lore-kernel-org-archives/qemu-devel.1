Received: from eggs.gnu.org ([209.51.188.92]:34108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWLt-0007yo-FS
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:27:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWLs-0003aI-5I
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:27:41 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri,  3 May 2019 13:26:54 +0200
Message-Id: <20190503112654.4393-13-laurent@vivier.eu>
In-Reply-To: <20190503112654.4393-1-laurent@vivier.eu>
References: <20190503112654.4393-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 12/12] sockets: avoid string truncation
 warnings when copying UNIX path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Fabien Chouteau <chouteau@adacore.com>, qemu-trivial@nongnu.org, Richard Henderson <rth@twiddle.net>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eric Blake <eblake@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>

From: Daniel P. Berrangé <berrange@redhat.com>

In file included from /usr/include/string.h:494,
                 from include/qemu/osdep.h:101,
                 from util/qemu-sockets.c:18:
In function ‘strncpy’,
    inlined from ‘unix_connect_saddr.isra.0’ at util/qemu-sockets.c:925:5:
/usr/include/bits/string_fortified.h:106:10: warning: ‘__builtin_strncpy’ specified bound 108 equals destination size [-Wstringop-truncation]
  106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function ‘strncpy’,
    inlined from ‘unix_listen_saddr.isra.0’ at util/qemu-sockets.c:880:5:
/usr/include/bits/string_fortified.h:106:10: warning: ‘__builtin_strncpy’ specified bound 108 equals destination size [-Wstringop-truncation]
  106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

We are already validating the UNIX socket path length earlier in
the functions. If we save this string length when we first check
it, then we can simply use memcpy instead of strcpy later, avoiding
the gcc truncation warnings.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20190501145052.12579-1-berrange@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 util/qemu-sockets.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 970505169000..ba6335e71a95 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -830,6 +830,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
     int sock, fd;
     char *pathbuf = NULL;
     const char *path;
+    size_t pathlen;
 
     sock = qemu_socket(PF_UNIX, SOCK_STREAM, 0);
     if (sock < 0) {
@@ -845,7 +846,8 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
         path = pathbuf = g_strdup_printf("%s/qemu-socket-XXXXXX", tmpdir);
     }
 
-    if (strlen(path) > sizeof(un.sun_path)) {
+    pathlen = strlen(path);
+    if (pathlen > sizeof(un.sun_path)) {
         error_setg(errp, "UNIX socket path '%s' is too long", path);
         error_append_hint(errp, "Path must be less than %zu bytes\n",
                           sizeof(un.sun_path));
@@ -877,7 +879,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
 
     memset(&un, 0, sizeof(un));
     un.sun_family = AF_UNIX;
-    strncpy(un.sun_path, path, sizeof(un.sun_path));
+    memcpy(un.sun_path, path, pathlen);
 
     if (bind(sock, (struct sockaddr*) &un, sizeof(un)) < 0) {
         error_setg_errno(errp, errno, "Failed to bind socket to %s", path);
@@ -901,6 +903,7 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
 {
     struct sockaddr_un un;
     int sock, rc;
+    size_t pathlen;
 
     if (saddr->path == NULL) {
         error_setg(errp, "unix connect: no path specified");
@@ -913,7 +916,8 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
         return -1;
     }
 
-    if (strlen(saddr->path) > sizeof(un.sun_path)) {
+    pathlen = strlen(saddr->path);
+    if (pathlen > sizeof(un.sun_path)) {
         error_setg(errp, "UNIX socket path '%s' is too long", saddr->path);
         error_append_hint(errp, "Path must be less than %zu bytes\n",
                           sizeof(un.sun_path));
@@ -922,7 +926,7 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
 
     memset(&un, 0, sizeof(un));
     un.sun_family = AF_UNIX;
-    strncpy(un.sun_path, saddr->path, sizeof(un.sun_path));
+    memcpy(un.sun_path, saddr->path, pathlen);
 
     /* connect to peer */
     do {
-- 
2.20.1
