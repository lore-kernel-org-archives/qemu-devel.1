Received: from eggs.gnu.org ([2001:4830:134:3::10]:53255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpqr-00022E-Bx
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:56:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpqq-0003Rr-F0
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:56:17 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  2 Mar 2018 19:54:45 +0100
Message-Id: <20180302185448.6314-35-kwolf@redhat.com>
In-Reply-To: <20180302185448.6314-1-kwolf@redhat.com>
References: <20180302185448.6314-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 34/37] block/ssh: Pull ssh_grow_file() from
 ssh_create()
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

From: Max Reitz <mreitz@redhat.com>

If we ever want to offer even rudimentary truncation functionality for
ssh, we should put the respective code into a reusable function.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20180214204915.7980-2-mreitz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/ssh.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/block/ssh.c b/block/ssh.c
index 36d5d888d5..d6a68cb880 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -803,6 +803,26 @@ static int ssh_file_open(BlockDriverState *bs, QDict *options, int bdrv_flags,
     return ret;
 }
 
+static int ssh_grow_file(BDRVSSHState *s, int64_t offset, Error **errp)
+{
+    ssize_t ret;
+    char c[1] = { '\0' };
+
+    /* offset must be strictly greater than the current size so we do
+     * not overwrite anything */
+    assert(offset > 0 && offset > s->attrs.filesize);
+
+    libssh2_sftp_seek64(s->sftp_handle, offset - 1);
+    ret = libssh2_sftp_write(s->sftp_handle, c, 1);
+    if (ret < 0) {
+        sftp_error_setg(errp, s, "Failed to grow file");
+        return -EIO;
+    }
+
+    s->attrs.filesize = offset;
+    return 0;
+}
+
 static QemuOptsList ssh_create_opts = {
     .name = "ssh-create-opts",
     .head = QTAILQ_HEAD_INITIALIZER(ssh_create_opts.head),
@@ -823,8 +843,6 @@ static int coroutine_fn ssh_co_create_opts(const char *filename, QemuOpts *opts,
     int64_t total_size = 0;
     QDict *uri_options = NULL;
     BDRVSSHState s;
-    ssize_t r2;
-    char c[1] = { '\0' };
 
     ssh_state_init(&s);
 
@@ -850,14 +868,10 @@ static int coroutine_fn ssh_co_create_opts(const char *filename, QemuOpts *opts,
     }
 
     if (total_size > 0) {
-        libssh2_sftp_seek64(s.sftp_handle, total_size-1);
-        r2 = libssh2_sftp_write(s.sftp_handle, c, 1);
-        if (r2 < 0) {
-            sftp_error_setg(errp, &s, "truncate failed");
-            ret = -EINVAL;
+        ret = ssh_grow_file(&s, total_size, errp);
+        if (ret < 0) {
             goto out;
         }
-        s.attrs.filesize = total_size;
     }
 
     ret = 0;
-- 
2.13.6
