Received: from eggs.gnu.org ([2001:4830:134:3::10]:33131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFzjN-0007n5-LU
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFzjM-0001wc-S1
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:15:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dFzjM-0001wX-Ll
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:15:52 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 31 May 2017 11:15:38 +0200
Message-Id: <20170531091538.21626-6-quintela@redhat.com>
In-Reply-To: <20170531091538.21626-1-quintela@redhat.com>
References: <20170531091538.21626-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 5/5] migration: use dirty_rate_high_cnt more
 aggressively
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Felipe Franciosi <felipe@nutanix.com>

From: Felipe Franciosi <felipe@nutanix.com>

The commit message from 070afca25 suggests that dirty_rate_high_cnt
should be used more aggressively to start throttling after two
iterations instead of four. The code, however, only changes the auto
convergence behaviour to throttle after three iterations. This makes the
behaviour more aggressive by kicking off throttling after two iterations
as originally intended.

Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
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
2.9.4
