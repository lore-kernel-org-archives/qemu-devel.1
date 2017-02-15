Received: from eggs.gnu.org ([2001:4830:134:3::10]:40769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cdxTB-0002Rm-2W
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 06:09:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cdxT5-0002Bj-JU
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 06:09:56 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:23646 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cdxT5-0002BV-76
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 06:09:51 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 15 Feb 2017 14:09:45 +0300
Message-Id: <1487156985-18321-1-git-send-email-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2] backup: allow target without .bdrv_get_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, stefanha@redhat.com

Currently backup to nbd target is broken, as nbd doesn't have
.bdrv_get_info realization.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

v2: add WARNING

===

Since commit

commit 4c9bca7e39a6e07ad02c1dcde3478363344ec60b
Author: John Snow <jsnow@redhat.com>
Date:   Thu Feb 25 15:58:30 2016 -0500

    block/backup: avoid copying less than full target clusters

backup to nbd target is broken, we have "Couldn't determine the cluster size of
the target image".

Proposed NBD protocol extension - NBD_OPT_INFO should finally solve this problem.
But until it is not realized, we need allow backup to nbd target due to backward
compatibility.

Furthermore, is it entirely ok to disallow backup if bds lacks .bdrv_get_info?
Which behavior should be default: to fail backup or to use default cluster size?

 block/backup.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/backup.c b/block/backup.c
index ea38733..a464b63 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -638,7 +638,15 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
      * backup cluster size is smaller than the target cluster size. Even for
      * targets with a backing file, try to avoid COW if possible. */
     ret = bdrv_get_info(target, &bdi);
-    if (ret < 0 && !target->backing) {
+    if (ret == -ENOTSUP) {
+        /* Cluster size is not defined */
+        error_report("WARNING: Target block device doesn't provide information "
+                     "about block size and it doesn't have backing file. "
+                     "Default block size of %u bytes is used. If actual block "
+                     "size of target exceeds this default, destination image "
+                     "may become unusable");
+        job->cluster_size = BACKUP_CLUSTER_SIZE_DEFAULT;
+    } else if (ret < 0 && !target->backing) {
         error_setg_errno(errp, -ret,
             "Couldn't determine the cluster size of the target image, "
             "which has no backing file");
-- 
1.8.3.1
