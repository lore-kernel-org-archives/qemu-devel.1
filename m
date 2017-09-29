Received: from eggs.gnu.org ([2001:4830:134:3::10]:47266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxyZk-00021m-PP
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 12:55:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxyZk-00040y-16
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 12:55:44 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 29 Sep 2017 18:53:35 +0200
Message-Id: <20170929165347.29658-14-mreitz@redhat.com>
In-Reply-To: <20170929165347.29658-1-mreitz@redhat.com>
References: <20170929165347.29658-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v6 13/25] block/nbd: Make bdrv_dirname() return
 NULL
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

The generic bdrv_dirname() implementation would be able to generate some
form of directory name for many NBD nodes, but it would be always wrong.
Therefore, we have to explicitly make it an error (until NBD has some
form of specification for export paths, if it ever will).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/nbd.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/block/nbd.c b/block/nbd.c
index a50d24b50a..ed921fa333 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -565,6 +565,16 @@ static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
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
     .bdrv_detach_aio_context    = nbd_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
+    .bdrv_dirname               = nbd_dirname,
 };
 
 static BlockDriver bdrv_nbd_tcp = {
@@ -601,6 +612,7 @@ static BlockDriver bdrv_nbd_tcp = {
     .bdrv_detach_aio_context    = nbd_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
+    .bdrv_dirname               = nbd_dirname,
 };
 
 static BlockDriver bdrv_nbd_unix = {
@@ -620,6 +632,7 @@ static BlockDriver bdrv_nbd_unix = {
     .bdrv_detach_aio_context    = nbd_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
+    .bdrv_dirname               = nbd_dirname,
 };
 
 static void bdrv_nbd_init(void)
-- 
2.13.6
