Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACBEC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5088207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ePMVU/1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5088207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irK16-00053U-JE
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 06:05:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1irJvb-0007wv-74
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:00:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1irJvX-0006NW-AY
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:00:07 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33306
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1irJvX-0006L5-3U
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578999602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=njIkzfi11qpKU658aVYy+uBVDZ16OoslMYBqd//K9YE=;
 b=ePMVU/1ppyMj+3PnBA78mDNWjse4jcjqOSeUkoOBD1MB0Jar4eAm6U0EV0c5gTDFE/fb+K
 EFsg/uRTGTe0r2OE4Thqg4h1Cik9V/l/ZQlUsEgKDZTskFDPRU+IXWu1fnY6QoQP0j7g1h
 hpB6+v3DnxMGrTntzIzGzTCc8/4dU4M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-vL5gTMgRPb6mgjCPtlsrFA-1; Tue, 14 Jan 2020 06:00:01 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F37E5107ACC5;
 Tue, 14 Jan 2020 10:59:59 +0000 (UTC)
Received: from localhost (unknown [10.36.118.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 54885675AF;
 Tue, 14 Jan 2020 10:59:59 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 04/15] block/io_uring: implements interfaces for io_uring
Date: Tue, 14 Jan 2020 10:59:10 +0000
Message-Id: <20200114105921.131880-5-stefanha@redhat.com>
In-Reply-To: <20200114105921.131880-1-stefanha@redhat.com>
References: <20200114105921.131880-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: vL5gTMgRPb6mgjCPtlsrFA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, oleksandr@redhat.com,
 Julia Suvorova <jusual@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aarushi Mehta <mehta.aaru20@gmail.com>

Aborts when sqe fails to be set as sqes cannot be returned to the
ring. Adds slow path for short reads for older kernels

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v11:
 * Fix git bisect compilation breakage: move trace_luring_init_state()
   into the tracing commit.
v10:
 * Update MAINTAINERS file [Julia]
 * Rename MAX_EVENTS to MAX_ENTRIES [Julia]
 * Define ioq_submit() before callers so the prototype isn't necessary [Jul=
ia]
 * Declare variables at the beginning of the block in luring_init() [Julia]
---
 MAINTAINERS             |   8 +
 block/Makefile.objs     |   3 +
 block/io_uring.c        | 401 ++++++++++++++++++++++++++++++++++++++++
 include/block/aio.h     |  16 +-
 include/block/raw-aio.h |  12 ++
 5 files changed, 439 insertions(+), 1 deletion(-)
 create mode 100644 block/io_uring.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 483edfbc0b..dc9da76b84 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2606,6 +2606,14 @@ F: block/file-posix.c
 F: block/file-win32.c
 F: block/win32-aio.c
=20
+Linux io_uring
+M: Aarushi Mehta <mehta.aaru20@gmail.com>
+M: Julia Suvorova <jusual@redhat.com>
+M: Stefan Hajnoczi <stefanha@redhat.com>
+L: qemu-block@nongnu.org
+S: Maintained
+F: block/io_uring.c
+
 qcow2
 M: Kevin Wolf <kwolf@redhat.com>
 M: Max Reitz <mreitz@redhat.com>
diff --git a/block/Makefile.objs b/block/Makefile.objs
index 330529b0b7..3bcb35c81d 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -18,6 +18,7 @@ block-obj-y +=3D block-backend.o snapshot.o qapi.o
 block-obj-$(CONFIG_WIN32) +=3D file-win32.o win32-aio.o
 block-obj-$(CONFIG_POSIX) +=3D file-posix.o
 block-obj-$(CONFIG_LINUX_AIO) +=3D linux-aio.o
+block-obj-$(CONFIG_LINUX_IO_URING) +=3D io_uring.o
 block-obj-y +=3D null.o mirror.o commit.o io.o create.o
 block-obj-y +=3D throttle-groups.o
 block-obj-$(CONFIG_LINUX) +=3D nvme.o
@@ -66,5 +67,7 @@ block-obj-$(if $(CONFIG_LZFSE),m,n) +=3D dmg-lzfse.o
 dmg-lzfse.o-libs   :=3D $(LZFSE_LIBS)
 qcow.o-libs        :=3D -lz
 linux-aio.o-libs   :=3D -laio
