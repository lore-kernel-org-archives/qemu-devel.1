Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E178FCA9EBC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:55:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B002F205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMBfwlSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B002F205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNcdu-0004Ky-Lw
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNcKc-0003by-2f
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNcKa-00061k-AQ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23226
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNcKa-00061S-6K
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571920507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SemqXsPAY1Vd+OZb+KKA+UPO0kVAOEgdOZElEzsIGkA=;
 b=IMBfwlSe6wifF3+WSN5m+ikGITDZZCdCif/euiGK0NUnK5tQdRbvCqvvQQUAswxYWnXrL+
 ov1HAphaJqHmiYtkIxOIpPPfCBeJTXPFfruP/hGKmtXbct7iIlA8wOe7xyyiX627NcJ8pA
 U2JMURN7ATaz6M8JaTHb+45JFeIrJpw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-pCLIiQjgN3qmY0WmrV0Wjw-1; Thu, 24 Oct 2019 08:35:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC629107AD33;
 Thu, 24 Oct 2019 12:35:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B28B5D9CA;
 Thu, 24 Oct 2019 12:35:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 00DB31133034; Thu, 24 Oct 2019 14:34:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 02/19] tests/test-qmp-cmds: Check responses more thoroughly
Date: Thu, 24 Oct 2019 14:34:41 +0200
Message-Id: <20191024123458.13505-3-armbru@redhat.com>
In-Reply-To: <20191024123458.13505-1-armbru@redhat.com>
References: <20191024123458.13505-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: pCLIiQjgN3qmY0WmrV0Wjw-1
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-qmp-cmds.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index e738bead86..667e03cb1b 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -150,9 +150,10 @@ static QObject *do_qmp_dispatch(QDict *req, bool allow=
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
@@ -162,9 +163,17 @@ static QObject *do_qmp_dispatch(QDict *req, bool allow=
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
@@ -173,11 +182,12 @@ static void do_qmp_dispatch_error(QDict *req, bool al=
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
@@ -186,11 +196,12 @@ static void test_dispatch_cmd(void)
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
2.21.0


