Received: from eggs.gnu.org ([2001:4830:134:3::10]:57923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fYKU5-0004m4-Vh
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 20:08:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fYKU5-0004Tt-0c
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 20:08:25 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 28 Jun 2018 02:07:30 +0200
Message-Id: <20180628000745.4477-17-mreitz@redhat.com>
In-Reply-To: <20180628000745.4477-1-mreitz@redhat.com>
References: <20180628000745.4477-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v9 16/31] quorum: Make bdrv_dirname() return
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

While the common implementation for bdrv_dirname() should return NULL
for quorum BDSs already (because they do not have a file node and their
exact_filename field should be empty), there is no reason not to make
that explicit.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/quorum.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/quorum.c b/block/quorum.c
index 03388590f3..beec8209d1 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1101,6 +1101,16 @@ static void quorum_refresh_filename(BlockDriverState *bs, QDict *options)
     bs->full_open_options = opts;
 }
 
+static char *quorum_dirname(BlockDriverState *bs, Error **errp)
+{
+    /* In general, there are multiple BDSs with different dirnames below this
+     * one; so there is no unique dirname we could return (unless all are equal
+     * by chance, or there is only one). Therefore, to be consistent, just
+     * always return NULL. */
+    error_setg(errp, "Cannot generate a base directory for quorum nodes");
+    return NULL;
+}
+
 static BlockDriver bdrv_quorum = {
     .format_name                        = "quorum",
 
@@ -1109,6 +1119,7 @@ static BlockDriver bdrv_quorum = {
     .bdrv_open                          = quorum_open,
     .bdrv_close                         = quorum_close,
     .bdrv_refresh_filename              = quorum_refresh_filename,
+    .bdrv_dirname                       = quorum_dirname,
 
     .bdrv_co_flush_to_disk              = quorum_co_flush,
 
-- 
2.17.1
