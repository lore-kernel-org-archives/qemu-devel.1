Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064C1C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 15:55:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC6682089E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 15:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC6682089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0pQT-0004RG-Ub
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 11:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i0pOx-0002nU-Nr
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 11:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i0pOw-0003nJ-Kh
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 11:53:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54908)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1i0pOu-0003kd-AW; Thu, 22 Aug 2019 11:53:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9BB332BFDC;
 Thu, 22 Aug 2019 15:53:23 +0000 (UTC)
Received: from localhost (ovpn-116-61.ams2.redhat.com [10.36.116.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D66E5D772;
 Thu, 22 Aug 2019 15:53:15 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 16:53:01 +0100
Message-Id: <20190822155302.20916-2-stefanha@redhat.com>
In-Reply-To: <20190822155302.20916-1-stefanha@redhat.com>
References: <20190822155302.20916-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 22 Aug 2019 15:53:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/2] util/async: hold AioContext ref to prevent
 use-after-free
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The tests/test-bdrv-drain /bdrv-drain/iothread/drain test case does the
following:

1. The preadv coroutine calls aio_bh_schedule_oneshot() and then yields.
2. The one-shot BH executes in another AioContext.  All it does is call
   aio_co_wakeup(preadv_co).
3. The preadv coroutine is re-entered and returns.

There is a race condition in aio_co_wake() where the preadv coroutine
returns and the test case destroys the preadv IOThread.  aio_co_wake()
can still be running in the other AioContext and it performs an access
to the freed IOThread AioContext.

Here is the race in aio_co_schedule():

  QSLIST_INSERT_HEAD_ATOMIC(&ctx->scheduled_coroutines,
                            co, co_scheduled_next);
  <-- race: co may execute before we invoke qemu_bh_schedule()!
  qemu_bh_schedule(ctx->co_schedule_bh);

So if co causes ctx to be freed then we're in trouble.  Fix this problem
by holding a reference to ctx.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20190723190623.21537-1-stefanha@redhat.com
Message-Id: <20190723190623.21537-1-stefanha@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/async.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/util/async.c b/util/async.c
index 8d2105729c..4e4c7af51e 100644
--- a/util/async.c
+++ b/util/async.c
@@ -459,9 +459,17 @@ void aio_co_schedule(AioContext *ctx, Coroutine *co)
         abort();
     }
=20
+    /* The coroutine might run and release the last ctx reference before=
 we
+     * invoke qemu_bh_schedule().  Take a reference to keep ctx alive un=
til
+     * we're done.
+     */
+    aio_context_ref(ctx);
+
     QSLIST_INSERT_HEAD_ATOMIC(&ctx->scheduled_coroutines,
                               co, co_scheduled_next);
     qemu_bh_schedule(ctx->co_schedule_bh);
+
+    aio_context_unref(ctx);
 }
=20
 void aio_co_wake(struct Coroutine *co)
--=20
2.21.0


