Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C611C3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 11:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FEE7215EA
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 11:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FEE7215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3epv-0006Kh-4a
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 07:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1i3ekx-0003cY-7u
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 07:07:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1i3eko-0001jx-Ga
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 07:07:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56780)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1i3ekj-0001WB-4t; Fri, 30 Aug 2019 07:07:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A207F3C91A;
 Fri, 30 Aug 2019 11:07:31 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A10E5D717;
 Fri, 30 Aug 2019 11:07:30 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 30 Aug 2019 07:07:22 -0400
Message-Id: <20190830110723.15096-2-imammedo@redhat.com>
In-Reply-To: <20190830110723.15096-1-imammedo@redhat.com>
References: <20190830110723.15096-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 30 Aug 2019 11:07:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/2] tests: add qtest_qmp_device_add_qdict()
 helper
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
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, dhildenb@redhat.com,
 ehabkost@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add an API that takes QDict directly, so users could skip steps
of first building json dictionary and converting it back to
QDict in existing qtest_qmp_device_add() and instead use QDict
directly without intermediate conversion.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/libqtest.h | 12 ++++++++++++
 tests/libqtest.c | 29 +++++++++++++++++++----------
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 07ea35867c..0788f70954 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -948,6 +948,18 @@ QDict *qmp_fd(int fd, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
 void qtest_cb_for_every_machine(void (*cb)(const char *machine),
                                 bool skip_old_versioned);
 
+/**
+ * qtest_qmp_device_add_qdict:
+ * @qts: QTestState instance to operate on
+ * @drv: Name of the device that should be added
+ * @arguments: QDict with properties for the device to intialize
+ *
+ * Generic hot-plugging test via the device_add QMP command with properties
+ * supplied in form of QDict. Use NULL for empty properties list.
+ */
+void qtest_qmp_device_add_qdict(QTestState *qts, const char *drv,
+                                const QDict *arguments);
+
 /**
  * qtest_qmp_device_add:
  * @qts: QTestState instance to operate on
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 2713b86cf7..13d52f5cf3 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -1250,28 +1250,37 @@ QDict *qtest_qmp_receive_success(QTestState *s,
 }
 
 /*
- * Generic hot-plugging test via the device_add QMP command.
+ * Generic hot-plugging test via the device_add QMP commands.
  */
+void qtest_qmp_device_add_qdict(QTestState *qts, const char *drv,
+                                const QDict *arguments)
+{
+    QDict *resp;
+    QDict *args = arguments ? qdict_clone_shallow(arguments) : qdict_new();
+
+    g_assert(!qdict_haskey(args, "driver"));
+    qdict_put_str(args, "driver", drv);
+    resp = qtest_qmp(qts, "{'execute': 'device_add', 'arguments': %p}", args);
+    g_assert(resp);
+    g_assert(!qdict_haskey(resp, "event")); /* We don't expect any events */
+    g_assert(!qdict_haskey(resp, "error"));
+    qobject_unref(resp);
+}
+
 void qtest_qmp_device_add(QTestState *qts, const char *driver, const char *id,
                           const char *fmt, ...)
 {
-    QDict *args, *response;
+    QDict *args;
     va_list ap;
 
     va_start(ap, fmt);
     args = qdict_from_vjsonf_nofail(fmt, ap);
     va_end(ap);
 
-    g_assert(!qdict_haskey(args, "driver") && !qdict_haskey(args, "id"));
-    qdict_put_str(args, "driver", driver);
+    g_assert(!qdict_haskey(args, "id"));
     qdict_put_str(args, "id", id);
 
-    response = qtest_qmp(qts, "{'execute': 'device_add', 'arguments': %p}",
-                         args);
-    g_assert(response);
-    g_assert(!qdict_haskey(response, "event")); /* We don't expect any events */
-    g_assert(!qdict_haskey(response, "error"));
-    qobject_unref(response);
+    qtest_qmp_device_add_qdict(qts, driver, args);
 }
 
 static void device_deleted_cb(void *opaque, const char *name, QDict *data)
-- 
2.18.1


