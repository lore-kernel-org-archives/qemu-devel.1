Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0080BC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 20:20:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D161520665
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 20:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D161520665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn7ST-0005uB-S2
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 16:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55260)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hn7SB-0004sD-G4
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 16:20:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hn7SA-0007RY-FJ
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 16:20:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47034)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1hn7S8-0007Pm-AU; Mon, 15 Jul 2019 16:20:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A463CC00C7DD;
 Mon, 15 Jul 2019 20:20:03 +0000 (UTC)
Received: from localhost (ovpn-117-120.ams2.redhat.com [10.36.117.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7590A1001B35;
 Mon, 15 Jul 2019 20:19:58 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 21:19:48 +0100
Message-Id: <20190715201950.9444-2-stefanha@redhat.com>
In-Reply-To: <20190715201950.9444-1-stefanha@redhat.com>
References: <20190715201950.9444-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 15 Jul 2019 20:20:03 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/3] block/io_uring: add submission and
 completion trace events
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

It is useful to follow individual requests as they are submitted.  Add
trace events that show details of each request.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io_uring.c   | 5 +++++
 block/trace-events | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/block/io_uring.c b/block/io_uring.c
index 22e8d3d9ca..19919da4c9 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -128,6 +128,8 @@ static void luring_process_completions(LuringState *s=
)
         LuringAIOCB *luringcb =3D io_uring_cqe_get_data(cqes);
         ret =3D cqes->res;
=20
+        trace_luring_process_completion(s, luringcb, ret);
+
         if (ret =3D=3D luringcb->qiov->size) {
             ret =3D 0;
         } else if (ret >=3D 0) {
@@ -233,6 +235,7 @@ static int ioq_submit(LuringState *s)
             QSIMPLEQ_REMOVE_HEAD(&s->io_q.sq_overflow, next);
         }
         ret =3D io_uring_submit(&s->ring);
+        trace_luring_io_uring_submit(s, ret);
         /* Prevent infinite loop if submission is refused */
         if (ret <=3D 0) {
             if (ret =3D=3D -EAGAIN) {
@@ -339,6 +342,8 @@ int coroutine_fn luring_co_submit(BlockDriverState *b=
s, LuringState *s, int fd,
         .is_read    =3D (type =3D=3D QEMU_AIO_READ),
     };
=20
+    trace_luring_co_submit(bs, s, &luringcb, fd, offset, qiov ? qiov->si=
ze : 0, type);
+
     ret =3D luring_do_submit(fd, &luringcb, s, offset, type);
     if (ret < 0) {
         return ret;
diff --git a/block/trace-events b/block/trace-events
index 069779773b..02952fe4cb 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -67,6 +67,9 @@ luring_io_plug(void *s) "LuringState %p plug"
 luring_io_unplug(void *s, int blocked, int plugged, int queued, int infl=
ight) "LuringState %p blocked %d plugged %d queued %d inflight %d"
 luring_do_submit(void *s, int blocked, int plugged, int queued, int infl=
ight) "LuringState %p blocked %d plugged %d queued %d inflight %d"
 luring_do_submit_done(void *s, int ret) "LuringState %p submitted to ker=
nel %d"
+luring_co_submit(void *bs, void *s, void *luringcb, int fd, uint64_t off=
set, size_t nbytes, int type) "bs %p s %p luringcb %p fd %d offset %" PRI=
d64 " nbytes %zd type %d"
+luring_process_completion(void *s, void *aiocb, int ret) "LuringState %p=
 luringcb %p ret %d"
+luring_io_uring_submit(void *s, int ret) "LuringState %p ret %d"
=20
 # qcow2.c
 qcow2_writev_start_req(void *co, int64_t offset, int bytes) "co %p offse=
t 0x%" PRIx64 " bytes %d"
--=20
2.21.0


