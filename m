Received: from eggs.gnu.org ([2001:4830:134:3::10]:53539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvCq-0006jX-Vp
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvCp-0002Ol-M9
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:38:49 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 16 Jun 2017 19:37:14 +0200
Message-Id: <1497634636-20230-30-git-send-email-kwolf@redhat.com>
In-Reply-To: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
References: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 29/31] qed: Add coroutine_fn to I/O path
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

Now that we stay in coroutine context for the whole request when doing
reads or writes, we can add coroutine_fn annotations to many functions
that can do I/O or yield directly.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qed-cluster.c |  5 +++--
 block/qed.c         | 44 ++++++++++++++++++++++++--------------------
 block/qed.h         |  5 +++--
 3 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/block/qed-cluster.c b/block/qed-cluster.c
index 88dc979..d8d6e66 100644
--- a/block/qed-cluster.c
+++ b/block/qed-cluster.c
@@ -86,8 +86,9 @@ static unsigned int qed_count_contiguous_clusters(BDRVQEDState *s,
  * On failure QED_CLUSTER_L2 or QED_CLUSTER_L1 is returned for missing L2 or L1
  * table offset, respectively. len is number of contiguous unallocated bytes.
  */
-int qed_find_cluster(BDRVQEDState *s, QEDRequest *request, uint64_t pos,
-                     size_t *len, uint64_t *img_offset)
+int coroutine_fn qed_find_cluster(BDRVQEDState *s, QEDRequest *request,
+                                  uint64_t pos, size_t *len,
+                                  uint64_t *img_offset)
 {
     uint64_t l2_offset;
     uint64_t offset = 0;
diff --git a/block/qed.c b/block/qed.c
index eac8c2f..48f2b0e 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -94,7 +94,7 @@ int qed_write_header_sync(BDRVQEDState *s)
  * This function only updates known header fields in-place and does not affect
  * extra data after the QED header.
  */
-static int qed_write_header(BDRVQEDState *s)
+static int coroutine_fn qed_write_header(BDRVQEDState *s)
 {
     /* We must write full sectors for O_DIRECT but cannot necessarily generate
      * the data following the header if an unrecognized compat feature is
@@ -264,7 +264,7 @@ static void qed_unplug_allocating_write_reqs(BDRVQEDState *s)
     qemu_co_enter_next(&s->allocating_write_reqs);
 }
 
-static void qed_need_check_timer_entry(void *opaque)
+static void coroutine_fn qed_need_check_timer_entry(void *opaque)
 {
     BDRVQEDState *s = opaque;
     int ret;
@@ -757,9 +757,9 @@ static BDRVQEDState *acb_to_s(QEDAIOCB *acb)
  * This function reads qiov->size bytes starting at pos from the backing file.
  * If there is no backing file then zeroes are read.
  */
-static int qed_read_backing_file(BDRVQEDState *s, uint64_t pos,
-                                 QEMUIOVector *qiov,
-                                 QEMUIOVector **backing_qiov)
+static int coroutine_fn qed_read_backing_file(BDRVQEDState *s, uint64_t pos,
+                                              QEMUIOVector *qiov,
+                                              QEMUIOVector **backing_qiov)
 {
     uint64_t backing_length = 0;
     size_t size;
@@ -811,8 +811,9 @@ static int qed_read_backing_file(BDRVQEDState *s, uint64_t pos,
  * @len:        Number of bytes
  * @offset:     Byte offset in image file
  */
-static int qed_copy_from_backing_file(BDRVQEDState *s, uint64_t pos,
-                                      uint64_t len, uint64_t offset)
+static int coroutine_fn qed_copy_from_backing_file(BDRVQEDState *s,
+                                                   uint64_t pos, uint64_t len,
+                                                   uint64_t offset)
 {
     QEMUIOVector qiov;
     QEMUIOVector *backing_qiov = NULL;
@@ -865,8 +866,9 @@ out:
  * The cluster offset may be an allocated byte offset in the image file, the
  * zero cluster marker, or the unallocated cluster marker.
  */
-static void qed_update_l2_table(BDRVQEDState *s, QEDTable *table, int index,
-                                unsigned int n, uint64_t cluster)
+static void coroutine_fn qed_update_l2_table(BDRVQEDState *s, QEDTable *table,
+                                             int index, unsigned int n,
+                                             uint64_t cluster)
 {
     int i;
     for (i = index; i < index + n; i++) {
@@ -878,7 +880,7 @@ static void qed_update_l2_table(BDRVQEDState *s, QEDTable *table, int index,
     }
 }
 
-static void qed_aio_complete(QEDAIOCB *acb)
+static void coroutine_fn qed_aio_complete(QEDAIOCB *acb)
 {
     BDRVQEDState *s = acb_to_s(acb);
 
@@ -911,7 +913,7 @@ static void qed_aio_complete(QEDAIOCB *acb)
 /**
  * Update L1 table with new L2 table offset and write it out
  */
-static int qed_aio_write_l1_update(QEDAIOCB *acb)
+static int coroutine_fn qed_aio_write_l1_update(QEDAIOCB *acb)
 {
     BDRVQEDState *s = acb_to_s(acb);
     CachedL2Table *l2_table = acb->request.l2_table;
@@ -939,7 +941,7 @@ static int qed_aio_write_l1_update(QEDAIOCB *acb)
 /**
  * Update L2 table with new cluster offsets and write them out
  */
-static int qed_aio_write_l2_update(QEDAIOCB *acb, uint64_t offset)
+static int coroutine_fn qed_aio_write_l2_update(QEDAIOCB *acb, uint64_t offset)
 {
     BDRVQEDState *s = acb_to_s(acb);
     bool need_alloc = acb->find_cluster_ret == QED_CLUSTER_L1;
@@ -975,7 +977,7 @@ static int qed_aio_write_l2_update(QEDAIOCB *acb, uint64_t offset)
 /**
  * Write data to the image file
  */
-static int qed_aio_write_main(QEDAIOCB *acb)
+static int coroutine_fn qed_aio_write_main(QEDAIOCB *acb)
 {
     BDRVQEDState *s = acb_to_s(acb);
     uint64_t offset = acb->cur_cluster +
@@ -1018,7 +1020,7 @@ static int qed_aio_write_main(QEDAIOCB *acb)
 /**
  * Populate untouched regions of new data cluster
  */
-static int qed_aio_write_cow(QEDAIOCB *acb)
+static int coroutine_fn qed_aio_write_cow(QEDAIOCB *acb)
 {
     BDRVQEDState *s = acb_to_s(acb);
     uint64_t start, len, offset;
@@ -1071,7 +1073,7 @@ static bool qed_should_set_need_check(BDRVQEDState *s)
  *
  * This path is taken when writing to previously unallocated clusters.
  */
-static int qed_aio_write_alloc(QEDAIOCB *acb, size_t len)
+static int coroutine_fn qed_aio_write_alloc(QEDAIOCB *acb, size_t len)
 {
     BDRVQEDState *s = acb_to_s(acb);
     int ret;
@@ -1132,7 +1134,8 @@ static int qed_aio_write_alloc(QEDAIOCB *acb, size_t len)
  *
  * This path is taken when writing to already allocated clusters.
  */
-static int qed_aio_write_inplace(QEDAIOCB *acb, uint64_t offset, size_t len)
+static int coroutine_fn qed_aio_write_inplace(QEDAIOCB *acb, uint64_t offset,
+                                              size_t len)
 {
     /* Allocate buffer for zero writes */
     if (acb->flags & QED_AIOCB_ZERO) {
@@ -1163,8 +1166,8 @@ static int qed_aio_write_inplace(QEDAIOCB *acb, uint64_t offset, size_t len)
  * @offset:     Cluster offset in bytes
  * @len:        Length in bytes
  */
-static int qed_aio_write_data(void *opaque, int ret,
-                              uint64_t offset, size_t len)
+static int coroutine_fn qed_aio_write_data(void *opaque, int ret,
+                                           uint64_t offset, size_t len)
 {
     QEDAIOCB *acb = opaque;
 
@@ -1194,7 +1197,8 @@ static int qed_aio_write_data(void *opaque, int ret,
  * @offset:     Cluster offset in bytes
  * @len:        Length in bytes
  */
-static int qed_aio_read_data(void *opaque, int ret, uint64_t offset, size_t len)
+static int coroutine_fn qed_aio_read_data(void *opaque, int ret,
+                                          uint64_t offset, size_t len)
 {
     QEDAIOCB *acb = opaque;
     BDRVQEDState *s = acb_to_s(acb);
@@ -1227,7 +1231,7 @@ static int qed_aio_read_data(void *opaque, int ret, uint64_t offset, size_t len)
 /**
  * Begin next I/O or complete the request
  */
-static int qed_aio_next_io(QEDAIOCB *acb)
+static int coroutine_fn qed_aio_next_io(QEDAIOCB *acb)
 {
     BDRVQEDState *s = acb_to_s(acb);
     uint64_t offset;
diff --git a/block/qed.h b/block/qed.h
index fb80943..dd3a2d5 100644
--- a/block/qed.h
+++ b/block/qed.h
@@ -213,8 +213,9 @@ int qed_write_l2_table_sync(BDRVQEDState *s, QEDRequest *request,
 /**
  * Cluster functions
  */
-int qed_find_cluster(BDRVQEDState *s, QEDRequest *request, uint64_t pos,
-                     size_t *len, uint64_t *img_offset);
+int coroutine_fn qed_find_cluster(BDRVQEDState *s, QEDRequest *request,
+                                  uint64_t pos, size_t *len,
+                                  uint64_t *img_offset);
 
 /**
  * Consistency check
-- 
1.8.3.1
