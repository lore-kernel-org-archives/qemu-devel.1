Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498B3C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:59:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8E0820663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ervTr/Y5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E0820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEAsC-0005u2-1I
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 07:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEAoT-0007wU-30
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEAoR-0005xy-J3
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:27530)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEAoR-0005tX-EV
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584446111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kf+1SEw5rF2M4TLuz4qDRuz7bjjAQazXHPlRzdIIh0o=;
 b=ervTr/Y5Yt568bmX8n/iHxVNMBu+pksKGeL8xPprto+c/6vQ5QKeSbayTz+xV9gGpeAln8
 Kv2xJFIkrhkPSb0SyZMa+WKGy0oWniEREGXfsE0IUCZmAs8ysNfK3EXUNfahQC7iPwQU8w
 K6JkoJEBznxOQMy+up7OL076n3p/FsM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-46Kj5pQqNY6peF7i5D8PrA-1; Tue, 17 Mar 2020 07:55:09 -0400
X-MC-Unique: 46Kj5pQqNY6peF7i5D8PrA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17DEEDBA3;
 Tue, 17 Mar 2020 11:55:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE5031036B53;
 Tue, 17 Mar 2020 11:55:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0676111366D5; Tue, 17 Mar 2020 12:55:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 05/34] tests/test-qmp-cmds: Factor out qmp_dispatch() test
 helpers
Date: Tue, 17 Mar 2020 12:54:30 +0100
Message-Id: <20200317115459.31821-6-armbru@redhat.com>
In-Reply-To: <20200317115459.31821-1-armbru@redhat.com>
References: <20200317115459.31821-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: marcandre.lureau@gmail.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Checking the value of qmp_dispatch() is repetitive.  Factor out
helpers do_qmp_dispatch() and do_qmp_dispatch_error().  Without this,
the next commit would make things even more repetitive.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/test-qmp-cmds.c | 70 +++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 79507d9e54..fb18475c7e 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -145,34 +145,55 @@ __org_qemu_x_Union1 *qmp___org_qemu_x_command(__org_q=
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
@@ -181,15 +202,11 @@ static void test_dispatch_cmd_failure(void)
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
@@ -199,11 +216,8 @@ static void test_dispatch_cmd_failure(void)
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
@@ -218,20 +232,6 @@ static void test_dispatch_cmd_success_response(void)
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
@@ -254,7 +254,7 @@ static void test_dispatch_cmd_io(void)
     qdict_put(req, "arguments", args);
     qdict_put_str(req, "execute", "user_def_cmd2");
=20
-    ret =3D qobject_to(QDict, test_qmp_dispatch(req));
+    ret =3D qobject_to(QDict, do_qmp_dispatch(req, false));
=20
     assert(!strcmp(qdict_get_str(ret, "string0"), "blah1"));
     ret_dict =3D qdict_get_qdict(ret, "dict1");
@@ -275,7 +275,7 @@ static void test_dispatch_cmd_io(void)
     qdict_put(req, "arguments", args3);
     qdict_put_str(req, "execute", "guest-get-time");
=20
-    ret3 =3D qobject_to(QNum, test_qmp_dispatch(req));
+    ret3 =3D qobject_to(QNum, do_qmp_dispatch(req, false));
     g_assert(qnum_get_try_int(ret3, &val));
     g_assert_cmpint(val, =3D=3D, 66);
     qobject_unref(ret3);
--=20
2.21.1


