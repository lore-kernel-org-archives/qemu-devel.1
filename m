Received: from eggs.gnu.org ([2001:4830:134:3::10]:51323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eCndN-0004Sf-TM
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:16:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eCndN-0008QC-1i
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:16:45 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:18818 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eCndM-0008PY-MY
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:16:44 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  9 Nov 2017 17:16:31 +0300
Message-Id: <20171109141631.25688-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] blockdev-backup: enable non-root nodes for
 backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, eblake@redhat.com

This is needed to implement image-fleecing scheme, when we create
a temporary node, mark our active node to be backing for the temp,
and start backup(sync=none) from active node to the temp node.
Temp node then represents a kind of snapshot and may be used
for external backup through NBD.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

What was the reason to abandon non-root nodes?

 blockdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index 56a6b24a0b..d0a5a107f0 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3345,7 +3345,7 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, BlockJobTxn *txn,
         backup->compress = false;
     }
 
-    bs = qmp_get_root_bs(backup->device, errp);
+    bs = bdrv_lookup_bs(backup->device, backup->device, errp);
     if (!bs) {
         return NULL;
     }
-- 
2.11.1
