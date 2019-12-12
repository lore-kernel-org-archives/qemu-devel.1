Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1416BC2D0C9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD246214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3Z2GqsX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD246214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSzF-0007ge-EC
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:14:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRXB-00080Z-1U
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRX8-00054o-L1
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:48 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36222
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRX8-000549-En
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e4wmgWEMPfBkBatn/VTO8vmYPrk94slO6WxsYDTPWFI=;
 b=Q3Z2GqsXwZxIDqcAkSma+OkkUHdwhDIBtS6nvaCzUtv4pxONQfhFwnBbF2AuBITAXJNz/X
 4+YUD4OOi4XQG+T+Bwxl0LKMpXnUdc8bi67oHyijzYKDdwuHvfgulirw+qzztq+TDTlHm0
 vLQwZONr9e4pj7Q+x3GOW3I41OxN+4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-caWQ2tA0N_SRcwUhDfQjUg-1; Thu, 12 Dec 2019 11:41:45 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C8C0800C78
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:41:44 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C21960BE1;
 Thu, 12 Dec 2019 16:41:43 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 100/104] virtiofsd: process requests in a thread pool
Date: Thu, 12 Dec 2019 16:39:00 +0000
Message-Id: <20191212163904.159893-101-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: caWQ2tA0N_SRcwUhDfQjUg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Introduce a thread pool so that fv_queue_thread() just pops
VuVirtqElements and hands them to the thread pool.  For the time being
only one worker thread is allowed since passthrough_ll.c is not
thread-safe yet.  Future patches will lift this restriction so that
multiple FUSE requests can be processed in parallel.

The main new concept is struct FVRequest, which contains both
VuVirtqElement and struct fuse_chan.  We now have fv_VuDev for a device,
fv_QueueInfo for a virtqueue, and FVRequest for a request.  Some of
fv_QueueInfo's fields are moved into FVRequest because they are
per-request.  The name FVRequest conforms to QEMU coding style and I
expect the struct fv_* types will be renamed in a future refactoring.

This patch series is not optimal.  fbuf reuse is dropped so each request
does malloc(se->bufsize), but there is no clean and cheap way to keep
this with a thread pool.  The vq_lock mutex is held for longer than
necessary, especially during the eventfd_write() syscall.  Performance
can be improved in the future.

prctl(2) had to be added to the seccomp whitelist because glib invokes
it.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tools/virtiofsd/fuse_virtio.c | 361 +++++++++++++++++++---------------
 1 file changed, 202 insertions(+), 159 deletions(-)

diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index 2c1e524852..b696ac3135 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -22,6 +22,7 @@
=20
 #include <assert.h>
 #include <errno.h>
+#include <glib.h>
 #include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -37,17 +38,28 @@
 struct fv_VuDev;
 struct fv_QueueInfo {
     pthread_t thread;
+    /*
+     * This lock protects the VuVirtq preventing races between
+     * fv_queue_thread() and fv_queue_worker().
+     */
+    pthread_mutex_t vq_lock;
+
     struct fv_VuDev *virtio_dev;
=20
     /* Our queue index, corresponds to array position */
     int qidx;
     int kick_fd;
     int kill_fd; /* For killing the thread */
+};
=20
-    /* The element for the command currently being processed */
-    VuVirtqElement *qe;
+/* A FUSE request */
+typedef struct {
+    VuVirtqElement elem;
+    struct fuse_chan ch;
+
+    /* Used to complete requests that involve no reply */
     bool reply_sent;
-};
+} FVRequest;
=20
 /*
  * We pass the dev element into libvhost-user
@@ -191,8 +203,11 @@ static void copy_iov(struct iovec *src_iov, int src_co=
unt,
 int virtio_send_msg(struct fuse_session *se, struct fuse_chan *ch,
                     struct iovec *iov, int count)
 {
-    VuVirtqElement *elem;
-    VuVirtq *q;
+    FVRequest *req =3D container_of(ch, FVRequest, ch);
+    struct fv_QueueInfo *qi =3D ch->qi;
+    VuDev *dev =3D &se->virtio_dev->dev;
+    VuVirtq *q =3D vu_get_queue(dev, qi->qidx);
+    VuVirtqElement *elem =3D &req->elem;
     int ret =3D 0;
=20
     assert(count >=3D 1);
@@ -205,11 +220,7 @@ int virtio_send_msg(struct fuse_session *se, struct fu=
se_chan *ch,
=20
     /* unique =3D=3D 0 is notification, which we don't support */
     assert(out->unique);