+io_uring.o-cflags  :=3D $(LINUX_IO_URING_CFLAGS)
+io_uring.o-libs    :=3D $(LINUX_IO_URING_LIBS)
 parallels.o-cflags :=3D $(LIBXML2_CFLAGS)
 parallels.o-libs   :=3D $(LIBXML2_LIBS)
diff --git a/block/io_uring.c b/block/io_uring.c
new file mode 100644
index 0000000000..bb433a685b
--- /dev/null
+++ b/block/io_uring.c
@@ -0,0 +1,401 @@
+/*
+ * Linux io_uring support.
+ *
+ * Copyright (C) 2009 IBM, Corp.
+ * Copyright (C) 2009 Red Hat, Inc.
+ * Copyright (C) 2019 Aarushi Mehta
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include <liburing.h>
+#include "qemu-common.h"
+#include "block/aio.h"
+#include "qemu/queue.h"
+#include "block/block.h"
+#include "block/raw-aio.h"
+#include "qemu/coroutine.h"
+#include "qapi/error.h"
+
+/* io_uring ring size */
+#define MAX_ENTRIES 128
+
+typedef struct LuringAIOCB {
+    Coroutine *co;
+    struct io_uring_sqe sqeq;
+    ssize_t ret;
+    QEMUIOVector *qiov;
+    bool is_read;
+    QSIMPLEQ_ENTRY(LuringAIOCB) next;
+
+    /*
+     * Buffered reads may require resubmission, see
+     * luring_resubmit_short_read().
+     */
+    int total_read;
+    QEMUIOVector resubmit_qiov;
+} LuringAIOCB;
+
+typedef struct LuringQueue {
+    int plugged;
+    unsigned int in_queue;
+    unsigned int in_flight;
+    bool blocked;
+    QSIMPLEQ_HEAD(, LuringAIOCB) submit_queue;
+} LuringQueue;
+
+typedef struct LuringState {
+    AioContext *aio_context;
+
+    struct io_uring ring;
+
+    /* io queue for submit at batch.  Protected by AioContext lock. */
+    LuringQueue io_q;
+
+    /* I/O completion processing.  Only runs in I/O thread.  */
+    QEMUBH *completion_bh;
+} LuringState;
+
+/**
+ * luring_resubmit:
+ *
+ * Resubmit a request by appending it to submit_queue.  The caller must en=
sure
+ * that ioq_submit() is called later so that submit_queue requests are sta=
rted.
+ */
+static void luring_resubmit(LuringState *s, LuringAIOCB *luringcb)
+{
+    QSIMPLEQ_INSERT_TAIL(&s->io_q.submit_queue, luringcb, next);
+    s->io_q.in_queue++;
+}
+
+/**
+ * luring_resubmit_short_read:
+ *
+ * Before Linux commit 9d93a3f5a0c ("io_uring: punt short reads to async
+ * context") a buffered I/O request with the start of the file range in th=
e
+ * page cache could result in a short read.  Applications need to resubmit=
 the
+ * remaining read request.
+ *
+ * This is a slow path but recent kernels never take it.
+ */
+static void luring_resubmit_short_read(LuringState *s, LuringAIOCB *luring=
cb,
+                                       int nread)
+{
+    QEMUIOVector *resubmit_qiov;
+    size_t remaining;
+
+    /* Update read position */
+    luringcb->total_read =3D nread;
+    remaining =3D luringcb->qiov->size - luringcb->total_read;
+
+    /* Shorten qiov */
+    resubmit_qiov =3D &luringcb->resubmit_qiov;
+    if (resubmit_qiov->iov =3D=3D NULL) {
+        qemu_iovec_init(resubmit_qiov, luringcb->qiov->niov);
+    } else {
+        qemu_iovec_reset(resubmit_qiov);
+    }
+    qemu_iovec_concat(resubmit_qiov, luringcb->qiov, luringcb->total_read,
+                      remaining);
+
+    /* Update sqe */
+    luringcb->sqeq.off =3D nread;
+    luringcb->sqeq.addr =3D (__u64)(uintptr_t)luringcb->resubmit_qiov.iov;
+    luringcb->sqeq.len =3D luringcb->resubmit_qiov.niov;
+
+    luring_resubmit(s, luringcb);
+}
+
+/**
+ * luring_process_completions:
+ * @s: AIO state
+ *
+ * Fetches completed I/O requests, consumes cqes and invokes their callbac=
ks
+ * The function is somewhat tricky because it supports nested event loops,=
 for
+ * example when a request callback invokes aio_poll().
+ *
+ * Function schedules BH completion so it  can be called again in a nested
+ * event loop.  When there are no events left  to complete the BH is being
+ * canceled.
+ *
+ */
+static void luring_process_completions(LuringState *s)
+{
+    struct io_uring_cqe *cqes;
+    int total_bytes;
+    /*
+     * Request completion callbacks can run the nested event loop.
+     * Schedule ourselves so the nested event loop will "see" remaining
+     * completed requests and process them.  Without this, completion
+     * callbacks that wait for other requests using a nested event loop
+     * would hang forever.
+     *
+     * This workaround is needed because io_uring uses poll_wait, which
+     * is woken up when new events are added to the uring, thus polling on
+     * the same uring fd will block unless more events are received.
+     *
+     * Other leaf block drivers (drivers that access the data themselves)
+     * are networking based, so they poll sockets for data and run the
+     * correct coroutine.
+     */
+    qemu_bh_schedule(s->completion_bh);
+
+    while (io_uring_peek_cqe(&s->ring, &cqes) =3D=3D 0) {
+        LuringAIOCB *luringcb;
+        int ret;
+
+        if (!cqes) {
+            break;
+        }
+
+        luringcb =3D io_uring_cqe_get_data(cqes);
+        ret =3D cqes->res;
+        io_uring_cqe_seen(&s->ring, cqes);
+        cqes =3D NULL;
+
+        /* Change counters one-by-one because we can be nested. */
+        s->io_q.in_flight--;
+
+        /* total_read is non-zero only for resubmitted read requests */
+        total_bytes =3D ret + luringcb->total_read;
+
+        if (ret < 0) {
+            if (ret =3D=3D -EINTR) {
+                luring_resubmit(s, luringcb);
+                continue;
+            }
+        } else if (!luringcb->qiov) {
+            goto end;
+        } else if (total_bytes =3D=3D luringcb->qiov->size) {
+            ret =3D 0;
+        /* Only read/write */
+        } else {
+            /* Short Read/Write */
+            if (luringcb->is_read) {
+                if (ret > 0) {
+                    luring_resubmit_short_read(s, luringcb, ret);
+                    continue;
+                } else {
+                    /* Pad with zeroes */
+                    qemu_iovec_memset(luringcb->qiov, total_bytes, 0,
+                                      luringcb->qiov->size - total_bytes);
+                    ret =3D 0;
+                }
+            } else {
+                ret =3D -ENOSPC;;
+            }
+        }
+end:
+        luringcb->ret =3D ret;
+        qemu_iovec_destroy(&luringcb->resubmit_qiov);
+
+        /*
+         * If the coroutine is already entered it must be in ioq_submit()
+         * and will notice luringcb->ret has been filled in when it
+         * eventually runs later. Coroutines cannot be entered recursively
+         * so avoid doing that!
+         */
+        if (!qemu_coroutine_entered(luringcb->co)) {
+            aio_co_wake(luringcb->co);
+        }
+    }
+    qemu_bh_cancel(s->completion_bh);
+}
+
+static int ioq_submit(LuringState *s)
+{
+    int ret =3D 0;
+    LuringAIOCB *luringcb, *luringcb_next;
+
+    while (s->io_q.in_queue > 0) {
+        /*
+         * Try to fetch sqes from the ring for requests waiting in
+         * the overflow queue
+         */
+        QSIMPLEQ_FOREACH_SAFE(luringcb, &s->io_q.submit_queue, next,
+                              luringcb_next) {
+            struct io_uring_sqe *sqes =3D io_uring_get_sqe(&s->ring);
+            if (!sqes) {
+                break;
+            }
+            /* Prep sqe for submission */
+            *sqes =3D luringcb->sqeq;
+            QSIMPLEQ_REMOVE_HEAD(&s->io_q.submit_queue, next);
+        }
+        ret =3D io_uring_submit(&s->ring);
+        /* Prevent infinite loop if submission is refused */
+        if (ret <=3D 0) {
+            if (ret =3D=3D -EAGAIN) {
+                continue;
+            }
+            break;
+        }
+        s->io_q.in_flight +=3D ret;
+        s->io_q.in_queue  -=3D ret;
+    }
+    s->io_q.blocked =3D (s->io_q.in_queue > 0);
+
+    if (s->io_q.in_flight) {
+        /*
+         * We can try to complete something just right away if there are
+         * still requests in-flight.
+         */
+        luring_process_completions(s);
+    }
+    return ret;
+}
+
+static void luring_process_completions_and_submit(LuringState *s)
+{
+    aio_context_acquire(s->aio_context);
+    luring_process_completions(s);
+
+    if (!s->io_q.plugged && s->io_q.in_queue > 0) {
+        ioq_submit(s);
+    }
+    aio_context_release(s->aio_context);
+}
+
+static void qemu_luring_completion_bh(void *opaque)
+{
+    LuringState *s =3D opaque;
+    luring_process_completions_and_submit(s);
+}
+
+static void qemu_luring_completion_cb(void *opaque)
+{
+    LuringState *s =3D opaque;
+    luring_process_completions_and_submit(s);
+}
+
+static void ioq_init(LuringQueue *io_q)
+{
+    QSIMPLEQ_INIT(&io_q->submit_queue);
+    io_q->plugged =3D 0;
+    io_q->in_queue =3D 0;
+    io_q->in_flight =3D 0;
+    io_q->blocked =3D false;
+}
+
+void luring_io_plug(BlockDriverState *bs, LuringState *s)
+{
+    s->io_q.plugged++;
+}
+
+void luring_io_unplug(BlockDriverState *bs, LuringState *s)
+{
+    assert(s->io_q.plugged);
+    if (--s->io_q.plugged =3D=3D 0 &&
+        !s->io_q.blocked && s->io_q.in_queue > 0) {
+        ioq_submit(s);
+    }
+}
+
+/**
+ * luring_do_submit:
+ * @fd: file descriptor for I/O
+ * @luringcb: AIO control block
+ * @s: AIO state
+ * @offset: offset for request
+ * @type: type of request
+ *
+ * Fetches sqes from ring, adds to pending queue and preps them
+ *
+ */
+static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState *s,
+                            uint64_t offset, int type)
+{
+    struct io_uring_sqe *sqes =3D &luringcb->sqeq;
+
+    switch (type) {
+    case QEMU_AIO_WRITE:
+        io_uring_prep_writev(sqes, fd, luringcb->qiov->iov,
+                             luringcb->qiov->niov, offset);
+        break;
+    case QEMU_AIO_READ:
+        io_uring_prep_readv(sqes, fd, luringcb->qiov->iov,
+                            luringcb->qiov->niov, offset);
+        break;
+    case QEMU_AIO_FLUSH:
+        io_uring_prep_fsync(sqes, fd, IORING_FSYNC_DATASYNC);
+        break;
+    default:
+        fprintf(stderr, "%s: invalid AIO request type, aborting 0x%x.\n",
+                        __func__, type);
+        abort();
+    }
+    io_uring_sqe_set_data(sqes, luringcb);
+
+    QSIMPLEQ_INSERT_TAIL(&s->io_q.submit_queue, luringcb, next);
+    s->io_q.in_queue++;
+
+    if (!s->io_q.blocked &&
+        (!s->io_q.plugged ||
+         s->io_q.in_flight + s->io_q.in_queue >=3D MAX_ENTRIES)) {
+        return ioq_submit(s);
+    }
+    return 0;
+}
+
+int coroutine_fn luring_co_submit(BlockDriverState *bs, LuringState *s, in=
t fd,
+                                  uint64_t offset, QEMUIOVector *qiov, int=
 type)
