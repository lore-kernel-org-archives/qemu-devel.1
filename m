Received: from eggs.gnu.org ([2001:4830:134:3::10]:36458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@hotmail.com>) id 1evv61-0000e4-33
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 21:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@hotmail.com>) id 1evv5w-0006YA-7J
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 21:20:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:28906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@hotmail.com>)
	id 1evv5v-0006Hx-UK
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 21:20:44 -0400
From: junyan.he@hotmail.com
Date: Wed, 14 Mar 2018 09:20:18 +0800
Message-Id: <1520990418-28258-11-git-send-email-junyan.he@hotmail.com>
In-Reply-To: <1520990418-28258-1-git-send-email-junyan.he@hotmail.com>
References: <1520990418-28258-1-git-send-email-junyan.he@hotmail.com>
Subject: [Qemu-devel] [PATCH 10/10] RFC: Enable nvdimm snapshot functions.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, quintela@redhat.com, rth@twiddle.net, dgilbert@redhat.com, famz@redhat.com, Junyan He <junyan.he@intel.com>

From: Junyan He <junyan.he@intel.com>

In snapshot saving, all nvdimm kind memory will be saved in different way
and we exclude all nvdimm kind memory region in ram.c

Signed-off-by: Junyan He <junyan.he@intel.com>
---
 migration/ram.c | 17 +++++++++++++++++
 vl.c            |  1 +
 2 files changed, 18 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index d1db422..ad32469 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1219,9 +1219,15 @@ static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss, bool *again)
         /* Didn't find anything in this RAM Block */
         pss->page = 0;
         pss->block = QLIST_NEXT_RCU(pss->block, next);
+        while (ram_block_is_nvdimm_active(pss->block)) {
+            pss->block = QLIST_NEXT_RCU(pss->block, next);
+        }
         if (!pss->block) {
             /* Hit the end of the list */
             pss->block = QLIST_FIRST_RCU(&ram_list.blocks);
+            while (ram_block_is_nvdimm_active(pss->block)) {
+                pss->block = QLIST_NEXT_RCU(pss->block, next);
+            }
             /* Flag that we've looped */
             pss->complete_round = true;
             rs->ram_bulk_stage = false;
@@ -1541,6 +1547,9 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
 
     if (!pss.block) {
         pss.block = QLIST_FIRST_RCU(&ram_list.blocks);
+        while (ram_block_is_nvdimm_active(pss.block)) {
+            pss.block = QLIST_NEXT_RCU(pss.block, next);
+        }
     }
 
     do {
@@ -1583,6 +1592,10 @@ uint64_t ram_bytes_total(void)
 
     rcu_read_lock();
     RAMBLOCK_FOREACH(block) {
+        if (ram_block_is_nvdimm_active(block)) {
+            // If snapshot and the block is nvdimm, let nvdimm do the job
+            continue;
+        }
         total += block->used_length;
     }
     rcu_read_unlock();
@@ -2222,6 +2235,10 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     qemu_put_be64(f, ram_bytes_total() | RAM_SAVE_FLAG_MEM_SIZE);
 
     RAMBLOCK_FOREACH(block) {
+        if (ram_block_is_nvdimm_active(block)) {
+            // If snapshot and the block is nvdimm, let nvdimm do the job
+            continue;
+        }
         qemu_put_byte(f, strlen(block->idstr));
         qemu_put_buffer(f, (uint8_t *)block->idstr, strlen(block->idstr));
         qemu_put_be64(f, block->used_length);
diff --git a/vl.c b/vl.c
index 3ef04ce..1bd5711 100644
--- a/vl.c
+++ b/vl.c
@@ -4502,6 +4502,7 @@ int main(int argc, char **argv, char **envp)
 
     blk_mig_init();
     ram_mig_init();
+    nvdimm_snapshot_init();
 
     /* If the currently selected machine wishes to override the units-per-bus
      * property of its default HBA interface type, do so now. */
-- 
2.7.4
