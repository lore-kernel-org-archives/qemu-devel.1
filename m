Received: from eggs.gnu.org ([2001:4830:134:3::10]:42671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHEs-0002Mq-42
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHEq-0002px-Qz
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:26 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  7 Mar 2017 16:40:39 +0100
Message-Id: <1488901251-16214-16-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
References: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 15/27] sheepdog: Fix snapshot ID parsing in
 _open(), _create, _goto()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Markus Armbruster <armbru@redhat.com>

sd_parse_uri() and sd_snapshot_goto() screw up error checking after
strtoul(), and truncate long tag names silently.  Fix by replacing
those parts by new sd_parse_snapid_or_tag(), which checks more
carefully.

sd_snapshot_delete() also parses snapshot IDs, but is currently too
broken for me to touch.  Mark TODO.

Two calls of strtol() without error checking remain in
parse_redundancy().  Mark them FIXME.

More silent truncation of configuration strings remains elsewhere.
Not marked.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/sheepdog.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 55 insertions(+), 11 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 187bcd8..d3d3731 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -914,6 +914,49 @@ static int get_sheep_fd(BDRVSheepdogState *s, Error **errp)
     return fd;
 }
 
+/*
+ * Parse numeric snapshot ID in @str
+ * If @str can't be parsed as number, return false.
+ * Else, if the number is zero or too large, set *@snapid to zero and
+ * return true.
+ * Else, set *@snapid to the number and return true.
+ */
+static bool sd_parse_snapid(const char *str, uint32_t *snapid)
+{
+    unsigned long ul;
+    int ret;
+
+    ret = qemu_strtoul(str, NULL, 10, &ul);
+    if (ret == -ERANGE) {
+        ul = ret = 0;
+    }
+    if (ret) {
+        return false;
+    }
+    if (ul > UINT32_MAX) {
+        ul = 0;
+    }
+
+    *snapid = ul;
+    return true;
+}
+
+static bool sd_parse_snapid_or_tag(const char *str,
+                                   uint32_t *snapid, char tag[])
+{
+    if (!sd_parse_snapid(str, snapid)) {
+        *snapid = 0;
+        if (g_strlcpy(tag, str, SD_MAX_VDI_TAG_LEN) >= SD_MAX_VDI_TAG_LEN) {
+            return false;
+        }
+    } else if (!*snapid) {
+        return false;
+    } else {
+        tag[0] = 0;
+    }
+    return true;
+}
+
 static int sd_parse_uri(BDRVSheepdogState *s, const char *filename,
                         char *vdi, uint32_t *snapid, char *tag)
 {
@@ -965,9 +1008,9 @@ static int sd_parse_uri(BDRVSheepdogState *s, const char *filename,
 
     /* snapshot tag */
     if (uri->fragment) {
-        *snapid = strtoul(uri->fragment, NULL, 10);
-        if (*snapid == 0) {
-            pstrcpy(tag, SD_MAX_VDI_TAG_LEN, uri->fragment);
+        if (!sd_parse_snapid_or_tag(uri->fragment, snapid, tag)) {
+            ret = -EINVAL;
+            goto out;
         }
     } else {
         *snapid = CURRENT_VDI_ID; /* search current vdi */
@@ -1685,6 +1728,7 @@ static int parse_redundancy(BDRVSheepdogState *s, const char *opt)
     }
 
     copy = strtol(n1, NULL, 10);
+    /* FIXME fix error checking by switching to qemu_strtol() */
     if (copy > SD_MAX_COPIES || copy < 1) {
         return -EINVAL;
     }
@@ -1699,6 +1743,7 @@ static int parse_redundancy(BDRVSheepdogState *s, const char *opt)
     }
 
     parity = strtol(n2, NULL, 10);
+    /* FIXME fix error checking by switching to qemu_strtol() */
     if (parity >= SD_EC_MAX_STRIP || parity < 1) {
         return -EINVAL;
     }
@@ -2365,19 +2410,16 @@ static int sd_snapshot_goto(BlockDriverState *bs, const char *snapshot_id)
     BDRVSheepdogState *old_s;
     char tag[SD_MAX_VDI_TAG_LEN];
     uint32_t snapid = 0;
-    int ret = 0;
+    int ret;
+
+    if (!sd_parse_snapid_or_tag(snapshot_id, &snapid, tag)) {
+        return -EINVAL;
+    }
 
     old_s = g_new(BDRVSheepdogState, 1);
 
     memcpy(old_s, s, sizeof(BDRVSheepdogState));
 
-    snapid = strtoul(snapshot_id, NULL, 10);
-    if (snapid) {
-        tag[0] = 0;
-    } else {
-        pstrcpy(tag, sizeof(tag), snapshot_id);
-    }
-
     ret = reload_inode(s, snapid, tag);
     if (ret) {
         goto out;
@@ -2483,6 +2525,7 @@ static int sd_snapshot_delete(BlockDriverState *bs,
     memset(buf, 0, sizeof(buf));
     memset(snap_tag, 0, sizeof(snap_tag));
     pstrcpy(buf, SD_MAX_VDI_LEN, s->name);
+    /* TODO Use sd_parse_snapid() once this mess is cleaned up */
     ret = qemu_strtoul(snapshot_id, NULL, 10, &snap_id);
     if (ret || snap_id > UINT32_MAX) {
         /*
@@ -2499,6 +2542,7 @@ static int sd_snapshot_delete(BlockDriverState *bs,
         hdr.snapid = (uint32_t) snap_id;
     } else {
         /* FIXME I suspect we should use @name here */
+        /* FIXME don't truncate silently */
         pstrcpy(snap_tag, sizeof(snap_tag), snapshot_id);
         pstrcpy(buf + SD_MAX_VDI_LEN, SD_MAX_VDI_TAG_LEN, snap_tag);
     }
-- 
1.8.3.1
