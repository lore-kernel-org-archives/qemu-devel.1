Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6737FC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:14:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F86821919
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXndqzR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F86821919
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG1oC-0006Sg-Ci
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 11:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kG1li-0001Lm-G4
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 11:12:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55311)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kG1lf-0003nq-RB
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 11:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599664335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R+GxBZ05I55j0DxODUUI8P5IDmobelPnlqIg9oLpL6k=;
 b=JXndqzR1JMGlSqve+QztuyKISp0sZUkgI7yPg5WQ7vR/S9hjaAtg5PjDJ+NdtaTajo8ggs
 xcaTJkpv8viz83u9fGWPwLBw5J+8c+Qysx8PNPxJW8dKR/oUJjd+FBuv0OtYkqQMTCdulF
 xrNxOAjycfd9HXaMIPhQSV2NsobPOIs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-x_wEyWlmNGisnF3QmgrPMA-1; Wed, 09 Sep 2020 11:12:10 -0400
X-MC-Unique: x_wEyWlmNGisnF3QmgrPMA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 666891084D79;
 Wed,  9 Sep 2020 15:12:09 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-221.ams2.redhat.com
 [10.36.113.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4FCF60C07;
 Wed,  9 Sep 2020 15:12:07 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 06/13] qmp: Call monitor_set_cur() only in qmp_dispatch()
Date: Wed,  9 Sep 2020 17:11:42 +0200
Message-Id: <20200909151149.490589-7-kwolf@redhat.com>
In-Reply-To: <20200909151149.490589-1-kwolf@redhat.com>
References: <20200909151149.490589-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:25:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 marcandre.lureau@gmail.com, stefanha@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The correct way to set the current monitor for a coroutine handler will
be different than for a blocking handler, so monitor_set_cur() needs to
be called in qmp_dispatch().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qapi/qmp/dispatch.h | 3 ++-
 monitor/qmp.c               | 8 +-------
 qapi/qmp-dispatch.c         | 8 +++++++-
 qga/main.c                  | 2 +-
 stubs/monitor-core.c        | 5 +++++
 tests/test-qmp-cmds.c       | 6 +++---
 6 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 5a9cf82472..0c2f467028 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -14,6 +14,7 @@
 #ifndef QAPI_QMP_DISPATCH_H
 #define QAPI_QMP_DISPATCH_H
 
+#include "monitor/monitor.h"
 #include "qemu/queue.h"
 
 typedef void (QmpCommandFunc)(QDict *, QObject **, Error **);
@@ -49,7 +50,7 @@ const char *qmp_command_name(const QmpCommand *cmd);
 bool qmp_has_success_response(const QmpCommand *cmd);
 QDict *qmp_error_response(Error *err);
 QDict *qmp_dispatch(const QmpCommandList *cmds, QObject *request,
-                    bool allow_oob);
+                    bool allow_oob, Monitor *cur_mon);
 bool qmp_is_oob(const QDict *dict);
 
 typedef void (*qmp_cmd_callback_fn)(const QmpCommand *cmd, void *opaque);
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 8469970c69..922fdb5541 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -135,16 +135,10 @@ static void monitor_qmp_respond(MonitorQMP *mon, QDict *rsp)
 
 static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
 {
-    Monitor *old_mon;
     QDict *rsp;
     QDict *error;
 
-    old_mon = monitor_set_cur(&mon->common);
-    assert(old_mon == NULL);
-
-    rsp = qmp_dispatch(mon->commands, req, qmp_oob_enabled(mon));
-
-    monitor_set_cur(NULL);
+    rsp = qmp_dispatch(mon->commands, req, qmp_oob_enabled(mon), &mon->common);
 
     if (mon->commands == &qmp_cap_negotiation_commands) {
         error = qdict_get_qdict(rsp, "error");
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 79347e0864..2fdbc0fba4 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -89,7 +89,7 @@ bool qmp_is_oob(const QDict *dict)
 }
 
 QDict *qmp_dispatch(const QmpCommandList *cmds, QObject *request,
-                    bool allow_oob)
+                    bool allow_oob, Monitor *cur_mon)
 {
     Error *err = NULL;
     bool oob;
@@ -152,7 +152,13 @@ QDict *qmp_dispatch(const QmpCommandList *cmds, QObject *request,
         args = qdict_get_qdict(dict, "arguments");
         qobject_ref(args);
     }
+
+    assert(monitor_cur() == NULL);
+    monitor_set_cur(cur_mon);
+
     cmd->fn(args, &ret, &err);
+
+    monitor_set_cur(NULL);
     qobject_unref(args);
     if (err) {
         /* or assert(!ret) after reviewing all handlers: */
diff --git a/qga/main.c b/qga/main.c
index 3febf3b0fd..241779a1d6 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -578,7 +578,7 @@ static void process_event(void *opaque, QObject *obj, Error *err)
     }
 
     g_debug("processing command");
-    rsp = qmp_dispatch(&ga_commands, obj, false);
+    rsp = qmp_dispatch(&ga_commands, obj, false, NULL);
 
 end:
     ret = send_response(s, rsp);
diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
index 0cd2d864b2..dc1748bf13 100644
--- a/stubs/monitor-core.c
+++ b/stubs/monitor-core.c
@@ -8,6 +8,11 @@ Monitor *monitor_cur(void)
     return NULL;
 }
 
+Monitor *monitor_set_cur(Monitor *mon)
+{
+    return NULL;
+}
+
 void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
 {
 }
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index d12ff47e26..5f1b245e19 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -152,7 +152,7 @@ static QObject *do_qmp_dispatch(bool allow_oob, const char *template, ...)
     req = qdict_from_vjsonf_nofail(template, ap);
     va_end(ap);
 
-    resp = qmp_dispatch(&qmp_commands, QOBJECT(req), allow_oob);
+    resp = qmp_dispatch(&qmp_commands, QOBJECT(req), allow_oob, NULL);
     g_assert(resp);
     ret = qdict_get(resp, "return");
     g_assert(ret);
@@ -175,7 +175,7 @@ static void do_qmp_dispatch_error(bool allow_oob, ErrorClass cls,
     req = qdict_from_vjsonf_nofail(template, ap);
     va_end(ap);
 
-    resp = qmp_dispatch(&qmp_commands, QOBJECT(req), allow_oob);
+    resp = qmp_dispatch(&qmp_commands, QOBJECT(req), allow_oob, NULL);
     g_assert(resp);
     error = qdict_get_qdict(resp, "error");
     g_assert(error);
@@ -231,7 +231,7 @@ static void test_dispatch_cmd_success_response(void)
     QDict *resp;
 
     qdict_put_str(req, "execute", "cmd-success-response");
-    resp = qmp_dispatch(&qmp_commands, QOBJECT(req), false);
+    resp = qmp_dispatch(&qmp_commands, QOBJECT(req), false, NULL);
     g_assert_null(resp);
     qobject_unref(req);
 }
-- 
2.25.4


