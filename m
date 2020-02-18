Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAC5C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 15:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D9482176D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 15:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azjxofrt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9482176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j450L-0008RB-JP
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 10:41:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j44zT-0006bF-De
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:40:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j44zR-0001dG-DX
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:40:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21601
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j44zR-0001cm-8X
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:40:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582040448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0fofnXmzWwoAoZLNHsCrqCblbFUzE3zF3J43i4iej00=;
 b=azjxofrtvG9ZwuD20bdymBetUsHN3tbBlda+711R6aD7nwodr+m3hgJzaTADhgHuGl76J9
 UHIGELkZg+C8HQrJSmtpTXGJc/u6W/pbyysFy2YftpYLTYxrHGXcXhblft4wPzcYFQLdcG
 TIoSXJsboVrT444QE4UhzHZxa+ROvwc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-VN7cczDzN_aCgKUP6-hJ0Q-1; Tue, 18 Feb 2020 10:40:46 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64C7E800D48;
 Tue, 18 Feb 2020 15:40:45 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 108F71BC6D;
 Tue, 18 Feb 2020 15:40:43 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 1/4] qapi: Add a 'coroutine' flag for commands
Date: Tue, 18 Feb 2020 16:40:33 +0100
Message-Id: <20200218154036.28562-2-kwolf@redhat.com>
In-Reply-To: <20200218154036.28562-1-kwolf@redhat.com>
References: <20200218154036.28562-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: VN7cczDzN_aCgKUP6-hJ0Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, marcandre.lureau@gmail.com, armbru@redhat.com,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds a new 'coroutine' flag to QMP command definitions that
tells the QMP dispatcher that the command handler is safe to be run in a
coroutine.

The documentation of the new flag pretends that this flag is already
used as intended, which it isn't yet after this patch. We'll implement
this in another patch in this series.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt            | 11 +++++++++++
 include/qapi/qmp/dispatch.h             |  1 +
 tests/test-qmp-cmds.c                   |  4 ++++
 scripts/qapi/commands.py                | 10 +++++++---
 scripts/qapi/doc.py                     |  2 +-
 scripts/qapi/expr.py                    | 10 ++++++++--
 scripts/qapi/introspect.py              |  2 +-
 scripts/qapi/schema.py                  |  9 ++++++---
 tests/qapi-schema/test-qapi.py          |  7 ++++---
 tests/Makefile.include                  |  1 +
 tests/qapi-schema/oob-coroutine.err     |  2 ++
 tests/qapi-schema/oob-coroutine.json    |  2 ++
 tests/qapi-schema/oob-coroutine.out     |  0
 tests/qapi-schema/qapi-schema-test.json |  1 +
 tests/qapi-schema/qapi-schema-test.out  |  2 ++
 15 files changed, 51 insertions(+), 13 deletions(-)
 create mode 100644 tests/qapi-schema/oob-coroutine.err
 create mode 100644 tests/qapi-schema/oob-coroutine.json
 create mode 100644 tests/qapi-schema/oob-coroutine.out

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 59d6973e1e..df01bd852b 100644
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
@@ -581,6 +582,16 @@ before the machine is built.  It defaults to false.  F=
or example:
 QMP is available before the machine is built only when QEMU was
 started with --preconfig.
=20
+Member 'coroutine' tells the QMP dispatcher whether the command handler
+is safe to be run in a coroutine.  It defaults to false.  If it is true,
+the command handler is called from coroutine context and may yield while
+waiting for an external event (such as I/O completion) in order to avoid
+blocking the guest and other background operations.
+
+It is an error to specify both 'coroutine': true and 'allow-oob': true
+for a command.  (We don't currently have a use case for both together and
+without a use case, it's not entirely clear what the semantics should be.)
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
index 79507d9e54..6359cc28c7 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -35,6 +35,10 @@ void qmp_cmd_success_response(Error **errp)
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
index afa55b055c..f2f2f8948d 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -194,7 +194,8 @@ out:
     return ret
=20
=20
-def gen_register_command(name, success_response, allow_oob, allow_preconfi=
g):
+def gen_register_command(name, success_response, allow_oob, allow_preconfi=
g,
+                         coroutine):
     options =3D []
=20
     if not success_response:
@@ -203,6 +204,8 @@ def gen_register_command(name, success_response, allow_=
oob, allow_preconfig):
         options +=3D ['QCO_ALLOW_OOB']
     if allow_preconfig:
         options +=3D ['QCO_ALLOW_PRECONFIG']
+    if coroutine:
+        options +=3D ['QCO_COROUTINE']
=20
     if not options:
         options =3D ['QCO_NO_OPTIONS']
@@ -285,7 +288,7 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds)=
;
=20
     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
                       success_response, boxed, allow_oob, allow_preconfig,
-                      features):
+                      coroutine, features):
         if not gen:
             return
         # FIXME: If T is a user-defined type, the user is responsible
@@ -303,7 +306,8 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds)=
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
index 1787a53d91..69f971e427 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -264,7 +264,7 @@ class QAPISchemaGenDocVisitor(QAPISchemaVisitor):
=20
     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
                       success_response, boxed, allow_oob, allow_preconfig,
