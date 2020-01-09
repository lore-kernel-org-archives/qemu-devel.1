Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA697C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 18:40:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 844B420678
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 18:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fw7d0/ER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844B420678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipcjY-0003NQ-Jm
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 13:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ipcf9-0006BI-5l
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 13:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ipcf7-0003kI-0o
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 13:36:07 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34117
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ipcf6-0003h9-Rl
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 13:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578594964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0aNj6zyFt652klXOAISYwNHBy4ZUeVSHRcou5N9NHs4=;
 b=Fw7d0/ERapT0jM7W2Xa6gVA+aektyQsk4EUSabco+EObZ6WSFhmLWOm1jvOh8cwGN32v3R
 1T0GunaqpuC0PxAesCM6IysMmY6nXGtA/QbPZQAXuK53wg1qKbxDkMLBdTm8lGZ4Ps70u4
 B90LBgDaBDeKsXj1pXnfXEBF6bvwib8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-uheNV9GcPy28fX5k2FDx1g-1; Thu, 09 Jan 2020 13:36:00 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC5E6593A2;
 Thu,  9 Jan 2020 18:35:59 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-193.ams2.redhat.com
 [10.36.117.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 78753691AD;
 Thu,  9 Jan 2020 18:35:58 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] qapi: Add a 'coroutine' flag for commands
Date: Thu,  9 Jan 2020 19:35:42 +0100
Message-Id: <20200109183545.27452-2-kwolf@redhat.com>
In-Reply-To: <20200109183545.27452-1-kwolf@redhat.com>
References: <20200109183545.27452-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: uheNV9GcPy28fX5k2FDx1g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, marcandre.lureau@gmail.com, armbru@redhat.com,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds a new 'coroutine' flag to QMP command definitions that
tells the QMP dispatcher than the command handler is safe to be run in a
coroutine.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qapi-schema/qapi-schema-test.json |  1 +
 docs/devel/qapi-code-gen.txt            |  4 ++++
 include/qapi/qmp/dispatch.h             |  1 +
 tests/test-qmp-cmds.c                   |  4 ++++
 scripts/qapi/commands.py                | 17 +++++++++++------
 scripts/qapi/doc.py                     |  2 +-
 scripts/qapi/expr.py                    |  4 ++--
 scripts/qapi/introspect.py              |  2 +-
 scripts/qapi/schema.py                  |  9 ++++++---
 tests/qapi-schema/qapi-schema-test.out  |  2 ++
 tests/qapi-schema/test-qapi.py          |  7 ++++---
 11 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qa=
pi-schema-test.json
index 9abf175fe0..55f596dbaa 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -147,6 +147,7 @@
   'returns': 'UserDefTwo' }
=20
 { 'command': 'cmd-success-response', 'data': {}, 'success-response': false=
 }
+{ 'command': 'coroutine_cmd', 'data': {}, 'coroutine': true }
=20
 # Returning a non-dictionary requires a name from the whitelist
 { 'command': 'guest-get-time', 'data': {'a': 'int', '*b': 'int' },
diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 45c93a43cc..753f6711d3 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -457,6 +457,7 @@ Syntax:
                 '*gen': false,
                 '*allow-oob': true,
                 '*allow-preconfig': true,
+                '*coroutine': true,
                 '*if': COND,
                 '*features': FEATURES }
=20
@@ -581,6 +582,9 @@ before the machine is built.  It defaults to false.  Fo=
r example:
 QMP is available before the machine is built only when QEMU was
 started with --preconfig.
=20
+Member 'coroutine' tells the QMP dispatcher whether the command handler
+is safe to be run in a coroutine. It defaults to false.
+
 The optional 'if' member specifies a conditional.  See "Configuring
 the schema" below for more on this.
=20
diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 9aa426a398..d6ce9efc8e 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -24,6 +24,7 @@ typedef enum QmpCommandOptions
     QCO_NO_SUCCESS_RESP       =3D  (1U << 0),
     QCO_ALLOW_OOB             =3D  (1U << 1),
     QCO_ALLOW_PRECONFIG       =3D  (1U << 2),
