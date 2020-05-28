Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2533AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:43:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D01292073B
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e52mzOih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01292073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeKgg-0007nl-Vn
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 11:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jeKbf-0003lb-Qk
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:38:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39978
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jeKbe-0003vf-0L
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590680285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+RZrr6ic9RBOFFKgER+QKdZ9x8KUuan9eOf+y/q7WVY=;
 b=e52mzOih8fPL1HIzIh1ZifgYs0eTrSBKJm1Zc2UQPfORmAONRy0/q/88VkTvuXPrHzHPi+
 zJm9ff58iH/ILJPhJvshzmQTmq8alBQlV8Bnyw6xvAi4qA75XKspOkfmlXVvyj75VitiIp
 Cg8WvJ7uIMeFIvkxKGbZoEn+T4/LzCw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-kpVqrWN9Mz-MuPEEa--s9A-1; Thu, 28 May 2020 11:38:01 -0400
X-MC-Unique: kpVqrWN9Mz-MuPEEa--s9A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A1F81855A16;
 Thu, 28 May 2020 15:38:00 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-117.ams2.redhat.com
 [10.36.114.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7305C1002382;
 Thu, 28 May 2020 15:37:57 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v6 07/12] qapi: Add a 'coroutine' flag for commands
Date: Thu, 28 May 2020 17:37:37 +0200
Message-Id: <20200528153742.274164-8-kwolf@redhat.com>
In-Reply-To: <20200528153742.274164-1-kwolf@redhat.com>
References: <20200528153742.274164-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 01:51:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 qemu-devel@nongnu.org
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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt            | 12 ++++++++++++
 include/qapi/qmp/dispatch.h             |  1 +
 tests/test-qmp-cmds.c                   |  4 ++++
 scripts/qapi/commands.py                | 10 +++++++---
 scripts/qapi/doc.py                     |  2 +-
 scripts/qapi/expr.py                    | 10 ++++++++--
 scripts/qapi/introspect.py              |  2 +-
 scripts/qapi/schema.py                  | 12 ++++++++----
 tests/qapi-schema/test-qapi.py          |  7 ++++---
 tests/Makefile.include                  |  1 +
 tests/qapi-schema/oob-coroutine.err     |  2 ++
 tests/qapi-schema/oob-coroutine.json    |  2 ++
 tests/qapi-schema/oob-coroutine.out     |  0
 tests/qapi-schema/qapi-schema-test.json |  1 +
 tests/qapi-schema/qapi-schema-test.out  |  2 ++
 15 files changed, 54 insertions(+), 14 deletions(-)
 create mode 100644 tests/qapi-schema/oob-coroutine.err
 create mode 100644 tests/qapi-schema/oob-coroutine.json
 create mode 100644 tests/qapi-schema/oob-coroutine.out

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index a7794ef658..b8eb370a13 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -472,6 +472,7 @@ Syntax:
                 '*gen': false,
                 '*allow-oob': true,
                 '*allow-preconfig': true,
+                '*coroutine': true,
                 '*if': COND,
                 '*features': FEATURES }
 
@@ -596,6 +597,17 @@ before the machine is built.  It defaults to false.  For example:
 QMP is available before the machine is built only when QEMU was
 started with --preconfig.
 
+Member 'coroutine' tells the QMP dispatcher whether the command handler
+is safe to be run in a coroutine.  It defaults to false.  If it is true,
+the command handler is called from coroutine context and may yield while
+waiting for an external event (such as I/O completion) in order to avoid
+blocking the guest and other background operations.
+
+It is an error to specify both 'coroutine': true and 'allow-oob': true
+for a command.  We don't currently have a use case for both together and
+without a use case, it's not entirely clear what the semantics should
+be.
+
 The optional 'if' member specifies a conditional.  See "Configuring
 the schema" below for more on this.
 
diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 0c2f467028..9fd2b720a7 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -25,6 +25,7 @@ typedef enum QmpCommandOptions
     QCO_NO_SUCCESS_RESP       =  (1U << 0),
     QCO_ALLOW_OOB             =  (1U << 1),
     QCO_ALLOW_PRECONFIG       =  (1U << 2),
+    QCO_COROUTINE             =  (1U << 3),
 } QmpCommandOptions;
 
 typedef struct QmpCommand
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 5f1b245e19..d3413bfef0 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -36,6 +36,10 @@ void qmp_cmd_success_response(Error **errp)
 {
 }
 
