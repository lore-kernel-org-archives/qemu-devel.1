Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F52FC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 11:15:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28D3720732
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 11:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D3720732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNx3L-0006fn-AZ
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 07:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jNx0u-0002jw-RY
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 07:12:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jNx0s-0000if-Q4
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 07:12:28 -0400
Received: from relay.sw.ru ([185.231.240.75]:40326)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jNx0s-0000fy-EE
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 07:12:26 -0400
Received: from vgpu0.qa.sw.ru ([10.94.1.107])
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jNx0h-0002VQ-IR; Mon, 13 Apr 2020 14:12:15 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [RFC patch v1 1/3] qemu-file: introduce current buffer
Date: Mon, 13 Apr 2020 14:12:12 +0300
Message-Id: <1586776334-641239-2-git-send-email-dplotnikov@virtuozzo.com>
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

To approach async wrtiting in the further commits, the buffer
allocated in QEMUFile struct is replaced with the link to the
current buffer. We're going to use many buffers to write the
qemu file stream to the unerlying storage asynchronously. The
current buffer points out to the buffer is currently filled
with data.

This patch doesn't add any features to qemu-file and doesn't
change any qemu-file behavior.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 include/qemu/typedefs.h |   1 +
 migration/qemu-file.c   | 156 +++++++++++++++++++++++++++++-------------------
 2 files changed, 95 insertions(+), 62 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 375770a..88dce54 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -97,6 +97,7 @@ typedef struct QDict QDict;
 typedef struct QEMUBH QEMUBH;
 typedef struct QemuConsole QemuConsole;
 typedef struct QEMUFile QEMUFile;
+typedef struct QEMUFileBuffer QEMUFileBuffer;
 typedef struct QemuLockable QemuLockable;
 typedef struct QemuMutex QemuMutex;
 typedef struct QemuOpt QemuOpt;
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 1c3a358..285c6ef 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -33,6 +33,17 @@
 #define IO_BUF_SIZE 32768
 #define MAX_IOV_SIZE MIN(IOV_MAX, 64)
 
