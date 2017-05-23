Received: from eggs.gnu.org ([2001:4830:134:3::10]:46395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dDArX-0002nv-JF
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:32:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dDArT-00088J-G8
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:32:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51932
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dDArT-00087R-AL
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:32:35 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4NETvMa085409
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 10:32:34 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2am85fdg0r-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 10:32:34 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 23 May 2017 08:32:33 -0600
From: Greg Kurz <groug@kaod.org>
Date: Tue, 23 May 2017 16:32:29 +0200
In-Reply-To: <149554993519.23396.2947622015408783770.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <149554993519.23396.2947622015408783770.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <149554994914.23396.9158086745678389330.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH v2 2/4] 9pfs: local: resolve special
 directories in paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Leo Gaspard <leo@gaspard.io>, Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>

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
---
v2: - grammatical fix in the changelog
    - updated comment to mention that symlink resolution happens in the
      client
---
 hw/9pfs/9p-local.c |   32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index a2486566afb7..4da77ef1bc35 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1138,14 +1138,32 @@ static int local_name_to_path(FsContext *ctx, V9fsPath *dir_path,
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
