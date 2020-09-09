Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB8FC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:17:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F94B22272
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXiRFAnq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F94B22272
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG1qg-0000od-9G
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 11:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kG1lx-0001yi-FN
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 11:12:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28898
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kG1lp-0003qL-5c
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 11:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599664344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EhlBYBZa5MKP/ypPYxGQfG8Jorm1ey51c6s1ocNbuCA=;
 b=BXiRFAnqa2bwGVdXYk18ec/sHsCFuZ2ztK4SwirQVFUQ9Tf2nvf8lmli0+Xsp/5ccYvFWT
 MPqAUFG9kzsDm8HckbMb0URSbePRKJpWGTHY4dWgEpQhWp0h8ed4+xTOsVQGcUGkK04TVl
 ksCTp3vP2x02iKs65gao5g8NWRhvn7M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-UinDH_6UOP6ZzJ8TU9TcxQ-1; Wed, 09 Sep 2020 11:12:22 -0400
X-MC-Unique: UinDH_6UOP6ZzJ8TU9TcxQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF0041084D72;
 Wed,  9 Sep 2020 15:12:21 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-221.ams2.redhat.com
 [10.36.113.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DBF9860C87;
 Wed,  9 Sep 2020 15:12:19 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 11/13] util/async: Add aio_co_reschedule_self()
Date: Wed,  9 Sep 2020 17:11:47 +0200
Message-Id: <20200909151149.490589-12-kwolf@redhat.com>
In-Reply-To: <20200909151149.490589-1-kwolf@redhat.com>
References: <20200909151149.490589-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:05:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 marcandre.lureau@gmail.com, stefanha@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a function that can be used to move the currently running coroutine
to a different AioContext (and therefore potentially a different
thread).

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/aio.h | 10 ++++++++++
 util/async.c        | 30 ++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/block/aio.h b/include/block/aio.h
index b2f703fa3f..c37617b404 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -17,6 +17,7 @@
 #ifdef CONFIG_LINUX_IO_URING
 #include <liburing.h>
 #endif
+#include "qemu/coroutine.h"
 #include "qemu/queue.h"
 #include "qemu/event_notifier.h"
 #include "qemu/thread.h"
@@ -654,6 +655,15 @@ static inline bool aio_node_check(AioContext *ctx, bool is_external)
  */
 void aio_co_schedule(AioContext *ctx, struct Coroutine *co);
 
+/**
+ * aio_co_reschedule_self:
+ * @new_ctx: the new context
+ *
+ * Move the currently running coroutine to new_ctx. If the coroutine is already
+ * running in new_ctx, do nothing.
+ */
+void coroutine_fn aio_co_reschedule_self(AioContext *new_ctx);
+
 /**
  * aio_co_wake:
  * @co: the coroutine
diff --git a/util/async.c b/util/async.c
index 4266745dee..a609e18693 100644
--- a/util/async.c
+++ b/util/async.c
@@ -569,6 +569,36 @@ void aio_co_schedule(AioContext *ctx, Coroutine *co)
     aio_context_unref(ctx);
 }
 
+typedef struct AioCoRescheduleSelf {
+    Coroutine *co;
+    AioContext *new_ctx;
+} AioCoRescheduleSelf;
+
+static void aio_co_reschedule_self_bh(void *opaque)
+{
+    AioCoRescheduleSelf *data = opaque;
+    aio_co_schedule(data->new_ctx, data->co);
+}
+
+void coroutine_fn aio_co_reschedule_self(AioContext *new_ctx)
+{
+    AioContext *old_ctx = qemu_get_current_aio_context();
+
+    if (old_ctx != new_ctx) {
+        AioCoRescheduleSelf data = {
+            .co = qemu_coroutine_self(),
+            .new_ctx = new_ctx,
+        };
+        /*
+         * We can't directly schedule the coroutine in the target context
+         * because this would be racy: The other thread could try to enter the
+         * coroutine before it has yielded in this one.
+         */
+        aio_bh_schedule_oneshot(old_ctx, aio_co_reschedule_self_bh, &data);
+        qemu_coroutine_yield();
+    }
+}
+
 void aio_co_wake(struct Coroutine *co)
 {
     AioContext *ctx;
-- 
2.25.4


