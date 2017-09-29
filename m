Received: from eggs.gnu.org ([2001:4830:134:3::10]:47313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxyZr-00029X-K3
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 12:55:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxyZq-00045Z-OF
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 12:55:51 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 29 Sep 2017 18:53:36 +0200
Message-Id: <20170929165347.29658-15-mreitz@redhat.com>
In-Reply-To: <20170929165347.29658-1-mreitz@redhat.com>
References: <20170929165347.29658-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v6 14/25] block/nfs: Implement bdrv_dirname()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>
List-ID: <qemu-devel.nongnu.org>

While the basic idea is obvious and could be handled by the default
bdrv_dirname() implementation, we cannot generate a directory name if
the gid or uid are set, so we have to explicitly return NULL in those
cases.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/nfs.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/nfs.c b/block/nfs.c
index 337fcd9c84..0152a9bd32 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -875,6 +875,19 @@ static void nfs_refresh_filename(BlockDriverState *bs, QDict *options)
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
@@ -908,6 +921,7 @@ static BlockDriver bdrv_nfs = {
     .bdrv_detach_aio_context        = nfs_detach_aio_context,
     .bdrv_attach_aio_context        = nfs_attach_aio_context,
     .bdrv_refresh_filename          = nfs_refresh_filename,
+    .bdrv_dirname                   = nfs_dirname,
 
 #ifdef LIBNFS_FEATURE_PAGECACHE
     .bdrv_invalidate_cache          = nfs_invalidate_cache,
-- 
2.13.6
