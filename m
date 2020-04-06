Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2F2C2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 19:17:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D35C9206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 19:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bKPec95/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35C9206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLXFT-0005hn-Th
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 15:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jLXBc-00011W-2w
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 15:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jLXBa-0006i9-Us
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 15:13:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42718
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jLXBa-0006hc-RJ
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 15:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586200410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Ua1uVlJeZsGjldXbjT2beLLFwjIig2Wrf3VsNlyDJ0=;
 b=bKPec95/d25zRbXk4No7wBjqfkggJuZ4WvveBdoixjpGWHZICkecsI+4ZN4kdiSiRP35sI
 XZP8OGgKRE2isbLBY5NzmCehNqSeUAKu03wBxTpzzxqNjeQjsHTucVwgPKKHLA38j2FoDm
 8NQFt04p/iLA1Mgk/F2Er3nxtKL13rc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-GVZshSvyN_i567-Lf4XtVQ-1; Mon, 06 Apr 2020 15:13:28 -0400
X-MC-Unique: GVZshSvyN_i567-Lf4XtVQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47C7C8017CE;
 Mon,  6 Apr 2020 19:13:27 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB03A62697;
 Mon,  6 Apr 2020 19:13:26 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] async: use explicit memory barriers and relaxed accesses
Date: Mon,  6 Apr 2020 15:13:20 -0400
Message-Id: <20200406191320.13371-5-pbonzini@redhat.com>
In-Reply-To: <20200406191320.13371-1-pbonzini@redhat.com>
References: <20200406191320.13371-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Ying Fang <fangying1@huawei.com>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When using C11 atomics, non-seqcst reads and writes do not participate
in the total order of seqcst operations.  In util/async.c and util/aio-posi=
x.c,
in particular, the pattern that we use

          write ctx->notify_me                 write bh->scheduled
          read bh->scheduled                   read ctx->notify_me
          if !bh->scheduled, sleep             if ctx->notify_me, notify

needs to use seqcst operations for both the write and the read.  In
general this is something that we do not want, because there can be
many sources that are polled in addition to bottom halves.  The
alternative is to place a seqcst memory barrier between the write
and the read.  This also comes with a disadvantage, in that the
memory barrier is implicit on strongly-ordered architectures and
it wastes a few dozen clock cycles.

Fortunately, ctx->notify_me is never written concurrently by two
threads, so we can instead relax the writes to ctx->notify_me.
[This part of the commit message is still to be written more
in detail and is what I am not sure about.]

Analyzed-by: Ying Fang <fangying1@huawei.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/aio-posix.c |  9 ++++++++-
 util/aio-win32.c |  8 +++++++-
 util/async.c     | 12 ++++++++++--
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index cd6cf0a4a9..37afec726f 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -569,7 +569,13 @@ bool aio_poll(AioContext *ctx, bool blocking)
      * so disable the optimization now.
      */
     if (blocking) {
-        atomic_add(&ctx->notify_me, 2);
+        atomic_set(&ctx->notify_me, atomic_read(&ctx->notify_me) + 2);
+        /*
+         * Write ctx->notify_me before computing the timeout
+         * (reading bottom half flags, etc.).  Pairs with
+         * atomic_xchg in aio_notify().
+         */
+        smp_mb();
     }
=20
     qemu_lockcnt_inc(&ctx->list_lock);
@@ -590,6 +596,7 @@ bool aio_poll(AioContext *ctx, bool blocking)
     }
=20
     if (blocking) {
+        /* Finish the poll before clearing the flag.  */
         atomic_sub(&ctx->notify_me, 2);
         aio_notify_accept(ctx);
     }
diff --git a/util/aio-win32.c b/util/aio-win32.c
index a23b9c364d..2cccdb35c1 100644
--- a/util/aio-win32.c
+++ b/util/aio-win32.c
@@ -331,7 +331,13 @@ bool aio_poll(AioContext *ctx, bool blocking)
      * so disable the optimization now.
      */
     if (blocking) {
-        atomic_add(&ctx->notify_me, 2);
+        atomic_set(&ctx->notify_me, atomic_read(&ctx->notify_me) + 2);
+        /*
+         * Write ctx->notify_me before computing the timeout
+         * (reading bottom half flags, etc.).  Pairs with
+         * atomic_xchg in aio_notify().
+         */
+        smp_mb();
     }
=20
     qemu_lockcnt_inc(&ctx->list_lock);
diff --git a/util/async.c b/util/async.c
index b94518b948..ee1bc87d2b 100644
--- a/util/async.c
+++ b/util/async.c
@@ -249,7 +249,14 @@ aio_ctx_prepare(GSource *source, gint    *timeout)
 {
     AioContext *ctx =3D (AioContext *) source;
=20
-    atomic_or(&ctx->notify_me, 1);
+    atomic_set(&ctx->notify_me, atomic_read(&ctx->notify_me) | 1);
+
+    /*
+     * Write ctx->notify_me before computing the timeout
+     * (reading bottom half flags, etc.).  Pairs with
+     * atomic_xchg in aio_notify().
+     */
+    smp_mb();
=20
     /* We assume there is no timeout already supplied */
     *timeout =3D qemu_timeout_ns_to_ms(aio_compute_timeout(ctx));
@@ -414,7 +422,7 @@ void aio_notify(AioContext *ctx)
      * with atomic_or in aio_ctx_prepare or atomic_add in aio_poll.
      */
     smp_mb();
-    if (ctx->notify_me) {
+    if (atomic_read(&ctx->notify_me)) {
         event_notifier_set(&ctx->notifier);
         atomic_mb_set(&ctx->notified, true);
     }
--=20
2.18.2


