Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CACC2D0E3
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 23:02:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 745EB20770
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 23:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wh5nrD0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 745EB20770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIJxb-00073v-GV
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 19:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIJdf-0007Mx-VO
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 18:41:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIJdd-0002hC-Qf
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 18:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600209684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uahw5VxJvg7Mg8Xm/z24kEFUIYO2j5wRgaa8KzHDdqg=;
 b=Wh5nrD0+eQ3/SWTc6XRAVHfXdHzOjugsnaG+ISaTWWXM5nJOZAAlvp8gpkOOZMX/xg+TNW
 EyMHeZvVRufr8yAh/dcVcfKDwIdClDvklgp+EST4VllxsPe06i9wKKF+Cu2bapr9TfudGU
 ouXhiianHFG0aDXaWmUbBds52s53qG8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-MV7n_buzOn-IWI2rVs1pJQ-1; Tue, 15 Sep 2020 18:41:23 -0400
X-MC-Unique: MV7n_buzOn-IWI2rVs1pJQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5815918C8C20;
 Tue, 15 Sep 2020 22:41:07 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4518A76E16;
 Tue, 15 Sep 2020 22:41:06 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 20/37] qapi/commands.py: add notational type hints
Date: Tue, 15 Sep 2020 18:40:10 -0400
Message-Id: <20200915224027.2529813-21-jsnow@redhat.com>
In-Reply-To: <20200915224027.2529813-1-jsnow@redhat.com>
References: <20200915224027.2529813-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 18:01:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/commands.py | 72 ++++++++++++++++++++++++++++++----------
 1 file changed, 54 insertions(+), 18 deletions(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index b215e58357..3c950da10a 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -13,15 +13,32 @@
 See the COPYING file in the top-level directory.
 """
 
+from typing import Dict, Optional, List, Set
+
 from .common import (
     c_name,
     mcgen,
 )
+from .gen import (
+    QAPIGenC,
+    QAPIGenCCode,
+    QAPISchemaModularCVisitor,
+    ifcontext,
+)
 from .params import build_params
-from .gen import QAPIGenCCode, QAPISchemaModularCVisitor, ifcontext
+from .schema import (
+    QAPISchema,
+    QAPISchemaFeature,
+    QAPISchemaObjectType,
+    QAPISchemaType,
+)
+from .source import QAPISourceInfo
 
 
-def gen_command_decl(name, arg_type, boxed, ret_type):
+def gen_command_decl(name: str,
+                     arg_type: Optional[QAPISchemaObjectType],
+                     boxed: bool,
+                     ret_type: Optional[QAPISchemaType]) -> str:
     return mcgen('''
 %(c_type)s qmp_%(c_name)s(%(params)s);
 ''',
@@ -30,7 +47,10 @@ def gen_command_decl(name, arg_type, boxed, ret_type):
                  params=build_params(arg_type, boxed, 'Error **errp'))
 
 
-def gen_call(name, arg_type, boxed, ret_type):
+def gen_call(name: str,
+             arg_type: Optional[QAPISchemaObjectType],
+             boxed: bool,
+             ret_type: Optional[QAPISchemaType]) -> str:
     ret = ''
 
     argstr = ''
@@ -66,7 +86,7 @@ def gen_call(name, arg_type, boxed, ret_type):
     return ret
 
 
-def gen_marshal_output(ret_type):
+def gen_marshal_output(ret_type: QAPISchemaType) -> str:
     return mcgen('''
 
 static void qmp_marshal_output_%(c_name)s(%(c_type)s ret_in, QObject **ret_out,
@@ -87,19 +107,22 @@ def gen_marshal_output(ret_type):
                  c_type=ret_type.c_type(), c_name=ret_type.c_name())
 
 
-def build_marshal_proto(name):
+def build_marshal_proto(name: str) -> str:
     return ('void qmp_marshal_%s(QDict *args, QObject **ret, Error **errp)'
             % c_name(name))
 
 
-def gen_marshal_decl(name):
+def gen_marshal_decl(name: str) -> str:
     return mcgen('''
 %(proto)s;
 ''',
                  proto=build_marshal_proto(name))
 
 
-def gen_marshal(name, arg_type, boxed, ret_type):
+def gen_marshal(name: str,
+                arg_type: Optional[QAPISchemaObjectType],
+                boxed: bool,
+                ret_type: Optional[QAPISchemaType]) -> str:
     have_args = boxed or (arg_type and not arg_type.is_empty())
 
     ret = mcgen('''
@@ -181,7 +204,10 @@ def gen_marshal(name, arg_type, boxed, ret_type):
     return ret
 
 
-def gen_register_command(name, success_response, allow_oob, allow_preconfig):
+def gen_register_command(name: str,
+                         success_response: bool,
+                         allow_oob: bool,
+                         allow_preconfig: bool) -> str:
     options = []
 
     if not success_response:
@@ -203,7 +229,7 @@ def gen_register_command(name, success_response, allow_oob, allow_preconfig):
     return ret
 
 
-def gen_registry(registry, prefix):
+def gen_registry(registry: str, prefix: str) -> str:
     ret = mcgen('''
 
 void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds)
@@ -220,15 +246,14 @@ def gen_registry(registry, prefix):
 
 
 class QAPISchemaGenCommandVisitor(QAPISchemaModularCVisitor):
-
-    def __init__(self, prefix):
+    def __init__(self, prefix: str):
         super().__init__(
             prefix, 'qapi-commands',
             ' * Schema-defined QAPI/QMP commands', None, __doc__)
         self._regy = QAPIGenCCode(None)
-        self._visited_ret_types = {}
+        self._visited_ret_types: Dict[QAPIGenC, Set[QAPISchemaType]] = {}
 
-    def _begin_user_module(self, name):
+    def _begin_user_module(self, name: str) -> None:
         self._visited_ret_types[self._genc] = set()
         commands = self._module_basename('qapi-commands', name)
         types = self._module_basename('qapi-types', name)
@@ -252,7 +277,7 @@ def _begin_user_module(self, name):
 ''',
                              types=types))
 
-    def visit_end(self):
+    def visit_end(self) -> None:
         self._add_system_module('init', ' * QAPI Commands initialization')
         self._genh.add(mcgen('''
 #include "qapi/qmp/dispatch.h"
@@ -268,9 +293,18 @@ def visit_end(self):
                                       prefix=self._prefix))
         self._genc.add(gen_registry(self._regy.get_content(), self._prefix))
 
-    def visit_command(self, name, info, ifcond, features,
-                      arg_type, ret_type, gen, success_response, boxed,
-                      allow_oob, allow_preconfig):
+    def visit_command(self,
+                      name: str,
+                      info: QAPISourceInfo,
+                      ifcond: List[str],
+                      features: List[QAPISchemaFeature],
+                      arg_type: Optional[QAPISchemaObjectType],
+                      ret_type: Optional[QAPISchemaType],
+                      gen: bool,
+                      success_response: bool,
+                      boxed: bool,
+                      allow_oob: bool,
+                      allow_preconfig: bool) -> None:
         if not gen:
             return
         # FIXME: If T is a user-defined type, the user is responsible
@@ -291,7 +325,9 @@ def visit_command(self, name, info, ifcond, features,
                                                 allow_oob, allow_preconfig))
 
 
-def gen_commands(schema, output_dir, prefix):
+def gen_commands(schema: QAPISchema,
+                 output_dir: str,
+                 prefix: str) -> None:
     vis = QAPISchemaGenCommandVisitor(prefix)
     schema.visit(vis)
     vis.write(output_dir)
-- 
2.26.2


