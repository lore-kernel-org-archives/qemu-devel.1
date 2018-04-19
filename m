Received: from eggs.gnu.org ([2001:4830:134:3::10]:43297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f94NJ-0004wI-DP
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 03:53:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f94NG-0002x0-9d
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 03:53:01 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 19 Apr 2018 15:52:32 +0800
Message-Id: <20180419075232.31407-3-stefanha@redhat.com>
In-Reply-To: <20180419075232.31407-1-stefanha@redhat.com>
References: <20180419075232.31407-1-stefanha@redhat.com>
Subject: [Qemu-devel] [RFC 2/2] block/file-posix: verify page cache is not
 used
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This commit is for debugging only.  Do not merge it.

mincore(2) checks whether pages are resident.  Use it to verify that
page cache has been dropped.

You can trigger a verification failure by mmapping the image file from
another process and loading a byte from a page so that it becomes
resident.  bdrv_co_invalidate_cache() will fail while the process is
alive.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/file-posix.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index df4f52919f..d3105269c6 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2236,6 +2236,75 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
     return ret | BDRV_BLOCK_OFFSET_VALID;
 }
 
+static bool is_mincore(void *addr, size_t length)
+{
+    size_t vec_len = DIV_ROUND_UP(length, sysconf(_SC_PAGESIZE));
+    unsigned char *vec;
+    size_t i;
+    int ret;
+    bool incore = false;
+
+    vec = g_malloc(vec_len);
+    ret = mincore(addr, length, vec);
+    if (ret < 0) {
+        incore = true;
+        goto out;
+    }
+
+    for (i = 0; i < vec_len; i++) {
+        if (vec[i] & 0x1) {
+            incore = true;
+            break;
+        }
+    }
+
+out:
+    g_free(vec);
+    return incore;
+}
+
+static void check_not_in_page_cache(BlockDriverState *bs, Error **errp)
+{
+    const size_t WINDOW_SIZE = 128 * 1024 * 1024;
+    BDRVRawState *s = bs->opaque;
+    void *window = NULL;
+    size_t length = 0;
+    off_t end;
+    off_t offset;
+
+    end = raw_getlength(bs);
+
+    for (offset = 0; offset < end; offset += WINDOW_SIZE) {
+        void *new_window;
+        size_t new_length = MIN(end - offset, WINDOW_SIZE);
+
+        if (new_length != length) {
+            munmap(window, length);
+            window = NULL;
+            length = 0;
+        }
+
+        new_window = mmap(window, new_length, PROT_NONE, MAP_PRIVATE,
+                          s->fd, offset);
+        if (new_window == MAP_FAILED) {
+            error_setg_errno(errp, errno, "mmap failed");
+            break;
+        }
+
+        window = new_window;
+        length = new_length;
+
+        if (is_mincore(window, length)) {
+            error_setg(errp, "page cache still in use!");
+            break;
+        }
+    }
+
+    if (window) {
+        munmap(window, length);
+    }
+}
+
 static void coroutine_fn raw_co_invalidate_cache(BlockDriverState *bs,
                                                  Error **errp)
 {
@@ -2270,6 +2339,8 @@ static void coroutine_fn raw_co_invalidate_cache(BlockDriverState *bs,
         return;
     }
 #endif /* __linux__ */
+
+    check_not_in_page_cache(bs, errp);
 }
 
 static coroutine_fn BlockAIOCB *raw_aio_pdiscard(BlockDriverState *bs,
-- 
2.14.3
