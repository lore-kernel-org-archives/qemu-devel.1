Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A44EC2BA2B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:15:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4D30206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQcYtyin"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D30206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLp0o-0006sP-V6
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 10:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jLozX-0006Kb-8i
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:14:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jLozV-0005cj-OF
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:14:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50366
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jLozV-0005bu-L5
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586268852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=20aiP+/dA+EblNQZt/yrEm2C26ewENAgFUQO4Z58Jv0=;
 b=NQcYtyinQ+/0ZJ3jrPCVKuKF3V5uuPmETKAzG2/jilLpo1Mn7i4JZk0ihzxkmKe7nSGfnV
 /iaH0VKU8w0WmpNEigmBtI3TIQYi0mcdHFv63P2x5PR8xLRP2soFPQpBSvvgknVCASsU+c
 qNk08ru0eeGuMkoTZg6ovvPBWb4A88U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-LeA1f9ieNpWWN8KL4EM4Rw-1; Tue, 07 Apr 2020 10:07:55 -0400
X-MC-Unique: LeA1f9ieNpWWN8KL4EM4Rw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 579C2107B7D4;
 Tue,  7 Apr 2020 14:07:54 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE91F5C1BB;
 Tue,  7 Apr 2020 14:07:53 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] async: use explicit memory barriers
Date: Tue,  7 Apr 2020 10:07:46 -0400
Message-Id: <20200407140746.8041-6-pbonzini@redhat.com>
In-Reply-To: <20200407140746.8041-1-pbonzini@redhat.com>
References: <20200407140746.8041-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: fangying1@huawei.com, stefanha@redhat.com
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
threads, so we can assert that and relax the writes to ctx->notify_me.
The resulting solution works and performs well on both aarch64 and x86.

Note that the atomic_set/atomic_read combination is not an atomic
read-modify-write, and therefore it is even weaker than C11 ATOMIC_RELAXED;
on x86, ATOMIC_RELAXED compiles to a locked operation.

Analyzed-by: Ying Fang <fangying1@huawei.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/aio-posix.c | 16 ++++++++++++++--
 util/aio-win32.c | 17 ++++++++++++++---
 util/async.c     | 16 ++++++++++++----
 3 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index cd6cf0a4a9..c3613d299e 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -559,6 +559,11 @@ bool aio_poll(AioContext *ctx, bool blocking)
     int64_t timeout;
     int64_t start =3D 0;
=20
+    /*
+     * There cannot be two concurrent aio_poll calls for the same AioConte=
xt (or
+     * an aio_poll concurrent with a GSource prepare/check/dispatch callba=
ck).
+     * We rely on this below to avoid slow locked accesses to ctx->notify_=
me.
+     */
     assert(in_aio_context_home_thread(ctx));
=20
     /* aio_notify can avoid the expensive event_notifier_set if
@@ -569,7 +574,13 @@ bool aio_poll(AioContext *ctx, bool blocking)
      * so disable the optimization now.
      */
     if (blocking) {
-        atomic_add(&ctx->notify_me, 2);
+        atomic_set(&ctx->notify_me, atomic_read(&ctx->notify_me) + 2);
+        /*
+         * Write ctx->notify_me before computing the timeout
+         * (reading bottom half flags, etc.).  Pairs with
+         * smp_mb in aio_notify().
+         */
+        smp_mb();
     }
=20
     qemu_lockcnt_inc(&ctx->list_lock);
@@ -590,7 +601,8 @@ bool aio_poll(AioContext *ctx, bool blocking)
     }
=20
     if (blocking) {
-        atomic_sub(&ctx->notify_me, 2);
+        /* Finish the poll before clearing the flag.  */
+        atomic_store_release(&ctx->notify_me, atomic_read(&ctx->notify_me)=
 - 2);
         aio_notify_accept(ctx);
     }
=20
diff --git a/util/aio-win32.c b/util/aio-win32.c
index a23b9c364d..729d533faf 100644
--- a/util/aio-win32.c
+++ b/util/aio-win32.c
@@ -321,6 +321,12 @@ bool aio_poll(AioContext *ctx, bool blocking)
     int count;
     int timeout;
=20
+    /*
+     * There cannot be two concurrent aio_poll calls for the same AioConte=
xt (or
+     * an aio_poll concurrent with a GSource prepare/check/dispatch callba=
ck).
+     * We rely on this below to avoid slow locked accesses to ctx->notify_=
me.
+     */
+    assert(in_aio_context_home_thread(ctx));
     progress =3D false;
=20
     /* aio_notify can avoid the expensive event_notifier_set if
@@ -331,7 +337,13 @@ bool aio_poll(AioContext *ctx, bool blocking)
      * so disable the optimization now.
      */
     if (blocking) {
-        atomic_add(&ctx->notify_me, 2);
+        atomic_set(&ctx->notify_me, atomic_read(&ctx->notify_me) + 2);
+        /*
+         * Write ctx->notify_me before computing the timeout
+         * (reading bottom half flags, etc.).  Pairs with
+         * smp_mb in aio_notify().
+         */
+        smp_mb();
     }
=20
     qemu_lockcnt_inc(&ctx->list_lock);
@@ -364,8 +376,7 @@ bool aio_poll(AioContext *ctx, bool blocking)
         ret =3D WaitForMultipleObjects(count, events, FALSE, timeout);
         if (blocking) {
             assert(first);
-            assert(in_aio_context_home_thread(ctx));
-            atomic_sub(&ctx->notify_me, 2);
+            atomic_store_release(&ctx->notify_me, atomic_read(&ctx->notify=
_me) - 2);
             aio_notify_accept(ctx);
         }
=20
diff --git a/util/async.c b/util/async.c
index b94518b948..3165a28f2f 100644
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
+     * smp_mb in aio_notify().
+     */
+    smp_mb();
=20
     /* We assume there is no timeout already supplied */
     *timeout =3D qemu_timeout_ns_to_ms(aio_compute_timeout(ctx));
@@ -268,7 +275,8 @@ aio_ctx_check(GSource *source)
     QEMUBH *bh;
     BHListSlice *s;
=20
-    atomic_and(&ctx->notify_me, ~1);
+    /* Finish computing the timeout before clearing the flag.  */
+    atomic_store_release(&ctx->notify_me, atomic_read(&ctx->notify_me) & ~=
1);
     aio_notify_accept(ctx);
=20
     QSLIST_FOREACH_RCU(bh, &ctx->bh_list, next) {
@@ -411,10 +419,10 @@ LuringState *aio_get_linux_io_uring(AioContext *ctx)
 void aio_notify(AioContext *ctx)
 {
     /* Write e.g. bh->scheduled before reading ctx->notify_me.  Pairs
-     * with atomic_or in aio_ctx_prepare or atomic_add in aio_poll.
+     * with smp_mb in aio_ctx_prepare or aio_poll.
      */
     smp_mb();
-    if (ctx->notify_me) {
+    if (atomic_read(&ctx->notify_me)) {
         event_notifier_set(&ctx->notifier);
         atomic_mb_set(&ctx->notified, true);
     }
--=20
2.18.2


