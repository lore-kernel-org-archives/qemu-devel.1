Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D2AC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:11:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C77B3215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZSQKsJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77B3215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT5uq-0004cy-WF
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iT5oY-00052s-7c
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:04:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iT5oU-00051n-0X
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:04:41 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50651
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iT5oS-00050w-MU
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:04:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573225476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MQo/RxsLCbRLIfn5dXPT7MLQoAPuvHzpSnZeI8LguL4=;
 b=RZSQKsJB3CivrQxO2pR3MLuf2X+FJlDoa15xazv4HQtpOwa5sIKYOjz+jH8UBRhHaWKUB4
 ZJYLOMPF2FUxyZL2P/pZGPkTfDAVVOLas4idkaIcbbCoY2Fuj1vA816gPzLxUqvW4bbvCQ
 I+jnjerxCy9L+qdTYSYvMKAdRyQQtrY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-rBaDBzpRMPS-4EJfV6kCIA-1; Fri, 08 Nov 2019 10:04:33 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 066A91005500
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 15:04:33 +0000 (UTC)
Received: from localhost (ovpn-112-25.ams2.redhat.com [10.36.112.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E58F60BE2;
 Fri,  8 Nov 2019 15:04:24 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 13/25] scripts: learn 'async' qapi commands
Date: Fri,  8 Nov 2019 19:01:11 +0400
Message-Id: <20191108150123.12213-14-marcandre.lureau@redhat.com>
In-Reply-To: <20191108150123.12213-1-marcandre.lureau@redhat.com>
References: <20191108150123.12213-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: rBaDBzpRMPS-4EJfV6kCIA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 armbru@redhat.com, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commands with the 'async' key will be registered as async type (see
related commit), and will allow a synchronous (in scope callback) or
asynchronous return (out-of-scope when ready, in idle etc) by keeping
the given QmpReturn and calling qmp_return function later.

Ex:
  { 'command': 'foo-async,
    'data': {'arg': 'str'},
    'returns': 'Foo',
    'async': true }

generates the following marshaller:

void qmp_marshal_foo_async(QDict *args, QmpReturn *qret)
{
    Error *err =3D NULL;
    Visitor *v;
    q_obj_foo_async_arg arg =3D {0};

    v =3D qmp_input_visitor_new(QOBJECT(args), true);
    visit_start_struct(v, NULL, NULL, 0, &err);
    if (err) {
        goto out;
    }
    visit_type_q_obj_foo_async_arg_members(v, &arg, &err);
    if (!err) {
        visit_check_struct(v, &err);
    }
    visit_end_struct(v, NULL);
    if (err) {
        goto out;
    }

    qmp_foo_async(arg.arg, qret);

out:
    if (err) {
        qmp_return_error(qret, err);
    }
    visit_free(v);
    v =3D qapi_dealloc_visitor_new();
    visit_start_struct(v, NULL, NULL, 0, NULL);
    visit_type_q_obj_foo_async_arg_members(v, &arg, NULL);
    visit_end_struct(v, NULL);
    visit_free(v);
}

and a return helper:

void qmp_foo_async_return(QmpReturn *qret, Foo *ret_in)
{
    Error *err =3D NULL;
    QObject *ret_out =3D NULL;

    qmp_marshal_output_Foo(ret_in, &ret_out, &err);

    if (err) {
        qmp_return_error(qret, err);
    } else {
        qmp_return(qret, ret_out);
    }
}

The dispatched function may call the return helper within the calling
scope or delay the return. To return an error, it can call
qmp_return_error() directly instead.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/commands.py                | 149 ++++++++++++++++++++----
 scripts/qapi/doc.py                     |   2 +-
 scripts/qapi/expr.py                    |   4 +-
 scripts/qapi/introspect.py              |   2 +-
 scripts/qapi/schema.py                  |  11 +-
 tests/qapi-schema/qapi-schema-test.json |   5 +
 tests/qapi-schema/qapi-schema-test.out  |   8 ++
 tests/qapi-schema/test-qapi.py          |   7 +-
 tests/test-qmp-cmds.c                   |  60 ++++++++++
 9 files changed, 212 insertions(+), 36 deletions(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index ab98e504f3..301b1a24d8 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -17,18 +17,35 @@ from qapi.common import *
 from qapi.gen import QAPIGenCCode, QAPISchemaModularCVisitor, ifcontext
=20
=20
-def gen_command_decl(name, arg_type, boxed, ret_type):
-    return mcgen('''
+def gen_command_decl(name, arg_type, boxed, ret_type, success_response, as=
yn):
+    if asyn:
+        extra =3D "QmpReturn *qret"
+    else:
+        extra =3D 'Error **errp'
+
+    if asyn:
+        ret =3D mcgen('''
+void qmp_%(name)s(%(params)s);
+ ''',
+                    name=3Dc_name(name),
+                    params=3Dbuild_params(arg_type, boxed, extra))
+        if success_response:
+            ret +=3D mcgen('''
+void qmp_%(name)s_return(QmpReturn *qret%(c_type)s);
+''',
+                         c_type=3D(", " + ret_type.c_type() if ret_type el=
se ""),
+                         name=3Dc_name(name))
+        return ret
+    else:
+        return mcgen('''
 %(c_type)s qmp_%(c_name)s(%(params)s);
 ''',
-                 c_type=3D(ret_type and ret_type.c_type()) or 'void',
-                 c_name=3Dc_name(name),
-                 params=3Dbuild_params(arg_type, boxed, 'Error **errp'))
+                     c_type=3D(ret_type and ret_type.c_type()) or 'void',
+                     c_name=3Dc_name(name),
+                     params=3Dbuild_params(arg_type, boxed, extra))
=20
=20
-def gen_call(name, arg_type, boxed, ret_type):
-    ret =3D ''
-
+def gen_argstr(arg_type, boxed):
     argstr =3D ''
     if boxed:
         assert arg_type
@@ -39,7 +56,13 @@ def gen_call(name, arg_type, boxed, ret_type):
             if memb.optional:
                 argstr +=3D 'arg.has_%s, ' % c_name(memb.name)
             argstr +=3D 'arg.%s, ' % c_name(memb.name)
+    return argstr
=20
+
+def gen_call(name, arg_type, boxed, ret_type):
+    ret =3D ''
+
+    argstr =3D gen_argstr(arg_type, boxed)
     lhs =3D ''
     if ret_type:
         lhs =3D 'retval =3D '
@@ -61,6 +84,51 @@ def gen_call(name, arg_type, boxed, ret_type):
     return ret
=20
=20
+def gen_async_call(name, arg_type, boxed):
+    argstr =3D gen_argstr(arg_type, boxed)
+
+    push_indent()
+    ret =3D mcgen('''
+
+qmp_%(c_name)s(%(args)sqret);
+''',
+                c_name=3Dc_name(name), args=3Dargstr)
+
+    pop_indent()
+    return ret
+
+
+def gen_async_return(name, ret_type):
+    if ret_type:
+        return mcgen('''
+
+void qmp_%(c_name)s_return(QmpReturn *qret, %(ret_type)s ret_in)
+{
+    Error *err =3D NULL;
+    QObject *ret_out =3D NULL;
+
+    qmp_marshal_output_%(ret_c_name)s(ret_in, &ret_out, &err);
+
+    if (err) {
+        qmp_return_error(qret, err);
+    } else {
+        qmp_return(qret, ret_out);
+    }
+}
+''',
+                     c_name=3Dc_name(name),
+                     ret_type=3Dret_type.c_type(), ret_c_name=3Dret_type.c=
_name())
+    else:
+        return mcgen('''
+
+void qmp_%(c_name)s_return(QmpReturn *qret)
+{
+    qmp_return(qret, QOBJECT(qdict_new()));
+}
+''',
+                     c_name=3Dc_name(name))
+
+
 def gen_marshal_output(ret_type):
     return mcgen('''
=20
@@ -84,19 +152,22 @@ static void qmp_marshal_output_%(c_name)s(%(c_type)s r=
et_in, QObject **ret_out,
                  c_type=3Dret_type.c_type(), c_name=3Dret_type.c_name())
=20
=20
-def build_marshal_proto(name):
-    return ('void qmp_marshal_%s(QDict *args, QObject **ret, Error **errp)=
'
-            % c_name(name))
+def build_marshal_proto(name, asyn):
+    if asyn:
+        tmpl =3D 'void qmp_marshal_%s(QDict *args, QmpReturn *qret)'
+    else:
+        tmpl =3D 'void qmp_marshal_%s(QDict *args, QObject **ret, Error **=
errp)'
+    return tmpl % c_name(name)
=20
=20
-def gen_marshal_decl(name):
+def gen_marshal_decl(name, asyn):
     return mcgen('''
 %(proto)s;
 ''',
-                 proto=3Dbuild_marshal_proto(name))
+                 proto=3Dbuild_marshal_proto(name, asyn))
=20
=20
-def gen_marshal(name, arg_type, boxed, ret_type):
+def gen_marshal(name, arg_type, boxed, ret_type, asyn):
     have_args =3D boxed or (arg_type and not arg_type.is_empty())
=20
     ret =3D mcgen('''
@@ -105,9 +176,9 @@ def gen_marshal(name, arg_type, boxed, ret_type):
 {
     Error *err =3D NULL;
 ''',
-                proto=3Dbuild_marshal_proto(name))
+                proto=3Dbuild_marshal_proto(name, asyn))
=20
-    if ret_type:
+    if ret_type and not asyn:
         ret +=3D mcgen('''
     %(c_type)s retval;
 ''',
@@ -154,12 +225,28 @@ def gen_marshal(name, arg_type, boxed, ret_type):
     }
 ''')
=20
-    ret +=3D gen_call(name, arg_type, boxed, ret_type)
+    if asyn:
+        ret +=3D gen_async_call(name, arg_type, boxed)
+    else:
+        ret +=3D gen_call(name, arg_type, boxed, ret_type)
=20
     ret +=3D mcgen('''
