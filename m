Received: from eggs.gnu.org ([2001:4830:134:3::10]:44083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d80Aa-00084j-1s
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d80AT-0007Ws-S5
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:06:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d80AT-0007Vr-LK
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:06:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A9F893D953
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 08:06:48 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  9 May 2017 10:06:26 +0200
Message-Id: <1494317205-2211-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1494317205-2211-1-git-send-email-armbru@redhat.com>
References: <1494317205-2211-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v3 09/28] block: Simplify
 bdrv_append_temp_snapshot() logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

Noticed while checking Coccinelle results. Naming a label 'out:'
when it is only used on error paths is weird.  Also, we had some
dead stores to 'ret'.  Meanwhile we know that snapshot_options
is NULL on success and that QDECREF(NULL) is safe.  So merge the
two exit paths into one by careful control over bs_snapshot.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20170427215821.19397-8-eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/block.c b/block.c
index aae8f7e..a45b9b5 100644
--- a/block.c
+++ b/block.c
@@ -2195,7 +2195,7 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
     char *tmp_filename = g_malloc0(PATH_MAX + 1);
     int64_t total_size;
     QemuOpts *opts = NULL;
-    BlockDriverState *bs_snapshot;
+    BlockDriverState *bs_snapshot = NULL;
     Error *local_err = NULL;
     int ret;
 
@@ -2235,28 +2235,25 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
     bs_snapshot = bdrv_open(NULL, NULL, snapshot_options, flags, errp);
     snapshot_options = NULL;
     if (!bs_snapshot) {
-        ret = -EINVAL;
         goto out;
     }
 
-    /* bdrv_append() consumes a strong reference to bs_snapshot (i.e. it will
-     * call bdrv_unref() on it), so in order to be able to return one, we have
-     * to increase bs_snapshot's refcount here */
+    /* bdrv_append() consumes a strong reference to bs_snapshot
+     * (i.e. it will call bdrv_unref() on it) even on error, so in
+     * order to be able to return one, we have to increase
+     * bs_snapshot's refcount here */
     bdrv_ref(bs_snapshot);
     bdrv_append(bs_snapshot, bs, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        ret = -EINVAL;
+        bs_snapshot = NULL;
         goto out;
     }
 
+out:
+    QDECREF(snapshot_options);
     g_free(tmp_filename);
     return bs_snapshot;
-
-out:
-    QDECREF(snapshot_options);
-    g_free(tmp_filename);
-    return NULL;
 }
 
 /*
-- 
2.7.4
