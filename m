Received: from eggs.gnu.org ([2001:4830:134:3::10]:38616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eoUry-0001Xh-Jm
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:55:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eoUrx-00039m-Kx
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:55:38 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 21 Feb 2018 14:53:59 +0100
Message-Id: <20180221135404.27598-32-kwolf@redhat.com>
In-Reply-To: <20180221135404.27598-1-kwolf@redhat.com>
References: <20180221135404.27598-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 31/36] ssh: Pass BlockdevOptionsSsh to
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
Cc: kwolf@redhat.com, mreitz@redhat.com, pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

Move the parsing of the QDict options up to the callers, in preparation
for the .bdrv_co_create implementation that directly gets a QAPI type.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/ssh.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/block/ssh.c b/block/ssh.c
index dcf766c213..77bc20041f 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -655,19 +655,13 @@ fail:
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
@@ -747,8 +741,6 @@ static int connect_to_ssh(BDRVSSHState *s, QDict *options,
         goto err;
     }
 
-    qapi_free_BlockdevOptionsSsh(opts);
-
     r = libssh2_sftp_fstat(s->sftp_handle, &s->attrs);
     if (r < 0) {
         sftp_error_setg(errp, s, "failed to read file attributes");
@@ -774,8 +766,6 @@ static int connect_to_ssh(BDRVSSHState *s, QDict *options,
     }
     s->session = NULL;
 
-    qapi_free_BlockdevOptionsSsh(opts);
-
     return ret;
 }
 
@@ -783,6 +773,7 @@ static int ssh_file_open(BlockDriverState *bs, QDict *options, int bdrv_flags,
                          Error **errp)
 {
     BDRVSSHState *s = bs->opaque;
+    BlockdevOptionsSsh *opts;
     int ret;
     int ssh_flags;
 
@@ -793,8 +784,13 @@ static int ssh_file_open(BlockDriverState *bs, QDict *options, int bdrv_flags,
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
@@ -802,6 +798,8 @@ static int ssh_file_open(BlockDriverState *bs, QDict *options, int bdrv_flags,
     /* Go non-blocking. */
     libssh2_session_set_blocking(s->session, 0);
 
+    qapi_free_BlockdevOptionsSsh(opts);
+
     return 0;
 
  err:
@@ -810,6 +808,8 @@ static int ssh_file_open(BlockDriverState *bs, QDict *options, int bdrv_flags,
     }
     s->sock = -1;
 
+    qapi_free_BlockdevOptionsSsh(opts);
+
     return ret;
 }
 
@@ -831,6 +831,7 @@ static int ssh_create(const char *filename, QemuOpts *opts, Error **errp)
     int r, ret;
     int64_t total_size = 0;
     QDict *uri_options = NULL;
+    BlockdevOptionsSsh *ssh_opts = NULL;
     BDRVSSHState s;
     ssize_t r2;
     char c[1] = { '\0' };
@@ -849,7 +850,13 @@ static int ssh_create(const char *filename, QemuOpts *opts, Error **errp)
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
@@ -876,6 +883,7 @@ static int ssh_create(const char *filename, QemuOpts *opts, Error **errp)
     if (uri_options != NULL) {
         QDECREF(uri_options);
     }
+    qapi_free_BlockdevOptionsSsh(ssh_opts);
     return ret;
 }
 
-- 
2.13.6
