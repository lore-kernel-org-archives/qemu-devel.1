Received: from eggs.gnu.org ([2001:4830:134:3::10]:38635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1clVbw-0005Zp-Ez
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 02:02:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1clVbv-0000v4-LE
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 02:02:12 -0500
From: Fam Zheng <famz@redhat.com>
Date: Wed,  8 Mar 2017 15:01:59 +0800
Message-Id: <20170308070159.19487-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2] file-posix: Incoporate max_segments in
 block limit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, eblake@redhat.com

Linux exposes a separate limit, /sys/block/.../queue/max_segments, which
in the worst case can be more restrictive than BLKSECTGET (as they are
two different things). Similar to the BLKSECTGET story, guests don't see
this limit and send big requests will get -EINVAL error on SG_IO.

Lean on the safer side to clamp max_transfer according to max_segments
and page size, because in the end what host HBA gets is the mapped host
pages rather than a guest buffer.

Signed-off-by: Fam Zheng <famz@redhat.com>

---

v2: Use /sys/dev/block/MAJOR:MINOR/queue/max_segments. [Paolo]
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
2.9.3
