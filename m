Received: from eggs.gnu.org ([209.51.188.92]:34778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hMCFF-0002N0-9S
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:59:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hMCF7-0008Mc-8p
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:59:22 -0400
From: Sam Eiderman <shmuel.eiderman@oracle.com>
Date: Thu,  2 May 2019 16:58:27 +0300
Message-Id: <20190502135828.42797-3-shmuel.eiderman@oracle.com>
In-Reply-To: <20190502135828.42797-1-shmuel.eiderman@oracle.com>
References: <20190502085029.30776-1-shmuel.eiderman@oracle.com>
	<20190502135828.42797-1-shmuel.eiderman@oracle.com>
Subject: [Qemu-devel] [PATCH v2 2/3] qemu-img: rebase: Reduce reads on
 in-chain rebase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: shmuel.eiderman@oracle.com, eyal.moscovici@oracle.com, sagi.amit@oracle.com, karl.heubaum@oracle.com, liran.alon@oracle.com, arbel.moshe@oracle.com

In the following case:

(base) A <- B <- C (tip)

when running:

    qemu-img rebase -b A C

QEMU would read all sectors not allocated in the file being rebased (C)
and compare them to the new base image (A), regardless of whether they
were changed or even allocated anywhere along the chain between the new
base and the top image (B). This causes many unneeded reads when
rebasing an image which represents a small diff of a large disk, as it
would read most of the disk's sectors.

Instead, use bdrv_is_allocated_above() to reduce the number of
unnecessary reads.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
Signed-off-by: Eyal Moscovici <eyal.moscovici@oracle.com>
---
 qemu-img.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index d9b609b3f0..7f20858cb9 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3152,7 +3152,7 @@ static int img_rebase(int argc, char **argv)
     BlockBackend *blk = NULL, *blk_old_backing = NULL, *blk_new_backing = NULL;
     uint8_t *buf_old = NULL;
     uint8_t *buf_new = NULL;
-    BlockDriverState *bs = NULL;
+    BlockDriverState *bs = NULL, *prefix_chain_bs = NULL;
     char *filename;
     const char *fmt, *cache, *src_cache, *out_basefmt, *out_baseimg;
     int c, flags, src_flags, ret;
@@ -3343,6 +3343,12 @@ static int img_rebase(int argc, char **argv)
                 goto out;
             }
 
+            /*
+             * Find out whether we rebase an image on top of a previous image
+             * in its chain.
+             */
+            prefix_chain_bs = bdrv_find_backing_image(bs, out_real_path);
+
             blk_new_backing = blk_new_open(out_real_path, NULL,
                                            options, src_flags, &local_err);
             g_free(out_real_path);
@@ -3422,6 +3428,23 @@ static int img_rebase(int argc, char **argv)
                 continue;
             }
 
+            if (prefix_chain_bs) {
+                /*
+                 * If cluster wasn't changed since prefix_chain, we don't need
+                 * to take action
+                 */
+                ret = bdrv_is_allocated_above(bs, prefix_chain_bs,
+                                              offset, n, &n);
+                if (ret < 0) {
+                    error_report("error while reading image metadata: %s",
+                                 strerror(-ret));
+                    goto out;
+                }
+                if (!ret) {
+                    continue;
+                }
+            }
+
             /*
              * Read old and new backing file and take into consideration that
              * backing files may be smaller than the COW image.
-- 
2.13.3
