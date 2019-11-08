Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727A5C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:12:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B419215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UauoBIlp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B419215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT5wW-0006oP-Qt
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:12:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iT5of-00056k-GS
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:04:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iT5oe-00059L-5J
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:04:49 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24959
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iT5od-00058c-W6
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573225487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Ew9vHmiWjfrl81VNZzip86x0hD9sFmj8JBBNQVLTHg=;
 b=UauoBIlpiIgKhWGGreQM2ll6+wEALljH7TtReKWnkmjCqUl7c2jsvz1QS5ewXVW2944Eqf
 T9cvmEOq1Yl+saZtN7K+bE5DbGqFYPEgVKsPUdeQa/P/sWbMo1l1xhp5A2oDVmqpH/72mH
 Aq7IoS4/YyIctkN9CBxBq8FaQxKOCHI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-V8MqFVBvNz2em5aS0e8HwA-1; Fri, 08 Nov 2019 10:04:46 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FF441005500
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 15:04:45 +0000 (UTC)
Received: from localhost (ovpn-112-25.ams2.redhat.com [10.36.112.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55E035C1BB;
 Fri,  8 Nov 2019 15:04:37 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 14/25] qmp: add qmp_return_is_cancelled()
Date: Fri,  8 Nov 2019 19:01:12 +0400
Message-Id: <20191108150123.12213-15-marcandre.lureau@redhat.com>
In-Reply-To: <20191108150123.12213-1-marcandre.lureau@redhat.com>
References: <20191108150123.12213-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: V8MqFVBvNz2em5aS0e8HwA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 armbru@redhat.com, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the client is gone, and the session finished, no need to
return. The async handler can use this information to avoid
unnecessary work and exit earlier.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h |  8 ++++++++
 qapi/qmp-dispatch.c         | 10 ++++++++++
 tests/test-qmp-cmds.c       | 39 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 6aef0abc70..6673902e95 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -91,6 +91,14 @@ void qmp_return_free(QmpReturn *qret);
 void qmp_return(QmpReturn *qret, QObject *rsp);
 void qmp_return_error(QmpReturn *qret, Error *err);
=20
+/*
+ * @qmp_return_is_cancelled:
+ *
+ * Return true if the QmpReturn is cancelled, and free the QmpReturn
+ * in this case.
+ */
+bool qmp_return_is_cancelled(QmpReturn *qret);
+
 void qmp_register_command(QmpCommandList *cmds, const char *name,
                           QmpCommandFunc *fn, QmpCommandOptions options);
 void qmp_register_async_command(QmpCommandList *cmds, const char *name,
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 85e99671a9..e5c1505b05 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -64,6 +64,16 @@ void qmp_return_free(QmpReturn *qret)
     }
 }
=20
+bool qmp_return_is_cancelled(QmpReturn *qret)
+{
+    if (!qret->session) {
+        qmp_return_free(qret);
+        return true;
+    }
+
+    return false;
+}
+
 static void qmp_return_orderly(QmpReturn *qret)
 {
     QmpSession *session =3D qret->session;
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 75ef30f6ea..66ad8726fe 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -34,17 +34,29 @@ void qmp_cmd_success_response(Error **errp)
 {
 }
=20
+static GMainLoop *loop;
+
 static gboolean cmd_async_idle(gpointer user_data)
 {
     QmpReturn *qret =3D user_data;
=20
-    qmp_cmd_async_return(qret, g_new0(Empty2, 1));
+    if (!qret->session) {
+        g_assert(qmp_return_is_cancelled(qret));
+        g_main_loop_quit(loop);
+        g_main_loop_unref(loop);
+        loop =3D NULL;
+    } else {
+        qmp_cmd_async_return(qret, g_new0(Empty2, 1));
+    }
=20
     return G_SOURCE_REMOVE;
 }
=20
 void qmp_cmd_async(const char *filename, QmpReturn *qret)
 {
+    if (g_str_equal(filename, "cancel")) {
+        qmp_session_destroy(qret->session);
+    }
     g_idle_add(cmd_async_idle, qret);
 }
=20
@@ -453,6 +465,30 @@ static void test_qmp_return_async(void)
     qobject_unref(req);
 }
=20
+static void test_qmp_return_async_cancel(void)
+{
+    QmpReturnAsync a =3D { { 0, }, };
+    QDict *args =3D qdict_new();
+    QDict *req =3D qdict_new();
+
+    a.loop =3D g_main_loop_new(NULL, TRUE);
+    qmp_session_init(&a.session, &qmp_commands,
+                     NULL, dispatch_return_async);
+
+    qdict_put_str(args, "filename", "cancel");
+    qdict_put_str(req, "execute", "cmd-async");
+    qdict_put(req, "arguments", args);
+    qmp_dispatch(&a.session, QOBJECT(req), false);
+    g_assert(a.loop);
+
+    loop =3D a.loop;
+    g_main_loop_run(loop);
+    g_assert(!loop);
+
+    qmp_session_destroy(&a.session);
+    qobject_unref(req);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -467,6 +503,7 @@ int main(int argc, char **argv)
     g_test_add_func("/qmp/dealloc_partial", test_dealloc_partial);
     g_test_add_func("/qmp/return_orderly", test_qmp_return_orderly);
     g_test_add_func("/qmp/return_async", test_qmp_return_async);
+    g_test_add_func("/qmp/return_async_cancel", test_qmp_return_async_canc=
el);
=20
     test_qmp_init_marshal(&qmp_commands);
     g_test_run();
--=20
2.24.0


