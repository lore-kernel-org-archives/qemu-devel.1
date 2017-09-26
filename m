Received: from eggs.gnu.org ([2001:4830:134:3::10]:55601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dwdUj-0002wE-L6
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 20:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dwdUf-0005cp-HR
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 20:13:01 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 25 Sep 2017 17:08:55 -0700
Message-ID: <32420d254357de5d661b1af400b27924cbd71282.1506384414.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1506384414.git.alistair.francis@xilinx.com>
References: <cover.1506384414.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 4/8] block: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, Stefan Weil <sw@weilnetz.de>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Alberto Garcia <berto@igalia.com>, "Richard W.M. Jones" <rjones@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: Stefan Weil <sw@weilnetz.de>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>
Cc: Alberto Garcia <berto@igalia.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Jeff Cody <jcody@redhat.com>
Cc: qemu-block@nongnu.org
---

 block/file-posix.c     |  6 +--
 block/file-win32.c     |  3 +-
 block/linux-aio.c      |  5 ++-
 block/parallels.c      |  7 ++--
 block/qcow2-cluster.c  |  2 +-
 block/qcow2-refcount.c | 95 ++++++++++++++++++++++++------------------------
 block/qcow2.c          |  8 ++--
 block/quorum.c         |  5 ++-
 block/ssh.c            |  4 +-
 block/vdi.c            | 14 ++++---
 block/vpc.c            |  5 ++-
 block/vvfat.c          | 99 ++++++++++++++++++++++++++++----------------------
 12 files changed, 136 insertions(+), 117 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index ab12a2b591..2ea7a689cd 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -198,7 +198,7 @@ static int raw_normalize_devicepath(const char **filename)
     fname = *filename;
     dp = strrchr(fname, '/');
     if (lstat(fname, &sb) < 0) {
-        fprintf(stderr, "%s: stat failed: %s\n",
+        error_report("%s: stat failed: %s",
             fname, strerror(errno));
         return -errno;
     }
@@ -215,7 +215,7 @@ static int raw_normalize_devicepath(const char **filename)
     }
     fprintf(stderr, "%s is a block device", fname);
     *filename = namebuf;
-    fprintf(stderr, ", using %s\n", *filename);
+    error_report(", using %s", *filename);
 
     return 0;
 }
@@ -1499,7 +1499,7 @@ static int aio_worker(void *arg)
         ret = handle_aiocb_write_zeroes(aiocb);
         break;
     default:
-        fprintf(stderr, "invalid aio request (0x%x)\n", aiocb->aio_type);
+        error_report("invalid aio request (0x%x)", aiocb->aio_type);
         ret = -EINVAL;
         break;
     }
diff --git a/block/file-win32.c b/block/file-win32.c
index 9e02214a69..a2ed9d2e55 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "block/block_int.h"
@@ -131,7 +132,7 @@ static int aio_worker(void *arg)
         }
         break;
     default:
-        fprintf(stderr, "invalid aio request (0x%x)\n", aiocb->aio_type);
+        error_report("invalid aio request (0x%x)", aiocb->aio_type);
         ret = -EINVAL;
         break;
     }
diff --git a/block/linux-aio.c b/block/linux-aio.c
index 88b8d55ec7..435c2ae47e 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -8,6 +8,7 @@
  * See the COPYING file in the top-level directory.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "block/aio.h"
 #include "qemu/queue.h"
