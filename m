Received: from eggs.gnu.org ([2001:4830:134:3::10]:41855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadwO-0006a3-45
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadwN-0006lE-3x
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:28 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gadwM-0006ij-Tf
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:27 -0500
Received: by mail-wm1-x343.google.com with SMTP id y139so7337109wmc.5
	for <qemu-devel@nongnu.org>; Sat, 22 Dec 2018 01:51:24 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 22 Dec 2018 11:50:36 +0200
Message-Id: <20181222095036.29743-32-marcel.apfelbaum@gmail.com>
In-Reply-To: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
References: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 31/31] pvrdma: check return value from
 pvrdma_idx_ring_has_ routines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, pjp@fedoraproject.org

From: Prasad J Pandit <pjp@fedoraproject.org>

pvrdma_idx_ring_has_[data/space] routines also return invalid
index PVRDMA_INVALID_IDX[=-1], if ring has no data/space. Check
return value from these routines to avoid plausible infinite loops.

Reported-by: Li Qiang <liq3ea@163.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/vmw/pvrdma_dev_ring.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/hw/rdma/vmw/pvrdma_dev_ring.c b/hw/rdma/vmw/pvrdma_dev_ring.c
index 01247fc041..e8e5b502f6 100644
--- a/hw/rdma/vmw/pvrdma_dev_ring.c
+++ b/hw/rdma/vmw/pvrdma_dev_ring.c
@@ -73,23 +73,16 @@ out:
 
 void *pvrdma_ring_next_elem_read(PvrdmaRing *ring)
 {
+    int e;
     unsigned int idx = 0, offset;
 
-    /*
-    pr_dbg("%s: t=%d, h=%d\n", ring->name, ring->ring_state->prod_tail,
-           ring->ring_state->cons_head);
-    */
-
-    if (!pvrdma_idx_ring_has_data(ring->ring_state, ring->max_elems, &idx)) {
+    e = pvrdma_idx_ring_has_data(ring->ring_state, ring->max_elems, &idx);
+    if (e <= 0) {
         pr_dbg("No more data in ring\n");
         return NULL;
     }
 
     offset = idx * ring->elem_sz;
-    /*
-    pr_dbg("idx=%d\n", idx);
-    pr_dbg("offset=%d\n", offset);
-    */
     return ring->pages[offset / TARGET_PAGE_SIZE] + (offset % TARGET_PAGE_SIZE);
 }
 
@@ -105,20 +98,20 @@ void pvrdma_ring_read_inc(PvrdmaRing *ring)
 
 void *pvrdma_ring_next_elem_write(PvrdmaRing *ring)
 {
-    unsigned int idx, offset, tail;
+    int idx;
+    unsigned int offset, tail;
 
-    /*
-    pr_dbg("%s: t=%d, h=%d\n", ring->name, ring->ring_state->prod_tail,
-           ring->ring_state->cons_head);
-    */
-
-    if (!pvrdma_idx_ring_has_space(ring->ring_state, ring->max_elems, &tail)) {
+    idx = pvrdma_idx_ring_has_space(ring->ring_state, ring->max_elems, &tail);
+    if (idx <= 0) {
         pr_dbg("CQ is full\n");
         return NULL;
     }
 
     idx = pvrdma_idx(&ring->ring_state->prod_tail, ring->max_elems);
-    /* TODO: tail == idx */
+    if (idx < 0 || tail != idx) {
+        pr_dbg("invalid idx\n");
+        return NULL;
+    }
 
     offset = idx * ring->elem_sz;
     return ring->pages[offset / TARGET_PAGE_SIZE] + (offset % TARGET_PAGE_SIZE);
-- 
2.17.1
