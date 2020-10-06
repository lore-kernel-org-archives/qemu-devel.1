Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3197CC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D8BE206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Etgfz7sM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D8BE206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPmHp-00033a-G4
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 08:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kPmFh-00017n-V1
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:39:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43495)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kPmFe-0007uV-9c
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601987969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b7kcWylIzEeeuI/BDC+p1ghoUDjqkSMgRnDXz2QMLN0=;
 b=Etgfz7sMCoehM8qKrzBCTop6MU6vAFYrwb4T/b9LUwH32v5dtNrVF1d+lXyWKuYg2Pdc1Q
 dnFsOjytWfXg6ekTTLZjI2JYmeDqlW1xnDGQDTJ4eYuNmy2ZILn5NnC1po5KcWIKiqLC3c
 ahPrrn/39HFxkUXYLijNDxM3qdz6ZsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-0yojUnTFOx-OeC1oAfELzw-1; Tue, 06 Oct 2020 08:39:27 -0400
X-MC-Unique: 0yojUnTFOx-OeC1oAfELzw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 673E187950F;
 Tue,  6 Oct 2020 12:39:26 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 87DE555760;
 Tue,  6 Oct 2020 12:39:22 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 03/13] qtest: switch users back to qtest_qmp_receive
Date: Tue,  6 Oct 2020 15:38:54 +0300
Message-Id: <20201006123904.610658-4-mlevitsk@redhat.com>
In-Reply-To: <20201006123904.610658-1-mlevitsk@redhat.com>
References: <20201006123904.610658-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The only remaining users of qtest_qmp_receive_dict are tests
that fuzz the QMP protocol.

Tested with 'make check-qtest'.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 tests/qtest/ahci-test.c         |  4 +-
 tests/qtest/device-plug-test.c  |  2 +-
 tests/qtest/drive_del-test.c    |  9 ++---
 tests/qtest/libqos/libqtest.h   | 17 ---------
 tests/qtest/libqtest.c          | 65 ++++-----------------------------
 tests/qtest/migration-helpers.c | 25 ++++++++++---
 tests/qtest/pvpanic-test.c      |  4 +-
 tests/qtest/tpm-util.c          |  8 +++-
 8 files changed, 41 insertions(+), 93 deletions(-)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index d42ebaeb4c..5e1954852e 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1590,7 +1590,7 @@ static void test_atapi_tray(void)
     qtest_qmp_send(ahci->parent->qts, "{'execute': 'blockdev-open-tray', "
                     "'arguments': {'id': 'cd0'}}");
     atapi_wait_tray(ahci, true);