-    /* For virtio we always have ch */
-    assert(ch);
-    assert(!ch->qi->reply_sent);
-    elem =3D ch->qi->qe;
-    q =3D &ch->qi->virtio_dev->dev.vq[ch->qi->qidx];
+    assert(!req->reply_sent);
=20
     /* The 'in' part of the elem is to qemu */
     unsigned int in_num =3D elem->in_num;
@@ -236,9 +247,15 @@ int virtio_send_msg(struct fuse_session *se, struct fu=
se_chan *ch,
     }
=20
     copy_iov(iov, count, in_sg, in_num, tosend_len);
-    vu_queue_push(&se->virtio_dev->dev, q, elem, tosend_len);
-    vu_queue_notify(&se->virtio_dev->dev, q);
-    ch->qi->reply_sent =3D true;
+
+    pthread_rwlock_rdlock(&qi->virtio_dev->vu_dispatch_rwlock);
+    pthread_mutex_lock(&qi->vq_lock);
+    vu_queue_push(dev, q, elem, tosend_len);
+    vu_queue_notify(dev, q);
+    pthread_mutex_unlock(&qi->vq_lock);
+    pthread_rwlock_unlock(&qi->virtio_dev->vu_dispatch_rwlock);
+
+    req->reply_sent =3D true;
=20
 err:
     return ret;
