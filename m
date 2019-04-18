Received: from eggs.gnu.org ([209.51.188.92]:54848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0g-0005GD-RM
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0d-0005Mi-35
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:52 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 18 Apr 2019 22:51:05 +0200
Message-Id: <20190418205135.6686-7-armbru@redhat.com>
In-Reply-To: <20190418205135.6686-1-armbru@redhat.com>
References: <20190418205135.6686-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for-4.1 06/36] block/ssh: Do not report
 read/write/flush errors to the user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Richard W.M. Jones" <rjones@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Callbacks ssh_co_readv(), ssh_co_writev(), ssh_co_flush() report
errors to the user with error_printf().  They shouldn't, it's their
caller's job.  Replace by a suitable trace point.  While there, drop
the unreachable !s->sftp case.

Perhaps we should convert this part of the block driver interface to
Error, so block drivers can pass more detail to their callers.  Not
today.

Cc: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190417190641.26814-3-armbru@redhat.com>
---
 block/ssh.c        | 38 +++++++++++++-------------------------
 block/trace-events |  3 +++
 2 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/block/ssh.c b/block/ssh.c
index 190ef95300..859249113d 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -159,31 +159,19 @@ sftp_error_setg(Error **errp, BDRVSSHState *s, const char *fs, ...)
     g_free(msg);
 }
 
-static void GCC_FMT_ATTR(2, 3)
-sftp_error_report(BDRVSSHState *s, const char *fs, ...)
+static void sftp_error_trace(BDRVSSHState *s, const char *op)
 {
-    va_list args;
+    char *ssh_err;
+    int ssh_err_code;
+    unsigned long sftp_err_code;
 
-    va_start(args, fs);
-    error_vprintf(fs, args);
+    /* This is not an errno.  See <libssh2.h>. */
+    ssh_err_code = libssh2_session_last_error(s->session,
+                                              &ssh_err, NULL, 0);
+    /* See <libssh2_sftp.h>. */
+    sftp_err_code = libssh2_sftp_last_error((s)->sftp);
 
-    if ((s)->sftp) {
-        char *ssh_err;
-        int ssh_err_code;
-        unsigned long sftp_err_code;
-
-        /* This is not an errno.  See <libssh2.h>. */
-        ssh_err_code = libssh2_session_last_error(s->session,
-                                                  &ssh_err, NULL, 0);
-        /* See <libssh2_sftp.h>. */
-        sftp_err_code = libssh2_sftp_last_error((s)->sftp);
-
-        error_printf(": %s (libssh2 error code: %d, sftp error code: %lu)",
-                     ssh_err, ssh_err_code, sftp_err_code);
-    }
-
-    va_end(args);
-    error_printf("\n");
+    trace_sftp_error(op, ssh_err, ssh_err_code, sftp_err_code);
 }
 
 static int parse_uri(const char *filename, QDict *options, Error **errp)
@@ -1035,7 +1023,7 @@ static coroutine_fn int ssh_read(BDRVSSHState *s, BlockDriverState *bs,
             goto again;
         }
         if (r < 0) {
-            sftp_error_report(s, "read failed");
+            sftp_error_trace(s, "read");
             s->offset = -1;
             return -EIO;
         }
@@ -1105,7 +1093,7 @@ static int ssh_write(BDRVSSHState *s, BlockDriverState *bs,
             goto again;
         }
         if (r < 0) {
-            sftp_error_report(s, "write failed");
+            sftp_error_trace(s, "write");
             s->offset = -1;
             return -EIO;
         }
@@ -1188,7 +1176,7 @@ static coroutine_fn int ssh_flush(BDRVSSHState *s, BlockDriverState *bs)
         return 0;
     }
     if (r < 0) {
-        sftp_error_report(s, "fsync failed");
+        sftp_error_trace(s, "fsync");
         return -EIO;
     }
 
diff --git a/block/trace-events b/block/trace-events
index 7335a42540..79ccd8d824 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -208,3 +208,6 @@ sheepdog_co_rw_vector_new(uint64_t oid) "new oid 0x%" PRIx64
 sheepdog_snapshot_create_info(const char *sn_name, const char *id, const char *name, int64_t size, int is_snapshot) "sn_info: name %s id_str %s s: name %s vm_state_size %" PRId64 " " "is_snapshot %d"
 sheepdog_snapshot_create(const char *sn_name, const char *id) "%s %s"
 sheepdog_snapshot_create_inode(const char *name, uint32_t snap, uint32_t vdi) "s->inode: name %s snap_id 0x%" PRIx32 " vdi 0x%" PRIx32
+
+# ssh.c
+sftp_error(const char *op, const char *ssh_err, int ssh_err_code, unsigned long sftp_err_code) "%s failed: %s (libssh2 error code: %d, sftp error code: %lu)"
-- 
2.17.2
