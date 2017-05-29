Received: from eggs.gnu.org ([2001:4830:134:3::10]:36208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFGcv-0001iB-VP
	for qemu-devel@nongnu.org; Mon, 29 May 2017 05:06:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFGcr-0006Ew-Vk
	for qemu-devel@nongnu.org; Mon, 29 May 2017 05:06:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54652
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dFGcr-0006Ed-Qk
	for qemu-devel@nongnu.org; Mon, 29 May 2017 05:06:09 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4T94DDX011442
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 05:06:09 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2aqn3fwkyf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 05:06:09 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 29 May 2017 10:06:07 +0100
From: Greg Kurz <groug@kaod.org>
Date: Mon, 29 May 2017 11:05:38 +0200
In-Reply-To: <1496048740-26578-1-git-send-email-groug@kaod.org>
References: <1496048740-26578-1-git-send-email-groug@kaod.org>
Message-Id: <1496048740-26578-10-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 09/11] 9pfs: local: resolve special directories
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Greg Kurz <groug@kaod.org>

When using the mapped-file security mode, the creds of a path /foo/bar
are stored in the /foo/.virtfs_metadata/bar file. This is okay for all
paths unless they end with '.' or '..', because we cannot create the
corresponding file in the metadata directory.

This patch ensures that '.' and '..' are resolved in all paths.

The core code only passes path elements (no '/') to the backend, with
the notable exception of the '/' path, which refers to the virtfs root.
This patch preserves the current behavior of converting it to '.' so
that it can be passed to "*at()" syscalls ('/' would mean the host root).

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 hw/9pfs/9p-local.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 226234d38642..68e92652ed73 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1134,14 +1134,32 @@ static int local_name_to_path(FsContext *ctx, V9fsPath *dir_path,
     }
 
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
+                /* Symbolic links are resolved by the client. We can assume
+                 * that ".." relative to "foo/bar" is equivalent to "foo"
+                 */
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
-- 
2.7.4
