Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681D4C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:21:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D25B20833
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D25B20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45785 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDtUy-0002c3-8D
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 12:21:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtLR-00032e-RO
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtLN-0004xe-Oi
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hDtLN-0004wB-3c
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BE259859FF;
	Tue,  9 Apr 2019 16:11:27 +0000 (UTC)
Received: from localhost (ovpn-112-27.ams2.redhat.com [10.36.112.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4AAB93844;
	Tue,  9 Apr 2019 16:11:23 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 18:10:00 +0200
Message-Id: <20190409161009.6322-12-marcandre.lureau@redhat.com>
In-Reply-To: <20190409161009.6322-1-marcandre.lureau@redhat.com>
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Tue, 09 Apr 2019 16:11:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 11/20] QmpSession: return orderly
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
Message-ID: <20190409161000.0uKIFiVucnvxCO2NWGao6Nb1BNTomRqH91FJjZ6t__M@z>

QEMU will gain support for asynchronous commands, and may thus finish
commands in various order. However, the clients expect replies in
order. Let's enforce ordering of replies in QmpReturn: starting from
the older command, process each pending QmpReturn, and return until
reaching one that is unfinished.

Or if the command is OOB, it should return immediately.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h |  2 ++
 qapi/qmp-dispatch.c         | 61 ++++++++++++++++++++++++++++++-------
 tests/test-qmp-cmds.c       | 33 ++++++++++++++++++++
 3 files changed, 85 insertions(+), 11 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 7c9de9780d..92d6fd1afb 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -55,6 +55,8 @@ struct QmpSession {
 struct QmpReturn {
     QmpSession *session;
     QDict *rsp;
+    bool oob;
+    bool finished;
     QTAILQ_ENTRY(QmpReturn) entry;
 };
=20
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 4699a6715b..546a6c9f7b 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -25,6 +25,7 @@ QmpReturn *qmp_return_new(QmpSession *session, const QO=
bject *request)
     const QDict *req =3D qobject_to(QDict, request);
     QObject *id =3D req ? qdict_get(req, "id") : NULL;
=20
+    qret->oob =3D req ? qmp_is_oob(req) : false;
     qret->session =3D session;
     qret->rsp =3D qdict_new();
     if (id) {
@@ -39,6 +40,15 @@ QmpReturn *qmp_return_new(QmpSession *session, const Q=
Object *request)
     return qret;
 }
=20
+static void qmp_return_free_with_lock(QmpReturn *qret)
+{
+    if (qret->session) {
+        QTAILQ_REMOVE(&qret->session->pending, qret, entry);
+    }
+    qobject_unref(qret->rsp);
+    g_free(qret);
+}
+
 void qmp_return_free(QmpReturn *qret)
 {
     QmpSession *session =3D qret->session;
@@ -46,21 +56,53 @@ void qmp_return_free(QmpReturn *qret)
     if (session) {
         qemu_mutex_lock(&session->pending_lock);
     }
-    QTAILQ_REMOVE(&session->pending, qret, entry);
+
+    qmp_return_free_with_lock(qret);
+
     if (session) {
         qemu_mutex_unlock(&session->pending_lock);
     }
-    qobject_unref(qret->rsp);
-    g_free(qret);
+}
+
+static void qmp_return_orderly(QmpReturn *qret)
+{
+    QmpSession *session =3D qret->session;
+    QmpReturn *ret, *next;
+
+    if (!session) {
+        /* the session was destroyed before return, discard */
+        qmp_return_free(qret);
+        return;
+    }
+    if (qret->oob) {
+        session->return_cb(session, qret->rsp);
+        qmp_return_free(qret);
+        return;
+    }
+
+    qret->finished =3D true;
+
+    qemu_mutex_lock(&session->pending_lock);
+    /*
+     * Process the list of pending and call return_cb until reaching
+     * an unfinished.
+     */
+    QTAILQ_FOREACH_SAFE(ret, &session->pending, entry, next) {
+        if (!ret->finished) {
+            break;
+        }
+        session->return_cb(session, ret->rsp);
+        ret->session =3D session;
+        qmp_return_free_with_lock(ret);
+    }
+
+    qemu_mutex_unlock(&session->pending_lock);
 }
=20
 void qmp_return(QmpReturn *qret, QObject *rsp)
 {
     qdict_put_obj(qret->rsp, "return", rsp ?: QOBJECT(qdict_new()));
-    if (qret->session) {
-        qret->session->return_cb(qret->session, qret->rsp);
-    }
-    qmp_return_free(qret);
+    qmp_return_orderly(qret);
 }
=20
 void qmp_return_error(QmpReturn *qret, Error *err)
@@ -70,10 +112,7 @@ void qmp_return_error(QmpReturn *qret, Error *err)
     qdict_put_str(qdict, "desc", error_get_pretty(err));
     qdict_put_obj(qret->rsp, "error", QOBJECT(qdict));
     error_free(err);
-    if (qret->session) {
-        qret->session->return_cb(qret->session, qret->rsp);
-    }
-    qmp_return_free(qret);
+    qmp_return_orderly(qret);
 }
=20
 static QDict *qmp_dispatch_check_obj(const QObject *request, bool allow_=
oob,
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index b4d0b0440a..c4593552e3 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -327,6 +327,38 @@ static void test_dealloc_partial(void)
     qapi_free_UserDefTwo(ud2);
 }
=20
+typedef struct QmpReturnOrderly {
+    QmpSession session;
+    int returns;
+} QmpReturnOrderly;
+
+static void dispatch_return_orderly(QmpSession *session, QDict *resp)
+{
+    QmpReturnOrderly *o =3D container_of(session, QmpReturnOrderly, sess=
ion);
+
+    o->returns++;
+}
+
+static void test_qmp_return_orderly(void)
+{
+    QDict *dict =3D qdict_new();
+    QmpReturnOrderly o =3D { 0, };
+    QmpReturn *r1, *r2, *r3;
+
+    qmp_session_init(&o.session, &qmp_commands, NULL, dispatch_return_or=
derly);
+    r1 =3D qmp_return_new(&o.session, NULL);
+    qdict_put_str(dict, "exec-oob", "test");
+    r2 =3D qmp_return_new(&o.session, QOBJECT(dict));
+    r3 =3D qmp_return_new(&o.session, NULL);
+    qmp_return(r3, NULL);
+    g_assert_cmpint(o.returns, =3D=3D, 0);
+    qmp_return(r2, NULL);
+    g_assert_cmpint(o.returns, =3D=3D, 1);
+    qmp_return(r1, NULL);
+    g_assert_cmpint(o.returns, =3D=3D, 3);
+    qmp_session_destroy(&o.session);
+    qobject_unref(dict);
+}
=20
 int main(int argc, char **argv)
 {
@@ -340,6 +372,7 @@ int main(int argc, char **argv)
                     test_dispatch_cmd_success_response);
     g_test_add_func("/qmp/dealloc_types", test_dealloc_types);
     g_test_add_func("/qmp/dealloc_partial", test_dealloc_partial);
+    g_test_add_func("/qmp/return_orderly", test_qmp_return_orderly);
=20
     test_qmp_init_marshal(&qmp_commands);
     g_test_run();
--=20
2.21.0.196.g041f5ea1cf


