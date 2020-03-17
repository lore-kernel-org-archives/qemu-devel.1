Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D85C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9A342074D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YWkxxPwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A342074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEAsT-0006Xk-Gj
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 07:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEAoU-00081i-U9
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEAoT-0006D6-6L
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:31064)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEAoT-0006Az-1t
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584446112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D0uvarjntmway33kjJNYBtUlb9puOJe40SGh5+RD2sw=;
 b=YWkxxPwkLIJWDMxjm65ZzxlaTnR721Axm0ZRopMm4SF2u5Rct5yUwsZ/V752G+mZtw1PTV
 cknA4fhIJoW5dkzeUCoBrh05ygR3R0dbMXVMwap8WCI6B+Q+zzYxgBo96dg5M1gO6CAu4L
 vXpafGUgIHRy7LCN8k3J7UD6Ems08QA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-AdOVuRQ-NOSRhMizGqh76w-1; Tue, 17 Mar 2020 07:55:11 -0400
X-MC-Unique: AdOVuRQ-NOSRhMizGqh76w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D101C102CE27;
 Tue, 17 Mar 2020 11:55:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C1E8E60BF3;
 Tue, 17 Mar 2020 11:55:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0CDAE11366DF; Tue, 17 Mar 2020 12:55:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 07/34] tests/test-qmp-cmds: Simplify test data setup
Date: Tue, 17 Mar 2020 12:54:32 +0100
Message-Id: <20200317115459.31821-8-armbru@redhat.com>
In-Reply-To: <20200317115459.31821-1-armbru@redhat.com>
References: <20200317115459.31821-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

Building requests with qdict_put() & friends is tedious to write and
hard to read.  Parse them from string literals with
qdict_from_vjsonf_nofail() instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/test-qmp-cmds.c | 95 +++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 57 deletions(-)

diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 1563556e7c..99013ff37b 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/error.h"
@@ -145,11 +146,16 @@ __org_qemu_x_Union1 *qmp___org_qemu_x_command(__org_q=
emu_x_EnumList *a,
 }
=20
=20
-static QObject *do_qmp_dispatch(QDict *req, bool allow_oob)
+static QObject *do_qmp_dispatch(bool allow_oob, const char *template, ...)
 {
-    QDict *resp;
+    va_list ap;
+    QDict *req, *resp;
     QObject *ret;
=20
+    va_start(ap, template);
+    req =3D qdict_from_vjsonf_nofail(template, ap);
+    va_end(ap);
+
     resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req), allow_oob);
     g_assert(resp);
     ret =3D qdict_get(resp, "return");
@@ -158,14 +164,21 @@ static QObject *do_qmp_dispatch(QDict *req, bool allo=
w_oob)
=20
     qobject_ref(ret);
     qobject_unref(resp);
+    qobject_unref(req);
     return ret;
 }
=20
-static void do_qmp_dispatch_error(QDict *req, bool allow_oob, ErrorClass c=
ls)
+static void do_qmp_dispatch_error(bool allow_oob, ErrorClass cls,
+                                  const char *template, ...)
 {
-    QDict *resp;
+    va_list ap;
+    QDict *req, *resp;
     QDict *error;
=20
+    va_start(ap, template);
+    req =3D qdict_from_vjsonf_nofail(template, ap);
+    va_end(ap);
+
     resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req), allow_oob);
     g_assert(resp);
     error =3D qdict_get_qdict(resp, "error");
@@ -177,59 +190,43 @@ static void do_qmp_dispatch_error(QDict *req, bool al=
low_oob, ErrorClass cls)
     g_assert(qdict_size(resp) =3D=3D 1);
=20
     qobject_unref(resp);
+    qobject_unref(req);
 }
=20
 /* test commands with no input and no return value */
 static void test_dispatch_cmd(void)
 {
-    QDict *req =3D qdict_new();
     QDict *ret;
=20
-    qdict_put_str(req, "execute", "user_def_cmd");
-
-    ret =3D qobject_to(QDict, do_qmp_dispatch(req, false));
+    ret =3D qobject_to(QDict,
+                     do_qmp_dispatch(false,
+                                     "{ 'execute': 'user_def_cmd' }"));
     assert(ret && qdict_size(ret) =3D=3D 0);
-
     qobject_unref(ret);
-    qobject_unref(req);
 }
