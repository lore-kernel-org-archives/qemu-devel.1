Received: from eggs.gnu.org ([2001:4830:134:3::10]:32955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elaFq-0007Yb-34
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 08:04:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elaFp-0006SK-80
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 08:04:14 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 13 Feb 2018 14:03:53 +0100
Message-Id: <20180213130356.8885-5-mreitz@redhat.com>
In-Reply-To: <20180213130356.8885-1-mreitz@redhat.com>
References: <20180213130356.8885-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 4/7] gluster: Add preallocated truncation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, sheepdog@lists.wpkg.org, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>

By using qemu_do_cluster_truncate() in qemu_cluster_truncate(), we now
automatically have preallocated truncation.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/gluster.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index 806b894bc8..3f17b7819d 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1122,23 +1122,8 @@ static coroutine_fn int qemu_gluster_co_rw(BlockDriverState *bs,
 static int qemu_gluster_truncate(BlockDriverState *bs, int64_t offset,
                                  PreallocMode prealloc, Error **errp)
 {
-    int ret;
     BDRVGlusterState *s = bs->opaque;
-
-    if (prealloc != PREALLOC_MODE_OFF) {
-        error_setg(errp, "Unsupported preallocation mode '%s'",
-                   PreallocMode_str(prealloc));
-        return -ENOTSUP;
-    }
-
-    ret = glfs_ftruncate(s->fd, offset);
-    if (ret < 0) {
-        ret = -errno;
-        error_setg_errno(errp, -ret, "Failed to truncate file");
-        return ret;
-    }
-
-    return 0;
+    return qemu_gluster_do_truncate(s->fd, offset, prealloc, errp);
 }
 
 static coroutine_fn int qemu_gluster_co_readv(BlockDriverState *bs,
-- 
2.14.3
