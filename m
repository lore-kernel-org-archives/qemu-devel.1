Received: from eggs.gnu.org ([2001:4830:134:3::10]:34722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1einHp-0004qe-5n
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 15:22:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1einHn-0006z1-Mm
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 15:22:45 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  5 Feb 2018 21:22:31 +0100
Message-Id: <20180205202232.19254-2-mreitz@redhat.com>
In-Reply-To: <20180205202232.19254-1-mreitz@redhat.com>
References: <20180205202232.19254-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] block/ssh: Implement
 .bdrv_refresh_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, "Richard W . M . Jones" <rjones@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/ssh.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/block/ssh.c b/block/ssh.c
index c31b2686c3..a5b7e831a4 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -75,6 +75,12 @@ typedef struct BDRVSSHState {
 
     /* Used to warn if 'flush' is not supported. */
     bool unsafe_flush_warning;
+
+    /* Store the user name for ssh_refresh_filename() because the
+     * default depends on the system you are on -- therefore, when we
+     * generate a filename, it should always contain the user name we
+     * are actually using */
+    char *user;
 } BDRVSSHState;
 
 static void ssh_state_init(BDRVSSHState *s)
@@ -86,6 +92,8 @@ static void ssh_state_init(BDRVSSHState *s)
 
 static void ssh_state_free(BDRVSSHState *s)
 {
+    g_free(s->user);
+
     if (s->attrs) {
         sftp_attributes_free(s->attrs);
     }
@@ -569,7 +577,7 @@ static int connect_to_ssh(BDRVSSHState *s, QDict *options,
     int r, ret;
     QemuOpts *opts = NULL;
     Error *local_err = NULL;
-    const char *user, *path, *host_key_check;
+    const char *path, *host_key_check;
     long port = 0;
     unsigned long portU = 0;
     int new_sock = -1;
@@ -594,10 +602,10 @@ static int connect_to_ssh(BDRVSSHState *s, QDict *options,
         goto err;
     }
 
-    user = qemu_opt_get(opts, "user");
-    if (!user) {
-        user = g_get_user_name();
-        if (!user) {
+    s->user = g_strdup(qemu_opt_get(opts, "user"));
+    if (!s->user) {
+        s->user = g_strdup(g_get_user_name());
+        if (!s->user) {
             error_setg_errno(errp, errno, "Can't get user name");
             ret = -errno;
             goto err;
@@ -642,7 +650,7 @@ static int connect_to_ssh(BDRVSSHState *s, QDict *options,
      */
     ssh_set_blocking(s->session, 1);
 
-    r = ssh_options_set(s->session, SSH_OPTIONS_USER, user);
+    r = ssh_options_set(s->session, SSH_OPTIONS_USER, s->user);
     if (r < 0) {
         ret = -EINVAL;
         session_error_setg(errp, s,
@@ -704,7 +712,7 @@ static int connect_to_ssh(BDRVSSHState *s, QDict *options,
     }
 
     /* Authenticate. */
-    ret = authenticate(s, user, errp);
+    ret = authenticate(s, s->user, errp);
     if (ret < 0) {
         goto err;
     }
@@ -1156,6 +1164,36 @@ static int64_t ssh_getlength(BlockDriverState *bs)
     return length;
 }
 
+static void ssh_refresh_filename(BlockDriverState *bs)
+{
+    BDRVSSHState *s = bs->opaque;
+    const char *path, *host_key_check;
+    int ret;
+
+    /* None of these options can be represented in a plain "host:port"
+     * format, so if any was given, we have to abort */
+    if (s->inet->has_ipv4 || s->inet->has_ipv6 || s->inet->has_to ||
+        s->inet->has_numeric)
+    {
+        return;
+    }
+
+    path = qdict_get_try_str(bs->full_open_options, "path");
+    assert(path); /* mandatory option */
+
+    host_key_check = qdict_get_try_str(bs->full_open_options, "host_key_check");
+
+    ret = snprintf(bs->exact_filename, sizeof(bs->exact_filename),
+                   "ssh://%s@%s:%s%s%s%s",
+                   s->user, s->inet->host, s->inet->port, path,
+                   host_key_check ? "?host_key_check=" : "",
+                   host_key_check ?: "");
+    if (ret >= sizeof(bs->exact_filename)) {
+        /* An overflow makes the filename unusable, so do not report any */
+        bs->exact_filename[0] = '\0';
+    }
+}
+
 static const char *const ssh_sgfnt_runtime_opts[] = {
     "host",
     "port",
@@ -1180,6 +1218,7 @@ static BlockDriver bdrv_ssh = {
     .bdrv_co_writev               = ssh_co_writev,
     .bdrv_getlength               = ssh_getlength,
     .bdrv_co_flush_to_disk        = ssh_co_flush,
+    .bdrv_refresh_filename        = ssh_refresh_filename,
     .create_opts                  = &ssh_create_opts,
     .sgfnt_runtime_opts           = ssh_sgfnt_runtime_opts,
 };
-- 
2.14.3
