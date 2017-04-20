Received: from eggs.gnu.org ([2001:4830:134:3::10]:55699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d16uR-0007j4-SA
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d16uR-0003gP-5h
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:53:47 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 20 Apr 2017 15:52:34 +0800
Message-Id: <20170420075237.18219-18-famz@redhat.com>
In-Reply-To: <20170420075237.18219-1-famz@redhat.com>
References: <20170420075237.18219-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v13 17/20] block: Workaround drive-backup
 sync=none for image locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 blockdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/blockdev.c b/blockdev.c
index 4927914..5831b95 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3223,6 +3223,9 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
         }
     }
     if (backup->sync == MIRROR_SYNC_MODE_NONE) {
+        /* FIXME: block layer should really open target with BDRV_O_NO_BACKING
+         * and reuse source's backing chain, if they share one. */
+        flags |= BDRV_O_UNSAFE_READ;
         source = bs;
     }
 
-- 
2.9.3
