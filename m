Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DDAC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:14:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D26920409
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TyvmctLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D26920409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEJXb-0003S4-7l
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 17:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEJL9-0002p4-IZ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEJL4-0002dr-4T
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:01:30 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:44209)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEJL3-0002Xb-OZ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584478884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j5D3fVQN2NgaVKFgm80uMfzgpXjo0CFd4vAaYtoTCrU=;
 b=TyvmctLaNwfDXi+jMtiTeYW7OpFLCcRX+c12kR5rAG9NEFogq+BwlCRsp79Hgp2ZGloojW
 VOfV2YT0EiCHwGveF3Wy3PG/0VR5kFDfDk0A3HwSkqkYxtTcd7+1b0ZmXntLIIweqb7Bez
 BAEqtVTN1XUpnQdlUDF5MijZS4ikS9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-jjNBbPKSOm-qbW7WTEQnRg-1; Tue, 17 Mar 2020 17:01:22 -0400
X-MC-Unique: jjNBbPKSOm-qbW7WTEQnRg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28E3A801E6C
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 21:01:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E7E25D9E2;
 Tue, 17 Mar 2020 21:01:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 487D311366DF; Tue, 17 Mar 2020 22:01:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/30] tests/test-qmp-cmds: Check responses more thoroughly
Date: Tue, 17 Mar 2020 22:00:52 +0100
Message-Id: <20200317210115.8864-8-armbru@redhat.com>
In-Reply-To: <20200317210115.8864-1-armbru@redhat.com>
References: <20200317210115.8864-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200317115459.31821-7-armbru@redhat.com>
---
 tests/test-qmp-cmds.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index fb18475c7e..1563556e7c 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -151,9 +151,10 @@ static QObject *do_qmp_dispatch(QDict *req, bool allow=
_oob)
     QObject *ret;
=20
     resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req), allow_oob);
-    g_assert(resp && !qdict_haskey(resp, "error"));
+    g_assert(resp);
     ret =3D qdict_get(resp, "return");
     g_assert(ret);
+    g_assert(qdict_size(resp) =3D=3D 1);
=20
     qobject_ref(ret);
     qobject_unref(resp);
@@ -163,9 +164,17 @@ static QObject *do_qmp_dispatch(QDict *req, bool allow=
_oob)
 static void do_qmp_dispatch_error(QDict *req, bool allow_oob, ErrorClass c=
ls)
 {
     QDict *resp;
+    QDict *error;
=20
     resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req), allow_oob);
-    g_assert(resp && qdict_haskey(resp, "error"));
+    g_assert(resp);
+    error =3D qdict_get_qdict(resp, "error");
+    g_assert(error);
+    g_assert_cmpstr(qdict_get_try_str(error, "class"),
+                    =3D=3D, QapiErrorClass_str(cls));
+    g_assert(qdict_get_try_str(error, "desc"));
+    g_assert(qdict_size(error) =3D=3D 2);
+    g_assert(qdict_size(resp) =3D=3D 1);
=20
     qobject_unref(resp);
 }
@@ -174,11 +183,12 @@ static void do_qmp_dispatch_error(QDict *req, bool al=
low_oob, ErrorClass cls)
 static void test_dispatch_cmd(void)
 {
     QDict *req =3D qdict_new();
-    QObject *ret;
+    QDict *ret;
=20
     qdict_put_str(req, "execute", "user_def_cmd");
=20
-    ret =3D do_qmp_dispatch(req, false);
+    ret =3D qobject_to(QDict, do_qmp_dispatch(req, false));
+    assert(ret && qdict_size(ret) =3D=3D 0);
=20
     qobject_unref(ret);
     qobject_unref(req);
@@ -187,11 +197,12 @@ static void test_dispatch_cmd(void)
 static void test_dispatch_cmd_oob(void)
 {
     QDict *req =3D qdict_new();
-    QObject *ret;
+    QDict *ret;
=20
     qdict_put_str(req, "exec-oob", "test-flags-command");
=20
-    ret =3D do_qmp_dispatch(req, true);
+    ret =3D qobject_to(QDict, do_qmp_dispatch(req, true));
+    assert(ret && qdict_size(ret) =3D=3D 0);
=20
     qobject_unref(ret);
     qobject_unref(req);
--=20
2.21.1


