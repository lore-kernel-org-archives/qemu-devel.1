Received: from eggs.gnu.org ([2001:4830:134:3::10]:58705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gersner@gmail.com>) id 1fWKAO-0007XP-QV
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:23:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gersner@gmail.com>) id 1fWKAN-0005aa-PA
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:23:48 -0400
From: Shimi Gersner <gersner@gmail.com>
Date: Fri, 22 Jun 2018 11:22:37 +0000
Message-Id: <20180622112237.2131-5-gersner@gmail.com>
In-Reply-To: <20180622112237.2131-1-gersner@gmail.com>
References: <20180622112237.2131-1-gersner@gmail.com>
Subject: [Qemu-devel] [PATCH 5/5] nvme: Missing MSI message upon partial CQ
 read
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

When MSIx interrupts are enabled, each CQ is associated with
a vector which is expected to be called upon ready data
in the CQ buffer. After guest reads from the buffer, it updates
the processed buffer position using a CQ dedicated DB.

Upon reading only partial data from the CQ buffer, device
fails to re-send a new MSI message stating buffer still has
unread data. The fix ensures a new message will be sent.

Change-Id: I10190be127b8dcbd89732cfb95ea37faf8c5779b
Signed-off-by: Shimi Gersner <gersner@gmail.com>
---
 hw/block/nvme.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index f639d7ae73..e2dca6e57f 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1152,8 +1152,12 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
             }
         }
 
+        // When we have more messages, we should make sure irq is asserted. When MSIx is used
+        // this will make sure another notification is sent to the guest.
         if (cq->tail == cq->head) {
             nvme_irq_deassert(n, cq);
+        } else {
+            nvme_irq_assert(n, cq);
         }
     } else {
         /* Submission queue doorbell write */
-- 
2.17.1