-    rsp = qtest_qmp_receive_dict(ahci->parent->qts);
+    rsp = qtest_qmp_receive(ahci->parent->qts);
     qobject_unref(rsp);
 
     qmp_discard_response(ahci->parent->qts,
@@ -1620,7 +1620,7 @@ static void test_atapi_tray(void)
     qtest_qmp_send(ahci->parent->qts, "{'execute': 'blockdev-close-tray', "
                    "'arguments': {'id': 'cd0'}}");
     atapi_wait_tray(ahci, false);
-    rsp = qtest_qmp_receive_dict(ahci->parent->qts);
+    rsp = qtest_qmp_receive(ahci->parent->qts);
     qobject_unref(rsp);
 
     /* Now, to convince ATAPI we understand the media has changed... */
diff --git a/tests/qtest/device-plug-test.c b/tests/qtest/device-plug-test.c
index a2247856be..9214892741 100644
--- a/tests/qtest/device-plug-test.c
+++ b/tests/qtest/device-plug-test.c
@@ -23,7 +23,7 @@ static void device_del_start(QTestState *qtest, const char *id)
 
 static void device_del_finish(QTestState *qtest)
 {
-    QDict *resp = qtest_qmp_receive_dict(qtest);
+    QDict *resp = qtest_qmp_receive(qtest);
 
     g_assert(qdict_haskey(resp, "return"));
     qobject_unref(resp);
diff --git a/tests/qtest/drive_del-test.c b/tests/qtest/drive_del-test.c
index ba0cd77445..9d20a1ed8b 100644
--- a/tests/qtest/drive_del-test.c
+++ b/tests/qtest/drive_del-test.c
@@ -15,9 +15,6 @@
 #include "libqos/virtio.h"
 #include "qapi/qmp/qdict.h"
 
-/* TODO actually test the results and get rid of this */
-#define qmp_discard_response(q, ...) qobject_unref(qtest_qmp(q, __VA_ARGS__))
-
 static void drive_add(QTestState *qts)
 {
     char *resp = qtest_hmp(qts, "drive_add 0 if=none,id=drive0");
@@ -38,13 +35,13 @@ static void device_del(QTestState *qts)
 {
     QDict *response;
 
-    /* Complication: ignore DEVICE_DELETED event */
-    qmp_discard_response(qts, "{'execute': 'device_del',"
+    response = qtest_qmp(qts, "{'execute': 'device_del',"
                          " 'arguments': { 'id': 'dev0' } }");
-    response = qtest_qmp_receive_dict(qts);
     g_assert(response);
     g_assert(qdict_haskey(response, "return"));
     qobject_unref(response);
+
+    qtest_qmp_eventwait(qts, "DEVICE_DELETED");
 }
 
 static void test_drive_without_dev(void)
diff --git a/tests/qtest/libqos/libqtest.h b/tests/qtest/libqos/libqtest.h
index 19429a536d..a91e9e02e9 100644
--- a/tests/qtest/libqos/libqtest.h
+++ b/tests/qtest/libqos/libqtest.h
@@ -240,23 +240,6 @@ QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event);
  */
 QDict *qtest_qmp_event_ref(QTestState *s, const char *event);
 
-/**
- * qtest_qmp_receive_success:
- * @s: #QTestState instance to operate on
- * @event_cb: Event callback
- * @opaque: Argument for @event_cb
- *
- * Poll QMP messages until a command success response is received.
- * If @event_cb, call it for each event received, passing @opaque,
- * the event's name and data.
- * Return the success response's "return" member.
- */
-QDict *qtest_qmp_receive_success(QTestState *s,
-                                 void (*event_cb)(void *opaque,
-                                                  const char *name,
-                                                  QDict *data),
-                                 void *opaque);
-
 /**
  * qtest_hmp:
  * @s: #QTestState instance to operate on.
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index d4c49a52ff..08929f5ff6 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -324,7 +324,7 @@ QTestState *qtest_init(const char *extra_args)
     QDict *greeting;
 
     /* Read the QMP greeting and then do the handshake */
-    greeting = qtest_qmp_receive_dict(s);
+    greeting = qtest_qmp_receive(s);
     qobject_unref(greeting);
     qobject_unref(qtest_qmp(s, "{ 'execute': 'qmp_capabilities' }"));
 
@@ -700,7 +700,7 @@ QDict *qtest_vqmp_fds(QTestState *s, int *fds, size_t fds_num,
     qtest_qmp_vsend_fds(s, fds, fds_num, fmt, ap);
 
     /* Receive reply */
-    return qtest_qmp_receive_dict(s);
+    return qtest_qmp_receive(s);
 }
 
 QDict *qtest_vqmp(QTestState *s, const char *fmt, va_list ap)
@@ -708,7 +708,7 @@ QDict *qtest_vqmp(QTestState *s, const char *fmt, va_list ap)
     qtest_qmp_vsend(s, fmt, ap);
 
     /* Receive reply */
-    return qtest_qmp_receive_dict(s);
+    return qtest_qmp_receive(s);
 }
 
 QDict *qmp_fd(int fd, const char *fmt, ...)
@@ -850,12 +850,6 @@ char *qtest_vhmp(QTestState *s, const char *fmt, va_list ap)
                      " 'arguments': {'command-line': %s}}",
                      cmd);
     ret = g_strdup(qdict_get_try_str(resp, "return"));
-    while (ret == NULL && qdict_get_try_str(resp, "event")) {
-        /* Ignore asynchronous QMP events */
-        qobject_unref(resp);
-        resp = qtest_qmp_receive_dict(s);
-        ret = g_strdup(qdict_get_try_str(resp, "return"));
-    }
     g_assert(ret);
     qobject_unref(resp);
     g_free(cmd);
@@ -1291,35 +1285,6 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine),
     qobject_unref(response);
 }
 
-QDict *qtest_qmp_receive_success(QTestState *s,
-                                 void (*event_cb)(void *opaque,
-                                                  const char *event,
-                                                  QDict *data),
-                                 void *opaque)
-{
-    QDict *response, *ret, *data;
-    const char *event;
-
-    for (;;) {
-        response = qtest_qmp_receive_dict(s);
-        g_assert(!qdict_haskey(response, "error"));
-        ret = qdict_get_qdict(response, "return");
-        if (ret) {
-            break;
-        }
-        event = qdict_get_str(response, "event");
-        data = qdict_get_qdict(response, "data");
-        if (event_cb) {
-            event_cb(opaque, event, data);
-        }
-        qobject_unref(response);
-    }
-
-    qobject_ref(ret);
-    qobject_unref(response);
-    return ret;
-}
-
 /*
  * Generic hot-plugging test via the device_add QMP commands.
  */
@@ -1355,13 +1320,6 @@ void qtest_qmp_device_add(QTestState *qts, const char *driver, const char *id,
     qobject_unref(args);
 }
 
