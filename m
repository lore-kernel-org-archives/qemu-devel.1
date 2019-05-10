Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A3EC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:07:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7E632173B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E632173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43013 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP5F4-0007nK-U8
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 09:07:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hP5BE-0004XE-1Q
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:03:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hP5BC-0004ab-Sm
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:03:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>)
	id 1hP5B8-0004Ve-LB; Fri, 10 May 2019 09:03:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E8F9B30254A1;
	Fri, 10 May 2019 13:03:09 +0000 (UTC)
Received: from localhost (ovpn-116-89.ams2.redhat.com [10.36.116.89])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9D40F60126;
	Fri, 10 May 2019 13:03:06 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 14:02:41 +0100
Message-Id: <20190510130243.8887-7-stefanha@redhat.com>
In-Reply-To: <20190510130243.8887-1-stefanha@redhat.com>
References: <20190510130243.8887-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Fri, 10 May 2019 13:03:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 6/8] aio-posix: ensure poll mode is left when
 aio_notify is called
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
	Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
	Stefan Hajnoczi <stefanha@gmail.com>, Max Reitz <mreitz@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

With aio=3Dthread, adaptive polling makes latency worse rather than
better, because it delays the execution of the ThreadPool's
completion bottom half.

event_notifier_poll() does run while polling, detecting that
a bottom half was scheduled by a worker thread, but because
ctx->notifier is explicitly ignored in run_poll_handlers_once(),
scheduling the BH does not count as making progress and
run_poll_handlers() keeps running.  Fix this by recomputing
the deadline after *timeout could have changed.

With this change, ThreadPool still cannot participate in polling
but at least it does not suffer from extra latency.

Reported-by: Sergio Lopez <slp@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20190409122823.12416-1-pbonzini@redhat.com
Cc: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1553692145-86728-1-git-send-email-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20190409122823.12416-1-pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/aio-posix.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 6fbfa7924f..db11021287 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -519,6 +519,10 @@ static bool run_poll_handlers_once(AioContext *ctx, =
int64_t *timeout)
         if (!node->deleted && node->io_poll &&
             aio_node_check(ctx, node->is_external) &&
             node->io_poll(node->opaque)) {
+            /*
+             * Polling was successful, exit try_poll_mode immediately
+             * to adjust the next polling time.
+             */
             *timeout =3D 0;
             if (node->opaque !=3D &ctx->notifier) {
                 progress =3D true;
@@ -558,8 +562,9 @@ static bool run_poll_handlers(AioContext *ctx, int64_=
t max_ns, int64_t *timeout)
     do {
         progress =3D run_poll_handlers_once(ctx, timeout);
         elapsed_time =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start_=
time;
-    } while (!progress && elapsed_time < max_ns
-             && !atomic_read(&ctx->poll_disable_cnt));
+        max_ns =3D qemu_soonest_timeout(*timeout, max_ns);
+        assert(!(max_ns && progress));
+    } while (elapsed_time < max_ns && !atomic_read(&ctx->poll_disable_cn=
t));
=20
     /* If time has passed with no successful polling, adjust *timeout to
      * keep the same ending time.
@@ -585,8 +590,7 @@ static bool run_poll_handlers(AioContext *ctx, int64_=
t max_ns, int64_t *timeout)
  */
 static bool try_poll_mode(AioContext *ctx, int64_t *timeout)
 {
-    /* See qemu_soonest_timeout() uint64_t hack */
-    int64_t max_ns =3D MIN((uint64_t)*timeout, (uint64_t)ctx->poll_ns);
+    int64_t max_ns =3D qemu_soonest_timeout(*timeout, ctx->poll_ns);
=20
     if (max_ns && !atomic_read(&ctx->poll_disable_cnt)) {
         poll_set_started(ctx, true);
--=20
2.21.0


