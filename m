Received: from eggs.gnu.org ([2001:4830:134:3::10]:57938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fYKU6-0004mx-IW
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 20:08:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fYKU5-0004VE-Lg
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 20:08:26 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 28 Jun 2018 02:07:32 +0200
Message-Id: <20180628000745.4477-19-mreitz@redhat.com>
In-Reply-To: <20180628000745.4477-1-mreitz@redhat.com>
References: <20180628000745.4477-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v9 18/31] block/nfs: Implement bdrv_dirname()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

While the basic idea is obvious and could be handled by the default
bdrv_dirname() implementation, we cannot generate a directory name if
the gid or uid are set, so we have to explicitly return NULL in those
cases.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/nfs.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/block/nfs.c b/block/nfs.c
index eab1a2c408..19ee07c321 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -855,6 +855,20 @@ static void nfs_refresh_filename(BlockDriverState *bs, QDict *options)
     bs->full_open_options = opts;
 }
 
+static char *nfs_dirname(BlockDriverState *bs, Error **errp)
+{
+    NFSClient *client = bs->opaque;
+
+    if (client->uid || client->gid) {
+        bdrv_refresh_filename(bs);
+        error_setg(errp, "Cannot generate a base directory for NFS node '%s'",
+                   bs->filename);
+        return NULL;
+    }
+
+    return g_strdup_printf("nfs://%s%s/", client->server->host, client->path);
+}
+
 #ifdef LIBNFS_FEATURE_PAGECACHE
 static void coroutine_fn nfs_co_invalidate_cache(BlockDriverState *bs,
                                                  Error **errp)
@@ -889,6 +903,7 @@ static BlockDriver bdrv_nfs = {
     .bdrv_detach_aio_context        = nfs_detach_aio_context,
     .bdrv_attach_aio_context        = nfs_attach_aio_context,
     .bdrv_refresh_filename          = nfs_refresh_filename,
+    .bdrv_dirname                   = nfs_dirname,
 
 #ifdef LIBNFS_FEATURE_PAGECACHE
     .bdrv_co_invalidate_cache       = nfs_co_invalidate_cache,
-- 
2.17.1
