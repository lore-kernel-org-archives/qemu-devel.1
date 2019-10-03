Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2B2C32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 17:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0718B2086A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 17:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0718B2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG4nc-0003Kz-Ne
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 13:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iG4hl-00074h-Ak
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 13:15:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iG4hj-00006X-LY
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 13:15:53 -0400
Received: from relay.sw.ru ([185.231.240.75]:50280)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iG4hc-0008Tr-3i; Thu, 03 Oct 2019 13:15:45 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iG4hY-0002ks-Io; Thu, 03 Oct 2019 20:15:40 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 4/6] util: introduce co-shared-amount
Date: Thu,  3 Oct 2019 20:15:37 +0300
Message-Id: <20191003171539.12327-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191003171539.12327-1-vsementsov@virtuozzo.com>
References: <20191003171539.12327-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce an API for some shared splitable resource, like memory.
It's going to be used by backup. Backup uses both read/write io and
copy_range. copy_range may consume memory implictly, so new API is
abstract: it don't allocate any real memory but only handling out
tickets.

The idea is that we have some total amount of something and callers
should wait in coroutine queue if there is not enough of the resource
at the moment.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/qemu/co-shared-amount.h | 66 ++++++++++++++++++++++++++++
 util/qemu-co-shared-amount.c    | 77 +++++++++++++++++++++++++++++++++
 util/Makefile.objs              |  1 +
 3 files changed, 144 insertions(+)
 create mode 100644 include/qemu/co-shared-amount.h
 create mode 100644 util/qemu-co-shared-amount.c

diff --git a/include/qemu/co-shared-amount.h b/include/qemu/co-shared-amount.h
new file mode 100644
index 0000000000..e2dbc43dfd
--- /dev/null
+++ b/include/qemu/co-shared-amount.h
@@ -0,0 +1,66 @@
+/*
+ * Generic shared amount for coroutines
+ *
+ * Copyright (c) 2019 Virtuozzo International GmbH
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef QEMU_CO_SHARED_AMOUNT_H
+#define QEMU_CO_SHARED_AMOUNT_H
+
+
+typedef struct QemuCoSharedAmount QemuCoSharedAmount;
+
+/*
+ * Create QemuCoSharedAmount structure
+ *
+ * @total: total amount to be shared between clients
+ *
+ * Note: this API is not thread-safe as it originally designed to be used in
+ * backup block-job and called from one aio context. If multiple threads support
+ * is needed it should be implemented (for ex., protect QemuCoSharedAmount by
+ * mutex).
+ */
+QemuCoSharedAmount *qemu_co_shared_amount_new(uint64_t total);
+
+/*
+ * Release QemuCoSharedAmount structure
+ */
+void qemu_co_shared_amount_free(QemuCoSharedAmount *s);
+
+/*
+ * Try to get n peaces. If not enough free peaces returns false, otherwise true.
+ */
+bool qemu_co_try_get_amount(QemuCoSharedAmount *s, uint64_t n);
+
+/*
+ * Get n peaces. If not enough yields. Return on success.
+ */
+void coroutine_fn qemu_co_get_amount(QemuCoSharedAmount *s, uint64_t n);
+
+/*
+ * Put n peaces. Client must not put more than it gets, still it may put in
+ * split: for example, get(5) and then put(3), put(2). All peaces must be put
+ * back before qemu_co_shared_amount_free call.
+ */
+void coroutine_fn qemu_co_put_amount(QemuCoSharedAmount *s, uint64_t n);
+
+
+#endif /* QEMU_CO_SHARED_AMOUNT_H */
diff --git a/util/qemu-co-shared-amount.c b/util/qemu-co-shared-amount.c
new file mode 100644
index 0000000000..8855ce5705
--- /dev/null
+++ b/util/qemu-co-shared-amount.c
@@ -0,0 +1,77 @@
+/*
+ * Generic shared amount for coroutines
+ *
+ * Copyright (c) 2019 Virtuozzo International GmbH
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/coroutine.h"
+#include "qemu/co-shared-amount.h"
+
+struct QemuCoSharedAmount {
+    uint64_t total;
+    uint64_t taken;
+
+    CoQueue queue;
+};
+
+QemuCoSharedAmount *qemu_co_shared_amount_new(uint64_t total)
+{
+    QemuCoSharedAmount *s = g_new0(QemuCoSharedAmount, 1);
+
+    s->total = total;
+    qemu_co_queue_init(&s->queue);
+
+    return s;
+}
+
+void qemu_co_shared_amount_free(QemuCoSharedAmount *s)
+{
+    assert(s->taken == 0);
+    g_free(s);
+}
+
+bool qemu_co_try_get_amount(QemuCoSharedAmount *s, uint64_t n)
+{
+    if (n < s->total && s->total - n >= s->taken) {
+        s->taken += n;
+        return true;
+    }
+
+    return false;
+}
+
+void coroutine_fn qemu_co_get_amount(QemuCoSharedAmount *s, uint64_t n)
+{
+    assert(n < s->total);
+    while (s->total - n < s->taken) {
+        qemu_co_queue_wait(&s->queue, NULL);
+    }
+
+    assert(qemu_co_try_get_amount(s, n));
+}
+
+void coroutine_fn qemu_co_put_amount(QemuCoSharedAmount *s, uint64_t n)
+{
+    assert(n <= s->taken);
+    s->taken -= n;
+    qemu_co_queue_restart_all(&s->queue);
+}
diff --git a/util/Makefile.objs b/util/Makefile.objs
index 41bf59d127..65ae18993a 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -37,6 +37,7 @@ util-obj-y += rcu.o
 util-obj-$(CONFIG_MEMBARRIER) += sys_membarrier.o
 util-obj-y += qemu-coroutine.o qemu-coroutine-lock.o qemu-coroutine-io.o
 util-obj-y += qemu-coroutine-sleep.o
+util-obj-y += qemu-co-shared-amount.o
 util-obj-y += coroutine-$(CONFIG_COROUTINE_BACKEND).o
 util-obj-y += buffer.o
 util-obj-y += timed-average.o
-- 
2.21.0


