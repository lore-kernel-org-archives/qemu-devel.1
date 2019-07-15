Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D48BC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 20:20:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6581B20665
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 20:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6581B20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn7Sn-0007NR-Ki
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 16:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55350)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hn7SQ-0005yH-ND
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 16:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hn7SP-0007hz-BJ
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 16:20:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44642)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1hn7SM-0007co-93; Mon, 15 Jul 2019 16:20:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9514983E;
 Mon, 15 Jul 2019 20:20:17 +0000 (UTC)
Received: from localhost (ovpn-117-120.ams2.redhat.com [10.36.117.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A9DF5B681;
 Mon, 15 Jul 2019 20:20:12 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 21:19:50 +0100
Message-Id: <20190715201950.9444-4-stefanha@redhat.com>
In-Reply-To: <20190715201950.9444-1-stefanha@redhat.com>
References: <20190715201950.9444-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 15 Jul 2019 20:20:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/3] block/io_uring: resubmit short buffered
 reads
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The io_uring API had unusual read behavior up until recently, where
short reads could occur when the start of the file range was in the page
cache and a later portion was not in the page cache.  Normally read(2)
does not expose this detail to applications and this behavior has been
fixed in Linux commit 9d93a3f5a0c ("io_uring: punt short reads to async
* context").

In the meantime Linux distros have shipped kernels where io_uring
exhibits the old behavior and there is no simple way to detect it.

Add a slow path for resubmitting short read requests.  The idea is
simple: shorten the iovecs and increment the file offset each time a
short read occurs and then resubmit the request.  The implementation
requires adding additional fields to LuringAIOCB to keep track of where
we were.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io_uring.c   | 75 +++++++++++++++++++++++++++++++++++++++-------
 block/trace-events |  3 +-
 2 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/block/io_uring.c b/block/io_uring.c
index 97e4f876d7..12cef71175 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -28,6 +28,12 @@ typedef struct LuringAIOCB {
     QEMUIOVector *qiov;
     bool is_read;
     QSIMPLEQ_ENTRY(LuringAIOCB) next;
+
+    /* Buffered reads may require resubmission, see
+     * luring_resubmit_short_read().
+     */
+    int total_read;
+    QEMUIOVector resubmit_qiov;
 } LuringAIOCB;
=20
 typedef struct LuringQueue {
@@ -99,6 +105,43 @@ static void luring_resubmit(LuringState *s, LuringAIO=
CB *luringcb)
     s->io_q.in_queue++;
 }
=20
+/* Before Linux commit 9d93a3f5a0c ("io_uring: punt short reads to async
+ * context") a buffered I/O request with the start of the file range in =
the
+ * page cache could result in a short read.  Applications need to resubm=
it the
+ * remaining read request.
+ *
+ * This is a slow path but recent kernels never take it.
+ */
+static void luring_resubmit_short_read(LuringState *s, LuringAIOCB *luri=
ngcb,
+                                       int nread)
+{
+    QEMUIOVector *resubmit_qiov;
+    size_t remaining;
+
+    trace_luring_resubmit_short_read(s, luringcb, nread);
+
+    /* Update read position */
+    luringcb->total_read +=3D nread;
+    remaining =3D luringcb->qiov->size - luringcb->total_read;
+
+    /* Shorten qiov */
+    resubmit_qiov =3D &luringcb->resubmit_qiov;
+    if (resubmit_qiov->iov =3D=3D NULL) {
+        qemu_iovec_init(resubmit_qiov, luringcb->qiov->niov);
+    } else {
+        qemu_iovec_reset(resubmit_qiov);
+    }
+    qemu_iovec_concat(resubmit_qiov, luringcb->qiov, luringcb->total_rea=
d,
+                      remaining);
+
+    /* Update sqe */
+    luringcb->sqeq.off +=3D nread;
+    luringcb->sqeq.addr =3D (__u64)(uintptr_t)luringcb->resubmit_qiov.io=
v;
+    luringcb->sqeq.len =3D luringcb->resubmit_qiov.niov;
+
+    luring_resubmit(s, luringcb);
+}
+
 /**
  * luring_process_completions:
  * @s: AIO state
@@ -135,6 +178,7 @@ static void luring_process_completions(LuringState *s=
)
     while (io_uring_peek_cqe(&s->ring, &cqes) =3D=3D 0) {
         LuringAIOCB *luringcb;
         int ret;
+        int total_bytes;
=20
         if (!cqes) {
             break;
@@ -150,25 +194,36 @@ static void luring_process_completions(LuringState =
*s)
=20
         trace_luring_process_completion(s, luringcb, ret);
=20
-        if (ret =3D=3D luringcb->qiov->size) {
+        /* total_read is non-zero only for resubmitted read requests */
+        total_bytes =3D ret + luringcb->total_read;
+
+        if (ret < 0) {
+            if (ret =3D=3D -EINTR) {
+                luring_resubmit(s, luringcb);
+                continue;
+            }
+        } else if (total_bytes =3D=3D luringcb->qiov->size) {
             ret =3D 0;
-        } else if (ret >=3D 0) {
+        } else {
             /* Short Read/Write */
             if (luringcb->is_read) {
-                /* Read, pad with zeroes */
-                qemu_iovec_memset(luringcb->qiov, ret, 0,
-                luringcb->qiov->size - ret);
-                ret =3D 0;
+                if (ret > 0) {
+                    luring_resubmit_short_read(s, luringcb, ret);
+                    continue;
+                } else {
+                    /* Pad with zeroes */
+                    qemu_iovec_memset(luringcb->qiov, total_bytes, 0,
+                                      luringcb->qiov->size - total_bytes=
);
+                    ret =3D 0;
+                }
             } else {
                 ret =3D -ENOSPC;;
             }
-        /* Add to overflow queue to be resubmitted later */
-        } else if (ret =3D=3D -EINTR) {
-            luring_resubmit(s, luringcb);
-            continue;
         }
         luringcb->ret =3D ret;
=20
+        qemu_iovec_destroy(&luringcb->resubmit_qiov);
+
         /*
          * If the coroutine is already entered it must be in ioq_submit(=
)
          * and will notice luringcb->ret has been filled in when it
diff --git a/block/trace-events b/block/trace-events
index 02952fe4cb..f434cac634 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -60,7 +60,7 @@ qmp_block_stream(void *bs) "bs %p"
 file_paio_submit(void *acb, void *opaque, int64_t offset, int count, int=
 type) "acb %p opaque %p offset %"PRId64" count %d type %d"
 file_copy_file_range(void *bs, int src, int64_t src_off, int dst, int64_=
t dst_off, int64_t bytes, int flags, int64_t ret) "bs %p src_fd %d offset=
 %"PRIu64" dst_fd %d offset %"PRIu64" bytes %"PRIu64" flags %d ret %"PRId=
64
=20
-#io_uring.c
+# io_uring.c
 luring_init_state(void *s, size_t size) "s %p size %zu"
 luring_cleanup_state(void *s) "%p freed"
 luring_io_plug(void *s) "LuringState %p plug"
@@ -70,6 +70,7 @@ luring_do_submit_done(void *s, int ret) "LuringState %p=
 submitted to kernel %d"
 luring_co_submit(void *bs, void *s, void *luringcb, int fd, uint64_t off=
set, size_t nbytes, int type) "bs %p s %p luringcb %p fd %d offset %" PRI=
d64 " nbytes %zd type %d"
 luring_process_completion(void *s, void *aiocb, int ret) "LuringState %p=
 luringcb %p ret %d"
 luring_io_uring_submit(void *s, int ret) "LuringState %p ret %d"
+luring_resubmit_short_read(void *s, void *luringcb, int nread) "LuringSt=
ate %p luringcb %p nread %d"
=20
 # qcow2.c
 qcow2_writev_start_req(void *co, int64_t offset, int bytes) "co %p offse=
t 0x%" PRIx64 " bytes %d"
--=20
2.21.0


