Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD795C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 16:21:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3D832081C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 16:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D832081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54110 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMESJ-0002Yn-Oy
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 12:21:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMEKw-00049j-5c
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMEKv-0002Js-3P
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hMEKu-0002Jk-Rn
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F00459450;
	Thu,  2 May 2019 16:13:28 +0000 (UTC)
Received: from thuth.com (ovpn-116-131.ams2.redhat.com [10.36.116.131])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A0F8D17D58;
	Thu,  2 May 2019 16:13:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Thu,  2 May 2019 18:13:04 +0200
Message-Id: <20190502161310.15624-3-thuth@redhat.com>
In-Reply-To: <20190502161310.15624-1-thuth@redhat.com>
References: <20190502161310.15624-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Thu, 02 May 2019 16:13:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/8] qtest: Move accel code to accel/qtest.c
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
Cc: Eduardo Otubo <otubo@redhat.com>, Helge Deller <deller@gmx.de>,
	Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502161304.Hxfmy3CX1rBUwBtZVzl0foE4k_Ufa5dRGHd3Bf1H1B8@z>

From: Eduardo Habkost <ehabkost@redhat.com>

QTest has two parts: the server (-qtest) and the accelerator
(-machine accel=3Dqtest).  The accelerator depends on CONFIG_POSIX
due to its usage of sigwait(), but the server doesn't.

Move the accel code to accel/qtest.c.  Later we will disable
compilation of accel/qtest.c on non-POSIX systems.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20190422210448.2488-2-ehabkost@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
[thuth: added fixup for MAINTAINERS file]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS         |  1 +
 accel/Makefile.objs |  1 +
 accel/qtest.c       | 55 +++++++++++++++++++++++++++++++++++++++++++++
 qtest.c             | 34 ----------------------------
 4 files changed, 57 insertions(+), 34 deletions(-)
 create mode 100644 accel/qtest.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7dd71e0a2d..66ddbda9c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2035,6 +2035,7 @@ M: Laurent Vivier <lvivier@redhat.com>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: qtest.c
+F: accel/qtest.c
 F: tests/libqtest.*
 F: tests/libqos/
 F: tests/*-test.c
diff --git a/accel/Makefile.objs b/accel/Makefile.objs
index c3718a10c5..2a5ed46940 100644
--- a/accel/Makefile.objs
+++ b/accel/Makefile.objs
@@ -1,4 +1,5 @@
 obj-$(CONFIG_SOFTMMU) +=3D accel.o
+obj-$(CONFIG_SOFTMMU) +=3D qtest.o
 obj-$(CONFIG_KVM) +=3D kvm/
 obj-$(CONFIG_TCG) +=3D tcg/
 obj-y +=3D stubs/
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
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
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
+    QemuOpts *opts =3D qemu_opts_create(qemu_find_opts("icount"), NULL, =
0,
+                                      &error_abort);
+    qemu_opt_set(opts, "shift", "0", &error_abort);
+    configure_icount(opts, &error_abort);
+    qemu_opts_del(opts);
+    return 0;
+}
+
+static void qtest_accel_class_init(ObjectClass *oc, void *data)
+{
+    AccelClass *ac =3D ACCEL_CLASS(oc);
+    ac->name =3D "QTest";
+    ac->available =3D qtest_available;
+    ac->init_machine =3D qtest_init_accel;
+    ac->allowed =3D &qtest_allowed;
+}
+
+#define TYPE_QTEST_ACCEL ACCEL_CLASS_NAME("qtest")
+
+static const TypeInfo qtest_accel_type =3D {
+    .name =3D TYPE_QTEST_ACCEL,
+    .parent =3D TYPE_ACCEL,
+    .class_init =3D qtest_accel_class_init,
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
=20
-static int qtest_init_accel(MachineState *ms)
-{
-    QemuOpts *opts =3D qemu_opts_create(qemu_find_opts("icount"), NULL, =
0,
-                                      &error_abort);
-    qemu_opt_set(opts, "shift", "0", &error_abort);
-    configure_icount(opts, &error_abort);
-    qemu_opts_del(opts);
-    return 0;
-}
-
 void qtest_init(const char *qtest_chrdev, const char *qtest_log, Error *=
*errp)
 {
     Chardev *chr;
@@ -791,27 +781,3 @@ bool qtest_driver(void)
 {
     return qtest_chr.chr !=3D NULL;
 }
-
-static void qtest_accel_class_init(ObjectClass *oc, void *data)
-{
-    AccelClass *ac =3D ACCEL_CLASS(oc);
-    ac->name =3D "QTest";
-    ac->available =3D qtest_available;
-    ac->init_machine =3D qtest_init_accel;
-    ac->allowed =3D &qtest_allowed;
-}
-
-#define TYPE_QTEST_ACCEL ACCEL_CLASS_NAME("qtest")
-
-static const TypeInfo qtest_accel_type =3D {
-    .name =3D TYPE_QTEST_ACCEL,
-    .parent =3D TYPE_ACCEL,
-    .class_init =3D qtest_accel_class_init,
-};
-
-static void qtest_type_init(void)
-{
-    type_register_static(&qtest_accel_type);
-}
-
-type_init(qtest_type_init);
--=20
2.21.0


