Received: from eggs.gnu.org ([2001:4830:134:3::10]:40115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cih5v-0008It-Gi
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cih5s-0000KN-E6
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cih5s-0000KE-7f
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:28 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 28 Feb 2017 12:40:43 +0000
Message-Id: <20170228124056.5074-15-dgilbert@redhat.com>
In-Reply-To: <20170228124056.5074-1-dgilbert@redhat.com>
References: <20170228124056.5074-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 14/27] postcopy: Chunk discards for hugepages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, lvivier@redhat.com, marcandre.lureau@redhat.com, vsementsov@virtuozzo.com, danielhb@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, ashijeetacharya@gmail.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

At the start of the postcopy phase, partially sent huge pages
must be discarded.  The code for dealing with host page sizes larger
than the target page size can be reused for this case.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20170224182844.32452-4-dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index fbd987a..7c5cdf9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1672,12 +1672,17 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
 {
     unsigned long *bitmap;
     unsigned long *unsentmap;
-    unsigned int host_ratio = qemu_host_page_size / TARGET_PAGE_SIZE;
+    unsigned int host_ratio = block->page_size / TARGET_PAGE_SIZE;
     unsigned long first = block->offset >> TARGET_PAGE_BITS;
     unsigned long len = block->used_length >> TARGET_PAGE_BITS;
     unsigned long last = first + (len - 1);
     unsigned long run_start;
 
+    if (block->page_size == TARGET_PAGE_SIZE) {
+        /* Easy case - TPS==HPS for a non-huge page RAMBlock */
+        return;
+    }
+
     bitmap = atomic_rcu_read(&migration_bitmap_rcu)->bmap;
     unsentmap = atomic_rcu_read(&migration_bitmap_rcu)->unsentmap;
 
@@ -1781,7 +1786,8 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
  * Utility for the outgoing postcopy code.
  *
  * Discard any partially sent host-page size chunks, mark any partially
- * dirty host-page size chunks as all dirty.
+ * dirty host-page size chunks as all dirty.  In this case the host-page
+ * is the host-page for the particular RAMBlock, i.e. it might be a huge page
  *
  * Returns: 0 on success
  */
@@ -1789,11 +1795,6 @@ static int postcopy_chunk_hostpages(MigrationState *ms)
 {
     struct RAMBlock *block;
 
-    if (qemu_host_page_size == TARGET_PAGE_SIZE) {
-        /* Easy case - TPS==HPS - nothing to be done */
-        return 0;
-    }
-
     /* Easiest way to make sure we don't resume in the middle of a host-page */
     last_seen_block = NULL;
     last_sent_block = NULL;
@@ -1849,7 +1850,7 @@ int ram_postcopy_send_discard_bitmap(MigrationState *ms)
         return -EINVAL;
     }
 
-    /* Deal with TPS != HPS */
+    /* Deal with TPS != HPS and huge pages */
     ret = postcopy_chunk_hostpages(ms);
     if (ret) {
         rcu_read_unlock();
-- 
2.9.3
