Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997CFC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:06:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6224120724
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/MsB5Oa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6224120724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEAzM-0001Qk-Gm
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 08:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEAoa-0008DQ-G9
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEAoY-0006kY-1C
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:20 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:42238)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEAoX-0006ei-R1
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584446116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0D4PB9YjJB08aB6926cQUW1CYMw+l3Wfh+7zQ7cWyvs=;
 b=V/MsB5OaBINkxW2xX5TMc7JAYYPGd3IRN7FEC/ltWCe8ceDKldNkWMqEr0QG6EAGVv+YQJ
 V5KomAYYYaZYYMHMepQ4/l7A1OCeShQM93dqnq5LS2L78nljfi2AO09WzH8MxWTwNkc6z5
 mwXcXNtlmN2Q2WWYzsgicLbaXu0Nmtw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-xQK2fX6lNy-hRrH9e1XMwA-1; Tue, 17 Mar 2020 07:55:14 -0400
X-MC-Unique: xQK2fX6lNy-hRrH9e1XMwA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51B8B8017CC;
 Tue, 17 Mar 2020 11:55:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D250953B9;
 Tue, 17 Mar 2020 11:55:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6619C11358C9; Tue, 17 Mar 2020 12:55:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 22/34] qapi: Simplify how qmp_dispatch() deals with
 QCO_NO_SUCCESS_RESP
Date: Tue, 17 Mar 2020 12:54:47 +0100
Message-Id: <20200317115459.31821-23-armbru@redhat.com>
In-Reply-To: <20200317115459.31821-1-armbru@redhat.com>
References: <20200317115459.31821-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/qmp-dispatch.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index a588072523..550d1fe8d2 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -106,7 +106,7 @@ QDict *qmp_dispatch(QmpCommandList *cmds, QObject *requ=
est,
     QDict *dict =3D qobject_to(QDict, request);
     QObject *id =3D dict ? qdict_get(dict, "id") : NULL;
     QObject *ret =3D NULL;
-    QDict *rsp;
+    QDict *rsp =3D NULL;
=20
     dict =3D qmp_dispatch_check_obj(request, allow_oob, &err);
     if (!dict) {
@@ -151,31 +151,32 @@ QDict *qmp_dispatch(QmpCommandList *cmds, QObject *re=
quest,
         args =3D qdict_get_qdict(dict, "arguments");
         qobject_ref(args);
     }
-
     cmd->fn(args, &ret, &err);
+    qobject_unref(args);
     if (err) {
-        ;
-    } else if (cmd->options & QCO_NO_SUCCESS_RESP) {
+        goto out;
+    }
+
+    if (cmd->options & QCO_NO_SUCCESS_RESP) {
         g_assert(!ret);
+        return NULL;
     } else if (!ret) {
         /* TODO turn into assertion */
         ret =3D QOBJECT(qdict_new());
     }
=20
-    qobject_unref(args);
+    rsp =3D qdict_new();
+    qdict_put_obj(rsp, "return", ret);
=20
 out:
     if (err) {
+        assert(!rsp);
         rsp =3D qmp_error_response(err);
-    } else if (ret) {
-        rsp =3D qdict_new();
-        qdict_put_obj(rsp, "return", ret);
-    } else {
-        /* Can only happen for commands with QCO_NO_SUCCESS_RESP */
-        rsp =3D NULL;
     }
=20
-    if (rsp && id) {
+    assert(rsp);
+
+    if (id) {
         qdict_put_obj(rsp, "id", qobject_ref(id));
     }
=20
--=20
2.21.1


