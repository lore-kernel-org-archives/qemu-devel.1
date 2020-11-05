Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395F5C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58BE720782
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRxzC7+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BE720782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaeai-0000rx-5O
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 07:42:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kaeP4-0003Gs-Pj
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 07:30:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kaeP1-0004xr-N5
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 07:30:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604579406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vfZujg0N6cua9BlDcAeI7ULjamCVgXpF4Qmay/ot2Vs=;
 b=DRxzC7+ERYsFpNE7UAD+WitK8irzIN2FKX//n2noUCWsI5dNGIDavwcTOUN5IfhcwknrXj
 kf/rtU34vBbkBRqtUN0tZ8vbDWHwz0qixbVEr+S77ayAkwhvXCJ4M3hIHJiFi2b04Jk4T9
 JRInI8oynMosJT9qlLYOs04A8qWl87M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-z-PruzEkOhCDghzUBAL-zg-1; Thu, 05 Nov 2020 07:30:04 -0500
X-MC-Unique: z-PruzEkOhCDghzUBAL-zg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FFAA100F954;
 Thu,  5 Nov 2020 12:30:03 +0000 (UTC)
Received: from localhost (unknown [10.36.110.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E37C5C5FD;
 Thu,  5 Nov 2020 12:29:55 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/9] qapi: normalize 'if' condition to IfPredicate tree
Date: Thu,  5 Nov 2020 16:28:05 +0400
Message-Id: <20201105122808.1182973-7-marcandre.lureau@redhat.com>
In-Reply-To: <20201105122808.1182973-1-marcandre.lureau@redhat.com>
References: <20201105122808.1182973-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, jsnow@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Modify check_if() to build an IfPredicate tree. (the documentation is
updated in a following patch)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/expr.py                          | 64 +++++++++++++------
 scripts/qapi/schema.py                        |  9 +--
 tests/qapi-schema/bad-if.err                  |  3 +-
 tests/qapi-schema/doc-good.out                | 12 ++--
 tests/qapi-schema/enum-if-invalid.err         |  3 +-
 tests/qapi-schema/features-if-invalid.err     |  2 +-
 tests/qapi-schema/qapi-schema-test.json       | 15 +++--
 tests/qapi-schema/qapi-schema-test.out        | 55 ++++++++--------
 .../qapi-schema/struct-member-if-invalid.err  |  2 +-
 tests/test-qmp-cmds.c                         |  1 +
 10 files changed, 99 insertions(+), 67 deletions(-)

diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index ad1e214386..2290baccb5 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -44,7 +44,14 @@ from typing import (
     cast,
 )
 
-from .common import c_name
+from .common import (
+    IfAll,
+    IfAny,
+    IfNot,
+    IfOption,
+    IfPredicate,
+    c_name,
+)
 from .error import QAPISemError
 from .parser import ParsedExpression
 from .source import QAPISourceInfo
@@ -196,41 +203,56 @@ def check_if(expr: _JSObject, info: QAPISourceInfo, source: str) -> None:
     """
     Syntactically validate and normalize the ``if`` field of an object. [RW]
 
-    The ``if`` field may be either a ``str`` or a ``List[str]``.
-    A ``str`` element will be normalized to ``List[str]``.
+    The ``if`` field may be either a ``str``, a ``List[str]`` or a dict.
+    A ``str`` element or a ``List[str]`` will be normalized to
+    ``IfAll([str])``.
 
     :param expr: A ``dict``; the ``if`` field, if present, will be validated.
     :param info: QAPI source file information.
 
     :forms:
-      :sugared: ``Union[str, List[str]]``
-      :canonical: ``List[str]``
+      :sugared: ``Union[str, List[str], dict[str, object]]``
+      :canonical: ``IfPredicate``
     """
 
-    def check_if_str(ifcond: object) -> None:
-        if not isinstance(ifcond, str):
+    def normalize(cond: Union[str, List[str], object]) -> IfPredicate:
+        if isinstance(cond, str):
+            if not cond.strip():
+                raise QAPISemError(
+                    info,
+                    "'if' condition '%s' of %s makes no sense"
+                    % (cond, source))
+            return IfOption(cond)
+        if isinstance(cond, list):
+            cond = {"all": cond}
+        if not isinstance(cond, dict):
             raise QAPISemError(
                 info,
-                "'if' condition of %s must be a string or a list of strings"
-                % source)
-        if ifcond.strip() == '':
+                "'if' condition of %s must be a string, "
+                "a list of strings or a dict" % source)
+        if len(cond) != 1:
             raise QAPISemError(
                 info,
-                "'if' condition '%s' of %s makes no sense"
-                % (ifcond, source))
+                "'if' condition dict of %s must have one key: "
+                "'all', 'any' or 'not'" % source)
+        check_keys(cond, info, "'if' condition",
+                   optional=("all", "any", "not"))
+        op, operands = next(iter(cond.items()))
+        if op == "not":
+            return IfNot(normalize(operands))
+        if not operands:
+            raise QAPISemError(
+                info, "'if' condition [] of %s is useless" % source)
+        if not isinstance(operands, list):
+            raise QAPISemError(
+                info, "'%s' condition of %s must be a list" % (op, source))
+        operands = [normalize(o) for o in operands]
+        return IfAll(operands) if op == "all" else IfAny(operands)
 
     ifcond = expr.get('if')
     if ifcond is None:
         return