=20
 out:
+''')
+
+    if asyn:
+        ret +=3D mcgen('''
+    if (err) {
+        qmp_return_error(qret, err);
+    }
+''')
+    else:
+        ret +=3D mcgen('''
     error_propagate(errp, err);
+''')
+
+    ret +=3D mcgen('''
     visit_free(v);
 ''')
=20
@@ -194,7 +281,8 @@ out:
     return ret
=20
=20
-def gen_register_command(name, success_response, allow_oob, allow_preconfi=
g):
+def gen_register_command(name, success_response, allow_oob, allow_preconfi=
g,
+                         asyn):
     options =3D []
=20
     if not success_response:
@@ -203,17 +291,24 @@ def gen_register_command(name, success_response, allo=
w_oob, allow_preconfig):
         options +=3D ['QCO_ALLOW_OOB']
     if allow_preconfig:
         options +=3D ['QCO_ALLOW_PRECONFIG']
+    if asyn:
+        options +=3D ['QCO_ASYNC']
=20
     if not options:
         options =3D ['QCO_NO_OPTIONS']
=20
     options =3D " | ".join(options)
=20
+    if asyn:
+        regfn =3D 'qmp_register_async_command'
+    else:
+        regfn =3D 'qmp_register_command'
+
     ret =3D mcgen('''
