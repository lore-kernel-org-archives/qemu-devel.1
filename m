Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D59C2BB86
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 11:15:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52C8620732
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 11:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C8620732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNx4B-0007O4-HS
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 07:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jNx0u-0002k3-Ts
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 07:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jNx0s-0000iL-Jd
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 07:12:28 -0400
Received: from relay.sw.ru ([185.231.240.75]:40332)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jNx0s-0000fx-7n
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 07:12:26 -0400
Received: from vgpu0.qa.sw.ru ([10.94.1.107])
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jNx0h-0002VQ-PK; Mon, 13 Apr 2020 14:12:15 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [RFC patch v1 2/3] qemu-file: add buffered mode
Date: Mon, 13 Apr 2020 14:12:13 +0300
Message-Id: <1586776334-641239-3-git-send-email-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1586776334-641239-1-git-send-email-dplotnikov@virtuozzo.com>
References: <1586776334-641239-1-git-send-email-dplotnikov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: den@openvz.org, dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The patch adds ability to qemu-file to write the data
asynchronously to improve the performance on writing.
Before, only synchronous writing was supported.

Enabling of the asyncronous mode is managed by new
"enabled_buffered" callback.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 include/qemu/typedefs.h |   1 +
 migration/qemu-file.c   | 351 +++++++++++++++++++++++++++++++++++++++++++++---
 migration/qemu-file.h   |   9 ++
 3 files changed, 339 insertions(+), 22 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 88dce54..9b388c8 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -98,6 +98,7 @@ typedef struct QEMUBH QEMUBH;
 typedef struct QemuConsole QemuConsole;
 typedef struct QEMUFile QEMUFile;
 typedef struct QEMUFileBuffer QEMUFileBuffer;
+typedef struct QEMUFileAioTask QEMUFileAioTask;
 typedef struct QemuLockable QemuLockable;
 typedef struct QemuMutex QemuMutex;
 typedef struct QemuOpt QemuOpt;
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 285c6ef..f42f949 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -29,19 +29,25 @@
 #include "qemu-file.h"
 #include "trace.h"
 #include "qapi/error.h"
+#include "block/aio_task.h"
 
-#define IO_BUF_SIZE 32768
+#define IO_BUF_SIZE (1024 * 1024)
 #define MAX_IOV_SIZE MIN(IOV_MAX, 64)
+#define IO_BUF_NUM 2
+#define IO_BUF_ALIGNMENT 512
 
