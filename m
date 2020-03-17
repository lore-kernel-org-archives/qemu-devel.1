Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9485EC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:03:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F17320663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGt745Ep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F17320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEAwA-00031C-HG
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 08:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEAoZ-0008AO-6g
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEAoX-0006et-3U
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:31110)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEAoW-0006cC-Sb
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584446116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g00Prh+uvQe+VSOmvW8i9oEnkuZZI+qq9LLubpzlJw0=;
 b=EGt745Ep5FctyDMZRfqJch1wnj49RJr2BZDqD8hgVaRSixs+ZqICFY2EL/QJE5GyH+nATD
 +TRgO62ZYXjMVcTYcg3XhlRSoq74ZMMsvu89yS+Tn0YjBO5hgB4Y6sjhSu/v3xM1kRw3F6
 RfLBoC9n6O4Wv4jANm2aZA+EOB1XoPw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-I0-VlpQLPra7urAgHnE7MA-1; Tue, 17 Mar 2020 07:55:15 -0400
X-MC-Unique: I0-VlpQLPra7urAgHnE7MA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F1E21922960;
 Tue, 17 Mar 2020 11:55:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B504953B1;
 Tue, 17 Mar 2020 11:55:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 60ACA11358A3; Tue, 17 Mar 2020 12:55:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 21/34] qapi: Inline do_qmp_dispatch() into qmp_dispatch()
Date: Tue, 17 Mar 2020 12:54:46 +0100
Message-Id: <20200317115459.31821-22-armbru@redhat.com>
In-Reply-To: <20200317115459.31821-1-armbru@redhat.com>
References: <20200317115459.31821-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: marcandre.lureau@gmail.com, mdroth@linux.vnet.ibm.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both functions check @request is a QDict, and both have code for
QCO_NO_SUCCESS_RESP.  This wasn't the case back when they were
created.  It's a sign of muddled responsibilities.  Inline.  The next
commits will clean up some more.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/qmp-dispatch.c | 90 +++++++++++++++++++++------------------------
 1 file changed, 41 insertions(+), 49 deletions(-)

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index bc264b3c9b..a588072523 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -75,19 +75,42 @@ static QDict *qmp_dispatch_check_obj(const QObject *req=
uest, bool allow_oob,
     return dict;
 }
=20
-static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
-                                bool allow_oob, Error **errp)
+QDict *qmp_error_response(Error *err)
 {
-    Error *local_err =3D NULL;
+    QDict *rsp;
+
+    rsp =3D qdict_from_jsonf_nofail("{ 'error': { 'class': %s, 'desc': %s =
} }",
+                                  QapiErrorClass_str(error_get_class(err))=
,
+                                  error_get_pretty(err));
+    error_free(err);
+    return rsp;
+}
+
+/*
+ * Does @qdict look like a command to be run out-of-band?
+ */
+bool qmp_is_oob(const QDict *dict)
+{
+    return qdict_haskey(dict, "exec-oob")
+        && !qdict_haskey(dict, "execute");
+}
+
+QDict *qmp_dispatch(QmpCommandList *cmds, QObject *request,
+                    bool allow_oob)
+{
+    Error *err =3D NULL;
     bool oob;
     const char *command;
-    QDict *args, *dict;
+    QDict *args;
     QmpCommand *cmd;
+    QDict *dict =3D qobject_to(QDict, request);
+    QObject *id =3D dict ? qdict_get(dict, "id") : NULL;
     QObject *ret =3D NULL;
+    QDict *rsp;
=20
-    dict =3D qmp_dispatch_check_obj(request, allow_oob, errp);
+    dict =3D qmp_dispatch_check_obj(request, allow_oob, &err);
     if (!dict) {
-        return NULL;
+        goto out;
     }
=20
     command =3D qdict_get_try_str(dict, "execute");
@@ -99,27 +122,27 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds, =
QObject *request,
     }
     cmd =3D qmp_find_command(cmds, command);
     if (cmd =3D=3D NULL) {
-        error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
+        error_set(&err, ERROR_CLASS_COMMAND_NOT_FOUND,
                   "The command %s has not been found", command);
-        return NULL;
+        goto out;
     }
     if (!cmd->enabled) {
-        error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
+        error_set(&err, ERROR_CLASS_COMMAND_NOT_FOUND,
                   "The command %s has been disabled for this instance",
                   command);
-        return NULL;
+        goto out;
     }
     if (oob && !(cmd->options & QCO_ALLOW_OOB)) {
-        error_setg(errp, "The command %s does not support OOB",
+        error_setg(&err, "The command %s does not support OOB",
                    command);
-        return NULL;
+        goto out;
     }
=20
     if (runstate_check(RUN_STATE_PRECONFIG) &&
         !(cmd->options & QCO_ALLOW_PRECONFIG)) {
-        error_setg(errp, "The command '%s' isn't permitted in '%s' state",
+        error_setg(&err, "The command '%s' isn't permitted in '%s' state",
                    cmd->name, RunState_str(RUN_STATE_PRECONFIG));
-        return NULL;
+        goto out;
     }
=20
     if (!qdict_haskey(dict, "arguments")) {
@@ -129,9 +152,9 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds, Q=
Object *request,
         qobject_ref(args);
     }
=20
-    cmd->fn(args, &ret, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    cmd->fn(args, &ret, &err);
+    if (err) {
+        ;
     } else if (cmd->options & QCO_NO_SUCCESS_RESP) {
         g_assert(!ret);
     } else if (!ret) {
@@ -141,38 +164,7 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds, =
QObject *request,
=20
     qobject_unref(args);
=20
-    return ret;
-}
-
-QDict *qmp_error_response(Error *err)
-{
-    QDict *rsp;
-
-    rsp =3D qdict_from_jsonf_nofail("{ 'error': { 'class': %s, 'desc': %s =
} }",
-                                  QapiErrorClass_str(error_get_class(err))=
,
-                                  error_get_pretty(err));
-    error_free(err);
-    return rsp;
-}
-
-/*
- * Does @qdict look like a command to be run out-of-band?
- */
-bool qmp_is_oob(const QDict *dict)
-{
-    return qdict_haskey(dict, "exec-oob")
-        && !qdict_haskey(dict, "execute");
-}
-
-QDict *qmp_dispatch(QmpCommandList *cmds, QObject *request,
-                    bool allow_oob)
-{
-    Error *err =3D NULL;
-    QDict *dict =3D qobject_to(QDict, request);
-    QObject *ret, *id =3D dict ? qdict_get(dict, "id") : NULL;
-    QDict *rsp;
-
-    ret =3D do_qmp_dispatch(cmds, request, allow_oob, &err);
+out:
     if (err) {
         rsp =3D qmp_error_response(err);
     } else if (ret) {
--=20
2.21.1


