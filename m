Received: from eggs.gnu.org ([2001:4830:134:3::10]:58674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gersner@gmail.com>) id 1fWKAN-0007Vt-Ak
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:23:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gersner@gmail.com>) id 1fWKAL-0005Zb-Td
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:23:47 -0400
From: Shimi Gersner <gersner@gmail.com>
Date: Fri, 22 Jun 2018 11:22:36 +0000
Message-Id: <20180622112237.2131-4-gersner@gmail.com>
In-Reply-To: <20180622112237.2131-1-gersner@gmail.com>
References: <20180622112237.2131-1-gersner@gmail.com>
Subject: [Qemu-devel] [PATCH 4/5] nvme: Fix phantom irq raise
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

CQ irq is asserted when requested are ready for the guest to
collect. On edge cases, irq is raised when there is no actual
request pending on the queue.

Irq is raised for a CQ from nvme_post_cqes uncondtionally
if there are processes requests or not. nvme_post_cqes is
triggered through timer in two cases
 - Completion of sync or async request.
 - CQ was emptied by the guest and pending responses may be queued.

Consider the following flow
 - Async request is made while CQ is full.
 - Guest reads entire CQ and triggers a DB. nvme_post_cqes is scheduled
   and executed through timer.
 - Async request is complete and nvme_post_cqes is scheduled
   and executed through timer.

As nvme_post_cqes raises the irq unconditionally, it leads to
a raise of the irq while no pending CQ request is ready.

Issue is fixed by adding a fast path exit to nvme_post_cqes when it has
no pending processing hence no need to raise the irq.

Change-Id: Ib7af6c1bcb63d03022d9b57e079fdb2cf954e7dc
Signed-off-by: Shimi Gersner <gersner@gmail.com>
---
 hw/block/nvme.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 206d8428fd..f639d7ae73 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -265,6 +265,11 @@ static void nvme_post_cqes(void *opaque)
     NvmeCtrl *n = cq->ctrl;
     NvmeRequest *req, *next;
 
+    // Fast path if nothing to be processed
+    if (QTAILQ_EMPTY(&cq->req_list)) {
+        return;
+    }
+
     QTAILQ_FOREACH_SAFE(req, &cq->req_list, entry, next) {
         NvmeSQueue *sq;
         hwaddr addr;
@@ -1130,14 +1135,21 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
             return;
         }
 
+        /*
+         CLARIFICATION
+         When CQ was full *before* the db write, nvme_post_cqes skipped processing of responses and
+         as a side effect SQ was unable to process new requests (As they are limited by size).
+         When CQ is cleared, spawn both processing of all CQs and SQs. As call to timer_mod
+         is serial, first handle the CQ to clear any pending requests and then clear the associated SQs.
+         */
         start_sqs = nvme_cq_full(cq) ? 1 : 0;
         cq->head = new_head;
         if (start_sqs) {
             NvmeSQueue *sq;
+            timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
             QTAILQ_FOREACH(sq, &cq->sq_list, entry) {
                 timer_mod(sq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
             }
-            timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
         }
 
         if (cq->tail == cq->head) {
-- 
2.17.1
