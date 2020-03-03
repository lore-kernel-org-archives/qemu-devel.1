Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BB8C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 16:49:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B6D020863
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 16:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fA4598Yn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6D020863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9AjN-0005vm-JM
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 11:49:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j9AVy-0004U2-90
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 11:35:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j9AVv-00035K-QY
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 11:35:26 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50584
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j9AVv-00034h-Kw
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 11:35:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583253323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=namzcJL7H+P9R7eVK9JjD1sr8RCU31GMrX+vUBSmwYI=;
 b=fA4598YnVPM50FYf3np13HAsbP3F9PKu3PjYLv+NVbISUOcLgQvBWcuWS1vMqs+VZ0cjfl
 y6MruisiHQ4vFUNYXQexp/QcsGGvVkHGzxWfEOYRhldu91h8POz4lCu5KYd+CwqHTTGxkJ
 Hr/gdU72Iico4J885PCeoyYwkTZirRE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-zDuHqB5AMaGDb2pmo0JuUA-1; Tue, 03 Mar 2020 11:35:19 -0500
X-MC-Unique: zDuHqB5AMaGDb2pmo0JuUA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CE881005510;
 Tue,  3 Mar 2020 16:35:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B11D373876;
 Tue,  3 Mar 2020 16:35:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1CE6211326E1; Tue,  3 Mar 2020 17:35:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 29/30] qapi: Implement -compat deprecated-input=reject
