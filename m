Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480ACC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 16:57:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CE842064A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 16:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE842064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htEOo-0008Hl-Bv
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 12:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33071)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1htELc-0005OE-NN
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:54:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1htELT-0005Lo-A7
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:54:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20763)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1htELQ-0005J5-Tp
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:54:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3FFDB3149676;
 Thu,  1 Aug 2019 16:54:23 +0000 (UTC)
Received: from localhost (ovpn-116-232.ams2.redhat.com [10.36.116.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 238FB5C205;
 Thu,  1 Aug 2019 16:54:17 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: virtio-fs@redhat.com,
	qemu-devel@nongnu.org
Date: Thu,  1 Aug 2019 17:54:06 +0100
Message-Id: <20190801165409.20121-2-stefanha@redhat.com>
In-Reply-To: <20190801165409.20121-1-stefanha@redhat.com>
References: <20190801165409.20121-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 01 Aug 2019 16:54:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/4] virtiofsd: process requests in a thread
 pool
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
Cc: Liu Bo <bo.liu@linux.alibaba.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
 contrib/virtiofsd/fuse_virtio.c | 491 ++++++++++++++++++--------------
 contrib/virtiofsd/seccomp.c     |   1 +
 2 files changed, 273 insertions(+), 219 deletions(-)

diff --git a/contrib/virtiofsd/fuse_virtio.c b/contrib/virtiofsd/fuse_vir=
tio.c
index d543c6d30f..0c52911144 100644
--- a/contrib/virtiofsd/fuse_virtio.c
+++ b/contrib/virtiofsd/fuse_virtio.c
@@ -29,26 +29,40 @@
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <sys/un.h>
+#include <glib.h>
=20
 #include "contrib/libvhost-user/libvhost-user.h"
=20
 struct fv_VuDev;
 struct fv_QueueInfo {
         pthread_t thread;
+
+        /* This lock protects the VuVirtq preventing races between
+         * fv_queue_thread() and fv_queue_worker().
+         */
+        pthread_mutex_t vq_lock;
+
         struct fv_VuDev *virtio_dev;
=20
         /* Our queue index, corresponds to array position */
         int       qidx;
         int       kick_fd;
         int       kill_fd; /* For killing the thread */
-
-        /* The element for the command currently being processed */
-        VuVirtqElement *qe;
-        /* If any of the qe vec elements (towards vmm) are unmappable */
-        unsigned int elem_bad_in;
-        bool      reply_sent;
 };
=20
+/* A FUSE request */
+typedef struct {
+        VuVirtqElement elem;
+        struct fuse_chan ch;
+
+        /* Number of unmappable iovecs */
+        unsigned int bad_in_num;
+        unsigned int bad_out_num;
+
+        /* Used to complete requests that involve no reply */
+        bool reply_sent;
+} FVRequest;
+
 /* We pass the dev element into libvhost-user
  * and then use it to get back to the outer
  * container for other data.
@@ -186,8 +200,11 @@ static void copy_iov(struct iovec *src_iov, int src_=
count,
 int virtio_send_msg(struct fuse_session *se, struct fuse_chan *ch,
                     struct iovec *iov, int count)
 {
-        VuVirtqElement *elem;
-        VuVirtq *q;
+        FVRequest *req =3D container_of(ch, FVRequest, ch);
+        struct fv_QueueInfo *qi =3D ch->qi;
+        VuDev *dev =3D &se->virtio_dev->dev;
+        VuVirtq *q =3D vu_get_queue(dev, qi->qidx);
+        VuVirtqElement *elem =3D &req->elem;
         int ret =3D 0;
=20
         assert(count >=3D 1);
@@ -200,11 +217,7 @@ int virtio_send_msg(struct fuse_session *se, struct =
fuse_chan *ch,
=20
         /* unique =3D=3D 0 is notification, which we don't support */
         assert (out->unique);
-        /* For virtio we always have ch */
-        assert(ch);
-        assert(!ch->qi->reply_sent);
-        elem =3D ch->qi->qe;
-        q =3D &ch->qi->virtio_dev->dev.vq[ch->qi->qidx];
+        assert(!req->reply_sent);
=20
         /* The 'in' part of the elem is to qemu */
         unsigned int in_num =3D elem->in_num;
@@ -231,9 +244,15 @@ int virtio_send_msg(struct fuse_session *se, struct =
fuse_chan *ch,
         }
=20
         copy_iov(iov, count, in_sg, in_num, tosend_len);
-        vu_queue_push(&se->virtio_dev->dev, q, elem, tosend_len);
-        vu_queue_notify(&se->virtio_dev->dev, q);
-        ch->qi->reply_sent =3D true;
+
+        pthread_rwlock_rdlock(&qi->virtio_dev->vu_dispatch_rwlock);
+        pthread_mutex_lock(&qi->vq_lock);
+        vu_queue_push(dev, q, elem, tosend_len);
+        vu_queue_notify(dev, q);
+        pthread_mutex_unlock(&qi->vq_lock);
+        pthread_rwlock_unlock(&qi->virtio_dev->vu_dispatch_rwlock);
+
+        req->reply_sent =3D true;
=20
 err:
=20
@@ -249,9 +268,12 @@ int virtio_send_data_iov(struct fuse_session *se, st=
ruct fuse_chan *ch,
                          struct iovec *iov, int count,
                          struct fuse_bufvec *buf, size_t len)
 {
+        FVRequest *req =3D container_of(ch, FVRequest, ch);
+        struct fv_QueueInfo *qi =3D ch->qi;
+        VuDev *dev =3D &se->virtio_dev->dev;
+        VuVirtq *q =3D vu_get_queue(dev, qi->qidx);
+        VuVirtqElement *elem =3D &req->elem;
         int ret =3D 0;
-        VuVirtqElement *elem;
-        VuVirtq *q;
=20
         assert(count >=3D 1);
         assert(iov[0].iov_len >=3D sizeof(struct fuse_out_header));
@@ -271,15 +293,11 @@ int virtio_send_data_iov(struct fuse_session *se, s=
truct fuse_chan *ch,
         /* unique =3D=3D 0 is notification which we don't support */
         assert (out->unique);
=20
-        /* For virtio we always have ch */
-        assert(ch);
-        assert(!ch->qi->reply_sent);
-        elem =3D ch->qi->qe;
-        q =3D &ch->qi->virtio_dev->dev.vq[ch->qi->qidx];
+        assert(!req->reply_sent);
=20
         /* The 'in' part of the elem is to qemu */
         unsigned int in_num =3D elem->in_num;
-        unsigned int bad_in_num =3D ch->qi->elem_bad_in;
+        unsigned int bad_in_num =3D req->bad_in_num;
         struct iovec *in_sg =3D elem->in_sg;
         size_t in_len =3D iov_length(in_sg, in_num);
         size_t in_len_writeable =3D iov_length(in_sg, in_num - bad_in_nu=
m);
@@ -423,16 +441,219 @@ int virtio_send_data_iov(struct fuse_session *se, =
struct fuse_chan *ch,
=20
         ret =3D 0;
=20
-        vu_queue_push(&se->virtio_dev->dev, q, elem, tosend_len);
-        vu_queue_notify(&se->virtio_dev->dev, q);
+        pthread_rwlock_rdlock(&qi->virtio_dev->vu_dispatch_rwlock);
+        pthread_mutex_lock(&qi->vq_lock);
+        vu_queue_push(dev, q, elem, tosend_len);
+        vu_queue_notify(dev, q);
+        pthread_mutex_unlock(&qi->vq_lock);
+        pthread_rwlock_unlock(&qi->virtio_dev->vu_dispatch_rwlock);
=20
 err:
         if (ret =3D=3D 0)
-                ch->qi->reply_sent =3D true;
+                req->reply_sent =3D true;
=20
         return ret;
 }
=20
+/* Process one FVRequest in a thread pool */
+static void fv_queue_worker(gpointer data, gpointer user_data)
+{
+        struct fv_QueueInfo *qi =3D user_data;
+        struct fuse_session *se =3D qi->virtio_dev->se;
+        struct VuDev *dev =3D &qi->virtio_dev->dev;
+        FVRequest *req =3D data;
+        VuVirtqElement *elem =3D &req->elem;
+        struct fuse_buf fbuf =3D {};
+        bool allocated_bufv =3D false;
+        struct fuse_bufvec bufv;
+        struct fuse_bufvec *pbufv;
+
+        assert(se->bufsize > sizeof(struct fuse_in_header));
+
+        /* An element contains one request and the space to send our res=
ponse
+         * They're spread over multiple descriptors in a scatter/gather =
set
+         * and we can't trust the guest to keep them still; so copy in/o=
ut.
+         */
+        fbuf.mem =3D malloc(se->bufsize);
+        assert(fbuf.mem);
+
+        fuse_mutex_init(&req->ch.lock);
+        req->ch.fd =3D (int)0xdaff0d111;
+        req->ch.ctr =3D 1;
+        req->ch.qi =3D qi;
+
+        /* The 'out' part of the elem is from qemu */
+        unsigned int out_num =3D elem->out_num;
+        unsigned int out_num_readable =3D out_num - req->bad_out_num;
+        struct iovec *out_sg =3D elem->out_sg;
+        size_t out_len =3D iov_length(out_sg, out_num);
+        size_t out_len_readable =3D iov_length(out_sg, out_num_readable)=
;
+        if (se->debug)
+                fuse_debug("%s: elem %d: with %d out desc of length %zd"
+                           " bad_in_num=3D%u bad_out_num=3D%u\n",
+                           __func__, elem->index, out_num,
+                           out_len, req->bad_in_num, req->bad_out_num);
+
+        /* The elem should contain a 'fuse_in_header' (in to fuse)
+         * plus the data based on the len in the header.
+         */
+        if (out_len_readable < sizeof(struct fuse_in_header)) {
+                fuse_err("%s: elem %d too short for in_header\n",
+                                __func__, elem->index);
+                assert(0); // TODO
+        }
+        if (out_len > se->bufsize) {
+                fuse_err("%s: elem %d too large for buffer\n",
+                                __func__, elem->index);
+                assert(0); // TODO
+        }
+        // Copy just the first element and look at it
+        copy_from_iov(&fbuf, 1, out_sg);
+
+        pbufv =3D NULL; /* Compiler thinks an unitialised path */
+        if (req->bad_in_num || req->bad_out_num) {
+                bool handled_unmappable =3D false;
+
+                if (out_num > 2 && out_num_readable >=3D 2 && !req->bad_=
in_num &&
+                                out_sg[0].iov_len =3D=3D sizeof(struct f=
use_in_header) &&
+                                ((struct fuse_in_header *)fbuf.mem)->opc=
ode =3D=3D
+                                FUSE_WRITE &&
+                                out_sg[1].iov_len =3D=3D sizeof(struct f=
use_write_in)) {
+                        handled_unmappable =3D true;
+
+                        // copy the fuse_write_in header after the fuse_=
in_header
+                        fbuf.mem +=3D out_sg->iov_len;
+                        copy_from_iov(&fbuf, 1, out_sg + 1);
+                        fbuf.mem -=3D out_sg->iov_len;
+                        fbuf.size =3D out_sg[0].iov_len + out_sg[1].iov_=
len;
+
+                        // Allocate the bufv, with space for the rest of=
 the iov
+                        allocated_bufv =3D true;
+                        pbufv =3D malloc(sizeof(struct fuse_bufvec) +
+                                        sizeof(struct fuse_buf) * (out_n=
um - 2));
+
+                        pbufv->count =3D 1;
+                        pbufv->buf[0] =3D fbuf;
+
+                        size_t iovindex, pbufvindex;
+                        iovindex =3D 2; // 2 headers, separate iovs
+                        pbufvindex =3D 1; // 2 headers, 1 fusebuf
+
+                        for(; iovindex < out_num; iovindex++, pbufvindex=
++) {
+                                pbufv->count++;
+                                pbufv->buf[pbufvindex].pos =3D ~0; // Du=
mmy
+                                pbufv->buf[pbufvindex].flags =3D
+                                        (iovindex < out_num_readable) ?
+                                        0 : FUSE_BUF_PHYS_ADDR;
+                                pbufv->buf[pbufvindex].mem =3D out_sg[io=
vindex].iov_base;
+                                pbufv->buf[pbufvindex].size =3D out_sg[i=
ovindex].iov_len;
+                        }
+                }
+
+                if (out_num =3D=3D 2 && out_num_readable =3D=3D 2 && req=
->bad_in_num &&
+                                out_sg[0].iov_len =3D=3D sizeof(struct f=
use_in_header) &&
+                                ((struct fuse_in_header *)fbuf.mem)->opc=
ode =3D=3D
+                                FUSE_READ &&
+                                out_sg[1].iov_len =3D=3D sizeof(struct f=
use_read_in)) {
+                        if (se->debug) {
+                                fuse_debug("Unmappable read case "
+                                           "in_num=3D%d bad_in_num=3D%d\=
n",
+                                           elem->in_num, req->bad_in_num=
);
+                        }
+                        handled_unmappable =3D true;
+                }
+
+                if (!handled_unmappable) {
+                        fuse_err("Unhandled unmappable element: out: %d(=
b:%d) in: %d(b:%d)",
+                                 out_num, req->bad_out_num,
+                                 elem->in_num, req->bad_in_num);
+                        fv_panic(dev, "Unhandled unmappable element");
+                }
+        }
+
+        if (!req->bad_out_num) {
+                if (out_num > 2 &&
+                                out_sg[0].iov_len =3D=3D sizeof(struct f=
use_in_header) &&
+                                ((struct fuse_in_header *)fbuf.mem)->opc=
ode =3D=3D
+                                FUSE_WRITE &&
+                                out_sg[1].iov_len =3D=3D sizeof(struct f=
use_write_in)) {
+                        // For a write we don't actually need to copy th=
e
+                        // data, we can just do it straight out of guest=
 memory
+                        // but we must sitll copy the headers in case th=
e guest
+                        // was nasty and changed them while we were usin=
g them.
+                        if (se->debug)
+                                fuse_debug("%s: Write special case\n", _=
_func__);
+
+                        // copy the fuse_write_in header afte rthe fuse_=
in_header
+                        fbuf.mem +=3D out_sg->iov_len;
+                        copy_from_iov(&fbuf, 1, out_sg + 1);
+                        fbuf.mem -=3D out_sg->iov_len;
+                        fbuf.size =3D out_sg[0].iov_len + out_sg[1].iov_=
len;
+
+                        // Allocate the bufv, with space for the rest of=
 the iov
+                        allocated_bufv =3D true;
+                        pbufv =3D malloc(sizeof(struct fuse_bufvec) +
+                                        sizeof(struct fuse_buf) * (out_n=
um - 2));
+
+                        pbufv->count =3D 1;
+                        pbufv->buf[0] =3D fbuf;
+
+                        size_t iovindex, pbufvindex;
+                        iovindex =3D 2; // 2 headers, separate iovs
+                        pbufvindex =3D 1; // 2 headers, 1 fusebuf
+
+                        for(; iovindex < out_num; iovindex++, pbufvindex=
++) {
+                                pbufv->count++;
+                                pbufv->buf[pbufvindex].pos =3D ~0; // Du=
mmy
+                                pbufv->buf[pbufvindex].flags =3D 0;
+                                pbufv->buf[pbufvindex].mem =3D out_sg[io=
vindex].iov_base;
+                                pbufv->buf[pbufvindex].size =3D out_sg[i=
ovindex].iov_len;
+                        }
+                } else {
+                        // Normal (non fast write) path
+
+                        // Copy the rest of the buffer
+                        fbuf.mem +=3D out_sg->iov_len;
+                        copy_from_iov(&fbuf, out_num - 1, out_sg + 1);
+                        fbuf.mem -=3D out_sg->iov_len;
+                        fbuf.size =3D out_len;
+
+                        // TODO! Endianness of header
+
+                        // TODO: Add checks for fuse_session_exited
+                        bufv.buf[0] =3D fbuf;
+                        bufv.count =3D 1;
+                        pbufv =3D &bufv;
+                }
+        }
+        pbufv->idx =3D 0;
+        pbufv->off =3D 0;
+        fuse_session_process_buf_int(se, pbufv, &req->ch);
+
+        if (allocated_bufv) free(pbufv);
+
+        /* If the request has no reply, still recycle the virtqueue elem=
ent */
+        if (!req->reply_sent) {
+                struct VuVirtq *q =3D vu_get_queue(dev, qi->qidx);
+
+                if (se->debug) {
+                        fuse_debug("%s: elem %d no reply sent\n",
+                                   __func__, elem->index);
+                }
+
+                pthread_rwlock_rdlock(&qi->virtio_dev->vu_dispatch_rwloc=
k);
+                pthread_mutex_lock(&qi->vq_lock);
+                vu_queue_push(dev, q, elem, 0);
+                vu_queue_notify(dev, q);
+                pthread_mutex_unlock(&qi->vq_lock);
+                pthread_rwlock_unlock(&qi->virtio_dev->vu_dispatch_rwloc=
k);
+        }
+
+        pthread_mutex_destroy(&req->ch.lock);
+        free(fbuf.mem);
+        free(req);
+}
+
 /* Thread function for individual queues, created when a queue is 'start=
ed' */
 static void *fv_queue_thread(void *opaque)
 {
@@ -440,16 +661,14 @@ static void *fv_queue_thread(void *opaque)
         struct VuDev        *dev =3D &qi->virtio_dev->dev;
         struct VuVirtq      *q =3D vu_get_queue(dev, qi->qidx);
         struct fuse_session *se =3D qi->virtio_dev->se;
-        struct fuse_chan    ch;
-        struct fuse_buf     fbuf;
+        GThreadPool *pool;
=20
-        fbuf.mem =3D NULL;
-        fbuf.flags =3D 0;
-
-        fuse_mutex_init(&ch.lock);
-        ch.fd =3D (int)0xdaff0d111;
-        ch.ctr =3D 1;
-        ch.qi =3D qi;
+        pool =3D g_thread_pool_new(fv_queue_worker, qi, 1 /* TODO max_th=
reads */,
+                        TRUE, NULL);
+        if (!pool) {
+                fuse_err("%s: g_thread_pool_new failed\n", __func__);
+                return NULL;
+        }
=20
         fuse_info("%s: Start for queue %d kick_fd %d\n",
                   __func__, qi->qidx, qi->kick_fd);
@@ -507,6 +726,8 @@ static void *fv_queue_thread(void *opaque)
                ret =3D pthread_rwlock_rdlock(&qi->virtio_dev->vu_dispatc=
h_rwlock);
                assert(ret =3D=3D 0); /* there is no possible error case =
*/
=20
+               pthread_mutex_lock(&qi->vq_lock);
+
                if (se->debug) {
                        /* out is from guest, in is too guest */
                        unsigned int in_bytes, out_bytes;
@@ -518,198 +739,26 @@ static void *fv_queue_thread(void *opaque)
                }
=20
                while (1) {
-                       bool allocated_bufv =3D false;
-                       struct fuse_bufvec bufv;
-                       struct fuse_bufvec *pbufv;
                        unsigned int bad_in_num =3D 0, bad_out_num =3D 0;
-
-                       /* An element contains one request and the space =
to send our response
-                        * They're spread over multiple descriptors in a =
scatter/gather set
-                        * and we can't trust the guest to keep them stil=
l; so copy in/out.
-                        */
-                       VuVirtqElement *elem =3D vu_queue_pop(dev, q, siz=
eof(VuVirtqElement),
-                                                           &bad_in_num, =
&bad_out_num);
-                       if (!elem) {
+                       FVRequest *req =3D vu_queue_pop(dev, q, sizeof(FV=
Request),
+                                                     &bad_in_num,
+                                                     &bad_out_num);
+                       if (!req) {
                                break;
                        }
=20
-                       qi->qe =3D elem;
-                       qi->reply_sent =3D false;
-                       qi->elem_bad_in =3D bad_in_num;
+                       req->reply_sent =3D false;
+                       req->bad_in_num =3D bad_in_num;
+                       req->bad_out_num =3D bad_out_num;
=20
-                       if (!fbuf.mem) {
-                               fbuf.mem =3D malloc(se->bufsize);
-                               assert(fbuf.mem);
-                               assert(se->bufsize > sizeof(struct fuse_i=
n_header));
-                       }
-                       /* The 'out' part of the elem is from qemu */
-                       unsigned int out_num =3D elem->out_num;
-                       unsigned int out_num_readable =3D out_num - bad_o=
ut_num;
-                       struct iovec *out_sg =3D elem->out_sg;
-                       size_t out_len =3D iov_length(out_sg, out_num);
-                       size_t out_len_readable =3D iov_length(out_sg, ou=
t_num_readable);
-                       if (se->debug)
-                               fuse_debug("%s: elem %d: with %d out desc=
 of length %zd"
-                                          " bad_in_num=3D%u bad_out_num=3D=
%u\n",
-					  __func__, elem->index, out_num,
-					  out_len, bad_in_num, bad_out_num);
-
-                       /* The elem should contain a 'fuse_in_header' (in=
 to fuse)
-                        * plus the data based on the len in the header.
-                        */
-                       if (out_len_readable < sizeof(struct fuse_in_head=
er)) {
-                               fuse_err("%s: elem %d too short for in_he=
ader\n",
-                                        __func__, elem->index);
-                               assert(0); // TODO
-                       }
-                       if (out_len > se->bufsize) {
-                               fuse_err("%s: elem %d too large for buffe=
r\n",
-                                        __func__, elem->index);
-                               assert(0); // TODO
-                       }
-                       // Copy just the first element and look at it
-                       copy_from_iov(&fbuf, 1, out_sg);
-
-                       pbufv =3D NULL; /* Compiler thinks an unitialised=
 path */
-                       if (bad_in_num || bad_out_num) {
-                           bool handled_unmappable =3D false;
-
-                           if (out_num > 2 && out_num_readable >=3D 2 &&=
 !bad_in_num &&
-                               out_sg[0].iov_len =3D=3D sizeof(struct fu=
se_in_header) &&
-                               ((struct fuse_in_header *)fbuf.mem)->opco=
de =3D=3D
-                                   FUSE_WRITE &&
-                               out_sg[1].iov_len =3D=3D sizeof(struct fu=
se_write_in)) {
-                               handled_unmappable =3D true;
-
-                               // copy the fuse_write_in header after th=
e fuse_in_header
-                               fbuf.mem +=3D out_sg->iov_len;
-                               copy_from_iov(&fbuf, 1, out_sg + 1);
-                               fbuf.mem -=3D out_sg->iov_len;
-                               fbuf.size =3D out_sg[0].iov_len + out_sg[=
1].iov_len;
-
-                               // Allocate the bufv, with space for the =
rest of the iov
-                               allocated_bufv =3D true;
-                               pbufv =3D malloc(sizeof(struct fuse_bufve=
c) +
-                                              sizeof(struct fuse_buf) * =
(out_num - 2));
-
-                               pbufv->count =3D 1;
-                               pbufv->buf[0] =3D fbuf;
-
-                               size_t iovindex, pbufvindex;
-                               iovindex =3D 2; // 2 headers, separate io=
vs
-                               pbufvindex =3D 1; // 2 headers, 1 fusebuf
-
-                               for(; iovindex < out_num; iovindex++, pbu=
fvindex++) {
-                                       pbufv->count++;
-                                       pbufv->buf[pbufvindex].pos =3D ~0=
; // Dummy
-                                       pbufv->buf[pbufvindex].flags =3D
-                                               (iovindex < out_num_reada=
ble) ?
-                                               0 : FUSE_BUF_PHYS_ADDR;
-                                       pbufv->buf[pbufvindex].mem =3D ou=
t_sg[iovindex].iov_base;
-                                       pbufv->buf[pbufvindex].size =3D o=
ut_sg[iovindex].iov_len;
-                               }
-                           }
-
-                           if (out_num =3D=3D 2 && out_num_readable =3D=3D=
 2 && bad_in_num &&
-                               out_sg[0].iov_len =3D=3D sizeof(struct fu=
se_in_header) &&
-                               ((struct fuse_in_header *)fbuf.mem)->opco=
de =3D=3D
-                                   FUSE_READ &&
-                               out_sg[1].iov_len =3D=3D sizeof(struct fu=
se_read_in)) {
-                               if (se->debug) {
-                                   fuse_debug("Unmappable read case "
-                                              "in_num=3D%d bad_in_num=3D=
%d\n",
-                                              elem->in_num, bad_in_num);
-                               }
-                               handled_unmappable =3D true;
-                           }
-
-                           if (!handled_unmappable) {
-                               fuse_err("Unhandled unmappable element: o=
ut: %d(b:%d) in: %d(b:%d)",
-                                        out_num, bad_out_num,
-                                        elem->in_num, bad_in_num);
-                               fv_panic(dev, "Unhandled unmappable eleme=
nt");
-                           }
-                       }
-
-                       if (!bad_out_num) {
-                           if (out_num > 2 &&
-                               out_sg[0].iov_len =3D=3D sizeof(struct fu=
se_in_header) &&
-                               ((struct fuse_in_header *)fbuf.mem)->opco=
de =3D=3D
-                                   FUSE_WRITE &&
-                               out_sg[1].iov_len =3D=3D sizeof(struct fu=
se_write_in)) {
-                                   // For a write we don't actually need=
 to copy the
-                                   // data, we can just do it straight o=
ut of guest memory
-                                   // but we must sitll copy the headers=
 in case the guest
-                                   // was nasty and changed them while w=
e were using them.
-                                   if (se->debug)
-                                           fuse_debug("%s: Write special=
 case\n", __func__);
-
-                                   // copy the fuse_write_in header afte=
 rthe fuse_in_header
-                                   fbuf.mem +=3D out_sg->iov_len;
-                                   copy_from_iov(&fbuf, 1, out_sg + 1);
-                                   fbuf.mem -=3D out_sg->iov_len;
-                                   fbuf.size =3D out_sg[0].iov_len + out=
_sg[1].iov_len;
-
-                                   // Allocate the bufv, with space for =
the rest of the iov
-                                   allocated_bufv =3D true;
-                                   pbufv =3D malloc(sizeof(struct fuse_b=
ufvec) +
-                                                  sizeof(struct fuse_buf=
) * (out_num - 2));
-
-                                   pbufv->count =3D 1;
-                                   pbufv->buf[0] =3D fbuf;
-
-                                   size_t iovindex, pbufvindex;
-                                   iovindex =3D 2; // 2 headers, separat=
e iovs
-                                   pbufvindex =3D 1; // 2 headers, 1 fus=
ebuf
-
-                                   for(; iovindex < out_num; iovindex++,=
 pbufvindex++) {
-                                           pbufv->count++;
-                                           pbufv->buf[pbufvindex].pos =3D=
 ~0; // Dummy
-                                           pbufv->buf[pbufvindex].flags =
=3D 0;
-                                           pbufv->buf[pbufvindex].mem =3D=
 out_sg[iovindex].iov_base;
-                                           pbufv->buf[pbufvindex].size =3D=
 out_sg[iovindex].iov_len;
-                                   }
-                           } else {
-                                   // Normal (non fast write) path
-
-                                   // Copy the rest of the buffer
-                                   fbuf.mem +=3D out_sg->iov_len;
-                                   copy_from_iov(&fbuf, out_num - 1, out=
_sg + 1);
-                                   fbuf.mem -=3D out_sg->iov_len;
-                                   fbuf.size =3D out_len;
-
-                                   // TODO! Endianness of header
-
-                                   // TODO: Add checks for fuse_session_=
exited
-                                   bufv.buf[0] =3D fbuf;
-                                   bufv.count =3D 1;
-                                   pbufv =3D &bufv;
-                           }
-                       }
-                       pbufv->idx =3D 0;
-                       pbufv->off =3D 0;
-                       fuse_session_process_buf_int(se, pbufv, &ch);
-
-                       if (allocated_bufv) free(pbufv);
-
-                       if (!qi->reply_sent) {
-			       if (se->debug) {
-				       fuse_debug("%s: elem %d no reply sent\n",
-					          __func__, elem->index);
-			       }
-                               /* I think we've still got to recycle the=
 element */
-                               vu_queue_push(dev, q, elem, 0);
-                               vu_queue_notify(dev, q);
-                       }
-                       qi->qe =3D NULL;
-                       free(elem);
-                       elem =3D NULL;
+                       g_thread_pool_push(pool, req, NULL);
                 }
=20
+                pthread_mutex_unlock(&qi->vq_lock);
                 pthread_rwlock_unlock(&qi->virtio_dev->vu_dispatch_rwloc=
k);
         }
-        pthread_mutex_destroy(&ch.lock);
-        free(fbuf.mem);
+
+        g_thread_pool_free(pool, FALSE, TRUE);
=20
         return NULL;
 }
@@ -760,6 +809,9 @@ static void fv_queue_set_started(VuDev *dev, int qidx=
, bool started)
=20
                 ourqi->kill_fd =3D eventfd(0, EFD_CLOEXEC | EFD_SEMAPHOR=
E);
                 assert(ourqi->kill_fd !=3D -1);
+
+                pthread_mutex_init(&ourqi->vq_lock, NULL);
+
                 if (pthread_create(&ourqi->thread, NULL,  fv_queue_threa=
d,
                                    ourqi)) {
                         fuse_err("%s: Failed to create thread for queue =
%d\n",
@@ -780,6 +832,7 @@ static void fv_queue_set_started(VuDev *dev, int qidx=
, bool started)
                        fuse_err("%s: Failed to join thread idx %d err %d=
\n",
                                 __func__, qidx, ret);
                 }
+                pthread_mutex_destroy(&ourqi->vq_lock);
                 close(ourqi->kill_fd);
                 ourqi->kick_fd =3D -1;
                 free(vud->qi[qidx]);
diff --git a/contrib/virtiofsd/seccomp.c b/contrib/virtiofsd/seccomp.c
index cea4cc5f60..5f1c873b82 100644
--- a/contrib/virtiofsd/seccomp.c
+++ b/contrib/virtiofsd/seccomp.c
@@ -58,6 +58,7 @@ static const int syscall_whitelist[] =3D {
 	SCMP_SYS(open),
 	SCMP_SYS(openat),
 	SCMP_SYS(ppoll),
+	SCMP_SYS(prctl), /* TODO restrict to just PR_SET_NAME? */
 	SCMP_SYS(preadv),
 	SCMP_SYS(pwrite64),
 	SCMP_SYS(read),
--=20
2.21.0


