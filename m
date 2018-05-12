Received: from eggs.gnu.org ([2001:4830:134:3::10]:34946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fHQqs-0006Vl-77
	for qemu-devel@nongnu.org; Sat, 12 May 2018 05:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fHQqq-0000sg-Re
	for qemu-devel@nongnu.org; Sat, 12 May 2018 05:30:06 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Sat, 12 May 2018 10:28:24 +0100
Message-Id: <20180512092824.13848-9-stefanha@redhat.com>
In-Reply-To: <20180512092824.13848-1-stefanha@redhat.com>
References: <20180512092824.13848-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 8/8] block/file-posix: add
 x-check-page-cache=on|off option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

mincore(2) checks whether pages are resident.  Use it to verify that
page cache has been dropped.

You can trigger a verification failure by mmapping the image file from
another process that loads a byte from a page, forcing it to become
resident.  bdrv_co_invalidate_cache() will fail while that process is
alive.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-id: 20180427162312.18583-3-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qapi/block-core.json |   7 ++-
 block/file-posix.c   | 100 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index c50517bff3..21c3470234 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2530,6 +2530,10 @@
 # @locking:     whether to enable file locking. If set to 'auto', only enable
 #               when Open File Descriptor (OFD) locking API is available
 #               (default: auto, since 2.10)
+# @x-check-cache-dropped: whether to check that page cache was dropped on live
+#                         migration.  May cause noticeable delays if the image
+#                         file is large, do not use in production.
+#                         (default: off) (since: 2.13)
 #
 # Since: 2.9
 ##
@@ -2537,7 +2541,8 @@
   'data': { 'filename': 'str',
             '*pr-manager': 'str',
             '*locking': 'OnOffAuto',
-            '*aio': 'BlockdevAioOptions' } }
+            '*aio': 'BlockdevAioOptions',
+            '*x-check-cache-dropped': 'bool' } }
 
 ##
 # @BlockdevOptionsNull:
diff --git a/block/file-posix.c b/block/file-posix.c
index 3707ea2d1c..5a602cfe37 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -161,6 +161,7 @@ typedef struct BDRVRawState {
     bool page_cache_inconsistent:1;
     bool has_fallocate;
     bool needs_alignment;
+    bool check_cache_dropped;
 
     PRManager *pr_mgr;
 } BDRVRawState;
@@ -168,6 +169,7 @@ typedef struct BDRVRawState {
 typedef struct BDRVRawReopenState {
     int fd;
     int open_flags;
+    bool check_cache_dropped;
 } BDRVRawReopenState;
 
 static int fd_open(BlockDriverState *bs);
@@ -415,6 +417,11 @@ static QemuOptsList raw_runtime_opts = {
             .type = QEMU_OPT_STRING,
             .help = "id of persistent reservation manager object (default: none)",
         },
+        {
+            .name = "x-check-cache-dropped",
+            .type = QEMU_OPT_BOOL,
+            .help = "check that page cache was dropped on live migration (default: off)"
+        },
         { /* end of list */ }
     },
 };
@@ -500,6 +507,9 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
         }
     }
 
+    s->check_cache_dropped = qemu_opt_get_bool(opts, "x-check-cache-dropped",
+                                               false);
+
     s->open_flags = open_flags;
     raw_parse_flags(bdrv_flags, &s->open_flags);
 
@@ -777,6 +787,7 @@ static int raw_reopen_prepare(BDRVReopenState *state,
 {
     BDRVRawState *s;
     BDRVRawReopenState *rs;
+    QemuOpts *opts;
     int ret = 0;
     Error *local_err = NULL;
 
@@ -787,6 +798,19 @@ static int raw_reopen_prepare(BDRVReopenState *state,
 
     state->opaque = g_new0(BDRVRawReopenState, 1);
     rs = state->opaque;
+    rs->fd = -1;
+
+    /* Handle options changes */
+    opts = qemu_opts_create(&raw_runtime_opts, NULL, 0, &error_abort);
+    qemu_opts_absorb_qdict(opts, state->options, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+        goto out;
+    }
+
+    rs->check_cache_dropped = qemu_opt_get_bool(opts, "x-check-cache-dropped",
+                                                s->check_cache_dropped);
 
     if (s->type == FTYPE_CD) {
         rs->open_flags |= O_NONBLOCK;
@@ -794,8 +818,6 @@ static int raw_reopen_prepare(BDRVReopenState *state,
 
     raw_parse_flags(state->flags, &rs->open_flags);
 
-    rs->fd = -1;
-
     int fcntl_flags = O_APPEND | O_NONBLOCK;
 #ifdef O_NOATIME
     fcntl_flags |= O_NOATIME;
@@ -850,6 +872,8 @@ static int raw_reopen_prepare(BDRVReopenState *state,
         }
     }
 
+out:
+    qemu_opts_del(opts);
     return ret;
 }
 
@@ -858,6 +882,7 @@ static void raw_reopen_commit(BDRVReopenState *state)
     BDRVRawReopenState *rs = state->opaque;
     BDRVRawState *s = state->bs->opaque;
 
+    s->check_cache_dropped = rs->check_cache_dropped;
     s->open_flags = rs->open_flags;
 
     qemu_close(s->fd);
@@ -2236,6 +2261,73 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
     return ret | BDRV_BLOCK_OFFSET_VALID;
 }
 
+#if defined(__linux__)
+/* Verify that the file is not in the page cache */
+static void check_cache_dropped(BlockDriverState *bs, Error **errp)
+{
+    const size_t window_size = 128 * 1024 * 1024;
+    BDRVRawState *s = bs->opaque;
+    void *window = NULL;
+    size_t length = 0;
+    unsigned char *vec;
+    size_t page_size;
+    off_t offset;
+    off_t end;
+
+    /* mincore(2) page status information requires 1 byte per page */
+    page_size = sysconf(_SC_PAGESIZE);
+    vec = g_malloc(DIV_ROUND_UP(window_size, page_size));
+
+    end = raw_getlength(bs);
+
+    for (offset = 0; offset < end; offset += window_size) {
+        void *new_window;
+        size_t new_length;
+        size_t vec_end;
+        size_t i;
+        int ret;
+
+        /* Unmap previous window if size has changed */
+        new_length = MIN(end - offset, window_size);
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
+        ret = mincore(window, length, vec);
+        if (ret < 0) {
+            error_setg_errno(errp, errno, "mincore failed");
+            break;
+        }
+
+        vec_end = DIV_ROUND_UP(length, page_size);
+        for (i = 0; i < vec_end; i++) {
+            if (vec[i] & 0x1) {
+                error_setg(errp, "page cache still in use!");
+                break;
+            }
+        }
+    }
+
+    if (window) {
+        munmap(window, length);
+    }
+
+    g_free(vec);
+}
+#endif /* __linux__ */
+
 static void coroutine_fn raw_co_invalidate_cache(BlockDriverState *bs,
                                                  Error **errp)
 {
@@ -2269,6 +2361,10 @@ static void coroutine_fn raw_co_invalidate_cache(BlockDriverState *bs,
         error_setg_errno(errp, ret, "fadvise failed");
         return;
     }
+
+    if (s->check_cache_dropped) {
+        check_cache_dropped(bs, errp);
+    }
 #else /* __linux__ */
     /* Do nothing.  Live migration to a remote host with cache.direct=off is
      * unsupported on other host operating systems.  Cache consistency issues
-- 
2.17.0
