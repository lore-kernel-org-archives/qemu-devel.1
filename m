Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AECCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:08:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8BD72166E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWcwltwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8BD72166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdn8-0005hk-Kv
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNcKg-0003nf-1n
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNcKe-00067y-M7
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35304
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNcKe-00067G-I5
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571920512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0FX4zw8MbBKnMnJjqqP2YzVBQ+eQCNba0U4sF/U/f8=;
 b=EWcwltwLW101+I1GtcSJfe5Rxh+KNjiTEuzjcdP7KwtV6athPWNAvi8Wj986RT3kqlWoFE
 jxBGHq5Byxvxrl0KcwV6R0WNDb/qZ76HN5j6c0lozPq9QejA1bp4osomBVaqCTSkg6bL2d
 hjz2h0eFNQuSYWolN6Z5goS5gwOqP1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-1CSS3L2bPx-cETir2I70CA-1; Thu, 24 Oct 2019 08:35:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE3CE1005512;
 Thu, 24 Oct 2019 12:35:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AA3F600CC;
 Thu, 24 Oct 2019 12:35:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1E60B113294D; Thu, 24 Oct 2019 14:34:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 11/19] qapi: Simplify how qmp_dispatch() gets the request
 ID
Date: Thu, 24 Oct 2019 14:34:50 +0200
Message-Id: <20191024123458.13505-12-armbru@redhat.com>
In-Reply-To: <20191024123458.13505-1-armbru@redhat.com>
References: <20191024123458.13505-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 1CSS3L2bPx-cETir2I70CA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: libvir-list@redhat.com, mdroth@linux.vnet.ibm.com
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
index d1643fe37a..0cbb663097 100644
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
     QDict *rsp;
=20
-    dict =3D qmp_dispatch_check_obj(request, allow_oob, &err);
+    dict =3D qmp_dispatch_check_obj(request, allow_oob, &id, &err);
     if (!dict) {
         goto out;
     }
--=20
2.21.0


