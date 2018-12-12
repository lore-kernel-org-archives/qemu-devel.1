Received: from eggs.gnu.org ([2001:4830:134:3::10]:47368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gXAMy-0005cT-1d
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:40:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gXAMv-0007kb-D3
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:40:31 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Wed, 12 Dec 2018 20:40:06 +0100
Message-Id: <20181212194009.2951-2-lvivier@redhat.com>
In-Reply-To: <20181212194009.2951-1-lvivier@redhat.com>
References: <20181212194009.2951-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/4] block/ssh: Convert from DPRINTF() macro to
 trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Liu Yuan <namei.unix@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-trivial@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>, qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 block/ssh.c        | 46 +++++++++++++++++-----------------------------
 block/trace-events | 17 +++++++++++++++++
 2 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/block/ssh.c b/block/ssh.c
index 7fbc27abdf..bbc513e095 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -41,27 +41,17 @@
 #include "qapi/qmp/qstring.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
+#include "trace.h"
=20
-/* DEBUG_SSH=3D1 enables the DPRINTF (debugging printf) statements in
- * this block driver code.
- *
+/*
  * TRACE_LIBSSH2=3D<bitmask> enables tracing in libssh2 itself.  Note
  * that this requires that libssh2 was specially compiled with the
  * `./configure --enable-debug' option, so most likely you will have
  * to compile it yourself.  The meaning of <bitmask> is described
  * here: http://www.libssh2.org/libssh2_trace.html
  */
-#define DEBUG_SSH     0
 #define TRACE_LIBSSH2 0 /* or try: LIBSSH2_TRACE_SFTP */
