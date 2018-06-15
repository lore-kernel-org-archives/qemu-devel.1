Received: from eggs.gnu.org ([2001:4830:134:3::10]:48068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTqS0-0004Lu-Ab
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:15:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTqRz-0000nQ-Bv
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:15:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43926 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fTqRz-0000nF-6y
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:15:43 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 15 Jun 2018 16:15:18 +0100
Message-Id: <20180615151518.83637-11-dgilbert@redhat.com>
In-Reply-To: <20180615151518.83637-1-dgilbert@redhat.com>
References: <20180615151518.83637-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 10/10] migration: calculate expected_downtime
 with ram_bytes_remaining()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, groug@kaod.org, vsementsov@virtuozzo.com, xiaoguangrong@tencent.com, bala24@linux.vnet.ibm.com

From: Balamuruhan S <bala24@linux.vnet.ibm.com>

expected_downtime value is not accurate with dirty_pages_rate * page_size,
using ram_bytes_remaining() would yeild it resonable.

consider to read the remaining ram just after having updated the dirty
pages count later migration_bitmap_sync_range() in migration_bitmap_sync()
and reuse the `remaining` field in ram_counters to hold ram_bytes_remaining()
for calculating expected_downtime.

Reported-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20180612085009.17594-2-bala24@linux.vnet.ibm.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 3 +--
 migration/ram.c       | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 108c3d7142..e1eaa97df4 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2746,8 +2746,7 @@ static void migration_update_counters(MigrationState *s,
      * recalculate. 10000 is a small enough number for our purposes
      */
     if (ram_counters.dirty_pages_rate && transferred > 10000) {
-        s->expected_downtime = ram_counters.dirty_pages_rate *
-            qemu_target_page_size() / bandwidth;
+        s->expected_downtime = ram_counters.remaining / bandwidth;
     }
 
     qemu_file_reset_rate_limit(s->to_dst_file);
diff --git a/migration/ram.c b/migration/ram.c
index 225b201aff..cd5f55117d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1180,6 +1180,7 @@ static void migration_bitmap_sync(RAMState *rs)
     RAMBLOCK_FOREACH_MIGRATABLE(block) {
         migration_bitmap_sync_range(rs, block, 0, block->used_length);
     }
+    ram_counters.remaining = ram_bytes_remaining();
     rcu_read_unlock();
     qemu_mutex_unlock(&rs->bitmap_mutex);
 
-- 
2.17.1
