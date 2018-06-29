Received: from eggs.gnu.org ([2001:4830:134:3::10]:49570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6S-0003v8-0A
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6P-0003tO-Kb
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:23 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 29 Jun 2018 16:09:41 +0200
Message-Id: <20180629140959.6690-12-kwolf@redhat.com>
In-Reply-To: <20180629140959.6690-1-kwolf@redhat.com>
References: <20180629140959.6690-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 11/29] file-posix: Make .bdrv_co_truncate
 asynchronous
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

This moves the code to resize an image file to the thread pool to avoid
blocking.

Creating large images with preallocation with blockdev-create is now
actually a background job instead of blocking the monitor (and most
other things) until the preallocation has completed.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/raw-aio.h |   4 +-
 block/file-posix.c      | 266 +++++++++++++++++++++++++++---------------------
 2 files changed, 154 insertions(+), 116 deletions(-)

diff --git a/include/block/raw-aio.h b/include/block/raw-aio.h
index 8d698ccd31..6799614e56 100644
--- a/include/block/raw-aio.h
+++ b/include/block/raw-aio.h
@@ -26,6 +26,7 @@
 #define QEMU_AIO_DISCARD      0x0010
 #define QEMU_AIO_WRITE_ZEROES 0x0020
 #define QEMU_AIO_COPY_RANGE   0x0040
+#define QEMU_AIO_TRUNCATE     0x0080
 #define QEMU_AIO_TYPE_MASK \
         (QEMU_AIO_READ | \
          QEMU_AIO_WRITE | \
@@ -33,7 +34,8 @@
          QEMU_AIO_FLUSH | \
          QEMU_AIO_DISCARD | \
          QEMU_AIO_WRITE_ZEROES | \
-         QEMU_AIO_COPY_RANGE)
+         QEMU_AIO_COPY_RANGE | \
+         QEMU_AIO_TRUNCATE)
 
 /* AIO flags */
 #define QEMU_AIO_MISALIGNED   0x1000
diff --git a/block/file-posix.c b/block/file-posix.c
index 53c5833659..639265d53b 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -188,8 +188,16 @@ typedef struct RawPosixAIOData {
 #define aio_ioctl_cmd   aio_nbytes /* for QEMU_AIO_IOCTL */
     off_t aio_offset;
     int aio_type;
-    int aio_fd2;
-    off_t aio_offset2;
+    union {
+        struct {
+            int aio_fd2;
+            off_t aio_offset2;
+        };
+        struct {
+            PreallocMode prealloc;
+            Error **errp;
+        };
+    };
 } RawPosixAIOData;
 
 #if defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
@@ -1539,6 +1547,122 @@ static ssize_t handle_aiocb_discard(RawPosixAIOData *aiocb)
     return ret;
 }
 
