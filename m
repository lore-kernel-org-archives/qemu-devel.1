Received: from eggs.gnu.org ([2001:4830:134:3::10]:33207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d6f0H-0000CX-As
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:18:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d6f0E-0007tw-1O
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:18:45 -0400
Received: from 20.mo5.mail-out.ovh.net ([91.121.55.239]:40029)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d6f0D-0007t4-Rl
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:18:41 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 72958EC728
	for <qemu-devel@nongnu.org>; Fri,  5 May 2017 17:18:40 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 05 May 2017 16:37:12 +0200
Message-ID: <149399503288.29022.13904385823492355197.stgit@bahia.lan>
In-Reply-To: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
References: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 2/5] 9pfs: local: resolve special directories
 in paths
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

When using the mapped-file security mode, the creds of a path /foo/bar
are stored in the /foo/.virtfs_metadata/bar file. This is okay for all
paths unless they end with '.' or '..', because we cannot create the
corresponding file in the metadata directory.

This patch ensures that '.' and '..' are resolved in all paths.

The core code only passes path elements (no '/') to the backend, with
the notable exception of the '/' path, which refers to the virtfs root.
This patch preserve the current behavior of converting it to '.' so
that it can be passed to "*at()" syscalls ('/' would mean the host root).

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index f3ebca4f7a56..92262f3c3e37 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1097,14 +1097,30 @@ static int local_name_to_path(FsContext *ctx, V9fsPath *dir_path,
                               const char *name, V9fsPath *target)
 {
     if (dir_path) {
-        v9fs_path_sprintf(target, "%s/%s", dir_path->data, name);
-    } else if (strcmp(name, "/")) {
-        v9fs_path_sprintf(target, "%s", name);
+        if (!strcmp(name, ".")) {
+            /* "." relative to "foo/bar" is "foo/bar" */
+            v9fs_path_copy(target, dir_path);
+        } else if (!strcmp(name, "..")) {
+            if (!strcmp(dir_path->data, ".")) {
+                /* ".." relative to the root is "." */
+                v9fs_path_sprintf(target, ".");
+            } else {
+                char *tmp = g_path_get_dirname(dir_path->data);
+                /* ".." relative to "foo/bar" is equivalent to "foo" */
+                v9fs_path_sprintf(target, "%s", tmp);
+                g_free(tmp);
+            }
+        } else {
+            assert(!strchr(name, '/'));
+            v9fs_path_sprintf(target, "%s/%s", dir_path->data, name);
+        }
+    } else if (!strcmp(name, "/") || !strcmp(name, ".") ||
+               !strcmp(name, "..")) {
+            /* This is the root fid */
+        v9fs_path_sprintf(target, ".");
     } else {
-        /* We want the path of the export root to be relative, otherwise
-         * "*at()" syscalls would treat it as "/" in the host.
-         */
-        v9fs_path_sprintf(target, "%s", ".");
+        assert(!strchr(name, '/'));
+        v9fs_path_sprintf(target, "./%s", name);
     }
     return 0;
 }
