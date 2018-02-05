Received: from eggs.gnu.org ([2001:4830:134:3::10]:53557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eiiZZ-0001Nj-Fk
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:20:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eiiZT-0000tA-G2
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:20:45 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  5 Feb 2018 16:18:23 +0100
Message-Id: <20180205151835.20812-15-mreitz@redhat.com>
In-Reply-To: <20180205151835.20812-1-mreitz@redhat.com>
References: <20180205151835.20812-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v8 14/26] block/nbd: Make bdrv_dirname() return
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

The generic bdrv_dirname() implementation would be able to generate some
form of directory name for many NBD nodes, but it would be always wrong.
Therefore, we have to explicitly make it an error (until NBD has some
form of specification for export paths, if it ever will).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/nbd.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/block/nbd.c b/block/nbd.c
index 94220f6d14..dcea7ffaef 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -574,6 +574,16 @@ static int nbd_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
     return 0;
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
@@ -592,6 +602,7 @@ static BlockDriver bdrv_nbd = {
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
     .bdrv_get_info              = nbd_get_info,
+    .bdrv_dirname               = nbd_dirname,
 };
 
 static BlockDriver bdrv_nbd_tcp = {
@@ -612,6 +623,7 @@ static BlockDriver bdrv_nbd_tcp = {
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
     .bdrv_get_info              = nbd_get_info,
+    .bdrv_dirname               = nbd_dirname,
 };
 
 static BlockDriver bdrv_nbd_unix = {
@@ -632,6 +644,7 @@ static BlockDriver bdrv_nbd_unix = {
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
     .bdrv_get_info              = nbd_get_info,
+    .bdrv_dirname               = nbd_dirname,
 };
 
 static void bdrv_nbd_init(void)
-- 
2.14.3