-static void device_deleted_cb(void *opaque, const char *name, QDict *data)
-{
-    bool *got_event = opaque;
-
-    g_assert_cmpstr(name, ==, "DEVICE_DELETED");
-    *got_event = true;
-}
 
 /*
  * Generic hot-unplugging test via the device_del QMP command.
@@ -1378,24 +1336,17 @@ static void device_deleted_cb(void *opaque, const char *name, QDict *data)
  * and this one:
  *
  * {"return": {}}
- *
- * But the order of arrival may vary - so we've got to detect both.
  */
 void qtest_qmp_device_del(QTestState *qts, const char *id)
 {
-    bool got_event = false;
     QDict *rsp;
 
-    qtest_qmp_send(qts, "{'execute': 'device_del', 'arguments': {'id': %s}}",
-                   id);
-    rsp = qtest_qmp_receive_success(qts, device_deleted_cb, &got_event);
+    rsp = qtest_qmp(qts, "{'execute': 'device_del', 'arguments': {'id': %s}}",
+                    id);
+
+    g_assert(qdict_haskey(rsp, "return"));
     qobject_unref(rsp);
-    if (!got_event) {
-        rsp = qtest_qmp_receive_dict(qts);
-        g_assert_cmpstr(qdict_get_try_str(rsp, "event"),
-                        ==, "DEVICE_DELETED");
-        qobject_unref(rsp);
-    }
+    qtest_qmp_eventwait(qts, "DEVICE_DELETED");
 }
 
 bool qmp_rsp_is_err(QDict *rsp)
diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 516093b39a..b799dbafb7 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -17,10 +17,12 @@
 
 bool got_stop;
 
-static void stop_cb(void *opaque, const char *name, QDict *data)
+static void check_stop_event(QTestState *who)
 {
-    if (!strcmp(name, "STOP")) {
+    QDict *event = qtest_qmp_event_ref(who, "STOP");
+    if (event) {
         got_stop = true;
+        qobject_unref(event);
     }
 }
 
@@ -30,12 +32,19 @@ static void stop_cb(void *opaque, const char *name, QDict *data)
 QDict *wait_command_fd(QTestState *who, int fd, const char *command, ...)
 {
     va_list ap;
+    QDict *resp;
 
     va_start(ap, command);
     qtest_qmp_vsend_fds(who, &fd, 1, command, ap);
     va_end(ap);
 
-    return qtest_qmp_receive_success(who, stop_cb, NULL);
+    resp = qtest_qmp_receive(who);
+    check_stop_event(who);
+
+    g_assert(!qdict_haskey(resp, "error"));
+    g_assert(qdict_haskey(resp, "return"));
+
+    return qdict_get_qdict(resp, "return");
 }
 
 /*
@@ -44,12 +53,18 @@ QDict *wait_command_fd(QTestState *who, int fd, const char *command, ...)
 QDict *wait_command(QTestState *who, const char *command, ...)
 {
     va_list ap;
+    QDict *resp;
 
     va_start(ap, command);
-    qtest_qmp_vsend(who, command, ap);
+    resp = qtest_vqmp(who, command, ap);
     va_end(ap);
 
-    return qtest_qmp_receive_success(who, stop_cb, NULL);
+    check_stop_event(who);
+
+    g_assert(!qdict_haskey(resp, "error"));
+    g_assert(qdict_haskey(resp, "return"));
+
+    return qdict_get_qdict(resp, "return");
 }
 
 /*
diff --git a/tests/qtest/pvpanic-test.c b/tests/qtest/pvpanic-test.c
index b0b20ad340..0657de797f 100644
--- a/tests/qtest/pvpanic-test.c
+++ b/tests/qtest/pvpanic-test.c
@@ -24,9 +24,7 @@ static void test_panic(void)
 
     qtest_outb(qts, 0x505, 0x1);
 
-    response = qtest_qmp_receive_dict(qts);
-    g_assert(qdict_haskey(response, "event"));
-    g_assert_cmpstr(qdict_get_str(response, "event"), ==, "GUEST_PANICKED");
+    response = qtest_qmp_eventwait_ref(qts, "GUEST_PANICKED");
     g_assert(qdict_haskey(response, "data"));
     data = qdict_get_qdict(response, "data");
     g_assert(qdict_haskey(data, "action"));
diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
index 3ed6c8548a..5a33a6ef0f 100644
--- a/tests/qtest/tpm-util.c
+++ b/tests/qtest/tpm-util.c
@@ -237,12 +237,16 @@ void tpm_util_migrate(QTestState *who, const char *uri)
 void tpm_util_wait_for_migration_complete(QTestState *who)
 {
     while (true) {
+        QDict *rsp;
         QDict *rsp_return;
         bool completed;
         const char *status;
 
-        qtest_qmp_send(who, "{ 'execute': 'query-migrate' }");
-        rsp_return = qtest_qmp_receive_success(who, NULL, NULL);
+        rsp = qtest_qmp(who, "{ 'execute': 'query-migrate' }");
+        g_assert(qdict_haskey(rsp, "return"));
+        rsp_return = qdict_get_qdict(rsp, "return");
+
+        g_assert(!qdict_haskey(rsp_return, "error"));
         status = qdict_get_str(rsp_return, "status");
         completed = strcmp(status, "completed") == 0;
         g_assert_cmpstr(status, !=,  "failed");
-- 
2.26.2


