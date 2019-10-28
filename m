Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546D8CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:56:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C99C20873
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDMxkRV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C99C20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP4ZQ-0003pw-0A
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 08:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3wk-0002b3-4k
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3wi-0001s4-Cp
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54672
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3wi-0001rO-8E
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NLXLDNRwLKHMK2M0jKKx2XmiojPxKUfmgaG8PxKK2W8=;
 b=CDMxkRV26mJP8DUcpzxBw2ebxyQQInHYa8RkqWUe5iy1EXx/0PmJHfxRyV+/gsSKG5rz3k
 PZlZjMvnT1XrovI++dZTqh5E608x97XDq15TXO8u5HvtUb1uECpqWJ9U5hrIotrzsbFmue
 OYeNZRRMuc1XoXpnKgsOenek3ZY30+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-vtoB4tZoNAyLtoeVwvAN1g-1; Mon, 28 Oct 2019 08:16:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 271D6107AD28;
 Mon, 28 Oct 2019 12:16:24 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B35A5C1D6;
 Mon, 28 Oct 2019 12:16:23 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 39/69] util: introduce SharedResource
Date: Mon, 28 Oct 2019 13:14:31 +0100
Message-Id: <20191028121501.15279-40-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: vtoB4tZoNAyLtoeVwvAN1g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

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
Message-id: 20191022111805.3432-5-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 util/Makefile.objs                |  1 +
 include/qemu/co-shared-resource.h | 71 +++++++++++++++++++++++++++++
 util/qemu-co-shared-resource.c    | 76 +++++++++++++++++++++++++++++++
 3 files changed, 148 insertions(+)
 create mode 100644 include/qemu/co-shared-resource.h
 create mode 100644 util/qemu-co-shared-resource.c

diff --git a/util/Makefile.objs b/util/Makefile.objs
index 41bf59d127..df124af1c5 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -37,6 +37,7 @@ util-obj-y +=3D rcu.o
 util-obj-$(CONFIG_MEMBARRIER) +=3D sys_membarrier.o
 util-obj-y +=3D qemu-coroutine.o qemu-coroutine-lock.o qemu-coroutine-io.o
 util-obj-y +=3D qemu-coroutine-sleep.o
+util-obj-y +=3D qemu-co-shared-resource.o
 util-obj-y +=3D coroutine-$(CONFIG_COROUTINE_BACKEND).o
 util-obj-y +=3D buffer.o
 util-obj-y +=3D timed-average.o
diff --git a/include/qemu/co-shared-resource.h b/include/qemu/co-shared-res=
ource.h
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
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
+ * of this software and associated documentation files (the "Software"), t=
o deal
+ * in the Software without restriction, including without limitation the r=
ights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN
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
diff --git a/util/qemu-co-shared-resource.c b/util/qemu-co-shared-resource.=
c
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
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
+ * of this software and associated documentation files (the "Software"), t=
o deal
+ * in the Software without restriction, including without limitation the r=
ights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN
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
+    SharedResource *s =3D g_new0(SharedResource, 1);
+
+    s->total =3D s->available =3D total;
+    qemu_co_queue_init(&s->queue);
+
+    return s;
+}
+
+void shres_destroy(SharedResource *s)
+{
+    assert(s->available =3D=3D s->total);
+    g_free(s);
+}
+
+bool co_try_get_from_shres(SharedResource *s, uint64_t n)
+{
+    if (s->available >=3D n) {
+        s->available -=3D n;
+        return true;
+    }
+
+    return false;
+}
+
+void coroutine_fn co_get_from_shres(SharedResource *s, uint64_t n)
+{
+    assert(n <=3D s->total);
+    while (!co_try_get_from_shres(s, n)) {
+        qemu_co_queue_wait(&s->queue, NULL);
+    }
+}
+
+void coroutine_fn co_put_to_shres(SharedResource *s, uint64_t n)
+{
+    assert(s->total - s->available >=3D n);
+    s->available +=3D n;
+    qemu_co_queue_restart_all(&s->queue);
+}
--=20
2.21.0


