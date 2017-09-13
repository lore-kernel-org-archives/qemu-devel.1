Received: from eggs.gnu.org ([2001:4830:134:3::10]:37949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dsCId-0001JG-4v
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dsCIb-0006hg-UX
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:22:11 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 13 Sep 2017 20:19:09 +0200
Message-Id: <20170913181910.29688-18-mreitz@redhat.com>
In-Reply-To: <20170913181910.29688-1-mreitz@redhat.com>
References: <20170913181910.29688-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 17/18] qemu-io: Add background write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

Add a new parameter -B to qemu-io's write command.  When used, qemu-io
will not wait for the result of the operation and instead execute it in
the background.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-io-cmds.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 77 insertions(+), 6 deletions(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 2811a89099..c635a248f5 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -481,6 +481,62 @@ static int do_pwrite(BlockBackend *blk, char *buf, int64_t offset,
 typedef struct {
     BlockBackend *blk;
     int64_t offset;
+    int bytes;
+    char *buf;
+    int flags;
+} CoBackgroundWrite;
+
+static void coroutine_fn co_background_pwrite_entry(void *opaque)
+{
+    CoBackgroundWrite *data = opaque;
+    QEMUIOVector qiov;
+    int ret;
+
+    qemu_iovec_init(&qiov, 1);
+    qemu_iovec_add(&qiov, data->buf, data->bytes);
+
+    ret = blk_co_pwritev(data->blk, data->offset, data->bytes, &qiov,
+                         data->flags);
+
+    qemu_iovec_destroy(&qiov);
+    g_free(data->buf);
+
+    if (ret < 0) {
+        Error *err;
+        error_setg_errno(&err, -ret, "Background write failed");
+        error_report_err(err);
+    }
+}
+
+/* Takes ownership of @buf */
+static int do_background_pwrite(BlockBackend *blk, char *buf, int64_t offset,
+                                int64_t bytes, int flags)
+{
+    Coroutine *co;
+    CoBackgroundWrite *data;
+
+    if (bytes > INT_MAX) {
+        return -ERANGE;
+    }
+
+    data = g_new(CoBackgroundWrite, 1);
+    *data = (CoBackgroundWrite){
+        .blk    = blk,
+        .offset = offset,
+        .bytes  = bytes,
+        .buf    = buf,
+        .flags  = flags,
+    };
+
+    co = qemu_coroutine_create(co_background_pwrite_entry, data);
+    bdrv_coroutine_enter(blk_bs(blk), co);
+
+    return bytes;
+}
+
+typedef struct {
+    BlockBackend *blk;
+    int64_t offset;
     int64_t bytes;
     int64_t *total;
     int flags;
@@ -931,6 +987,7 @@ static void write_help(void)
 " Writes into a segment of the currently open file, using a buffer\n"
 " filled with a set pattern (0xcdcdcdcd).\n"
 " -b, -- write to the VM state rather than the virtual disk\n"
+" -B, -- just start a background write, do not wait for the result\n"
 " -c, -- write compressed data with blk_write_compressed\n"
 " -f, -- use Force Unit Access semantics\n"
 " -p, -- ignored for backwards compatibility\n"
@@ -951,7 +1008,7 @@ static const cmdinfo_t write_cmd = {
     .perm       = BLK_PERM_WRITE,
     .argmin     = 2,
     .argmax     = -1,
-    .args       = "[-bcCfquz] [-P pattern] off len",
+    .args       = "[-bBcCfquz] [-P pattern] off len",
     .oneline    = "writes a number of bytes at a specified offset",
     .help       = write_help,
 };
@@ -961,6 +1018,7 @@ static int write_f(BlockBackend *blk, int argc, char **argv)
     struct timeval t1, t2;
     bool Cflag = false, qflag = false, bflag = false;
     bool Pflag = false, zflag = false, cflag = false;
+    bool background = false;
     int flags = 0;
     int c, cnt;
     char *buf = NULL;
@@ -970,11 +1028,14 @@ static int write_f(BlockBackend *blk, int argc, char **argv)
     int64_t total = 0;
     int pattern = 0xcd;
 
-    while ((c = getopt(argc, argv, "bcCfpP:quz")) != -1) {
+    while ((c = getopt(argc, argv, "bBcCfpP:quz")) != -1) {
         switch (c) {
         case 'b':
             bflag = true;
             break;
+        case 'B':
+            background = true;
+            break;
         case 'c':
             cflag = true;
             break;
@@ -1032,6 +1093,11 @@ static int write_f(BlockBackend *blk, int argc, char **argv)
         return 0;
     }
 
+    if (background && (bflag || cflag || zflag)) {
+        printf("-B cannot be specified together with -b, -c, or -z\n");
+        return 0;
+    }
+
     offset = cvtnum(argv[optind]);
     if (offset < 0) {
         print_cvtnum_err(offset, argv[optind]);
@@ -1074,6 +1140,8 @@ static int write_f(BlockBackend *blk, int argc, char **argv)
         cnt = do_co_pwrite_zeroes(blk, offset, count, flags, &total);
     } else if (cflag) {
         cnt = do_write_compressed(blk, buf, offset, count, &total);
+    } else if (background) {
+        cnt = do_background_pwrite(blk, buf, offset, count, flags);
     } else {
         cnt = do_pwrite(blk, buf, offset, count, flags, &total);
     }
@@ -1088,12 +1156,15 @@ static int write_f(BlockBackend *blk, int argc, char **argv)
         goto out;
     }
 
-    /* Finally, report back -- -C gives a parsable format */
-    t2 = tsub(t2, t1);
-    print_report("wrote", &t2, offset, count, total, cnt, Cflag);
+    if (!background) {
+        /* Finally, report back -- -C gives a parsable format */
+        t2 = tsub(t2, t1);
+        print_report("wrote", &t2, offset, count, total, cnt, Cflag);
+    }
 
 out:
-    if (!zflag) {
+    /* do_background_pwrite() takes ownership of the buffer */
+    if (!zflag && !background) {
         qemu_io_free(buf);
     }
 
-- 
2.13.5
