Received: from eggs.gnu.org ([2001:4830:134:3::10]:40285)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1ettZJ-0004Wk-KU
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:18:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1ettZG-0001zN-E2
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:18:41 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:34310 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1ettZG-0001yV-4q
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:18:38 -0500
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	for qemu-devel@nongnu.org; Thu, 8 Mar 2018 12:18:28 +0100
From: Peter Lieven <pl@kamp.de>
Date: Thu,  8 Mar 2018 12:18:26 +0100
Message-Id: <1520507908-16743-4-git-send-email-pl@kamp.de>
In-Reply-To: <1520507908-16743-1-git-send-email-pl@kamp.de>
References: <1520507908-16743-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH 3/5] migration/block: rename MAX_INFLIGHT_IO to
 MAX_IO_BUFFERS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, famz@redhat.com, stefanha@redhat.com, jjherne@linux.vnet.ibm.com, Peter Lieven <pl@kamp.de>

this actually limits (as the original commit mesage suggests) the
number of I/O buffers that can be allocated and not the number
of parallel (inflight) I/O requests.

Signed-off-by: Peter Lieven <pl@kamp.de>
---
 migration/block.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index 87bb35c..41b95d1 100644
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
2.7.4