+QEMU_BUILD_BUG_ON(!QEMU_IS_ALIGNED(IO_BUF_SIZE, 512));
+
+struct QEMUFileBuffer {
+    int buf_index;
+    int buf_size; /* 0 when writing */
+    uint8_t *buf;
+    unsigned long *may_free;
+    struct iovec *iov;
+    unsigned int iovcnt;
+};
+
 struct QEMUFile {
     const QEMUFileOps *ops;
     const QEMUFileHooks *hooks;
@@ -43,18 +54,12 @@ struct QEMUFile {
 
     int64_t pos; /* start of buffer when writing, end of buffer
                     when reading */
-    int buf_index;
-    int buf_size; /* 0 when writing */
-    uint8_t buf[IO_BUF_SIZE];
-
-    DECLARE_BITMAP(may_free, MAX_IOV_SIZE);
-    struct iovec iov[MAX_IOV_SIZE];
-    unsigned int iovcnt;
-
     int last_error;
     Error *last_error_obj;
     /* has the file has been shutdown */
     bool shutdown;
+    /* currently used buffer */
+    QEMUFileBuffer *current_buf;
 };
 
 /*
@@ -109,6 +114,12 @@ QEMUFile *qemu_fopen_ops(void *opaque, const QEMUFileOps *ops)
 
     f->opaque = opaque;
     f->ops = ops;
+
+    f->current_buf = g_new0(QEMUFileBuffer, 1);
+    f->current_buf->buf = g_malloc(IO_BUF_SIZE);
+    f->current_buf->iov = g_new0(struct iovec, MAX_IOV_SIZE);
+    f->current_buf->may_free = bitmap_new(MAX_IOV_SIZE);
+
     return f;
 }
 
@@ -177,35 +188,37 @@ static void qemu_iovec_release_ram(QEMUFile *f)
 {
     struct iovec iov;
     unsigned long idx;
+    QEMUFileBuffer *fb = f->current_buf;
 
     /* Find and release all the contiguous memory ranges marked as may_free. */
-    idx = find_next_bit(f->may_free, f->iovcnt, 0);
-    if (idx >= f->iovcnt) {
+    idx = find_next_bit(fb->may_free, fb->iovcnt, 0);
+    if (idx >= fb->iovcnt) {
         return;
     }
-    iov = f->iov[idx];
+    iov = fb->iov[idx];
 
     /* The madvise() in the loop is called for iov within a continuous range and
      * then reinitialize the iov. And in the end, madvise() is called for the
      * last iov.
      */
-    while ((idx = find_next_bit(f->may_free, f->iovcnt, idx + 1)) < f->iovcnt) {
+    while ((idx = find_next_bit(fb->may_free,
+                                fb->iovcnt, idx + 1)) < fb->iovcnt) {
         /* check for adjacent buffer and coalesce them */
-        if (iov.iov_base + iov.iov_len == f->iov[idx].iov_base) {
-            iov.iov_len += f->iov[idx].iov_len;
+        if (iov.iov_base + iov.iov_len == fb->iov[idx].iov_base) {
+            iov.iov_len += fb->iov[idx].iov_len;
             continue;
         }
         if (qemu_madvise(iov.iov_base, iov.iov_len, QEMU_MADV_DONTNEED) < 0) {
             error_report("migrate: madvise DONTNEED failed %p %zd: %s",
                          iov.iov_base, iov.iov_len, strerror(errno));
         }
-        iov = f->iov[idx];
+        iov = fb->iov[idx];
     }
     if (qemu_madvise(iov.iov_base, iov.iov_len, QEMU_MADV_DONTNEED) < 0) {
             error_report("migrate: madvise DONTNEED failed %p %zd: %s",
                          iov.iov_base, iov.iov_len, strerror(errno));
     }
-    memset(f->may_free, 0, sizeof(f->may_free));
+    bitmap_zero(fb->may_free, MAX_IOV_SIZE);
 }
 
 /**
@@ -219,6 +232,7 @@ void qemu_fflush(QEMUFile *f)
     ssize_t ret = 0;
     ssize_t expect = 0;
     Error *local_error = NULL;
+    QEMUFileBuffer *fb = f->current_buf;
 
     if (!qemu_file_is_writable(f)) {
         return;
@@ -227,9 +241,9 @@ void qemu_fflush(QEMUFile *f)
     if (f->shutdown) {
         return;
     }
-    if (f->iovcnt > 0) {
-        expect = iov_size(f->iov, f->iovcnt);
-        ret = f->ops->writev_buffer(f->opaque, f->iov, f->iovcnt, f->pos,
+    if (fb->iovcnt > 0) {
+        expect = iov_size(fb->iov, fb->iovcnt);
+        ret = f->ops->writev_buffer(f->opaque, fb->iov, fb->iovcnt, f->pos,
                                     &local_error);
 
         qemu_iovec_release_ram(f);
@@ -244,8 +258,8 @@ void qemu_fflush(QEMUFile *f)
     if (ret != expect) {
         qemu_file_set_error_obj(f, ret < 0 ? ret : -EIO, local_error);
     }
-    f->buf_index = 0;
-    f->iovcnt = 0;
+    fb->buf_index = 0;
+    fb->iovcnt = 0;
 }
 
 void ram_control_before_iterate(QEMUFile *f, uint64_t flags)
@@ -331,24 +345,25 @@ static ssize_t qemu_fill_buffer(QEMUFile *f)
     int len;
     int pending;
     Error *local_error = NULL;
+    QEMUFileBuffer *fb = f->current_buf;
 
     assert(!qemu_file_is_writable(f));
 
-    pending = f->buf_size - f->buf_index;
+    pending = fb->buf_size - fb->buf_index;
     if (pending > 0) {
-        memmove(f->buf, f->buf + f->buf_index, pending);
+        memmove(fb->buf, fb->buf + fb->buf_index, pending);
     }
-    f->buf_index = 0;
-    f->buf_size = pending;
+    fb->buf_index = 0;
+    fb->buf_size = pending;
 
     if (f->shutdown) {
         return 0;
     }
 
-    len = f->ops->get_buffer(f->opaque, f->buf + pending, f->pos,
+    len = f->ops->get_buffer(f->opaque, fb->buf + pending, f->pos,
                              IO_BUF_SIZE - pending, &local_error);
     if (len > 0) {
-        f->buf_size += len;
+        fb->buf_size += len;
         f->pos += len;
     } else if (len == 0) {
         qemu_file_set_error_obj(f, -EIO, local_error);
@@ -393,6 +408,10 @@ int qemu_fclose(QEMUFile *f)
         ret = f->last_error;
     }
     error_free(f->last_error_obj);
+    g_free(f->current_buf->buf);
+    g_free(f->current_buf->iov);
+    g_free(f->current_buf->may_free);
+    g_free(f->current_buf);
     g_free(f);
     trace_qemu_file_fclose();
     return ret;
@@ -409,21 +428,22 @@ int qemu_fclose(QEMUFile *f)
 static int add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size,
                         bool may_free)
 {
+    QEMUFileBuffer *fb = f->current_buf;
     /* check for adjacent buffer and coalesce them */
-    if (f->iovcnt > 0 && buf == f->iov[f->iovcnt - 1].iov_base +
-        f->iov[f->iovcnt - 1].iov_len &&
-        may_free == test_bit(f->iovcnt - 1, f->may_free))
+    if (fb->iovcnt > 0 && buf == fb->iov[fb->iovcnt - 1].iov_base +
+        fb->iov[fb->iovcnt - 1].iov_len &&
+        may_free == test_bit(fb->iovcnt - 1, fb->may_free))
     {
-        f->iov[f->iovcnt - 1].iov_len += size;
+        fb->iov[fb->iovcnt - 1].iov_len += size;
     } else {
         if (may_free) {
-            set_bit(f->iovcnt, f->may_free);
+            set_bit(fb->iovcnt, fb->may_free);
         }
-        f->iov[f->iovcnt].iov_base = (uint8_t *)buf;
-        f->iov[f->iovcnt++].iov_len = size;
+        fb->iov[fb->iovcnt].iov_base = (uint8_t *)buf;
+        fb->iov[fb->iovcnt++].iov_len = size;
     }
 
-    if (f->iovcnt >= MAX_IOV_SIZE) {
+    if (fb->iovcnt >= MAX_IOV_SIZE) {
         qemu_fflush(f);
         return 1;
     }
@@ -433,9 +453,10 @@ static int add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size,
 
 static void add_buf_to_iovec(QEMUFile *f, size_t len)
 {
-    if (!add_to_iovec(f, f->buf + f->buf_index, len, false)) {
-        f->buf_index += len;
-        if (f->buf_index == IO_BUF_SIZE) {
+    QEMUFileBuffer *fb = f->current_buf;
+    if (!add_to_iovec(f, fb->buf + fb->buf_index, len, false)) {
+        fb->buf_index += len;
+        if (fb->buf_index == IO_BUF_SIZE) {
             qemu_fflush(f);
         }
     }
@@ -455,17 +476,18 @@ void qemu_put_buffer_async(QEMUFile *f, const uint8_t *buf, size_t size,
 void qemu_put_buffer(QEMUFile *f, const uint8_t *buf, size_t size)
 {
     size_t l;
+    QEMUFileBuffer *fb = f->current_buf;
 
     if (f->last_error) {
         return;
     }
 
     while (size > 0) {
-        l = IO_BUF_SIZE - f->buf_index;
+        l = IO_BUF_SIZE - fb->buf_index;
         if (l > size) {
             l = size;
         }
-        memcpy(f->buf + f->buf_index, buf, l);
+        memcpy(fb->buf + fb->buf_index, buf, l);
         f->bytes_xfer += l;
         add_buf_to_iovec(f, l);
         if (qemu_file_get_error(f)) {
@@ -478,19 +500,23 @@ void qemu_put_buffer(QEMUFile *f, const uint8_t *buf, size_t size)
 
 void qemu_put_byte(QEMUFile *f, int v)
 {
+    QEMUFileBuffer *fb = f->current_buf;
+
     if (f->last_error) {
         return;
     }
 
-    f->buf[f->buf_index] = v;
+    fb->buf[fb->buf_index] = v;
     f->bytes_xfer++;
     add_buf_to_iovec(f, 1);
 }
 
 void qemu_file_skip(QEMUFile *f, int size)
 {
-    if (f->buf_index + size <= f->buf_size) {
-        f->buf_index += size;
+    QEMUFileBuffer *fb = f->current_buf;
+
+    if (fb->buf_index + size <= fb->buf_size) {
+        fb->buf_index += size;
     }
 }
 
@@ -506,15 +532,16 @@ size_t qemu_peek_buffer(QEMUFile *f, uint8_t **buf, size_t size, size_t offset)
 {
     ssize_t pending;
     size_t index;
+    QEMUFileBuffer *fb = f->current_buf;
 
     assert(!qemu_file_is_writable(f));
     assert(offset < IO_BUF_SIZE);
     assert(size <= IO_BUF_SIZE - offset);
 
     /* The 1st byte to read from */
-    index = f->buf_index + offset;
+    index = fb->buf_index + offset;
     /* The number of available bytes starting at index */
-    pending = f->buf_size - index;
+    pending = fb->buf_size - index;
 
     /*
      * qemu_fill_buffer might return just a few bytes, even when there isn't
@@ -527,8 +554,8 @@ size_t qemu_peek_buffer(QEMUFile *f, uint8_t **buf, size_t size, size_t offset)
             break;
         }
 
-        index = f->buf_index + offset;
-        pending = f->buf_size - index;
+        index = fb->buf_index + offset;
+        pending = fb->buf_size - index;
     }
 
     if (pending <= 0) {
@@ -538,7 +565,7 @@ size_t qemu_peek_buffer(QEMUFile *f, uint8_t **buf, size_t size, size_t offset)
         size = pending;
     }
 
-    *buf = f->buf + index;
+    *buf = fb->buf + index;
     return size;
 }
 
@@ -615,19 +642,21 @@ size_t qemu_get_buffer_in_place(QEMUFile *f, uint8_t **buf, size_t size)
  */
 int qemu_peek_byte(QEMUFile *f, int offset)
 {
-    int index = f->buf_index + offset;
+    QEMUFileBuffer *fb = f->current_buf;
+
+    int index = fb->buf_index + offset;
 
     assert(!qemu_file_is_writable(f));
     assert(offset < IO_BUF_SIZE);
 
-    if (index >= f->buf_size) {
+    if (index >= fb->buf_size) {
         qemu_fill_buffer(f);
-        index = f->buf_index + offset;
-        if (index >= f->buf_size) {
+        index = fb->buf_index + offset;
+        if (index >= fb->buf_size) {
             return 0;
         }
     }
-    return f->buf[index];
+    return fb->buf[index];
 }
 
 int qemu_get_byte(QEMUFile *f)
@@ -643,9 +672,10 @@ int64_t qemu_ftell_fast(QEMUFile *f)
 {
     int64_t ret = f->pos;
     int i;
+    QEMUFileBuffer *fb = f->current_buf;
 
-    for (i = 0; i < f->iovcnt; i++) {
-        ret += f->iov[i].iov_len;
+    for (i = 0; i < fb->iovcnt; i++) {
+        ret += fb->iov[i].iov_len;
     }
 
     return ret;
@@ -770,13 +800,14 @@ static int qemu_compress_data(z_stream *stream, uint8_t *dest, size_t dest_len,
 ssize_t qemu_put_compression_data(QEMUFile *f, z_stream *stream,
                                   const uint8_t *p, size_t size)
 {
-    ssize_t blen = IO_BUF_SIZE - f->buf_index - sizeof(int32_t);
+    QEMUFileBuffer *fb = f->current_buf;
+    ssize_t blen = IO_BUF_SIZE - fb->buf_index - sizeof(int32_t);
 
     if (blen < compressBound(size)) {
         return -1;
     }
 
-    blen = qemu_compress_data(stream, f->buf + f->buf_index + sizeof(int32_t),
+    blen = qemu_compress_data(stream, fb->buf + fb->buf_index + sizeof(int32_t),
                               blen, p, size);
     if (blen < 0) {
         return -1;
@@ -794,12 +825,13 @@ ssize_t qemu_put_compression_data(QEMUFile *f, z_stream *stream,
 int qemu_put_qemu_file(QEMUFile *f_des, QEMUFile *f_src)
 {
     int len = 0;
+    QEMUFileBuffer *fb_src = f_src->current_buf;
 
-    if (f_src->buf_index > 0) {
-        len = f_src->buf_index;
-        qemu_put_buffer(f_des, f_src->buf, f_src->buf_index);
-        f_src->buf_index = 0;
-        f_src->iovcnt = 0;
+    if (fb_src->buf_index > 0) {
+        len = fb_src->buf_index;
+        qemu_put_buffer(f_des, fb_src->buf, fb_src->buf_index);
+        fb_src->buf_index = 0;
+        fb_src->iovcnt = 0;
     }
     return len;
 }
-- 
1.8.3.1


