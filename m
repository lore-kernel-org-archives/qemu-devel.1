Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFADC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:54:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD4D0227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ESCinfAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4D0227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvKE-0006LY-D9
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:54:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ihuz4-0001em-H1
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:32:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ihuz1-0007Pt-TH
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:32:50 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32929
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ihuz1-0007N6-KT
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:32:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Ma/H5NbB9BGAt4xU8QspKxhJxth7q7yxK/1QFdxJ84=;
 b=ESCinfAV7i320DJDwgnXlaaEmDa80hp8RO8vSfp6D/Fl+nfg8JUq1xWu4Ng4pVg5kHAfth
 HnkpT1YZ6fR9T6qKRJR7kN5V+5QbgHPBaVG3UhDivBZVW1br5g1VnZyY6bgJJVc0nKvcYt
 YYru2yZmkerz1zuyvdJgfuInqgZvkkQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-SernIptJN8KwJN9Lw5MCzg-1; Thu, 19 Dec 2019 07:32:45 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8084184BEC0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:32:44 +0000 (UTC)
Received: from localhost (ovpn-112-22.ams2.redhat.com [10.36.112.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 27E875C1B0;
 Thu, 19 Dec 2019 12:32:36 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 8/9] tests: add migration-helpers unit
Date: Thu, 19 Dec 2019 16:30:28 +0400
Message-Id: <20191219123029.200788-9-marcandre.lureau@redhat.com>
In-Reply-To: <20191219123029.200788-1-marcandre.lureau@redhat.com>
References: <20191219123029.200788-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: SernIptJN8KwJN9Lw5MCzg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: berrange@redhat.com, quintela@redhat.com, mprivozn@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move a few helper functions from migration-test.c to migration-helpers.c

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/Makefile.include    |   2 +-
 tests/migration-helpers.c | 167 ++++++++++++++++++++++++++++++++++++
 tests/migration-helpers.h |  37 ++++++++
 tests/migration-test.c    | 176 +++-----------------------------------
 4 files changed, 216 insertions(+), 166 deletions(-)
 create mode 100644 tests/migration-helpers.c
 create mode 100644 tests/migration-helpers.h

diff --git a/tests/Makefile.include b/tests/Makefile.include
index fa4140cbde..af88e8d6e1 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -827,7 +827,7 @@ tests/usb-hcd-uhci-test$(EXESUF): tests/usb-hcd-uhci-te=
st.o $(libqos-usb-obj-y)
 tests/usb-hcd-ehci-test$(EXESUF): tests/usb-hcd-ehci-test.o $(libqos-usb-o=
bj-y)
 tests/usb-hcd-xhci-test$(EXESUF): tests/usb-hcd-xhci-test.o $(libqos-usb-o=
bj-y)
 tests/cpu-plug-test$(EXESUF): tests/cpu-plug-test.o
-tests/migration-test$(EXESUF): tests/migration-test.o
+tests/migration-test$(EXESUF): tests/migration-test.o tests/migration-help=
ers.o
 tests/qemu-iotests/socket_scm_helper$(EXESUF): tests/qemu-iotests/socket_s=
cm_helper.o
 tests/test-qemu-opts$(EXESUF): tests/test-qemu-opts.o $(test-util-obj-y)
 tests/test-keyval$(EXESUF): tests/test-keyval.o $(test-util-obj-y) $(test-=
qapi-obj-y)
diff --git a/tests/migration-helpers.c b/tests/migration-helpers.c
new file mode 100644
index 0000000000..516093b39a
--- /dev/null
+++ b/tests/migration-helpers.c
@@ -0,0 +1,167 @@
+/*
+ * QTest migration helpers
+ *
+ * Copyright (c) 2016-2018 Red Hat, Inc. and/or its affiliates
+ *   based on the vhost-user-test.c that is:
+ *      Copyright (c) 2014 Virtual Open Systems Sarl.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/qmp/qjson.h"
+
+#include "migration-helpers.h"
+
+bool got_stop;
+
+static void stop_cb(void *opaque, const char *name, QDict *data)
+{
+    if (!strcmp(name, "STOP")) {
+        got_stop =3D true;
+    }
+}
+
+/*
+ * Events can get in the way of responses we are actually waiting for.
+ */
+QDict *wait_command_fd(QTestState *who, int fd, const char *command, ...)
+{
+    va_list ap;
+
+    va_start(ap, command);
+    qtest_qmp_vsend_fds(who, &fd, 1, command, ap);
+    va_end(ap);
+
+    return qtest_qmp_receive_success(who, stop_cb, NULL);
+}
+
+/*
+ * Events can get in the way of responses we are actually waiting for.
+ */
+QDict *wait_command(QTestState *who, const char *command, ...)
+{
+    va_list ap;
+
+    va_start(ap, command);
+    qtest_qmp_vsend(who, command, ap);
+    va_end(ap);
+
+    return qtest_qmp_receive_success(who, stop_cb, NULL);
+}
+
+/*
+ * Send QMP command "migrate".
+ * Arguments are built from @fmt... (formatted like
+ * qobject_from_jsonf_nofail()) with "uri": @uri spliced in.
+ */
+void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...)
+{
+    va_list ap;
+    QDict *args, *rsp;
+
+    va_start(ap, fmt);
+    args =3D qdict_from_vjsonf_nofail(fmt, ap);
+    va_end(ap);
+
+    g_assert(!qdict_haskey(args, "uri"));
+    qdict_put_str(args, "uri", uri);
+
+    rsp =3D qtest_qmp(who, "{ 'execute': 'migrate', 'arguments': %p}", arg=
s);
+
+    g_assert(qdict_haskey(rsp, "return"));
+    qobject_unref(rsp);
+}
+
+/*
+ * Note: caller is responsible to free the returned object via
+ * qobject_unref() after use
+ */
+QDict *migrate_query(QTestState *who)
+{
+    return wait_command(who, "{ 'execute': 'query-migrate' }");
+}
+
+/*
+ * Note: caller is responsible to free the returned object via
+ * g_free() after use
+ */
+static gchar *migrate_query_status(QTestState *who)
+{
+    QDict *rsp_return =3D migrate_query(who);
+    gchar *status =3D g_strdup(qdict_get_str(rsp_return, "status"));
+
+    g_assert(status);
+    qobject_unref(rsp_return);
+
+    return status;
+}
+
+static bool check_migration_status(QTestState *who, const char *goal,
+                                   const char **ungoals)
+{
+    bool ready;
+    char *current_status;
+    const char **ungoal;
+
+    current_status =3D migrate_query_status(who);
+    ready =3D strcmp(current_status, goal) =3D=3D 0;
+    if (!ungoals) {
+        g_assert_cmpstr(current_status, !=3D, "failed");
+        /*
+         * If looking for a state other than completed,
+         * completion of migration would cause the test to
+         * hang.
+         */
+        if (strcmp(goal, "completed") !=3D 0) {
+            g_assert_cmpstr(current_status, !=3D, "completed");
+        }
+    } else {
+        for (ungoal =3D ungoals; *ungoal; ungoal++) {
+            g_assert_cmpstr(current_status, !=3D,  *ungoal);
+        }
+    }
+    g_free(current_status);
+    return ready;
+}
+
+void wait_for_migration_status(QTestState *who,
+                               const char *goal, const char **ungoals)
+{
+    while (!check_migration_status(who, goal, ungoals)) {
+        usleep(1000);
+    }
+}
+
+void wait_for_migration_complete(QTestState *who)
+{
+    wait_for_migration_status(who, "completed", NULL);
+}
+
+void wait_for_migration_fail(QTestState *from, bool allow_active)
+{
+    QDict *rsp_return;
+    char *status;
+    bool failed;
+
+    do {
+        status =3D migrate_query_status(from);
+        bool result =3D !strcmp(status, "setup") || !strcmp(status, "faile=
d") ||
+            (allow_active && !strcmp(status, "active"));
+        if (!result) {
+            fprintf(stderr, "%s: unexpected status status=3D%s allow_activ=
e=3D%d\n",
+                    __func__, status, allow_active);
+        }
+        g_assert(result);
+        failed =3D !strcmp(status, "failed");
+        g_free(status);
+    } while (!failed);
+
+    /* Is the machine currently running? */
+    rsp_return =3D wait_command(from, "{ 'execute': 'query-status' }");
+    g_assert(qdict_haskey(rsp_return, "running"));
+    g_assert(qdict_get_bool(rsp_return, "running"));
+    qobject_unref(rsp_return);
+}
diff --git a/tests/migration-helpers.h b/tests/migration-helpers.h
new file mode 100644
index 0000000000..a11808b3b7
--- /dev/null
+++ b/tests/migration-helpers.h
@@ -0,0 +1,37 @@
+/*
+ * QTest migration helpers
+ *
+ * Copyright (c) 2016-2018 Red Hat, Inc. and/or its affiliates
+ *   based on the vhost-user-test.c that is:
+ *      Copyright (c) 2014 Virtual Open Systems Sarl.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+#ifndef MIGRATION_HELPERS_H_
+#define MIGRATION_HELPERS_H_
+
+#include "libqtest.h"
+
+extern bool got_stop;
+
+GCC_FMT_ATTR(3, 4)
+QDict *wait_command_fd(QTestState *who, int fd, const char *command, ...);
+
+GCC_FMT_ATTR(2, 3)
+QDict *wait_command(QTestState *who, const char *command, ...);
+
+GCC_FMT_ATTR(3, 4)
+void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...);
+
+QDict *migrate_query(QTestState *who);
+
+void wait_for_migration_status(QTestState *who,
+                               const char *goal, const char **ungoals);
+
+void wait_for_migration_complete(QTestState *who);
+
+void wait_for_migration_fail(QTestState *from, bool allow_active);
+
+#endif /* MIGRATION_HELPERS_H_ */
diff --git a/tests/migration-test.c b/tests/migration-test.c
index a5343fdc66..03fb1f1328 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -14,7 +14,6 @@
=20
 #include "libqtest.h"
 #include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qjson.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/range.h"
@@ -24,6 +23,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
=20
+#include "migration-helpers.h"
 #include "migration/migration-test.h"
=20
 /* TODO actually test the results and get rid of this */
@@ -31,7 +31,6 @@
=20
 unsigned start_address;
 unsigned end_address;
-bool got_stop;
 static bool uffd_feature_thread_id;
=20
 #if defined(__linux__)
@@ -157,67 +156,6 @@ static void wait_for_serial(const char *side)
     } while (true);
 }
