Received: from eggs.gnu.org ([2001:4830:134:3::10]:58002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dBpvp-0002Tt-9U
	for qemu-devel@nongnu.org; Fri, 19 May 2017 17:59:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dBpvm-0003Zi-81
	for qemu-devel@nongnu.org; Fri, 19 May 2017 17:59:33 -0400
Received: from [62.254.189.133] (port=52428 helo=centos.localdomain)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dBpvl-0003P2-Sz
	for qemu-devel@nongnu.org; Fri, 19 May 2017 17:59:30 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Fri, 19 May 2017 22:59:02 +0100
Message-Id: <1495231142-19055-1-git-send-email-felipe@nutanix.com>
Subject: [Qemu-devel] [PATCH] migration: keep bytes_xfer_prev init'd to zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Felipe Franciosi <felipe@nutanix.com>

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
~
---
 migration/ram.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index f59fdd4..793af39 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -670,10 +670,6 @@ static void migration_bitmap_sync(RAMState *rs)
 
     rs->bitmap_sync_count++;
 
-    if (!rs->bytes_xfer_prev) {
-        rs->bytes_xfer_prev = ram_bytes_transferred();
-    }
-
     if (!rs->time_last_bitmap_sync) {
         rs->time_last_bitmap_sync = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     }
-- 
1.9.5
