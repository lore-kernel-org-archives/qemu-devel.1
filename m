Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1020CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8041820B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8041820B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMsH6-0003da-Dh
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 07:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iMsB5-0004Bt-8s
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:18:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iMsB3-0007hl-Ib
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:18:15 -0400
Received: from relay.sw.ru ([185.231.240.75]:51908)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iMsB0-0007dk-2y; Tue, 22 Oct 2019 07:18:10 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iMsAw-0003JX-PD; Tue, 22 Oct 2019 14:18:06 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 4/6] util: introduce SharedResource
Date: Tue, 22 Oct 2019 14:18:03 +0300
Message-Id: <20191022111805.3432-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191022111805.3432-1-vsementsov@virtuozzo.com>
References: <20191022111805.3432-1-vsementsov@virtuozzo.com>
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

Introduce an API for some shared splittable resource, like memory.
It's going to be used by backup. Backup uses both read/write io and
copy_range. copy_range may consume memory implictly, so the new API is
abstract: it doesn't allocate any real memory but only hands out
tickets.

The idea is that we have some total amount of something and callers
should wait in coroutine queue if there is not enough of the resource
at the moment.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/qemu/co-shared-resource.h | 71 +++++++++++++++++++++++++++++
 util/qemu-co-shared-resource.c    | 76 +++++++++++++++++++++++++++++++
 util/Makefile.objs                |  1 +
 3 files changed, 148 insertions(+)
 create mode 100644 include/qemu/co-shared-resource.h
 create mode 100644 util/qemu-co-shared-resource.c

diff --git a/include/qemu/co-shared-resource.h b/include/qemu/co-shared-resource.h
new file mode 100644
index 0000000000..4e4503004c
--- /dev/null
+++ b/include/qemu/co-shared-resource.h
@@ -0,0 +1,71 @@
+/*
+ * Helper functionality for distributing a fixed total amount of
+ * an abstract resource among multiple coroutines.
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
+#ifndef QEMU_CO_SHARED_RESOURCE_H
+#define QEMU_CO_SHARED_RESOURCE_H
+
+
+typedef struct SharedResource SharedResource;
+
+/*
+ * Create SharedResource structure
+ *
+ * @total: total amount of some resource to be shared between clients
+ *
+ * Note: this API is not thread-safe.
+ */
+SharedResource *shres_create(uint64_t total);
+
+/*
+ * Release SharedResource structure
+ *
+ * This function may only be called once everything allocated by all
+ * clients has been deallocated.
+ */
+void shres_destroy(SharedResource *s);
+
+/*
+ * Try to allocate an amount of @n.  Return true on success, and false
+ * if there is too little left of the collective resource to fulfill
+ * the request.
+ */
+bool co_try_get_from_shres(SharedResource *s, uint64_t n);
+
+/*
+ * Allocate an amount of @n, and, if necessary, yield until
+ * that becomes possible.
+ */
+void coroutine_fn co_get_from_shres(SharedResource *s, uint64_t n);
+
+/*
+ * Deallocate an amount of @n.  The total amount allocated by a caller
+ * does not need to be deallocated/released with a single call, but may
+ * be split over several calls.  For example, get(4), get(3), and then
+ * put(5), put(2).
+ */
+void coroutine_fn co_put_to_shres(SharedResource *s, uint64_t n);
+
+
+#endif /* QEMU_CO_SHARED_RESOURCE_H */
diff --git a/util/qemu-co-shared-resource.c b/util/qemu-co-shared-resource.c
new file mode 100644
index 0000000000..1c83cd9d29
--- /dev/null
+++ b/util/qemu-co-shared-resource.c
@@ -0,0 +1,76 @@
+/*
+ * Helper functionality for distributing a fixed total amount of
+ * an abstract resource among multiple coroutines.
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
+#include "qemu/co-shared-resource.h"
+
+struct SharedResource {
+    uint64_t total;
+    uint64_t available;
+
+    CoQueue queue;
+};
+
+SharedResource *shres_create(uint64_t total)
+{
+    SharedResource *s = g_new0(SharedResource, 1);
+
+    s->total = s->available = total;
+    qemu_co_queue_init(&s->queue);
+
+    return s;
+}
+
+void shres_destroy(SharedResource *s)
+{
+    assert(s->available == s->total);
+    g_free(s);
+}
+
+bool co_try_get_from_shres(SharedResource *s, uint64_t n)
+{
+    if (s->available >= n) {
+        s->available -= n;
+        return true;
+    }
+
+    return false;
+}
+
+void coroutine_fn co_get_from_shres(SharedResource *s, uint64_t n)
+{
+    assert(n <= s->total);
+    while (!co_try_get_from_shres(s, n)) {
+        qemu_co_queue_wait(&s->queue, NULL);
+    }
+}
+
+void coroutine_fn co_put_to_shres(SharedResource *s, uint64_t n)
+{
+    assert(s->total - s->available >= n);
+    s->available += n;
+    qemu_co_queue_restart_all(&s->queue);
+}
diff --git a/util/Makefile.objs b/util/Makefile.objs
index 41bf59d127..df124af1c5 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -37,6 +37,7 @@ util-obj-y += rcu.o
 util-obj-$(CONFIG_MEMBARRIER) += sys_membarrier.o
 util-obj-y += qemu-coroutine.o qemu-coroutine-lock.o qemu-coroutine-io.o
 util-obj-y += qemu-coroutine-sleep.o
+util-obj-y += qemu-co-shared-resource.o
 util-obj-y += coroutine-$(CONFIG_COROUTINE_BACKEND).o
 util-obj-y += buffer.o
 util-obj-y += timed-average.o
-- 
2.21.0


