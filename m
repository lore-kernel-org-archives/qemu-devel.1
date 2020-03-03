Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA42CC3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 16:41:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34CFF20838
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 16:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aW/aV66/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34CFF20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Abc-0007J5-3Q
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 11:41:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56921)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j9AVu-0004Kn-02
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 11:35:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j9AVs-00032V-RZ
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 11:35:21 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35617
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j9AVs-000324-Mo
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 11:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583253320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DolF0eQFcYj8TmoxPP0W7/I7b+3KWwKUpg3+CYqCpWk=;
 b=aW/aV66/5ChE0mwIUzRTeqROInesIJZLmmm5xh9D3QHlsUE7j8co+aBseaYvdvbidaP7m5
 B72j1Ppqlr6MVXTqRjpnKKtQ4msJTnNLOT2XYxzxC0a4Y2c4n0p0vj5veqGqZZtN+pUwLp
 jb861CLyLkVPBvwlLGCHAaEVstF3g1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-fso8hiD_Nu-ZEjckBe-ONw-1; Tue, 03 Mar 2020 11:35:18 -0500
X-MC-Unique: fso8hiD_Nu-ZEjckBe-ONw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8CC61007275;
 Tue,  3 Mar 2020 16:35:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C947719C4F;
 Tue,  3 Mar 2020 16:35:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 08DF611329BF; Tue,  3 Mar 2020 17:35:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 23/30] qapi: Simplify how qmp_dispatch() gets the request ID
Date: Tue,  3 Mar 2020 17:34:58 +0100
Message-Id: <20200303163505.32041-24-armbru@redhat.com>
In-Reply-To: <20200303163505.32041-1-armbru@redhat.com>
References: <20200303163505.32041-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: libvir-list@redhat.com, berrange@redhat.com, mdroth@linux.vnet.ibm.com
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


