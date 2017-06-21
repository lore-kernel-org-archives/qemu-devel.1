Received: from eggs.gnu.org ([2001:4830:134:3::10]:34072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNf6g-00082O-OL
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNf6f-0005FN-TC
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:51:38 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 21 Jun 2017 14:50:36 +0200
Message-Id: <20170621125047.30294-15-mreitz@redhat.com>
In-Reply-To: <20170621125047.30294-1-mreitz@redhat.com>
References: <20170621125047.30294-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 14/25] block/nfs: Implement bdrv_dirname()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>

While the basic idea is obvious and could be handled by the default
bdrv_dirname() implementation, we cannot generate a directory name if
the gid or uid are set, so we have to explicitly return NULL in those
cases.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/nfs.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/nfs.c b/block/nfs.c
index fee1f87..976d96f 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -862,6 +862,19 @@ static void nfs_refresh_filename(BlockDriverState *bs, QDict *options)
     bs->full_open_options = opts;
 }
 
+static char *nfs_dirname(BlockDriverState *bs, Error **errp)
+{
+    NFSClient *client = bs->opaque;
+
+    if (client->uid || client->gid) {
+        error_setg(errp, "Cannot generate a base directory for NBD node '%s'",
+                   bs->filename);
+        return NULL;
+    }
+
+    return g_strdup_printf("nfs://%s%s/", client->server->host, client->path);
+}
+
 #ifdef LIBNFS_FEATURE_PAGECACHE
 static void nfs_invalidate_cache(BlockDriverState *bs,
                                  Error **errp)
@@ -895,6 +908,7 @@ static BlockDriver bdrv_nfs = {
     .bdrv_detach_aio_context        = nfs_detach_aio_context,
     .bdrv_attach_aio_context        = nfs_attach_aio_context,
     .bdrv_refresh_filename          = nfs_refresh_filename,
+    .bdrv_dirname                   = nfs_dirname,
 
 #ifdef LIBNFS_FEATURE_PAGECACHE
     .bdrv_invalidate_cache          = nfs_invalidate_cache,
-- 
2.9.4