+    QCO_COROUTINE             =3D  (1U << 3),
 } QmpCommandOptions;
=20
 typedef struct QmpCommand
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 27b0afe55a..e2f71e42a1 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -34,6 +34,10 @@ void qmp_cmd_success_response(Error **errp)
 {
 }
=20
+void qmp_coroutine_cmd(Error **errp)
+{
+}
+
 Empty2 *qmp_user_def_cmd0(Error **errp)
 {
     return g_new0(Empty2, 1);
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index ab98e504f3..97e51401f1 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -15,6 +15,7 @@ See the COPYING file in the top-level directory.
=20
 from qapi.common import *
 from qapi.gen import QAPIGenCCode, QAPISchemaModularCVisitor, ifcontext
+from typing import List
=20
=20
 def gen_command_decl(name, arg_type, boxed, ret_type):
@@ -194,8 +195,9 @@ out:
     return ret
=20
=20
-def gen_register_command(name, success_response, allow_oob, allow_preconfi=
g):
-    options =3D []
+def gen_register_command(name: str, success_response: bool, allow_oob: boo=
l,
+                         allow_preconfig: bool, coroutine: bool) -> str:
+    options =3D [] # type: List[str]
=20
     if not success_response:
         options +=3D ['QCO_NO_SUCCESS_RESP']
@@ -203,18 +205,20 @@ def gen_register_command(name, success_response, allo=
w_oob, allow_preconfig):
         options +=3D ['QCO_ALLOW_OOB']
     if allow_preconfig:
         options +=3D ['QCO_ALLOW_PRECONFIG']
+    if coroutine:
+        options +=3D ['QCO_COROUTINE']
=20
     if not options:
         options =3D ['QCO_NO_OPTIONS']
=20
-    options =3D " | ".join(options)
+    options_str =3D " | ".join(options)
=20
     ret =3D mcgen('''
     qmp_register_command(cmds, "%(name)s",
                          qmp_marshal_%(c_name)s, %(opts)s);
 ''',
                 name=3Dname, c_name=3Dc_name(name),
-                opts=3Doptions)
+                opts=3Doptions_str)
     return ret
=20
=20
@@ -278,7 +282,7 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds)=
;
=20
     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
                       success_response, boxed, allow_oob, allow_preconfig,
-                      features):
+                      coroutine, features):
         if not gen:
             return
         # FIXME: If T is a user-defined type, the user is responsible
@@ -296,7 +300,8 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds)=
;
             self._genh.add(gen_marshal_decl(name))
             self._genc.add(gen_marshal(name, arg_type, boxed, ret_type))
             self._regy.add(gen_register_command(name, success_response,
-                                                allow_oob, allow_preconfig=
))
+                                                allow_oob, allow_preconfig=
,
+                                                coroutine))
=20
=20
 def gen_commands(schema, output_dir, prefix):
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 6f1c17f71f..8b6978c81e 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -265,7 +265,7 @@ class QAPISchemaGenDocVisitor(QAPISchemaVisitor):
=20
     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
                       success_response, boxed, allow_oob, allow_preconfig,