-QEMU_BUILD_BUG_ON(!QEMU_IS_ALIGNED(IO_BUF_SIZE, 512));
+QEMU_BUILD_BUG_ON(!QEMU_IS_ALIGNED(IO_BUF_SIZE, IO_BUF_ALIGNMENT));
+QEMU_BUILD_BUG_ON(IO_BUF_SIZE > INT_MAX);
+QEMU_BUILD_BUG_ON(IO_BUF_NUM <= 0);
 
 struct QEMUFileBuffer {
     int buf_index;
-    int buf_size; /* 0 when writing */
+    int buf_size; /* 0 when non-buffered writing */
     uint8_t *buf;
     unsigned long *may_free;
     struct iovec *iov;
     unsigned int iovcnt;
+    QLIST_ENTRY(QEMUFileBuffer) link;
 };
 
 struct QEMUFile {
@@ -60,6 +66,22 @@ struct QEMUFile {
     bool shutdown;
     /* currently used buffer */
     QEMUFileBuffer *current_buf;
+    /*
+     * with buffered_mode enabled all the data copied to 512 byte
+     * aligned buffer, including iov data. Then the buffer is passed
+     * to writev_buffer callback.
+     */
+    bool buffered_mode;
+    /* for async buffer writing */
+    AioTaskPool *pool;
+    /* the list of free buffers, currently used on is NOT there */
+    QLIST_HEAD(, QEMUFileBuffer) free_buffers;
+};
+
+struct QEMUFileAioTask {
+    AioTask task;
+    QEMUFile *f;
+    QEMUFileBuffer *fb;
 };
 
 /*
@@ -115,10 +137,42 @@ QEMUFile *qemu_fopen_ops(void *opaque, const QEMUFileOps *ops)
     f->opaque = opaque;
     f->ops = ops;
 
-    f->current_buf = g_new0(QEMUFileBuffer, 1);
-    f->current_buf->buf = g_malloc(IO_BUF_SIZE);
-    f->current_buf->iov = g_new0(struct iovec, MAX_IOV_SIZE);
-    f->current_buf->may_free = bitmap_new(MAX_IOV_SIZE);
+    if (f->ops->enable_buffered) {
+        f->buffered_mode = f->ops->enable_buffered(f->opaque);
+    }
+
+    if (f->buffered_mode && qemu_file_is_writable(f)) {
+        int i;
+        /*
+         * in buffered_mode we don't use internal io vectors
+         * and may_free bitmap, because we copy the data to be
+         * written right away to the buffer
+         */
+        f->pool = aio_task_pool_new(IO_BUF_NUM);
+
+        /* allocate io buffers */
+        for (i = 0; i < IO_BUF_NUM; i++) {
+            QEMUFileBuffer *fb = g_new0(QEMUFileBuffer, 1);
+
+            fb->buf = qemu_memalign(IO_BUF_ALIGNMENT, IO_BUF_SIZE);
+            fb->buf_size = IO_BUF_SIZE;
+
+            /*
+             * put the first buffer to the current buf and the rest
+             * to the list of free buffers
+             */
+            if (i == 0) {
+                f->current_buf = fb;
+            } else {
+                QLIST_INSERT_HEAD(&f->free_buffers, fb, link);
+            }
+        }
+    } else {
+        f->current_buf = g_new0(QEMUFileBuffer, 1);
+        f->current_buf->buf = g_malloc(IO_BUF_SIZE);
+        f->current_buf->iov = g_new0(struct iovec, MAX_IOV_SIZE);
+        f->current_buf->may_free = bitmap_new(MAX_IOV_SIZE);
+    }
 
     return f;
 }
@@ -190,6 +244,8 @@ static void qemu_iovec_release_ram(QEMUFile *f)
     unsigned long idx;
     QEMUFileBuffer *fb = f->current_buf;
 
+    assert(!f->buffered_mode);
+
     /* Find and release all the contiguous memory ranges marked as may_free. */
     idx = find_next_bit(fb->may_free, fb->iovcnt, 0);
     if (idx >= fb->iovcnt) {
@@ -221,6 +277,147 @@ static void qemu_iovec_release_ram(QEMUFile *f)
     bitmap_zero(fb->may_free, MAX_IOV_SIZE);
 }
 
