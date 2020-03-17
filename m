Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF13C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:12:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF0342076B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqSuNXoG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF0342076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEB5R-0005e1-2C
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 08:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEAog-0008PA-Us
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEAoe-0007Lf-Vi
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:26 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:36554)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEAoe-0007JH-PQ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584446124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=60n4UvY4nJ9qhhi+o1KATEXmoVRpzmup+ji/INf9+7E=;
 b=VqSuNXoGUigJABQkna7TyhMWFbOEllBCHrsVcR/bOemysmUkkpmf+WBZt1slZYbhX9S/IM
 mlr2OWFgGu6XocGqoacuXMWIGz3r+ZRr6OSWn+1SARMgrYNJRY2CMnV6bioUnOzBJUIWWH
 bU0GGxhVfXorYnerh++noSLX/qGm0lk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-kKdbWKsZO6qO_bp64ftKuA-1; Tue, 17 Mar 2020 07:55:16 -0400
X-MC-Unique: kKdbWKsZO6qO_bp64ftKuA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83F4C149E2;
 Tue, 17 Mar 2020 11:55:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4747F10027AA;
 Tue, 17 Mar 2020 11:55:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9D3F211336AF; Tue, 17 Mar 2020 12:55:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 33/34] qapi: Implement deprecated-input=reject for QMP
 command arguments
Date: Tue, 17 Mar 2020 12:54:58 +0100
Message-Id: <20200317115459.31821-34-armbru@redhat.com>
In-Reply-To: <20200317115459.31821-1-armbru@redhat.com>
References: <20200317115459.31821-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: marcandre.lureau@gmail.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This policy rejects deprecated input, and thus permits "testing the
future".  Implement it for QMP command arguments: reject commands with
deprecated ones.  Example: when QEMU is run with -compat
deprecated-input=3Dreject, then

    {"execute": "eject", "arguments": {"device": "cd"}}

