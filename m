Received: from eggs.gnu.org ([2001:4830:134:3::10]:53350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eiiZ7-000108-W0
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:20:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eiiZ5-0008NI-9V
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:20:17 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  5 Feb 2018 16:18:21 +0100
Message-Id: <20180205151835.20812-13-mreitz@redhat.com>
In-Reply-To: <20180205151835.20812-1-mreitz@redhat.com>
References: <20180205151835.20812-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v8 12/26] blkverify: Make bdrv_dirname() return
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

blkverify's BDSs have a file BDS, but we do not want this to be
preferred over the raw node. There is no way to decide between the two
(and not really a reason to, either), so just return NULL in blkverify's
implementation of bdrv_dirname().

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/blkverify.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/blkverify.c b/block/blkverify.c
index b2ed8cd70d..d5233eeaf9 100644
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
@@ -320,6 +329,7 @@ static BlockDriver bdrv_blkverify = {
     .bdrv_child_perm                  = bdrv_filter_default_perms,
     .bdrv_getlength                   = blkverify_getlength,
     .bdrv_refresh_filename            = blkverify_refresh_filename,
+    .bdrv_dirname                     = blkverify_dirname,
 
     .bdrv_co_preadv                   = blkverify_co_preadv,
     .bdrv_co_pwritev                  = blkverify_co_pwritev,
-- 
2.14.3
