Received: from eggs.gnu.org ([2001:4830:134:3::10]:33534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d6f1G-0000mH-2A
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:19:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d6f1C-00008x-QU
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:19:46 -0400
Received: from 17.mo5.mail-out.ovh.net ([46.105.56.132]:51145)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d6f1C-00007H-JH
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:19:42 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 17A90EB6DE
	for <qemu-devel@nongnu.org>; Fri,  5 May 2017 17:19:41 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 05 May 2017 16:37:21 +0200
Message-ID: <149399504137.29022.4985100698645275511.stgit@bahia.lan>
In-Reply-To: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
References: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 3/5] 9pfs: local: simplify file opening
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?L=C3=A9o?= Gaspard <leo@gaspard.io>, Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>

All paths in the virtfs directory now start with "./" (except the virtfs
root itself which is exactly ".").

We hence don't need to skip leading '/' characters anymore, nor to handle
the empty path case. Also, since virtfs will only ever be supported on
linux+glibc hosts, we can use strchrnul() and come up with a much simplier
code to walk through the path elements. And we don't need to dup() the
passed directory fd.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |    5 -----
 hw/9pfs/9p-util.c  |   26 ++++++++++----------------
 2 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 92262f3c3e37..bb6e296df317 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -54,11 +54,6 @@ int local_open_nofollow(FsContext *fs_ctx, const char *path, int flags,
 {
     LocalData *data = fs_ctx->private;
 
-    /* All paths are relative to the path data->mountfd points to */
-    while (*path == '/') {
-        path++;
-    }
-
     return relative_openat_nofollow(data->mountfd, path, flags, mode);
 }
 
diff --git a/hw/9pfs/9p-util.c b/hw/9pfs/9p-util.c
index fdb4d5737635..e46399a9119d 100644
--- a/hw/9pfs/9p-util.c
+++ b/hw/9pfs/9p-util.c
@@ -17,14 +17,11 @@
 int relative_openat_nofollow(int dirfd, const char *path, int flags,
                              mode_t mode)
 {
-    int fd;
+    int fd = dirfd;
 
-    fd = dup(dirfd);
-    if (fd == -1) {
-        return -1;
-    }
+    assert(*path);
 
-    while (*path) {
+    while (*path && fd != -1) {
         const char *c;
         int next_fd;
         char *head;
@@ -33,25 +30,22 @@ int relative_openat_nofollow(int dirfd, const char *path, int flags,
         assert(path[0] != '/');
 
         head = g_strdup(path);
-        c = strchr(path, '/');
-        if (c) {
+        c = strchrnul(path, '/');
+        if (*c) {
+            /* Intermediate path element */
             head[c - path] = 0;
+            path = c + 1;
             next_fd = openat_dir(fd, head);
         } else {
+            /* Rightmost path element */
             next_fd = openat_file(fd, head, flags, mode);
+            path = c;
         }
         g_free(head);
-        if (next_fd == -1) {
+        if (dirfd != fd) {
             close_preserve_errno(fd);
-            return -1;
         }
-        close(fd);
         fd = next_fd;
-
-        if (!c) {
-            break;
-        }
-        path = c + 1;
     }
 
     return fd;