fails like this

    {"error": {"class": "GenericError", "desc": "Deprecated parameter 'devi=
ce' disabled by policy"}}

When the argument is removed, the error will change to

    {"error": {"class": "GenericError", "desc": "Parameter 'device' is unex=
pected"}}

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qobject-input-visitor.h |  9 +++++++++
 include/qapi/visitor-impl.h          |  2 +-
 include/qapi/visitor.h               |  2 +-
 qapi/qapi-visit-core.c               |  4 ++--
 qapi/qobject-input-visitor.c         | 28 ++++++++++++++++++++++++++++
 qapi/qobject-output-visitor.c        |  3 ++-
 tests/test-qmp-cmds.c                | 25 +++++++++++++++++++++++++
 scripts/qapi/commands.py             |  2 +-
 scripts/qapi/visit.py                | 10 ++++++----
 9 files changed, 75 insertions(+), 10 deletions(-)

diff --git a/include/qapi/qobject-input-visitor.h b/include/qapi/qobject-in=
put-visitor.h
index 95985e25e5..cbc54de4ac 100644
--- a/include/qapi/qobject-input-visitor.h
+++ b/include/qapi/qobject-input-visitor.h
@@ -58,6 +58,15 @@ typedef struct QObjectInputVisitor QObjectInputVisitor;
  */
 Visitor *qobject_input_visitor_new(QObject *obj);
=20
+/*
+ * Create a QObject input visitor for @obj for use with QMP
+ *
+ * This is like qobject_input_visitor_new(), except it obeys the
+ * policy for handling deprecated management interfaces set with
+ * -compat.
+ */
+Visitor *qobject_input_visitor_new_qmp(QObject *obj);
+
 /*
  * Create a QObject input visitor for @obj for use with keyval_parse()
  *
diff --git a/include/qapi/visitor-impl.h b/include/qapi/visitor-impl.h
index a6b26b7a5b..ccc159a0d2 100644
--- a/include/qapi/visitor-impl.h
+++ b/include/qapi/visitor-impl.h
@@ -111,7 +111,7 @@ struct Visitor
     void (*optional)(Visitor *v, const char *name, bool *present);
=20
     /* Optional */
-    bool (*deprecated)(Visitor *v, const char *name);
+    bool (*deprecated)(Visitor *v, const char *name, Error **errp);
=20
     /* Must be set */
     VisitorType type;
diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index c89d51b2a4..2a3c4d0407 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -456,7 +456,7 @@ bool visit_optional(Visitor *v, const char *name, bool =
*present);
  * visit_start_struct() and visit_end_struct(), since only objects
  * have deprecated members.
  */
-bool visit_deprecated(Visitor *v, const char *name);
+bool visit_deprecated(Visitor *v, const char *name, Error **errp);
=20
 /*
  * Visit an enum value.
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index 501b3ccdef..71e4978a6f 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -137,11 +137,11 @@ bool visit_optional(Visitor *v, const char *name, boo=
l *present)
     return *present;
 }
=20
-bool visit_deprecated(Visitor *v, const char *name)
+bool visit_deprecated(Visitor *v, const char *name, Error **errp)
 {
     trace_visit_deprecated(v, name);
     if (v->deprecated) {
-        return v->deprecated(v, name);
+        return v->deprecated(v, name, errp);
     }
     return true;
 }
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 32236cbcb1..6ea93f5a7a 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -14,6 +14,7 @@
=20
 #include "qemu/osdep.h"
 #include <math.h>
+#include "qapi/compat-policy.h"
 #include "qapi/error.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/visitor-impl.h"
@@ -43,6 +44,7 @@ typedef struct StackObject {
=20
 struct QObjectInputVisitor {
     Visitor visitor;
+    CompatPolicyInput deprecated_policy;
=20
     /* Root of visit at visitor creation. */
     QObject *root;
@@ -640,6 +642,23 @@ static void qobject_input_optional(Visitor *v, const c=
har *name, bool *present)
     *present =3D true;
 }
=20
+static bool qobject_input_deprecated(Visitor *v, const char *name,
+                                     Error **errp)
+{
+    QObjectInputVisitor *qiv =3D to_qiv(v);
+
+    switch (qiv->deprecated_policy) {
+    case COMPAT_POLICY_INPUT_ACCEPT:
+        return true;
+    case COMPAT_POLICY_INPUT_REJECT:
+        error_setg(errp, "Deprecated parameter '%s' disabled by policy",
+                   name);
+        return false;
+    default:
+        abort();
+    }
+}
+
 static void qobject_input_free(Visitor *v)
 {
     QObjectInputVisitor *qiv =3D to_qiv(v);
@@ -674,6 +693,7 @@ static QObjectInputVisitor *qobject_input_visitor_base_=
new(QObject *obj)
     v->visitor.end_list =3D qobject_input_end_list;
     v->visitor.start_alternate =3D qobject_input_start_alternate;
     v->visitor.optional =3D qobject_input_optional;
+    v->visitor.deprecated =3D qobject_input_deprecated;
     v->visitor.free =3D qobject_input_free;
=20
     v->root =3D qobject_ref(obj);
@@ -696,6 +716,14 @@ Visitor *qobject_input_visitor_new(QObject *obj)
     return &v->visitor;
 }
=20
+Visitor *qobject_input_visitor_new_qmp(QObject *obj)
+{
+    QObjectInputVisitor *v =3D to_qiv(qobject_input_visitor_new(obj));
+
+    v->deprecated_policy =3D compat_policy.deprecated_input;
+    return &v->visitor;
+}
+
 Visitor *qobject_input_visitor_new_keyval(QObject *obj)
 {
     QObjectInputVisitor *v =3D qobject_input_visitor_base_new(obj);
diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visitor.c
index 84cee17596..73983ca5cc 100644
--- a/qapi/qobject-output-visitor.c
+++ b/qapi/qobject-output-visitor.c
@@ -201,7 +201,8 @@ static void qobject_output_type_null(Visitor *v, const =
char *name,
     qobject_output_add(qov, name, qnull());
 }
=20
-static bool qobject_output_deprecated(Visitor *v, const char *name)
+static bool qobject_output_deprecated(Visitor *v, const char *name,
+                                      Error **errp)
 {
     QObjectOutputVisitor *qov =3D to_qov(v);
=20
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index a2099fee7d..4ca658acf9 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -299,6 +299,29 @@ static void test_dispatch_cmd_deprecated(void)
     do_qmp_dispatch_error(false, ERROR_CLASS_COMMAND_NOT_FOUND, cmd);
 }
=20
+static void test_dispatch_cmd_arg_deprecated(void)
+{
+    const char *cmd =3D "{ 'execute': 'test-features0',"
+        " 'arguments': { 'fs1': { 'foo': 42 } } }";
+    QDict *ret;
+
+    memset(&compat_policy, 0, sizeof(compat_policy));
+
+    /* accept */
+    ret =3D qobject_to(QDict, do_qmp_dispatch(false, cmd));
+    assert(ret && qdict_size(ret) =3D=3D 1);
+    qobject_unref(ret);
+
+    compat_policy.has_deprecated_input =3D true;
+    compat_policy.deprecated_input =3D COMPAT_POLICY_INPUT_ACCEPT;
+    ret =3D qobject_to(QDict, do_qmp_dispatch(false, cmd));
+    assert(ret && qdict_size(ret) =3D=3D 1);
+    qobject_unref(ret);
+
+    compat_policy.deprecated_input =3D COMPAT_POLICY_INPUT_REJECT;
+    do_qmp_dispatch_error(false, ERROR_CLASS_GENERIC_ERROR, cmd);
+}
+
 static void test_dispatch_cmd_ret_deprecated(void)
 {
     const char *cmd =3D "{ 'execute': 'test-features0' }";
@@ -399,6 +422,8 @@ int main(int argc, char **argv)
                     test_dispatch_cmd_success_response);
     g_test_add_func("/qmp/dispatch_cmd_deprecated",
                     test_dispatch_cmd_deprecated);
+    g_test_add_func("/qmp/dispatch_cmd_arg_deprecated",
+                    test_dispatch_cmd_arg_deprecated);
     g_test_add_func("/qmp/dispatch_cmd_ret_deprecated",
                     test_dispatch_cmd_ret_deprecated);
     g_test_add_func("/qmp/dealloc_types", test_dealloc_types);
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index f628bbf144..3fb4ed42ed 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -132,7 +132,7 @@ def gen_marshal(name, arg_type, boxed, ret_type):
         push_indent()
=20
     ret +=3D mcgen('''
-    v =3D qobject_input_visitor_new(QOBJECT(args));
+    v =3D qobject_input_visitor_new_qmp(QOBJECT(args));
     visit_start_struct(v, NULL, NULL, 0, &err);
     if (err) {
         goto out;
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 21df3abed2..9119eb015b 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -66,15 +66,12 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_name=
)s *obj, Error **errp)
             push_indent()
         if deprecated:
             ret +=3D mcgen('''
-    if (visit_deprecated(v, "%(name)s")) {
+    if (visit_deprecated(v, "%(name)s", &err)) {
 ''',
                          name=3Dmemb.name)
             push_indent()
         ret +=3D mcgen('''
     visit_type_%(c_type)s(v, "%(name)s", &obj->%(c_name)s, &err);
-    if (err) {
-        goto out;
-    }
 ''',
                      c_type=3Dmemb.type.c_name(), name=3Dmemb.name,
                      c_name=3Dc_name(memb.name))
@@ -82,6 +79,11 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_name)=
s *obj, Error **errp)
             pop_indent()
             ret +=3D mcgen('''
     }
+''')
+        ret +=3D mcgen('''
+    if (err) {
+        goto out;
+    }
 ''')
         if memb.optional:
             pop_indent()
--=20
2.21.1


