Received: from eggs.gnu.org ([2001:4830:134:3::10]:48765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCn-0001fP-SJ
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCk-000644-Lc
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38913
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCk-00062v-Ev
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:30 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0EWxq065758
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:30 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cmq0jb031-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:29 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 20:16:29 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:39 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-65-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 64/79] block: Do not strcmp() with NULL
 uri->scheme
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>

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
(cherry picked from commit f69165a8feca055cf4a37d13ab0fc5beec3cb372)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/nbd.c      | 6 +++---
 block/nfs.c      | 2 +-
 block/sheepdog.c | 6 +++---
 block/ssh.c      | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index b3545f5..9a54edf 100644
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
index bfeebc1..344186f 100644
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
index fb9203e..2d8d8c8 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1052,11 +1052,11 @@ static void sd_parse_uri(SheepdogConfig *cfg, const char *filename,
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
index 34a2f79..139b05d 100644
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
2.7.4
