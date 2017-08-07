Received: from eggs.gnu.org ([2001:4830:134:3::10]:45892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1deofb-0007Iq-1M
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 16:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1deofW-00049I-8f
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 16:30:35 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  7 Aug 2017 15:30:06 -0500
Message-Id: <20170807203007.19033-4-eblake@redhat.com>
In-Reply-To: <20170807203007.19033-1-eblake@redhat.com>
References: <20170807203007.19033-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] qcow2: Drop debugging dump_refcounts()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

It's been #if 0'd since its introduction in 2006, commit 585f8587.
We can revive dead code if we need it, but in the meantime, it has
bit-rotted (for example, not checking for failure in bdrv_getlength()).

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index d7c600b5a2..99407403ea 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3798,27 +3798,6 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs)
     return spec_info;
 }

-#if 0
-static void dump_refcounts(BlockDriverState *bs)
-{
-    BDRVQcow2State *s = bs->opaque;
-    int64_t nb_clusters, k, k1, size;
-    int refcount;
-
-    size = bdrv_getlength(bs->file->bs);
-    nb_clusters = size_to_clusters(s, size);
-    for(k = 0; k < nb_clusters;) {
-        k1 = k;
-        refcount = get_refcount(bs, k);
-        k++;
-        while (k < nb_clusters && get_refcount(bs, k) == refcount)
-            k++;
-        printf("%" PRId64 ": refcount=%d nb=%" PRId64 "\n", k, refcount,
-               k - k1);
-    }
-}
-#endif
-
 static int qcow2_save_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
                               int64_t pos)
 {
-- 
2.13.4
