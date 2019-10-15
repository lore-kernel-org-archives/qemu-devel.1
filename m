Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C8FECE58F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 21:41:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8326320873
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 21:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8326320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKUZQ-0001Zl-Tv
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 17:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iKUVs-0004ox-6h
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 17:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iKUVq-0006fX-Sj
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 17:37:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39784)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iKUVq-0006fL-Ke
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 17:37:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BC30A18C893A;
 Tue, 15 Oct 2019 21:37:49 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B5365C231;
 Tue, 15 Oct 2019 21:37:49 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
 qemu-devel@nongnu.org
Subject: [PULL 01/18] tests: add qtest_qmp_device_add_qdict() helper
Date: Tue, 15 Oct 2019 18:37:28 -0300
Message-Id: <20191015213745.22174-2-ehabkost@redhat.com>
In-Reply-To: <20191015213745.22174-1-ehabkost@redhat.com>
References: <20191015213745.22174-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Tue, 15 Oct 2019 21:37:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

Add an API that takes QDict directly, so users could skip steps
of first building json dictionary and converting it back to
QDict in existing qtest_qmp_device_add() and instead use QDict
directly without intermediate conversion.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20190830110723.15096-2-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/libqtest.h | 12 ++++++++++++
 tests/libqtest.c | 29 +++++++++++++++++++----------
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index a177e502d9..c9e21e05b3 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -659,6 +659,18 @@ QDict *qmp_fd(int fd, const char *fmt, ...) GCC_FMT_=
ATTR(2, 3);
 void qtest_cb_for_every_machine(void (*cb)(const char *machine),
                                 bool skip_old_versioned);
=20
+/**
+ * qtest_qmp_device_add_qdict:
+ * @qts: QTestState instance to operate on
+ * @drv: Name of the device that should be added
+ * @arguments: QDict with properties for the device to intialize
+ *
+ * Generic hot-plugging test via the device_add QMP command with propert=
ies
+ * supplied in form of QDict. Use NULL for empty properties list.
+ */
+void qtest_qmp_device_add_qdict(QTestState *qts, const char *drv,
+                                const QDict *arguments);
+
 /**
  * qtest_qmp_device_add:
  * @qts: QTestState instance to operate on
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 38e4f5b587..3706bccd8d 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -1243,28 +1243,37 @@ QDict *qtest_qmp_receive_success(QTestState *s,
 }
=20
 /*
- * Generic hot-plugging test via the device_add QMP command.
+ * Generic hot-plugging test via the device_add QMP commands.
  */
+void qtest_qmp_device_add_qdict(QTestState *qts, const char *drv,
+                                const QDict *arguments)
+{
+    QDict *resp;
+    QDict *args =3D arguments ? qdict_clone_shallow(arguments) : qdict_n=
ew();
+
+    g_assert(!qdict_haskey(args, "driver"));
+    qdict_put_str(args, "driver", drv);
+    resp =3D qtest_qmp(qts, "{'execute': 'device_add', 'arguments': %p}"=
, args);
+    g_assert(resp);
+    g_assert(!qdict_haskey(resp, "event")); /* We don't expect any event=
s */
+    g_assert(!qdict_haskey(resp, "error"));
+    qobject_unref(resp);
+}
+
 void qtest_qmp_device_add(QTestState *qts, const char *driver, const cha=
r *id,
                           const char *fmt, ...)
 {
-    QDict *args, *response;
+    QDict *args;
     va_list ap;
=20
     va_start(ap, fmt);
     args =3D qdict_from_vjsonf_nofail(fmt, ap);
     va_end(ap);
=20
-    g_assert(!qdict_haskey(args, "driver") && !qdict_haskey(args, "id"))=
;
-    qdict_put_str(args, "driver", driver);
+    g_assert(!qdict_haskey(args, "id"));
     qdict_put_str(args, "id", id);
=20
-    response =3D qtest_qmp(qts, "{'execute': 'device_add', 'arguments': =
%p}",
-                         args);
-    g_assert(response);
-    g_assert(!qdict_haskey(response, "event")); /* We don't expect any e=
vents */
-    g_assert(!qdict_haskey(response, "error"));
-    qobject_unref(response);
+    qtest_qmp_device_add_qdict(qts, driver, args);
 }
=20
 static void device_deleted_cb(void *opaque, const char *name, QDict *dat=
a)
--=20
2.21.0


