Received: from eggs.gnu.org ([2001:4830:134:3::10]:60964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORMn-0002Br-0n
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORMm-0008NM-05
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:28 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:21:58 +0200
Message-Id: <1498234919-27316-61-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 60/61] block: Do not strcmp() with NULL
 uri->scheme
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

uri_parse(...)->scheme may be NULL. In fact, probably every field may be
NULL, and the callers do test this for all of the other fields but not
for scheme (except for block/gluster.c; block/vxhs.c does not access
that field at all).

We can easily fix this by using g_strcmp0() instead of strcmp().

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170613205726.13544-1-mreitz@redhat.com
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/nbd.c      | 6 +++---
 block/nfs.c      | 2 +-
 block/sheepdog.c | 6 +++---
 block/ssh.c      | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index e946ea9..d529305 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -64,11 +64,11 @@ static int nbd_parse_uri(const char *filename, QDict *options)
     }
 
     /* transport */
-    if (!strcmp(uri->scheme, "nbd")) {
+    if (!g_strcmp0(uri->scheme, "nbd")) {
         is_unix = false;
-    } else if (!strcmp(uri->scheme, "nbd+tcp")) {
+    } else if (!g_strcmp0(uri->scheme, "nbd+tcp")) {
         is_unix = false;
-    } else if (!strcmp(uri->scheme, "nbd+unix")) {
+    } else if (!g_strcmp0(uri->scheme, "nbd+unix")) {
         is_unix = true;
     } else {
         ret = -EINVAL;
diff --git a/block/nfs.c b/block/nfs.c
index 6b8b5b6..c3c5de0 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -82,7 +82,7 @@ static int nfs_parse_uri(const char *filename, QDict *options, Error **errp)
         error_setg(errp, "Invalid URI specified");
         goto out;
     }
-    if (strcmp(uri->scheme, "nfs") != 0) {
+    if (g_strcmp0(uri->scheme, "nfs") != 0) {
         error_setg(errp, "URI scheme must be 'nfs'");
         goto out;
     }
diff --git a/block/sheepdog.c b/block/sheepdog.c
index a87ee5f..08d7b11 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1046,11 +1046,11 @@ static void sd_parse_uri(SheepdogConfig *cfg, const char *filename,
     }
 
     /* transport */
-    if (!strcmp(uri->scheme, "sheepdog")) {
+    if (!g_strcmp0(uri->scheme, "sheepdog")) {
         is_unix = false;
-    } else if (!strcmp(uri->scheme, "sheepdog+tcp")) {
+    } else if (!g_strcmp0(uri->scheme, "sheepdog+tcp")) {
         is_unix = false;
-    } else if (!strcmp(uri->scheme, "sheepdog+unix")) {
+    } else if (!g_strcmp0(uri->scheme, "sheepdog+unix")) {
         is_unix = true;
     } else {
         error_setg(&err, "URI scheme must be 'sheepdog', 'sheepdog+tcp',"
diff --git a/block/ssh.c b/block/ssh.c
index bac3453..5296441 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -204,7 +204,7 @@ static int parse_uri(const char *filename, QDict *options, Error **errp)
         return -EINVAL;
     }
 
-    if (strcmp(uri->scheme, "ssh") != 0) {
+    if (g_strcmp0(uri->scheme, "ssh") != 0) {
         error_setg(errp, "URI scheme must be 'ssh'");
         goto err;
     }
-- 
1.8.3.1
