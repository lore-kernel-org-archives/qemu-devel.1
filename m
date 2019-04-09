Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7BAC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:18:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ADCF21473
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ADCF21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45733 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDtSF-0000Bl-BR
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 12:18:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtLf-0003Gm-UT
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtLe-00058l-Kr
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hDtLe-00057d-9G
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 81B68307B4BA;
	Tue,  9 Apr 2019 16:11:21 +0000 (UTC)
Received: from localhost (ovpn-112-27.ams2.redhat.com [10.36.112.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C7E445D719;
	Tue,  9 Apr 2019 16:11:16 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 18:09:59 +0200
Message-Id: <20190409161009.6322-11-marcandre.lureau@redhat.com>
In-Reply-To: <20190409161009.6322-1-marcandre.lureau@redhat.com>
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Tue, 09 Apr 2019 16:11:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 10/20] QmpSession: keep a queue of pending
 commands
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
	Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409160959.pGgXX_bfTzCXRLnHuywHl7LoGb2cS6swSS_5qWC45A4@z>

The following commit will introduce asynchronous commands. Let's keep
the session aware of the pending commands, so we can do interesting
things like order the replies, or cancel pending operations when the
client is gone.

The queue needs a lock, since QmpReturn may be called from any thread.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h |  4 ++++
 qapi/qmp-dispatch.c         | 32 ++++++++++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 6c0d21968e..7c9de9780d 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -16,6 +16,7 @@
=20
 #include "qemu/queue.h"
 #include "qapi/qmp/json-parser.h"
+#include "qemu/thread.h"
=20
 typedef struct QmpReturn QmpReturn;
=20
@@ -47,11 +48,14 @@ struct QmpSession {
     const QmpCommandList *cmds;
     JSONMessageParser parser;
     QmpDispatchReturn *return_cb;
+    QemuMutex pending_lock;
+    QTAILQ_HEAD(, QmpReturn) pending;
 };
=20
 struct QmpReturn {
     QmpSession *session;
     QDict *rsp;
+    QTAILQ_ENTRY(QmpReturn) entry;
 };
=20
 /**
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 5f75dc27bd..4699a6715b 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -32,11 +32,24 @@ QmpReturn *qmp_return_new(QmpSession *session, const =
QObject *request)
         qdict_put_obj(qret->rsp, "id", id);
     }
=20
+    qemu_mutex_lock(&session->pending_lock);
+    QTAILQ_INSERT_TAIL(&session->pending, qret, entry);
+    qemu_mutex_unlock(&session->pending_lock);
+
     return qret;
 }
=20
 void qmp_return_free(QmpReturn *qret)
 {
+    QmpSession *session =3D qret->session;
+
+    if (session) {
+        qemu_mutex_lock(&session->pending_lock);
+    }
+    QTAILQ_REMOVE(&session->pending, qret, entry);
+    if (session) {
+        qemu_mutex_unlock(&session->pending_lock);
+    }
     qobject_unref(qret->rsp);
     g_free(qret);
 }
@@ -44,7 +57,9 @@ void qmp_return_free(QmpReturn *qret)
 void qmp_return(QmpReturn *qret, QObject *rsp)
 {
     qdict_put_obj(qret->rsp, "return", rsp ?: QOBJECT(qdict_new()));
-    qret->session->return_cb(qret->session, qret->rsp);
+    if (qret->session) {
+        qret->session->return_cb(qret->session, qret->rsp);
+    }
     qmp_return_free(qret);
 }
=20
@@ -55,7 +70,9 @@ void qmp_return_error(QmpReturn *qret, Error *err)
     qdict_put_str(qdict, "desc", error_get_pretty(err));
     qdict_put_obj(qret->rsp, "error", QOBJECT(qdict));
     error_free(err);
-    qret->session->return_cb(qret->session, qret->rsp);
+    if (qret->session) {
+        qret->session->return_cb(qret->session, qret->rsp);
+    }
     qmp_return_free(qret);
 }
=20
@@ -219,17 +236,28 @@ void qmp_session_init(QmpSession *session,
                              session, NULL);
     session->cmds =3D cmds;
     session->return_cb =3D return_cb;
+    qemu_mutex_init(&session->pending_lock);
+    QTAILQ_INIT(&session->pending);
 }
=20
 void qmp_session_destroy(QmpSession *session)
 {
+    QmpReturn *ret, *next;
+
     if (!session->return_cb) {
         return;
     }
=20
+    qemu_mutex_lock(&session->pending_lock);
+    QTAILQ_FOREACH_SAFE(ret, &session->pending, entry, next) {
+        ret->session =3D NULL;
+        QTAILQ_REMOVE(&session->pending, ret, entry);
+    }
+    qemu_mutex_unlock(&session->pending_lock);
     session->cmds =3D NULL;
     session->return_cb =3D NULL;
     json_message_parser_destroy(&session->parser);
+    qemu_mutex_destroy(&session->pending_lock);
 }
=20
 void qmp_dispatch(QmpSession *session, QObject *request, bool allow_oob)
--=20
2.21.0.196.g041f5ea1cf


