Received: from eggs.gnu.org ([2001:4830:134:3::10]:34029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNf6e-00080C-VI
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:51:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNf6e-0005Ck-26
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:51:37 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 21 Jun 2017 14:50:35 +0200
Message-Id: <20170621125047.30294-14-mreitz@redhat.com>
In-Reply-To: <20170621125047.30294-1-mreitz@redhat.com>
References: <20170621125047.30294-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 13/25] block/nbd: Make bdrv_dirname() return
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>

The generic bdrv_dirname() implementation would be able to generate some
form of directory name for many NBD nodes, but it would be always wrong.
Therefore, we have to explicitly make it an error (until NBD has some
form of specification for export paths, if it ever will).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/nbd.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/block/nbd.c b/block/nbd.c
index f91ac63..f896fc4 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -558,6 +558,16 @@ static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
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
@@ -575,6 +585,7 @@ static BlockDriver bdrv_nbd = {
     .bdrv_detach_aio_context    = nbd_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
+    .bdrv_dirname               = nbd_dirname,
 };
 
 static BlockDriver bdrv_nbd_tcp = {
@@ -594,6 +605,7 @@ static BlockDriver bdrv_nbd_tcp = {
     .bdrv_detach_aio_context    = nbd_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
+    .bdrv_dirname               = nbd_dirname,
 };
 
 static BlockDriver bdrv_nbd_unix = {
@@ -613,6 +625,7 @@ static BlockDriver bdrv_nbd_unix = {
     .bdrv_detach_aio_context    = nbd_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
+    .bdrv_dirname               = nbd_dirname,
 };
 
 static void bdrv_nbd_init(void)
-- 
2.9.4