-
-    if not isinstance(ifcond, list):
-        ifcond = [ifcond]
-        expr['if'] = ifcond
-    if not ifcond:
-        raise QAPISemError(
-            info, "'if' condition [] of %s is useless" % source)
-    for elt in ifcond:
-        check_if_str(elt)
+    expr['if'] = normalize(ifcond)
 
 
 def normalize_members(members: object) -> None:
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 4a4dbf2da7..3394a8b0bd 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -62,7 +62,6 @@ from typing import (
     Dict,
     List,
     Optional,
-    Sequence,
     Type,
     TypeVar,
     Union,
@@ -72,8 +71,7 @@ from typing import (
 
 from .common import (
     POINTER_SUFFIX,
-    IfAll,
-    IfOption,
+    IfPredicate,
     c_name,
     mcgen,
 )
@@ -92,9 +90,8 @@ class Visitable:
 
 
 class QAPISchemaIf:
-    def __init__(self, ifcond: Optional[Sequence[str]] = None):
-        pred_list = [IfOption(opt) for opt in ifcond or []]
-        self.pred = IfAll(pred_list)
+    def __init__(self, pred: Optional[IfPredicate] = None):
+        self.pred = pred
 
     def __bool__(self) -> bool:
         return bool(self.pred)
diff --git a/tests/qapi-schema/bad-if.err b/tests/qapi-schema/bad-if.err
index f83dee65da..454fbae387 100644
--- a/tests/qapi-schema/bad-if.err
+++ b/tests/qapi-schema/bad-if.err
@@ -1,2 +1,3 @@
 bad-if.json: In struct 'TestIfStruct':
-bad-if.json:2: 'if' condition of struct must be a string or a list of strings
+bad-if.json:2: 'if' condition has unknown key 'value'
+Valid keys are 'all', 'any', 'not'.
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 0d27323c47..6b723d2341 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -12,15 +12,15 @@ enum QType
 module doc-good.json
 enum Enum
     member one
-        if IfAll(['defined(IFONE)'])
+        if 'defined(IFONE)'
     member two
-    if IfAll(['defined(IFCOND)'])
+    if 'defined(IFCOND)'
     feature enum-feat
 object Base
     member base1: Enum optional=False
 object Variant1
     member var1: str optional=False
-        if IfAll(['defined(IFSTR)'])
+        if 'defined(IFSTR)'
         feature member-feat
     feature variant1-feat
 object Variant2
@@ -29,7 +29,7 @@ object Object
     tag base1
     case one: Variant1
     case two: Variant2
-        if IfAll(['IFTWO'])
+        if 'IFTWO'
     feature union-feat1
 object q_obj_Variant1-wrapper
     member data: Variant1 optional=False
@@ -38,13 +38,13 @@ object q_obj_Variant2-wrapper
 enum SugaredUnionKind
     member one
     member two
-        if IfAll(['IFTWO'])
+        if 'IFTWO'
 object SugaredUnion
     member type: SugaredUnionKind optional=False
     tag type
     case one: q_obj_Variant1-wrapper
     case two: q_obj_Variant2-wrapper
-        if IfAll(['IFTWO'])
+        if 'IFTWO'
     feature union-feat2
 alternate Alternate
     tag type
diff --git a/tests/qapi-schema/enum-if-invalid.err b/tests/qapi-schema/enum-if-invalid.err
index 0556dc967b..3bb84075a9 100644
--- a/tests/qapi-schema/enum-if-invalid.err
+++ b/tests/qapi-schema/enum-if-invalid.err
@@ -1,2 +1,3 @@
 enum-if-invalid.json: In enum 'TestIfEnum':
-enum-if-invalid.json:2: 'if' condition of 'data' member 'bar' must be a string or a list of strings
+enum-if-invalid.json:2: 'if' condition has unknown key 'val'
+Valid keys are 'all', 'any', 'not'.
diff --git a/tests/qapi-schema/features-if-invalid.err b/tests/qapi-schema/features-if-invalid.err
index f63b89535e..724a810086 100644
--- a/tests/qapi-schema/features-if-invalid.err
+++ b/tests/qapi-schema/features-if-invalid.err
@@ -1,2 +1,2 @@
 features-if-invalid.json: In struct 'Stru':
-features-if-invalid.json:2: 'if' condition of 'features' member 'f' must be a string or a list of strings
+features-if-invalid.json:2: 'if' condition of 'features' member 'f' must be a string, a list of strings or a dict
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index 63f92adf68..6b3089a553 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -228,7 +228,7 @@
 { 'union': 'TestIfUnion', 'data':
   { 'foo': 'TestStruct',
     'union_bar': { 'type': 'str', 'if': 'defined(TEST_IF_UNION_BAR)'} },
-  'if': 'defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)' }
+  'if': ['defined(TEST_IF_UNION)', 'defined(TEST_IF_STRUCT)'] }
 
 { 'command': 'TestIfUnionCmd', 'data': { 'union_cmd_arg': 'TestIfUnion' },
   'if': 'defined(TEST_IF_UNION)' }
@@ -236,10 +236,10 @@
 { 'alternate': 'TestIfAlternate', 'data':
   { 'foo': 'int',
     'bar': { 'type': 'TestStruct', 'if': 'defined(TEST_IF_ALT_BAR)'} },
-  'if': 'defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)' }
+  'if': {'all': ['defined(TEST_IF_ALT)', 'defined(TEST_IF_STRUCT)'] } }
 
 { 'command': 'TestIfAlternateCmd', 'data': { 'alt_cmd_arg': 'TestIfAlternate' },
-  'if': 'defined(TEST_IF_ALT)' }
+  'if': {'all': ['defined(TEST_IF_ALT)', {'not': 'defined(TEST_IF_NOT_ALT)'}] } }
 
 { 'command': 'TestIfCmd', 'data':
   { 'foo': 'TestIfStruct',
@@ -252,7 +252,7 @@
 { 'event': 'TestIfEvent', 'data':
   { 'foo': 'TestIfStruct',
     'bar': { 'type': ['TestIfEnum'], 'if': 'defined(TEST_IF_EVT_BAR)' } },
-  'if': 'defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)' }
+  'if': ['defined(TEST_IF_EVT)', 'defined(TEST_IF_STRUCT)'] }
 
 # test 'features'
 
@@ -283,6 +283,10 @@
   'data': { 'foo': 'int' },
   'features': [ { 'name': 'feature1', 'if': [ 'defined(TEST_IF_COND_1)',
                                               'defined(TEST_IF_COND_2)'] } ] }