=20
 static void test_dispatch_cmd_oob(void)
 {
-    QDict *req =3D qdict_new();
     QDict *ret;
=20
-    qdict_put_str(req, "exec-oob", "test-flags-command");
-
-    ret =3D qobject_to(QDict, do_qmp_dispatch(req, true));
+    ret =3D qobject_to(QDict,
+                     do_qmp_dispatch(true,
+                                     "{ 'exec-oob': 'test-flags-command' }=
"));
     assert(ret && qdict_size(ret) =3D=3D 0);
-
     qobject_unref(ret);
-    qobject_unref(req);
 }
=20
 /* test commands that return an error due to invalid parameters */
 static void test_dispatch_cmd_failure(void)
 {
-    QDict *req =3D qdict_new();
-    QDict *args =3D qdict_new();
-
-    qdict_put_str(req, "execute", "user_def_cmd2");
-
-    do_qmp_dispatch_error(req, false, ERROR_CLASS_GENERIC_ERROR);
-
-    qobject_unref(req);
-
-    /* check that with extra arguments it throws an error */
-    req =3D qdict_new();
-    qdict_put_int(args, "a", 66);
-    qdict_put(req, "arguments", args);
-
-    qdict_put_str(req, "execute", "user_def_cmd");
-
-    do_qmp_dispatch_error(req, false, ERROR_CLASS_GENERIC_ERROR);
-
-    qobject_unref(req);
+    /* missing arguments */
+    do_qmp_dispatch_error(false, ERROR_CLASS_GENERIC_ERROR,
+                          "{ 'execute': 'user_def_cmd2' }");
+
+    /* extra arguments */
+    do_qmp_dispatch_error(false, ERROR_CLASS_GENERIC_ERROR,
+                          "{ 'execute': 'user_def_cmd',"
+                          " 'arguments': { 'a': 66 } }");
 }
=20
 static void test_dispatch_cmd_success_response(void)
@@ -246,26 +243,15 @@ static void test_dispatch_cmd_success_response(void)
 /* test commands that involve both input parameters and return values */
 static void test_dispatch_cmd_io(void)
 {
-    QDict *req =3D qdict_new();
-    QDict *args =3D qdict_new();
-    QDict *args3 =3D qdict_new();
-    QDict *ud1a =3D qdict_new();
-    QDict *ud1b =3D qdict_new();
     QDict *ret, *ret_dict, *ret_dict_dict, *ret_dict_dict_userdef;
     QDict *ret_dict_dict2, *ret_dict_dict2_userdef;
     QNum *ret3;
     int64_t val;
=20
-    qdict_put_int(ud1a, "integer", 42);
-    qdict_put_str(ud1a, "string", "hello");
-    qdict_put_int(ud1b, "integer", 422);
-    qdict_put_str(ud1b, "string", "hello2");
-    qdict_put(args, "ud1a", ud1a);
-    qdict_put(args, "ud1b", ud1b);
-    qdict_put(req, "arguments", args);
-    qdict_put_str(req, "execute", "user_def_cmd2");
-
-    ret =3D qobject_to(QDict, do_qmp_dispatch(req, false));
+    ret =3D qobject_to(QDict, do_qmp_dispatch(false,
+        "{ 'execute': 'user_def_cmd2', 'arguments': {"
+        " 'ud1a': { 'integer': 42, 'string': 'hello' },"
+        " 'ud1b': { 'integer': 422, 'string': 'hello2' } } }"));
=20
     assert(!strcmp(qdict_get_str(ret, "string0"), "blah1"));
     ret_dict =3D qdict_get_qdict(ret, "dict1");
@@ -282,16 +268,11 @@ static void test_dispatch_cmd_io(void)
     assert(!strcmp(qdict_get_str(ret_dict_dict2, "string"), "blah4"));
     qobject_unref(ret);
=20
-    qdict_put_int(args3, "a", 66);
-    qdict_put(req, "arguments", args3);
-    qdict_put_str(req, "execute", "guest-get-time");
-
-    ret3 =3D qobject_to(QNum, do_qmp_dispatch(req, false));
+    ret3 =3D qobject_to(QNum, do_qmp_dispatch(false,
+        "{ 'execute': 'guest-get-time', 'arguments': { 'a': 66 } }"));
     g_assert(qnum_get_try_int(ret3, &val));
     g_assert_cmpint(val, =3D=3D, 66);
     qobject_unref(ret3);
-
-    qobject_unref(req);
 }
=20
 /* test generated dealloc functions for generated types */
--=20
2.21.1