-    qmp_register_command(cmds, "%(name)s",
+    %(regfn)s(cmds, "%(name)s",
                          qmp_marshal_%(c_name)s, %(opts)s);
 ''',
-                name=3Dname, c_name=3Dc_name(name),
+                regfn=3Dregfn, name=3Dname, c_name=3Dc_name(name),
                 opts=3Doptions)
     return ret
=20
@@ -278,7 +373,7 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds)=
;
=20
     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
                       success_response, boxed, allow_oob, allow_preconfig,
-                      features):
+                      features, asyn):
         if not gen:
             return
         # FIXME: If T is a user-defined type, the user is responsible
@@ -292,11 +387,15 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmd=
s);
                            self._genh, self._genc, self._regy):
                 self._genc.add(gen_marshal_output(ret_type))
         with ifcontext(ifcond, self._genh, self._genc, self._regy):
-            self._genh.add(gen_command_decl(name, arg_type, boxed, ret_typ=
e))
-            self._genh.add(gen_marshal_decl(name))
-            self._genc.add(gen_marshal(name, arg_type, boxed, ret_type))
+            self._genh.add(gen_command_decl(name, arg_type, boxed, ret_typ=
e,
+                                            success_response, asyn))
+            self._genh.add(gen_marshal_decl(name, asyn))
+            self._genc.add(gen_marshal(name, arg_type, boxed, ret_type, as=
yn))
+            if asyn and success_response:
+                self._genc.add(gen_async_return(name, ret_type))
             self._regy.add(gen_register_command(name, success_response,
-                                                allow_oob, allow_preconfig=
))
+                                                allow_oob, allow_preconfig=
,
+                                                asyn))
=20
=20
 def gen_commands(schema, output_dir, prefix):
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 6f1c17f71f..375978f04f 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -265,7 +265,7 @@ class QAPISchemaGenDocVisitor(QAPISchemaVisitor):
=20
     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
                       success_response, boxed, allow_oob, allow_preconfig,
-                      features):
+                      features, asyn):
         doc =3D self.cur_doc
         self._gen.add(texi_msg('Command', doc, ifcond,
                                texi_arguments(doc,
diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index d7a289eded..db4956133d 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -89,7 +89,7 @@ def check_flags(expr, info):
         if key in expr and expr[key] is not False:
             raise QAPISemError(
                 info, "flag '%s' may only use false value" % key)
-    for key in ['boxed', 'allow-oob', 'allow-preconfig']:
+    for key in ['boxed', 'allow-oob', 'allow-preconfig', 'async']:
         if key in expr and expr[key] is not True:
             raise QAPISemError(
                 info, "flag '%s' may only use true value" % key)
@@ -344,7 +344,7 @@ def check_exprs(exprs):
                        ['command'],
                        ['data', 'returns', 'boxed', 'if', 'features',
                         'gen', 'success-response', 'allow-oob',
-                        'allow-preconfig'])
+                        'allow-preconfig', 'async'])
             normalize_members(expr.get('data'))
             check_command(expr, info)
         elif meta =3D=3D 'event':
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index b3a463dd8b..f28c96afa3 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -212,7 +212,7 @@ const QLitObject %(c_name)s =3D %(c_string)s;
=20
     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
                       success_response, boxed, allow_oob, allow_preconfig,
-                      features):
+                      features, asyn):
         arg_type =3D arg_type or self._schema.the_empty_object_type
         ret_type =3D ret_type or self._schema.the_empty_object_type
         obj =3D {'arg-type': self._use_type(arg_type),
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index cf0045f34e..2e1d5278bf 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -128,7 +128,7 @@ class QAPISchemaVisitor(object):
=20
     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
                       success_response, boxed, allow_oob, allow_preconfig,
-                      features):
+                      features, asyn):
         pass
=20
     def visit_event(self, name, info, ifcond, arg_type, boxed):
@@ -678,7 +678,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
=20
     def __init__(self, name, info, doc, ifcond, arg_type, ret_type,
                  gen, success_response, boxed, allow_oob, allow_preconfig,
-                 features):
+                 features, asyn):
         QAPISchemaEntity.__init__(self, name, info, doc, ifcond, features)
         assert not arg_type or isinstance(arg_type, str)
         assert not ret_type or isinstance(ret_type, str)
@@ -691,6 +691,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
         self.boxed =3D boxed
         self.allow_oob =3D allow_oob
         self.allow_preconfig =3D allow_preconfig
+        self.asyn =3D asyn
=20
     def check(self, schema):
         QAPISchemaEntity.check(self, schema)
@@ -733,7 +734,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
                               self.gen, self.success_response,
                               self.boxed, self.allow_oob,
                               self.allow_preconfig,
-                              self.features)
+                              self.features, self.asyn)
=20
=20
 class QAPISchemaEvent(QAPISchemaEntity):
@@ -1016,6 +1017,7 @@ class QAPISchema(object):
         allow_preconfig =3D expr.get('allow-preconfig', False)
         ifcond =3D expr.get('if')
         features =3D expr.get('features', [])
+        asyn =3D expr.get('async', False)
         if isinstance(data, OrderedDict):
             data =3D self._make_implicit_object_type(
                 name, info, ifcond, 'arg', self._make_members(data, info))
@@ -1025,7 +1027,8 @@ class QAPISchema(object):
         self._def_entity(QAPISchemaCommand(name, info, doc, ifcond, data, =
rets,
                                            gen, success_response,
                                            boxed, allow_oob, allow_preconf=
ig,
-                                           self._make_features(features, i=
nfo)))
+                                           self._make_features(features, i=
nfo),
+                                           asyn))
=20
     def _def_event(self, expr, info, doc):
         name =3D expr['event']
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qa=
pi-schema-test.json
index 9abf175fe0..58d2164c7e 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -148,6 +148,11 @@
=20
 { 'command': 'cmd-success-response', 'data': {}, 'success-response': false=
 }
=20
+{ 'command': 'cmd-async', 'data': {'filename': 'str'},
+  'returns': 'Empty2', 'async': true }
+{ 'command': 'cmd-success-response-async', 'data': {'filename': 'str'},
+  'async': true, 'success-response': false}
+
 # Returning a non-dictionary requires a name from the whitelist
 { 'command': 'guest-get-time', 'data': {'a': 'int', '*b': 'int' },
   'returns': 'int' }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qap=
i-schema-test.out
index 3660e75a48..19d2d202b9 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -217,6 +217,14 @@ command user_def_cmd2 q_obj_user_def_cmd2-arg -> UserD=
efTwo
     gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
 command cmd-success-response None -> None
     gen=3DTrue success_response=3DFalse boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+object q_obj_cmd-async-arg
+    member filename: str optional=3DFalse
+command cmd-async q_obj_cmd-async-arg -> Empty2
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse async=3DTrue
+object q_obj_cmd-success-response-async-arg
+    member filename: str optional=3DFalse
+command cmd-success-response-async q_obj_cmd-success-response-async-arg ->=
 None
+    gen=3DTrue success_response=3DFalse boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse async=3DTrue
 object q_obj_guest-get-time-arg
     member a: int optional=3DFalse
     member b: int optional=3DTrue
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.p=
y
index bad14edb47..1914b7d5ff 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -70,12 +70,13 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
=20
     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
                       success_response, boxed, allow_oob, allow_preconfig,
-                      features):
+                      features, asyn):
         print('command %s %s -> %s'
               % (name, arg_type and arg_type.name,
                  ret_type and ret_type.name))
-        print('    gen=3D%s success_response=3D%s boxed=3D%s oob=3D%s prec=
onfig=3D%s'
-              % (gen, success_response, boxed, allow_oob, allow_preconfig)=
)
+        print('    gen=3D%s success_response=3D%s boxed=3D%s oob=3D%s prec=
onfig=3D%s%s'
+              % (gen, success_response, boxed, allow_oob, allow_preconfig,
+                 ' async=3DTrue' if asyn else ''))
         self._print_if(ifcond)
         self._print_features(features)
=20
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 213df7e53a..75ef30f6ea 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -34,6 +34,28 @@ void qmp_cmd_success_response(Error **errp)
 {
 }
=20
+static gboolean cmd_async_idle(gpointer user_data)
+{
+    QmpReturn *qret =3D user_data;
+
+    qmp_cmd_async_return(qret, g_new0(Empty2, 1));
+
+    return G_SOURCE_REMOVE;
+}
+
+void qmp_cmd_async(const char *filename, QmpReturn *qret)
+{
+    g_idle_add(cmd_async_idle, qret);
+}
+
+void qmp_cmd_success_response_async(const char *filename, QmpReturn *qret)
+{
+    Error *err =3D NULL;
+
+    error_setg(&err, "no response, but error ok");
+    qmp_return_error(qret, err);
+}
+
 Empty2 *qmp_user_def_cmd0(Error **errp)
 {
     return g_new0(Empty2, 1);
@@ -394,6 +416,43 @@ static void test_qmp_return_orderly(void)
     qobject_unref(dict);
 }
=20
+typedef struct QmpReturnAsync {
+    QmpSession session;
+    GMainLoop *loop;
+} QmpReturnAsync;
+
+static void dispatch_return_async(QmpSession *session, QDict *resp)
+{
+    QmpReturnAsync *a =3D container_of(session, QmpReturnAsync, session);
+
+    g_main_loop_quit(a->loop);
+    g_main_loop_unref(a->loop);
+    a->loop =3D NULL;
+}
+
+static void test_qmp_return_async(void)
+{
+    QmpReturnAsync a =3D { { 0, } , };
+    QDict *args =3D qdict_new();
+    QDict *req =3D qdict_new();
+
+    a.loop =3D g_main_loop_new(NULL, TRUE);
+    qmp_session_init(&a.session, &qmp_commands,
+                    NULL, dispatch_return_async);
+
+    qdict_put_str(args, "filename", "test-filename");
+    qdict_put_str(req, "execute", "cmd-async");
+    qdict_put(req, "arguments", args);
+    qmp_dispatch(&a.session, QOBJECT(req), false);
+    g_assert(a.loop);
+
+    g_main_loop_run(a.loop);
+    g_assert(!a.loop);
+
+    qmp_session_destroy(&a.session);
+    qobject_unref(req);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -407,6 +466,7 @@ int main(int argc, char **argv)
     g_test_add_func("/qmp/dealloc_types", test_dealloc_types);
     g_test_add_func("/qmp/dealloc_partial", test_dealloc_partial);
     g_test_add_func("/qmp/return_orderly", test_qmp_return_orderly);
+    g_test_add_func("/qmp/return_async", test_qmp_return_async);
=20
     test_qmp_init_marshal(&qmp_commands);
     g_test_run();
--=20
2.24.0


