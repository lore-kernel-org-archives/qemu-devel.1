Received: from eggs.gnu.org ([209.51.188.92]:49401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ggxK6-00039J-IS
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 14:46:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ggxK2-0003dc-JN
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 14:46:00 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  8 Jan 2019 22:45:52 +0300
Message-Id: <20190108194552.45453-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] file-posix: add rough-block-status parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, fam@euphon.net, stefanha@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

bdrv_co_block_status digs bs->file for additional, more accurate search
for hole inside region, reported as DATA by bs since 5daa74a6ebc.

This accuracy is not free: assume we have qcow2 disk. Actually, qcow2
knows, where are holes and where is data. But every block_status
request calls lseek additionally. Assume a big disk, full of
data, in any iterative copying block job (or img convert) we'll call
lseek(HOLE) on every iteration, and each of these lseeks will have to
iterate through all metadata up to the end of file. It's obviously
ineffective behavior. And for many scenarios we don't need this lseek
at all.

So, add an option to omit calling lseek.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

Hi all!

This is a continuation of "do not lseek in qcow2 block_status" thread
(https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg05749.html)

 qapi/block-core.json |  6 +++++-
 block/file-posix.c   | 13 ++++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 762000f31f..ec5549e5c2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2645,6 +2645,9 @@
 #                         migration.  May cause noticeable delays if the image
 #                         file is large, do not use in production.
 #                         (default: off) (since: 3.0)
+# @rough-block-status: If set, on block-status querying assume that the whole
+#                      file is data and do not try to find holes through system
+#                      calls (default: off) (since 4.0)
 #
 # Since: 2.9
 ##
@@ -2653,7 +2656,8 @@
             '*pr-manager': 'str',
             '*locking': 'OnOffAuto',
             '*aio': 'BlockdevAioOptions',
-            '*x-check-cache-dropped': 'bool' } }
+            '*x-check-cache-dropped': 'bool',
+            '*rough-block-status': 'bool' } }
 
 ##
 # @BlockdevOptionsNull:
diff --git a/block/file-posix.c b/block/file-posix.c
index d8f0b93752..3f6d76a5dc 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -167,6 +167,7 @@ typedef struct BDRVRawState {
     bool has_fallocate;
     bool needs_alignment;
     bool check_cache_dropped;
+    bool rough_block_status;
 
     PRManager *pr_mgr;
 } BDRVRawState;
@@ -439,6 +440,13 @@ static QemuOptsList raw_runtime_opts = {
             .type = QEMU_OPT_BOOL,
             .help = "check that page cache was dropped on live migration (default: off)"
         },
+        {
+            .name = "rough-block-status",
+            .type = QEMU_OPT_BOOL,
+            .help = "If set, on block-status querying assume that the whole "
+                    "file is data and do not try to find holes through system "
+                    "calls (default: off)"
+        },
         { /* end of list */ }
     },
 };
@@ -525,6 +533,8 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
 
     s->check_cache_dropped = qemu_opt_get_bool(opts, "x-check-cache-dropped",
                                                false);
+    s->rough_block_status = qemu_opt_get_bool(opts, "rough-block-status",
+                                              false);
 
     s->open_flags = open_flags;
     raw_parse_flags(bdrv_flags, &s->open_flags);
@@ -2424,6 +2434,7 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
                                             int64_t *map,
                                             BlockDriverState **file)
 {
+    BDRVRawState *s = bs->opaque;
     off_t data = 0, hole = 0;
     int ret;
 
@@ -2432,7 +2443,7 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
         return ret;
     }
 
-    if (!want_zero) {
+    if (!want_zero || s->rough_block_status) {
         *pnum = bytes;
         *map = offset;
         *file = bs;
-- 
2.18.0
