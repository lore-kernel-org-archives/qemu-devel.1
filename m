Received: from eggs.gnu.org ([2001:4830:134:3::10]:46010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3rR4-0001VQ-7B
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 17:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3rR3-0003l1-Ec
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 17:58:50 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 27 Apr 2017 16:58:18 -0500
Message-Id: <20170427215821.19397-8-eblake@redhat.com>
In-Reply-To: <20170427215821.19397-1-eblake@redhat.com>
References: <20170427215821.19397-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 07/10] block: Simplify
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
Cc: armbru@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

Noticed while checking Coccinelle results. Naming a label 'out:'
when it is only used on error paths is weird.  Also, we had some
dead stores to 'ret'.  Meanwhile we know that snapshot_options
is NULL on success and that QDECREF(NULL) is safe.  So merge the
two exit paths into one by careful control over bs_snapshot.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>

---
v5: add R-b
v4: fix -O2 compilation bug, kill dead 'ret'
v3: split out from bigger v2 patch
---
 block.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/block.c b/block.c
index 5b70f58..1ee9db2 100644
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
2.9.3
