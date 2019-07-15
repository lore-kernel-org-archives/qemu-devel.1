Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AF6C76197
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 20:20:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E03420665
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 20:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E03420665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn7So-0007RQ-AK
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 16:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55317)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hn7SK-0005Wa-Sf
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 16:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hn7SJ-0007ax-GW
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 16:20:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51678)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1hn7SG-0007Xn-Sk; Mon, 15 Jul 2019 16:20:13 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D39EB85360;
 Mon, 15 Jul 2019 20:20:10 +0000 (UTC)
Received: from localhost (ovpn-117-120.ams2.redhat.com [10.36.117.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CDCE819C59;
 Mon, 15 Jul 2019 20:20:04 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 21:19:49 +0100
Message-Id: <20190715201950.9444-3-stefanha@redhat.com>
In-Reply-To: <20190715201950.9444-1-stefanha@redhat.com>
References: <20190715201950.9444-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Mon, 15 Jul 2019 20:20:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/3] block/io_uring: fix EINTR request
 resubmission
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

Adding the request to sq_overflow isn't enough:
1. luringcb->sqeq is uninitialized if there was space in the sq ring at
   submission time.
2. Not all code paths invoke ioq_submit() after processing completions,
   so the request could hang.

Additional bugs include checking for EINTR instead of -EINTR and
forgetting to skip the completion callback when a request is
resubmitted.

Fix this by always initializing luringcb->sqeq and ensuring that all
code paths invoke ioq_submit() after appending to sq_overflow.  Ensure
that luring_process_completions() marks the cqe seen and decrements
in_flight before resubmitting the request.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io_uring.c | 64 ++++++++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/block/io_uring.c b/block/io_uring.c
index 19919da4c9..97e4f876d7 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -87,6 +87,18 @@ int luring_register_fd(LuringState *s, unsigned int fd=
)
                              s->fd.head, s->fd.size);
 }
=20
+/**
+ * luring_resubmit:
+ *
+ * Resubmit a request by appending it to sq_overflow.  The caller must e=
nsure
+ * that ioq_submit() is called later so that sq_overflow requests are st=
arted.
+ */
+static void luring_resubmit(LuringState *s, LuringAIOCB *luringcb)
+{
+    QSIMPLEQ_INSERT_TAIL(&s->io_q.sq_overflow, luringcb, next);
+    s->io_q.in_queue++;
+}
+
 /**
  * luring_process_completions:
  * @s: AIO state
@@ -102,7 +114,6 @@ int luring_register_fd(LuringState *s, unsigned int f=
d)
 static void luring_process_completions(LuringState *s)
 {
     struct io_uring_cqe *cqes;
-    int ret;
=20
     /*
      * Request completion callbacks can run the nested event loop.
@@ -122,11 +133,20 @@ static void luring_process_completions(LuringState =
*s)
     qemu_bh_schedule(s->completion_bh);
=20
     while (io_uring_peek_cqe(&s->ring, &cqes) =3D=3D 0) {
+        LuringAIOCB *luringcb;
+        int ret;
+
         if (!cqes) {
             break;
         }
-        LuringAIOCB *luringcb =3D io_uring_cqe_get_data(cqes);
+
+        luringcb =3D io_uring_cqe_get_data(cqes);
         ret =3D cqes->res;
+        io_uring_cqe_seen(&s->ring, cqes);
+        cqes =3D NULL;
+
+        /* Change counters one-by-one because we can be nested. */
+        s->io_q.in_flight--;
=20
         trace_luring_process_completion(s, luringcb, ret);
=20
@@ -143,17 +163,12 @@ static void luring_process_completions(LuringState =
*s)
                 ret =3D -ENOSPC;;
             }
         /* Add to overflow queue to be resubmitted later */
-        } else if (ret =3D=3D EINTR) {
-            QSIMPLEQ_INSERT_TAIL(&s->io_q.sq_overflow, luringcb, next);
+        } else if (ret =3D=3D -EINTR) {
+            luring_resubmit(s, luringcb);
+            continue;
         }
         luringcb->ret =3D ret;
=20
-
-        io_uring_cqe_seen(&s->ring, cqes);
-        cqes =3D NULL;
-        /* Change counters one-by-one because we can be nested. */
-        s->io_q.in_flight--;
-
         /*
          * If the coroutine is already entered it must be in ioq_submit(=
)
          * and will notice luringcb->ret has been filled in when it
@@ -245,16 +260,16 @@ static int ioq_submit(LuringState *s)
         }
         s->io_q.in_flight +=3D ret;
         s->io_q.in_queue  -=3D ret;
+
+        if (s->io_q.in_flight) {
+            /*
+             * We can try to complete something just right away if there=
 are
+             * still requests in-flight.
+             */
+            luring_process_completions(s);
+        }
     }
     s->io_q.blocked =3D (s->io_q.in_queue > 0);
-
-    if (s->io_q.in_flight) {
-        /*
-         * We can try to complete something just right away if there are
-         * still requests in-flight.
-         */
-        luring_process_completions(s);
-    }
     return ret;
 }
=20
@@ -290,15 +305,7 @@ static int luring_do_submit(int fd, LuringAIOCB *lur=
ingcb, LuringState *s,
                             uint64_t offset, int type)
 {
     int ret;
-    struct io_uring_sqe *sqes =3D io_uring_get_sqe(&s->ring);
-    /*=20
-     *If the ring is full and cannot fetch new sqes, add the request to
-     * to an overflow queue to be submitted later
-     */
-    if (!sqes) {
-        sqes =3D &luringcb->sqeq;
-        QSIMPLEQ_INSERT_TAIL(&s->io_q.sq_overflow, luringcb, next);
-    }
+    struct io_uring_sqe *sqes =3D &luringcb->sqeq;
=20
     switch (type) {
     case QEMU_AIO_WRITE:
@@ -318,7 +325,10 @@ static int luring_do_submit(int fd, LuringAIOCB *lur=
ingcb, LuringState *s,
         abort();
     }
     io_uring_sqe_set_data(sqes, luringcb);
+
+    QSIMPLEQ_INSERT_TAIL(&s->io_q.sq_overflow, luringcb, next);
     s->io_q.in_queue++;
+
     trace_luring_do_submit(s, s->io_q.blocked, s->io_q.plugged,
                            s->io_q.in_queue, s->io_q.in_flight);
     if (!s->io_q.blocked &&
--=20
2.21.0


