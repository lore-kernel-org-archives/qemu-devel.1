Received: from eggs.gnu.org ([2001:4830:134:3::10]:54842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dDYs1-0004Nn-Cd
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:10:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dDYrx-0001kX-AY
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:10:45 -0400
Received: from [62.254.189.133] (port=14873 helo=centos.localdomain)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dDYrw-0001eK-V4
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:10:41 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Wed, 24 May 2017 17:10:02 +0100
Message-Id: <1495642203-12702-4-git-send-email-felipe@nutanix.com>
In-Reply-To: <1495642203-12702-1-git-send-email-felipe@nutanix.com>
References: <1495642203-12702-1-git-send-email-felipe@nutanix.com>
Subject: [Qemu-devel] [PATCH 3/4] migration: set bytes_xfer_* outside of
 autoconverge logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, amit Shah <amit.shah@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Malcolm Crossley <malcolm@nutanix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Felipe Franciosi <felipe@nutanix.com>

The bytes_xfer_now/prev counters are only used by the auto convergence
logic. However, they are used alongside the dirty_pages_rate counter,
which is calculated (and required) outside of this logic. The problem
with this approach is that if the auto convergence capability is changed
while a migration is ongoing, the relationship of the counters will be
broken.

This moves the management of bytes_xfer_now/prev counters outside of the
auto convergence logic to address this issue.

Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
---
 migration/ram.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 495ecbe..1a3d9e6 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -697,6 +697,7 @@ static void migration_bitmap_sync(RAMState *rs)
         /* calculate period counters */
         rs->dirty_pages_rate = rs->num_dirty_pages_period * 1000
             / (end_time - rs->time_last_bitmap_sync);
+        bytes_xfer_now = ram_bytes_transferred();
 
         if (migrate_auto_converge()) {
             /* The following detection logic can be refined later. For now:
@@ -704,7 +705,6 @@ static void migration_bitmap_sync(RAMState *rs)
                amount of bytes that just got transferred since the last time we
                were in this routine. If that happens twice, start or increase
                throttling */
-            bytes_xfer_now = ram_bytes_transferred();
 
             if ((rs->num_dirty_pages_period * TARGET_PAGE_SIZE >
                    (bytes_xfer_now - rs->bytes_xfer_prev) / 2) &&
@@ -713,7 +713,6 @@ static void migration_bitmap_sync(RAMState *rs)
                     rs->dirty_rate_high_cnt = 0;
                     mig_throttle_guest_down();
             }
-            rs->bytes_xfer_prev = bytes_xfer_now;
         }
 
         if (migrate_use_xbzrle()) {
@@ -730,6 +729,7 @@ static void migration_bitmap_sync(RAMState *rs)
         /* reset period counters */
         rs->time_last_bitmap_sync = end_time;
         rs->num_dirty_pages_period = 0;
+        rs->bytes_xfer_prev = bytes_xfer_now;
     }
     if (migrate_use_events()) {
         qapi_event_send_migration_pass(rs->bitmap_sync_count, NULL);
-- 
1.9.5
