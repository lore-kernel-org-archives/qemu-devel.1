Received: from eggs.gnu.org ([2001:4830:134:3::10]:54839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dDYs1-0004Nl-CH
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:10:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dDYrx-0001kW-9m
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:10:45 -0400
Received: from [62.254.189.133] (port=33355 helo=centos.localdomain)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dDYrw-0001eb-Uq
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:10:41 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Wed, 24 May 2017 17:10:03 +0100
Message-Id: <1495642203-12702-5-git-send-email-felipe@nutanix.com>
In-Reply-To: <1495642203-12702-1-git-send-email-felipe@nutanix.com>
References: <1495642203-12702-1-git-send-email-felipe@nutanix.com>
Subject: [Qemu-devel] [PATCH 4/4] migration: use dirty_rate_high_cnt more
 aggressively
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

The commit message from 070afca25 suggests that dirty_rate_high_cnt
should be used more aggressively to start throttling after two
iterations instead of four. The code, however, only changes the auto
convergence behaviour to throttle after three iterations. This makes the
behaviour more aggressive by kicking off throttling after two iterations
as originally intended.

Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
---
 migration/ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 1a3d9e6..26e03a5 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -708,7 +708,7 @@ static void migration_bitmap_sync(RAMState *rs)
 
             if ((rs->num_dirty_pages_period * TARGET_PAGE_SIZE >
                    (bytes_xfer_now - rs->bytes_xfer_prev) / 2) &&
-                (rs->dirty_rate_high_cnt++ >= 2)) {
+                (++rs->dirty_rate_high_cnt >= 2)) {
                     trace_migration_throttle();
                     rs->dirty_rate_high_cnt = 0;
                     mig_throttle_guest_down();
-- 
1.9.5
