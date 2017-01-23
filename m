Received: from eggs.gnu.org ([2001:4830:134:3::10]:41256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cVdnE-0004Fi-CD
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:32:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cVdnD-0005wH-JY
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:32:16 -0500
From: Fam Zheng <famz@redhat.com>
Date: Mon, 23 Jan 2017 20:30:45 +0800
Message-Id: <20170123123056.30383-6-famz@redhat.com>
In-Reply-To: <20170123123056.30383-1-famz@redhat.com>
References: <20170123123056.30383-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v12 05/16] block: Set "share-rw" flag in
 drive-backup when sync=none
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com, Max Reitz <mreitz@redhat.com>

In this case we may open the source's backing image chain multiple
times. Setting share flag means the new open won't try to acquire or
check any lock, once we implement image locking.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 blockdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/blockdev.c b/blockdev.c
index 245e1e1..c97e97f 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3177,6 +3177,9 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
     }
     if (backup->sync == MIRROR_SYNC_MODE_NONE) {
         source = bs;
+        /* FIXME: block layer should really open target with BDRV_O_NO_BACKING
+         * and reuse source's backing chain, if they share one. */
+        flags |= BDRV_O_SHARE_RW;
     }
 
     size = bdrv_getlength(bs);
-- 
2.9.3
