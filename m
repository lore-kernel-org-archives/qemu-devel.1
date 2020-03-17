Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E81C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:04:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A52020724
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EG7GWmbj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A52020724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEAxU-0005Rd-FG
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 08:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEAoW-00085D-IC
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEAoU-0006Pl-VZ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:16 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56578)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEAoU-0006N3-R3
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584446114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ePcL4jMr5ho3uFRr0SwI3tKaouKaWGPYWwp+LQfUZMc=;
 b=EG7GWmbjLOLeL9lENdqccllzBBztpe3eRY7L9c29kIna7yjk5w+gpBUeMCr9jXwqdHaPSk
 2CpjsqccoMot6N2DqqO3XQX4+CCxtBLxwDr4M9ClWdeVSjYyoxMi9LJCEYIbiOBV2o4w9S
 gEqUc9A74GVhRJZFq8xd1ixx94uOe/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-QzxlLTXrNhW-R25ItuWmEQ-1; Tue, 17 Mar 2020 07:55:13 -0400
X-MC-Unique: QzxlLTXrNhW-R25ItuWmEQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FAA9800D4E;
 Tue, 17 Mar 2020 11:55:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B8CA9128E;
 Tue, 17 Mar 2020 11:55:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6C2F9113522F; Tue, 17 Mar 2020 12:55:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 23/34] qapi: Simplify how qmp_dispatch() gets the request ID
Date: Tue, 17 Mar 2020 12:54:48 +0100
Message-Id: <20200317115459.31821-24-armbru@redhat.com>
In-Reply-To: <20200317115459.31821-1-armbru@redhat.com>
References: <20200317115459.31821-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

We convert the request object to a QDict twice: first in
qmp_dispatch() to get the request ID, and then again in
qmp_dispatch_check_obj(), which converts to QDict, then checks and
returns it.  We can't get the request ID from the latter, because it's
null when the qdict flunks the checks.

Move the checked conversion to QDict from qmp_dispatch_check_obj() to
qmp_dispatch(), and drop the duplicate there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/qmp-dispatch.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 550d1fe8d2..91e50fa0dd 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -19,20 +19,13 @@
 #include "sysemu/runstate.h"
 #include "qapi/qmp/qbool.h"
=20
-static QDict *qmp_dispatch_check_obj(const QObject *request, bool allow_oo=
b,
+static QDict *qmp_dispatch_check_obj(QDict *dict, bool allow_oob,
                                      Error **errp)
 {
     const char *exec_key =3D NULL;
     const QDictEntry *ent;
     const char *arg_name;
     const QObject *arg_obj;
-    QDict *dict;
-
-    dict =3D qobject_to(QDict, request);
-    if (!dict) {
-        error_setg(errp, "QMP input must be a JSON object");
-        return NULL;
-    }
=20
     for (ent =3D qdict_first(dict); ent;
          ent =3D qdict_next(dict, ent)) {
@@ -103,13 +96,21 @@ QDict *qmp_dispatch(QmpCommandList *cmds, QObject *req=
uest,
     const char *command;
     QDict *args;
     QmpCommand *cmd;
-    QDict *dict =3D qobject_to(QDict, request);
-    QObject *id =3D dict ? qdict_get(dict, "id") : NULL;
+    QDict *dict;
+    QObject *id;
     QObject *ret =3D NULL;
     QDict *rsp =3D NULL;
=20
-    dict =3D qmp_dispatch_check_obj(request, allow_oob, &err);
+    dict =3D qobject_to(QDict, request);
     if (!dict) {
+        id =3D NULL;
+        error_setg(&err, "QMP input must be a JSON object");
+        goto out;
+    }
+
+    id =3D qdict_get(dict, "id");
+
+    if (!qmp_dispatch_check_obj(dict, allow_oob, &err)) {
         goto out;
     }
=20
--=20
2.21.1