@@ -389,7 +390,7 @@ static int laio_do_submit(int fd, struct qemu_laiocb *laiocb, off_t offset,
 	break;
     /* Currently Linux kernel does not support other operations */
     default:
-        fprintf(stderr, "%s: invalid AIO request type 0x%x.\n",
+        error_report("%s: invalid AIO request type 0x%x.",
                         __func__, type);
         return -EIO;
     }
@@ -499,7 +500,7 @@ void laio_cleanup(LinuxAioState *s)
     event_notifier_cleanup(&s->e);
 
     if (io_destroy(s->ctx) != 0) {
-        fprintf(stderr, "%s: destroy AIO context %p failed\n",
+        error_report("%s: destroy AIO context %p failed",
                         __func__, &s->ctx);
     }
     g_free(s);
diff --git a/block/parallels.c b/block/parallels.c
index 2b6c6e5709..30056f943a 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -28,6 +28,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "block/block_int.h"
@@ -397,7 +398,7 @@ static int parallels_check(BlockDriverState *bs, BdrvCheckResult *res,
     }
 
     if (s->header_unclean) {
-        fprintf(stderr, "%s image was not closed correctly\n",
+        error_report("%s image was not closed correctly",
                 fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR");
         res->corruptions++;
         if (fix & BDRV_FIX_ERRORS) {
@@ -421,7 +422,7 @@ static int parallels_check(BlockDriverState *bs, BdrvCheckResult *res,
 
         /* cluster outside the image */
         if (off > size) {
-            fprintf(stderr, "%s cluster %u is outside image\n",
+            error_report("%s cluster %u is outside image",
                     fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR", i);
             res->corruptions++;
             if (fix & BDRV_FIX_ERRORS) {
@@ -456,7 +457,7 @@ static int parallels_check(BlockDriverState *bs, BdrvCheckResult *res,
     if (size > res->image_end_offset) {
         int64_t count;
         count = DIV_ROUND_UP(size - res->image_end_offset, cluster_size);
-        fprintf(stderr, "%s space leaked at the end of the image %" PRId64 "\n",
+        error_report("%s space leaked at the end of the image %" PRId64 "",
                 fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
                 size - res->image_end_offset);
         res->leaks += count;
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 0d4824993c..894f57b4f9 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -71,7 +71,7 @@ int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
     }
 
 #ifdef DEBUG_ALLOC2
-    fprintf(stderr, "grow l1_table from %d to %" PRId64 "\n",
+    error_report("grow l1_table from %d to %" PRId64 "",
             s->l1_size, new_l1_size);
 #endif
 
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 168fc32e7b..2a8d1210c8 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "block/block_int.h"
@@ -367,8 +368,8 @@ static int alloc_refcount_block(BlockDriverState *bs,
     }
 
 #ifdef DEBUG_ALLOC2
-    fprintf(stderr, "qcow2: Allocate refcount block %d for %" PRIx64
-        " at %" PRIx64 "\n",
+    error_report("qcow2: Allocate refcount block %d for %" PRIx64
+        " at %" PRIx64 "",
         refcount_table_index, cluster_index << s->cluster_bits, new_block);
 #endif
 
@@ -800,8 +801,8 @@ static int QEMU_WARN_UNUSED_RESULT update_refcount(BlockDriverState *bs,
     int ret;
 
 #ifdef DEBUG_ALLOC2
-    fprintf(stderr, "update_refcount: offset=%" PRId64 " size=%" PRId64
-            " addend=%s%" PRIu64 "\n", offset, length, decrease ? "-" : "",
+    error_report("update_refcount: offset=%" PRId64 " size=%" PRId64
+            " addend=%s%" PRIu64 "", offset, length, decrease ? "-" : "",
             addend);
 #endif
     if (length < 0) {
@@ -957,7 +958,7 @@ retry:
     }
 
 #ifdef DEBUG_ALLOC2
-    fprintf(stderr, "alloc_clusters: size=%" PRId64 " -> %" PRId64 "\n",
+    error_report("alloc_clusters: size=%" PRId64 " -> %" PRId64 "",
             size,
             (s->free_cluster_index - nb_clusters) << s->cluster_bits);
 #endif
@@ -1097,7 +1098,7 @@ void qcow2_free_clusters(BlockDriverState *bs,
     BLKDBG_EVENT(bs->file, BLKDBG_CLUSTER_FREE);
     ret = update_refcount(bs, offset, size, 1, true, type);
     if (ret < 0) {
-        fprintf(stderr, "qcow2_free_clusters failed: %s\n", strerror(-ret));
+        error_report("qcow2_free_clusters failed: %s", strerror(-ret));
         /* TODO Remember the clusters to free them later and avoid leaking */
     }
 }
@@ -1447,11 +1448,11 @@ int qcow2_inc_refcounts_imrt(BlockDriverState *bs, BdrvCheckResult *res,
 
         refcount = s->get_refcount(*refcount_table, k);
         if (refcount == s->refcount_max) {
-            fprintf(stderr, "ERROR: overflow cluster offset=0x%" PRIx64
-                    "\n", cluster_offset);
-            fprintf(stderr, "Use qemu-img amend to increase the refcount entry "
+            error_report("ERROR: overflow cluster offset=0x%" PRIx64
+                    "", cluster_offset);
+            error_report("Use qemu-img amend to increase the refcount entry "
                     "width or qemu-img convert to create a clean copy if the "
-                    "image cannot be opened for writing\n");
+                    "image cannot be opened for writing");
             res->corruptions++;
             continue;
         }
@@ -1490,7 +1491,7 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
 
     ret = bdrv_pread(bs->file, l2_offset, l2_table, l2_size);
     if (ret < 0) {
-        fprintf(stderr, "ERROR: I/O error in check_refcounts_l2\n");
+        error_report("ERROR: I/O error in check_refcounts_l2");
         res->check_errors++;
         goto fail;
     }
@@ -1503,9 +1504,9 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
         case QCOW2_CLUSTER_COMPRESSED:
             /* Compressed clusters don't have QCOW_OFLAG_COPIED */
             if (l2_entry & QCOW_OFLAG_COPIED) {
-                fprintf(stderr, "ERROR: cluster %" PRId64 ": "
+                error_report("ERROR: cluster %" PRId64 ": "
                     "copied flag must never be set for compressed "
-                    "clusters\n", l2_entry >> s->cluster_bits);
+                    "clusters", l2_entry >> s->cluster_bits);
                 l2_entry &= ~QCOW_OFLAG_COPIED;
                 res->corruptions++;
             }
@@ -1558,8 +1559,8 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
 
             /* Correct offsets are cluster aligned */
             if (offset_into_cluster(s, offset)) {
-                fprintf(stderr, "ERROR offset=%" PRIx64 ": Cluster is not "
-                    "properly aligned; L2 entry corrupted.\n", offset);
+                error_report("ERROR offset=%" PRIx64 ": Cluster is not "
+                    "properly aligned; L2 entry corrupted.", offset);
                 res->corruptions++;
             }
             break;
@@ -1620,7 +1621,7 @@ static int check_refcounts_l1(BlockDriverState *bs,
         }
         ret = bdrv_pread(bs->file, l1_table_offset, l1_table, l1_size2);
         if (ret < 0) {
-            fprintf(stderr, "ERROR: I/O error in check_refcounts_l1\n");
+            error_report("ERROR: I/O error in check_refcounts_l1");
             res->check_errors++;
             goto fail;
         }
@@ -1643,8 +1644,8 @@ static int check_refcounts_l1(BlockDriverState *bs,
 
             /* L2 tables are cluster aligned */
             if (offset_into_cluster(s, l2_offset)) {
-                fprintf(stderr, "ERROR l2_offset=%" PRIx64 ": Table is not "
-                    "cluster aligned; L1 entry corrupted\n", l2_offset);
+                error_report("ERROR l2_offset=%" PRIx64 ": Table is not "
+                    "cluster aligned; L1 entry corrupted", l2_offset);
                 res->corruptions++;
             }
 
@@ -1697,8 +1698,8 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
             continue;
         }
         if ((refcount == 1) != ((l1_entry & QCOW_OFLAG_COPIED) != 0)) {
-            fprintf(stderr, "%s OFLAG_COPIED L2 cluster: l1_index=%d "
-                    "l1_entry=%" PRIx64 " refcount=%" PRIu64 "\n",
+            error_report("%s OFLAG_COPIED L2 cluster: l1_index=%d "
+                    "l1_entry=%" PRIx64 " refcount=%" PRIu64 "",
                     fix & BDRV_FIX_ERRORS ? "Repairing" :
                                             "ERROR",
                     i, l1_entry, refcount);
@@ -1720,7 +1721,7 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
         ret = bdrv_pread(bs->file, l2_offset, l2_table,
                          s->l2_size * sizeof(uint64_t));
         if (ret < 0) {
-            fprintf(stderr, "ERROR: Could not read L2 table: %s\n",
+            error_report("ERROR: Could not read L2 table: %s",
                     strerror(-ret));
             res->check_errors++;
             goto fail;
@@ -1741,8 +1742,8 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
                     continue;
                 }
                 if ((refcount == 1) != ((l2_entry & QCOW_OFLAG_COPIED) != 0)) {
-                    fprintf(stderr, "%s OFLAG_COPIED data cluster: "
-                            "l2_entry=%" PRIx64 " refcount=%" PRIu64 "\n",
+                    error_report("%s OFLAG_COPIED data cluster: "
+                            "l2_entry=%" PRIx64 " refcount=%" PRIu64 "",
                             fix & BDRV_FIX_ERRORS ? "Repairing" :
                                                     "ERROR",
                             l2_entry, refcount);
@@ -1763,8 +1764,8 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
             ret = qcow2_pre_write_overlap_check(bs, QCOW2_OL_ACTIVE_L2,
                                                 l2_offset, s->cluster_size);
             if (ret < 0) {
-                fprintf(stderr, "ERROR: Could not write L2 table; metadata "
-                        "overlap check failed: %s\n", strerror(-ret));
+                error_report("ERROR: Could not write L2 table; metadata "
+                        "overlap check failed: %s", strerror(-ret));
                 res->check_errors++;
                 goto fail;
             }
@@ -1772,7 +1773,7 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
             ret = bdrv_pwrite(bs->file, l2_offset, l2_table,
                               s->cluster_size);
             if (ret < 0) {
-                fprintf(stderr, "ERROR: Could not write L2 table: %s\n",
+                error_report("ERROR: Could not write L2 table: %s",
                         strerror(-ret));
                 res->check_errors++;
                 goto fail;
@@ -1806,15 +1807,15 @@ static int check_refblocks(BlockDriverState *bs, BdrvCheckResult *res,
 
         /* Refcount blocks are cluster aligned */
         if (offset_into_cluster(s, offset)) {
-            fprintf(stderr, "ERROR refcount block %" PRId64 " is not "
-                "cluster aligned; refcount table entry corrupted\n", i);
+            error_report("ERROR refcount block %" PRId64 " is not "
+                "cluster aligned; refcount table entry corrupted", i);
             res->corruptions++;
             *rebuild = true;
             continue;
         }
 
         if (cluster >= *nb_clusters) {
-            fprintf(stderr, "%s refcount block %" PRId64 " is outside image\n",
+            error_report("%s refcount block %" PRId64 " is outside image",
                     fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR", i);
 
             if (fix & BDRV_FIX_ERRORS) {
@@ -1868,7 +1869,7 @@ static int check_refblocks(BlockDriverState *bs, BdrvCheckResult *res,
 resize_fail:
                 res->corruptions++;
                 *rebuild = true;
-                fprintf(stderr, "ERROR could not resize image: %s\n",
+                error_report("ERROR could not resize image: %s",
                         strerror(-ret));
             } else {
                 res->corruptions++;
@@ -1883,8 +1884,8 @@ resize_fail:
                 return ret;
             }
             if (s->get_refcount(*refcount_table, cluster) != 1) {
-                fprintf(stderr, "ERROR refcount block %" PRId64
-                        " refcount=%" PRIu64 "\n", i,
+                error_report("ERROR refcount block %" PRId64
+                        " refcount=%" PRIu64 "", i,
                         s->get_refcount(*refcount_table, cluster));
                 res->corruptions++;
                 *rebuild = true;
@@ -1990,7 +1991,7 @@ static void compare_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
     for (i = 0, *highest_cluster = 0; i < nb_clusters; i++) {
         ret = qcow2_get_refcount(bs, i, &refcount1);
         if (ret < 0) {
-            fprintf(stderr, "Can't get refcount for cluster %" PRId64 ": %s\n",
+            error_report("Can't get refcount for cluster %" PRId64 ": %s",
                     i, strerror(-ret));
             res->check_errors++;
             continue;
@@ -2013,8 +2014,8 @@ static void compare_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                 num_fixed = &res->corruptions_fixed;
             }
 
-            fprintf(stderr, "%s cluster %" PRId64 " refcount=%" PRIu64
-                    " reference=%" PRIu64 "\n",
+            error_report("%s cluster %" PRId64 " refcount=%" PRIu64
+                    " reference=%" PRIu64 "",
                    num_fixed != NULL     ? "Repairing" :
                    refcount1 < refcount2 ? "ERROR" :
                                            "Leaked",
@@ -2159,7 +2160,7 @@ write_refblocks:
         refblock_offset = alloc_clusters_imrt(bs, 1, refcount_table,
                                               nb_clusters, &first_free_cluster);
         if (refblock_offset < 0) {
-            fprintf(stderr, "ERROR allocating refblock: %s\n",
+            error_report("ERROR allocating refblock: %s",
                     strerror(-refblock_offset));
             res->check_errors++;
             ret = refblock_offset;
@@ -2205,7 +2206,7 @@ write_refblocks:
                                                   refcount_table, nb_clusters,
                                                   &first_free_cluster);
             if (reftable_offset < 0) {
-                fprintf(stderr, "ERROR allocating reftable: %s\n",
+                error_report("ERROR allocating reftable: %s",
                         strerror(-reftable_offset));
                 res->check_errors++;
                 ret = reftable_offset;
@@ -2216,7 +2217,7 @@ write_refblocks:
         ret = qcow2_pre_write_overlap_check(bs, 0, refblock_offset,
                                             s->cluster_size);
         if (ret < 0) {
-            fprintf(stderr, "ERROR writing refblock: %s\n", strerror(-ret));
+            error_report("ERROR writing refblock: %s", strerror(-ret));
             goto fail;
         }
 
@@ -2228,7 +2229,7 @@ write_refblocks:
         ret = bdrv_write(bs->file, refblock_offset / BDRV_SECTOR_SIZE,
                          on_disk_refblock, s->cluster_sectors);
         if (ret < 0) {
-            fprintf(stderr, "ERROR writing refblock: %s\n", strerror(-ret));
+            error_report("ERROR writing refblock: %s", strerror(-ret));
             goto fail;
         }
 
@@ -2250,7 +2251,7 @@ write_refblocks:
                                               refcount_table, nb_clusters,
                                               &first_free_cluster);
         if (reftable_offset < 0) {
-            fprintf(stderr, "ERROR allocating reftable: %s\n",
+            error_report("ERROR allocating reftable: %s",
                     strerror(-reftable_offset));
             res->check_errors++;
             ret = reftable_offset;
@@ -2267,7 +2268,7 @@ write_refblocks:
     ret = qcow2_pre_write_overlap_check(bs, 0, reftable_offset,
                                         reftable_size * sizeof(uint64_t));
     if (ret < 0) {
-        fprintf(stderr, "ERROR writing reftable: %s\n", strerror(-ret));
+        error_report("ERROR writing reftable: %s", strerror(-ret));
         goto fail;
     }
 
@@ -2275,7 +2276,7 @@ write_refblocks:
     ret = bdrv_pwrite(bs->file, reftable_offset, on_disk_reftable,
                       reftable_size * sizeof(uint64_t));
     if (ret < 0) {
-        fprintf(stderr, "ERROR writing reftable: %s\n", strerror(-ret));
+        error_report("ERROR writing reftable: %s", strerror(-ret));
         goto fail;
     }
 
@@ -2288,7 +2289,7 @@ write_refblocks:
                            &reftable_offset_and_clusters,
                            sizeof(reftable_offset_and_clusters));
     if (ret < 0) {
-        fprintf(stderr, "ERROR setting reftable: %s\n", strerror(-ret));
+        error_report("ERROR setting reftable: %s", strerror(-ret));
         goto fail;
     }
 
@@ -2355,7 +2356,7 @@ int qcow2_check_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
         BdrvCheckResult old_res = *res;
         int fresh_leaks = 0;
 
-        fprintf(stderr, "Rebuilding refcount structure\n");
+        error_report("Rebuilding refcount structure");
         ret = rebuild_refcount_structure(bs, res, &refcount_table,
                                          &nb_clusters);
         if (ret < 0) {
@@ -2385,8 +2386,8 @@ int qcow2_check_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
             compare_refcounts(bs, res, BDRV_FIX_LEAKS, &rebuild,
                               &highest_cluster, refcount_table, nb_clusters);
             if (rebuild) {
-                fprintf(stderr, "ERROR rebuilt refcount structure is still "
-                        "broken\n");
+                error_report("ERROR rebuilt refcount structure is still "
+                        "broken");
             }
 
             /* Any leaks accounted for here were introduced by
@@ -2405,7 +2406,7 @@ int qcow2_check_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
         res->leaks += fresh_leaks;
     } else if (fix) {
         if (rebuild) {
-            fprintf(stderr, "ERROR need to rebuild refcount structures\n");
+            error_report("ERROR need to rebuild refcount structures");
             res->check_errors++;
             ret = -EIO;
             goto fail;
diff --git a/block/qcow2.c b/block/qcow2.c
index d33fb3ecdd..06a131d287 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4162,11 +4162,11 @@ void qcow2_signal_corruption(BlockDriverState *bs, bool fatal, int64_t offset,
     va_end(ap);
 
     if (fatal) {
-        fprintf(stderr, "qcow2: Marking image as corrupt: %s; further "
-                "corruption events will be suppressed\n", message);
+        error_report("qcow2: Marking image as corrupt: %s; further "
+                "corruption events will be suppressed", message);
     } else {
-        fprintf(stderr, "qcow2: Image is corrupt: %s; further non-fatal "
-                "corruption events will be suppressed\n", message);
+        error_report("qcow2: Image is corrupt: %s; further non-fatal "
+                "corruption events will be suppressed", message);
     }
 
     node_name = bdrv_get_node_name(bs);
diff --git a/block/quorum.c b/block/quorum.c
index 272f9a5b77..a55f1fe6a0 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -14,6 +14,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu/cutils.h"
 #include "block/block_int.h"
 #include "qapi/qmp/qbool.h"
@@ -927,8 +928,8 @@ static int quorum_open(BlockDriverState *bs, QDict *options, int flags,
             s->num_children == 2 && s->threshold == 2) {
             s->is_blkverify = true;
         } else if (qemu_opt_get_bool(opts, QUORUM_OPT_BLKVERIFY, false)) {
-            fprintf(stderr, "blkverify mode is set by setting blkverify=on "
-                    "and using two files with vote_threshold=2\n");
+            error_report("blkverify mode is set by setting blkverify=on "
+                    "and using two files with vote_threshold=2");
         }
 
         s->rewrite_corrupted = qemu_opt_get_bool(opts, QUORUM_OPT_REWRITE,
diff --git a/block/ssh.c b/block/ssh.c
index b049a16eb9..903b797a55 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -53,7 +53,7 @@
 #define DPRINTF(fmt, ...)                           \
     do {                                            \
         if (DEBUG_SSH) {                            \
-            fprintf(stderr, "ssh: %-15s " fmt "\n", \
+            error_report("ssh: %-15s " fmt "", \
                     __func__, ##__VA_ARGS__);       \
         }                                           \
     } while (0)
@@ -1217,7 +1217,7 @@ static void bdrv_ssh_init(void)
 
     r = libssh2_init(0);
     if (r != 0) {
-        fprintf(stderr, "libssh2 initialization failed, %d\n", r);
+        error_report("libssh2 initialization failed, %d", r);
         exit(EXIT_FAILURE);
     }
 
diff --git a/block/vdi.c b/block/vdi.c
index 8da5dfc897..0d9440d36e 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -50,6 +50,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "block/block_int.h"
 #include "sysemu/block-backend.h"
@@ -289,20 +290,21 @@ static int vdi_check(BlockDriverState *bs, BdrvCheckResult *res,
                 if (!VDI_IS_ALLOCATED(bmap[bmap_entry])) {
                     bmap[bmap_entry] = bmap_entry;
                 } else {
-                    fprintf(stderr, "ERROR: block index %" PRIu32
-                            " also used by %" PRIu32 "\n", bmap[bmap_entry], bmap_entry);
+                    error_report("block index %" PRIu32
+                                 " also used by %" PRIu32 "",
+                                 bmap[bmap_entry], bmap_entry);
                     res->corruptions++;
                 }
             } else {
-                fprintf(stderr, "ERROR: block index %" PRIu32
-                        " too large, is %" PRIu32 "\n", block, bmap_entry);
+                error_report("block index %" PRIu32
+                             " too large, is %" PRIu32 "", block, bmap_entry);
                 res->corruptions++;
             }
         }
     }
     if (blocks_allocated != s->header.blocks_allocated) {
-        fprintf(stderr, "ERROR: allocated blocks mismatch, is %" PRIu32
-               ", should be %" PRIu32 "\n",
+        error_report("allocated blocks mismatch, is %" PRIu32
+                     ", should be %" PRIu32 "",
                blocks_allocated, s->header.blocks_allocated);
         res->corruptions++;
     }
diff --git a/block/vpc.c b/block/vpc.c
index 1576d7b595..f033bde29e 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -23,6 +23,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "block/block_int.h"
@@ -278,8 +279,8 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
     checksum = be32_to_cpu(footer->checksum);
     footer->checksum = 0;
     if (vpc_checksum(s->footer_buf, HEADER_SIZE) != checksum)
-        fprintf(stderr, "block-vpc: The header checksum of '%s' is "
-            "incorrect.\n", bs->filename);
+        error_report("block-vpc: The header checksum of '%s' is "
+            "incorrect.", bs->filename);
 
     /* Write 'checksum' back to footer, or else will leave it with zero. */
     footer->checksum = cpu_to_be32(checksum);
diff --git a/block/vvfat.c b/block/vvfat.c
index cbabb36f62..e339e1f97e 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -59,7 +59,7 @@ static void checkpoint(void);
 
 #ifdef __MINGW32__
 void nonono(const char* file, int line, const char* msg) {
-    fprintf(stderr, "Nonono! %s:%d %s\n", file, line, msg);
+    error_report("Nonono! %s:%d %s", file, line, msg);
     exit(-5);
 }
 #undef assert
@@ -446,7 +446,7 @@ static direntry_t *create_long_filename(BDRVVVFATState *s, const char *filename)
 
     gunichar2 *longname = g_utf8_to_utf16(filename, -1, NULL, &length, NULL);
     if (!longname) {
-        fprintf(stderr, "vvfat: invalid UTF-8 name: %s\n", filename);
+        error_report("vvfat: invalid UTF-8 name: %s", filename);
         return NULL;
     }
 
@@ -803,7 +803,7 @@ static int read_directory(BDRVVVFATState* s, int mapping_index)
         int is_dotdot=!strcmp(entry->d_name,"..");
 
         if (first_cluster == 0 && s->directory.next >= s->root_entries - 1) {
-            fprintf(stderr, "Too many entries in root directory\n");
+            error_report("Too many entries in root directory");
             closedir(dir);
             return -2;
         }
@@ -840,7 +840,7 @@ static int read_directory(BDRVVVFATState* s, int mapping_index)
         else
             direntry->begin=0; /* do that later */
         if (st.st_size > 0x7fffffff) {
-            fprintf(stderr, "File %s is larger than 2GB\n", buffer);
+            error_report("File %s is larger than 2GB", buffer);
             g_free(buffer);
             closedir(dir);
             return -2;
@@ -1251,8 +1251,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
     s->fat2 = NULL;
     s->downcase_short_names = 1;
 
-    fprintf(stderr, "vvfat %s chs %d,%d,%d\n",
-            dirname, cyls, heads, secs);
+    error_report("vvfat %s chs %d,%d,%d", dirname, cyls, heads, secs);
 
     s->sector_count = cyls * heads * secs - s->offset_to_bootsector;
 
@@ -1458,7 +1457,7 @@ static void print_direntry(const direntry_t* direntry)
         for(i=28;i<32 && c[i] && c[i]!=0xff;i+=2)
             ADD_CHAR(c[i]);
         buffer[j] = 0;
-        fprintf(stderr, "%s\n", buffer);
+        error_report("%s", buffer);
     } else {
         int i;
         for(i=0;i<11;i++)
@@ -1479,9 +1478,11 @@ static void print_mapping(const mapping_t* mapping)
         mapping->first_mapping_index, mapping->path, mapping->mode);
 
     if (mapping->mode & MODE_DIRECTORY)
-        fprintf(stderr, "parent_mapping_index = %d, first_dir_index = %d\n", mapping->info.dir.parent_mapping_index, mapping->info.dir.first_dir_index);
+        error_report("parent_mapping_index = %d, first_dir_index = %d",
+                     mapping->info.dir.parent_mapping_index,
+                     mapping->info.dir.first_dir_index);
     else
-        fprintf(stderr, "offset = %d\n", mapping->info.file.offset);
+        error_report("offset = %d", mapping->info.file.offset);
 }
 #endif
 
@@ -1503,9 +1504,9 @@ static int vvfat_read(BlockDriverState *bs, int64_t sector_num,
                 return ret;
             }
             if (ret) {
-                DLOG(fprintf(stderr, "sectors %" PRId64 "+%" PRId64
-                             " allocated\n", sector_num,
-                             n >> BDRV_SECTOR_BITS));
+                DLOG(error_report("sectors %" PRId64 "+%" PRId64
+                                  " allocated", sector_num,
+                                  n >> BDRV_SECTOR_BITS));
                 if (bdrv_read(s->qcow, sector_num, buf + i * 0x200,
                               n >> BDRV_SECTOR_BITS)) {
                     return -1;
@@ -1514,8 +1515,8 @@ static int vvfat_read(BlockDriverState *bs, int64_t sector_num,
                 sector_num += (n >> BDRV_SECTOR_BITS) - 1;
                 continue;
             }
-            DLOG(fprintf(stderr, "sector %" PRId64 " not allocated\n",
-                         sector_num));
+            DLOG(error_report("sector %" PRId64 " not allocated",
+                              sector_num));
         }
         if (sector_num < s->offset_to_root_dir) {
             if (sector_num < s->offset_to_fat) {
@@ -1615,7 +1616,7 @@ typedef struct commit_t {
 static void clear_commits(BDRVVVFATState* s)
 {
     int i;
-DLOG(fprintf(stderr, "clear_commits (%d commits)\n", s->commits.next));
+DLOG(error_report("clear_commits (%d commits)", s->commits.next));
     for (i = 0; i < s->commits.next; i++) {
         commit_t* commit = array_get(&(s->commits), i);
         assert(commit->path || commit->action == ACTION_WRITEOUT);
@@ -2065,16 +2066,17 @@ static int check_directory_consistency(BDRVVVFATState *s,
         ret++;
 
         if (s->used_clusters[cluster_num] & USED_ANY) {
-            fprintf(stderr, "cluster %d used more than once\n", (int)cluster_num);
+            error_report("cluster %d used more than once", (int)cluster_num);
             goto fail;
         }
         s->used_clusters[cluster_num] = USED_DIRECTORY;
 
-DLOG(fprintf(stderr, "read cluster %d (sector %d)\n", (int)cluster_num, (int)cluster2sector(s, cluster_num)));
+DLOG(error_report("read cluster %d (sector %d)",
+                  (int)cluster_num, (int)cluster2sector(s, cluster_num)));
         subret = vvfat_read(s->bs, cluster2sector(s, cluster_num), cluster,
                 s->sectors_per_cluster);
         if (subret) {
-            fprintf(stderr, "Error fetching direntries\n");
+            error_report("Error fetching direntries");
         fail:
             g_free(cluster);
             return 0;
@@ -2083,14 +2085,14 @@ DLOG(fprintf(stderr, "read cluster %d (sector %d)\n", (int)cluster_num, (int)clu
         for (i = 0; i < 0x10 * s->sectors_per_cluster; i++) {
             int cluster_count = 0;
 
-DLOG(fprintf(stderr, "check direntry %d:\n", i); print_direntry(direntries + i));
+DLOG(error_report("check direntry %d:", i); print_direntry(direntries + i));
             if (is_volume_label(direntries + i) || is_dot(direntries + i) ||
                     is_free(direntries + i))
                 continue;
 
             subret = parse_long_name(&lfn, direntries + i);
             if (subret < 0) {
-                fprintf(stderr, "Error in long name\n");
+                error_report("Error in long name");
                 goto fail;
             }
             if (subret == 0 || is_free(direntries + i))
@@ -2099,7 +2101,7 @@ DLOG(fprintf(stderr, "check direntry %d:\n", i); print_direntry(direntries + i))
             if (fat_chksum(direntries+i) != lfn.checksum) {
                 subret = parse_short_name(s, &lfn, direntries + i);
                 if (subret < 0) {
-                    fprintf(stderr, "Error in short name (%d)\n", subret);
+                    error_report("Error in short name (%d)", subret);
                     goto fail;
                 }
                 if (subret > 0 || !strcmp((char*)lfn.name, ".")
@@ -2109,7 +2111,7 @@ DLOG(fprintf(stderr, "check direntry %d:\n", i); print_direntry(direntries + i))
             lfn.checksum = 0x100; /* cannot use long name twice */
 
             if (path_len + 1 + lfn.len >= PATH_MAX) {
-                fprintf(stderr, "Name too long: %s/%s\n", path, lfn.name);
+                error_report("Name too long: %s/%s", path, lfn.name);
                 goto fail;
             }
             pstrcpy(path2 + path_len + 1, sizeof(path2) - path_len - 1,
@@ -2117,13 +2119,15 @@ DLOG(fprintf(stderr, "check direntry %d:\n", i); print_direntry(direntries + i))
 
             if (is_directory(direntries + i)) {
                 if (begin_of_direntry(direntries + i) == 0) {
-                    DLOG(fprintf(stderr, "invalid begin for directory: %s\n", path2); print_direntry(direntries + i));
+                    DLOG(error_report("invalid begin for directory: %s", path2);
+                         print_direntry(direntries + i));
                     goto fail;
                 }
                 cluster_count = check_directory_consistency(s,
                         begin_of_direntry(direntries + i), path2);
                 if (cluster_count == 0) {
-                    DLOG(fprintf(stderr, "problem in directory %s:\n", path2); print_direntry(direntries + i));
+                    DLOG(error_report("problem in directory %s:", path2);
+                         print_direntry(direntries + i));
                     goto fail;
                 }
             } else if (is_file(direntries + i)) {
@@ -2131,7 +2135,7 @@ DLOG(fprintf(stderr, "check direntry %d:\n", i); print_direntry(direntries + i))
                 cluster_count = get_cluster_count_for_direntry(s, direntries + i, path2);
                 if (cluster_count !=
             DIV_ROUND_UP(le32_to_cpu(direntries[i].size), s->cluster_size)) {
-                    DLOG(fprintf(stderr, "Cluster count mismatch\n"));
+                    DLOG(error_report("Cluster count mismatch"));
                     goto fail;
                 }
             } else
@@ -2175,7 +2179,7 @@ DLOG(checkpoint());
     check = vvfat_read(s->bs,
             s->offset_to_fat, s->fat2, s->sectors_per_fat);
     if (check) {
-        fprintf(stderr, "Could not copy fat\n");
+        error_report("Could not copy fat");
         return 0;
     }
     assert (s->used_clusters);
@@ -2195,7 +2199,7 @@ DLOG(checkpoint());
 
     used_clusters_count = check_directory_consistency(s, 0, s->path);
     if (used_clusters_count <= 0) {
-        DLOG(fprintf(stderr, "problem in directory\n"));
+        DLOG(error_report("problem in directory"));
         return 0;
     }
 
@@ -2203,7 +2207,8 @@ DLOG(checkpoint());
     for (i = check; i < sector2cluster(s, s->sector_count); i++) {
         if (modified_fat_get(s, i)) {
             if(!s->used_clusters[i]) {
-                DLOG(fprintf(stderr, "FAT was modified (%d), but cluster is not used?\n", i));
+                DLOG(error_report("FAT was modified (%d), but cluster"
+                                  " is not used?", i));
                 return 0;
             }
             check++;
@@ -2211,7 +2216,7 @@ DLOG(checkpoint());
 
         if (s->used_clusters[i] == USED_ALLOCATED) {
             /* allocated, but not used... */
-            DLOG(fprintf(stderr, "unused, modified cluster: %d\n", i));
+            DLOG(error_report("unused, modified cluster: %d", i));
             return 0;
         }
     }
@@ -2438,7 +2443,8 @@ static int commit_direntries(BDRVVVFATState* s,
     int ret, i;
     uint32_t c;
 
-DLOG(fprintf(stderr, "commit_direntries for %s, parent_mapping_index %d\n", mapping->path, parent_mapping_index));
+DLOG(error_report("commit_direntries for %s, parent_mapping_index %d",
+                  mapping->path, parent_mapping_index));
 
     assert(direntry);
     assert(mapping);
@@ -2529,8 +2535,8 @@ static int commit_one_file(BDRVVVFATState* s,
 
     fd = qemu_open(mapping->path, O_RDWR | O_CREAT | O_BINARY, 0666);
     if (fd < 0) {
-        fprintf(stderr, "Could not open %s... (%s, %d)\n", mapping->path,
-                strerror(errno), errno);
+        error_report("Could not open %s... (%s, %d)", mapping->path,
+                     strerror(errno), errno);
         g_free(cluster);
         return fd;
     }
@@ -2592,7 +2598,7 @@ static void check1(BDRVVVFATState* s)
     for (i = 0; i < s->mapping.next; i++) {
         mapping_t* mapping = array_get(&(s->mapping), i);
         if (mapping->mode & MODE_DELETED) {
-            fprintf(stderr, "deleted\n");
+            error_report("deleted");
             continue;
         }
         assert(mapping->dir_index < s->directory.next);
@@ -2658,10 +2664,12 @@ static int handle_renames_and_mkdirs(BDRVVVFATState* s)
     int i;
 
 #ifdef DEBUG
-    fprintf(stderr, "handle_renames\n");
+    error_report("handle_renames");
     for (i = 0; i < s->commits.next; i++) {
         commit_t* commit = array_get(&(s->commits), i);
-        fprintf(stderr, "%d, %s (%d, %d)\n", i, commit->path ? commit->path : "(null)", commit->param.rename.cluster, commit->action);
+        error_report("%d, %s (%d, %d)", i,
+                     commit->path ? commit->path : "(null)",
+                     commit->param.rename.cluster, commit->action);
     }
 #endif
 
@@ -2893,7 +2901,9 @@ static int handle_deletes(BDRVVVFATState* s)
                         return -4;
                     deleted++;
                 }
-                DLOG(fprintf(stderr, "DELETE (%d)\n", i); print_mapping(mapping); print_direntry(entry));
+                DLOG(error_report("DELETE (%d)", i);
+                     print_mapping(mapping);
+                     print_direntry(entry));
                 remove_mapping(s, i);
             }
         }
@@ -2922,7 +2932,7 @@ static int do_commit(BDRVVVFATState* s)
 
     ret = handle_renames_and_mkdirs(s);
     if (ret) {
-        fprintf(stderr, "Error handling renames (%d)\n", ret);
+        error_report("Error handling renames (%d)", ret);
         abort();
         return ret;
     }
@@ -2933,21 +2943,21 @@ static int do_commit(BDRVVVFATState* s)
     /* recurse direntries from root (using bs->bdrv_read) */
     ret = commit_direntries(s, 0, -1);
     if (ret) {
-        fprintf(stderr, "Fatal: error while committing (%d)\n", ret);
+        error_report("Fatal: error while committing (%d)", ret);
         abort();
         return ret;
     }
 
     ret = handle_commits(s);
     if (ret) {
-        fprintf(stderr, "Error handling commits (%d)\n", ret);
+        error_report("Error handling commits (%d)", ret);
         abort();
         return ret;
     }
 
     ret = handle_deletes(s);
     if (ret) {
-        fprintf(stderr, "Error deleting\n");
+        error_report("Error deleting");
         abort();
         return ret;
     }
@@ -2999,7 +3009,7 @@ DLOG(checkpoint());
         mapping_t* mapping = find_mapping_for_cluster(s, i);
         if (mapping) {
             if (mapping->read_only) {
-                fprintf(stderr, "Tried to write to write-protected file %s\n",
+                error_report("Tried to write to write-protected file %s",
                         mapping->path);
                 return -1;
             }
@@ -3043,10 +3053,11 @@ DLOG(checkpoint());
     /*
      * Use qcow backend. Commit later.
      */
-DLOG(fprintf(stderr, "Write to qcow backend: %d + %d\n", (int)sector_num, nb_sectors));
+DLOG(error_report("Write to qcow backend: %d + %d",
+                  (int)sector_num, nb_sectors));
     ret = bdrv_write(s->qcow, sector_num, buf, nb_sectors);
     if (ret < 0) {
-        fprintf(stderr, "Error writing to qcow backend\n");
+        error_report("Error writing to qcow backend");
         return ret;
     }
 
@@ -3277,7 +3288,7 @@ static void checkpoint(void) {
     assert(!vvv->current_mapping || vvv->current_fd || (vvv->current_mapping->mode & MODE_DIRECTORY));
 #if 0
     if (((direntry_t*)vvv->directory.pointer)[1].attributes != 0xf)
-        fprintf(stderr, "Nonono!\n");
+        error_report("Nonono!");
     mapping_t* mapping;
     direntry_t* direntry;
     assert(vvv->mapping.size >= vvv->mapping.item_size * vvv->mapping.next);
-- 
2.11.0
