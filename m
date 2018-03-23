Received: from eggs.gnu.org ([2001:4830:134:3::10]:42268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ezTEC-0000aq-7v
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:23:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ezTEB-0003oO-8P
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:23:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40982 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ezTEB-0003o9-3v
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:23:55 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 23 Mar 2018 20:23:42 +0000
Message-Id: <20180323202344.70640-4-dgilbert@redhat.com>
In-Reply-To: <20180323202344.70640-1-dgilbert@redhat.com>
References: <20180323202344.70640-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 3/5] migration/block: limit the number of
 parallel I/O requests
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

the current implementation submits up to 512 I/O requests in parallel
which is much to high especially for a background task.
This patch adds a maximum limit of 16 I/O requests that can
be submitted in parallel to avoid monopolizing the I/O device.

Signed-off-by: Peter Lieven <pl@kamp.de>
Message-Id: <1520507908-16743-5-git-send-email-pl@kamp.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/block.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/block.c b/migration/block.c
index 5c03632257..03bbba61cb 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -37,6 +37,7 @@
 #define MAX_IS_ALLOCATED_SEARCH (65536 * BDRV_SECTOR_SIZE)
 
 #define MAX_IO_BUFFERS 512
+#define MAX_PARALLEL_IO 16
 
 //#define DEBUG_BLK_MIGRATION
 
@@ -775,6 +776,7 @@ static int block_save_iterate(QEMUFile *f, void *opaque)
     while ((block_mig_state.submitted +
             block_mig_state.read_done) * BLOCK_SIZE <
            qemu_file_get_rate_limit(f) &&
+           block_mig_state.submitted < MAX_PARALLEL_IO &&
            (block_mig_state.submitted + block_mig_state.read_done) <
            MAX_IO_BUFFERS) {
         blk_mig_unlock();
-- 
2.14.3
