Received: from eggs.gnu.org ([2001:4830:134:3::10]:45946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckxsR-00045t-Pl
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:01:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckxsQ-0004j8-FG
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:00:59 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  6 Mar 2017 20:00:36 +0100
Message-Id: <1488826849-32384-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1488826849-32384-1-git-send-email-armbru@redhat.com>
References: <1488826849-32384-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 02/15] sheepdog: Fix error handling in
 sd_snapshot_delete()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, ndevos@redhat.com, eblake@redhat.com, f4bug@amsat.org

As a bdrv_snapshot_delete() method, sd_snapshot_delete() must set an
error and return negative errno on failure.  It sometimes returns -1,
and sometimes neglects to set an error.  It also prints error messages
with error_report().  Fix all that.

Moreover, its handling of an attempt to delete an nonexistent snapshot
is wrong: it error_report()s and succeeds.  Fix it to set an error and
return -ENOENT instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/sheepdog.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index c3ee4ce..0a0803e 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2405,18 +2405,15 @@ out:
 
 #define NR_BATCHED_DISCARD 128
 
-static bool remove_objects(BDRVSheepdogState *s)
+static int remove_objects(BDRVSheepdogState *s, Error **errp)
 {
     int fd, i = 0, nr_objs = 0;
-    Error *local_err = NULL;
-    int ret = 0;
-    bool result = true;
+    int ret;
     SheepdogInode *inode = &s->inode;
 
-    fd = connect_to_sdog(s, &local_err);
+    fd = connect_to_sdog(s, errp);
     if (fd < 0) {
-        error_report_err(local_err);
-        return false;
+        return fd;
     }
 
     nr_objs = count_data_objs(inode);
@@ -2446,15 +2443,15 @@ static bool remove_objects(BDRVSheepdogState *s)
                                     data_vdi_id[start_idx]),
                            false, s->cache_flags);
         if (ret < 0) {
-            error_report("failed to discard snapshot inode.");
-            result = false;
+            error_setg(errp, "Failed to discard snapshot inode");
             goto out;
         }
     }
 
+    ret = 0;
 out:
     closesocket(fd);
-    return result;
+    return ret;
 }
 
 static int sd_snapshot_delete(BlockDriverState *bs,
@@ -2464,7 +2461,6 @@ static int sd_snapshot_delete(BlockDriverState *bs,
 {
     unsigned long snap_id = 0;
     char snap_tag[SD_MAX_VDI_TAG_LEN];
-    Error *local_err = NULL;
     int fd, ret;
     char buf[SD_MAX_VDI_LEN + SD_MAX_VDI_TAG_LEN];
     BDRVSheepdogState *s = bs->opaque;
@@ -2477,8 +2473,9 @@ static int sd_snapshot_delete(BlockDriverState *bs,
     };
     SheepdogVdiRsp *rsp = (SheepdogVdiRsp *)&hdr;
 
-    if (!remove_objects(s)) {
-        return -1;
+    ret = remove_objects(s, errp);
+    if (ret) {
+        return ret;
     }
 
     memset(buf, 0, sizeof(buf));
@@ -2498,36 +2495,36 @@ static int sd_snapshot_delete(BlockDriverState *bs,
         pstrcpy(buf + SD_MAX_VDI_LEN, SD_MAX_VDI_TAG_LEN, snap_tag);
     }
 
-    ret = find_vdi_name(s, s->name, snap_id, snap_tag, &vid, true,
-                        &local_err);
+    ret = find_vdi_name(s, s->name, snap_id, snap_tag, &vid, true, errp);
     if (ret) {
         return ret;
     }
 
-    fd = connect_to_sdog(s, &local_err);
+    fd = connect_to_sdog(s, errp);
     if (fd < 0) {
-        error_report_err(local_err);
-        return -1;
+        return fd;
     }
 
     ret = do_req(fd, s->bs, (SheepdogReq *)&hdr,
                  buf, &wlen, &rlen);
     closesocket(fd);
     if (ret) {
+        error_setg_errno(errp, -ret, "Couldn't send request to server");
         return ret;
     }
 
     switch (rsp->result) {
     case SD_RES_NO_VDI:
-        error_report("%s was already deleted", s->name);
+        error_setg(errp, "Can't find the snapshot");
+        return -ENOENT;
     case SD_RES_SUCCESS:
         break;
     default:
-        error_report("%s, %s", sd_strerror(rsp->result), s->name);
-        return -1;
+        error_setg(errp, "%s", sd_strerror(rsp->result));
+        return -EIO;
     }
 
-    return ret;
+    return 0;
 }
 
 static int sd_snapshot_list(BlockDriverState *bs, QEMUSnapshotInfo **psn_tab)
-- 
2.7.4
