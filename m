Received: from eggs.gnu.org ([2001:4830:134:3::10]:49390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cT9v5-0006Z5-NS
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:14:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cT9v4-0001QX-Ey
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:14:07 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 16 Jan 2017 17:13:53 +0100
Message-Id: <20170116161354.8011-2-mreitz@redhat.com>
In-Reply-To: <20170113205237.30386-1-mreitz@redhat.com>
References: <20170113205237.30386-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v6 8/9] block: Complete move to pull filename
 updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

Before this patch series, filename were updates in a push model: Every
change to the BDS graph required bdrv_refresh_filename() to be called.
This patch completes the transition to a pull model: Every time a
filename is queried, the caller has to take responsibility that the new
filename is up-to-date.

In the case of bdrv_filename(), this is done automatically through the
call of bdrv_refresh_filename(). However, some places bypass that
function and query the BDS fields full_open_options and exact_filename
instead. For this case, this patch establishes rules on when such an
access requires a call to bdrv_refresh_filename() beforehand.

There are two places in the block layer that do require such a call
before they access a BDS's exact_filename, so add it there and drop it
in places that just called it because they followed the push model.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h | 12 ++++++++++++
 block.c                   |  4 +---
 block/replication.c       |  2 --
 block/vmdk.c              |  2 ++
 blockdev.c                |  1 -
 5 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 83c7c4e5d9..a3501a1163 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -471,7 +471,19 @@ struct BlockDriverState {
     char backing_format[16]; /* if non-zero and backing_file exists */
     bool backing_overridden; /* backing file has been specified by the user */
 
+    /* Before reading this field, bdrv_refresh_filename() should be called.
+     * For BlockDriver.bdrv_refresh_filename() and .bdrv_gather_child_options()
+     * implementations, this has already been done both for the respective BDS
+     * and recursively for all of its children. */
     QDict *full_open_options;
+
+    /* Before reading this field, bdrv_refresh_filename() should be called.
+     * For BlockDriver.bdrv_refresh_filename() implementations, this has already
+     * been done recursively for all of the respective BDS's children.
+     * Protocol drivers are generally free to access this field without a prior
+     * bdrv_refresh_filename() call because it will not be changed by the block
+     * layer from its initial value unless the protocol driver in question
+     * implements BlockDriver.bdrv_refresh_filename(). */
     char exact_filename[PATH_MAX];
 
     char *dirname;
diff --git a/block.c b/block.c
index 58f7575d4f..64e07aebd5 100644
--- a/block.c
+++ b/block.c
@@ -1735,7 +1735,6 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
     bdrv_append(bs_snapshot, bs);
 
     bs_snapshot->backing_overridden = true;
-    bdrv_refresh_filename(bs_snapshot);
 
     g_free(tmp_filename);
     return bs_snapshot;
@@ -1927,8 +1926,6 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
         }
     }
 
-    bdrv_refresh_filename(bs);
-
     /* Check if any unknown options were used */
     if (options && (qdict_size(options) != 0)) {
         const QDictEntry *entry = qdict_first(options);
@@ -4257,6 +4254,7 @@ char *bdrv_dirname(BlockDriverState *bs, Error **errp)
         return bdrv_dirname(bs->file->bs, errp);
     }
 
+    bdrv_refresh_filename(bs);
     if (bs->exact_filename[0] != '\0') {
         return path_combine(bs->exact_filename, "");
     }
diff --git a/block/replication.c b/block/replication.c
index 729dd12499..b64540e670 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -585,8 +585,6 @@ static void replication_done(void *opaque, int ret)
     if (ret == 0) {
         s->replication_state = BLOCK_REPLICATION_DONE;
 
-        /* refresh top bs's filename */
-        bdrv_refresh_filename(bs);
         s->active_disk = NULL;
         s->secondary_disk = NULL;
         s->hidden_disk = NULL;
diff --git a/block/vmdk.c b/block/vmdk.c
index c1100b9cb9..f3cd2310c0 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -937,6 +937,8 @@ static int vmdk_open_desc_file(BlockDriverState *bs, int flags, char *buf,
     }
     s->create_type = g_strdup(ct);
     s->desc_offset = 0;
+
+    bdrv_refresh_filename(bs->file->bs);
     ret = vmdk_parse_extents(buf, bs, bs->file->bs->exact_filename, options,
                              errp);
 exit:
diff --git a/blockdev.c b/blockdev.c
index 6f0d3957bb..f2210c0021 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1803,7 +1803,6 @@ static void external_snapshot_commit(BlkActionState *common)
 
     if (image_was_existing) {
         state->new_bs->backing_overridden = true;
-        bdrv_refresh_filename(state->new_bs);
     }
 }
 
-- 
2.11.0
