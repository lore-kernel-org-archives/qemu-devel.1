Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949AFCA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 02:04:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63A1D2086D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 02:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S66FULjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A1D2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iN60O-00031X-AH
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 22:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iN5xy-00015G-VA
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 22:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iN5xx-0008Mv-Eo
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 22:01:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30298
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iN5xw-0008MN-Ae
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 22:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571796095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sJBT+KxNtbrv9rd8vZLLZ1RKBc+eKb/5DTyPtyP6zys=;
 b=S66FULjCh5Pa4xeAmo5dUThRaCqTLQTQqSMVqmNUm6ZsMl6wFvHIwTeYVR4tEfijQaFAzf
 z0DpRC8MCsvJYTA0DxaMrpueFeCUr4rtdi3z9hJEnNa92/DjHZ1YqZsFAnDp+GYce8wRl2
 j2tSQA38qkModEZX1APsLZGSlV1yxC4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-7iuxsg0AOvW_7PNNZaPVfQ-1; Tue, 22 Oct 2019 22:01:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B494107AD31;
 Wed, 23 Oct 2019 02:01:33 +0000 (UTC)
Received: from blue.redhat.com (ovpn-117-0.phx2.redhat.com [10.3.117.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5AA0D6012D;
 Wed, 23 Oct 2019 02:01:30 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] qemu-coroutine-sleep: introduce qemu_co_sleep_wake
Date: Tue, 22 Oct 2019 21:01:24 -0500
Message-Id: <20191023020126.24991-2-eblake@redhat.com>
In-Reply-To: <20191023020126.24991-1-eblake@redhat.com>
References: <20191023020126.24991-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 7iuxsg0AOvW_7PNNZaPVfQ-1
X-Mimecast-Spam-Score: 0
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Introduce a function to gracefully wake a coroutine sleeping in
qemu_co_sleep_ns().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20191009084158.15614-2-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/qemu/coroutine.h    | 23 +++++++++++++++--
 util/qemu-coroutine-sleep.c | 51 +++++++++++++++++++++++++++----------
 2 files changed, 59 insertions(+), 15 deletions(-)

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index 9801e7f5a497..8d55663062ad 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -273,10 +273,29 @@ void qemu_co_rwlock_wrlock(CoRwlock *lock);
  */
 void qemu_co_rwlock_unlock(CoRwlock *lock);

+typedef struct QemuCoSleepState QemuCoSleepState;
+
 /**
- * Yield the coroutine for a given duration
+ * Yield the coroutine for a given duration. During this yield, @sleep_sta=
te
+ * (if not NULL) is set to an opaque pointer, which may be used for
+ * qemu_co_sleep_wake(). Be careful, the pointer is set back to zero when =
the
+ * timer fires. Don't save the obtained value to other variables and don't=
 call
+ * qemu_co_sleep_wake from another aio context.
  */
-void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns);
+void coroutine_fn qemu_co_sleep_ns_wakeable(QEMUClockType type, int64_t ns=
,
+                                            QemuCoSleepState **sleep_state=
);
+static inline void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64=
_t ns)
+{
+    qemu_co_sleep_ns_wakeable(type, ns, NULL);
+}
+
+/**
+ * Wake a coroutine if it is sleeping in qemu_co_sleep_ns. The timer will =
be
+ * deleted. @sleep_state must be the variable whose address was given to
+ * qemu_co_sleep_ns() and should be checked to be non-NULL before calling
+ * qemu_co_sleep_wake().
+ */
+void qemu_co_sleep_wake(QemuCoSleepState *sleep_state);

 /**
  * Yield until a file descriptor becomes readable
diff --git a/util/qemu-coroutine-sleep.c b/util/qemu-coroutine-sleep.c
index 4bfdd30cbf13..ae91b92b6e78 100644
--- a/util/qemu-coroutine-sleep.c
+++ b/util/qemu-coroutine-sleep.c
@@ -17,31 +17,56 @@
 #include "qemu/timer.h"
 #include "block/aio.h"

-static void co_sleep_cb(void *opaque)
+static const char *qemu_co_sleep_ns__scheduled =3D "qemu_co_sleep_ns";
+
+struct QemuCoSleepState {
+    Coroutine *co;
+    QEMUTimer *ts;
+    QemuCoSleepState **user_state_pointer;
+};
+
+void qemu_co_sleep_wake(QemuCoSleepState *sleep_state)
 {
-    Coroutine *co =3D opaque;
-
     /* Write of schedule protected by barrier write in aio_co_schedule */
-    atomic_set(&co->scheduled, NULL);
-    aio_co_wake(co);
+    const char *scheduled =3D atomic_cmpxchg(&sleep_state->co->scheduled,
+                                           qemu_co_sleep_ns__scheduled, NU=
LL);
+
+    assert(scheduled =3D=3D qemu_co_sleep_ns__scheduled);
+    if (sleep_state->user_state_pointer) {
+        *sleep_state->user_state_pointer =3D NULL;
+    }
+    timer_del(sleep_state->ts);
+    aio_co_wake(sleep_state->co);
+}
+
+static void co_sleep_cb(void *opaque)
+{
+    qemu_co_sleep_wake(opaque);
 }

-void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns)
+void coroutine_fn qemu_co_sleep_ns_wakeable(QEMUClockType type, int64_t ns=
,
+                                            QemuCoSleepState **sleep_state=
)
 {
     AioContext *ctx =3D qemu_get_current_aio_context();
-    QEMUTimer *ts;
-    Coroutine *co =3D qemu_coroutine_self();
+    QemuCoSleepState state =3D {
+        .co =3D qemu_coroutine_self(),
+        .ts =3D aio_timer_new(ctx, type, SCALE_NS, co_sleep_cb, &state),
+        .user_state_pointer =3D sleep_state,
+    };

-    const char *scheduled =3D atomic_cmpxchg(&co->scheduled, NULL, __func_=
_);
+    const char *scheduled =3D atomic_cmpxchg(&state.co->scheduled, NULL,
+                                           qemu_co_sleep_ns__scheduled);
     if (scheduled) {
         fprintf(stderr,
                 "%s: Co-routine was already scheduled in '%s'\n",
                 __func__, scheduled);
         abort();
     }
-    ts =3D aio_timer_new(ctx, type, SCALE_NS, co_sleep_cb, co);
-    timer_mod(ts, qemu_clock_get_ns(type) + ns);
+
+    if (sleep_state) {
+        *sleep_state =3D &state;
+    }
+    timer_mod(state.ts, qemu_clock_get_ns(type) + ns);
     qemu_coroutine_yield();
-    timer_del(ts);
-    timer_free(ts);
+    timer_free(state.ts);
 }
--=20
2.21.0


