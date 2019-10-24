Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD48BCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 889B82084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TnPbxi+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889B82084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNd3t-00035c-Gg
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 09:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNcKc-0003di-Bo
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNcKa-00061z-Kv
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28798
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNcKa-00061c-Gt
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571920507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tUGFGut42C7Eg3kJl6e085bOhjnnZCRoXhBoIDYsbvo=;
 b=TnPbxi+lhu4VJt6pnSy1dvDTVDewLISY3Uh4y0f8wUaoI9J+Nn9lxQ+PE1kxT3Bwk1ksbp
 2GOvfmSaBKlbqQTl7zi7S6lxgslVoulq07UKDY75dZ9gIKkgJFSOeJMY1JK7DNTHaRIS28
 mGpq4LNs10mxkyEupuGPK1thGlXsVlk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-xqx0-tj1NXOSZQujijkKxQ-1; Thu, 24 Oct 2019 08:35:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DF6D801E5C;
 Thu, 24 Oct 2019 12:35:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EB6A19D70;
 Thu, 24 Oct 2019 12:35:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 045121132D6D; Thu, 24 Oct 2019 14:34:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 03/19] tests/test-qmp-cmds: Simplify test data setup
Date: Thu, 24 Oct 2019 14:34:42 +0200
Message-Id: <20191024123458.13505-4-armbru@redhat.com>
In-Reply-To: <20191024123458.13505-1-armbru@redhat.com>
References: <20191024123458.13505-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: xqx0-tj1NXOSZQujijkKxQ-1
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

Building requests with qdict_put() & friends is tedious to write and
hard to read.  Parse them from string literals with
qdict_from_vjsonf_nofail() instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-qmp-cmds.c | 93 ++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 55 deletions(-)

diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 667e03cb1b..3798ba1b16 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/error.h"
@@ -144,11 +145,16 @@ __org_qemu_x_Union1 *qmp___org_qemu_x_command(__org_q=
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
@@ -157,14 +163,21 @@ static QObject *do_qmp_dispatch(QDict *req, bool allo=
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
@@ -176,59 +189,43 @@ static void do_qmp_dispatch_error(QDict *req, bool al=
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
@@ -245,26 +242,15 @@ static void test_dispatch_cmd_success_response(void)
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
@@ -281,11 +267,8 @@ static void test_dispatch_cmd_io(void)
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
--=20
2.21.0


