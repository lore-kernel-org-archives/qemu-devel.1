Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09335C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 08:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E941207E8
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 08:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDEO3H3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E941207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR9yu-0007g3-JJ
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 04:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kR9lQ-0004PZ-Eo
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 03:58:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49817)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kR9lN-0006j0-Tw
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 03:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602316677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=55WpEi90PG0R1Tz2B85E8h1Orp/fQfXznmS5ayIoWgQ=;
 b=HDEO3H3wiTGn9Eo2Vclh4QMMYggTsuswEbxL/VcLitDOnRilh9Spz1OlaB9gKTxXqefnuw
 th/6nVG5gjcyUf5/IZSHqXmHlbNM+rDRddfVvLoDY5OTPO0jSPHr8fNgesAvvxdPOKk5Dg
 GSjrMl61T2ORVUZ5uGMGHMRPJBou+4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-Z-Ia4ldvMNS-z-0K2ruuEg-1; Sat, 10 Oct 2020 03:57:55 -0400
X-MC-Unique: Z-Ia4ldvMNS-z-0K2ruuEg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B71201005E61
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 07:57:54 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7551B672C6;
 Sat, 10 Oct 2020 07:57:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/39] qtest: switch users back to qtest_qmp_receive
Date: Sat, 10 Oct 2020 03:57:26 -0400
Message-Id: <20201010075739.951385-27-pbonzini@redhat.com>
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

Let test use the new functionality for buffering events.
The only remaining users of qtest_qmp_receive_dict are tests
that fuzz the QMP protocol.

Tested with 'make check-qtest'.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Message-Id: <20201006123904.610658-4-mlevitsk@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qtest/ahci-test.c      |  4 ++--
 tests/qtest/drive_del-test.c |  9 +++------
 tests/qtest/libqtest.c       | 12 +++---------
 tests/qtest/pvpanic-test.c   |  4 +---
 tests/qtest/tpm-util.c       |  8 ++++++--
 5 files changed, 15 insertions(+), 22 deletions(-)

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
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index baac667b8d..08929f5ff6 100644
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



