Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E132C43457
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 06:36:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E8BD22251
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 06:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPmVytoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8BD22251
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQm1Q-0003ne-G2
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 02:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQlzH-0001x5-6S
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 02:34:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29797)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQlzF-0008UC-8Y
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 02:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602225280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OBkniY5zYY8f0UMKJUn+DDWI2bGks6XloSLFLnQ1cOo=;
 b=GPmVytoq2Ygq/4YueYN2B0sH+v6Ee5iUa77geGpD6ZY+kJZj8jXD6ZNrtRi2AjkJXQA3Re
 C1PNEacW0K8X/xGt82rYr+Or6aqqZKAUIZbdXKljwk0tSANEqIVsHwh/0nSW9YYIFZlOL+
 F0KlFxl1bac0ROqk+tvD8iLJ0lelqqY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-WSGKsM66NZyS1janEWMLIA-1; Fri, 09 Oct 2020 02:34:38 -0400
X-MC-Unique: WSGKsM66NZyS1janEWMLIA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA84364143
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 06:34:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 62A7910002A4;
 Fri,  9 Oct 2020 06:34:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 16C10112CE1D; Fri,  9 Oct 2020 08:34:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/14] qmp: Call monitor_set_cur() only in qmp_dispatch()
Date: Fri,  9 Oct 2020 08:34:24 +0200
Message-Id: <20201009063432.303441-7-armbru@redhat.com>
In-Reply-To: <20201009063432.303441-1-armbru@redhat.com>
References: <20201009063432.303441-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
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
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

The correct way to set the current monitor for a coroutine handler will
be different than for a blocking handler, so monitor_set_cur() needs to
be called in qmp_dispatch().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20201005155855.256490-7-kwolf@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/dispatch.h | 3 ++-
 monitor/qmp.c               | 9 ++-------
 qapi/qmp-dispatch.c         | 8 +++++++-
 qga/main.c                  | 2 +-
 stubs/monitor-core.c        | 5 +++++
 tests/test-qmp-cmds.c       | 6 +++---
 6 files changed, 20 insertions(+), 13 deletions(-)

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
index 8469970c69..e746b3575d 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -135,16 +135,11 @@ static void monitor_qmp_respond(MonitorQMP *mon, QDict *rsp)
 
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
+    rsp = qmp_dispatch(mon->commands, req, qmp_oob_enabled(mon),
+                       &mon->common);
 
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
index 740f5f7303..dea6a3aa64 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -579,7 +579,7 @@ static void process_event(void *opaque, QObject *obj, Error *err)
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
2.26.2