+{
+    int ret;
+    LuringAIOCB luringcb =3D {
+        .co         =3D qemu_coroutine_self(),
+        .ret        =3D -EINPROGRESS,
+        .qiov       =3D qiov,
+        .is_read    =3D (type =3D=3D QEMU_AIO_READ),
+    };
+
+    ret =3D luring_do_submit(fd, &luringcb, s, offset, type);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (luringcb.ret =3D=3D -EINPROGRESS) {
+        qemu_coroutine_yield();
+    }
+    return luringcb.ret;
+}
+
+void luring_detach_aio_context(LuringState *s, AioContext *old_context)
+{
+    aio_set_fd_handler(old_context, s->ring.ring_fd, false, NULL, NULL, NU=
LL,
+                       s);
+    qemu_bh_delete(s->completion_bh);
+    s->aio_context =3D NULL;
+}
+
+void luring_attach_aio_context(LuringState *s, AioContext *new_context)
+{
+    s->aio_context =3D new_context;
+    s->completion_bh =3D aio_bh_new(new_context, qemu_luring_completion_bh=
, s);
+    aio_set_fd_handler(s->aio_context, s->ring.ring_fd, false,
+                       qemu_luring_completion_cb, NULL, NULL, s);
+}
+
+LuringState *luring_init(Error **errp)
+{
+    int rc;
+    LuringState *s =3D g_new0(LuringState, 1);
+    struct io_uring *ring =3D &s->ring;
+
+    rc =3D io_uring_queue_init(MAX_ENTRIES, ring, 0);
+    if (rc < 0) {
+        error_setg_errno(errp, errno, "failed to init linux io_uring ring"=
);
+        g_free(s);
+        return NULL;
+    }
+
+    ioq_init(&s->io_q);
+    return s;
+
+}
+
+void luring_cleanup(LuringState *s)
+{
+    io_uring_queue_exit(&s->ring);
+    g_free(s);
+}
diff --git a/include/block/aio.h b/include/block/aio.h
index 6b0d52f732..7ba9bd7874 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -49,6 +49,7 @@ typedef void IOHandler(void *opaque);
 struct Coroutine;
 struct ThreadPool;
 struct LinuxAioState;