+{ 'struct': 'CondFeatureStruct4',
+  'data': { 'foo': 'int' },
+  'features': [ { 'name': 'feature1', 'if': {'any': ['defined(TEST_IF_COND_1)',
+                                                     'defined(TEST_IF_COND_2)'] } } ] }
 
 { 'enum': 'FeatureEnum1',
   'data': [ 'eins', 'zwei', 'drei' ],
@@ -306,7 +310,8 @@
             'fs4': 'FeatureStruct4',
             'cfs1': 'CondFeatureStruct1',
             'cfs2': 'CondFeatureStruct2',
-            'cfs3': 'CondFeatureStruct3' },
+            'cfs3': 'CondFeatureStruct3',
+            'cfs4': 'CondFeatureStruct4' },
   'features': [] }
 
 { 'command': 'test-command-features1',
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index 8ba658cd38..558427f6fa 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -298,49 +298,49 @@ command __org.qemu_x-command q_obj___org.qemu_x-command-arg -> __org.qemu_x-Unio
 object TestIfStruct
     member foo: int optional=False
     member bar: int optional=False
-        if IfAll(['defined(TEST_IF_STRUCT_BAR)'])
-    if IfAll(['defined(TEST_IF_STRUCT)'])
+        if 'defined(TEST_IF_STRUCT_BAR)'
+    if 'defined(TEST_IF_STRUCT)'
 enum TestIfEnum
     member foo
     member bar
-        if IfAll(['defined(TEST_IF_ENUM_BAR)'])
-    if IfAll(['defined(TEST_IF_ENUM)'])
+        if 'defined(TEST_IF_ENUM_BAR)'
+    if 'defined(TEST_IF_ENUM)'
 object q_obj_TestStruct-wrapper
     member data: TestStruct optional=False
 enum TestIfUnionKind
     member foo
     member union_bar
-        if IfAll(['defined(TEST_IF_UNION_BAR)'])
-    if IfAll(['defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)'])
+        if 'defined(TEST_IF_UNION_BAR)'
+    if IfAll(['defined(TEST_IF_UNION)', 'defined(TEST_IF_STRUCT)'])
 object TestIfUnion
     member type: TestIfUnionKind optional=False
     tag type
     case foo: q_obj_TestStruct-wrapper
     case union_bar: q_obj_str-wrapper
-        if IfAll(['defined(TEST_IF_UNION_BAR)'])
-    if IfAll(['defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)'])
+        if 'defined(TEST_IF_UNION_BAR)'
+    if IfAll(['defined(TEST_IF_UNION)', 'defined(TEST_IF_STRUCT)'])
 object q_obj_TestIfUnionCmd-arg
     member union_cmd_arg: TestIfUnion optional=False
-    if IfAll(['defined(TEST_IF_UNION)'])
+    if 'defined(TEST_IF_UNION)'
 command TestIfUnionCmd q_obj_TestIfUnionCmd-arg -> None
     gen=True success_response=True boxed=False oob=False preconfig=False
-    if IfAll(['defined(TEST_IF_UNION)'])
+    if 'defined(TEST_IF_UNION)'
 alternate TestIfAlternate
     tag type
     case foo: int
     case bar: TestStruct
-        if IfAll(['defined(TEST_IF_ALT_BAR)'])
-    if IfAll(['defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)'])
+        if 'defined(TEST_IF_ALT_BAR)'
+    if IfAll(['defined(TEST_IF_ALT)', 'defined(TEST_IF_STRUCT)'])
 object q_obj_TestIfAlternateCmd-arg
     member alt_cmd_arg: TestIfAlternate optional=False
-    if IfAll(['defined(TEST_IF_ALT)'])
+    if IfAll(['defined(TEST_IF_ALT)', IfNot('defined(TEST_IF_NOT_ALT)')])
 command TestIfAlternateCmd q_obj_TestIfAlternateCmd-arg -> None
     gen=True success_response=True boxed=False oob=False preconfig=False
-    if IfAll(['defined(TEST_IF_ALT)'])
+    if IfAll(['defined(TEST_IF_ALT)', IfNot('defined(TEST_IF_NOT_ALT)')])
 object q_obj_TestIfCmd-arg
     member foo: TestIfStruct optional=False
     member bar: TestIfEnum optional=False
-        if IfAll(['defined(TEST_IF_CMD_BAR)'])
+        if 'defined(TEST_IF_CMD_BAR)'
     if IfAll(['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)'])
 command TestIfCmd q_obj_TestIfCmd-arg -> UserDefThree
     gen=True success_response=True boxed=False oob=False preconfig=False
@@ -348,15 +348,15 @@ command TestIfCmd q_obj_TestIfCmd-arg -> UserDefThree
 command TestCmdReturnDefThree None -> UserDefThree
     gen=True success_response=True boxed=False oob=False preconfig=False
 array TestIfEnumList TestIfEnum
-    if IfAll(['defined(TEST_IF_ENUM)'])
+    if 'defined(TEST_IF_ENUM)'
 object q_obj_TestIfEvent-arg
     member foo: TestIfStruct optional=False
     member bar: TestIfEnumList optional=False
-        if IfAll(['defined(TEST_IF_EVT_BAR)'])
-    if IfAll(['defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)'])
+        if 'defined(TEST_IF_EVT_BAR)'
+    if IfAll(['defined(TEST_IF_EVT)', 'defined(TEST_IF_STRUCT)'])
 event TestIfEvent q_obj_TestIfEvent-arg
     boxed=False
-    if IfAll(['defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)'])
+    if IfAll(['defined(TEST_IF_EVT)', 'defined(TEST_IF_STRUCT)'])
 object FeatureStruct0
     member foo: int optional=False
 object FeatureStruct1
@@ -379,17 +379,21 @@ object FeatureStruct4
 object CondFeatureStruct1
     member foo: int optional=False
     feature feature1
-        if IfAll(['defined(TEST_IF_FEATURE_1)'])
+        if 'defined(TEST_IF_FEATURE_1)'
 object CondFeatureStruct2
     member foo: int optional=False
     feature feature1
-        if IfAll(['defined(TEST_IF_FEATURE_1)'])
+        if 'defined(TEST_IF_FEATURE_1)'
     feature feature2
-        if IfAll(['defined(TEST_IF_FEATURE_2)'])
+        if 'defined(TEST_IF_FEATURE_2)'
 object CondFeatureStruct3
     member foo: int optional=False
     feature feature1
         if IfAll(['defined(TEST_IF_COND_1)', 'defined(TEST_IF_COND_2)'])
+object CondFeatureStruct4
+    member foo: int optional=False
+    feature feature1
+        if IfAny(['defined(TEST_IF_COND_1)', 'defined(TEST_IF_COND_2)'])
 enum FeatureEnum1
     member eins
     member zwei
@@ -417,6 +421,7 @@ object q_obj_test-features0-arg
     member cfs1: CondFeatureStruct1 optional=False
     member cfs2: CondFeatureStruct2 optional=False
     member cfs3: CondFeatureStruct3 optional=False
+    member cfs4: CondFeatureStruct4 optional=False
 command test-features0 q_obj_test-features0-arg -> None
     gen=True success_response=True boxed=False oob=False preconfig=False
 command test-command-features1 None -> None
@@ -429,13 +434,13 @@ command test-command-features3 None -> None
 command test-command-cond-features1 None -> None
     gen=True success_response=True boxed=False oob=False preconfig=False
     feature feature1
-        if IfAll(['defined(TEST_IF_FEATURE_1)'])
+        if 'defined(TEST_IF_FEATURE_1)'
 command test-command-cond-features2 None -> None
     gen=True success_response=True boxed=False oob=False preconfig=False
     feature feature1
-        if IfAll(['defined(TEST_IF_FEATURE_1)'])
+        if 'defined(TEST_IF_FEATURE_1)'
     feature feature2
-        if IfAll(['defined(TEST_IF_FEATURE_2)'])
+        if 'defined(TEST_IF_FEATURE_2)'
 command test-command-cond-features3 None -> None
     gen=True success_response=True boxed=False oob=False preconfig=False
     feature feature1
diff --git a/tests/qapi-schema/struct-member-if-invalid.err b/tests/qapi-schema/struct-member-if-invalid.err
index 42e7fdae3c..c18157c1f9 100644
--- a/tests/qapi-schema/struct-member-if-invalid.err
+++ b/tests/qapi-schema/struct-member-if-invalid.err
@@ -1,2 +1,2 @@
 struct-member-if-invalid.json: In struct 'Stru':
-struct-member-if-invalid.json:2: 'if' condition of 'data' member 'member' must be a string or a list of strings
+struct-member-if-invalid.json:2: 'if' condition of 'data' member 'member' must be a string, a list of strings or a dict
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index d3413bfef0..9aabf8ccd4 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -53,6 +53,7 @@ void qmp_test_features0(FeatureStruct0 *fs0, FeatureStruct1 *fs1,
                        FeatureStruct2 *fs2, FeatureStruct3 *fs3,
                        FeatureStruct4 *fs4, CondFeatureStruct1 *cfs1,
                        CondFeatureStruct2 *cfs2, CondFeatureStruct3 *cfs3,
+                       CondFeatureStruct4 *cfs4,
                        Error **errp)
 {
 }
-- 
2.29.0


