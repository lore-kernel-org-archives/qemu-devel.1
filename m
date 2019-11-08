Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D6EFA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:07:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A9E1215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXIiUya/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9E1215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT5qm-0007lL-Ql
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:07:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iT5mj-0003Cd-DL
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:02:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iT5mi-0003o2-1I
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:02:49 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49936
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iT5mg-0003nG-2v
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:02:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573225364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e1yDkbX9kSrQE2esR1pQgQNkZhwENHxRrNgX62Wk9qo=;
 b=MXIiUya/MPD2Ez2ZMO3WRgSUVGJrGMj9oeAV2dc1fDGh2U6QlROkmBsw3yScmtxyc0HrDx
 jEy6MP1v17zsv4YMPll0Z9RWLcAW8Ddt5FyoXL3NqKkIX6ae2lCeyoCb9fhlvMmJxDyP/A
 EHaR0pusZ/Z35NiNuk/9v4WQnnU206I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-LzGJj93WOm6s5V5vro0rcg-1; Fri, 08 Nov 2019 10:02:43 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF4778017DD
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 15:02:42 +0000 (UTC)
Received: from localhost (ovpn-112-25.ams2.redhat.com [10.36.112.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 202A65C1BB;
 Fri,  8 Nov 2019 15:02:34 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 05/25] QmpSession: add json parser and use it in qga
Date: Fri,  8 Nov 2019 19:01:03 +0400
Message-Id: <20191108150123.12213-6-marcandre.lureau@redhat.com>
In-Reply-To: <20191108150123.12213-1-marcandre.lureau@redhat.com>
References: <20191108150123.12213-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: LzGJj93WOm6s5V5vro0rcg-1
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

Move JSON parser to QmpSession, and implement a simple handler to check
the parsed tokens and call qmp_dispatch(). This is enough for a simple
QMP client, like QGA.

The QEMU monitor has more complicated handling of dispatching which
will be addressed in a following patch to benefit from more common
code.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h |  7 +++++++
 qapi/qmp-dispatch.c         | 19 +++++++++++++++++++
 qga/main.c                  | 31 +------------------------------
 3 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index d1ce631a93..c84edff7d2 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -15,6 +15,7 @@
 #define QAPI_QMP_DISPATCH_H
=20
 #include "qemu/queue.h"
+#include "qapi/qmp/json-parser.h"
=20
 typedef void (QmpCommandFunc)(QDict *, QObject **, Error **);
=20
@@ -42,6 +43,7 @@ typedef void (QmpDispatchReturn) (QmpSession *session, QD=
ict *rsp);
=20
 struct QmpSession {
     const QmpCommandList *cmds;
+    JSONMessageParser parser;
     QmpDispatchReturn *return_cb;
 };
=20
@@ -52,6 +54,11 @@ const QmpCommand *qmp_find_command(const QmpCommandList =
*cmds,
 void qmp_session_init(QmpSession *session,
                       const QmpCommandList *cmds,
                       QmpDispatchReturn *return_cb);
+static inline void
+qmp_session_feed(QmpSession *session, const char *buf, size_t count)
+{
+    json_message_parser_feed(&session->parser, buf, count);
+}
 void qmp_session_destroy(QmpSession *session);
 void qmp_disable_command(QmpCommandList *cmds, const char *name);
 void qmp_enable_command(QmpCommandList *cmds, const char *name);
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 1314f4929f..f8c491924d 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -164,6 +164,23 @@ bool qmp_is_oob(const QDict *dict)
         && !qdict_haskey(dict, "execute");
 }
=20
+static void qmp_json_emit(void *opaque, QObject *obj, Error *err)
+{
+    QmpSession *session =3D opaque;
+
+    assert(!obj !=3D !err);
+
+    if (err) {
+        QDict *rsp =3D qmp_error_response(err);
+        session->return_cb(session, rsp);
+        qobject_unref(rsp);
+    } else {
+        qmp_dispatch(session, obj, false);
+    }
+
+    qobject_unref(obj);
+}
+
 void qmp_session_init(QmpSession *session,
                       const QmpCommandList *cmds,
                       QmpDispatchReturn *return_cb)
@@ -171,6 +188,7 @@ void qmp_session_init(QmpSession *session,
     assert(return_cb);
     assert(!session->return_cb);
=20
+    json_message_parser_init(&session->parser, qmp_json_emit, session, NUL=
L);
     session->cmds =3D cmds;
     session->return_cb =3D return_cb;
 }
@@ -183,6 +201,7 @@ void qmp_session_destroy(QmpSession *session)
=20
     session->cmds =3D NULL;
     session->return_cb =3D NULL;
+    json_message_parser_destroy(&session->parser);
 }
=20
 void qmp_dispatch(QmpSession *session, QObject *request, bool allow_oob)
diff --git a/qga/main.c b/qga/main.c
index c291d06491..057368eb16 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -19,7 +19,6 @@
 #include <sys/wait.h>
 #endif
 #include "qemu-common.h"
-#include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qstring.h"
@@ -75,7 +74,6 @@ typedef struct GAConfig GAConfig;
=20
 struct GAState {
     QmpSession session;
-    JSONMessageParser parser;
     GMainLoop *main_loop;
     GAChannel *channel;
     bool virtio; /* fastpath to check for virtio to deal with poll() quirk=
s */
@@ -567,31 +565,6 @@ static void dispatch_return_cb(QmpSession *session, QD=
ict *rsp)
     }
 }
=20
-/* handle requests/control events coming in over the channel */
-static void process_event(void *opaque, QObject *obj, Error *err)
-{
-    GAState *s =3D opaque;
-    int ret;
-
-    g_debug("process_event: called");
-    assert(!obj !=3D !err);
-
-    if (err) {
-        QDict *rsp =3D qmp_error_response(err);
-
-        ret =3D send_response(s, rsp);
-        if (ret < 0) {
-            g_warning("error sending error response: %s", strerror(-ret));
-        }
-        qobject_unref(rsp);
-    } else {
-        g_debug("processing command");
-        qmp_dispatch(&s->session, obj, false);
-    }
-
-    qobject_unref(obj);
-}
-
 /* false return signals GAChannel to close the current client connection *=
/
 static gboolean channel_event_cb(GIOCondition condition, gpointer data)
 {
@@ -607,7 +580,7 @@ static gboolean channel_event_cb(GIOCondition condition=
, gpointer data)
     case G_IO_STATUS_NORMAL:
         buf[count] =3D 0;
         g_debug("read data, count: %d, data: %s", (int)count, buf);
-        json_message_parser_feed(&s->parser, (char *)buf, (int)count);
+        qmp_session_feed(&s->session, (char *)buf, (int)count);
         break;
     case G_IO_STATUS_EOF:
         g_debug("received EOF");
@@ -1346,7 +1319,6 @@ static GAState *initialize_agent(GAConfig *config, in=
t socket_activation)
     s->command_state =3D ga_command_state_new();
     ga_command_state_init(s, s->command_state);
     ga_command_state_init_all(s->command_state);
-    json_message_parser_init(&s->parser, process_event, s, NULL);
     qmp_session_init(&s->session, &ga_commands, dispatch_return_cb);
=20
 #ifndef _WIN32
@@ -1382,7 +1354,6 @@ static void cleanup_agent(GAState *s)
         qmp_session_destroy(&s->session);
         ga_command_state_cleanup_all(s->command_state);
         ga_command_state_free(s->command_state);
-        json_message_parser_destroy(&s->parser);
     }
     g_free(s->pstate_filepath);
     g_free(s->state_filepath_isfrozen);
--=20
2.24.0


