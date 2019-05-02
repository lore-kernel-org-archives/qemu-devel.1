Received: from eggs.gnu.org ([209.51.188.92]:34745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hMCF7-0002Gi-FT
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hMCF6-0008MF-BN
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:59:21 -0400
From: Sam Eiderman <shmuel.eiderman@oracle.com>
Date: Thu,  2 May 2019 16:58:28 +0300
Message-Id: <20190502135828.42797-4-shmuel.eiderman@oracle.com>
In-Reply-To: <20190502135828.42797-1-shmuel.eiderman@oracle.com>
References: <20190502085029.30776-1-shmuel.eiderman@oracle.com>
	<20190502135828.42797-1-shmuel.eiderman@oracle.com>
Subject: [Qemu-devel] [PATCH v2 3/3] qemu-img: rebase: Reuse in-chain
 BlockDriverState
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

If a chain was detected, don't open a new BlockBackend from the target
backing file which will create a new BlockDriverState. Instead, create
an empty BlockBackend and attach the already open BlockDriverState.

Permissions for blk_new() were copied from blk_new_open() when
flags = 0.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Eyal Moscovici <eyal.moscovici@oracle.com>
Signed-off-by: Sagi Amit <sagi.amit@oracle.com>
Co-developed-by: Sagi Amit <sagi.amit@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 qemu-img.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 7f20858cb9..b32884bfc5 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3348,16 +3348,29 @@ static int img_rebase(int argc, char **argv)
              * in its chain.
              */
             prefix_chain_bs = bdrv_find_backing_image(bs, out_real_path);
-
-            blk_new_backing = blk_new_open(out_real_path, NULL,
-                                           options, src_flags, &local_err);
-            g_free(out_real_path);
-            if (!blk_new_backing) {
-                error_reportf_err(local_err,
-                                  "Could not open new backing file '%s': ",
-                                  out_baseimg);
-                ret = -1;
-                goto out;
+            if (prefix_chain_bs) {
+                g_free(out_real_path);
+                blk_new_backing = blk_new(BLK_PERM_CONSISTENT_READ,
+                                          BLK_PERM_ALL);
+                ret = blk_insert_bs(blk_new_backing, prefix_chain_bs,
+                                    &local_err);
+                if (ret < 0) {
+                    error_reportf_err(local_err,
+                                      "Could not reuse backing file '%s': ",
+                                      out_baseimg);
+                    goto out;
+                }
+            } else {
+                blk_new_backing = blk_new_open(out_real_path, NULL,
+                                               options, src_flags, &local_err);
+                g_free(out_real_path);
+                if (!blk_new_backing) {
+                    error_reportf_err(local_err,
+                                      "Could not open new backing file '%s': ",
+                                      out_baseimg);
+                    ret = -1;
+                    goto out;
+                }
             }
         }
     }
-- 
2.13.3
