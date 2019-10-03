Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF523C32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 10:02:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A900A2133F
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 10:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A900A2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFxwT-0005AJ-MY
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 06:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iFxvN-0004Ye-Di
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iFxvM-0007ca-6K
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:01:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34350)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1iFxv4-0007WK-OU; Thu, 03 Oct 2019 06:01:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 641673066EB9;
 Thu,  3 Oct 2019 10:01:08 +0000 (UTC)
Received: from localhost (ovpn-117-189.ams2.redhat.com [10.36.117.189])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E33E15C21A;
 Thu,  3 Oct 2019 10:01:04 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] test-bdrv-drain: fix iothread_join() hang
Date: Thu,  3 Oct 2019 11:01:03 +0100
Message-Id: <20191003100103.331-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 03 Oct 2019 10:01:08 +0000 (UTC)
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

tests/test-bdrv-drain can hang in tests/iothread.c:iothread_run():

  while (!atomic_read(&iothread->stopping)) {
      aio_poll(iothread->ctx, true);
  }

The iothread_join() function works as follows:

  void iothread_join(IOThread *iothread)
  {
      iothread->stopping =3D true;
      aio_notify(iothread->ctx);
      qemu_thread_join(&iothread->thread);

If iothread_run() checks iothread->stopping before the iothread_join()
thread sets stopping to true, then aio_notify() may be optimized away
and iothread_run() hangs forever in aio_poll().

The correct way to change iothread->stopping is from a BH that executes
within iothread_run().  This ensures that iothread->stopping is checked
after we set it to true.

This was already fixed for ./iothread.c (note this is a different source
file!) by commit 2362a28ea11c145e1a13ae79342d76dc118a72a6 ("iothread:
fix iothread_stop() race condition"), but not for tests/iothread.c.

Fixes: 0c330a734b51c177ab8488932ac3b0c4d63a718a
       ("aio: introduce aio_co_schedule and aio_co_wake")
Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/iothread.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/iothread.c b/tests/iothread.c
index 777d9eea46..13c9fdcd8d 100644
--- a/tests/iothread.c
+++ b/tests/iothread.c
@@ -55,10 +55,16 @@ static void *iothread_run(void *opaque)
     return NULL;
 }
=20
-void iothread_join(IOThread *iothread)
+static void iothread_stop_bh(void *opaque)
 {
+    IOThread *iothread =3D opaque;
+
     iothread->stopping =3D true;
-    aio_notify(iothread->ctx);
+}
+
+void iothread_join(IOThread *iothread)
+{
+    aio_bh_schedule_oneshot(iothread->ctx, iothread_stop_bh, iothread);
     qemu_thread_join(&iothread->thread);
     qemu_cond_destroy(&iothread->init_done_cond);
     qemu_mutex_destroy(&iothread->init_done_lock);
--=20
2.21.0


