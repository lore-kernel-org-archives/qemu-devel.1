Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC46C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 17:29:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E22692084D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 17:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22692084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52549 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEdVY-0005jJ-Pq
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 13:29:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEdTm-0004ZH-Vt
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:27:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEdTl-0003bl-Qs
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:27:14 -0400
Received: from relay.sw.ru ([185.231.240.75]:59344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hEdTl-0003Zv-D7; Thu, 11 Apr 2019 13:27:13 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hEdTj-00044D-2R; Thu, 11 Apr 2019 20:27:11 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Thu, 11 Apr 2019 20:27:07 +0300
Message-Id: <20190411172709.205032-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190411172709.205032-1-vsementsov@virtuozzo.com>
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v6 5/7] qemu-coroutine-sleep: introduce
 qemu_co_sleep_wake
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com,
	mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190411172707.Gkf4dGThWLUXTrLkBmghz6S-fLV5J9ux58Gmf_C3K_A@z>

Introduce a function to gracefully wake-up a coroutine, sleeping in
qemu_co_sleep_ns() sleep.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/qemu/coroutine.h    |  6 ++++++
 util/qemu-coroutine-sleep.c | 20 ++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index 9801e7f5a4..ec765c26f0 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -278,6 +278,12 @@ void qemu_co_rwlock_unlock(CoRwlock *lock);
  */
 void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns);
 
+/*
+ * Wake a coroutine if it is sleeping by qemu_co_sleep_ns. Timer will be
+ * deleted.
+ */
+void qemu_co_sleep_wake(Coroutine *co);
+
 /**
  * Yield until a file descriptor becomes readable
  *
diff --git a/util/qemu-coroutine-sleep.c b/util/qemu-coroutine-sleep.c
index 4bfdd30cbf..bcc6afca3e 100644
--- a/util/qemu-coroutine-sleep.c
+++ b/util/qemu-coroutine-sleep.c
@@ -17,13 +17,24 @@
 #include "qemu/timer.h"
 #include "block/aio.h"
 
+const char *qemu_co_sleep_ns__scheduled = "qemu_co_sleep_ns";
+
+void qemu_co_sleep_wake(Coroutine *co)
+{
+    /* Write of schedule protected by barrier write in aio_co_schedule */
+    const char *scheduled = atomic_cmpxchg(&co->scheduled,
+                                           qemu_co_sleep_ns__scheduled, NULL);
+
+    if (scheduled == qemu_co_sleep_ns__scheduled) {
+        aio_co_wake(co);
+    }
+}
+
 static void co_sleep_cb(void *opaque)
 {
     Coroutine *co = opaque;
 
-    /* Write of schedule protected by barrier write in aio_co_schedule */
-    atomic_set(&co->scheduled, NULL);
-    aio_co_wake(co);
+    qemu_co_sleep_wake(co);
 }
 
 void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns)
@@ -32,7 +43,8 @@ void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns)
     QEMUTimer *ts;
     Coroutine *co = qemu_coroutine_self();
 
-    const char *scheduled = atomic_cmpxchg(&co->scheduled, NULL, __func__);
+    const char *scheduled = atomic_cmpxchg(&co->scheduled, NULL,
+                                           qemu_co_sleep_ns__scheduled);
     if (scheduled) {
         fprintf(stderr,
                 "%s: Co-routine was already scheduled in '%s'\n",
-- 
2.18.0


