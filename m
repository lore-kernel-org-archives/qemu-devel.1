Received: from eggs.gnu.org ([209.51.188.92]:52021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hM7R5-0000WS-RV
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:51:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hM7R4-0000ZJ-HX
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:51:23 -0400
From: Sam Eiderman <shmuel.eiderman@oracle.com>
Date: Thu,  2 May 2019 11:50:27 +0300
Message-Id: <20190502085029.30776-2-shmuel.eiderman@oracle.com>
In-Reply-To: <20190502085029.30776-1-shmuel.eiderman@oracle.com>
References: <20190502085029.30776-1-shmuel.eiderman@oracle.com>
Subject: [Qemu-devel] [PATCH 1/3] qemu-img: rebase: Reuse parent
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

In safe mode we open the entire chain, including the parent backing
file of the rebased file.
Do not open a new BlockBackend for the parent backing file, which
saves opening the rest of the chain twice, which for long chains
saves many "pricy" bdrv_open() calls.

Permissions for blk_new() were copied from blk_new_open() when
flags = 0.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Eyal Moscovici <eyal.moscovici@oracle.com>
Signed-off-by: Sagi Amit <sagi.amit@oracle.com>
Co-developed-by: Sagi Amit <sagi.amit@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 qemu-img.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 8ee63daeae..d9b609b3f0 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3297,28 +3297,23 @@ static int img_rebase(int argc, char **argv)
 
     /* For safe rebasing we need to compare old and new backing file */
     if (!unsafe) {
-        char backing_name[PATH_MAX];
         QDict *options = NULL;
+        BlockDriverState *base_bs = backing_bs(bs);
 
-        if (bs->backing_format[0] != '\0') {
-            options = qdict_new();
-            qdict_put_str(options, "driver", bs->backing_format);
+        if (!base_bs) {
+            error_setg(&local_err, "Image does not have a backing file");
+            ret = -1;
+            goto out;
         }
 
-        if (force_share) {
-            if (!options) {
-                options = qdict_new();
-            }
-            qdict_put_bool(options, BDRV_OPT_FORCE_SHARE, true);
-        }
-        bdrv_get_backing_filename(bs, backing_name, sizeof(backing_name));
-        blk_old_backing = blk_new_open(backing_name, NULL,
-                                       options, src_flags, &local_err);
-        if (!blk_old_backing) {
+        blk_old_backing = blk_new(BLK_PERM_CONSISTENT_READ,
+                                  BLK_PERM_ALL);
+        ret = blk_insert_bs(blk_old_backing, base_bs,
+                            &local_err);
+        if (ret < 0) {
             error_reportf_err(local_err,
-                              "Could not open old backing file '%s': ",
-                              backing_name);
-            ret = -1;
+                              "Could not reuse old backing file '%s': ",
+                              base_bs->filename);
             goto out;
         }
 
-- 
2.13.3
