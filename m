Received: from eggs.gnu.org ([2001:4830:134:3::10]:45599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTEDh-0000oR-J5
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:49:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTEDe-0003m6-JT
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:49:37 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 16 Jan 2017 21:49:07 +0100
Message-Id: <20170116204921.31578-4-mreitz@redhat.com>
In-Reply-To: <20170111181432.18868-1-mreitz@redhat.com>
References: <20170111181432.18868-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 11/25] blkverify: Make bdrv_dirname() return
 NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

blkverify's BDSs have a file BDS, but we do not want this to be
preferred over the raw node. There is no way to decide between the two
(and not really a reason to, either), so just return NULL in blkverify's
implementation of bdrv_dirname().

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/blkverify.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/blkverify.c b/block/blkverify.c
index 38a8c68029..c72a1fba64 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -309,6 +309,15 @@ static void blkverify_refresh_filename(BlockDriverState *bs, QDict *options)
     }
 }
 
+static char *blkverify_dirname(BlockDriverState *bs, Error **errp)
+{
+    /* In general, there are two BDSs with different dirnames below this one;
+     * so there is no unique dirname we could return (unless both are equal by
+     * chance). Therefore, to be consistent, just always return NULL. */
+    error_setg(errp, "Cannot generate a base directory for blkverify nodes");
+    return NULL;
+}
+
 static BlockDriver bdrv_blkverify = {
     .format_name                      = "blkverify",
     .protocol_name                    = "blkverify",
@@ -319,6 +328,7 @@ static BlockDriver bdrv_blkverify = {
     .bdrv_close                       = blkverify_close,
     .bdrv_getlength                   = blkverify_getlength,
     .bdrv_refresh_filename            = blkverify_refresh_filename,
+    .bdrv_dirname                     = blkverify_dirname,
 
     .bdrv_co_preadv                   = blkverify_co_preadv,
     .bdrv_co_pwritev                  = blkverify_co_pwritev,
-- 
2.11.0