+struct LuringState;
=20
 struct AioContext {
     GSource source;
@@ -117,11 +118,19 @@ struct AioContext {
     struct ThreadPool *thread_pool;
=20
 #ifdef CONFIG_LINUX_AIO
-    /* State for native Linux AIO.  Uses aio_context_acquire/release for
+    /*
+     * State for native Linux AIO.  Uses aio_context_acquire/release for
      * locking.
      */
     struct LinuxAioState *linux_aio;
 #endif
+#ifdef CONFIG_LINUX_IO_URING
+    /*
+     * State for Linux io_uring.  Uses aio_context_acquire/release for
+     * locking.
+     */
+    struct LuringState *linux_io_uring;
+#endif
=20
     /* TimerLists for calling timers - one per clock type.  Has its own
      * locking.
@@ -386,6 +395,11 @@ struct LinuxAioState *aio_setup_linux_aio(AioContext *=
ctx, Error **errp);
 /* Return the LinuxAioState bound to this AioContext */
 struct LinuxAioState *aio_get_linux_aio(AioContext *ctx);
=20
+/* Setup the LuringState bound to this AioContext */
+struct LuringState *aio_setup_linux_io_uring(AioContext *ctx, Error **errp=
);
+
+/* Return the LuringState bound to this AioContext */
+struct LuringState *aio_get_linux_io_uring(AioContext *ctx);
 /**
  * aio_timer_new_with_attrs:
  * @ctx: the aio context
diff --git a/include/block/raw-aio.h b/include/block/raw-aio.h
index 4629f24d08..251b10d273 100644
--- a/include/block/raw-aio.h
+++ b/include/block/raw-aio.h
@@ -57,6 +57,18 @@ void laio_attach_aio_context(LinuxAioState *s, AioContex=
t *new_context);
 void laio_io_plug(BlockDriverState *bs, LinuxAioState *s);
 void laio_io_unplug(BlockDriverState *bs, LinuxAioState *s);
 #endif
+/* io_uring.c - Linux io_uring implementation */
+#ifdef CONFIG_LINUX_IO_URING
+typedef struct LuringState LuringState;
+LuringState *luring_init(Error **errp);
+void luring_cleanup(LuringState *s);
+int coroutine_fn luring_co_submit(BlockDriverState *bs, LuringState *s, in=
t fd,
+                                uint64_t offset, QEMUIOVector *qiov, int t=
ype);
+void luring_detach_aio_context(LuringState *s, AioContext *old_context);
+void luring_attach_aio_context(LuringState *s, AioContext *new_context);
+void luring_io_plug(BlockDriverState *bs, LuringState *s);
+void luring_io_unplug(BlockDriverState *bs, LuringState *s);
+#endif
=20
 #ifdef _WIN32
 typedef struct QEMUWin32AIOState QEMUWin32AIOState;
--=20
2.24.1


