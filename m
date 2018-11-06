Received: from eggs.gnu.org ([2001:4830:134:3::10]:42794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=84194b2eb=igor.druzhinin@citrix.com>)
	id 1gK0Im-0000Xx-4k
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:17:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=84194b2eb=igor.druzhinin@citrix.com>)
	id 1gK0Ie-0005Ga-Ig
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:17:45 -0500
From: Igor Druzhinin <igor.druzhinin@citrix.com>
Date: Tue, 6 Nov 2018 12:16:55 +0000
Message-ID: <1541506615-30202-1-git-send-email-igor.druzhinin@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] block/nvme: call blk_drain in NVMe reset code
 to avoid lockups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: keith.busch@intel.com, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Igor Druzhinin <igor.druzhinin@citrix.com>

When blk_flush called in NVMe reset path S/C queues are already freed
which means that re-entering AIO handling loop having some IO requests
unfinished will lockup or crash as their SG structures being potentially
reused. Call blk_drain before freeing the queues to avoid this nasty
scenario.

Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
---
 hw/block/nvme.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index fc7dacb..cdf836e 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -797,6 +797,8 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
 {
     int i;
 
+    blk_drain(n->conf.blk);
+
     for (i = 0; i < n->num_queues; i++) {
         if (n->sq[i] != NULL) {
             nvme_free_sq(n->sq[i], n);
-- 
2.7.4
