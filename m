Received: from eggs.gnu.org ([2001:4830:134:3::10]:37495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1em3zk-0002Ik-52
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 15:49:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1em3zj-0001v9-BE
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 15:49:36 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 14 Feb 2018 21:49:13 +0100
Message-Id: <20180214204915.7980-2-mreitz@redhat.com>
In-Reply-To: <20180214204915.7980-1-mreitz@redhat.com>
References: <20180214204915.7980-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] block/ssh: Pull ssh_grow_file() from
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Richard W . M . Jones" <rjones@redhat.com>, Jeff Cody <jcody@redhat.com>

If we ever want to offer even rudimentary truncation functionality for
ssh, we should put the respective code into a reusable function.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/ssh.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/block/ssh.c b/block/ssh.c
index b63addcf94..964e55f7fe 100644
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
@@ -822,8 +842,6 @@ static int ssh_create(const char *filename, QemuOpts *opts, Error **errp)
     int64_t total_size = 0;
     QDict *uri_options = NULL;
     BDRVSSHState s;
-    ssize_t r2;
-    char c[1] = { '\0' };
 
     ssh_state_init(&s);
 
@@ -849,14 +867,10 @@ static int ssh_create(const char *filename, QemuOpts *opts, Error **errp)
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
2.14.3