=20
-#define DPRINTF(fmt, ...)                           \
-    do {                                            \
-        if (DEBUG_SSH) {                            \
-            fprintf(stderr, "ssh: %-15s " fmt "\n", \
-                    __func__, ##__VA_ARGS__);       \
-        }                                           \
-    } while (0)
-
 typedef struct BDRVSSHState {
     /* Coroutine. */
     CoMutex lock;
@@ -336,7 +326,7 @@ static int check_host_key_knownhosts(BDRVSSHState *s,
     switch (r) {
     case LIBSSH2_KNOWNHOST_CHECK_MATCH:
         /* OK */
-        DPRINTF("host key OK: %s", found->key);
+        trace_ssh_check_host_key_knownhosts(found->key);
         break;
     case LIBSSH2_KNOWNHOST_CHECK_MISMATCH:
         ret =3D -EINVAL;
@@ -721,8 +711,7 @@ static int connect_to_ssh(BDRVSSHState *s, BlockdevOp=
tionsSsh *opts,
     }
=20
     /* Open the remote file. */
-    DPRINTF("opening file %s flags=3D0x%x creat_mode=3D0%o",
-            opts->path, ssh_flags, creat_mode);
+    trace_ssh_connect_to_ssh(opts->path, ssh_flags, creat_mode);
     s->sftp_handle =3D libssh2_sftp_open(s->sftp, opts->path, ssh_flags,
                                        creat_mode);
     if (!s->sftp_handle) {
@@ -890,7 +879,7 @@ static int coroutine_fn ssh_co_create_opts(const char=
 *filename, QemuOpts *opts,
     /* Get desired file size. */
     ssh_opts->size =3D ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SI=
ZE, 0),
                               BDRV_SECTOR_SIZE);
-    DPRINTF("total_size=3D%" PRIi64, ssh_opts->size);
+    trace_ssh_co_create_opts(ssh_opts->size);
=20
     uri_options =3D qdict_new();
     ret =3D parse_uri(filename, uri_options, errp);
@@ -946,7 +935,7 @@ static void restart_coroutine(void *opaque)
     BDRVSSHState *s =3D bs->opaque;
     AioContext *ctx =3D bdrv_get_aio_context(bs);
=20
-    DPRINTF("co=3D%p", restart->co);
+    trace_ssh_restart_coroutine(restart->co);
     aio_set_fd_handler(ctx, s->sock, false, NULL, NULL, NULL, NULL);
=20
     aio_co_wake(restart->co);
@@ -974,13 +963,12 @@ static coroutine_fn void co_yield(BDRVSSHState *s, =
BlockDriverState *bs)
         wr_handler =3D restart_coroutine;
     }
=20
-    DPRINTF("s->sock=3D%d rd_handler=3D%p wr_handler=3D%p", s->sock,
-            rd_handler, wr_handler);
+    trace_ssh_co_yield(s->sock, rd_handler, wr_handler);
=20
     aio_set_fd_handler(bdrv_get_aio_context(bs), s->sock,
                        false, rd_handler, wr_handler, NULL, &restart);
     qemu_coroutine_yield();
-    DPRINTF("s->sock=3D%d - back", s->sock);
+    trace_ssh_co_yield_back(s->sock);
 }
=20
 /* SFTP has a function `libssh2_sftp_seek64' which seeks to a position
@@ -1003,7 +991,7 @@ static void ssh_seek(BDRVSSHState *s, int64_t offset=
, int flags)
     bool force =3D (flags & SSH_SEEK_FORCE) !=3D 0;
=20
     if (force || op_read !=3D s->offset_op_read || offset !=3D s->offset=
) {
-        DPRINTF("seeking to offset=3D%" PRIi64, offset);
+        trace_ssh_seek(offset);
         libssh2_sftp_seek64(s->sftp_handle, offset);
         s->offset =3D offset;
         s->offset_op_read =3D op_read;
@@ -1019,7 +1007,7 @@ static coroutine_fn int ssh_read(BDRVSSHState *s, B=
lockDriverState *bs,
     char *buf, *end_of_vec;
     struct iovec *i;
=20
-    DPRINTF("offset=3D%" PRIi64 " size=3D%zu", offset, size);
+    trace_ssh_read(offset, size);
=20
     ssh_seek(s, offset, SSH_SEEK_READ);
=20
@@ -1038,9 +1026,9 @@ static coroutine_fn int ssh_read(BDRVSSHState *s, B=
lockDriverState *bs,
      */
     for (got =3D 0; got < size; ) {
     again:
-        DPRINTF("sftp_read buf=3D%p size=3D%zu", buf, end_of_vec - buf);
+        trace_ssh_read_buf(buf, end_of_vec - buf);
         r =3D libssh2_sftp_read(s->sftp_handle, buf, end_of_vec - buf);
-        DPRINTF("sftp_read returned %zd", r);
+        trace_ssh_read_return(r);
=20
         if (r =3D=3D LIBSSH2_ERROR_EAGAIN || r =3D=3D LIBSSH2_ERROR_TIME=
OUT) {
             co_yield(s, bs);
@@ -1094,7 +1082,7 @@ static int ssh_write(BDRVSSHState *s, BlockDriverSt=
ate *bs,
     char *buf, *end_of_vec;
     struct iovec *i;
=20
-    DPRINTF("offset=3D%" PRIi64 " size=3D%zu", offset, size);
+    trace_ssh_write(offset, size);
=20
     ssh_seek(s, offset, SSH_SEEK_WRITE);
=20
@@ -1108,9 +1096,9 @@ static int ssh_write(BDRVSSHState *s, BlockDriverSt=
ate *bs,
=20
     for (written =3D 0; written < size; ) {
     again:
-        DPRINTF("sftp_write buf=3D%p size=3D%zu", buf, end_of_vec - buf)=
;
+        trace_ssh_write_buf(buf, end_of_vec - buf);
         r =3D libssh2_sftp_write(s->sftp_handle, buf, end_of_vec - buf);
-        DPRINTF("sftp_write returned %zd", r);
+        trace_ssh_write_return(r);
=20
         if (r =3D=3D LIBSSH2_ERROR_EAGAIN || r =3D=3D LIBSSH2_ERROR_TIME=
OUT) {
             co_yield(s, bs);
@@ -1187,7 +1175,7 @@ static coroutine_fn int ssh_flush(BDRVSSHState *s, =
BlockDriverState *bs)
 {
     int r;
=20
-    DPRINTF("fsync");
+    trace_ssh_flush();
  again:
     r =3D libssh2_sftp_fsync(s->sftp_handle);
     if (r =3D=3D LIBSSH2_ERROR_EAGAIN || r =3D=3D LIBSSH2_ERROR_TIMEOUT)=
 {
@@ -1238,7 +1226,7 @@ static int64_t ssh_getlength(BlockDriverState *bs)
=20
     /* Note we cannot make a libssh2 call here. */
     length =3D (int64_t) s->attrs.filesize;
-    DPRINTF("length=3D%" PRIi64, length);
+    trace_ssh_getlength(length);
=20
     return length;
 }
diff --git a/block/trace-events b/block/trace-events
index 3e8c47bb24..b13b1e9706 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -156,3 +156,20 @@ nvme_cmd_map_qiov_iov(void *s, int i, void *page, in=
t pages) "s %p iov[%d] %p pa
=20
 # block/iscsi.c
 iscsi_xcopy(void *src_lun, uint64_t src_off, void *dst_lun, uint64_t dst=
_off, uint64_t bytes, int ret) "src_lun %p offset %"PRIu64" dst_lun %p of=
fset %"PRIu64" bytes %"PRIu64" ret %d"
+
+# block/ssh.c
+ssh_restart_coroutine(void *co) "co=3D%p"
+ssh_flush(void) "fsync"
+ssh_check_host_key_knownhosts(const char *key) "host key OK: %s"
+ssh_connect_to_ssh(char *path, int flags, int mode) "opening file %s fla=
gs=3D0x%x creat_mode=3D0%o"
+ssh_co_yield(int sock, void *rd_handler, void *wr_handler) "s->sock=3D%d=
 rd_handler=3D%p wr_handler=3D%p"
+ssh_co_yield_back(int sock) "s->sock=3D%d - back"
+ssh_getlength(int64_t length) "length=3D%" PRIi64
+ssh_co_create_opts(uint64_t size) "total_size=3D%" PRIu64
+ssh_read(int64_t offset, size_t size) "offset=3D%" PRIi64 " size=3D%zu"
+ssh_read_buf(void *buf, size_t size) "sftp_read buf=3D%p size=3D%zu"
+ssh_read_return(size_t ret) "sftp_read returned %zd"
+ssh_write(int64_t offset, size_t size) "offset=3D%" PRIi64 " size=3D%zu"
+ssh_write_buf(void *buf, size_t size) "sftp_write buf=3D%p size=3D%zu"
+ssh_write_return(size_t ret) "sftp_write returned %zd"
+ssh_seek(uint64_t offset) "seeking to offset=3D%" PRIi64
--=20
2.19.2
