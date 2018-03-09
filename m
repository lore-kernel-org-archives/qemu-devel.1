Received: from eggs.gnu.org ([2001:4830:134:3::10]:34145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlJ-0001VS-ED
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlG-0007Ln-2y
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:53 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:19:23 +0100
Message-Id: <20180309161933.8168-47-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 46/56] ssh: Pass BlockdevOptionsSsh to
 connect_to_ssh()
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

Move the parsing of the QDict options up to the callers, in preparation
for the .bdrv_co_create implementation that directly gets a QAPI type.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/ssh.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/block/ssh.c b/block/ssh.c
index 30cdf9a99f..80f59055cc 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -656,19 +656,13 @@ fail:
     return result;
 }
 
-static int connect_to_ssh(BDRVSSHState *s, QDict *options,
+static int connect_to_ssh(BDRVSSHState *s, BlockdevOptionsSsh *opts,
                           int ssh_flags, int creat_mode, Error **errp)
 {
-    BlockdevOptionsSsh *opts;
     int r, ret;
     const char *user;
     long port = 0;
 
-    opts = ssh_parse_options(options, errp);
-    if (opts == NULL) {
-        return -EINVAL;
-    }
-
     if (opts->has_user) {
         user = opts->user;
     } else {
@@ -748,8 +742,6 @@ static int connect_to_ssh(BDRVSSHState *s, QDict *options,
         goto err;
     }
 
-    qapi_free_BlockdevOptionsSsh(opts);
-
     r = libssh2_sftp_fstat(s->sftp_handle, &s->attrs);
     if (r < 0) {
         sftp_error_setg(errp, s, "failed to read file attributes");
@@ -775,8 +767,6 @@ static int connect_to_ssh(BDRVSSHState *s, QDict *options,
     }
     s->session = NULL;
 
-    qapi_free_BlockdevOptionsSsh(opts);
-
     return ret;
 }
 
@@ -784,6 +774,7 @@ static int ssh_file_open(BlockDriverState *bs, QDict *options, int bdrv_flags,
                          Error **errp)
 {
     BDRVSSHState *s = bs->opaque;
+    BlockdevOptionsSsh *opts;
     int ret;
     int ssh_flags;
 
@@ -794,8 +785,13 @@ static int ssh_file_open(BlockDriverState *bs, QDict *options, int bdrv_flags,
         ssh_flags |= LIBSSH2_FXF_WRITE;
     }
 
+    opts = ssh_parse_options(options, errp);
+    if (opts == NULL) {
+        return -EINVAL;
+    }
+
     /* Start up SSH. */
-    ret = connect_to_ssh(s, options, ssh_flags, 0, errp);
+    ret = connect_to_ssh(s, opts, ssh_flags, 0, errp);
     if (ret < 0) {
         goto err;
     }
@@ -803,6 +799,8 @@ static int ssh_file_open(BlockDriverState *bs, QDict *options, int bdrv_flags,
     /* Go non-blocking. */
     libssh2_session_set_blocking(s->session, 0);
 
+    qapi_free_BlockdevOptionsSsh(opts);
+
     return 0;
 
  err:
@@ -811,6 +809,8 @@ static int ssh_file_open(BlockDriverState *bs, QDict *options, int bdrv_flags,
     }
     s->sock = -1;
 
+    qapi_free_BlockdevOptionsSsh(opts);
+
     return ret;
 }
 
@@ -860,6 +860,7 @@ static int coroutine_fn ssh_co_create_opts(const char *filename, QemuOpts *opts,
     int r, ret;
     int64_t total_size = 0;
     QDict *uri_options = NULL;
+    BlockdevOptionsSsh *ssh_opts = NULL;
     BDRVSSHState s;
 
     ssh_state_init(&s);
@@ -876,7 +877,13 @@ static int coroutine_fn ssh_co_create_opts(const char *filename, QemuOpts *opts,
         goto out;
     }
 
-    r = connect_to_ssh(&s, uri_options,
+    ssh_opts = ssh_parse_options(uri_options, errp);
+    if (ssh_opts == NULL) {
+        ret = -EINVAL;
+        goto out;
+    }
+
+    r = connect_to_ssh(&s, ssh_opts,
                        LIBSSH2_FXF_READ|LIBSSH2_FXF_WRITE|
                        LIBSSH2_FXF_CREAT|LIBSSH2_FXF_TRUNC,
                        0644, errp);
@@ -899,6 +906,7 @@ static int coroutine_fn ssh_co_create_opts(const char *filename, QemuOpts *opts,
     if (uri_options != NULL) {
         QDECREF(uri_options);
     }
+    qapi_free_BlockdevOptionsSsh(ssh_opts);
     return ret;
 }
 
-- 
2.13.6
