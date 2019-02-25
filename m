Received: from eggs.gnu.org ([209.51.188.92]:38418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gyLcI-0002ze-Fx
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 14:08:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gyLcH-0001eA-4H
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 14:08:42 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 25 Feb 2019 20:08:27 +0100
Message-Id: <20190225190828.17726-2-mreitz@redhat.com>
In-Reply-To: <20190225190828.17726-1-mreitz@redhat.com>
References: <20190225190828.17726-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 1/2] block/ssh: Implement
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

This requires some changes to keep iotests 104 and 207 working.

qemu-img info in 104 will now return a filename including the user name
and the port, which need to be filtered by adjusting REMOTE_TEST_DIR in
common.rc.  This additional information has to be marked optional,
however (which is simple as REMOTE_TEST_DIR is a regex), because
otherwise 197 and 215 would fail: They use it (indirectly) to filter
qemu-img create output which contains a backing filename they have
passed to it -- which probably does not contain a user name or port
number.

The problem in 207 is a nice one to have: qemu-img info used to return
json:{} filenames, but with this patch it returns nice plain ones.  We
now need to adjust the filtering to hide the user name (and port number
while we are at it).  The simplest way to do this is to include both in
iotests.remote_filename() so that bdrv_refresh_filename() will not
change it, and then iotests.img_info_log() will filter it correctly
automatically.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Tested-by: Richard W.M. Jones <rjones@redhat.com>
---
 block/ssh.c                   | 52 +++++++++++++++++++++++++++++++----
 tests/qemu-iotests/207        | 10 +++----
 tests/qemu-iotests/207.out    | 10 +++----
 tests/qemu-iotests/common.rc  |  2 +-
 tests/qemu-iotests/iotests.py |  2 +-
 5 files changed, 59 insertions(+), 17 deletions(-)

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
diff --git a/tests/qemu-iotests/207 b/tests/qemu-iotests/207
index dfd3c51bd1..b3816136f7 100755
--- a/tests/qemu-iotests/207
+++ b/tests/qemu-iotests/207
@@ -66,7 +66,7 @@ with iotests.FilePath('t.img') as disk_path, \
                           'size': 4194304 })
     vm.shutdown()
=20
-    iotests.img_info_log(remote_path, filter_path=3Ddisk_path)
+    iotests.img_info_log(remote_path)
     iotests.log("")
     iotests.img_info_log(disk_path)
=20
@@ -91,7 +91,7 @@ with iotests.FilePath('t.img') as disk_path, \
                           'size': 8388608 })
     vm.shutdown()
=20
-    iotests.img_info_log(remote_path, filter_path=3Ddisk_path)
+    iotests.img_info_log(remote_path)
=20
     vm.launch()
     blockdev_create(vm, { 'driver': 'ssh',
@@ -108,7 +108,7 @@ with iotests.FilePath('t.img') as disk_path, \
                           'size': 4194304 })
     vm.shutdown()
=20
-    iotests.img_info_log(remote_path, filter_path=3Ddisk_path)
+    iotests.img_info_log(remote_path)
=20
     md5_key =3D subprocess.check_output(
         'ssh-keyscan -t rsa 127.0.0.1 2>/dev/null | grep -v "\\^#" | ' +
@@ -146,7 +146,7 @@ with iotests.FilePath('t.img') as disk_path, \
                           'size': 8388608 })
     vm.shutdown()
=20
-    iotests.img_info_log(remote_path, filter_path=3Ddisk_path)
+    iotests.img_info_log(remote_path)
=20
     sha1_key =3D subprocess.check_output(
         'ssh-keyscan -t rsa 127.0.0.1 2>/dev/null | grep -v "\\^#" | ' +
@@ -184,7 +184,7 @@ with iotests.FilePath('t.img') as disk_path, \
                           'size': 4194304 })
     vm.shutdown()
=20
-    iotests.img_info_log(remote_path, filter_path=3Ddisk_path)
+    iotests.img_info_log(remote_path)
=20
     #
     # Invalid path and user
diff --git a/tests/qemu-iotests/207.out b/tests/qemu-iotests/207.out
index 568e8619d0..8b8c28c7e1 100644
--- a/tests/qemu-iotests/207.out
+++ b/tests/qemu-iotests/207.out
@@ -5,7 +5,7 @@
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "s=
erver.port": "22", "driver": "ssh", "path": "TEST_IMG"}}
+image: TEST_IMG
 file format: IMGFMT
 virtual size: 4.0M (4194304 bytes)
=20
@@ -21,7 +21,7 @@ virtual size: 4.0M (4194304 bytes)
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "s=
erver.port": "22", "driver": "ssh", "path": "TEST_IMG"}}
+image: TEST_IMG
 file format: IMGFMT
 virtual size: 8.0M (8388608 bytes)
=20
@@ -30,7 +30,7 @@ virtual size: 8.0M (8388608 bytes)
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "s=
erver.port": "22", "driver": "ssh", "path": "TEST_IMG"}}
+image: TEST_IMG
 file format: IMGFMT
 virtual size: 4.0M (4194304 bytes)
=20
@@ -45,7 +45,7 @@ Job failed: remote host key does not match host_key_che=
ck 'wrong'
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "s=
erver.port": "22", "driver": "ssh", "path": "TEST_IMG"}}
+image: TEST_IMG
 file format: IMGFMT
 virtual size: 8.0M (8388608 bytes)
=20
@@ -60,7 +60,7 @@ Job failed: remote host key does not match host_key_che=
ck 'wrong'
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "s=
erver.port": "22", "driver": "ssh", "path": "TEST_IMG"}}
+image: TEST_IMG
 file format: IMGFMT
 virtual size: 4.0M (4194304 bytes)
=20
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 09a27f02d0..f323fa2925 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -145,7 +145,7 @@ else
         TEST_IMG=3D"nbd:127.0.0.1:10810"
     elif [ "$IMGPROTO" =3D "ssh" ]; then
         TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
-        REMOTE_TEST_DIR=3D"ssh://127.0.0.1$TEST_DIR"
+        REMOTE_TEST_DIR=3D"ssh://\\($USER@\\)\\?127.0.0.1\\(:[0-9]\\+\\)=
\\?$TEST_DIR"
         TEST_IMG=3D"ssh://127.0.0.1$TEST_IMG_FILE"
     elif [ "$IMGPROTO" =3D "nfs" ]; then
         TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 4910fb2005..aa16d6cbdd 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -411,7 +411,7 @@ def remote_filename(path):
     if imgproto =3D=3D 'file':
         return path
     elif imgproto =3D=3D 'ssh':
-        return "ssh://127.0.0.1%s" % (path)
+        return "ssh://%s@127.0.0.1:22%s" % (os.environ.get('USER'), path=
)
     else:
         raise Exception("Protocol %s not supported" % (imgproto))
=20
--=20
2.20.1