Date: Tue,  3 Mar 2020 17:35:04 +0100
Message-Id: <20200303163505.32041-30-armbru@redhat.com>
In-Reply-To: <20200303163505.32041-1-armbru@redhat.com>
References: <20200303163505.32041-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: libvir-list@redhat.com, berrange@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This policy makes deprecated commands fail like this:

    ---> {"execute": "query-cpus"}
    <--- {"error": {"class": "CommandNotFound", "desc": "Deprecated command=
 query-cpus disabled by policy"}}

When the command is removed, the error will change to

    <--- {"error": {"class": "CommandNotFound", "desc": "The command query-=
cpus has not been found"}}

It makes commands with deprecated arguments fail like this:

    ---> {"execute": "block-commit", "arguments": {"device": "virtio0", "to=
p": "/tmp/snap1.qcow2"}}
    <--- {"error": {"class": "GenericError", "desc": "Deprecated parameter =
'top' disabled by policy"}}

When the argument is removed, the error will change to

    <--- {"error": {"class": "GenericError", "desc": "Parameter 'top' is un=
expected"}}

The policy thus permits "testing the future".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/dispatch.h          |  1 +
 include/qapi/qobject-input-visitor.h |  9 +++++
 include/qapi/visitor-impl.h          |  2 +-
 include/qapi/visitor.h               |  2 +-
 qapi/qapi-visit-core.c               |  4 +--
 qapi/qmp-dispatch.c                  | 13 ++++++++
 qapi/qobject-input-visitor.c         | 28 ++++++++++++++++
 qapi/qobject-output-visitor.c        |  3 +-
 tests/test-qmp-cmds.c                | 49 ++++++++++++++++++++++++++++
 scripts/qapi/commands.py             | 12 ++++---
 scripts/qapi/visit.py                | 10 +++---
 11 files changed, 120 insertions(+), 13 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 9aa426a398..ef256f2bb7 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -24,6 +24,7 @@ typedef enum QmpCommandOptions
     QCO_NO_SUCCESS_RESP       =3D  (1U << 0),
     QCO_ALLOW_OOB             =3D  (1U << 1),
     QCO_ALLOW_PRECONFIG       =3D  (1U << 2),
+    QCO_DEPRECATED            =3D  (1U << 3),
 } QmpCommandOptions;
=20
 typedef struct QmpCommand
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
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 80beab517f..516ee9b0b7 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -132,6 +132,19 @@ QDict *qmp_dispatch(QmpCommandList *cmds, QObject *req=
uest,
                   "The command %s has not been found", command);
         goto out;
     }
+    if (cmd->options & QCO_DEPRECATED) {
+        switch (compat_policy.deprecated_input) {
+        case COMPAT_POLICY_INPUT_ACCEPT:
+            break;
+        case COMPAT_POLICY_INPUT_REJECT:
+            error_set(&err, ERROR_CLASS_COMMAND_NOT_FOUND,
+                      "Deprecated command %s disabled by policy",
+                      command);
+            goto out;
+        default:
+            abort();
+        }
+    }
     if (!cmd->enabled) {
         error_set(&err, ERROR_CLASS_COMMAND_NOT_FOUND,
                   "The command %s has been disabled for this instance",
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
index 82d599630c..4ca658acf9 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -277,6 +277,51 @@ static void test_dispatch_cmd_io(void)
     qobject_unref(ret3);
 }
=20
+static void test_dispatch_cmd_deprecated(void)
+{
+    const char *cmd =3D "{ 'execute': 'test-command-features1' }";
+    QDict *ret;
+
+    memset(&compat_policy, 0, sizeof(compat_policy));
+
+    /* accept */
+    ret =3D qobject_to(QDict, do_qmp_dispatch(false, cmd));
+    assert(ret && qdict_size(ret) =3D=3D 0);
+    qobject_unref(ret);
+
+    compat_policy.has_deprecated_input =3D true;
+    compat_policy.deprecated_input =3D COMPAT_POLICY_INPUT_ACCEPT;
+    ret =3D qobject_to(QDict, do_qmp_dispatch(false, cmd));
+    assert(ret && qdict_size(ret) =3D=3D 0);
+    qobject_unref(ret);
+
+    compat_policy.deprecated_input =3D COMPAT_POLICY_INPUT_REJECT;
+    do_qmp_dispatch_error(false, ERROR_CLASS_COMMAND_NOT_FOUND, cmd);
+}
+
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
@@ -375,6 +420,10 @@ int main(int argc, char **argv)
     g_test_add_func("/qmp/dispatch_cmd_io", test_dispatch_cmd_io);
     g_test_add_func("/qmp/dispatch_cmd_success_response",
                     test_dispatch_cmd_success_response);
+    g_test_add_func("/qmp/dispatch_cmd_deprecated",
+                    test_dispatch_cmd_deprecated);
+    g_test_add_func("/qmp/dispatch_cmd_arg_deprecated",
+                    test_dispatch_cmd_arg_deprecated);
     g_test_add_func("/qmp/dispatch_cmd_ret_deprecated",
                     test_dispatch_cmd_ret_deprecated);
     g_test_add_func("/qmp/dealloc_types", test_dealloc_types);
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 35b79c554d..3fb4ed42ed 100644
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
@@ -194,9 +194,13 @@ out:
     return ret
=20
=20
-def gen_register_command(name, success_response, allow_oob, allow_preconfi=
g):
+def gen_register_command(name, features,
+                         success_response, allow_oob, allow_preconfig):
     options =3D []
=20
+    if 'deprecated' in [f.name for f in features]:
+        options +=3D ['QCO_DEPRECATED']
+
     if not success_response:
         options +=3D ['QCO_NO_SUCCESS_RESP']
     if allow_oob:
@@ -302,8 +306,8 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds)=
;
             self._genh.add(gen_command_decl(name, arg_type, boxed, ret_typ=
e))
             self._genh.add(gen_marshal_decl(name))
             self._genc.add(gen_marshal(name, arg_type, boxed, ret_type))
-            self._regy.add(gen_register_command(name, success_response,
-                                                allow_oob, allow_preconfig=
))
+            self._regy.add(gen_register_command(
+                name, features, success_response, allow_oob, allow_preconf=
ig))
=20
=20
 def gen_commands(schema, output_dir, prefix):
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