-                      features):
+                      coroutine, features):
         doc =3D self.cur_doc
         self._gen.add(texi_msg('Command', doc, ifcond,
                                texi_arguments(doc,
diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index d7a289eded..95cc006cae 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -89,10 +89,16 @@ def check_flags(expr, info):
         if key in expr and expr[key] is not False:
             raise QAPISemError(
                 info, "flag '%s' may only use false value" % key)
-    for key in ['boxed', 'allow-oob', 'allow-preconfig']:
+    for key in ['boxed', 'allow-oob', 'allow-preconfig', 'coroutine']:
         if key in expr and expr[key] is not True:
             raise QAPISemError(
                 info, "flag '%s' may only use true value" % key)
+    if 'allow-oob' in expr and 'coroutine' in expr:
+        # This is not necessarily a fundamental incompatibility, but we do=
n't
+        # have a use case and the desired semantics isn't obvious. The sim=
plest
+        # solution is to forbid it until we get a use case for it.
+        raise QAPISemError(info, "flags 'allow-oob' and 'coroutine' "
+                                 "are incompatible")
=20
=20
 def check_if(expr, info, source):
@@ -344,7 +350,7 @@ def check_exprs(exprs):
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
index 5100110fa2..8fbfa42e8e 100644
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
@@ -690,7 +690,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
=20
     def __init__(self, name, info, doc, ifcond, arg_type, ret_type,
                  gen, success_response, boxed, allow_oob, allow_preconfig,
-                 features):
+                 coroutine, features):
         QAPISchemaEntity.__init__(self, name, info, doc, ifcond, features)
         assert not arg_type or isinstance(arg_type, str)
         assert not ret_type or isinstance(ret_type, str)
@@ -703,6 +703,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
         self.boxed =3D boxed
         self.allow_oob =3D allow_oob
         self.allow_preconfig =3D allow_preconfig
+        self.coroutine =3D coroutine
=20
     def check(self, schema):
         QAPISchemaEntity.check(self, schema)
@@ -745,7 +746,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
                               self.arg_type, self.ret_type,
                               self.gen, self.success_response,
                               self.boxed, self.allow_oob,
-                              self.allow_preconfig,
+                              self.allow_preconfig, self.coroutine,
                               self.features)
=20
=20
@@ -1043,6 +1044,7 @@ class QAPISchema(object):
         boxed =3D expr.get('boxed', False)
         allow_oob =3D expr.get('allow-oob', False)
         allow_preconfig =3D expr.get('allow-preconfig', False)
+        coroutine =3D expr.get('coroutine', False)
         ifcond =3D expr.get('if')
         features =3D expr.get('features', [])
         if isinstance(data, OrderedDict):
@@ -1054,6 +1056,7 @@ class QAPISchema(object):
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
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.p=
y
index 41232c11a3..dcb922755d 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -69,12 +69,13 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
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
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 2f1cafed72..893540f5a3 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -286,6 +286,7 @@ qapi-schema +=3D missing-type.json
 qapi-schema +=3D nested-struct-data.json
 qapi-schema +=3D nested-struct-data-invalid-dict.json
 qapi-schema +=3D non-objects.json
+qapi-schema +=3D oob-coroutine.json
 qapi-schema +=3D oob-test.json
 qapi-schema +=3D allow-preconfig-test.json
 qapi-schema +=3D pragma-doc-required-crap.json
diff --git a/tests/qapi-schema/oob-coroutine.err b/tests/qapi-schema/oob-co=
routine.err
new file mode 100644
index 0000000000..c01a4992bd
--- /dev/null
+++ b/tests/qapi-schema/oob-coroutine.err
@@ -0,0 +1,2 @@
+oob-coroutine.json: In command 'oob-command-1':
+oob-coroutine.json:2: flags 'allow-oob' and 'coroutine' are incompatible
diff --git a/tests/qapi-schema/oob-coroutine.json b/tests/qapi-schema/oob-c=
oroutine.json
new file mode 100644
index 0000000000..0f67663bcd
--- /dev/null
+++ b/tests/qapi-schema/oob-coroutine.json
@@ -0,0 +1,2 @@
+# Check that incompatible flags allow-oob and coroutine are rejected
+{ 'command': 'oob-command-1', 'allow-oob': true, 'coroutine': true }
diff --git a/tests/qapi-schema/oob-coroutine.out b/tests/qapi-schema/oob-co=
routine.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qa=
pi-schema-test.json
index 9abf175fe0..1a850fe171 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -147,6 +147,7 @@
   'returns': 'UserDefTwo' }
=20
 { 'command': 'cmd-success-response', 'data': {}, 'success-response': false=
 }
+{ 'command': 'coroutine-cmd', 'data': {}, 'coroutine': true }
=20
 # Returning a non-dictionary requires a name from the whitelist
 { 'command': 'guest-get-time', 'data': {'a': 'int', '*b': 'int' },
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qap=
i-schema-test.out
index 9bd3c4a490..fdc349991a 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -203,6 +203,8 @@ command user_def_cmd2 q_obj_user_def_cmd2-arg -> UserDe=
fTwo
     gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
 command cmd-success-response None -> None
     gen=3DTrue success_response=3DFalse boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+command coroutine-cmd None -> None
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse coroutine=3DTrue
 object q_obj_guest-get-time-arg
     member a: int optional=3DFalse
     member b: int optional=3DTrue
--=20
2.20.1


