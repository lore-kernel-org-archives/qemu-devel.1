Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8653EC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 17:03:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE96322254
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 17:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AeWg7hik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE96322254
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT6f8-0006l2-Gd
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 13:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kT6VH-0002wD-3e
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58790)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kT6VA-0001VT-QI
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602780795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/65jF4dN+hiIiX2ScXqyOrgcQndQ6YQjrO4QYF6wiSM=;
 b=AeWg7hikaLBPbVLbFb6Ud2jtCILpRunccKwcFWTdcRFNb2h0ya/UaT18bU0F26P66jvW5Q
 JLwlJW8m1AMOvVKRp6zkC/+lBZEVXTjpIC2a4BbQqmgJyv/8TFAIc2bp2v3V4XY+sOyuGu
 NcItJDbBHO7Pi2zfVISgenNTMejmluI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-Q2KNrmzaMfu0XDZ0ONC8EQ-1; Thu, 15 Oct 2020 12:53:12 -0400
X-MC-Unique: Q2KNrmzaMfu0XDZ0ONC8EQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 586BA1019634;
 Thu, 15 Oct 2020 16:53:11 +0000 (UTC)
Received: from localhost (unknown [10.36.110.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CEF35C1BD;
 Thu, 15 Oct 2020 16:53:05 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 1/9] qapi: replace List[str] by IfCond
Date: Thu, 15 Oct 2020 20:52:47 +0400
Message-Id: <20201015165255.1573897-2-marcandre.lureau@redhat.com>
In-Reply-To: <20201015165255.1573897-1-marcandre.lureau@redhat.com>
References: <20201015165255.1573897-1-marcandre.lureau@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
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
Cc: jsnow@redhat.com, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Wrap the 'if' condition in a higher-level object. Not only this is
allows more type safety but also further refactoring without too much
chrun. The following patches will extend the syntax of 'if' and will
have some extra handling and types.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/sphinx/qapidoc.py     |  2 +-
 scripts/qapi/commands.py   |  4 +-
 scripts/qapi/common.py     | 26 ++++++++---
 scripts/qapi/events.py     |  4 +-
 scripts/qapi/gen.py        |  9 ++--
 scripts/qapi/introspect.py | 21 ++++-----
 scripts/qapi/schema.py     | 91 ++++++++++++++++++++------------------
 scripts/qapi/types.py      | 11 ++---
 scripts/qapi/visit.py      |  9 ++--
 9 files changed, 102 insertions(+), 75 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 11e97839de..db9520f37f 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -116,7 +116,7 @@ class QAPISchemaGenRSTVisitor(QAPISchemaVisitor):
         the conditions are in literal-text and the commas are not.
         If with_if is False, we don't return the "(If: " and ")".
         """
-        condlist = intersperse([nodes.literal('', c) for c in ifcond],
+        condlist = intersperse([nodes.literal('', c) for c in ifcond.ifcond],
                                nodes.Text(', '))
         if not with_if:
             return condlist
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 50978090b4..03deac5fdd 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -20,7 +20,7 @@ from typing import (
     Set,
 )
 
-from .common import c_name, mcgen
+from .common import IfCond, c_name, mcgen
 from .gen import (
     QAPIGenC,
     QAPIGenCCode,
@@ -301,7 +301,7 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
     def visit_command(self,
                       name: str,
                       info: QAPISourceInfo,
-                      ifcond: List[str],
+                      ifcond: IfCond,
                       features: List[QAPISchemaFeature],
                       arg_type: Optional[QAPISchemaObjectType],
                       ret_type: Optional[QAPISchemaType],
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 11b86beeab..59e6a400da 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -12,7 +12,7 @@
 # See the COPYING file in the top-level directory.
 
 import re
-from typing import Optional, Sequence
+from typing import Optional, Sequence, Union
 
 
 #: Magic string that gets removed along with all space to its right.
@@ -194,18 +194,34 @@ def guardend(name: str) -> str:
                  name=c_fname(name).upper())
 
 
-def gen_if(ifcond: Sequence[str]) -> str:
+class IfCond:
+    def __init__(self, ifcond: Optional[Sequence[str]] = None):
+        self.ifcond = ifcond or []
+
+    def __bool__(self) -> bool:
+        return bool(self.ifcond)
+
+    def __repr__(self) -> str:
+        return repr(self.ifcond)
+
+    def __eq__(self, other: object) -> bool:
+        if not isinstance(other, IfCond):
+            return NotImplemented
+        return self.ifcond == other.ifcond
+
+
+def gen_if(c: IfCond) -> str:
     ret = ''
-    for ifc in ifcond:
+    for ifc in c.ifcond:
         ret += mcgen('''
 #if %(cond)s
 ''', cond=ifc)
     return ret
 
 
-def gen_endif(ifcond: Sequence[str]) -> str:
+def gen_endif(c: IfCond) -> str:
     ret = ''
-    for ifc in reversed(ifcond):
+    for ifc in reversed(c.ifcond):
         ret += mcgen('''
 #endif /* %(cond)s */
 ''', cond=ifc)
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index 599f3d1f56..e95a95feca 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -14,7 +14,7 @@ See the COPYING file in the top-level directory.
 
 from typing import List
 
-from .common import c_enum_const, c_name, mcgen
+from .common import IfCond, c_enum_const, c_name, mcgen
 from .gen import QAPISchemaModularCVisitor, build_params, ifcontext
 from .schema import (
     QAPISchema,
@@ -212,7 +212,7 @@ void %(event_emit)s(%(event_enum)s event, QDict *qdict);
     def visit_event(self,
                     name: str,
                     info: QAPISourceInfo,
-                    ifcond: List[str],
+                    ifcond: IfCond,
                     features: List[QAPISchemaFeature],
                     arg_type: QAPISchemaObjectType,
                     boxed: bool) -> None:
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index b40f18eee3..b35ccb201f 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -23,6 +23,7 @@ from typing import (
 )
 
 from .common import (
+    IfCond,
     c_fname,
     c_name,
     gen_endif,
@@ -81,7 +82,7 @@ class QAPIGen:
                 fp.write(text)
 
 
-def _wrap_ifcond(ifcond: List[str], before: str, after: str) -> str:
+def _wrap_ifcond(ifcond: IfCond, before: str, after: str) -> str:
     if before == after:
         return after   # suppress empty #if ... #endif
 
@@ -123,9 +124,9 @@ def build_params(arg_type: Optional[QAPISchemaObjectType],
 class QAPIGenCCode(QAPIGen):
     def __init__(self, fname: Optional[str]):
         super().__init__(fname)
-        self._start_if: Optional[Tuple[List[str], str, str]] = None
+        self._start_if: Optional[Tuple[IfCond, str, str]] = None
 
-    def start_if(self, ifcond: List[str]) -> None:
+    def start_if(self, ifcond: IfCond) -> None:
         assert self._start_if is None
         self._start_if = (ifcond, self._body, self._preamble)
 
@@ -186,7 +187,7 @@ class QAPIGenH(QAPIGenC):
 
 
 @contextmanager
-def ifcontext(ifcond: List[str], *args: QAPIGenCCode) -> Iterator[None]:
+def ifcontext(ifcond: IfCond, *args: QAPIGenCCode) -> Iterator[None]:
     """
     A with-statement context manager that wraps with `start_if()` / `end_if()`.
 
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 1817f1d34e..103b8515eb 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -21,6 +21,7 @@ from typing import (
 )
 
 from .common import (
+    IfCond,
     c_name,
     gen_endif,
     gen_if,
@@ -58,11 +59,11 @@ class Node(Generic[_NodeType]):
     """
     # Remove after 3.7 adds @dataclass:
     # pylint: disable=too-few-public-methods
-    def __init__(self, data: _NodeType, ifcond: Iterable[str],
+    def __init__(self, data: _NodeType, ifcond: IfCond,
                  comment: Optional[str] = None):
         self.data = data
         self.comment: Optional[str] = comment
-        self.ifcond: Sequence[str] = tuple(ifcond)
+        self.ifcond = ifcond
 
 
 def _tree_to_qlit(obj: TreeNode, level: int = 0,
@@ -197,7 +198,7 @@ const QLitObject %(c_name)s = %(c_string)s;
         return [Node(f.name, f.ifcond) for f in features]
 
     def _gen_tree(self, name: str, mtype: str, obj: _DObject,
-                  ifcond: List[str],
+                  ifcond: IfCond,
                   features: Optional[List[QAPISchemaFeature]]) -> None:
         comment: Optional[str] = None
         if mtype not in ('command', 'event', 'builtin', 'array'):
@@ -238,10 +239,10 @@ const QLitObject %(c_name)s = %(c_string)s;
 
     def visit_builtin_type(self, name: str, info: Optional[QAPISourceInfo],
                            json_type: str) -> None:
-        self._gen_tree(name, 'builtin', {'json-type': json_type}, [], None)
+        self._gen_tree(name, 'builtin', {'json-type': json_type}, IfCond(), None)
 
     def visit_enum_type(self, name: str, info: QAPISourceInfo,
-                        ifcond: List[str], features: List[QAPISchemaFeature],
+                        ifcond: IfCond, features: List[QAPISchemaFeature],
                         members: List[QAPISchemaEnumMember],
                         prefix: Optional[str]) -> None:
         self._gen_tree(name, 'enum',
@@ -249,14 +250,14 @@ const QLitObject %(c_name)s = %(c_string)s;
                        ifcond, features)
 
     def visit_array_type(self, name: str, info: Optional[QAPISourceInfo],
-                         ifcond: List[str],
+                         ifcond: IfCond,
                          element_type: QAPISchemaType) -> None:
         element = self._use_type(element_type)
         self._gen_tree('[' + element + ']', 'array', {'element-type': element},
                        ifcond, None)
 
     def visit_object_type_flat(self, name: str, info: Optional[QAPISourceInfo],
-                               ifcond: List[str],
+                               ifcond: IfCond,
                                features: List[QAPISchemaFeature],
                                members: Sequence[QAPISchemaObjectTypeMember],
                                variants: Optional[QAPISchemaVariants]) -> None:
@@ -268,7 +269,7 @@ const QLitObject %(c_name)s = %(c_string)s;
         self._gen_tree(name, 'object', obj, ifcond, features)
 
     def visit_alternate_type(self, name: str, info: QAPISourceInfo,
-                             ifcond: List[str],
+                             ifcond: IfCond,
                              features: List[QAPISchemaFeature],
                              variants: QAPISchemaVariants) -> None:
         self._gen_tree(name, 'alternate',
@@ -278,7 +279,7 @@ const QLitObject %(c_name)s = %(c_string)s;
                        ]},
                        ifcond, features)
 
-    def visit_command(self, name: str, info: QAPISourceInfo, ifcond: List[str],
+    def visit_command(self, name: str, info: QAPISourceInfo, ifcond: IfCond,
                       features: List[QAPISchemaFeature],
                       arg_type: QAPISchemaObjectType,
                       ret_type: Optional[QAPISchemaType], gen: bool,
@@ -295,7 +296,7 @@ const QLitObject %(c_name)s = %(c_string)s;
         self._gen_tree(name, 'command', obj, ifcond, features)
 
     def visit_event(self, name: str, info: QAPISourceInfo,
-                    ifcond: List[str], features: List[QAPISchemaFeature],
+                    ifcond: IfCond, features: List[QAPISchemaFeature],
                     arg_type: QAPISchemaObjectType, boxed: bool) -> None:
         arg_type = arg_type or self._schema.the_empty_object_type
         self._gen_tree(name, 'event', {'arg-type': self._use_type(arg_type)},
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index e388b3bced..b0287e2a8a 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -66,7 +66,7 @@ from typing import (
     overload,
 )
 
-from .common import POINTER_SUFFIX, c_name
+from .common import IfCond, POINTER_SUFFIX, c_name
 from .error import QAPISemError, QAPISourceError
 from .expr import check_exprs
 from .parser import ParsedExpression, QAPIDoc, QAPISchemaParser
@@ -86,7 +86,7 @@ class QAPISchemaEntity(Visitable):
                  name: str,
                  info: Optional[QAPISourceInfo],
                  doc: Optional[QAPIDoc],
-                 ifcond: Optional[Union[List[str], 'QAPISchemaType']] = None,
+                 ifcond: Optional[Union[IfCond, 'QAPISchemaType']] = None,
                  features: Optional[List['QAPISchemaFeature']] = None):
         assert name is None or isinstance(name, str)
 
@@ -103,7 +103,7 @@ class QAPISchemaEntity(Visitable):
         # such place).
         self.info = info
         self.doc = doc
-        self._ifcond = ifcond or []
+        self._ifcond = ifcond or IfCond()
         self.features = features or []
         self._checked = False
         self._meta = ''
@@ -148,8 +148,8 @@ class QAPISchemaEntity(Visitable):
         self._set_module(schema, self.info)
 
     @property
-    def ifcond(self) -> List[str]:
-        assert self._checked and isinstance(self._ifcond, list)
+    def ifcond(self) -> IfCond:
+        assert self._checked and isinstance(self._ifcond, IfCond)
         return self._ifcond
 
     def is_implicit(self) -> bool:
@@ -189,7 +189,7 @@ class QAPISchemaVisitor:
     def visit_enum_type(self,
                         name: str,
                         info: Optional[QAPISourceInfo],
-                        ifcond: List[str],
+                        ifcond: IfCond,
                         features: List['QAPISchemaFeature'],
                         members: List['QAPISchemaEnumMember'],
                         prefix: Optional[str]) -> None:
@@ -198,14 +198,14 @@ class QAPISchemaVisitor:
     def visit_array_type(self,
                          name: str,
                          info: Optional[QAPISourceInfo],
-                         ifcond: List[str],
+                         ifcond: IfCond,
                          element_type: 'QAPISchemaType') -> None:
         pass
 
     def visit_object_type(self,
                           name: str,
                           info: Optional[QAPISourceInfo],
-                          ifcond: List[str],
+                          ifcond: IfCond,
                           features: List['QAPISchemaFeature'],
                           base: Optional['QAPISchemaObjectType'],
                           members: List['QAPISchemaObjectTypeMember'],
@@ -215,7 +215,7 @@ class QAPISchemaVisitor:
     def visit_object_type_flat(self,
                                name: str,
                                info: Optional[QAPISourceInfo],
-                               ifcond: List[str],
+                               ifcond: IfCond,
                                features: List['QAPISchemaFeature'],
                                members: List['QAPISchemaObjectTypeMember'],
                                variants: Optional['QAPISchemaVariants'],
@@ -225,7 +225,7 @@ class QAPISchemaVisitor:
     def visit_alternate_type(self,
                              name: str,
                              info: QAPISourceInfo,
-                             ifcond: List[str],
+                             ifcond: IfCond,
                              features: List['QAPISchemaFeature'],
                              variants: 'QAPISchemaVariants') -> None:
         pass
@@ -233,7 +233,7 @@ class QAPISchemaVisitor:
     def visit_command(self,
                       name: str,
                       info: QAPISourceInfo,
-                      ifcond: List[str],
+                      ifcond: IfCond,
                       features: List['QAPISchemaFeature'],
                       arg_type: 'QAPISchemaObjectType',
                       ret_type: Optional['QAPISchemaType'],
@@ -248,7 +248,7 @@ class QAPISchemaVisitor:
     def visit_event(self,
                     name: str,
                     info: QAPISourceInfo,
-                    ifcond: List[str],
+                    ifcond: IfCond,
                     features: List['QAPISchemaFeature'],
                     arg_type: 'QAPISchemaObjectType',
                     boxed: bool) -> None:
@@ -361,7 +361,7 @@ class QAPISchemaEnumType(QAPISchemaType):
                  name: str,
                  info: Optional[QAPISourceInfo],
                  doc: Optional[QAPIDoc],
-                 ifcond: Optional[List[str]],
+                 ifcond: Optional[IfCond],
                  features: Optional[List['QAPISchemaFeature']],
                  members: List['QAPISchemaEnumMember'],
                  prefix: Optional[str]):
@@ -427,7 +427,7 @@ class QAPISchemaArrayType(QAPISchemaType):
         self._set_module(schema, self.element_type.info)
 
     @property
-    def ifcond(self) -> List[str]:
+    def ifcond(self) -> IfCond:
         assert self._checked
         return self.element_type.ifcond
 
@@ -461,7 +461,7 @@ class QAPISchemaObjectType(QAPISchemaType):
                  name: str,
                  info: Optional[QAPISourceInfo],
                  doc: Optional[QAPIDoc],
-                 ifcond: Optional['QAPISchemaType'],
+                 ifcond: Optional[Union[IfCond, 'QAPISchemaType']],
                  features: Optional[List['QAPISchemaFeature']],
                  base: Optional[str],
                  local_members: List['QAPISchemaObjectTypeMember'],
@@ -545,7 +545,7 @@ class QAPISchemaObjectType(QAPISchemaType):
             member.connect_doc(doc)
 
     @property
-    def ifcond(self) -> List[str]:
+    def ifcond(self) -> IfCond:
         assert self._checked
         if isinstance(self._ifcond, QAPISchemaType):
             # Simple union wrapper type inherits from wrapped type;
@@ -591,7 +591,7 @@ class QAPISchemaAlternateType(QAPISchemaType):
                  name: str,
                  info: QAPISourceInfo,
                  doc: QAPIDoc,
-                 ifcond: Optional[List[str]],
+                 ifcond: Optional[IfCond],
                  features: List['QAPISchemaFeature'],
                  variants: 'QAPISchemaVariants'):
         super().__init__(name, info, doc, ifcond, features)
@@ -725,7 +725,7 @@ class QAPISchemaVariants:
         else:                   # simple union
             assert isinstance(self.tag_member.type, QAPISchemaEnumType)
             assert not self.tag_member.optional
-            assert self.tag_member.ifcond == []
+            assert not self.tag_member.ifcond
         if self._tag_name:    # flat union
             # branches that are not explicitly covered get an empty type
             cases = {v.name for v in self.variants}
@@ -772,11 +772,11 @@ class QAPISchemaMember:
 
     def __init__(self, name: str,
                  info: Optional[QAPISourceInfo],
-                 ifcond: Optional[List[str]] = None):
+                 ifcond: Optional[IfCond] = None):
         assert isinstance(name, str)
         self.name = name
         self.info = info
-        self.ifcond = ifcond or []
+        self.ifcond = ifcond or IfCond()
         self.defined_in: Optional[str] = None
 
     def set_defined_in(self, name: str) -> None:
@@ -843,7 +843,7 @@ class QAPISchemaObjectTypeMember(QAPISchemaMember):
                  info: QAPISourceInfo,
                  typ: str,
                  optional: bool,
-                 ifcond: Optional[List[str]] = None,
+                 ifcond: Optional[IfCond] = None,
                  features: Optional[List[QAPISchemaFeature]] = None):
         super().__init__(name, info, ifcond)
         assert isinstance(typ, str)
@@ -878,7 +878,7 @@ class QAPISchemaVariant(QAPISchemaObjectTypeMember):
                  name: str,
                  info: QAPISourceInfo,
                  typ: str,
-                 ifcond: Optional[List[str]] = None):
+                 ifcond: Optional[IfCond] = None):
         super().__init__(name, info, typ, False, ifcond)
 
 
@@ -887,7 +887,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
                  name: str,
                  info: QAPISourceInfo,
                  doc: QAPIDoc,
-                 ifcond: Optional[List[str]],
+                 ifcond: Optional[IfCond],
                  features: List[QAPISchemaFeature],
                  arg_type: str,
                  ret_type: Optional[str],
@@ -963,7 +963,7 @@ class QAPISchemaEvent(QAPISchemaEntity):
                  name: str,
                  info: QAPISourceInfo,
                  doc: QAPIDoc,
-                 ifcond: Optional[List[str]],
+                 ifcond: Optional[IfCond],
                  features: List[QAPISchemaFeature],
                  arg_type: str,
                  boxed: bool):
@@ -1143,13 +1143,20 @@ class QAPISchema(Visitable):
         self._def_entity(QAPISchemaEnumType('QType', None, None, None, None,
                                             qtype_values, 'QTYPE'))
 
+    @classmethod
+    def _get_if(cls, d: Dict[str, Any]) -> IfCond:
+        ifcond = d.get('if')
+        if isinstance(ifcond, IfCond):
+            return ifcond
+        return IfCond(ifcond)
+
     @classmethod
     def _make_features(cls,
                        features: Optional[List[Dict[str, Any]]],
                        info: QAPISourceInfo) -> List[QAPISchemaFeature]:
         if features is None:
             return []
-        return [QAPISchemaFeature(f['name'], info, f.get('if'))
+        return [QAPISchemaFeature(f['name'], info, cls._get_if(f))
                 for f in features]
 
     @classmethod
@@ -1157,13 +1164,13 @@ class QAPISchema(Visitable):
                            values: List[Dict[str, Any]],
                            info: Optional[QAPISourceInfo],
                            ) -> List[QAPISchemaEnumMember]:
-        return [QAPISchemaEnumMember(v['name'], info, v.get('if'))
+        return [QAPISchemaEnumMember(v['name'], info, cls._get_if(v))
                 for v in values]
 
     def _make_implicit_enum_type(self,
                                  name: str,
                                  info: QAPISourceInfo,
-                                 ifcond: Optional[List[str]],
+                                 ifcond: Optional[IfCond],
                                  values: List[Dict[str, Any]]) -> str:
         # See also QAPISchemaObjectTypeMember.describe()
         name = name + 'Kind'    # reserved by check_defn_name_str()
@@ -1184,7 +1191,7 @@ class QAPISchema(Visitable):
     def _make_implicit_object_type(self,
                                    name: str,
                                    info: QAPISourceInfo,
-                                   ifcond: Optional[QAPISchemaType],
+                                   ifcond: Union[IfCond, Optional[QAPISchemaType]],
                                    role: str,
                                    members: List[QAPISchemaObjectTypeMember],
                                    ) -> Optional[str]:
@@ -1205,7 +1212,7 @@ class QAPISchema(Visitable):
             # TODO kill simple unions or implement the disjunction
 
             # pylint: disable=protected-access
-            assert (ifcond or []) == typ._ifcond
+            assert ifcond == typ._ifcond
         else:
             self._def_entity(QAPISchemaObjectType(
                 name, info, None, ifcond, None, None, members, None))
@@ -1218,7 +1225,7 @@ class QAPISchema(Visitable):
         name = expr['enum']
         data = expr['data']
         prefix = expr.get('prefix')
-        ifcond = expr.get('if')
+        ifcond = IfCond(expr.get('if'))
         features = self._make_features(expr.get('features'), info)
         self._def_entity(QAPISchemaEnumType(
             name, info, doc, ifcond, features,
@@ -1227,7 +1234,7 @@ class QAPISchema(Visitable):
     def _make_member(self,
                      name: str,
                      typ: str,
-                     ifcond: Optional[List[str]],
+                     ifcond: Optional[IfCond],
                      features: Optional[List[Dict[str, Any]]],
                      info: QAPISourceInfo) -> QAPISchemaObjectTypeMember:
         optional = False
@@ -1244,7 +1251,7 @@ class QAPISchema(Visitable):
                       data: Dict[str, Dict[str, Any]],
                       info: QAPISourceInfo,
                       ) -> List[QAPISchemaObjectTypeMember]:
-        return [self._make_member(key, value['type'], value.get('if'),
+        return [self._make_member(key, value['type'], IfCond(value.get('if')),
                                   value.get('features'), info)
                 for (key, value) in data.items()]
 
@@ -1255,7 +1262,7 @@ class QAPISchema(Visitable):
         name = expr['struct']
         base = expr.get('base')
         data = expr['data']
-        ifcond = expr.get('if')
+        ifcond = IfCond(expr.get('if'))
         features = self._make_features(expr.get('features'), info)
         self._def_entity(QAPISchemaObjectType(
             name, info, doc, ifcond, features, base,
@@ -1266,14 +1273,14 @@ class QAPISchema(Visitable):
     def _make_variant(cls,
                       case: str,
                       typ: str,
-                      ifcond: Optional[List[str]],
+                      ifcond: Optional[IfCond],
                       info: QAPISourceInfo) -> QAPISchemaVariant:
         return QAPISchemaVariant(case, info, typ, ifcond)
 
     def _make_simple_variant(self,
                              case: str,
                              typ: str,
-                             ifcond: Optional[List[str]],
+                             ifcond: Optional[IfCond],
                              info: QAPISourceInfo) -> QAPISchemaVariant:
         if isinstance(typ, list):
             assert len(typ) == 1
@@ -1290,7 +1297,7 @@ class QAPISchema(Visitable):
         name = expr['union']
         data = expr['data']
         base = expr.get('base')
-        ifcond = expr.get('if')
+        ifcond = IfCond(expr.get('if'))
         features = self._make_features(expr.get('features'), info)
         tag_name = expr.get('discriminator')
         tag_member = None
@@ -1300,12 +1307,12 @@ class QAPISchema(Visitable):
                 'base', self._make_members(base, info))
         if tag_name:
             variants = [self._make_variant(key, value['type'],
-                                           value.get('if'), info)
+                                           IfCond(value.get('if')), info)
                         for (key, value) in data.items()]
             members = []
         else:
             variants = [self._make_simple_variant(key, value['type'],
-                                                  value.get('if'), info)
+                                                  IfCond(value.get('if')), info)
                         for (key, value) in data.items()]
             enum = [{'name': v.name, 'if': v.ifcond} for v in variants]
             typ = self._make_implicit_enum_type(name, info, ifcond, enum)
@@ -1323,9 +1330,9 @@ class QAPISchema(Visitable):
                             doc: QAPIDoc) -> None:
         name = expr['alternate']
         data = expr['data']
-        ifcond = expr.get('if')
+        ifcond = IfCond(expr.get('if'))
         features = self._make_features(expr.get('features'), info)
-        variants = [self._make_variant(key, value['type'], value.get('if'),
+        variants = [self._make_variant(key, value['type'], IfCond(value.get('if')),
                                        info)
                     for (key, value) in data.items()]
         tag_member = QAPISchemaObjectTypeMember('type', info, 'QType', False)
@@ -1347,7 +1354,7 @@ class QAPISchema(Visitable):
         allow_oob = expr.get('allow-oob', False)
         allow_preconfig = expr.get('allow-preconfig', False)
         coroutine = expr.get('coroutine', False)
-        ifcond = expr.get('if')
+        ifcond = IfCond(expr.get('if'))
         features = self._make_features(expr.get('features'), info)
         if isinstance(data, OrderedDict):
             data = self._make_implicit_object_type(
@@ -1369,7 +1376,7 @@ class QAPISchema(Visitable):
         name = expr['event']
         data = expr.get('data')
         boxed = expr.get('boxed', False)
-        ifcond = expr.get('if')
+        ifcond = IfCond(expr.get('if'))
         features = self._make_features(expr.get('features'), info)
         if isinstance(data, OrderedDict):
             data = self._make_implicit_object_type(
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 2b4916cdaa..c15613d13b 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -16,6 +16,7 @@ This work is licensed under the terms of the GNU GPL, version 2.
 from typing import List, Optional
 
 from .common import (
+    IfCond,
     c_enum_const,
     c_name,
     gen_endif,
@@ -139,7 +140,7 @@ def gen_struct_members(members: List[QAPISchemaObjectTypeMember]) -> str:
     return ret
 
 
-def gen_object(name: str, ifcond: List[str],
+def gen_object(name: str, ifcond: IfCond,
                base: Optional[QAPISchemaObjectType],
                members: List[QAPISchemaObjectTypeMember],
                variants: Optional[QAPISchemaVariants]) -> str:
@@ -307,7 +308,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisitor):
     def visit_enum_type(self,
                         name: str,
                         info: Optional[QAPISourceInfo],
-                        ifcond: List[str],
+                        ifcond: IfCond,
                         features: List[QAPISchemaFeature],
                         members: List[QAPISchemaEnumMember],
                         prefix: Optional[str]) -> None:
@@ -318,7 +319,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisitor):
     def visit_array_type(self,
                          name: str,
                          info: Optional[QAPISourceInfo],
-                         ifcond: List[str],
+                         ifcond: IfCond,
                          element_type: QAPISchemaType) -> None:
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.preamble_add(gen_fwd_object_or_array(name))
@@ -328,7 +329,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisitor):
     def visit_object_type(self,
                           name: str,
                           info: Optional[QAPISourceInfo],
-                          ifcond: List[str],
+                          ifcond: IfCond,
                           features: List[QAPISchemaFeature],
                           base: Optional[QAPISchemaObjectType],
                           members: List[QAPISchemaObjectTypeMember],
@@ -351,7 +352,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisitor):
     def visit_alternate_type(self,
                              name: str,
                              info: QAPISourceInfo,
-                             ifcond: List[str],
+                             ifcond: IfCond,
                              features: List[QAPISchemaFeature],
                              variants: QAPISchemaVariants) -> None:
         with ifcontext(ifcond, self._genh):
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 339f152152..d10840bf7b 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -16,6 +16,7 @@ See the COPYING file in the top-level directory.
 from typing import List, Optional
 
 from .common import (
+    IfCond,
     c_enum_const,
     c_name,
     gen_endif,
@@ -337,7 +338,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVisitor):
     def visit_enum_type(self,
                         name: str,
                         info: QAPISourceInfo,
-                        ifcond: List[str],
+                        ifcond: IfCond,
                         features: List[QAPISchemaFeature],
                         members: List[QAPISchemaEnumMember],
                         prefix: Optional[str]) -> None:
@@ -348,7 +349,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVisitor):
     def visit_array_type(self,
                          name: str,
                          info: Optional[QAPISourceInfo],
-                         ifcond: List[str],
+                         ifcond: IfCond,
                          element_type: QAPISchemaType) -> None:
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.add(gen_visit_decl(name))
@@ -357,7 +358,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVisitor):
     def visit_object_type(self,
                           name: str,
                           info: Optional[QAPISourceInfo],
-                          ifcond: List[str],
+                          ifcond: IfCond,
                           features: List[QAPISchemaFeature],
                           base: Optional[QAPISchemaObjectType],
                           members: List[QAPISchemaObjectTypeMember],
@@ -379,7 +380,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVisitor):
     def visit_alternate_type(self,
                              name: str,
                              info: QAPISourceInfo,
-                             ifcond: List[str],
+                             ifcond: IfCond,
                              features: List[QAPISchemaFeature],
                              variants: QAPISchemaVariants) -> None:
         with ifcontext(ifcond, self._genh, self._genc):
-- 
2.28.0