+void qmp_coroutine_cmd(Error **errp)
+{
+}
+
 Empty2 *qmp_user_def_cmd0(Error **errp)
 {
     return g_new0(Empty2, 1);
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 6809b0fb6e..f50710306d 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -180,7 +180,8 @@ out:
     return ret
 
 
-def gen_register_command(name, success_response, allow_oob, allow_preconfig):
+def gen_register_command(name, success_response, allow_oob, allow_preconfig,
+                         coroutine):
     options = []
 
     if not success_response:
@@ -189,6 +190,8 @@ def gen_register_command(name, success_response, allow_oob, allow_preconfig):
         options += ['QCO_ALLOW_OOB']
     if allow_preconfig:
         options += ['QCO_ALLOW_PRECONFIG']
+    if coroutine:
+        options += ['QCO_COROUTINE']
 
     if not options:
         options = ['QCO_NO_OPTIONS']
@@ -271,7 +274,7 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
 
     def visit_command(self, name, info, ifcond, features,
                       arg_type, ret_type, gen, success_response, boxed,
-                      allow_oob, allow_preconfig):
+                      allow_oob, allow_preconfig, coroutine):
         if not gen:
             return
         # FIXME: If T is a user-defined type, the user is responsible
@@ -289,7 +292,8 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
             self._genh.add(gen_marshal_decl(name))
             self._genc.add(gen_marshal(name, arg_type, boxed, ret_type))
             self._regy.add(gen_register_command(name, success_response,
-                                                allow_oob, allow_preconfig))
+                                                allow_oob, allow_preconfig,
+                                                coroutine))
 
 
 def gen_commands(schema, output_dir, prefix):
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 92f584edcf..11771de923 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -264,7 +264,7 @@ class QAPISchemaGenDocVisitor(QAPISchemaVisitor):
 
     def visit_command(self, name, info, ifcond, features,
                       arg_type, ret_type, gen, success_response, boxed,
-                      allow_oob, allow_preconfig):
+                      allow_oob, allow_preconfig, coroutine):
         doc = self.cur_doc
         self._gen.add(texi_msg('Command', doc, ifcond,
                                texi_arguments(doc,
diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index 2942520399..928cd1eb5c 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -88,10 +88,16 @@ def check_flags(expr, info):
         if key in expr and expr[key] is not False:
             raise QAPISemError(
                 info, "flag '%s' may only use false value" % key)
-    for key in ['boxed', 'allow-oob', 'allow-preconfig']:
+    for key in ['boxed', 'allow-oob', 'allow-preconfig', 'coroutine']:
         if key in expr and expr[key] is not True:
             raise QAPISemError(
                 info, "flag '%s' may only use true value" % key)
+    if 'allow-oob' in expr and 'coroutine' in expr:
+        # This is not necessarily a fundamental incompatibility, but we don't
+        # have a use case and the desired semantics isn't obvious. The simplest
+        # solution is to forbid it until we get a use case for it.
+        raise QAPISemError(info, "flags 'allow-oob' and 'coroutine' "
+                                 "are incompatible")
 
 
 def check_if(expr, info, source):
@@ -342,7 +348,7 @@ def check_exprs(exprs):
                        ['command'],
                        ['data', 'returns', 'boxed', 'if', 'features',
                         'gen', 'success-response', 'allow-oob',
-                        'allow-preconfig'])
+                        'allow-preconfig', 'coroutine'])
             normalize_members(expr.get('data'))
             check_command(expr, info)
         elif meta == 'event':
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 23652be810..5907b09cd5 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -216,7 +216,7 @@ const QLitObject %(c_name)s = %(c_string)s;
 
     def visit_command(self, name, info, ifcond, features,
                       arg_type, ret_type, gen, success_response, boxed,
-                      allow_oob, allow_preconfig):
+                      allow_oob, allow_preconfig, coroutine):
         arg_type = arg_type or self._schema.the_empty_object_type
         ret_type = ret_type or self._schema.the_empty_object_type
         obj = {'arg-type': self._use_type(arg_type),
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 78309a00f0..c44d391c3f 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -128,7 +128,7 @@ class QAPISchemaVisitor:
 
     def visit_command(self, name, info, ifcond, features,
                       arg_type, ret_type, gen, success_response, boxed,
-                      allow_oob, allow_preconfig):
+                      allow_oob, allow_preconfig, coroutine):
         pass
 
     def visit_event(self, name, info, ifcond, features, arg_type, boxed):
@@ -713,7 +713,8 @@ class QAPISchemaCommand(QAPISchemaEntity):
 
     def __init__(self, name, info, doc, ifcond, features,
                  arg_type, ret_type,
-                 gen, success_response, boxed, allow_oob, allow_preconfig):
+                 gen, success_response, boxed, allow_oob, allow_preconfig,
+                 coroutine):
         super().__init__(name, info, doc, ifcond, features)
         assert not arg_type or isinstance(arg_type, str)
         assert not ret_type or isinstance(ret_type, str)
@@ -726,6 +727,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
         self.boxed = boxed
         self.allow_oob = allow_oob
         self.allow_preconfig = allow_preconfig
