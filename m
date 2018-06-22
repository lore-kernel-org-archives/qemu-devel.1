Received: from eggs.gnu.org ([2001:4830:134:3::10]:58678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gersner@gmail.com>) id 1fWKAN-0007Vw-CB
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:23:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gersner@gmail.com>) id 1fWKAL-0005ZW-R3
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:23:47 -0400
From: Shimi Gersner <gersner@gmail.com>
Date: Fri, 22 Jun 2018 11:22:34 +0000
Message-Id: <20180622112237.2131-2-gersner@gmail.com>
In-Reply-To: <20180622112237.2131-1-gersner@gmail.com>
References: <20180622112237.2131-1-gersner@gmail.com>
Subject: [Qemu-devel] [PATCH 2/5] nvme: CQ/SQ proper validation & status code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, David Sariel <davidsa@openu.ac.il>, Shimi Gersner <gersner@gmail.com>

Device fails to properly comply CQ/SQ id validation.

nvme_check_[cs]id was used for both validation of the id and
to check if the id is used. Function was split and into two
seperate functions and used properly on CQ/SQ creation/deletion.

When id check is failed a proper error should be returned as defined
by the sepecification.

Additionally, CQ creation failed to properly check irq vector number.

Change-Id: I3b6d8179ce567be4cd064c0be0ed69a740708096
Signed-off-by: Shimi Gersner <gersner@gmail.com>
---
 hw/block/nvme.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 9d5414c80f..24a51d33ea 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -62,14 +62,24 @@ static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
     }
 }
 
-static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)
+static int nvme_valid_sqid(NvmeCtrl *n, uint16_t sqid)
 {
-    return sqid < n->num_queues && n->sq[sqid] != NULL ? 0 : -1;
+    return sqid < n->num_queues;
 }
 
-static int nvme_check_cqid(NvmeCtrl *n, uint16_t cqid)
+static int nvme_used_sqid(NvmeCtrl *n, uint16_t sqid)
 {
-    return cqid < n->num_queues && n->cq[cqid] != NULL ? 0 : -1;
+    return sqid < n->num_queues && n->sq[sqid] != NULL ? 1 : 0;
+}
+
+static int nvme_valid_cqid(NvmeCtrl *n, uint16_t cqid)
+{
+    return cqid < n->num_queues;
+}
+
+static int nvme_used_cqid(NvmeCtrl *n, uint16_t cqid)
+{
+    return cqid < n->num_queues && n->cq[cqid] != NULL ? 1 : 0;
 }
 
 static void nvme_inc_cq_tail(NvmeCQueue *cq)
@@ -433,7 +443,7 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *cmd)
     NvmeCQueue *cq;
     uint16_t qid = le16_to_cpu(c->qid);
 
-    if (unlikely(!qid || nvme_check_sqid(n, qid))) {
+    if (unlikely(!qid || !nvme_used_sqid(n, qid))) {
         trace_nvme_err_invalid_del_sq(qid);
         return NVME_INVALID_QID | NVME_DNR;
     }
@@ -446,7 +456,7 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *cmd)
         assert(req->aiocb);
         blk_aio_cancel(req->aiocb);
     }
-    if (!nvme_check_cqid(n, sq->cqid)) {
+    if (nvme_used_cqid(n, sq->cqid)) {
         cq = n->cq[sq->cqid];
         QTAILQ_REMOVE(&cq->sq_list, sq, entry);
 
@@ -504,11 +514,11 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd *cmd)
 
     trace_nvme_create_sq(prp1, sqid, cqid, qsize, qflags);
 
-    if (unlikely(!cqid || nvme_check_cqid(n, cqid))) {
+    if (unlikely(!cqid || !nvme_used_cqid(n, cqid))) {
         trace_nvme_err_invalid_create_sq_cqid(cqid);
         return NVME_INVALID_CQID | NVME_DNR;
     }
-    if (unlikely(!sqid || !nvme_check_sqid(n, sqid))) {
+    if (unlikely(!sqid || !nvme_valid_sqid(n, sqid) || nvme_used_sqid(n, sqid))) {
         trace_nvme_err_invalid_create_sq_sqid(sqid);
         return NVME_INVALID_QID | NVME_DNR;
     }
@@ -546,9 +556,9 @@ static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeCmd *cmd)
     NvmeCQueue *cq;
     uint16_t qid = le16_to_cpu(c->qid);
 
-    if (unlikely(!qid || nvme_check_cqid(n, qid))) {
+    if (unlikely(!qid || !nvme_used_cqid(n, qid))) {
         trace_nvme_err_invalid_del_cq_cqid(qid);
-        return NVME_INVALID_CQID | NVME_DNR;
+        return NVME_INVALID_QID | NVME_DNR;
     }
 
     cq = n->cq[qid];
@@ -592,9 +602,9 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
     trace_nvme_create_cq(prp1, cqid, vector, qsize, qflags,
                          NVME_CQ_FLAGS_IEN(qflags) != 0);
 
-    if (unlikely(!cqid || !nvme_check_cqid(n, cqid))) {
+    if (unlikely(!cqid || !nvme_valid_cqid(n, cqid) || nvme_used_cqid(n, cqid))) {
         trace_nvme_err_invalid_create_cq_cqid(cqid);
-        return NVME_INVALID_CQID | NVME_DNR;
+        return NVME_INVALID_QID | NVME_DNR;
     }
     if (unlikely(!qsize || qsize > NVME_CAP_MQES(n->bar.cap))) {
         trace_nvme_err_invalid_create_cq_size(qsize);
@@ -604,7 +614,7 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
         trace_nvme_err_invalid_create_cq_addr(prp1);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
-    if (unlikely(vector > n->num_queues)) {
+    if (unlikely(vector >= n->num_queues)) {
         trace_nvme_err_invalid_create_cq_vector(vector);
         return NVME_INVALID_IRQ_VECTOR | NVME_DNR;
     }
@@ -1091,7 +1101,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
         NvmeCQueue *cq;
 
         qid = (addr - (0x1000 + (1 << 2))) >> 3;
-        if (unlikely(nvme_check_cqid(n, qid))) {
+        if (unlikely(!nvme_used_cqid(n, qid))) {
             NVME_GUEST_ERR(nvme_ub_db_wr_invalid_cq,
                            "completion queue doorbell write"
                            " for nonexistent queue,"
@@ -1129,7 +1139,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
         NvmeSQueue *sq;
 
         qid = (addr - 0x1000) >> 3;
-        if (unlikely(nvme_check_sqid(n, qid))) {
+        if (unlikely(!nvme_used_sqid(n, qid))) {
             NVME_GUEST_ERR(nvme_ub_db_wr_invalid_sq,
                            "submission queue doorbell write"
                            " for nonexistent queue,"
-- 
2.17.1
