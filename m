Received: from eggs.gnu.org ([2001:4830:134:3::10]:42624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHEp-0002Jf-UU
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHEp-0002nv-3W
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:23 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  7 Mar 2017 16:40:38 +0100
Message-Id: <1488901251-16214-15-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
References: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 14/27] sheepdog: Mark sd_snapshot_delete()
 lossage FIXME
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

sd_snapshot_delete() should delete the snapshot whose ID matches
@snapshot_id and whose name matches @name.  But that's not what it
does.  If @snapshot_id is a valid ID, it deletes the snapshot with
that ID, else it deletes the snapshot with that name.  It doesn't use
@name at all.  Add suitable FIXME comments, so someone who actually
knows Sheepdog can fix it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/sheepdog.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index be3db1f..187bcd8 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2457,6 +2457,10 @@ static int sd_snapshot_delete(BlockDriverState *bs,
                               const char *name,
                               Error **errp)
 {
+    /*
+     * FIXME should delete the snapshot matching both @snapshot_id and
+     * @name, but @name not used here
+     */
     unsigned long snap_id = 0;
     char snap_tag[SD_MAX_VDI_TAG_LEN];
     int fd, ret;
@@ -2481,6 +2485,11 @@ static int sd_snapshot_delete(BlockDriverState *bs,
     pstrcpy(buf, SD_MAX_VDI_LEN, s->name);
     ret = qemu_strtoul(snapshot_id, NULL, 10, &snap_id);
     if (ret || snap_id > UINT32_MAX) {
+        /*
+         * FIXME Since qemu_strtoul() returns -EINVAL when
+         * @snapshot_id is null, @snapshot_id is mandatory.  Correct
+         * would be to require at least one of @snapshot_id and @name.
+         */
         error_setg(errp, "Invalid snapshot ID: %s",
                          snapshot_id ? snapshot_id : "<null>");
         return -EINVAL;
@@ -2489,6 +2498,7 @@ static int sd_snapshot_delete(BlockDriverState *bs,
     if (snap_id) {
         hdr.snapid = (uint32_t) snap_id;
     } else {
+        /* FIXME I suspect we should use @name here */
         pstrcpy(snap_tag, sizeof(snap_tag), snapshot_id);
         pstrcpy(buf + SD_MAX_VDI_LEN, SD_MAX_VDI_TAG_LEN, snap_tag);
     }
-- 
1.8.3.1
