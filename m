Received: from eggs.gnu.org ([2001:4830:134:3::10]:47244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUC3-0000oo-6K
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUBz-00052H-W7
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40825
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUBz-00051Z-Q8
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:43 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0EEWB019727
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:15:42 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cmsfn2vqc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:15:41 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:15:41 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:13:45 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-11-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 10/79] block: Do not unref bs->file on error in
 BD's open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

From: Max Reitz <mreitz@redhat.com>

The block layer takes care of removing the bs->file child if the block
driver's bdrv_open()/bdrv_file_open() implementation fails. The block
driver therefore does not need to do so, and indeed should not unless it
sets bs->file to NULL afterwards -- because if this is not done, the
bdrv_unref_child() in bdrv_open_inherit() will dereference the freed
memory block at bs->file afterwards, which is not good.

We can now decide whether to add a "bs->file = NULL;" after each of the
offending bdrv_unref_child() invocations, or just drop them altogether.
The latter is simpler, so let's do that.

Cc: qemu-stable <qemu-stable@nongnu.org>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit de234897b60e034ba94b307fc289e2dc692c9251)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/blkdebug.c  | 4 +---
 block/blkreplay.c | 3 ---
 block/blkverify.c | 3 ---
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 67e8024..cc4a146 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -389,14 +389,12 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
     } else if (align) {
         error_setg(errp, "Invalid alignment");
         ret = -EINVAL;
-        goto fail_unref;
+        goto out;
     }
 
     ret = 0;
     goto out;
 
-fail_unref:
-    bdrv_unref_child(bs, bs->file);
 out:
     if (ret < 0) {
         g_free(s->config_file);
diff --git a/block/blkreplay.c b/block/blkreplay.c
index e110211..6aa5fd4 100755
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -37,9 +37,6 @@ static int blkreplay_open(BlockDriverState *bs, QDict *options, int flags,
 
     ret = 0;
 fail:
-    if (ret < 0) {
-        bdrv_unref_child(bs, bs->file);
-    }
     return ret;
 }
 
diff --git a/block/blkverify.c b/block/blkverify.c
index 9a1e21c..af23281 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -142,9 +142,6 @@ static int blkverify_open(BlockDriverState *bs, QDict *options, int flags,
 
     ret = 0;
 fail:
-    if (ret < 0) {
-        bdrv_unref_child(bs, bs->file);
-    }
     qemu_opts_del(opts);
     return ret;
 }
-- 
2.7.4