+static int handle_aiocb_truncate(RawPosixAIOData *aiocb)
+{
+    int result = 0;
+    int64_t current_length = 0;
+    char *buf = NULL;
+    struct stat st;
+    int fd = aiocb->aio_fildes;
+    int64_t offset = aiocb->aio_offset;
+    Error **errp = aiocb->errp;
+
+    if (fstat(fd, &st) < 0) {
+        result = -errno;
+        error_setg_errno(errp, -result, "Could not stat file");
+        return result;
+    }
+
+    current_length = st.st_size;
+    if (current_length > offset && aiocb->prealloc != PREALLOC_MODE_OFF) {
+        error_setg(errp, "Cannot use preallocation for shrinking files");
+        return -ENOTSUP;
+    }
+
+    switch (aiocb->prealloc) {
+#ifdef CONFIG_POSIX_FALLOCATE
+    case PREALLOC_MODE_FALLOC:
+        /*
+         * Truncating before posix_fallocate() makes it about twice slower on
+         * file systems that do not support fallocate(), trying to check if a
+         * block is allocated before allocating it, so don't do that here.
+         */
+        if (offset != current_length) {
+            result = -posix_fallocate(fd, current_length,
+                                      offset - current_length);
+            if (result != 0) {
+                /* posix_fallocate() doesn't set errno. */
+                error_setg_errno(errp, -result,
+                                 "Could not preallocate new data");
+            }
+        } else {
+            result = 0;
+        }
+        goto out;
+#endif
+    case PREALLOC_MODE_FULL:
+    {
+        int64_t num = 0, left = offset - current_length;
+        off_t seek_result;
+
+        /*
+         * Knowing the final size from the beginning could allow the file
+         * system driver to do less allocations and possibly avoid
+         * fragmentation of the file.
+         */
+        if (ftruncate(fd, offset) != 0) {
+            result = -errno;
+            error_setg_errno(errp, -result, "Could not resize file");
+            goto out;
+        }
+
+        buf = g_malloc0(65536);
+
+        seek_result = lseek(fd, current_length, SEEK_SET);
+        if (seek_result < 0) {
+            result = -errno;
+            error_setg_errno(errp, -result,
+                             "Failed to seek to the old end of file");
+            goto out;
+        }
+
+        while (left > 0) {
+            num = MIN(left, 65536);
+            result = write(fd, buf, num);
+            if (result < 0) {
+                result = -errno;
+                error_setg_errno(errp, -result,
+                                 "Could not write zeros for preallocation");
+                goto out;
+            }
+            left -= result;
+        }
+        if (result >= 0) {
+            result = fsync(fd);
+            if (result < 0) {
+                result = -errno;
+                error_setg_errno(errp, -result,
+                                 "Could not flush file to disk");
+                goto out;
+            }
+        }
+        goto out;
+    }
+    case PREALLOC_MODE_OFF:
+        if (ftruncate(fd, offset) != 0) {
+            result = -errno;
+            error_setg_errno(errp, -result, "Could not resize file");
+        }
+        return result;
+    default:
+        result = -ENOTSUP;
+        error_setg(errp, "Unsupported preallocation mode: %s",
+                   PreallocMode_str(aiocb->prealloc));
+        return result;
+    }
+
+out:
+    if (result < 0) {
+        if (ftruncate(fd, current_length) < 0) {
+            error_report("Failed to restore old file length: %s",
+                         strerror(errno));
+        }
+    }
+
+    g_free(buf);
+    return result;
+}
+
 static int aio_worker(void *arg)
 {
     RawPosixAIOData *aiocb = arg;
@@ -1582,6 +1706,9 @@ static int aio_worker(void *arg)
     case QEMU_AIO_COPY_RANGE:
         ret = handle_aiocb_copy_range(aiocb);
         break;
+    case QEMU_AIO_TRUNCATE:
+        ret = handle_aiocb_truncate(aiocb);
+        break;
     default:
         fprintf(stderr, "invalid aio request (0x%x)\n", aiocb->aio_type);
         ret = -EINVAL;
@@ -1765,117 +1892,25 @@ static void raw_close(BlockDriverState *bs)
  *
  * Returns: 0 on success, -errno on failure.
  */
-static int raw_regular_truncate(int fd, int64_t offset, PreallocMode prealloc,
-                                Error **errp)
+static int coroutine_fn
+raw_regular_truncate(BlockDriverState *bs, int fd, int64_t offset,
+                     PreallocMode prealloc, Error **errp)
 {
-    int result = 0;
-    int64_t current_length = 0;
-    char *buf = NULL;
-    struct stat st;
-
-    if (fstat(fd, &st) < 0) {
-        result = -errno;
-        error_setg_errno(errp, -result, "Could not stat file");
-        return result;
-    }
-
-    current_length = st.st_size;
-    if (current_length > offset && prealloc != PREALLOC_MODE_OFF) {
-        error_setg(errp, "Cannot use preallocation for shrinking files");
-        return -ENOTSUP;
-    }
-
-    switch (prealloc) {
-#ifdef CONFIG_POSIX_FALLOCATE
-    case PREALLOC_MODE_FALLOC:
-        /*
-         * Truncating before posix_fallocate() makes it about twice slower on
-         * file systems that do not support fallocate(), trying to check if a
-         * block is allocated before allocating it, so don't do that here.
-         */
-        if (offset != current_length) {
-            result = -posix_fallocate(fd, current_length, offset - current_length);
-            if (result != 0) {
-                /* posix_fallocate() doesn't set errno. */
-                error_setg_errno(errp, -result,
-                                 "Could not preallocate new data");
-            }
-        } else {
-            result = 0;
-        }
-        goto out;
-#endif
-    case PREALLOC_MODE_FULL:
-    {
-        int64_t num = 0, left = offset - current_length;
-        off_t seek_result;
-
-        /*
-         * Knowing the final size from the beginning could allow the file
-         * system driver to do less allocations and possibly avoid
-         * fragmentation of the file.
-         */
-        if (ftruncate(fd, offset) != 0) {
-            result = -errno;
-            error_setg_errno(errp, -result, "Could not resize file");
-            goto out;
-        }
-
-        buf = g_malloc0(65536);
-
-        seek_result = lseek(fd, current_length, SEEK_SET);
-        if (seek_result < 0) {
-            result = -errno;
-            error_setg_errno(errp, -result,
-                             "Failed to seek to the old end of file");
-            goto out;
-        }
-
-        while (left > 0) {
-            num = MIN(left, 65536);
-            result = write(fd, buf, num);
-            if (result < 0) {
-                result = -errno;
-                error_setg_errno(errp, -result,
-                                 "Could not write zeros for preallocation");
-                goto out;
-            }
-            left -= result;
-        }
-        if (result >= 0) {
-            result = fsync(fd);
-            if (result < 0) {
-                result = -errno;
-                error_setg_errno(errp, -result,
-                                 "Could not flush file to disk");
-                goto out;
-            }
-        }
-        goto out;
-    }
-    case PREALLOC_MODE_OFF:
-        if (ftruncate(fd, offset) != 0) {
-            result = -errno;
-            error_setg_errno(errp, -result, "Could not resize file");
-        }
-        return result;
-    default:
-        result = -ENOTSUP;
-        error_setg(errp, "Unsupported preallocation mode: %s",
-                   PreallocMode_str(prealloc));
-        return result;
-    }
+    RawPosixAIOData *acb = g_new(RawPosixAIOData, 1);
+    ThreadPool *pool;
 
-out:
-    if (result < 0) {
-        if (ftruncate(fd, current_length) < 0) {
-            error_report("Failed to restore old file length: %s",
-                         strerror(errno));
-        }
-    }
+    *acb = (RawPosixAIOData) {
+        .bs             = bs,
+        .aio_fildes     = fd,
+        .aio_type       = QEMU_AIO_TRUNCATE,
+        .aio_offset     = offset,
+        .prealloc       = prealloc,
+        .errp           = errp,
+    };
 
-    g_free(buf);
-    return result;
+    /* @bs can be NULL, bdrv_get_aio_context() returns the main context then */
+    pool = aio_get_thread_pool(bdrv_get_aio_context(bs));
+    return thread_pool_submit_co(pool, aio_worker, acb);
 }
 
 static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
@@ -1892,7 +1927,7 @@ static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
     }
 
     if (S_ISREG(st.st_mode)) {
-        return raw_regular_truncate(s->fd, offset, prealloc, errp);
+        return raw_regular_truncate(bs, s->fd, offset, prealloc, errp);
     }
 
     if (prealloc != PREALLOC_MODE_OFF) {
@@ -2094,7 +2129,8 @@ static int64_t raw_get_allocated_file_size(BlockDriverState *bs)
     return (int64_t)st.st_blocks * 512;
 }
 
-static int raw_co_create(BlockdevCreateOptions *options, Error **errp)
+static int coroutine_fn
+raw_co_create(BlockdevCreateOptions *options, Error **errp)
 {
     BlockdevCreateOptionsFile *file_opts;
     int fd;
@@ -2146,7 +2182,7 @@ static int raw_co_create(BlockdevCreateOptions *options, Error **errp)
     }
 
     /* Clear the file by truncating it to 0 */
-    result = raw_regular_truncate(fd, 0, PREALLOC_MODE_OFF, errp);
+    result = raw_regular_truncate(NULL, fd, 0, PREALLOC_MODE_OFF, errp);
     if (result < 0) {
         goto out_close;
     }
@@ -2168,8 +2204,8 @@ static int raw_co_create(BlockdevCreateOptions *options, Error **errp)
 
     /* Resize and potentially preallocate the file to the desired
      * final size */
-    result = raw_regular_truncate(fd, file_opts->size, file_opts->preallocation,
-                                  errp);
+    result = raw_regular_truncate(NULL, fd, file_opts->size,
+                                  file_opts->preallocation, errp);
     if (result < 0) {
         goto out_close;
     }
-- 
2.13.6