-                      features):
+                      coroutine, features):
         doc =3D self.cur_doc
         self._gen.add(texi_msg('Command', doc, ifcond,
                                texi_arguments(doc,
diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index d7a289eded..9dbfa3edf0 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -89,7 +89,7 @@ def check_flags(expr, info):
         if key in expr and expr[key] is not False:
             raise QAPISemError(
                 info, "flag '%s' may only use false value" % key)
-    for key in ['boxed', 'allow-oob', 'allow-preconfig']:
+    for key in ['boxed', 'allow-oob', 'allow-preconfig', 'coroutine']:
         if key in expr and expr[key] is not True:
             raise QAPISemError(
                 info, "flag '%s' may only use true value" % key)
@@ -344,7 +344,7 @@ def check_exprs(exprs):
                        ['command'],
                        ['data', 'returns', 'boxed', 'if', 'features',
                         'gen', 'success-response', 'allow-oob',
-                        'allow-preconfig'])
+                        'allow-preconfig', 'coroutine'])
             normalize_members(expr.get('data'))
             check_command(expr, info)
         elif meta =3D=3D 'event':
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index b3a463dd8b..8a296a69d6 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -212,7 +212,7 @@ const QLitObject %(c_name)s =3D %(c_string)s;
=20
     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
                       success_response, boxed, allow_oob, allow_preconfig,
-                      features):
+                      coroutine, features):
         arg_type =3D arg_type or self._schema.the_empty_object_type
         ret_type =3D ret_type or self._schema.the_empty_object_type
         obj =3D {'arg-type': self._use_type(arg_type),
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index cf0045f34e..753bf233a6 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -128,7 +128,7 @@ class QAPISchemaVisitor(object):
=20
     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
                       success_response, boxed, allow_oob, allow_preconfig,
-                      features):
+                      coroutine, features):
         pass
=20
     def visit_event(self, name, info, ifcond, arg_type, boxed):
@@ -678,7 +678,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
=20
     def __init__(self, name, info, doc, ifcond, arg_type, ret_type,
                  gen, success_response, boxed, allow_oob, allow_preconfig,
-                 features):
+                 coroutine, features):
         QAPISchemaEntity.__init__(self, name, info, doc, ifcond, features)
         assert not arg_type or isinstance(arg_type, str)
         assert not ret_type or isinstance(ret_type, str)
@@ -691,6 +691,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
         self.boxed =3D boxed
         self.allow_oob =3D allow_oob
         self.allow_preconfig =3D allow_preconfig
+        self.coroutine =3D coroutine
=20
     def check(self, schema):
         QAPISchemaEntity.check(self, schema)
@@ -732,7 +733,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
                               self.arg_type, self.ret_type,
                               self.gen, self.success_response,
                               self.boxed, self.allow_oob,
-                              self.allow_preconfig,
+                              self.allow_preconfig, self.coroutine,
                               self.features)
=20
=20
@@ -1014,6 +1015,7 @@ class QAPISchema(object):
         boxed =3D expr.get('boxed', False)
         allow_oob =3D expr.get('allow-oob', False)
         allow_preconfig =3D expr.get('allow-preconfig', False)
+        coroutine =3D expr.get('coroutine', False)
         ifcond =3D expr.get('if')
         features =3D expr.get('features', [])
         if isinstance(data, OrderedDict):
@@ -1025,6 +1027,7 @@ class QAPISchema(object):
         self._def_entity(QAPISchemaCommand(name, info, doc, ifcond, data, =
rets,
                                            gen, success_response,
                                            boxed, allow_oob, allow_preconf=
ig,
+                                           coroutine,
                                            self._make_features(features, i=
nfo)))
=20
     def _def_event(self, expr, info, doc):
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qap=
i-schema-test.out
index 3660e75a48..771e736675 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -217,6 +217,8 @@ command user_def_cmd2 q_obj_user_def_cmd2-arg -> UserDe=
fTwo
     gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
 command cmd-success-response None -> None
     gen=3DTrue success_response=3DFalse boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+command coroutine_cmd None -> None
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse coroutine=3DTrue
 object q_obj_guest-get-time-arg
     member a: int optional=3DFalse
     member b: int optional=3DTrue
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.p=
y
index bad14edb47..7a8e65188d 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -70,12 +70,13 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
=20
     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
                       success_response, boxed, allow_oob, allow_preconfig,
-                      features):
+                      coroutine, features):
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
+                 " coroutine=3DTrue" if coroutine else ""))
         self._print_if(ifcond)
         self._print_features(features)
=20
--=20
2.20.1


