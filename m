Received: from eggs.gnu.org ([2001:4830:134:3::10]:42933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsbM-0002hZ-69
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:36:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsbL-0008Hh-9B
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:36:12 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu,  9 Aug 2018 23:35:14 +0200
Message-Id: <20180809213528.14738-18-mreitz@redhat.com>
In-Reply-To: <20180809213528.14738-1-mreitz@redhat.com>
References: <20180809213528.14738-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1 v10 17/31] block/nbd: Make
 bdrv_dirname() return NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>

The generic bdrv_dirname() implementation would be able to generate some
form of directory name for many NBD nodes, but it would be always wrong.
Therefore, we have to explicitly make it an error (until NBD has some
form of specification for export paths, if it ever will).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/block/nbd.c b/block/nbd.c
index e87699fb73..bca127c8f5 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -564,6 +564,16 @@ static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
     bs->full_open_options = opts;
 }
 
+static char *nbd_dirname(BlockDriverState *bs, Error **errp)
+{
+    /* The generic bdrv_dirname() implementation is able to work out some
+     * directory name for NBD nodes, but that would be wrong. So far there is no
+     * specification for how "export paths" would work, so NBD does not have
+     * directory names. */
+    error_setg(errp, "Cannot generate a base directory for NBD nodes");
+    return NULL;
+}
+
 static BlockDriver bdrv_nbd = {
     .format_name                = "nbd",
     .protocol_name              = "nbd",
@@ -582,6 +592,7 @@ static BlockDriver bdrv_nbd = {
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
     .bdrv_co_block_status       = nbd_client_co_block_status,
+    .bdrv_dirname               = nbd_dirname,
 };
 
 static BlockDriver bdrv_nbd_tcp = {
@@ -602,6 +613,7 @@ static BlockDriver bdrv_nbd_tcp = {
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
     .bdrv_co_block_status       = nbd_client_co_block_status,
+    .bdrv_dirname               = nbd_dirname,
 };
 
 static BlockDriver bdrv_nbd_unix = {
@@ -622,6 +634,7 @@ static BlockDriver bdrv_nbd_unix = {
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
     .bdrv_co_block_status       = nbd_client_co_block_status,
+    .bdrv_dirname               = nbd_dirname,
 };
 
 static void bdrv_nbd_init(void)
-- 
2.17.1
