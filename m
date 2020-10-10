Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A5DC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 08:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C48FE207C4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 08:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NyQaRGI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48FE207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRAAB-00067A-V7
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 04:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kR9lS-0004VE-GW
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 03:58:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49119)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kR9lN-0006it-9D
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 03:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602316676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0rCcR97JKxJXfYnNhiKiRalRr9E4Y9hUyTEXRRIoa50=;
 b=NyQaRGI++umEiE92t4M4F621Fl4+xgItoL8xJpmL2UZhloauFXeIW1evVMTLAlcR8ghWiC
 OTywbRaO6Zc1xSAB/1UsT9Mx6/gVO3xkoQGQ7fzlbhCdxa0dvWTZC3LjtJJNcLfellrAJ1
 /5KPI51QHH1tuPWDf5uQQzeKVg6M1fU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-Ikaf0-1LPRSgReW5eP-Izw-1; Sat, 10 Oct 2020 03:57:54 -0400
X-MC-Unique: Ikaf0-1LPRSgReW5eP-Izw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A5411005E5A
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 07:57:54 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC7E360C07;
 Sat, 10 Oct 2020 07:57:53 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/39] qtest: remove qtest_qmp_receive_success
Date: Sat, 10 Oct 2020 03:57:24 -0400
Message-Id: <20201010075739.951385-25-pbonzini@redhat.com>
In-Reply-To: <20201010075739.951385-1-pbonzini@redhat.com>
References: <20201010075739.951385-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 02:57:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

The purpose of qtest_qmp_receive_success was mostly to process events
that arrived between the issueing of a command and the "return"
line from QMP.  This is now handled by the buffering of events
that libqtest performs automatically.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 tests/qtest/libqos/libqtest.h   | 17 -----------
 tests/qtest/libqtest.c          | 53 ++++-----------------------------
 tests/qtest/migration-helpers.c | 25 ++++++++++++----
 3 files changed, 25 insertions(+), 70 deletions(-)

diff --git a/tests/qtest/libqos/libqtest.h b/tests/qtest/libqos/libqtest.h
index a2e3961792..64bb1cd9eb 100644
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
index d4c49a52ff..baac667b8d 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1291,35 +1291,6 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine),
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
@@ -1355,13 +1326,6 @@ void qtest_qmp_device_add(QTestState *qts, const char *driver, const char *id,
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
@@ -1378,24 +1342,17 @@ static void device_deleted_cb(void *opaque, const char *name, QDict *data)
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
-- 
2.26.2



