Received: from eggs.gnu.org ([209.51.188.92]:58254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grPG3-0006SY-QH
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:37:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grPG1-0000NE-MI
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:37:03 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  6 Feb 2019 16:29:18 +0100
Message-Id: <20190206152919.5532-2-mreitz@redhat.com>
In-Reply-To: <20190206152919.5532-1-mreitz@redhat.com>
References: <20190206152919.5532-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/2] block/ssh: Implement
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, "Richard W . M . Jones" <rjones@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/ssh.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 5 deletions(-)

diff --git a/block/ssh.c b/block/ssh.c
index 190ef95300..88401bbd31 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -75,6 +75,14 @@ typedef struct BDRVSSHState {
=20
     /* Used to warn if 'flush' is not supported. */
     bool unsafe_flush_warning;
+
+    /*
+     * Store the user name for ssh_refresh_filename() because the
+     * default depends on the system you are on -- therefore, when we
+     * generate a filename, it should always contain the user name we
+     * are actually using.
+     */
+    char *user;
 } BDRVSSHState;
=20
 static void ssh_state_init(BDRVSSHState *s)
@@ -87,6 +95,8 @@ static void ssh_state_init(BDRVSSHState *s)
=20
 static void ssh_state_free(BDRVSSHState *s)
 {
+    g_free(s->user);
+
     if (s->sftp_handle) {
         libssh2_sftp_close(s->sftp_handle);
     }
@@ -640,14 +650,13 @@ static int connect_to_ssh(BDRVSSHState *s, Blockdev=
OptionsSsh *opts,
                           int ssh_flags, int creat_mode, Error **errp)
 {
     int r, ret;
-    const char *user;
     long port =3D 0;
=20
     if (opts->has_user) {
-        user =3D opts->user;
+        s->user =3D g_strdup(opts->user);
     } else {
-        user =3D g_get_user_name();
-        if (!user) {
+        s->user =3D g_strdup(g_get_user_name());
+        if (!s->user) {
             error_setg_errno(errp, errno, "Can't get user name");
             ret =3D -errno;
             goto err;
@@ -697,7 +706,7 @@ static int connect_to_ssh(BDRVSSHState *s, BlockdevOp=
tionsSsh *opts,
     }
=20
     /* Authenticate. */
-    ret =3D authenticate(s, user, errp);
+    ret =3D authenticate(s, s->user, errp);
     if (ret < 0) {
         goto err;
     }
@@ -1254,6 +1263,38 @@ static int coroutine_fn ssh_co_truncate(BlockDrive=
rState *bs, int64_t offset,
     return ssh_grow_file(s, offset, errp);
 }
=20
+static void ssh_refresh_filename(BlockDriverState *bs)
+{
+    BDRVSSHState *s =3D bs->opaque;
+    const char *path, *host_key_check;
+    int ret;
+
+    /*
+     * None of these options can be represented in a plain "host:port"
+     * format, so if any was given, we have to abort.
+     */
+    if (s->inet->has_ipv4 || s->inet->has_ipv6 || s->inet->has_to ||
+        s->inet->has_numeric)
+    {
+        return;
+    }
+
+    path =3D qdict_get_try_str(bs->full_open_options, "path");
+    assert(path); /* mandatory option */
+
+    host_key_check =3D qdict_get_try_str(bs->full_open_options, "host_ke=
y_check");
+
+    ret =3D snprintf(bs->exact_filename, sizeof(bs->exact_filename),
+                   "ssh://%s@%s:%s%s%s%s",
+                   s->user, s->inet->host, s->inet->port, path,
+                   host_key_check ? "?host_key_check=3D" : "",
+                   host_key_check ?: "");
+    if (ret >=3D sizeof(bs->exact_filename)) {
+        /* An overflow makes the filename unusable, so do not report any=
 */
+        bs->exact_filename[0] =3D '\0';
+    }
+}
+
 static const char *const ssh_strong_runtime_opts[] =3D {
     "host",
     "port",
@@ -1280,6 +1321,7 @@ static BlockDriver bdrv_ssh =3D {
     .bdrv_getlength               =3D ssh_getlength,
     .bdrv_co_truncate             =3D ssh_co_truncate,
     .bdrv_co_flush_to_disk        =3D ssh_co_flush,
+    .bdrv_refresh_filename        =3D ssh_refresh_filename,
     .create_opts                  =3D &ssh_create_opts,
     .strong_runtime_opts          =3D ssh_strong_runtime_opts,
 };
--=20
2.20.1
