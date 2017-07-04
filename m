Received: from eggs.gnu.org ([2001:4830:134:3::10]:34560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dSSt8-0003cL-G5
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:49:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dSSt7-0001Ti-Kl
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:49:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dSSt7-0001T7-EX
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:49:29 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  4 Jul 2017 19:49:15 +0100
Message-Id: <20170704184915.31586-6-dgilbert@redhat.com>
In-Reply-To: <20170704184915.31586-1-dgilbert@redhat.com>
References: <20170704184915.31586-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] migration/rdma: Send error during
 cancelling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, michael@hinespot.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, berrange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

When we issue a cancel and clean up the RDMA channel
send a CONTROL_ERROR to get the destination to quit.

The rdma_cleanup code waits for the event to come back
from the rdma_disconnect; but that wont happen until the
destination quits and there's currently nothing to force
it.

Note this makes the case of a cancel work while the destination
is alive, and it already works if the destination is
truly dead.  Note it doesn't fix the case where the destination
is hung (we get stuck waiting for the rdma_disconnect event).

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/rdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index bfb0a43740..3d17db3a23 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2260,7 +2260,9 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
     int ret, idx;
 
     if (rdma->cm_id && rdma->connected) {
-        if (rdma->error_state && !rdma->received_error) {
+        if ((rdma->error_state ||
+             migrate_get_current()->state == MIGRATION_STATUS_CANCELLING) &&
+            !rdma->received_error) {
             RDMAControlHeader head = { .len = 0,
                                        .type = RDMA_CONTROL_ERROR,
                                        .repeat = 1,
-- 
2.13.0
