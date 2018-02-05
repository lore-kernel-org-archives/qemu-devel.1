Received: from eggs.gnu.org ([2001:4830:134:3::10]:34742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1einHs-0004vB-Is
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 15:22:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1einHp-000709-Qq
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 15:22:48 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  5 Feb 2018 21:22:32 +0100
Message-Id: <20180205202232.19254-3-mreitz@redhat.com>
In-Reply-To: <20180205202232.19254-1-mreitz@redhat.com>
References: <20180205202232.19254-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] block/ssh: Implement .bdrv_dirname()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, "Richard W . M . Jones" <rjones@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>

ssh_bdrv_dirname() is basically the generic bdrv_dirname(), except it
takes care not to silently chop off any query string (i.e.,
host_key_check).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/ssh.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/block/ssh.c b/block/ssh.c
index a5b7e831a4..7dbe55cec1 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -1194,6 +1194,24 @@ static void ssh_refresh_filename(BlockDriverState *bs)
     }
 }
 
+static char *ssh_bdrv_dirname(BlockDriverState *bs, Error **errp)
+{
+    if (qdict_haskey(bs->full_open_options, "host_key_check")) {
+        /* We cannot generate a simple prefix if we would have to
+         * append a query string */
+        error_setg(errp,
+                   "Cannot generate a base directory with host_key_check set");
+        return NULL;
+    }
+
+    if (bs->exact_filename[0] == '\0') {
+        error_setg(errp, "Cannot generate a base directory for this ssh node");
+        return NULL;
+    }
+
+    return path_combine(bs->exact_filename, "");
+}
+
 static const char *const ssh_sgfnt_runtime_opts[] = {
     "host",
     "port",
@@ -1219,6 +1237,7 @@ static BlockDriver bdrv_ssh = {
     .bdrv_getlength               = ssh_getlength,
     .bdrv_co_flush_to_disk        = ssh_co_flush,
     .bdrv_refresh_filename        = ssh_refresh_filename,
+    .bdrv_dirname                 = ssh_bdrv_dirname,
     .create_opts                  = &ssh_create_opts,
     .sgfnt_runtime_opts           = ssh_sgfnt_runtime_opts,
 };
-- 
2.14.3
