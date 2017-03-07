Received: from eggs.gnu.org ([2001:4830:134:3::10]:42570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHEn-0002HR-Rk
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHEk-0002lt-2I
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:21 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  7 Mar 2017 16:40:35 +0100
Message-Id: <1488901251-16214-12-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
References: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 11/27] sheepdog: Defuse time bomb in sd_open()
 error handling
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

When qemu_opts_absorb_qdict() fails, sd_open() closes stdin, because
sd->fd is still zero.  Fortunately, qemu_opts_absorb_qdict() can't
fail, because:

1. it only fails when qemu_opt_parse() fails, and
2. the only member of runtime_opts.desc[] is a QEMU_OPT_STRING, and
3. qemu_opt_parse() can't fail for QEMU_OPT_STRING.

Defuse this ticking time bomb by jumping behind the file descriptor
cleanup on error.

Also do that for the error paths where sd->fd is still -1.  The file
descriptor cleanup happens to do nothing then, but let's not rely on
that here.

While there, rename label out to err, because it's on the error path,
not the normal path out of the function.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/sheepdog.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 7434710..c3ee4ce 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1392,7 +1392,7 @@ static int sd_open(BlockDriverState *bs, QDict *options, int flags,
     if (local_err) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
-        goto out;
+        goto err_no_fd;
     }
 
     filename = qemu_opt_get(opts, "filename");
@@ -1412,17 +1412,17 @@ static int sd_open(BlockDriverState *bs, QDict *options, int flags,
     }
     if (ret < 0) {
         error_setg(errp, "Can't parse filename");
-        goto out;
+        goto err_no_fd;
     }
     s->fd = get_sheep_fd(s, errp);
     if (s->fd < 0) {
         ret = s->fd;
-        goto out;
+        goto err_no_fd;
     }
 
     ret = find_vdi_name(s, vdi, snapid, tag, &vid, true, errp);
     if (ret) {
-        goto out;
+        goto err;
     }
 
     /*
@@ -1443,7 +1443,7 @@ static int sd_open(BlockDriverState *bs, QDict *options, int flags,
     fd = connect_to_sdog(s, errp);
     if (fd < 0) {
         ret = fd;
-        goto out;
+        goto err;
     }
 
     buf = g_malloc(SD_INODE_SIZE);
@@ -1454,7 +1454,7 @@ static int sd_open(BlockDriverState *bs, QDict *options, int flags,
 
     if (ret) {
         error_setg(errp, "Can't read snapshot inode");
-        goto out;
+        goto err;
     }
 
     memcpy(&s->inode, buf, sizeof(s->inode));
@@ -1466,12 +1466,12 @@ static int sd_open(BlockDriverState *bs, QDict *options, int flags,
     qemu_opts_del(opts);
     g_free(buf);
     return 0;
-out:
+
+err:
     aio_set_fd_handler(bdrv_get_aio_context(bs), s->fd,
                        false, NULL, NULL, NULL, NULL);
-    if (s->fd >= 0) {
-        closesocket(s->fd);
-    }
+    closesocket(s->fd);
+err_no_fd:
     qemu_opts_del(opts);
     g_free(buf);
     return ret;
-- 
1.8.3.1
