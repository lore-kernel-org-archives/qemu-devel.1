Received: from eggs.gnu.org ([2001:4830:134:3::10]:45770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1ctZAq-0003s1-9L
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 08:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1ctZAl-0008O3-Dc
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 08:27:32 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:35944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1ctZAl-0008NY-8V
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 08:27:27 -0400
Received: by mail-pg0-x244.google.com with SMTP id 81so9668501pgh.3
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 05:27:27 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 30 Mar 2017 05:27:14 -0700
Message-Id: <1490876834-61392-1-git-send-email-liqiang6-s@360.cn>
Subject: [Qemu-devel] [PATCH] 9pfs: fix migration_block leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org
Cc: qemu-devel@nongnu.org, ppandit@redhat.com, Li Qiang <liqiang6-s@360.cn>

The guest can leave the pdu->s->migration_blocker exists by attach
but not remove a fid. Then if we hot unplug the 9pfs device, the
v9fs_reset() just free the fids, but not free the migration_blocker.
This will leak a memory leak. This patch avoid this.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
---
 hw/9pfs/9p.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 48babce..b55c02d 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -548,6 +548,12 @@ static void coroutine_fn virtfs_reset(V9fsPDU *pdu)
             free_fid(pdu, fidp);
         }
     }
+
+    if (pdu->s->migration_blocker) {
+        migrate_del_blocker(pdu->s->migration_blocker);
+        error_free(pdu->s->migration_blocker);
+        pdu->s->migration_blocker = NULL;
+    }
 }
 
 #define P9_QID_TYPE_DIR         0x80
-- 
1.8.3.1
