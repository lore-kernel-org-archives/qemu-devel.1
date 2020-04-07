Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8D8C2BA2B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D93420719
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/EAs9Tb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D93420719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLouL-0002DU-50
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 10:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jLotS-0000Z2-He
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:07:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jLotQ-00013s-WC
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:07:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39940
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jLotQ-00013X-S8
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586268476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2NlGDHsxs6NB6PgDud3ZxG1DzThL5NOMW87BbQ97wik=;
 b=e/EAs9Tb+kg/pay/IC4VvUFanwrSj230ZQ0+YZ6I6ccq2fZM8asOhxoBfvK3j55VwRi52d
 X/7j11rTDmXJnIOP29f63x1a9aLilPM1PurY3ZJwVH3DNEqkulLWIWD5I2jV7GEDF6qvFz
 EZz5AmCIFFCJqzKwMcKh1igXp9kVoJA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-Q-8qwBxMMaC9j52qItvfGQ-1; Tue, 07 Apr 2020 10:07:54 -0400
X-MC-Unique: Q-8qwBxMMaC9j52qItvfGQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99FCE1005509;
 Tue,  7 Apr 2020 14:07:53 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D5755C1BB;
 Tue,  7 Apr 2020 14:07:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/5] aio-wait: delegate polling of main AioContext if BQL not
 held
Date: Tue,  7 Apr 2020 10:07:45 -0400
Message-Id: <20200407140746.8041-5-pbonzini@redhat.com>
In-Reply-To: <20200407140746.8041-1-pbonzini@redhat.com>
References: <20200407140746.8041-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: fangying1@huawei.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Any thread that is not a iothread returns NULL for qemu_get_current_aio_con=
text().
As a result, it would also return true for
in_aio_context_home_thread(qemu_get_aio_context()), causing
AIO_WAIT_WHILE to invoke aio_poll() directly.  This is incorrect
if the BQL is not held, because aio_poll() does not expect to
run concurrently from multiple threads, and it can actually
happen when savevm writes to the vmstate file from the
migration thread.

Therefore, restrict in_aio_context_home_thread to return true
for the main AioContext only if the BQL is held.

The function is moved to aio-wait.h because it is mostly used
there and to avoid a circular reference between main-loop.h
and block/aio.h.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/block/aio-wait.h | 22 ++++++++++++++++++++++
 include/block/aio.h      | 29 ++++++++++-------------------
 2 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/include/block/aio-wait.h b/include/block/aio-wait.h
index afeeb18f95..716d2639df 100644
--- a/include/block/aio-wait.h
+++ b/include/block/aio-wait.h
@@ -26,6 +26,7 @@
 #define QEMU_AIO_WAIT_H
=20
 #include "block/aio.h"
+#include "qemu/main-loop.h"
=20
 /**
  * AioWait:
@@ -124,4 +125,25 @@ void aio_wait_kick(void);
  */
 void aio_wait_bh_oneshot(AioContext *ctx, QEMUBHFunc *cb, void *opaque);
=20
+/**
+ * in_aio_context_home_thread:
+ * @ctx: the aio context
+ *
+ * Return whether we are running in the thread that normally runs @ctx.  N=
ote
+ * that acquiring/releasing ctx does not affect the outcome, each AioConte=
xt
+ * still only has one home thread that is responsible for running it.
+ */
+static inline bool in_aio_context_home_thread(AioContext *ctx)
+{
+    if (ctx =3D=3D qemu_get_current_aio_context()) {
+        return true;
+    }
+
+    if (ctx =3D=3D qemu_get_aio_context()) {
+        return qemu_mutex_iothread_locked();
+    } else {
+        return false;
+    }
+}
+
 #endif /* QEMU_AIO_WAIT_H */
diff --git a/include/block/aio.h b/include/block/aio.h
index cb1989105a..62ed954344 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -133,12 +133,16 @@ struct AioContext {
     AioHandlerList deleted_aio_handlers;
=20
     /* Used to avoid unnecessary event_notifier_set calls in aio_notify;
-     * accessed with atomic primitives.  If this field is 0, everything
-     * (file descriptors, bottom halves, timers) will be re-evaluated
-     * before the next blocking poll(), thus the event_notifier_set call
-     * can be skipped.  If it is non-zero, you may need to wake up a
-     * concurrent aio_poll or the glib main event loop, making
-     * event_notifier_set necessary.
+     * only written from the AioContext home thread, or under the BQL in
+     * the case of the main AioContext.  However, it is read from any
+     * thread so it is still accessed with atomic primitives.
+     *
+     * If this field is 0, everything (file descriptors, bottom halves,
+     * timers) will be re-evaluated before the next blocking poll() or
+     * io_uring wait; therefore, the event_notifier_set call can be
+     * skipped.  If it is non-zero, you may need to wake up a concurrent
+     * aio_poll or the glib main event loop, making event_notifier_set
+     * necessary.
      *
      * Bit 0 is reserved for GSource usage of the AioContext, and is 1
      * between a call to aio_ctx_prepare and the next call to aio_ctx_chec=
k.
@@ -681,19 +685,6 @@ void aio_co_enter(AioContext *ctx, struct Coroutine *c=
o);
  */
 AioContext *qemu_get_current_aio_context(void);
=20
-/**
- * in_aio_context_home_thread:
- * @ctx: the aio context
- *
- * Return whether we are running in the thread that normally runs @ctx.  N=
ote
- * that acquiring/releasing ctx does not affect the outcome, each AioConte=
xt
- * still only has one home thread that is responsible for running it.
- */
-static inline bool in_aio_context_home_thread(AioContext *ctx)
-{
-    return ctx =3D=3D qemu_get_current_aio_context();
-}
-
 /**
  * aio_context_setup:
  * @ctx: the aio context
--=20
2.18.2



