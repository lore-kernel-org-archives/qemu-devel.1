Received: from eggs.gnu.org ([2001:4830:134:3::10]:47355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dKssb-0005J4-IW
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:57:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dKssa-0005O8-Pl
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:57:37 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 13 Jun 2017 22:57:26 +0200
Message-Id: <20170613205726.13544-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2] block: Do not strcmp() with NULL uri->scheme
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>

uri_parse(...)->scheme may be NULL. In fact, probably every field may be
NULL, and the callers do test this for all of the other fields but not
for scheme (except for block/gluster.c; block/vxhs.c does not access
that field at all).

We can easily fix this by using g_strcmp0() instead of strcmp().

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
v2:
- Fix all affected block drivers, not just nfs [Peter]
- Use g_strcmp0() [Markus]
---
 block/nbd.c      | 6 +++---
 block/nfs.c      | 2 +-
 block/sheepdog.c | 6 +++---
 block/ssh.c      | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 975faab..f91ac63 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -65,11 +65,11 @@ static int nbd_parse_uri(const char *filename, QDict *options)
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
index 848b2c0..fee1f87 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -83,7 +83,7 @@ static int nfs_parse_uri(const char *filename, QDict *options, Error **errp)
         error_setg(errp, "Invalid URI specified");
         goto out;
     }
-    if (strcmp(uri->scheme, "nfs") != 0) {
+    if (g_strcmp0(uri->scheme, "nfs") != 0) {
         error_setg(errp, "URI scheme must be 'nfs'");
         goto out;
     }
diff --git a/block/sheepdog.c b/block/sheepdog.c
index a18315a..2d473e4 100644
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
index 11203fc..27f06ec 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -205,7 +205,7 @@ static int parse_uri(const char *filename, QDict *options, Error **errp)
         return -EINVAL;
     }
 
-    if (strcmp(uri->scheme, "ssh") != 0) {
+    if (g_strcmp0(uri->scheme, "ssh") != 0) {
         error_setg(errp, "URI scheme must be 'ssh'");
         goto err;
     }
-- 
2.9.4
