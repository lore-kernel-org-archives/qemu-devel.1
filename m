Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34478C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 12:04:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 587A320782
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 12:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IehpTEdu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 587A320782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ8BS-0001qn-U4
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 08:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQ84I-0001Ud-Nx
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:57:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37449)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQ84D-0001gl-1P
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602071828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WSybe/F61UcKWf9cKwsuGQfmd1CuQH+qTGEvPZqxSsI=;
 b=IehpTEdu+RsePpfl90TgPn9QQTq6bi6DmFDZ1nqoLjdbeRYl/M34hc/MHhrbZ9sdNpF4nE
 NxWVy2eXCwFIbwLlSy219ZV9+GRZwc4Q++Bp6uPxDZgCqeEdTtvOkuuOBP3KvZWy+rf22C
 IsCg0edUXYe3ECWnkCFjGB7vm7iVnOk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-MuZp7bqoMBSD-3z2-GyhHg-1; Wed, 07 Oct 2020 07:57:06 -0400
X-MC-Unique: MuZp7bqoMBSD-3z2-GyhHg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BC4710BBEC5;
 Wed,  7 Oct 2020 11:57:05 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F15C95577B;
 Wed,  7 Oct 2020 11:57:04 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 02/17] qtest: Reintroduce qtest_qmp_receive
Date: Wed,  7 Oct 2020 07:56:45 -0400
Message-Id: <20201007115700.707938-3-pbonzini@redhat.com>
In-Reply-To: <20201007115700.707938-1-pbonzini@redhat.com>
References: <20201007115700.707938-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

The new qtest_qmp_receive buffers all the received qmp events, allowing
qtest_qmp_eventwait_ref to return them.

This is intended to solve the race in regard to ordering of qmp events
vs qmp responses, as soon as the callers start using the new interface.

In addition to that, define qtest_qmp_event_ref a function which only scans
the buffer that qtest_qmp_receive stores the events to.

This is intended for callers that are only interested in events that were
received during the last call to the qtest_qmp_receive.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Message-Id: <20201006123904.610658-3-mlevitsk@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qtest/libqos/libqtest.h | 23 ++++++++++++++++
 tests/qtest/libqtest.c        | 49 ++++++++++++++++++++++++++++++++++-
 2 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/libqos/libqtest.h b/tests/qtest/libqos/libqtest.h
index 9b3f99b322..a2e3961792 100644
--- a/tests/qtest/libqos/libqtest.h
+++ b/tests/qtest/libqos/libqtest.h
@@ -198,6 +198,16 @@ void qtest_qmp_vsend(QTestState *s, const char *fmt, va_list ap)
  */
 QDict *qtest_qmp_receive_dict(QTestState *s);
 
+/**
+ * qtest_qmp_receive:
+ * @s: #QTestState instance to operate on.
+ *
+ * Reads a QMP message from QEMU and returns the response.
+ * Buffers all the events received meanwhile, until a
+ * call to qtest_qmp_eventwait
+ */
+QDict *qtest_qmp_receive(QTestState *s);
+
 /**
  * qtest_qmp_eventwait:
  * @s: #QTestState instance to operate on.
@@ -217,6 +227,19 @@ void qtest_qmp_eventwait(QTestState *s, const char *event);
  */
 QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event);
 
+/**
+ * qtest_qmp_event_ref:
+ * @s: #QTestState instance to operate on.
+ * @s: #event event to return.
+ *
+ * Removes non-matching events from the buffer that was set by
+ * qtest_qmp_receive, until an event bearing the given name is found,
+ * and returns it.
+ * If no event matches, clears the buffer and returns NULL.
+ *
+ */
+QDict *qtest_qmp_event_ref(QTestState *s, const char *event);
+
 /**
  * qtest_qmp_receive_success:
  * @s: #QTestState instance to operate on
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index dadc465825..d4c49a52ff 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -63,6 +63,7 @@ struct QTestState
     bool irq_level[MAX_IRQ];
     GString *rx;
     QTestTransportOps ops;
+    GList *pending_events;
 };
 
 static GHookList abrt_hooks;
@@ -279,6 +280,7 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
 
     g_test_message("starting QEMU: %s", command);
 
+    s->pending_events = NULL;
     s->wstatus = 0;
     s->expected_status = 0;
     s->qemu_pid = fork();
@@ -386,6 +388,13 @@ void qtest_quit(QTestState *s)
     close(s->fd);
     close(s->qmp_fd);
     g_string_free(s->rx, true);
+
+    for (GList *it = s->pending_events; it != NULL; it = it->next) {
+        qobject_unref((QDict *)it->data);
+    }
+
+    g_list_free(s->pending_events);
+
     g_free(s);
 }
 
@@ -603,6 +612,19 @@ QDict *qmp_fd_receive(int fd)
     return qmp.response;
 }
 
+QDict *qtest_qmp_receive(QTestState *s)
+{
+    while (true) {
+        QDict *response = qtest_qmp_receive_dict(s);
+
+        if (!qdict_get_try_str(response, "event")) {
+            return response;
+        }
+        /* Stash the event for a later consumption */
+        s->pending_events = g_list_prepend(s->pending_events, response);
+    }
+}
+
 QDict *qtest_qmp_receive_dict(QTestState *s)
 {
     return qmp_fd_receive(s->qmp_fd);
@@ -771,10 +793,34 @@ void qtest_qmp_send_raw(QTestState *s, const char *fmt, ...)
     va_end(ap);
 }
 
-QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event)
+QDict *qtest_qmp_event_ref(QTestState *s, const char *event)
 {
+    GList *next = NULL;
     QDict *response;
 
+    for (GList *it = s->pending_events; it != NULL; it = next) {
+
+        next = it->next;
+        response = (QDict *)it->data;
+
+        s->pending_events = g_list_remove_link(s->pending_events, it);
+
+        if (!strcmp(qdict_get_str(response, "event"), event)) {
+            return response;
+        }
+        qobject_unref(response);
+    }
+    return NULL;
+}
+
+QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event)
+{
+    QDict *response = qtest_qmp_event_ref(s, event);
+
+    if (response) {
+        return response;
+    }
+
     for (;;) {
         response = qtest_qmp_receive_dict(s);
         if ((qdict_haskey(response, "event")) &&
@@ -1403,6 +1449,7 @@ QTestState *qtest_inproc_init(QTestState **s, bool log, const char* arch,
 {
     QTestState *qts;
     qts = g_new0(QTestState, 1);
+    qts->pending_events = NULL;
     *s = qts; /* Expose qts early on, since the query endianness relies on it */
     qts->wstatus = 0;
     for (int i = 0; i < MAX_IRQ; i++) {
-- 
2.26.2



