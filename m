Received: from eggs.gnu.org ([2001:4830:134:3::10]:57213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g8Zii-0003R4-Ic
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 19:41:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g8Zih-00007v-J3
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 19:41:20 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Sat,  6 Oct 2018 01:40:08 +0200
Message-Id: <20181005234023.8104-17-mreitz@redhat.com>
In-Reply-To: <20181005234023.8104-1-mreitz@redhat.com>
References: <20181005234023.8104-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v11 16/31] quorum: Make bdrv_dirname() return
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

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
index b14e9c6ec6..f831f84fd1 100644
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
