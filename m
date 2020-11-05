Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58CFC00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:33:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB67E20756
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nx5Xj9Oh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB67E20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaeSM-00074a-Ls
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 07:33:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kaeOA-0002Jj-07
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 07:29:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47916)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kaeO6-0004hD-19
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 07:29:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604579349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tof2tBMzthPwa4iR0tFIwpppn7wfTnmnK4UCmPo+bQQ=;
 b=Nx5Xj9Ohx0Yf0iV7v0NDOC21beHhmVFK77XydcZ+A2WxOqx462obLZbguHmCJZXvbkCiGC
 2WiJt6e7rJYwOPSPrpi8ms/QPRhfx2itv5xTrDLlRgla2j6a/M4xy+f35dS+cDvPNAFrnn
 k9d9V7meFAhNuf5viM+Sy2hdC7ybUi8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-ER81Lf9GM-O-Cazz0MGV7Q-1; Thu, 05 Nov 2020 07:29:06 -0500
X-MC-Unique: ER81Lf9GM-O-Cazz0MGV7Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 246AC8049EC;
 Thu,  5 Nov 2020 12:29:05 +0000 (UTC)
Received: from localhost (unknown [10.36.110.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0230E78801;
 Thu,  5 Nov 2020 12:28:55 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/9] qapi: replace List[str] by QAPISchemaIf
Date: Thu,  5 Nov 2020 16:28:00 +0400
Message-Id: <20201105122808.1182973-2-marcandre.lureau@redhat.com>
In-Reply-To: <20201105122808.1182973-1-marcandre.lureau@redhat.com>
References: <20201105122808.1182973-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Wrap the 'if' condition in a higher-level object. Not only this allows
more type safety but also further refactoring without too much churn.

The following patches will change the syntax of the schema 'if'
conditions to be predicate expressions, and will generate code for
different target languages (C and Rust for now).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/sphinx/qapidoc.py     |   2 +-
 scripts/qapi/commands.py   |   3 +-
 scripts/qapi/events.py     |   3 +-
 scripts/qapi/gen.py        |  19 +++---
 scripts/qapi/introspect.py |  29 +++++----
 scripts/qapi/schema.py     | 118 +++++++++++++++++++++++--------------
 scripts/qapi/types.py      |  31 +++++-----
 scripts/qapi/visit.py      |  21 +++----
 8 files changed, 134 insertions(+), 92 deletions(-)

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
index 50978090b4..c4350eabe5 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -31,6 +31,7 @@ from .gen import (
 from .schema import (
     QAPISchema,
     QAPISchemaFeature,
+    QAPISchemaIf,
     QAPISchemaObjectType,
     QAPISchemaType,
 )
@@ -301,7 +302,7 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
     def visit_command(self,
                       name: str,
                       info: QAPISourceInfo,
-                      ifcond: List[str],
+                      ifcond: QAPISchemaIf,
                       features: List[QAPISchemaFeature],
                       arg_type: Optional[QAPISchemaObjectType],
                       ret_type: Optional[QAPISchemaType],
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index 599f3d1f56..7ad9cc12e3 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -20,6 +20,7 @@ from .schema import (
     QAPISchema,
     QAPISchemaEnumMember,
     QAPISchemaFeature,
+    QAPISchemaIf,
     QAPISchemaObjectType,
 )
 from .source import QAPISourceInfo
@@ -212,7 +213,7 @@ void %(event_emit)s(%(event_enum)s event, QDict *qdict);
     def visit_event(self,
                     name: str,
                     info: QAPISourceInfo,
-                    ifcond: List[str],
+                    ifcond: QAPISchemaIf,
                     features: List[QAPISchemaFeature],
                     arg_type: QAPISchemaObjectType,
                     boxed: bool) -> None:
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index b40f18eee3..b857bb7d5c 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -17,7 +17,6 @@ import re
 from typing import (
     Dict,
     Iterator,
-    List,
     Optional,
     Tuple,
 )
@@ -31,7 +30,11 @@ from .common import (
     guardstart,
     mcgen,
 )
-from .schema import QAPISchemaObjectType, QAPISchemaVisitor
+from .schema import (
+    QAPISchemaIf,
+    QAPISchemaObjectType,
+    QAPISchemaVisitor,
+)
 from .source import QAPISourceInfo
 
 
@@ -81,7 +84,7 @@ class QAPIGen:
                 fp.write(text)
 
 
-def _wrap_ifcond(ifcond: List[str], before: str, after: str) -> str:
+def _wrap_ifcond(ifcond: QAPISchemaIf, before: str, after: str) -> str:
     if before == after:
         return after   # suppress empty #if ... #endif
 
@@ -91,9 +94,9 @@ def _wrap_ifcond(ifcond: List[str], before: str, after: str) -> str:
     if added[0] == '\n':
         out += '\n'
         added = added[1:]
-    out += gen_if(ifcond)
+    out += gen_if(ifcond.ifcond)
     out += added
-    out += gen_endif(ifcond)
+    out += gen_endif(ifcond.ifcond)
     return out
 
 
@@ -123,9 +126,9 @@ def build_params(arg_type: Optional[QAPISchemaObjectType],
 class QAPIGenCCode(QAPIGen):
     def __init__(self, fname: Optional[str]):
         super().__init__(fname)
-        self._start_if: Optional[Tuple[List[str], str, str]] = None
+        self._start_if: Optional[Tuple[QAPISchemaIf, str, str]] = None
 
-    def start_if(self, ifcond: List[str]) -> None:
+    def start_if(self, ifcond: QAPISchemaIf) -> None:
         assert self._start_if is None
         self._start_if = (ifcond, self._body, self._preamble)
 
@@ -186,7 +189,7 @@ class QAPIGenH(QAPIGenC):
 
 
 @contextmanager
-def ifcontext(ifcond: List[str], *args: QAPIGenCCode) -> Iterator[None]:
+def ifcontext(ifcond: QAPISchemaIf, *args: QAPIGenCCode) -> Iterator[None]:
     """
     A with-statement context manager that wraps with `start_if()` / `end_if()`.
 
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 3ae9fbcfbc..58e8433682 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -15,7 +15,6 @@ from typing import (
     Any,
     Dict,
     Generic,
-    Iterable,
     List,
     Optional,
     Sequence,
@@ -37,6 +36,7 @@ from .schema import (
     QAPISchemaEntity,
     QAPISchemaEnumMember,
     QAPISchemaFeature,
+    QAPISchemaIf,
     QAPISchemaObjectType,
     QAPISchemaObjectTypeMember,
     QAPISchemaType,
@@ -81,11 +81,11 @@ class Annotated(Generic[_AnnoType]):
     """
     # Remove after 3.7 adds @dataclass:
     # pylint: disable=too-few-public-methods
-    def __init__(self, value: _AnnoType, ifcond: Iterable[str],
+    def __init__(self, value: _AnnoType, ifcond: QAPISchemaIf,
                  comment: Optional[str] = None):
         self.value = value
         self.comment: Optional[str] = comment
-        self.ifcond: Sequence[str] = tuple(ifcond)
+        self.ifcond = ifcond
 
 
 def _tree_to_qlit(obj: TreeValue, level: int = 0,
@@ -99,10 +99,10 @@ def _tree_to_qlit(obj: TreeValue, level: int = 0,
         if obj.comment:
             ret += indent(level) + '/* %s */\n' % obj.comment
         if obj.ifcond:
-            ret += gen_if(obj.ifcond)
+            ret += gen_if(obj.ifcond.ifcond)
         ret += _tree_to_qlit(obj.value, level)
         if obj.ifcond:
-            ret += '\n' + gen_endif(obj.ifcond)
+            ret += '\n' + gen_endif(obj.ifcond.ifcond)
         return ret
 
     ret = ''
@@ -220,7 +220,7 @@ const QLitObject %(c_name)s = %(c_string)s;
         return [Annotated(f.name, f.ifcond) for f in features]
 
     def _gen_tree(self, name: str, mtype: str, obj: _DObject,
-                  ifcond: List[str],
+                  ifcond: QAPISchemaIf,
                   features: Optional[List[QAPISchemaFeature]]) -> None:
         comment: Optional[str] = None
         if mtype not in ('command', 'event', 'builtin', 'array'):
@@ -261,10 +261,12 @@ const QLitObject %(c_name)s = %(c_string)s;
 
     def visit_builtin_type(self, name: str, info: Optional[QAPISourceInfo],
                            json_type: str) -> None:
-        self._gen_tree(name, 'builtin', {'json-type': json_type}, [], None)
+        self._gen_tree(name, 'builtin', {'json-type': json_type},
+                       QAPISchemaIf(), None)
 
     def visit_enum_type(self, name: str, info: QAPISourceInfo,
-                        ifcond: List[str], features: List[QAPISchemaFeature],
+                        ifcond: QAPISchemaIf,
+                        features: List[QAPISchemaFeature],
                         members: List[QAPISchemaEnumMember],
                         prefix: Optional[str]) -> None:
         self._gen_tree(
@@ -274,14 +276,14 @@ const QLitObject %(c_name)s = %(c_string)s;
         )
 
     def visit_array_type(self, name: str, info: Optional[QAPISourceInfo],
-                         ifcond: List[str],
+                         ifcond: QAPISchemaIf,
                          element_type: QAPISchemaType) -> None:
         element = self._use_type(element_type)
         self._gen_tree('[' + element + ']', 'array', {'element-type': element},
                        ifcond, None)
 
     def visit_object_type_flat(self, name: str, info: Optional[QAPISourceInfo],
-                               ifcond: List[str],
+                               ifcond: QAPISchemaIf,
                                features: List[QAPISchemaFeature],
                                members: Sequence[QAPISchemaObjectTypeMember],
                                variants: Optional[QAPISchemaVariants]) -> None:
@@ -293,7 +295,7 @@ const QLitObject %(c_name)s = %(c_string)s;
         self._gen_tree(name, 'object', obj, ifcond, features)
 
     def visit_alternate_type(self, name: str, info: QAPISourceInfo,
-                             ifcond: List[str],
+                             ifcond: QAPISchemaIf,
                              features: List[QAPISchemaFeature],
                              variants: QAPISchemaVariants) -> None:
         self._gen_tree(
@@ -303,7 +305,8 @@ const QLitObject %(c_name)s = %(c_string)s;
             ifcond, features
         )
 
-    def visit_command(self, name: str, info: QAPISourceInfo, ifcond: List[str],
+    def visit_command(self, name: str, info: QAPISourceInfo,
+                      ifcond: QAPISchemaIf,
                       features: List[QAPISchemaFeature],
                       arg_type: QAPISchemaObjectType,
                       ret_type: Optional[QAPISchemaType], gen: bool,
@@ -320,7 +323,7 @@ const QLitObject %(c_name)s = %(c_string)s;
         self._gen_tree(name, 'command', obj, ifcond, features)
 
     def visit_event(self, name: str, info: QAPISourceInfo,
-                    ifcond: List[str], features: List[QAPISchemaFeature],
+                    ifcond: QAPISchemaIf, features: List[QAPISchemaFeature],
                     arg_type: QAPISchemaObjectType, boxed: bool) -> None:
         arg_type = arg_type or self._schema.the_empty_object_type
         self._gen_tree(name, 'event', {'arg-type': self._use_type(arg_type)},
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index e388b3bced..05763008ae 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -35,6 +35,9 @@ The Python class hierarchy at a glance:
   - `QAPISchemaObjectTypeMember`
 
     - `QAPISchemaVariant`
+
+- `QAPISchemaIf`
+
 """
 # Copyright (c) 2015-2019 Red Hat Inc.
 #
@@ -59,6 +62,7 @@ from typing import (
     Dict,
     List,
     Optional,
+    Sequence,
     Type,
     TypeVar,
     Union,
@@ -81,12 +85,29 @@ class Visitable:
         raise NotImplementedError
 
 
+class QAPISchemaIf:
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
+        if not isinstance(other, QAPISchemaIf):
+            return NotImplemented
+        return self.ifcond == other.ifcond
+
+
 class QAPISchemaEntity(Visitable):
     def __init__(self,
                  name: str,
                  info: Optional[QAPISourceInfo],
                  doc: Optional[QAPIDoc],
-                 ifcond: Optional[Union[List[str], 'QAPISchemaType']] = None,
+                 ifcond: Optional[Union[QAPISchemaIf,
+                                        'QAPISchemaType']] = None,
                  features: Optional[List['QAPISchemaFeature']] = None):
         assert name is None or isinstance(name, str)
 
@@ -103,7 +124,7 @@ class QAPISchemaEntity(Visitable):
         # such place).
         self.info = info
         self.doc = doc
-        self._ifcond = ifcond or []
+        self._ifcond = ifcond or QAPISchemaIf()
         self.features = features or []
         self._checked = False
         self._meta = ''
@@ -148,8 +169,8 @@ class QAPISchemaEntity(Visitable):
         self._set_module(schema, self.info)
 
     @property
-    def ifcond(self) -> List[str]:
-        assert self._checked and isinstance(self._ifcond, list)
+    def ifcond(self) -> QAPISchemaIf:
+        assert self._checked and isinstance(self._ifcond, QAPISchemaIf)
         return self._ifcond
 
     def is_implicit(self) -> bool:
@@ -189,7 +210,7 @@ class QAPISchemaVisitor:
     def visit_enum_type(self,
                         name: str,
                         info: Optional[QAPISourceInfo],
-                        ifcond: List[str],
+                        ifcond: QAPISchemaIf,
                         features: List['QAPISchemaFeature'],
                         members: List['QAPISchemaEnumMember'],
                         prefix: Optional[str]) -> None:
@@ -198,14 +219,14 @@ class QAPISchemaVisitor:
     def visit_array_type(self,
                          name: str,
                          info: Optional[QAPISourceInfo],
-                         ifcond: List[str],
+                         ifcond: QAPISchemaIf,
                          element_type: 'QAPISchemaType') -> None:
         pass
 
     def visit_object_type(self,
                           name: str,
                           info: Optional[QAPISourceInfo],
-                          ifcond: List[str],
+                          ifcond: QAPISchemaIf,
                           features: List['QAPISchemaFeature'],
                           base: Optional['QAPISchemaObjectType'],
                           members: List['QAPISchemaObjectTypeMember'],
@@ -215,7 +236,7 @@ class QAPISchemaVisitor:
     def visit_object_type_flat(self,
                                name: str,
                                info: Optional[QAPISourceInfo],
-                               ifcond: List[str],
+                               ifcond: QAPISchemaIf,
                                features: List['QAPISchemaFeature'],
                                members: List['QAPISchemaObjectTypeMember'],
                                variants: Optional['QAPISchemaVariants'],
@@ -225,7 +246,7 @@ class QAPISchemaVisitor:
     def visit_alternate_type(self,
                              name: str,
                              info: QAPISourceInfo,
-                             ifcond: List[str],
+                             ifcond: QAPISchemaIf,
                              features: List['QAPISchemaFeature'],
                              variants: 'QAPISchemaVariants') -> None:
         pass
@@ -233,7 +254,7 @@ class QAPISchemaVisitor:
     def visit_command(self,
                       name: str,
                       info: QAPISourceInfo,
-                      ifcond: List[str],
+                      ifcond: QAPISchemaIf,
                       features: List['QAPISchemaFeature'],
                       arg_type: 'QAPISchemaObjectType',
                       ret_type: Optional['QAPISchemaType'],
@@ -248,7 +269,7 @@ class QAPISchemaVisitor:
     def visit_event(self,
                     name: str,
                     info: QAPISourceInfo,
-                    ifcond: List[str],
+                    ifcond: QAPISchemaIf,
                     features: List['QAPISchemaFeature'],
                     arg_type: 'QAPISchemaObjectType',
                     boxed: bool) -> None:
@@ -361,7 +382,7 @@ class QAPISchemaEnumType(QAPISchemaType):
                  name: str,
                  info: Optional[QAPISourceInfo],
                  doc: Optional[QAPIDoc],
-                 ifcond: Optional[List[str]],
+                 ifcond: Optional[QAPISchemaIf],
                  features: Optional[List['QAPISchemaFeature']],
                  members: List['QAPISchemaEnumMember'],
                  prefix: Optional[str]):
@@ -427,7 +448,7 @@ class QAPISchemaArrayType(QAPISchemaType):
         self._set_module(schema, self.element_type.info)
 
     @property
-    def ifcond(self) -> List[str]:
+    def ifcond(self) -> QAPISchemaIf:
         assert self._checked
         return self.element_type.ifcond
 
@@ -461,7 +482,7 @@ class QAPISchemaObjectType(QAPISchemaType):
                  name: str,
                  info: Optional[QAPISourceInfo],
                  doc: Optional[QAPIDoc],
-                 ifcond: Optional['QAPISchemaType'],
+                 ifcond: Optional[Union[QAPISchemaIf, 'QAPISchemaType']],
                  features: Optional[List['QAPISchemaFeature']],
                  base: Optional[str],
                  local_members: List['QAPISchemaObjectTypeMember'],
@@ -545,7 +566,7 @@ class QAPISchemaObjectType(QAPISchemaType):
             member.connect_doc(doc)
 
     @property
-    def ifcond(self) -> List[str]:
+    def ifcond(self) -> QAPISchemaIf:
         assert self._checked
         if isinstance(self._ifcond, QAPISchemaType):
             # Simple union wrapper type inherits from wrapped type;
@@ -591,7 +612,7 @@ class QAPISchemaAlternateType(QAPISchemaType):
                  name: str,
                  info: QAPISourceInfo,
                  doc: QAPIDoc,
-                 ifcond: Optional[List[str]],
+                 ifcond: Optional[QAPISchemaIf],
                  features: List['QAPISchemaFeature'],
                  variants: 'QAPISchemaVariants'):
         super().__init__(name, info, doc, ifcond, features)
@@ -725,7 +746,7 @@ class QAPISchemaVariants:
         else:                   # simple union
             assert isinstance(self.tag_member.type, QAPISchemaEnumType)
             assert not self.tag_member.optional
-            assert self.tag_member.ifcond == []
+            assert not self.tag_member.ifcond
         if self._tag_name:    # flat union
             # branches that are not explicitly covered get an empty type
             cases = {v.name for v in self.variants}
@@ -772,11 +793,11 @@ class QAPISchemaMember:
 
     def __init__(self, name: str,
                  info: Optional[QAPISourceInfo],
-                 ifcond: Optional[List[str]] = None):
+                 ifcond: Optional[QAPISchemaIf] = None):
         assert isinstance(name, str)
         self.name = name
         self.info = info
-        self.ifcond = ifcond or []
+        self.ifcond = ifcond or QAPISchemaIf()
         self.defined_in: Optional[str] = None
 
     def set_defined_in(self, name: str) -> None:
@@ -843,7 +864,7 @@ class QAPISchemaObjectTypeMember(QAPISchemaMember):
                  info: QAPISourceInfo,
                  typ: str,
                  optional: bool,
-                 ifcond: Optional[List[str]] = None,
+                 ifcond: Optional[QAPISchemaIf] = None,
                  features: Optional[List[QAPISchemaFeature]] = None):
         super().__init__(name, info, ifcond)
         assert isinstance(typ, str)
@@ -878,7 +899,7 @@ class QAPISchemaVariant(QAPISchemaObjectTypeMember):
                  name: str,
                  info: QAPISourceInfo,
                  typ: str,
-                 ifcond: Optional[List[str]] = None):
+                 ifcond: Optional[QAPISchemaIf] = None):
         super().__init__(name, info, typ, False, ifcond)
 
 
@@ -887,7 +908,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
                  name: str,
                  info: QAPISourceInfo,
                  doc: QAPIDoc,
-                 ifcond: Optional[List[str]],
+                 ifcond: Optional[QAPISchemaIf],
                  features: List[QAPISchemaFeature],
                  arg_type: str,
                  ret_type: Optional[str],
@@ -963,7 +984,7 @@ class QAPISchemaEvent(QAPISchemaEntity):
                  name: str,
                  info: QAPISourceInfo,
                  doc: QAPIDoc,
-                 ifcond: Optional[List[str]],
+                 ifcond: Optional[QAPISchemaIf],
                  features: List[QAPISchemaFeature],
                  arg_type: str,
                  boxed: bool):
@@ -1143,13 +1164,20 @@ class QAPISchema(Visitable):
         self._def_entity(QAPISchemaEnumType('QType', None, None, None, None,
                                             qtype_values, 'QTYPE'))
 
+    @classmethod
+    def _get_if(cls, d: Dict[str, Any]) -> QAPISchemaIf:
+        ifcond = d.get('if')
+        if isinstance(ifcond, QAPISchemaIf):
+            return ifcond
+        return QAPISchemaIf(ifcond)
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
@@ -1157,13 +1185,13 @@ class QAPISchema(Visitable):
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
+                                 ifcond: Optional[QAPISchemaIf],
                                  values: List[Dict[str, Any]]) -> str:
         # See also QAPISchemaObjectTypeMember.describe()
         name = name + 'Kind'    # reserved by check_defn_name_str()
@@ -1184,7 +1212,8 @@ class QAPISchema(Visitable):
     def _make_implicit_object_type(self,
                                    name: str,
                                    info: QAPISourceInfo,
-                                   ifcond: Optional[QAPISchemaType],
+                                   ifcond: Union[QAPISchemaIf,
+                                                 Optional[QAPISchemaType]],
                                    role: str,
                                    members: List[QAPISchemaObjectTypeMember],
                                    ) -> Optional[str]:
@@ -1205,7 +1234,7 @@ class QAPISchema(Visitable):
             # TODO kill simple unions or implement the disjunction
 
             # pylint: disable=protected-access
-            assert (ifcond or []) == typ._ifcond
+            assert ifcond == typ._ifcond
         else:
             self._def_entity(QAPISchemaObjectType(
                 name, info, None, ifcond, None, None, members, None))
@@ -1218,7 +1247,7 @@ class QAPISchema(Visitable):
         name = expr['enum']
         data = expr['data']
         prefix = expr.get('prefix')
-        ifcond = expr.get('if')
+        ifcond = QAPISchemaIf(expr.get('if'))
         features = self._make_features(expr.get('features'), info)
         self._def_entity(QAPISchemaEnumType(
             name, info, doc, ifcond, features,
@@ -1227,7 +1256,7 @@ class QAPISchema(Visitable):
     def _make_member(self,
                      name: str,
                      typ: str,
-                     ifcond: Optional[List[str]],
+                     ifcond: Optional[QAPISchemaIf],
                      features: Optional[List[Dict[str, Any]]],
                      info: QAPISourceInfo) -> QAPISchemaObjectTypeMember:
         optional = False
@@ -1244,7 +1273,8 @@ class QAPISchema(Visitable):
                       data: Dict[str, Dict[str, Any]],
                       info: QAPISourceInfo,
                       ) -> List[QAPISchemaObjectTypeMember]:
-        return [self._make_member(key, value['type'], value.get('if'),
+        return [self._make_member(key, value['type'],
+                                  QAPISchemaIf(value.get('if')),
                                   value.get('features'), info)
                 for (key, value) in data.items()]
 
@@ -1255,7 +1285,7 @@ class QAPISchema(Visitable):
         name = expr['struct']
         base = expr.get('base')
         data = expr['data']
-        ifcond = expr.get('if')
+        ifcond = QAPISchemaIf(expr.get('if'))
         features = self._make_features(expr.get('features'), info)
         self._def_entity(QAPISchemaObjectType(
             name, info, doc, ifcond, features, base,
@@ -1266,14 +1296,14 @@ class QAPISchema(Visitable):
     def _make_variant(cls,
                       case: str,
                       typ: str,
-                      ifcond: Optional[List[str]],
+                      ifcond: Optional[QAPISchemaIf],
                       info: QAPISourceInfo) -> QAPISchemaVariant:
         return QAPISchemaVariant(case, info, typ, ifcond)
 
     def _make_simple_variant(self,
                              case: str,
                              typ: str,
-                             ifcond: Optional[List[str]],
+                             ifcond: Optional[QAPISchemaIf],
                              info: QAPISourceInfo) -> QAPISchemaVariant:
         if isinstance(typ, list):
             assert len(typ) == 1
@@ -1290,7 +1320,7 @@ class QAPISchema(Visitable):
         name = expr['union']
         data = expr['data']
         base = expr.get('base')
-        ifcond = expr.get('if')
+        ifcond = QAPISchemaIf(expr.get('if'))
         features = self._make_features(expr.get('features'), info)
         tag_name = expr.get('discriminator')
         tag_member = None
@@ -1300,13 +1330,14 @@ class QAPISchema(Visitable):
                 'base', self._make_members(base, info))
         if tag_name:
             variants = [self._make_variant(key, value['type'],
-                                           value.get('if'), info)
+                                           QAPISchemaIf(value.get('if')), info)
                         for (key, value) in data.items()]
             members = []
         else:
-            variants = [self._make_simple_variant(key, value['type'],
-                                                  value.get('if'), info)
-                        for (key, value) in data.items()]
+            variants = [self._make_simple_variant(key, val['type'],
+                                                  QAPISchemaIf(val.get('if')),
+                                                  info)
+                        for (key, val) in data.items()]
             enum = [{'name': v.name, 'if': v.ifcond} for v in variants]
             typ = self._make_implicit_enum_type(name, info, ifcond, enum)
             tag_member = QAPISchemaObjectTypeMember('type', info, typ, False)
@@ -1323,9 +1354,10 @@ class QAPISchema(Visitable):
                             doc: QAPIDoc) -> None:
         name = expr['alternate']
         data = expr['data']
-        ifcond = expr.get('if')
+        ifcond = QAPISchemaIf(expr.get('if'))
         features = self._make_features(expr.get('features'), info)
-        variants = [self._make_variant(key, value['type'], value.get('if'),
+        variants = [self._make_variant(key, value['type'],
+                                       QAPISchemaIf(value.get('if')),
                                        info)
                     for (key, value) in data.items()]
         tag_member = QAPISchemaObjectTypeMember('type', info, 'QType', False)
@@ -1347,7 +1379,7 @@ class QAPISchema(Visitable):
         allow_oob = expr.get('allow-oob', False)
         allow_preconfig = expr.get('allow-preconfig', False)
         coroutine = expr.get('coroutine', False)
-        ifcond = expr.get('if')
+        ifcond = QAPISchemaIf(expr.get('if'))
         features = self._make_features(expr.get('features'), info)
         if isinstance(data, OrderedDict):
             data = self._make_implicit_object_type(
@@ -1369,7 +1401,7 @@ class QAPISchema(Visitable):
         name = expr['event']
         data = expr.get('data')
         boxed = expr.get('boxed', False)
-        ifcond = expr.get('if')
+        ifcond = QAPISchemaIf(expr.get('if'))
         features = self._make_features(expr.get('features'), info)
         if isinstance(data, OrderedDict):
             data = self._make_implicit_object_type(
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 2b4916cdaa..9618ad0640 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -27,6 +27,7 @@ from .schema import (
     QAPISchema,
     QAPISchemaEnumMember,
     QAPISchemaFeature,
+    QAPISchemaIf,
     QAPISchemaObjectType,
     QAPISchemaObjectTypeMember,
     QAPISchemaType,
@@ -50,13 +51,13 @@ const QEnumLookup %(c_name)s_lookup = {
 ''',
                 c_name=c_name(name))
     for memb in members:
-        ret += gen_if(memb.ifcond)
+        ret += gen_if(memb.ifcond.ifcond)
         index = c_enum_const(name, memb.name, prefix)
         ret += mcgen('''
         [%(index)s] = "%(name)s",
 ''',
                      index=index, name=memb.name)
-        ret += gen_endif(memb.ifcond)
+        ret += gen_endif(memb.ifcond.ifcond)
 
     ret += mcgen('''
     },
@@ -80,12 +81,12 @@ typedef enum %(c_name)s {
                 c_name=c_name(name))
 
     for memb in enum_members:
-        ret += gen_if(memb.ifcond)
+        ret += gen_if(memb.ifcond.ifcond)
         ret += mcgen('''
     %(c_enum)s,
 ''',
                      c_enum=c_enum_const(name, memb.name, prefix))
-        ret += gen_endif(memb.ifcond)
+        ret += gen_endif(memb.ifcond.ifcond)
 
     ret += mcgen('''
 } %(c_name)s;
@@ -125,7 +126,7 @@ struct %(c_name)s {
 def gen_struct_members(members: List[QAPISchemaObjectTypeMember]) -> str:
     ret = ''
     for memb in members:
-        ret += gen_if(memb.ifcond)
+        ret += gen_if(memb.ifcond.ifcond)
         if memb.optional:
             ret += mcgen('''
     bool has_%(c_name)s;
@@ -135,11 +136,11 @@ def gen_struct_members(members: List[QAPISchemaObjectTypeMember]) -> str:
     %(c_type)s %(c_name)s;
 ''',
                      c_type=memb.type.c_type(), c_name=c_name(memb.name))
-        ret += gen_endif(memb.ifcond)
+        ret += gen_endif(memb.ifcond.ifcond)
     return ret
 
 
-def gen_object(name: str, ifcond: List[str],
+def gen_object(name: str, ifcond: QAPISchemaIf,
                base: Optional[QAPISchemaObjectType],
                members: List[QAPISchemaObjectTypeMember],
                variants: Optional[QAPISchemaVariants]) -> str:
@@ -158,7 +159,7 @@ def gen_object(name: str, ifcond: List[str],
     ret += mcgen('''
 
 ''')
-    ret += gen_if(ifcond)
+    ret += gen_if(ifcond.ifcond)
     ret += mcgen('''
 struct %(c_name)s {
 ''',
@@ -192,7 +193,7 @@ struct %(c_name)s {
     ret += mcgen('''
 };
 ''')
-    ret += gen_endif(ifcond)
+    ret += gen_endif(ifcond.ifcond)
 
     return ret
 
@@ -219,13 +220,13 @@ def gen_variants(variants: QAPISchemaVariants) -> str:
     for var in variants.variants:
         if var.type.name == 'q_empty':
             continue
-        ret += gen_if(var.ifcond)
+        ret += gen_if(var.ifcond.ifcond)
         ret += mcgen('''
         %(c_type)s %(c_name)s;
 ''',
                      c_type=var.type.c_unboxed_type(),
                      c_name=c_name(var.name))
-        ret += gen_endif(var.ifcond)
+        ret += gen_endif(var.ifcond.ifcond)
 
     ret += mcgen('''
     } u;
@@ -307,7 +308,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisitor):
     def visit_enum_type(self,
                         name: str,
                         info: Optional[QAPISourceInfo],
-                        ifcond: List[str],
+                        ifcond: QAPISchemaIf,
                         features: List[QAPISchemaFeature],
                         members: List[QAPISchemaEnumMember],
                         prefix: Optional[str]) -> None:
@@ -318,7 +319,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisitor):
     def visit_array_type(self,
                          name: str,
                          info: Optional[QAPISourceInfo],
-                         ifcond: List[str],
+                         ifcond: QAPISchemaIf,
                          element_type: QAPISchemaType) -> None:
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.preamble_add(gen_fwd_object_or_array(name))
@@ -328,7 +329,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisitor):
     def visit_object_type(self,
                           name: str,
                           info: Optional[QAPISourceInfo],
-                          ifcond: List[str],
+                          ifcond: QAPISchemaIf,
                           features: List[QAPISchemaFeature],
                           base: Optional[QAPISchemaObjectType],
                           members: List[QAPISchemaObjectTypeMember],
@@ -351,7 +352,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisitor):
     def visit_alternate_type(self,
                              name: str,
                              info: QAPISourceInfo,
-                             ifcond: List[str],
+                             ifcond: QAPISchemaIf,
                              features: List[QAPISchemaFeature],
                              variants: QAPISchemaVariants) -> None:
         with ifcontext(ifcond, self._genh):
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 339f152152..d72a749190 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -29,6 +29,7 @@ from .schema import (
     QAPISchemaEnumMember,
     QAPISchemaEnumType,
     QAPISchemaFeature,
+    QAPISchemaIf,
     QAPISchemaObjectType,
     QAPISchemaObjectTypeMember,
     QAPISchemaType,
@@ -77,7 +78,7 @@ bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
                      c_type=base.c_name())
 
     for memb in members:
-        ret += gen_if(memb.ifcond)
+        ret += gen_if(memb.ifcond.ifcond)
         if memb.optional:
             ret += mcgen('''
     if (visit_optional(v, "%(name)s", &obj->has_%(c_name)s)) {
@@ -96,7 +97,7 @@ bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
             ret += mcgen('''
     }
 ''')
-        ret += gen_endif(memb.ifcond)
+        ret += gen_endif(memb.ifcond.ifcond)
 
     if variants:
         tag_member = variants.tag_member
@@ -110,7 +111,7 @@ bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
         for var in variants.variants:
             case_str = c_enum_const(tag_member.type.name, var.name,
                                     tag_member.type.prefix)
-            ret += gen_if(var.ifcond)
+            ret += gen_if(var.ifcond.ifcond)
             if var.type.name == 'q_empty':
                 # valid variant and nothing to do
                 ret += mcgen('''
@@ -126,7 +127,7 @@ bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
                              case=case_str,
                              c_type=var.type.c_name(), c_name=c_name(var.name))
 
-            ret += gen_endif(var.ifcond)
+            ret += gen_endif(var.ifcond.ifcond)
         ret += mcgen('''
     default:
         abort();
@@ -212,7 +213,7 @@ bool visit_type_%(c_name)s(Visitor *v, const char *name,
                 c_name=c_name(name))
 
     for var in variants.variants:
-        ret += gen_if(var.ifcond)
+        ret += gen_if(var.ifcond.ifcond)
         ret += mcgen('''
     case %(case)s:
 ''',
@@ -238,7 +239,7 @@ bool visit_type_%(c_name)s(Visitor *v, const char *name,
         ret += mcgen('''
         break;
 ''')
-        ret += gen_endif(var.ifcond)
+        ret += gen_endif(var.ifcond.ifcond)
 
     ret += mcgen('''
     case QTYPE_NONE:
@@ -337,7 +338,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVisitor):
     def visit_enum_type(self,
                         name: str,
                         info: QAPISourceInfo,
-                        ifcond: List[str],
+                        ifcond: QAPISchemaIf,
                         features: List[QAPISchemaFeature],
                         members: List[QAPISchemaEnumMember],
                         prefix: Optional[str]) -> None:
@@ -348,7 +349,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVisitor):
     def visit_array_type(self,
                          name: str,
                          info: Optional[QAPISourceInfo],
-                         ifcond: List[str],
+                         ifcond: QAPISchemaIf,
                          element_type: QAPISchemaType) -> None:
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.add(gen_visit_decl(name))
@@ -357,7 +358,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVisitor):
     def visit_object_type(self,
                           name: str,
                           info: Optional[QAPISourceInfo],
-                          ifcond: List[str],
+                          ifcond: QAPISchemaIf,
                           features: List[QAPISchemaFeature],
                           base: Optional[QAPISchemaObjectType],
                           members: List[QAPISchemaObjectTypeMember],
@@ -379,7 +380,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVisitor):
     def visit_alternate_type(self,
                              name: str,
                              info: QAPISourceInfo,
-                             ifcond: List[str],
+                             ifcond: QAPISchemaIf,
                              features: List[QAPISchemaFeature],
                              variants: QAPISchemaVariants) -> None:
         with ifcontext(ifcond, self._genh, self._genc):
-- 
2.29.0


