Received: from eggs.gnu.org ([2001:4830:134:3::10]:38486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fYbDw-00082S-Ex
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 14:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fYbDv-0003r6-NE
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 14:00:52 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 28 Jun 2018 14:00:41 -0400
Message-Id: <20180628180042.3881-2-jsnow@redhat.com>
In-Reply-To: <20180628180042.3881-1-jsnow@redhat.com>
References: <20180628180042.3881-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] block: allow blockdev-backup from any
 source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, eblake@redhat.com, Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>

In the case of image fleecing, the node we choose as the source
for a blockdev-backup is going to be both a root node AND the
backing node for the exported image. It does not qualify as a root
image in this case.

Loosen the restriction.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index 58d7570932..526f8b60be 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3517,7 +3517,7 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, JobTxn *txn,
         backup->compress = false;
     }
 
-    bs = qmp_get_root_bs(backup->device, errp);
+    bs = bdrv_lookup_bs(backup->device, backup->device, errp);
     if (!bs) {
         return NULL;
     }
-- 
2.14.4