+static void advance_buf_ptr(QEMUFile *f, size_t size)
+{
+    QEMUFileBuffer *fb = f->current_buf;
+    /* must not advance to 0 */
+    assert(size);
+    /* must not overflow buf_index (int) */
+    assert(fb->buf_index + size <= INT_MAX);
+    /* must not exceed buf_size */
+    assert(fb->buf_index + size <= fb->buf_size);
+
+    fb->buf_index += size;
+}
+
+static size_t get_buf_free_size(QEMUFile *f)
+{
+    QEMUFileBuffer *fb = f->current_buf;
+    /* buf_index can't be greated than buf_size */
+    assert(fb->buf_size >= fb->buf_index);
+    return fb->buf_size - fb->buf_index;
+}
+
+static size_t get_buf_used_size(QEMUFile *f)
+{
+    QEMUFileBuffer *fb = f->current_buf;
+    return fb->buf_index;
+}
+
+static uint8_t *get_buf_ptr(QEMUFile *f)
+{
+    QEMUFileBuffer *fb = f->current_buf;
+    /* protects from out of bound reading */
+    assert(fb->buf_index <= IO_BUF_SIZE);
+    return fb->buf + fb->buf_index;
+}
+
+static bool buf_is_full(QEMUFile *f)
+{
+    return get_buf_free_size(f) == 0;
+}
+
+static void reset_buf(QEMUFile *f)
+{
+    QEMUFileBuffer *fb = f->current_buf;
+    fb->buf_index = 0;
+}
+
+static int write_task_fn(AioTask *task)
+{
+    int ret;
+    Error *local_error = NULL;
+    QEMUFileAioTask *t = (QEMUFileAioTask *) task;
+    QEMUFile *f = t->f;
+    QEMUFileBuffer *fb = t->fb;
+    uint64_t pos = f->pos;
+    struct iovec v = (struct iovec) {
+        .iov_base = fb->buf,
+        .iov_len = fb->buf_index,
+    };
+
+    assert(f->buffered_mode);
+
+    /*
+     * Increment file position.
+     * This needs to be here before calling writev_buffer, because
+     * writev_buffer is asynchronous and there could be more than one
+     * writev_buffer started simultaniously. Each writev_buffer should
+     * use its own file pos to write to. writev_buffer may write less
+     * than buf_index bytes but we treat this situation as an error.
+     * If error appeared, further file using is meaningless.
+     * We expect that, the most of the time the full buffer is written,
+     * (when buf_size == buf_index). The only case when the non-full
+     * buffer is written (buf_size != buf_index) is file close,
+     * when we need to flush the rest of the buffer content.
+     */
+    f->pos += fb->buf_index;
+
+    ret = f->ops->writev_buffer(f->opaque, &v, 1, pos, &local_error);
+
+    /* return the just written buffer to the free list */
+    QLIST_INSERT_HEAD(&f->free_buffers, fb, link);
+
+    /* check that we have written everything */
+    if (ret != fb->buf_index) {
+        qemu_file_set_error_obj(f, ret < 0 ? ret : -EIO, local_error);
+    }
+
+    /*
+     * always return 0 - don't use task error handling, relay on
+     * qemu file error handling
+     */
+    return 0;
+}
+
+static void qemu_file_switch_current_buf(QEMUFile *f)
+{
+    /*
+     * if the list is empty, wait until some task returns a buffer
+     * to the list of free buffers.
+     */
+    if (QLIST_EMPTY(&f->free_buffers)) {
+        aio_task_pool_wait_slot(f->pool);
+    }
+
+    /*
+     * sanity check that the list isn't empty
+     * if the free list was empty, we waited for a task complition,
+     * and the pompleted task must return a buffer to a list of free buffers
+     */
+    assert(!QLIST_EMPTY(&f->free_buffers));
+
+    /* set the current buffer for using from the free list */
+    f->current_buf = QLIST_FIRST(&f->free_buffers);
+    reset_buf(f);
+
+    QLIST_REMOVE(f->current_buf, link);
+}
+
+/**
+ *  Asynchronously flushes QEMUFile buffer
+ *
+ * This will flush all pending data. If data was only partially flushed, it
+ * will set an error state. The function may return before the data actually
+ * written.
+ */
+static void flush_buffer(QEMUFile *f)
+{
+    QEMUFileAioTask *t = g_new(QEMUFileAioTask, 1);
+
+    *t = (QEMUFileAioTask) {
+        .task.func = &write_task_fn,
+        .f = f,
+        .fb = f->current_buf,
+    };
+
+    /* aio_task_pool should free t for us */
+    aio_task_pool_start_task(f->pool, (AioTask *) t);
+
+    /* if no errors this will switch the buffer */
+    qemu_file_switch_current_buf(f);
+}
+
 /**
  * Flushes QEMUFile buffer
  *
@@ -241,7 +438,13 @@ void qemu_fflush(QEMUFile *f)
     if (f->shutdown) {
         return;
     }
+
+    if (f->buffered_mode) {
+        return;
+    }
+
     if (fb->iovcnt > 0) {
+        /* this is non-buffered mode */
         expect = iov_size(fb->iov, fb->iovcnt);
         ret = f->ops->writev_buffer(f->opaque, fb->iov, fb->iovcnt, f->pos,
                                     &local_error);
@@ -378,6 +581,7 @@ static ssize_t qemu_fill_buffer(QEMUFile *f)
 
 void qemu_update_position(QEMUFile *f, size_t size)
 {
+    assert(!f->buffered_mode);
     f->pos += size;
 }
 
