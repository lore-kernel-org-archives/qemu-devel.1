Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B2CC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 12:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19917206BB
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 12:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19917206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHS1O-0003yG-OS
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 08:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iHRqt-0002JC-BI
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 08:11:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iHRqr-0004lJ-Uu
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 08:10:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49112)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1iHRqo-0004c0-VQ; Mon, 07 Oct 2019 08:10:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 76F3BA44AC2;
 Mon,  7 Oct 2019 12:10:53 +0000 (UTC)
Received: from localhost (unknown [10.36.118.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 376B55D9CC;
 Mon,  7 Oct 2019 12:10:43 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/16] block: add trace events for io_uring
Date: Mon,  7 Oct 2019 13:09:30 +0100
Message-Id: <20191007120937.5862-10-stefanha@redhat.com>
In-Reply-To: <20191007120937.5862-1-stefanha@redhat.com>
References: <20191007120937.5862-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Mon, 07 Oct 2019 12:10:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: oleksandr@redhat.com, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Julia Suvorova <jusual@mail.ru>, Julia Suvorova <jusual@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aarushi Mehta <mehta.aaru20@gmail.com>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io_uring.c   | 21 ++++++++++++++++++---
 block/trace-events | 12 ++++++++++++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/block/io_uring.c b/block/io_uring.c
index 307c4c5823..a5c0d16220 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -17,6 +17,7 @@
 #include "block/raw-aio.h"
 #include "qemu/coroutine.h"
 #include "qapi/error.h"
+#include "trace.h"
=20
 /* io_uring ring size */
 #define MAX_ENTRIES 128
@@ -85,6 +86,8 @@ static void luring_resubmit_short_read(LuringState *s, =
LuringAIOCB *luringcb,
     QEMUIOVector *resubmit_qiov;
     size_t remaining;
=20
+    trace_luring_resubmit_short_read(s, luringcb, nread);
+
     /* Update read position */
     luringcb->total_read =3D nread;
     remaining =3D luringcb->qiov->size - luringcb->total_read;
@@ -156,6 +159,7 @@ static void luring_process_completions(LuringState *s=
)
=20
         /* Change counters one-by-one because we can be nested. */
         s->io_q.in_flight--;
+        trace_luring_process_completion(s, luringcb, ret);
=20
         /* total_read is non-zero only for resubmitted read requests */
         total_bytes =3D ret + luringcb->total_read;
@@ -224,6 +228,7 @@ static int ioq_submit(LuringState *s)
             QSIMPLEQ_REMOVE_HEAD(&s->io_q.submit_queue, next);
         }
         ret =3D io_uring_submit(&s->ring);
+        trace_luring_io_uring_submit(s, ret);
         /* Prevent infinite loop if submission is refused */
         if (ret <=3D 0) {
             if (ret =3D=3D -EAGAIN) {
@@ -280,12 +285,15 @@ static void ioq_init(LuringQueue *io_q)
=20
 void luring_io_plug(BlockDriverState *bs, LuringState *s)
 {
+    trace_luring_io_plug(s);
     s->io_q.plugged++;
 }
=20
 void luring_io_unplug(BlockDriverState *bs, LuringState *s)
 {
     assert(s->io_q.plugged);
+    trace_luring_io_unplug(s, s->io_q.blocked, s->io_q.plugged,
+                           s->io_q.in_queue, s->io_q.in_flight);
     if (--s->io_q.plugged =3D=3D 0 &&
         !s->io_q.blocked && s->io_q.in_queue > 0) {
         ioq_submit(s);
@@ -306,6 +314,7 @@ void luring_io_unplug(BlockDriverState *bs, LuringSta=
te *s)
 static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState *=
s,
                             uint64_t offset, int type)
 {
+    int ret;
     struct io_uring_sqe *sqes =3D &luringcb->sqeq;
=20
     switch (type) {
@@ -329,11 +338,14 @@ static int luring_do_submit(int fd, LuringAIOCB *lu=
ringcb, LuringState *s,
=20
     QSIMPLEQ_INSERT_TAIL(&s->io_q.submit_queue, luringcb, next);
     s->io_q.in_queue++;
-
+    trace_luring_do_submit(s, s->io_q.blocked, s->io_q.plugged,
+                           s->io_q.in_queue, s->io_q.in_flight);
     if (!s->io_q.blocked &&
         (!s->io_q.plugged ||
          s->io_q.in_flight + s->io_q.in_queue >=3D MAX_ENTRIES)) {
-        return ioq_submit(s);
+        ret =3D ioq_submit(s);
+        trace_luring_do_submit_done(s, ret);
+        return ret;
     }
     return 0;
 }
@@ -348,8 +360,10 @@ int coroutine_fn luring_co_submit(BlockDriverState *=
bs, LuringState *s, int fd,
         .qiov       =3D qiov,
         .is_read    =3D (type =3D=3D QEMU_AIO_READ),
     };
-
+    trace_luring_co_submit(bs, s, &luringcb, fd, offset, qiov ? qiov->si=
ze : 0,
+                           type);
     ret =3D luring_do_submit(fd, &luringcb, s, offset, type);
+
     if (ret < 0) {
         return ret;
     }
@@ -400,4 +414,5 @@ void luring_cleanup(LuringState *s)
 {
     io_uring_queue_exit(&s->ring);
     g_free(s);
+    trace_luring_cleanup_state(s);
 }
diff --git a/block/trace-events b/block/trace-events
index 04209f058d..2e3a9851b6 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -61,6 +61,18 @@ qmp_block_stream(void *bs) "bs %p"
 file_paio_submit(void *acb, void *opaque, int64_t offset, int count, int=
 type) "acb %p opaque %p offset %"PRId64" count %d type %d"
 file_copy_file_range(void *bs, int src, int64_t src_off, int dst, int64_=
t dst_off, int64_t bytes, int flags, int64_t ret) "bs %p src_fd %d offset=
 %"PRIu64" dst_fd %d offset %"PRIu64" bytes %"PRIu64" flags %d ret %"PRId=
64
=20
+#io_uring.c
+luring_init_state(void *s, size_t size) "s %p size %zu"
+luring_cleanup_state(void *s) "%p freed"
+luring_io_plug(void *s) "LuringState %p plug"
+luring_io_unplug(void *s, int blocked, int plugged, int queued, int infl=
ight) "LuringState %p blocked %d plugged %d queued %d inflight %d"
+luring_do_submit(void *s, int blocked, int plugged, int queued, int infl=
ight) "LuringState %p blocked %d plugged %d queued %d inflight %d"
+luring_do_submit_done(void *s, int ret) "LuringState %p submitted to ker=
nel %d"
+luring_co_submit(void *bs, void *s, void *luringcb, int fd, uint64_t off=
set, size_t nbytes, int type) "bs %p s %p luringcb %p fd %d offset %" PRI=
d64 " nbytes %zd type %d"
+luring_process_completion(void *s, void *aiocb, int ret) "LuringState %p=
 luringcb %p ret %d"
+luring_io_uring_submit(void *s, int ret) "LuringState %p ret %d"
+luring_resubmit_short_read(void *s, void *luringcb, int nread) "LuringSt=
ate %p luringcb %p nread %d"
+
 # qcow2.c
 qcow2_writev_start_req(void *co, int64_t offset, int bytes) "co %p offse=
t 0x%" PRIx64 " bytes %d"
 qcow2_writev_done_req(void *co, int ret) "co %p ret %d"
--=20
2.21.0


