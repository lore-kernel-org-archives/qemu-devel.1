Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF512C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 14:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84B44208C3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 14:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B44208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55561 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOjz7-00055u-Jt
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 10:25:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hOjy1-0004Uj-JI
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hOjy0-0000Kf-M5
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:24:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hOjy0-0000KU-H4
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:24:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A8603007E66;
	Thu,  9 May 2019 14:24:11 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.40.205.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5337D646A1;
	Thu,  9 May 2019 14:23:43 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 16:23:42 +0200
Message-Id: <20190509142342.6132-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Thu, 09 May 2019 14:24:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC] rng-builtin: add an RNG backend that uses
 qemu_guest_getrandom()
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
Cc: Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
	Kashyap Chamarthy <kchamart@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Markus Armbruster <armbru@redhat.com>,
	"Richard W . M . Jones" <rjones@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a new RNG backend using QEMU builtin getrandom function.

It can be created with "-object rng-builtin".

This patch applies on top of
"[PATCH v4 00/24] Add qemu_getrandom and ARMv8.5-RNG etc"
Based-on: <20190506173353.32206-1-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 backends/Makefile.objs |  2 +-
 backends/rng-builtin.c | 56 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 1 deletion(-)
 create mode 100644 backends/rng-builtin.c

diff --git a/backends/Makefile.objs b/backends/Makefile.objs
index ff619d31b461..8da4a508d97b 100644
--- a/backends/Makefile.objs
+++ b/backends/Makefile.objs
@@ -1,4 +1,4 @@
-common-obj-y +=3D rng.o rng-egd.o
+common-obj-y +=3D rng.o rng-egd.o rng-builtin.o
 common-obj-$(CONFIG_POSIX) +=3D rng-random.o
=20
 common-obj-$(CONFIG_TPM) +=3D tpm.o
diff --git a/backends/rng-builtin.c b/backends/rng-builtin.c
new file mode 100644
index 000000000000..b1264b745407
--- /dev/null
+++ b/backends/rng-builtin.c
@@ -0,0 +1,56 @@
+/*
+ * QEMU Builtin Random Number Generator Backend
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "sysemu/rng.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qerror.h"
+#include "qemu/main-loop.h"
+#include "qemu/guest-random.h"
+
+#define TYPE_RNG_BUILTIN "rng-builtin"
+#define RNG_BUILTIN(obj) OBJECT_CHECK(RngBuiltin, (obj), TYPE_RNG_BUILTI=
N)
+
+typedef struct RngBuiltin {
+    RngBackend parent;
+} RngBuiltin;
+
+static void rng_builtin_request_entropy(RngBackend *b, RngRequest *req)
+{
+    RngBuiltin *s =3D RNG_BUILTIN(b);
+
+    while (!QSIMPLEQ_EMPTY(&s->parent.requests)) {
+        RngRequest *req =3D QSIMPLEQ_FIRST(&s->parent.requests);
+
+        qemu_guest_getrandom_nofail(req->data, req->size);
+
+        req->receive_entropy(req->opaque, req->data, req->size);
+
+        rng_backend_finalize_request(&s->parent, req);
+    }
+}
+
+static void rng_builtin_class_init(ObjectClass *klass, void *data)
+{
+    RngBackendClass *rbc =3D RNG_BACKEND_CLASS(klass);
+
+    rbc->request_entropy =3D rng_builtin_request_entropy;
+}
+
+static const TypeInfo rng_builtin_info =3D {
+    .name =3D TYPE_RNG_BUILTIN,
+    .parent =3D TYPE_RNG_BACKEND,
+    .instance_size =3D sizeof(RngBuiltin),
+    .class_init =3D rng_builtin_class_init,
+};
+
+static void register_types(void)
+{
+    type_register_static(&rng_builtin_info);
+}
+
+type_init(register_types);
--=20
2.20.1


