Received: from eggs.gnu.org ([2001:4830:134:3::10]:35089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjYWG-0005WK-4P
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:44:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjYWE-0002pw-Ca
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:44:16 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  2 Mar 2017 22:43:53 +0100
Message-Id: <1488491046-2549-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1488491046-2549-1-git-send-email-armbru@redhat.com>
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 02/15] sheepdog: Fix error handling in
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
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com

As a bdrv_snapshot_delete() method, sd_snapshot_delete() must set an
error and return negative errno on failure.  It sometimes returns -1,
and sometimes neglects to set an error.  It also prints error messages
with error_report().  Fix all that.

Moreover, its handling of an attempt to delete an nonexistent snapshot
is wrong: it error_report()s and succeeds.  Fix it to set an error and
return -ENOENT instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/sheepdog.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index fe15723..e4e5345 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2406,18 +2406,15 @@ out:
 
 #define NR_BATCHED_DISCARD 128
 
-static bool remove_objects(BDRVSheepdogState *s)
+static int remove_objects(BDRVSheepdogState *s, Error **errp)
 {
     int fd, i = 0, nr_objs = 0;
-    Error *local_err = NULL;
     int ret = 0;
-    bool result = true;
     SheepdogInode *inode = &s->inode;
 
-    fd = connect_to_sdog(s, &local_err);
+    fd = connect_to_sdog(s, errp);
     if (fd < 0) {
-        error_report_err(local_err);
-        return false;
+        return fd;
     }
 
     nr_objs = count_data_objs(inode);
@@ -2447,15 +2444,14 @@ static bool remove_objects(BDRVSheepdogState *s)
                                     data_vdi_id[start_idx]),
                            false, s->cache_flags);
         if (ret < 0) {
-            error_report("failed to discard snapshot inode.");
-            result = false;
+            error_setg(errp, "failed to discard snapshot inode.");
             goto out;
         }
     }
 
 out:
     closesocket(fd);
-    return result;
+    return ret;
 }
 
 static int sd_snapshot_delete(BlockDriverState *bs,
@@ -2465,7 +2461,6 @@ static int sd_snapshot_delete(BlockDriverState *bs,
 {
     unsigned long snap_id = 0;
     char snap_tag[SD_MAX_VDI_TAG_LEN];
-    Error *local_err = NULL;
     int fd, ret;
     char buf[SD_MAX_VDI_LEN + SD_MAX_VDI_TAG_LEN];
     BDRVSheepdogState *s = bs->opaque;
@@ -2478,8 +2473,9 @@ static int sd_snapshot_delete(BlockDriverState *bs,
     };
     SheepdogVdiRsp *rsp = (SheepdogVdiRsp *)&hdr;
 
-    if (!remove_objects(s)) {
-        return -1;
+    ret = remove_objects(s, errp);
+    if (ret) {
+        return ret;
     }
 
     memset(buf, 0, sizeof(buf));
@@ -2500,35 +2496,36 @@ static int sd_snapshot_delete(BlockDriverState *bs,
     }
 
     ret = find_vdi_name(s, s->name, snap_id, snap_tag, &vid, true,
-                        &local_err);
+                        errp);
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
