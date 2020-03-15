Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DD5C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 14:53:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77797206B1
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 14:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3wsXyzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77797206B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDUdn-0002Qz-Gj
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 10:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jDUXf-0005Wy-Cj
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jDUXd-0002HK-7y
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22970
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jDUXd-0002FE-2R
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584283620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DolF0eQFcYj8TmoxPP0W7/I7b+3KWwKUpg3+CYqCpWk=;
 b=T3wsXyzTTa1LMuThBHMuz19MV9Kp8kadxTfx38PUUm+kfmEqMRMJQYmK+zb+swYoTBPJvC
 Y+4RpJ+hHy7KyktsMlQ8UNG6oIKoBBIE4U/RB1TCCEkP+lG9V95pwHLSyuO0jNB94UFAlq
 8bIrsznPLufXNkj2WZKsmghfS4gpnbc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-cW6aPzmtPJ-UEOfNeUVlOA-1; Sun, 15 Mar 2020 10:46:59 -0400
X-MC-Unique: cW6aPzmtPJ-UEOfNeUVlOA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52E688017CC;
 Sun, 15 Mar 2020 14:46:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-49.ams2.redhat.com
 [10.36.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2371D8C091;
 Sun, 15 Mar 2020 14:46:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BF459113522F; Sun, 15 Mar 2020 15:46:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 23/34] qapi: Simplify how qmp_dispatch() gets the request ID
Date: Sun, 15 Mar 2020 15:46:42 +0100
Message-Id: <20200315144653.22660-24-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-1-armbru@redhat.com>
References: <20200315144653.22660-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We convert the request object to a QDict twice: first in
qmp_dispatch() to get the request ID, and then again in
qmp_dispatch_check_obj(), which converts to QDict, then checks and
returns it.  We can't get the request ID from the latter, because it's
null when the qdict flunks the checks.

Move getting the request ID into qmp_dispatch_check_obj().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/qmp-dispatch.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 550d1fe8d2..112d29a9ab 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -20,7 +20,7 @@
 #include "qapi/qmp/qbool.h"
=20
 static QDict *qmp_dispatch_check_obj(const QObject *request, bool allow_oo=
b,
-                                     Error **errp)
+                                     QObject **id, Error **errp)
 {
     const char *exec_key =3D NULL;
     const QDictEntry *ent;
@@ -30,10 +30,13 @@ static QDict *qmp_dispatch_check_obj(const QObject *req=
uest, bool allow_oob,
=20
     dict =3D qobject_to(QDict, request);
     if (!dict) {
+        *id =3D NULL;
         error_setg(errp, "QMP input must be a JSON object");
         return NULL;
     }
=20
+    *id =3D qdict_get(dict, "id");
+
     for (ent =3D qdict_first(dict); ent;
          ent =3D qdict_next(dict, ent)) {
         arg_name =3D qdict_entry_key(ent);
@@ -103,12 +106,12 @@ QDict *qmp_dispatch(QmpCommandList *cmds, QObject *re=
quest,
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
+    dict =3D qmp_dispatch_check_obj(request, allow_oob, &id, &err);
     if (!dict) {
         goto out;
     }
--=20
2.21.1