@@ -254,9 +271,12 @@ int virtio_send_data_iov(struct fuse_session *se, stru=
ct fuse_chan *ch,
                          struct iovec *iov, int count, struct fuse_bufvec =
*buf,
                          size_t len)
 {
+    FVRequest *req =3D container_of(ch, FVRequest, ch);
+    struct fv_QueueInfo *qi =3D ch->qi;
+    VuDev *dev =3D &se->virtio_dev->dev;
+    VuVirtq *q =3D vu_get_queue(dev, qi->qidx);
+    VuVirtqElement *elem =3D &req->elem;
     int ret =3D 0;
-    VuVirtqElement *elem;
-    VuVirtq *q;
=20
     assert(count >=3D 1);
     assert(iov[0].iov_len >=3D sizeof(struct fuse_out_header));
@@ -275,11 +295,7 @@ int virtio_send_data_iov(struct fuse_session *se, stru=
ct fuse_chan *ch,
     /* unique =3D=3D 0 is notification which we don't support */
     assert(out->unique);
=20
-    /* For virtio we always have ch */
-    assert(ch);
-    assert(!ch->qi->reply_sent);
-    elem =3D ch->qi->qe;
-    q =3D &ch->qi->virtio_dev->dev.vq[ch->qi->qidx];
+    assert(!req->reply_sent);
=20
     /* The 'in' part of the elem is to qemu */
     unsigned int in_num =3D elem->in_num;
@@ -392,34 +408,176 @@ int virtio_send_data_iov(struct fuse_session *se, st=
ruct fuse_chan *ch,
=20
     ret =3D 0;
=20
-    vu_queue_push(&se->virtio_dev->dev, q, elem, tosend_len);
-    vu_queue_notify(&se->virtio_dev->dev, q);
+    pthread_rwlock_rdlock(&qi->virtio_dev->vu_dispatch_rwlock);
+    pthread_mutex_lock(&qi->vq_lock);
+    vu_queue_push(dev, q, elem, tosend_len);
+    vu_queue_notify(dev, q);
+    pthread_mutex_unlock(&qi->vq_lock);
+    pthread_rwlock_unlock(&qi->virtio_dev->vu_dispatch_rwlock);
=20
 err:
     if (ret =3D=3D 0) {
-        ch->qi->reply_sent =3D true;
+        req->reply_sent =3D true;
     }
=20
     return ret;
 }
=20
+/* Process one FVRequest in a thread pool */
+static void fv_queue_worker(gpointer data, gpointer user_data)
+{
+    struct fv_QueueInfo *qi =3D user_data;
+    struct fuse_session *se =3D qi->virtio_dev->se;
+    struct VuDev *dev =3D &qi->virtio_dev->dev;
+    FVRequest *req =3D data;
+    VuVirtqElement *elem =3D &req->elem;
+    struct fuse_buf fbuf =3D {};
+    bool allocated_bufv =3D false;
+    struct fuse_bufvec bufv;
+    struct fuse_bufvec *pbufv;
+
+    assert(se->bufsize > sizeof(struct fuse_in_header));
+
+    /*
+     * An element contains one request and the space to send our response
+     * They're spread over multiple descriptors in a scatter/gather set
+     * and we can't trust the guest to keep them still; so copy in/out.
+     */
+    fbuf.mem =3D malloc(se->bufsize);
+    assert(fbuf.mem);
+
+    fuse_mutex_init(&req->ch.lock);
+    req->ch.fd =3D (int)0xdaff0d111;
+    req->ch.ctr =3D 1;
+    req->ch.qi =3D qi;
+
+    /* The 'out' part of the elem is from qemu */
+    unsigned int out_num =3D elem->out_num;
+    struct iovec *out_sg =3D elem->out_sg;
+    size_t out_len =3D iov_size(out_sg, out_num);
+    fuse_log(FUSE_LOG_DEBUG,
+             "%s: elem %d: with %d out desc of length %zd\n",
+             __func__, elem->index, out_num, out_len);
+
+    /*
+     * The elem should contain a 'fuse_in_header' (in to fuse)
+     * plus the data based on the len in the header.
+     */
+    if (out_len < sizeof(struct fuse_in_header)) {
+        fuse_log(FUSE_LOG_ERR, "%s: elem %d too short for in_header\n",
+                 __func__, elem->index);
+        assert(0); /* TODO */
+    }
+    if (out_len > se->bufsize) {
+        fuse_log(FUSE_LOG_ERR, "%s: elem %d too large for buffer\n", __fun=
c__,
+                 elem->index);
+        assert(0); /* TODO */
+    }
+    /* Copy just the first element and look at it */
+    copy_from_iov(&fbuf, 1, out_sg);
+
+    pbufv =3D NULL; /* Compiler thinks an unitialised path */
+    if (out_num > 2 &&
+        out_sg[0].iov_len =3D=3D sizeof(struct fuse_in_header) &&
+        ((struct fuse_in_header *)fbuf.mem)->opcode =3D=3D FUSE_WRITE &&
+        out_sg[1].iov_len =3D=3D sizeof(struct fuse_write_in)) {
+        /*
+         * For a write we don't actually need to copy the
+         * data, we can just do it straight out of guest memory
+         * but we must still copy the headers in case the guest
+         * was nasty and changed them while we were using them.
+         */
+        fuse_log(FUSE_LOG_DEBUG, "%s: Write special case\n", __func__);
+
+        /* copy the fuse_write_in header afte rthe fuse_in_header */
+        fbuf.mem +=3D out_sg->iov_len;
+        copy_from_iov(&fbuf, 1, out_sg + 1);
+        fbuf.mem -=3D out_sg->iov_len;
+        fbuf.size =3D out_sg[0].iov_len + out_sg[1].iov_len;
+
+        /* Allocate the bufv, with space for the rest of the iov */
+        pbufv =3D malloc(sizeof(struct fuse_bufvec) +
+                       sizeof(struct fuse_buf) * (out_num - 2));
+        if (!pbufv) {
+            fuse_log(FUSE_LOG_ERR, "%s: pbufv malloc failed\n",
+                    __func__);
+            goto out;
+        }
+
+        allocated_bufv =3D true;
+        pbufv->count =3D 1;
+        pbufv->buf[0] =3D fbuf;
+
+        size_t iovindex, pbufvindex;
+        iovindex =3D 2; /* 2 headers, separate iovs */
+        pbufvindex =3D 1; /* 2 headers, 1 fusebuf */
+
+        for (; iovindex < out_num; iovindex++, pbufvindex++) {
+            pbufv->count++;
+            pbufv->buf[pbufvindex].pos =3D ~0; /* Dummy */
+            pbufv->buf[pbufvindex].flags =3D 0;
+            pbufv->buf[pbufvindex].mem =3D out_sg[iovindex].iov_base;
+            pbufv->buf[pbufvindex].size =3D out_sg[iovindex].iov_len;
+        }
+    } else {
+        /* Normal (non fast write) path */
+
+        /* Copy the rest of the buffer */
+        fbuf.mem +=3D out_sg->iov_len;
+        copy_from_iov(&fbuf, out_num - 1, out_sg + 1);
+        fbuf.mem -=3D out_sg->iov_len;
+        fbuf.size =3D out_len;
+
+        /* TODO! Endianness of header */
+
+        /* TODO: Add checks for fuse_session_exited */
+        bufv.buf[0] =3D fbuf;
+        bufv.count =3D 1;
+        pbufv =3D &bufv;
+    }
+    pbufv->idx =3D 0;
+    pbufv->off =3D 0;
+    fuse_session_process_buf_int(se, pbufv, &req->ch);
+
+out:
+    if (allocated_bufv) {
+        free(pbufv);
+    }
+
+    /* If the request has no reply, still recycle the virtqueue element */
+    if (!req->reply_sent) {
+        struct VuVirtq *q =3D vu_get_queue(dev, qi->qidx);
+
+        fuse_log(FUSE_LOG_DEBUG, "%s: elem %d no reply sent\n", __func__,
+                 elem->index);
+
+        pthread_rwlock_rdlock(&qi->virtio_dev->vu_dispatch_rwlock);
+        pthread_mutex_lock(&qi->vq_lock);
+        vu_queue_push(dev, q, elem, 0);
+        vu_queue_notify(dev, q);
+        pthread_mutex_unlock(&qi->vq_lock);
+        pthread_rwlock_unlock(&qi->virtio_dev->vu_dispatch_rwlock);
+    }
+
+    pthread_mutex_destroy(&req->ch.lock);
+    free(fbuf.mem);
+    free(req);
+}
+
 /* Thread function for individual queues, created when a queue is 'started=
' */
 static void *fv_queue_thread(void *opaque)
 {
     struct fv_QueueInfo *qi =3D opaque;
     struct VuDev *dev =3D &qi->virtio_dev->dev;
     struct VuVirtq *q =3D vu_get_queue(dev, qi->qidx);
-    struct fuse_session *se =3D qi->virtio_dev->se;
-    struct fuse_chan ch;
-    struct fuse_buf fbuf;
-
-    fbuf.mem =3D NULL;
-    fbuf.flags =3D 0;
+    GThreadPool *pool;
=20
-    fuse_mutex_init(&ch.lock);
-    ch.fd =3D (int)0xdaff0d111;
-    ch.ctr =3D 1;
-    ch.qi =3D qi;
+    pool =3D g_thread_pool_new(fv_queue_worker, qi, 1 /* TODO max_threads =
*/,
+                             TRUE, NULL);
+    if (!pool) {
+        fuse_log(FUSE_LOG_ERR, "%s: g_thread_pool_new failed\n", __func__)=
;
+        return NULL;
+    }
=20
     fuse_log(FUSE_LOG_INFO, "%s: Start for queue %d kick_fd %d\n", __func_=
_,
              qi->qidx, qi->kick_fd);
@@ -476,6 +634,7 @@ static void *fv_queue_thread(void *opaque)
         /* Mutual exclusion with virtio_loop() */
         ret =3D pthread_rwlock_rdlock(&qi->virtio_dev->vu_dispatch_rwlock)=
;
         assert(ret =3D=3D 0); /* there is no possible error case */
+        pthread_mutex_lock(&qi->vq_lock);
         /* out is from guest, in is too guest */
         unsigned int in_bytes, out_bytes;
         vu_queue_get_avail_bytes(dev, q, &in_bytes, &out_bytes, ~0, ~0);
@@ -484,141 +643,22 @@ static void *fv_queue_thread(void *opaque)
                  "%s: Queue %d gave evalue: %zx available: in: %u out: %u\=
n",
                  __func__, qi->qidx, (size_t)evalue, in_bytes, out_bytes);
=20
-
         while (1) {
-            bool allocated_bufv =3D false;
-            struct fuse_bufvec bufv;
-            struct fuse_bufvec *pbufv;
-
-            /*
-             * An element contains one request and the space to send our
-             * response They're spread over multiple descriptors in a
-             * scatter/gather set and we can't trust the guest to keep the=
m
-             * still; so copy in/out.
-             */
-            VuVirtqElement *elem =3D vu_queue_pop(dev, q, sizeof(VuVirtqEl=
ement));
-            if (!elem) {
+            FVRequest *req =3D vu_queue_pop(dev, q, sizeof(FVRequest));
+            if (!req) {
                 break;
             }
=20
-            qi->qe =3D elem;
-            qi->reply_sent =3D false;
+            req->reply_sent =3D false;
=20
-            if (!fbuf.mem) {
-                fbuf.mem =3D malloc(se->bufsize);
-                assert(fbuf.mem);
-                assert(se->bufsize > sizeof(struct fuse_in_header));
-            }
-            /* The 'out' part of the elem is from qemu */
-            unsigned int out_num =3D elem->out_num;
-            struct iovec *out_sg =3D elem->out_sg;
-            size_t out_len =3D iov_size(out_sg, out_num);
-            fuse_log(FUSE_LOG_DEBUG,
-                     "%s: elem %d: with %d out desc of length %zd\n", __fu=
nc__,
-                     elem->index, out_num, out_len);
-
-            /*
-             * The elem should contain a 'fuse_in_header' (in to fuse)
-             * plus the data based on the len in the header.
-             */
-            if (out_len < sizeof(struct fuse_in_header)) {
-                fuse_log(FUSE_LOG_ERR, "%s: elem %d too short for in_heade=
r\n",
-                         __func__, elem->index);
-                assert(0); /* TODO */
-            }
-            if (out_len > se->bufsize) {
-                fuse_log(FUSE_LOG_ERR, "%s: elem %d too large for buffer\n=
",
-                         __func__, elem->index);
-                assert(0); /* TODO */
-            }
-            /* Copy just the first element and look at it */
-            copy_from_iov(&fbuf, 1, out_sg);
-
-            if (out_num > 2 &&
-                out_sg[0].iov_len =3D=3D sizeof(struct fuse_in_header) &&
-                ((struct fuse_in_header *)fbuf.mem)->opcode =3D=3D FUSE_WR=
ITE &&
-                out_sg[1].iov_len =3D=3D sizeof(struct fuse_write_in)) {
-                /*
-                 * For a write we don't actually need to copy the
-                 * data, we can just do it straight out of guest memory
-                 * but we must still copy the headers in case the guest
-                 * was nasty and changed them while we were using them.
-                 */
-                fuse_log(FUSE_LOG_DEBUG, "%s: Write special case\n", __fun=
c__);
-
-                /* copy the fuse_write_in header after the fuse_in_header =
*/
-                fbuf.mem +=3D out_sg->iov_len;
-                copy_from_iov(&fbuf, 1, out_sg + 1);
-                fbuf.mem -=3D out_sg->iov_len;
-                fbuf.size =3D out_sg[0].iov_len + out_sg[1].iov_len;
-
-                /* Allocate the bufv, with space for the rest of the iov *=
/
-                allocated_bufv =3D true;
-                pbufv =3D malloc(sizeof(struct fuse_bufvec) +
-                               sizeof(struct fuse_buf) * (out_num - 2));
-                if (!pbufv) {
-                    vu_queue_unpop(dev, q, elem, 0);
-                    free(elem);
-                    fuse_log(FUSE_LOG_ERR, "%s: pbufv malloc failed\n",
-                             __func__);
-                    goto out;
-                }
-
-                pbufv->count =3D 1;
-                pbufv->buf[0] =3D fbuf;
-
-                size_t iovindex, pbufvindex;
-                iovindex =3D 2; /* 2 headers, separate iovs */
-                pbufvindex =3D 1; /* 2 headers, 1 fusebuf */
-
-                for (; iovindex < out_num; iovindex++, pbufvindex++) {
-                    pbufv->count++;
-                    pbufv->buf[pbufvindex].pos =3D ~0; /* Dummy */
-                    pbufv->buf[pbufvindex].flags =3D 0;
-                    pbufv->buf[pbufvindex].mem =3D out_sg[iovindex].iov_ba=
se;
-                    pbufv->buf[pbufvindex].size =3D out_sg[iovindex].iov_l=
en;
-                }
-            } else {
-                /* Normal (non fast write) path */
-
-                /* Copy the rest of the buffer */
-                fbuf.mem +=3D out_sg->iov_len;
-                copy_from_iov(&fbuf, out_num - 1, out_sg + 1);
-                fbuf.mem -=3D out_sg->iov_len;
-                fbuf.size =3D out_len;
-
-                /* TODO! Endianness of header */
-
-                /* TODO: Add checks for fuse_session_exited */
-                bufv.buf[0] =3D fbuf;
-                bufv.count =3D 1;
-                pbufv =3D &bufv;
-            }
-            pbufv->idx =3D 0;
-            pbufv->off =3D 0;
-            fuse_session_process_buf_int(se, pbufv, &ch);
-
-            if (allocated_bufv) {
-                free(pbufv);
-            }
-
-            if (!qi->reply_sent) {
-                fuse_log(FUSE_LOG_DEBUG, "%s: elem %d no reply sent\n",
-                         __func__, elem->index);
-                /* I think we've still got to recycle the element */
-                vu_queue_push(dev, q, elem, 0);
-                vu_queue_notify(dev, q);
-            }
-            qi->qe =3D NULL;
-            free(elem);
-            elem =3D NULL;
+            g_thread_pool_push(pool, req, NULL);
         }
=20
+        pthread_mutex_unlock(&qi->vq_lock);
         pthread_rwlock_unlock(&qi->virtio_dev->vu_dispatch_rwlock);
     }
-out:
-    pthread_mutex_destroy(&ch.lock);
-    free(fbuf.mem);
+
+    g_thread_pool_free(pool, FALSE, TRUE);
=20
     return NULL;
 }
@@ -670,6 +710,8 @@ static void fv_queue_set_started(VuDev *dev, int qidx, =
bool started)
=20
         ourqi->kill_fd =3D eventfd(0, EFD_CLOEXEC | EFD_SEMAPHORE);
         assert(ourqi->kill_fd !=3D -1);
+        pthread_mutex_init(&ourqi->vq_lock, NULL);
+
         if (pthread_create(&ourqi->thread, NULL, fv_queue_thread, ourqi)) =
{
             fuse_log(FUSE_LOG_ERR, "%s: Failed to create thread for queue =
%d\n",
                      __func__, qidx);
@@ -689,6 +731,7 @@ static void fv_queue_set_started(VuDev *dev, int qidx, =
bool started)
             fuse_log(FUSE_LOG_ERR, "%s: Failed to join thread idx %d err %=
d\n",
                      __func__, qidx, ret);
         }
+        pthread_mutex_destroy(&ourqi->vq_lock);
         close(ourqi->kill_fd);
         ourqi->kick_fd =3D -1;
         free(vud->qi[qidx]);
--=20
2.23.0


