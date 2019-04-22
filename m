Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C38C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 21:14:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1077E20896
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 21:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1077E20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44318 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIgHC-0004XV-AQ
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 17:14:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hIgED-0002Td-Nt
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 17:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hIg7R-0000GT-Dw
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 17:04:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hIg7R-0000Fw-6M
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 17:04:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B3C3308339B
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 21:04:52 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EF2F75D9CA;
	Mon, 22 Apr 2019 21:04:51 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 22 Apr 2019 18:04:46 -0300
Message-Id: <20190422210448.2488-2-ehabkost@redhat.com>
In-Reply-To: <20190422210448.2488-1-ehabkost@redhat.com>
References: <20190422210448.2488-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Mon, 22 Apr 2019 21:04:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/3] qtest: Move accel code to accel/qtest.c
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190422210446.Lr8Of6J-le6W8lsqLhzEuMoeaUG8BEFD2YJ-yLoHbo4@z>

QTest has two parts: the server (-qtest) and the accelerator
(-machine accel=qtest).  The accelerator depends on CONFIG_POSIX
due to its usage of sigwait(), but the server doesn't.

Move the accel code to accel/qtest.c.  Later we will disable
compilation of accel/qtest.c on non-POSIX systems.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 accel/qtest.c       | 55 +++++++++++++++++++++++++++++++++++++++++++++
 qtest.c             | 34 ----------------------------
 accel/Makefile.objs |  1 +
 3 files changed, 56 insertions(+), 34 deletions(-)
 create mode 100644 accel/qtest.c

diff --git a/accel/qtest.c b/accel/qtest.c
new file mode 100644
index 0000000000..a02b3c26c7
--- /dev/null
+++ b/accel/qtest.c
@@ -0,0 +1,55 @@
+/*
+ * QTest accelerator code
+ *
+ * Copyright IBM, Corp. 2011
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "qemu/option.h"
+#include "qemu/config-file.h"
+#include "sysemu/accel.h"
+#include "sysemu/qtest.h"
+#include "sysemu/cpus.h"
+
+static int qtest_init_accel(MachineState *ms)
+{
+    QemuOpts *opts = qemu_opts_create(qemu_find_opts("icount"), NULL, 0,
+                                      &error_abort);
+    qemu_opt_set(opts, "shift", "0", &error_abort);
+    configure_icount(opts, &error_abort);
+    qemu_opts_del(opts);
+    return 0;
+}
+
+static void qtest_accel_class_init(ObjectClass *oc, void *data)
+{
+    AccelClass *ac = ACCEL_CLASS(oc);
+    ac->name = "QTest";
+    ac->available = qtest_available;
+    ac->init_machine = qtest_init_accel;
+    ac->allowed = &qtest_allowed;
+}
+
+#define TYPE_QTEST_ACCEL ACCEL_CLASS_NAME("qtest")
+
+static const TypeInfo qtest_accel_type = {
+    .name = TYPE_QTEST_ACCEL,
+    .parent = TYPE_ACCEL,
+    .class_init = qtest_accel_class_init,
+};
+
+static void qtest_type_init(void)
+{
+    type_register_static(&qtest_accel_type);
+}
+
+type_init(qtest_type_init);
diff --git a/qtest.c b/qtest.c
index 527141785f..f2e2f27778 100644
--- a/qtest.c
+++ b/qtest.c
@@ -749,16 +749,6 @@ static void qtest_event(void *opaque, int event)
     }
 }
 
-static int qtest_init_accel(MachineState *ms)
-{
-    QemuOpts *opts = qemu_opts_create(qemu_find_opts("icount"), NULL, 0,
-                                      &error_abort);
-    qemu_opt_set(opts, "shift", "0", &error_abort);
-    configure_icount(opts, &error_abort);
-    qemu_opts_del(opts);
-    return 0;
-}
-
 void qtest_init(const char *qtest_chrdev, const char *qtest_log, Error **errp)
 {
     Chardev *chr;
@@ -791,27 +781,3 @@ bool qtest_driver(void)
 {
     return qtest_chr.chr != NULL;
 }
-
-static void qtest_accel_class_init(ObjectClass *oc, void *data)
-{
-    AccelClass *ac = ACCEL_CLASS(oc);
-    ac->name = "QTest";
-    ac->available = qtest_available;
-    ac->init_machine = qtest_init_accel;
-    ac->allowed = &qtest_allowed;
-}
-
-#define TYPE_QTEST_ACCEL ACCEL_CLASS_NAME("qtest")
-
-static const TypeInfo qtest_accel_type = {
-    .name = TYPE_QTEST_ACCEL,
-    .parent = TYPE_ACCEL,
-    .class_init = qtest_accel_class_init,
-};
-
-static void qtest_type_init(void)
-{
-    type_register_static(&qtest_accel_type);
-}
-
-type_init(qtest_type_init);
diff --git a/accel/Makefile.objs b/accel/Makefile.objs
index c3718a10c5..2a5ed46940 100644
--- a/accel/Makefile.objs
+++ b/accel/Makefile.objs
@@ -1,4 +1,5 @@
 obj-$(CONFIG_SOFTMMU) += accel.o
+obj-$(CONFIG_SOFTMMU) += qtest.o
 obj-$(CONFIG_KVM) += kvm/
 obj-$(CONFIG_TCG) += tcg/
 obj-y += stubs/
-- 
2.18.0.rc1.1.g3f1ff2140


