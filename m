Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED615CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:01:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A7B2166E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iv8OjtPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A7B2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNckA-0004Z7-HJ
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 09:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNcKd-0003gV-GA
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNcKb-00062q-LL
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49158
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNcKb-00062J-HD
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571920508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZaB6cQbBP3IPVQztMxQOqDmUDs0zqWb6Yq0qbftgKKY=;
 b=iv8OjtPs4cC5IR+0A3o9y7HpTMeP57O832LaA9Nu5cV7flw+3NwkdGHbsnqVo0LbOLii/H
 3WH9g5K4khyz4hfkcK4lPv7RuY8FVldPVBNbCw4xjCmj8aaUdUbp5E2xudjWxk1BBNVIQb
 cw5k5uMtLvZBdhvJ8aJuda/10VpLJ6k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-mqzGqOr0MhSM8Y-hu1DWJQ-1; Thu, 24 Oct 2019 08:35:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B7075E4;
 Thu, 24 Oct 2019 12:35:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8941752F6;
 Thu, 24 Oct 2019 12:35:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F232911384A8; Thu, 24 Oct 2019 14:34:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 01/19] tests/test-qmp-cmds: Factor out qmp_dispatch() test
 helpers
Date: Thu, 24 Oct 2019 14:34:40 +0200
Message-Id: <20191024123458.13505-2-armbru@redhat.com>
In-Reply-To: <20191024123458.13505-1-armbru@redhat.com>
References: <20191024123458.13505-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: mqzGqOr0MhSM8Y-hu1DWJQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

Checking the value of qmp_dispatch() is repetitive.  Factor out
helpers do_qmp_dispatch() and do_qmp_dispatch_error().  Without this,
the next commit would make things even more repetitive.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-qmp-cmds.c | 72 +++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 37 deletions(-)

diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 27b0afe55a..e738bead86 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -144,34 +144,55 @@ __org_qemu_x_Union1 *qmp___org_qemu_x_command(__org_q=
emu_x_EnumList *a,
 }
=20
=20
+static QObject *do_qmp_dispatch(QDict *req, bool allow_oob)
+{
+    QDict *resp;
+    QObject *ret;
+
+    resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req), allow_oob);
+    g_assert(resp && !qdict_haskey(resp, "error"));
+    ret =3D qdict_get(resp, "return");
+    g_assert(ret);
+
+    qobject_ref(ret);
+    qobject_unref(resp);
+    return ret;
+}
+
+static void do_qmp_dispatch_error(QDict *req, bool allow_oob, ErrorClass c=
ls)
+{
+    QDict *resp;
+
+    resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req), allow_oob);
+    g_assert(resp && qdict_haskey(resp, "error"));
+
+    qobject_unref(resp);
+}
+
 /* test commands with no input and no return value */
 static void test_dispatch_cmd(void)
 {
     QDict *req =3D qdict_new();
-    QDict *resp;
+    QObject *ret;
=20
     qdict_put_str(req, "execute", "user_def_cmd");
=20
-    resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req), false);
-    assert(resp !=3D NULL);
-    assert(!qdict_haskey(resp, "error"));
+    ret =3D do_qmp_dispatch(req, false);
=20
-    qobject_unref(resp);
+    qobject_unref(ret);
     qobject_unref(req);
 }
=20
 static void test_dispatch_cmd_oob(void)
 {
     QDict *req =3D qdict_new();
-    QDict *resp;
+    QObject *ret;
=20
     qdict_put_str(req, "exec-oob", "test-flags-command");
=20
-    resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req), true);
-    assert(resp !=3D NULL);
-    assert(!qdict_haskey(resp, "error"));
+    ret =3D do_qmp_dispatch(req, true);
=20
-    qobject_unref(resp);
+    qobject_unref(ret);
     qobject_unref(req);
 }
=20
@@ -180,15 +201,11 @@ static void test_dispatch_cmd_failure(void)
 {
     QDict *req =3D qdict_new();
     QDict *args =3D qdict_new();
-    QDict *resp;
=20
     qdict_put_str(req, "execute", "user_def_cmd2");
=20
-    resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req), false);
-    assert(resp !=3D NULL);
-    assert(qdict_haskey(resp, "error"));
+    do_qmp_dispatch_error(req, false, ERROR_CLASS_GENERIC_ERROR);
=20
-    qobject_unref(resp);
     qobject_unref(req);
=20
     /* check that with extra arguments it throws an error */
@@ -198,11 +215,8 @@ static void test_dispatch_cmd_failure(void)
=20
     qdict_put_str(req, "execute", "user_def_cmd");
=20
-    resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req), false);
-    assert(resp !=3D NULL);
-    assert(qdict_haskey(resp, "error"));
+    do_qmp_dispatch_error(req, false, ERROR_CLASS_GENERIC_ERROR);
=20
-    qobject_unref(resp);
     qobject_unref(req);
 }
=20
@@ -217,20 +231,6 @@ static void test_dispatch_cmd_success_response(void)
     qobject_unref(req);
 }
=20
-static QObject *test_qmp_dispatch(QDict *req)
-{
-    QDict *resp;
-    QObject *ret;
-
-    resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req), false);
-    assert(resp && !qdict_haskey(resp, "error"));
-    ret =3D qdict_get(resp, "return");
-    assert(ret);
-    qobject_ref(ret);
-    qobject_unref(resp);
-    return ret;
-}
-
 /* test commands that involve both input parameters and return values */
 static void test_dispatch_cmd_io(void)
 {
@@ -253,7 +253,7 @@ static void test_dispatch_cmd_io(void)
     qdict_put(req, "arguments", args);
     qdict_put_str(req, "execute", "user_def_cmd2");
=20
-    ret =3D qobject_to(QDict, test_qmp_dispatch(req));
+    ret =3D qobject_to(QDict, do_qmp_dispatch(req, false));
=20
     assert(!strcmp(qdict_get_str(ret, "string0"), "blah1"));
     ret_dict =3D qdict_get_qdict(ret, "dict1");
@@ -274,12 +274,10 @@ static void test_dispatch_cmd_io(void)
     qdict_put(req, "arguments", args3);
     qdict_put_str(req, "execute", "guest-get-time");
=20
-    ret3 =3D qobject_to(QNum, test_qmp_dispatch(req));
+    ret3 =3D qobject_to(QNum, do_qmp_dispatch(req, false));
     g_assert(qnum_get_try_int(ret3, &val));
     g_assert_cmpint(val, =3D=3D, 66);
     qobject_unref(ret3);
-
-    qobject_unref(req);
 }
=20
 /* test generated dealloc functions for generated types */
--=20
2.21.0