@@ -392,7 +596,18 @@ void qemu_update_position(QEMUFile *f, size_t size)
 int qemu_fclose(QEMUFile *f)
 {
     int ret;
-    qemu_fflush(f);
+
+    if (qemu_file_is_writable(f) && f->buffered_mode) {
+        ret = qemu_file_get_error(f);
+        if (!ret) {
+            flush_buffer(f);
+        }
+        /* wait until all tasks are done */
+        aio_task_pool_wait_all(f->pool);
+    } else {
+        qemu_fflush(f);
+    }
+
     ret = qemu_file_get_error(f);
 
     if (f->ops->close) {
@@ -408,16 +623,77 @@ int qemu_fclose(QEMUFile *f)
         ret = f->last_error;
     }
     error_free(f->last_error_obj);
-    g_free(f->current_buf->buf);
-    g_free(f->current_buf->iov);
-    g_free(f->current_buf->may_free);
-    g_free(f->current_buf);
+
+    if (f->buffered_mode) {
+        QEMUFileBuffer *fb, *next;
+        /*
+         * put the current back to the free buffers list
+         * to destroy all the buffers in one loop
+         */
+        QLIST_INSERT_HEAD(&f->free_buffers, f->current_buf, link);
+
+        /* destroy all the buffers */
+        QLIST_FOREACH_SAFE(fb, &f->free_buffers, link, next) {
+            QLIST_REMOVE(fb, link);
+            /* looks like qemu_vfree pairs with qemu_memalign */
+            qemu_vfree(fb->buf);
+            g_free(fb);
+        }
+        g_free(f->pool);
+    } else {
+        g_free(f->current_buf->buf);
+        g_free(f->current_buf->iov);
+        g_free(f->current_buf->may_free);
+        g_free(f->current_buf);
+    }
+
     g_free(f);
     trace_qemu_file_fclose();
     return ret;
 }
 
 /*
+ * Copy an external buffer to the intenal current buffer.
+ */
+static void copy_buf(QEMUFile *f, const uint8_t *buf, size_t size,
+                     bool may_free)
+{
+    size_t data_size = size;
+    const uint8_t *src_ptr = buf;
+
+    assert(f->buffered_mode);
+    assert(size <= INT_MAX);
+
+    while (data_size > 0) {
+        size_t chunk_size;
+
+        if (buf_is_full(f)) {
+            flush_buffer(f);
+            if (qemu_file_get_error(f)) {
+                return;
+            }
+        }
+
+        chunk_size = MIN(get_buf_free_size(f), data_size);
+
+        memcpy(get_buf_ptr(f), src_ptr, chunk_size);
+
+        advance_buf_ptr(f, chunk_size);
+
+        src_ptr += chunk_size;
+        data_size -= chunk_size;
+        f->bytes_xfer += chunk_size;
+    }
+
+    if (may_free) {
+        if (qemu_madvise((void *) buf, size, QEMU_MADV_DONTNEED) < 0) {
+            error_report("migrate: madvise DONTNEED failed %p %zd: %s",
+                         buf, size, strerror(errno));
+        }
+    }
+}
+
+/*
  * Add buf to iovec. Do flush if iovec is full.
  *
  * Return values:
@@ -454,6 +730,9 @@ static int add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size,
 static void add_buf_to_iovec(QEMUFile *f, size_t len)
 {
     QEMUFileBuffer *fb = f->current_buf;
+
+    assert(!f->buffered_mode);
+
     if (!add_to_iovec(f, fb->buf + fb->buf_index, len, false)) {
         fb->buf_index += len;
         if (fb->buf_index == IO_BUF_SIZE) {
@@ -469,8 +748,12 @@ void qemu_put_buffer_async(QEMUFile *f, const uint8_t *buf, size_t size,
         return;
     }
 
-    f->bytes_xfer += size;
-    add_to_iovec(f, buf, size, may_free);
+    if (f->buffered_mode) {
+        copy_buf(f, buf, size, may_free);
+    } else {
+        f->bytes_xfer += size;
+        add_to_iovec(f, buf, size, may_free);
+    }
 }
 
 void qemu_put_buffer(QEMUFile *f, const uint8_t *buf, size_t size)
@@ -482,6 +765,11 @@ void qemu_put_buffer(QEMUFile *f, const uint8_t *buf, size_t size)
         return;
     }
 
+    if (f->buffered_mode) {
+        copy_buf(f, buf, size, false);
+        return;
+    }
+
     while (size > 0) {
         l = IO_BUF_SIZE - fb->buf_index;
         if (l > size) {
@@ -506,15 +794,21 @@ void qemu_put_byte(QEMUFile *f, int v)
         return;
     }
 
-    fb->buf[fb->buf_index] = v;
-    f->bytes_xfer++;
-    add_buf_to_iovec(f, 1);
+    if (f->buffered_mode) {
+        copy_buf(f, (const uint8_t *) &v, 1, false);
+    } else {
+        fb->buf[fb->buf_index] = v;
+        add_buf_to_iovec(f, 1);
+        f->bytes_xfer++;
+    }
 }
 
 void qemu_file_skip(QEMUFile *f, int size)
 {
     QEMUFileBuffer *fb = f->current_buf;
 
+    assert(!f->buffered_mode);
+
     if (fb->buf_index + size <= fb->buf_size) {
         fb->buf_index += size;
     }
@@ -672,10 +966,14 @@ int64_t qemu_ftell_fast(QEMUFile *f)
 {
     int64_t ret = f->pos;
     int i;
-    QEMUFileBuffer *fb = f->current_buf;
 
-    for (i = 0; i < fb->iovcnt; i++) {
-        ret += fb->iov[i].iov_len;
+    if (f->buffered_mode) {
+        ret += get_buf_used_size(f);
+    } else {
+        QEMUFileBuffer *fb = f->current_buf;
+        for (i = 0; i < fb->iovcnt; i++) {
+            ret += fb->iov[i].iov_len;
+        }
     }
 
     return ret;
@@ -683,8 +981,12 @@ int64_t qemu_ftell_fast(QEMUFile *f)
 
 int64_t qemu_ftell(QEMUFile *f)
 {
-    qemu_fflush(f);
-    return f->pos;
+    if (f->buffered_mode) {
+        return qemu_ftell_fast(f);
+    } else {
+        qemu_fflush(f);
+        return f->pos;
+    }
 }
 
 int qemu_file_rate_limit(QEMUFile *f)
@@ -803,6 +1105,8 @@ ssize_t qemu_put_compression_data(QEMUFile *f, z_stream *stream,
     QEMUFileBuffer *fb = f->current_buf;
     ssize_t blen = IO_BUF_SIZE - fb->buf_index - sizeof(int32_t);
 
+    assert(!f->buffered_mode);
+
     if (blen < compressBound(size)) {
         return -1;
     }
@@ -827,6 +1131,9 @@ int qemu_put_qemu_file(QEMUFile *f_des, QEMUFile *f_src)
     int len = 0;
     QEMUFileBuffer *fb_src = f_src->current_buf;
 
+    assert(!f_des->buffered_mode);
+    assert(!f_src->buffered_mode);
+
     if (fb_src->buf_index > 0) {
         len = fb_src->buf_index;
         qemu_put_buffer(f_des, fb_src->buf, fb_src->buf_index);
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index a9b6d6c..08655d2 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -103,6 +103,14 @@ typedef QEMUFile *(QEMURetPathFunc)(void *opaque);
 typedef int (QEMUFileShutdownFunc)(void *opaque, bool rd, bool wr,
                                    Error **errp);
 
+/*
+ * Enables or disables the buffered mode
+ * Existing blocking reads/writes must be woken
+ * Returns true if the buffered mode has to be enabled,
+ * false if it has to be disabled.
+ */
+typedef bool (QEMUFileEnableBufferedFunc)(void *opaque);
+
 typedef struct QEMUFileOps {
     QEMUFileGetBufferFunc *get_buffer;
     QEMUFileCloseFunc *close;
@@ -110,6 +118,7 @@ typedef struct QEMUFileOps {
     QEMUFileWritevBufferFunc *writev_buffer;
     QEMURetPathFunc *get_return_path;
     QEMUFileShutdownFunc *shut_down;
+    QEMUFileEnableBufferedFunc *enable_buffered;
 } QEMUFileOps;
 
 typedef struct QEMUFileHooks {
-- 
1.8.3.1


