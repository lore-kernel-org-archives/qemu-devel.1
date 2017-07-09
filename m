Received: from eggs.gnu.org ([2001:4830:134:3::10]:41678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dUFh6-0008RB-Eu
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 13:08:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dUFh2-0007VK-E4
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 13:08:28 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun,  9 Jul 2017 18:06:14 +0100
Message-Id: <20170709170614.24967-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] block/vmdk: Report failures in vmdk_read_cid()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

The function vmdk_read_cid() can fail if the read on the underlying
block device fails, or if there's a format error in the VMDK file.
However its API doesn't provide a mechanism to report these errors,
and in some cases we were returning a CID of 0 and in some cases a
CID of 0xffffffff, either of which might potentially be valid values.

Change the function to return 0 on success or a negative errno, and
return the CID via a uint32_t* argument. Update the callsites to
handle and propagate the error appropriately.

This fixes in passing a Coverity-spotted issue (CID 1350038) where
we weren't checking the return value from sscanf().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 block/vmdk.c | 44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 55581b03fe..0c9949fc0c 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -242,10 +242,11 @@ static void vmdk_free_last_extent(BlockDriverState *bs)
     s->extents = g_renew(VmdkExtent, s->extents, s->num_extents);
 }
 
-static uint32_t vmdk_read_cid(BlockDriverState *bs, int parent)
+/* Return -ve errno, or 0 on success and write CID into *pcid. */
+static int vmdk_read_cid(BlockDriverState *bs, int parent, uint32_t *pcid)
 {
     char *desc;
-    uint32_t cid = 0xffffffff;
+    uint32_t cid;
     const char *p_name, *cid_str;
     size_t cid_str_size;
     BDRVVmdkState *s = bs->opaque;
@@ -254,8 +255,7 @@ static uint32_t vmdk_read_cid(BlockDriverState *bs, int parent)
     desc = g_malloc0(DESC_SIZE);
     ret = bdrv_pread(bs->file, s->desc_offset, desc, DESC_SIZE);
     if (ret < 0) {
-        g_free(desc);
-        return 0;
+        goto out;
     }
 
     if (parent) {
@@ -268,13 +268,21 @@ static uint32_t vmdk_read_cid(BlockDriverState *bs, int parent)
 
     desc[DESC_SIZE - 1] = '\0';
     p_name = strstr(desc, cid_str);
-    if (p_name != NULL) {
-        p_name += cid_str_size;
-        sscanf(p_name, "%" SCNx32, &cid);
+    if (p_name == NULL) {
+        ret = -EINVAL;
+        goto out;
     }
+    p_name += cid_str_size;
+    if (sscanf(p_name, "%" SCNx32, &cid) != 1) {
+        ret = -EINVAL;
+        goto out;
+    }
+    *pcid = cid;
+    ret = 0;
 
+out:
     g_free(desc);
-    return cid;
+    return ret;
 }
 
 static int vmdk_write_cid(BlockDriverState *bs, uint32_t cid)
@@ -322,7 +330,10 @@ static int vmdk_is_cid_valid(BlockDriverState *bs)
     if (!s->cid_checked && bs->backing) {
         BlockDriverState *p_bs = bs->backing->bs;
 
-        cur_pcid = vmdk_read_cid(p_bs, 0);
+        if (vmdk_read_cid(p_bs, 0, &cur_pcid) != 0) {
+            /* read failure: report as not valid */
+            return 0;
+        }
         if (s->parent_cid != cur_pcid) {
             /* CID not valid */
             return 0;
@@ -975,8 +986,14 @@ static int vmdk_open(BlockDriverState *bs, QDict *options, int flags,
     if (ret) {
         goto fail;
     }
-    s->cid = vmdk_read_cid(bs, 0);
-    s->parent_cid = vmdk_read_cid(bs, 1);
+    ret = vmdk_read_cid(bs, 0, &s->cid);
+    if (ret) {
+        goto fail;
+    }
+    ret = vmdk_read_cid(bs, 1, &s->parent_cid);
+    if (ret) {
+        goto fail;
+    }
     qemu_co_mutex_init(&s->lock);
 
     /* Disable migration when VMDK images are used */
@@ -2007,8 +2024,11 @@ static int vmdk_create(const char *filename, QemuOpts *opts, Error **errp)
             ret = -EINVAL;
             goto exit;
         }
-        parent_cid = vmdk_read_cid(blk_bs(blk), 0);
+        ret = vmdk_read_cid(blk_bs(blk), 0, &parent_cid);
         blk_unref(blk);
+        if (ret) {
+            goto exit;
+        }
         snprintf(parent_desc_line, BUF_SIZE,
                 "parentFileNameHint=\"%s\"", backing_file);
     }
-- 
2.11.0
