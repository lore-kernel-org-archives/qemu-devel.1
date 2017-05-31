Received: from eggs.gnu.org ([2001:4830:134:3::10]:33055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFzjI-0007jk-4H
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFzjH-0001r5-8t
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:15:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dFzjH-0001qy-2t
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:15:47 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 31 May 2017 11:15:35 +0200
Message-Id: <20170531091538.21626-3-quintela@redhat.com>
In-Reply-To: <20170531091538.21626-1-quintela@redhat.com>
References: <20170531091538.21626-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] migration: keep bytes_xfer_prev init'd to
 zero
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

The first time migration_bitmap_sync() is called, bytes_xfer_prev is set
to ram_state.bytes_transferred which is, at this point, zero. The next
time migration_bitmap_sync() is called, an iteration has happened and
bytes_xfer_prev is set to 'x' bytes. Most likely, more than one second
has passed, so the auto converge logic will be triggered and
bytes_xfer_now will also be set to 'x' bytes.

This condition is currently masked by dirty_rate_high_cnt, which will
wait for a few iterations before throttling. It would otherwise always
assume zero bytes have been copied and therefore throttle the guest
(possibly) prematurely.

Given bytes_xfer_prev is only used by the auto convergence logic, it
makes sense to only set its value after a check has been made against
bytes_xfer_now.

Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index c07a9c0..36bf720 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -673,10 +673,6 @@ static void migration_bitmap_sync(RAMState *rs)
 
     rs->bitmap_sync_count++;
 
-    if (!rs->bytes_xfer_prev) {
-        rs->bytes_xfer_prev = ram_bytes_transferred();
-    }
-
     if (!rs->time_last_bitmap_sync) {
         rs->time_last_bitmap_sync = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     }
-- 
2.9.4
