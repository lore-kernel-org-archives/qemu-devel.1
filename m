Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519D2C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:10:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C183215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwDVLt9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C183215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT5ua-0004Ir-0E
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:10:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iT5nq-0004Rl-H3
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:03:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iT5no-0004ZT-LZ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:03:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45748
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iT5no-0004ZL-Hs
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:03:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573225436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tokP4vjSso+mNJQryUKg0EPaJ0vjrJNzrRiRGvfAkFI=;
 b=RwDVLt9dHEDvbUQKDDRXvEEAhX2g0rsUSxv9FDIvt9QAoavnegr3LgEykWpoNhzn6zp2S0
 wOqnXrsWlxDzGAUt47BUpuSK7kXlQf1KI3lO0VHeEoBaVSZ28JbWVZaqG9qstIcNOX0DLD
 2d3EjTmszHUF1mRu8H9ZUScqLzXHP1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-qe37uHoCO7yql5MqneRGJg-1; Fri, 08 Nov 2019 10:03:54 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C71E7180496F
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 15:03:53 +0000 (UTC)
Received: from localhost (ovpn-112-25.ams2.redhat.com [10.36.112.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E519060BE2;
 Fri,  8 Nov 2019 15:03:46 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 10/25] QmpSession: keep a queue of pending commands
Date: Fri,  8 Nov 2019 19:01:08 +0400
Message-Id: <20191108150123.12213-11-marcandre.lureau@redhat.com>
In-Reply-To: <20191108150123.12213-1-marcandre.lureau@redhat.com>
References: <20191108150123.12213-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: qe37uHoCO7yql5MqneRGJg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
index fcf6cb0bf8..aed5c91057 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -32,11 +32,24 @@ QmpReturn *qmp_return_new(QmpSession *session, const QO=
bject *request)
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
@@ -220,17 +237,28 @@ void qmp_session_init(QmpSession *session,
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
2.24.0


