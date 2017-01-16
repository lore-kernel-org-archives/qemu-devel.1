Received: from eggs.gnu.org ([2001:4830:134:3::10]:45648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTEDk-0000rQ-Hq
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:49:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTEDj-0003nF-Na
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:49:40 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 16 Jan 2017 21:49:09 +0100
Message-Id: <20170116204921.31578-6-mreitz@redhat.com>
In-Reply-To: <20170111181432.18868-1-mreitz@redhat.com>
References: <20170111181432.18868-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 13/25] block/nbd: Implement bdrv_dirname()
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

The idea behind this implementation is that the export name might be
interpreted as a path (which is the only apparent interpretation of
relative filenames for NBD paths).

The default implementation of bdrv_dirname() would handle that just fine
for nbd+tcp, but not for nbd+unix, because in that case, the last
element of the path is the Unix socket path and not the export name.
Therefore, we need to implement an own bdrv_dirname() which uses the
legacy NBD URL which has the export name at the end.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/nbd.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/block/nbd.c b/block/nbd.c
index 35f24be069..42f0cd638c 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -552,6 +552,34 @@ static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
     bs->full_open_options = opts;
 }
 
+static char *nbd_dirname(BlockDriverState *bs, Error **errp)
+{
+    BDRVNBDState *s = bs->opaque;
+    const char *host = NULL, *port = NULL, *path = NULL;
+
+    if (s->saddr->type == SOCKET_ADDRESS_KIND_INET) {
+        const InetSocketAddress *inet = s->saddr->u.inet.data;
+        if (!inet->has_ipv4 && !inet->has_ipv6 && !inet->has_to) {
+            host = inet->host;
+            port = inet->port;
+        }
+    } else if (s->saddr->type == SOCKET_ADDRESS_KIND_UNIX) {
+        path = s->saddr->u.q_unix.data->path;
+    }
+
+    if (path) {
+        return g_strdup_printf("nbd:unix:%s:exportname=%s%s", path,
+                               s->export ?: "", s->export ? "/" : "");
+    } else if (host) {
+        return g_strdup_printf("nbd://%s:%s/%s%s", host, port,
+                               s->export ?: "", s->export ? "/" : "");
+    }
+
+    error_setg(errp, "Cannot generate a base directory for NBD node '%s'",
+               bs->filename);
+    return NULL;
+}
+
 static BlockDriver bdrv_nbd = {
     .format_name                = "nbd",
     .protocol_name              = "nbd",
@@ -569,6 +597,7 @@ static BlockDriver bdrv_nbd = {
     .bdrv_detach_aio_context    = nbd_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
+    .bdrv_dirname               = nbd_dirname,
 };
 
 static BlockDriver bdrv_nbd_tcp = {
@@ -588,6 +617,7 @@ static BlockDriver bdrv_nbd_tcp = {
     .bdrv_detach_aio_context    = nbd_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
+    .bdrv_dirname               = nbd_dirname,
 };
 
 static BlockDriver bdrv_nbd_unix = {
@@ -607,6 +637,7 @@ static BlockDriver bdrv_nbd_unix = {
     .bdrv_detach_aio_context    = nbd_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
+    .bdrv_dirname               = nbd_dirname,
 };
 
 static void bdrv_nbd_init(void)
-- 
2.11.0