=20
-static void stop_cb(void *opaque, const char *name, QDict *data)
-{
-    if (!strcmp(name, "STOP")) {
-        got_stop =3D true;
-    }
-}
-
-/*
- * Events can get in the way of responses we are actually waiting for.
- */
-GCC_FMT_ATTR(3, 4)
-static QDict *wait_command_fd(QTestState *who, int fd, const char *command=
, ...)
-{
-    va_list ap;
-
-    va_start(ap, command);
-    qtest_qmp_vsend_fds(who, &fd, 1, command, ap);
-    va_end(ap);
-
-    return qtest_qmp_receive_success(who, stop_cb, NULL);
-}
-
-/*
- * Events can get in the way of responses we are actually waiting for.
- */
-GCC_FMT_ATTR(2, 3)
-static QDict *wait_command(QTestState *who, const char *command, ...)
-{
-    va_list ap;
-
-    va_start(ap, command);
-    qtest_qmp_vsend(who, command, ap);
-    va_end(ap);
-
-    return qtest_qmp_receive_success(who, stop_cb, NULL);
-}
-
-/*
- * Note: caller is responsible to free the returned object via
- * qobject_unref() after use
- */
-static QDict *migrate_query(QTestState *who)
-{
-    return wait_command(who, "{ 'execute': 'query-migrate' }");
-}
-
-/*
- * Note: caller is responsible to free the returned object via
- * g_free() after use
- */
-static gchar *migrate_query_status(QTestState *who)
-{
-    QDict *rsp_return =3D migrate_query(who);
-    gchar *status =3D g_strdup(qdict_get_str(rsp_return, "status"));
-
-    g_assert(status);
-    qobject_unref(rsp_return);
-
-    return status;
-}
-
 /*
  * It's tricky to use qemu's migration event capability with qtest,
  * events suddenly appearing confuse the qmp()/hmp() responses.
@@ -265,48 +203,6 @@ static void read_blocktime(QTestState *who)
     qobject_unref(rsp_return);
 }
=20
-static bool check_migration_status(QTestState *who, const char *goal,
-                                   const char **ungoals)
-{
-    bool ready;
-    char *current_status;
-    const char **ungoal;
-
-    current_status =3D migrate_query_status(who);
-    ready =3D strcmp(current_status, goal) =3D=3D 0;
-    if (!ungoals) {
-        g_assert_cmpstr(current_status, !=3D, "failed");
-        /*
-         * If looking for a state other than completed,
-         * completion of migration would cause the test to
-         * hang.
-         */
-        if (strcmp(goal, "completed") !=3D 0) {
-            g_assert_cmpstr(current_status, !=3D, "completed");
-        }
-    } else {
-        for (ungoal =3D ungoals; *ungoal; ungoal++) {
-            g_assert_cmpstr(current_status, !=3D,  *ungoal);
-        }
-    }
-    g_free(current_status);
-    return ready;
-}
-
-static void wait_for_migration_status(QTestState *who,
-                                      const char *goal,
-                                      const char **ungoals)
-{
-    while (!check_migration_status(who, goal, ungoals)) {
-        usleep(1000);
-    }
-}
-
-static void wait_for_migration_complete(QTestState *who)
-{
-    wait_for_migration_status(who, "completed", NULL);
-}
-
 static void wait_for_migration_pass(QTestState *who)
 {
     uint64_t initial_pass =3D get_migration_pass(who);
@@ -513,30 +409,6 @@ static void migrate_set_capability(QTestState *who, co=
nst char *capability,
     qobject_unref(rsp);
 }
=20
-/*
- * Send QMP command "migrate".
- * Arguments are built from @fmt... (formatted like
- * qobject_from_jsonf_nofail()) with "uri": @uri spliced in.
- */
-GCC_FMT_ATTR(3, 4)
-static void migrate(QTestState *who, const char *uri, const char *fmt, ...=
)
-{
-    va_list ap;
-    QDict *args, *rsp;
-
-    va_start(ap, fmt);
-    args =3D qdict_from_vjsonf_nofail(fmt, ap);
-    va_end(ap);
-
-    g_assert(!qdict_haskey(args, "uri"));
-    qdict_put_str(args, "uri", uri);
-
-    rsp =3D qtest_qmp(who, "{ 'execute': 'migrate', 'arguments': %p}", arg=
s);
-
-    g_assert(qdict_haskey(rsp, "return"));
-    qobject_unref(rsp);
-}
-
 static void migrate_postcopy_start(QTestState *from, QTestState *to)
 {
     QDict *rsp;
@@ -795,7 +667,7 @@ static int migrate_postcopy_prepare(QTestState **from_p=
tr,
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
=20
-    migrate(from, uri, "{}");
+    migrate_qmp(from, uri, "{}");
     g_free(uri);
=20
     wait_for_migration_pass(from);
@@ -882,7 +754,7 @@ static void test_postcopy_recovery(void)
     wait_for_migration_status(from, "postcopy-paused",
                               (const char * []) { "failed", "active",
                                                   "completed", NULL });
-    migrate(from, uri, "{'resume': true}");
+    migrate_qmp(from, uri, "{'resume': true}");
     g_free(uri);
=20
     /* Restore the postcopy bandwidth to unlimited */
@@ -891,32 +763,6 @@ static void test_postcopy_recovery(void)
     migrate_postcopy_complete(from, to);
 }
=20
-static void wait_for_migration_fail(QTestState *from, bool allow_active)
-{
-    QDict *rsp_return;
-    char *status;
-    bool failed;
-
-    do {
-        status =3D migrate_query_status(from);
-        bool result =3D !strcmp(status, "setup") || !strcmp(status, "faile=
d") ||
-                 (allow_active && !strcmp(status, "active"));
-        if (!result) {
-            fprintf(stderr, "%s: unexpected status status=3D%s allow_activ=
e=3D%d\n",
-                    __func__, status, allow_active);
-        }
-        g_assert(result);
-        failed =3D !strcmp(status, "failed");
-        g_free(status);
-    } while (!failed);
-
-    /* Is the machine currently running? */
-    rsp_return =3D wait_command(from, "{ 'execute': 'query-status' }");
-    g_assert(qdict_haskey(rsp_return, "running"));
-    g_assert(qdict_get_bool(rsp_return, "running"));
-    qobject_unref(rsp_return);
-}
-
 static void test_baddest(void)
 {
     QTestState *from, *to;
@@ -924,7 +770,7 @@ static void test_baddest(void)
     if (test_migrate_start(&from, &to, "tcp:0:0", true, false, NULL, NULL)=
) {
         return;
     }
-    migrate(from, "tcp:0:0", "{}");
+    migrate_qmp(from, "tcp:0:0", "{}");
     wait_for_migration_fail(from, false);
     test_migrate_end(from, to, false);
 }
@@ -950,7 +796,7 @@ static void test_precopy_unix(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
=20
-    migrate(from, uri, "{}");
+    migrate_qmp(from, uri, "{}");
=20
     wait_for_migration_pass(from);
=20
@@ -987,7 +833,7 @@ static void test_ignore_shared(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
=20
-    migrate(from, uri, "{}");
+    migrate_qmp(from, uri, "{}");
=20
     wait_for_migration_pass(from);
=20
@@ -1033,7 +879,7 @@ static void test_xbzrle(const char *uri)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
=20
-    migrate(from, uri, "{}");
+    migrate_qmp(from, uri, "{}");
=20
     wait_for_migration_pass(from);
=20
@@ -1084,7 +930,7 @@ static void test_precopy_tcp(void)
=20
     uri =3D migrate_get_socket_address(to, "socket-address");
=20
-    migrate(from, uri, "{}");
+    migrate_qmp(from, uri, "{}");
=20
     wait_for_migration_pass(from);
=20
@@ -1152,7 +998,7 @@ static void test_migrate_fd_proto(void)
     close(pair[1]);
=20
     /* Start migration to the 2nd socket*/
-    migrate(from, "fd:fd-mig", "{}");
+    migrate_qmp(from, "fd:fd-mig", "{}");
=20
     wait_for_migration_pass(from);
=20
@@ -1210,7 +1056,7 @@ static void do_test_validate_uuid(const char *uuid_ar=
g_src,
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
=20
-    migrate(from, uri, "{}");
+    migrate_qmp(from, uri, "{}");
=20
     if (should_fail) {
         qtest_set_expected_status(to, 1);
@@ -1292,7 +1138,7 @@ static void test_migrate_auto_converge(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
=20
-    migrate(from, uri, "{}");
+    migrate_qmp(from, uri, "{}");
=20
     /* Wait for throttling begins */
     percentage =3D 0;
--=20
2.24.0.308.g228f53135a


