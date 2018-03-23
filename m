Received: from eggs.gnu.org ([2001:4830:134:3::10]:42285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ezTED-0000b2-EL
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:23:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ezTEC-0003p4-JS
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:23:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35470 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ezTEC-0003ot-E3
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:23:56 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 23 Mar 2018 20:23:43 +0000
Message-Id: <20180323202344.70640-5-dgilbert@redhat.com>
In-Reply-To: <20180323202344.70640-1-dgilbert@redhat.com>
References: <20180323202344.70640-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 4/5] migration/block: compare only read blocks
 against the rate limiter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, berrange@redhat.com, lidongchen@tencent.com, pl@kamp.de, peterx@redhat.com

From: Peter Lieven <pl@kamp.de>

only read_done blocks are in the queued to be flushed to the migration
stream. submitted blocks are still in flight.

Signed-off-by: Peter Lieven <pl@kamp.de>
Message-Id: <1520507908-16743-6-git-send-email-pl@kamp.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/block.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index 03bbba61cb..4c04d937b1 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -773,8 +773,7 @@ static int block_save_iterate(QEMUFile *f, void *opaque)
 
     /* control the rate of transfer */
     blk_mig_lock();
-    while ((block_mig_state.submitted +
-            block_mig_state.read_done) * BLOCK_SIZE <
+    while (block_mig_state.read_done * BLOCK_SIZE <
            qemu_file_get_rate_limit(f) &&
            block_mig_state.submitted < MAX_PARALLEL_IO &&
            (block_mig_state.submitted + block_mig_state.read_done) <
-- 
2.14.3
