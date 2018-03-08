Received: from eggs.gnu.org ([2001:4830:134:3::10]:40288)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1ettZJ-0004Wn-Ki
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:18:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1ettZG-0001zV-Eq
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:18:41 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:48332 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1ettZG-0001yY-5G
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:18:38 -0500
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	for qemu-devel@nongnu.org; Thu, 8 Mar 2018 12:18:28 +0100
From: Peter Lieven <pl@kamp.de>
Date: Thu,  8 Mar 2018 12:18:28 +0100
Message-Id: <1520507908-16743-6-git-send-email-pl@kamp.de>
In-Reply-To: <1520507908-16743-1-git-send-email-pl@kamp.de>
References: <1520507908-16743-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH 5/5] migration/block: compare only read blocks
 against the rate limiter
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

only read_done blocks are in the queued to be flushed to the migration
stream. submitted blocks are still in flight.

Signed-off-by: Peter Lieven <pl@kamp.de>
---
 migration/block.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index ce939e2..4e950c2 100644
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
2.7.4
