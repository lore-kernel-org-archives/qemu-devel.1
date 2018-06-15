Received: from eggs.gnu.org ([2001:4830:134:3::10]:48050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTqRy-0004LC-T2
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:15:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTqRx-0000mr-Uk
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:15:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52348 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fTqRx-0000mi-Pw
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:15:41 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 15 Jun 2018 16:15:17 +0100
Message-Id: <20180615151518.83637-10-dgilbert@redhat.com>
In-Reply-To: <20180615151518.83637-1-dgilbert@redhat.com>
References: <20180615151518.83637-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 09/10] migration/postcopy: Wake rate limit sleep
 on postcopy request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, groug@kaod.org, vsementsov@virtuozzo.com, xiaoguangrong@tencent.com, bala24@linux.vnet.ibm.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Use the 'urgent request' mechanism added in the previous patch
for entries added to the postcopy request queue for RAM.  Ignore
the rate limiting while we have requests.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20180613102642.23995-4-dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 77071a43ed..225b201aff 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1547,6 +1547,7 @@ static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset)
             memory_region_unref(block->mr);
             QSIMPLEQ_REMOVE_HEAD(&rs->src_page_requests, next_req);
             g_free(entry);
+            migration_consume_urgent_request();
         }
     }
     qemu_mutex_unlock(&rs->src_page_req_mutex);
@@ -1695,6 +1696,7 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
     memory_region_ref(ramblock->mr);
     qemu_mutex_lock(&rs->src_page_req_mutex);
     QSIMPLEQ_INSERT_TAIL(&rs->src_page_requests, new_entry, next_req);
+    migration_make_urgent_request();
     qemu_mutex_unlock(&rs->src_page_req_mutex);
     rcu_read_unlock();
 
@@ -2643,9 +2645,14 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
 
     t0 = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
     i = 0;
-    while ((ret = qemu_file_rate_limit(f)) == 0) {
+    while ((ret = qemu_file_rate_limit(f)) == 0 ||
+            !QSIMPLEQ_EMPTY(&rs->src_page_requests)) {
         int pages;
 
+        if (qemu_file_get_error(f)) {
+            break;
+        }
+
         pages = ram_find_and_save_block(rs, false);
         /* no more pages to sent */
         if (pages == 0) {
-- 
2.17.1
