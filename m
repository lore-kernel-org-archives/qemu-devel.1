Received: from eggs.gnu.org ([2001:4830:134:3::10]:39150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1euMEP-00085b-OP
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:55:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1euMEO-0003MW-W1
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:55:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46064 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1euMEO-0003MH-RQ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:55:00 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  9 Mar 2018 17:54:51 +0000
Message-Id: <20180309175453.41548-5-dgilbert@redhat.com>
In-Reply-To: <20180309175453.41548-1-dgilbert@redhat.com>
References: <20180309175453.41548-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 4/6] migration/block: rename MAX_INFLIGHT_IO to
 MAX_IO_BUFFERS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pl@kamp.de, peterx@redhat.com, quintela@redhat.com

From: Peter Lieven <pl@kamp.de>

this actually limits (as the original commit mesage suggests) the
number of I/O buffers that can be allocated and not the number
of parallel (inflight) I/O requests.

Signed-off-by: Peter Lieven <pl@kamp.de>
Message-Id: <1520507908-16743-4-git-send-email-pl@kamp.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/block.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index 87bb35ce63..41b95d1dd8 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -36,7 +36,7 @@
 
 #define MAX_IS_ALLOCATED_SEARCH (65536 * BDRV_SECTOR_SIZE)
 
-#define MAX_INFLIGHT_IO 512
+#define MAX_IO_BUFFERS 512
 
 //#define DEBUG_BLK_MIGRATION
 
@@ -775,9 +775,8 @@ static int block_save_iterate(QEMUFile *f, void *opaque)
     while ((block_mig_state.submitted +
             block_mig_state.read_done) * BLOCK_SIZE <
            qemu_file_get_rate_limit(f) &&
-           (block_mig_state.submitted +
-            block_mig_state.read_done) <
-           MAX_INFLIGHT_IO) {
+           (block_mig_state.submitted + block_mig_state.read_done) <
+           MAX_IO_BUFFERS) {
         blk_mig_unlock();
         if (block_mig_state.bulk_completed == 0) {
             /* first finish the bulk phase */
-- 
2.14.3
