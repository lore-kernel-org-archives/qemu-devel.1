Received: from eggs.gnu.org ([2001:4830:134:3::10]:35048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnRNb-0005fC-8B
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnRNa-0002rX-0K
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:55:23 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Mar 2017 15:54:58 +0100
Message-Id: <1489416908-3771-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1489416908-3771-1-git-send-email-kwolf@redhat.com>
References: <1489416908-3771-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 02/12] file-posix: Consider max_segments for
 BlockLimits.max_transfer
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

From: Fam Zheng <famz@redhat.com>

BlockLimits.max_transfer can be too high without this fix, guest will
encounter I/O error or even get paused with werror=stop or rerror=stop. The
cause is explained below.

Linux has a separate limit, /sys/block/.../queue/max_segments, which in
the worst case can be more restrictive than the BLKSECTGET which we
already consider (note that they are two different things). So, the
failure scenario before this patch is:

1) host device has max_sectors_kb = 4096 and max_segments = 64;
2) guest learns max_sectors_kb limit from QEMU, but doesn't know
   max_segments;
3) guest issues e.g. a 512KB request thinking it's okay, but actually
   it's not, because it will be passed through to host device as an
   SG_IO req that has niov > 64;
4) host kernel doesn't like the segmenting of the request, and returns
   -EINVAL;

This patch checks the max_segments sysfs entry for the host device and
calculates a "conservative" bytes limit using the page size, which is
then merged into the existing max_transfer limit. Guest will discover
this from the usual virtual block device interfaces. (In the case of
scsi-generic, it will be done in the INQUIRY reply interception in
device model.)

The other possibility is to actually propagate it as a separate limit,
but it's not better. On the one hand, there is a big complication: the
limit is per-LUN in QEMU PoV (because we can attach LUNs from different
host HBAs to the same virtio-scsi bus), but the channel to communicate
it in a per-LUN manner is missing down the stack; on the other hand,
two limits versus one doesn't change much about the valid size of I/O
(because guest has no control over host segmenting).

Also, the idea to fall back to bounce buffering in QEMU, upon -EINVAL,
was explored. Unfortunately there is no neat way to ensure the bounce
buffer is less segmented (in terms of DMA addr) than the guest buffer.

Practically, this bug is not very common. It is only reported on a
Emulex (lpfc), so it's okay to get it fixed in the easier way.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 4de1abd..c4c0663 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -668,6 +668,48 @@ static int hdev_get_max_transfer_length(BlockDriverState *bs, int fd)
 #endif
 }
 
+static int hdev_get_max_segments(const struct stat *st)
+{
+#ifdef CONFIG_LINUX
+    char buf[32];
+    const char *end;
+    char *sysfspath;
+    int ret;
+    int fd = -1;
+    long max_segments;
+
+    sysfspath = g_strdup_printf("/sys/dev/block/%u:%u/queue/max_segments",
+                                major(st->st_rdev), minor(st->st_rdev));
+    fd = open(sysfspath, O_RDONLY);
+    if (fd == -1) {
+        ret = -errno;
+        goto out;
+    }
+    do {
+        ret = read(fd, buf, sizeof(buf));
+    } while (ret == -1 && errno == EINTR);
+    if (ret < 0) {
+        ret = -errno;
+        goto out;
+    } else if (ret == 0) {
+        ret = -EIO;
+        goto out;
+    }
+    buf[ret] = 0;
+    /* The file is ended with '\n', pass 'end' to accept that. */
+    ret = qemu_strtol(buf, &end, 10, &max_segments);
+    if (ret == 0 && end && *end == '\n') {
+        ret = max_segments;
+    }
+
+out:
+    g_free(sysfspath);
+    return ret;
+#else
+    return -ENOTSUP;
+#endif
+}
+
 static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     BDRVRawState *s = bs->opaque;
@@ -679,6 +721,11 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
             if (ret > 0 && ret <= BDRV_REQUEST_MAX_BYTES) {
                 bs->bl.max_transfer = pow2floor(ret);
             }
+            ret = hdev_get_max_segments(&st);
+            if (ret > 0) {
+                bs->bl.max_transfer = MIN(bs->bl.max_transfer,
+                                          ret * getpagesize());
+            }
         }
     }
 
-- 
1.8.3.1