+        self.coroutine = coroutine
 
     def check(self, schema):
         super().check(schema)
@@ -768,7 +770,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
         visitor.visit_command(
             self.name, self.info, self.ifcond, self.features,
             self.arg_type, self.ret_type, self.gen, self.success_response,
-            self.boxed, self.allow_oob, self.allow_preconfig)
+            self.boxed, self.allow_oob, self.allow_preconfig, self.coroutine)
 
 
 class QAPISchemaEvent(QAPISchemaEntity):
@@ -1074,6 +1076,7 @@ class QAPISchema:
         boxed = expr.get('boxed', False)
         allow_oob = expr.get('allow-oob', False)
         allow_preconfig = expr.get('allow-preconfig', False)
+        coroutine = expr.get('coroutine', False)
         ifcond = expr.get('if')
         features = self._make_features(expr.get('features'), info)
         if isinstance(data, OrderedDict):
@@ -1086,7 +1089,8 @@ class QAPISchema:
         self._def_entity(QAPISchemaCommand(name, info, doc, ifcond, features,
                                            data, rets,
                                            gen, success_response,
-                                           boxed, allow_oob, allow_preconfig))
+                                           boxed, allow_oob, allow_preconfig,
+                                           coroutine))
 
     def _def_event(self, expr, info, doc):
         name = expr['event']
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index f396b471eb..e8db9d09d9 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -68,12 +68,13 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
 
     def visit_command(self, name, info, ifcond, features,
                       arg_type, ret_type, gen, success_response, boxed,
-                      allow_oob, allow_preconfig):
+                      allow_oob, allow_preconfig, coroutine):
         print('command %s %s -> %s'
               % (name, arg_type and arg_type.name,
                  ret_type and ret_type.name))
-        print('    gen=%s success_response=%s boxed=%s oob=%s preconfig=%s'
-              % (gen, success_response, boxed, allow_oob, allow_preconfig))
+        print('    gen=%s success_response=%s boxed=%s oob=%s preconfig=%s%s'
+              % (gen, success_response, boxed, allow_oob, allow_preconfig,
+                 " coroutine=True" if coroutine else ""))
         self._print_if(ifcond)
         self._print_features(features)
 
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 03a74b60f6..bb69487436 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -290,6 +290,7 @@ qapi-schema += missing-type.json
 qapi-schema += nested-struct-data.json
 qapi-schema += nested-struct-data-invalid-dict.json
 qapi-schema += non-objects.json
+qapi-schema += oob-coroutine.json
 qapi-schema += oob-test.json
 qapi-schema += allow-preconfig-test.json
 qapi-schema += pragma-doc-required-crap.json
diff --git a/tests/qapi-schema/oob-coroutine.err b/tests/qapi-schema/oob-coroutine.err
new file mode 100644
index 0000000000..c01a4992bd
--- /dev/null
+++ b/tests/qapi-schema/oob-coroutine.err
@@ -0,0 +1,2 @@
+oob-coroutine.json: In command 'oob-command-1':
+oob-coroutine.json:2: flags 'allow-oob' and 'coroutine' are incompatible
diff --git a/tests/qapi-schema/oob-coroutine.json b/tests/qapi-schema/oob-coroutine.json
new file mode 100644
index 0000000000..0f67663bcd
--- /dev/null
+++ b/tests/qapi-schema/oob-coroutine.json
@@ -0,0 +1,2 @@
+# Check that incompatible flags allow-oob and coroutine are rejected
+{ 'command': 'oob-command-1', 'allow-oob': true, 'coroutine': true }
diff --git a/tests/qapi-schema/oob-coroutine.out b/tests/qapi-schema/oob-coroutine.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index 6b1f05afa7..3e29fe5b40 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -147,6 +147,7 @@
   'returns': 'UserDefTwo' }
 
 { 'command': 'cmd-success-response', 'data': {}, 'success-response': false }
+{ 'command': 'coroutine-cmd', 'data': {}, 'coroutine': true }
 
 # Returning a non-dictionary requires a name from the whitelist
 { 'command': 'guest-get-time', 'data': {'a': 'int', '*b': 'int' },
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index 891b4101e0..8868ca0dca 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -203,6 +203,8 @@ command user_def_cmd2 q_obj_user_def_cmd2-arg -> UserDefTwo
     gen=True success_response=True boxed=False oob=False preconfig=False
 command cmd-success-response None -> None
     gen=True success_response=False boxed=False oob=False preconfig=False
+command coroutine-cmd None -> None
+    gen=True success_response=True boxed=False oob=False preconfig=False coroutine=True
 object q_obj_guest-get-time-arg
     member a: int optional=False
     member b: int optional=True
-- 
2.25.4


