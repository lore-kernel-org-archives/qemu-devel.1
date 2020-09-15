Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746D4C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 23:10:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7966206A4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 23:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lp0bnw9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7966206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIK6D-0000dp-QM
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 19:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIJeF-0007sA-6Q
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 18:42:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38900)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIJeB-0002kn-17
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 18:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600209713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xucmwj4tTAsCtD3L6ZQ+AzD7cuIGftAw1H06DI/YQvk=;
 b=Lp0bnw9nImKshJ6xJiL8lVeX8stX5xaTV4q90polP5YniwmDiG7tL8cVJjON6AR2mR6Tgn
 eNZx3VoyPK7I/Kw4n+ORwxXMrATNSS/OLEEpLyifsXyuWl+jTCnP8tRB9bGFkHw3IZ66D/
 jPU0lzcQCC4xHKWZkesAsa+VAWeA8vI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-scKJAXX3PKuApur3Drw4kg-1; Tue, 15 Sep 2020 18:41:27 -0400
X-MC-Unique: scKJAXX3PKuApur3Drw4kg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56E49190A3ED;
 Tue, 15 Sep 2020 22:41:23 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71AC060BE5;
 Tue, 15 Sep 2020 22:41:22 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 33/37] qapi/introspect.py: add notational type hints
Date: Tue, 15 Sep 2020 18:40:23 -0400
Message-Id: <20200915224027.2529813-34-jsnow@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:10:32
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

Add a tiny hint into schema.py to allow introspect.py to type check, too.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/introspect.py | 123 ++++++++++++++++++++++++++-----------
 scripts/qapi/mypy.ini      |   5 --
 scripts/qapi/schema.py     |   2 +-
 3 files changed, 87 insertions(+), 43 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index e0f5007ab7..4e1ea3a00c 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -10,7 +10,16 @@
 See the COPYING file in the top-level directory.
 """
 
-from typing import (NamedTuple, List, Optional, Sequence)
+from typing import (
+    Any,
+    Dict,
+    Generic,
+    List,
+    NamedTuple,
+    Optional,
+    Sequence,
+    TypeVar,
+)
 
 from .common import (
     c_name,
@@ -19,8 +28,23 @@
     mcgen,
 )
 from .gen import QAPISchemaMonolithicCVisitor
-from .schema import (QAPISchemaArrayType, QAPISchemaBuiltinType,
-                     QAPISchemaFeature, QAPISchemaType)
+from .schema import (
+    QAPISchema,
+    QAPISchemaArrayType,
+    QAPISchemaBuiltinType,
+    QAPISchemaEntity,
+    QAPISchemaEnumMember,
+    QAPISchemaFeature,
+    QAPISchemaObjectType,
+    QAPISchemaObjectTypeMember,
+    QAPISchemaType,
+    QAPISchemaVariant,
+    QAPISchemaVariants,
+)
+from .source import QAPISourceInfo
+
+
+_NodeType = TypeVar('_NodeType')
 
 
 class Extra(NamedTuple):
@@ -31,23 +55,24 @@ class Extra(NamedTuple):
     ifcond: Sequence[str] = tuple()
 
 
-class Node:
+class Node(Generic[_NodeType]):
     """
     Node generally contains a SchemaInfo-like type (as a dict),
     But it also used to wrap comments/ifconds around leaf value types.
     """
     # Remove after 3.7 adds @dataclass:
     # pylint: disable=too-few-public-methods
-    def __init__(self, data, ifcond: List[str],
+    def __init__(self, data: _NodeType, ifcond: List[str],
                  extra: Optional[Extra] = None):
         self.data = data
         comment = extra.comment if extra else None
         self.extra = Extra(comment, ifcond)
 
 
-def _tree_to_qlit(obj, level=0, suppress_first_indent=False):
+def _tree_to_qlit(obj: Any, level: int = 0,
+                  suppress_first_indent: bool = False) -> str:
 
-    def indent(level):
+    def indent(level: int) -> str:
         return level * 4 * ' '
 
     if isinstance(obj, Node):
@@ -94,21 +119,20 @@ def indent(level):
     return ret
 
 
-def to_c_string(string):
+def to_c_string(string: str) -> str:
     return '"' + string.replace('\\', r'\\').replace('"', r'\"') + '"'
 
 
 class QAPISchemaGenIntrospectVisitor(QAPISchemaMonolithicCVisitor):
-
-    def __init__(self, prefix, unmask):
+    def __init__(self, prefix: str, unmask: bool):
         super().__init__(
             prefix, 'qapi-introspect',
             ' * QAPI/QMP schema introspection', __doc__)
         self._unmask = unmask
-        self._schema = None
-        self._trees = []
-        self._used_types = []
-        self._name_map = {}
+        self._schema: Optional[QAPISchema] = None
+        self._trees: List[Node[Dict[str, Any]]] = []
+        self._used_types: List[QAPISchemaType] = []
+        self._name_map: Dict[str, str] = {}
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "%(prefix)sqapi-introspect.h"
@@ -116,10 +140,10 @@ def __init__(self, prefix, unmask):
 ''',
                              prefix=prefix))
 
-    def visit_begin(self, schema):
+    def visit_begin(self, schema: QAPISchema) -> None:
         self._schema = schema
 
-    def visit_end(self):
+    def visit_end(self) -> None:
         # visit the types that are actually used
         for typ in self._used_types:
             typ.visit(self)
@@ -141,18 +165,18 @@ def visit_end(self):
         self._used_types = []
         self._name_map = {}
 
-    def visit_needed(self, entity):
+    def visit_needed(self, entity: QAPISchemaEntity) -> bool:
         # Ignore types on first pass; visit_end() will pick up used types
         return not isinstance(entity, QAPISchemaType)
 
-    def _name(self, name):
+    def _name(self, name: str) -> str:
         if self._unmask:
             return name
         if name not in self._name_map:
             self._name_map[name] = '%d' % len(self._name_map)
         return self._name_map[name]
 
-    def _use_type(self, typ):
+    def _use_type(self, typ: QAPISchemaType) -> str:
         # Map the various integer types to plain int
         if typ.json_type() == 'int':
             typ = self._schema.lookup_type('int')
@@ -172,10 +196,13 @@ def _use_type(self, typ):
         return self._name(typ.name)
 
     @classmethod
-    def _gen_features(cls, features: List[QAPISchemaFeature]):
+    def _gen_features(cls,
+                      features: List[QAPISchemaFeature]) -> List[Node[str]]:
         return [Node(f.name, f.ifcond) for f in features]
 
-    def _gen_tree(self, name, mtype, obj, ifcond, features):
+    def _gen_tree(self, name: str, mtype: str, obj: Dict[str, Any],
+                  ifcond: List[str],
+                  features: Optional[List[QAPISchemaFeature]]) -> None:
         extra = None
         if mtype not in ('command', 'event', 'builtin', 'array'):
             if not self._unmask:
@@ -189,7 +216,8 @@ def _gen_tree(self, name, mtype, obj, ifcond, features):
             obj['features'] = self._gen_features(features)
         self._trees.append(Node(obj, ifcond, extra))
 
-    def _gen_member(self, member):
+    def _gen_member(self, member: QAPISchemaObjectTypeMember,
+                    ) -> Node[Dict[str, Any]]:
         obj = {'name': member.name, 'type': self._use_type(member.type)}
         if member.optional:
             obj['default'] = None
@@ -197,29 +225,39 @@ def _gen_member(self, member):
             obj['features'] = self._gen_features(member.features)
         return Node(obj, member.ifcond)
 
-    def _gen_variants(self, tag_name, variants):
+    def _gen_variants(self, tag_name: str,
+                      variants: List[QAPISchemaVariant]) -> Dict[str, Any]:
         return {'tag': tag_name,
                 'variants': [self._gen_variant(v) for v in variants]}
 
-    def _gen_variant(self, variant):
+    def _gen_variant(self, variant: QAPISchemaVariant) -> Node[Dict[str, Any]]:
         obj = {'case': variant.name, 'type': self._use_type(variant.type)}
         return Node(obj, variant.ifcond)
 
-    def visit_builtin_type(self, name, info, json_type):
+    def visit_builtin_type(self, name: str, info: Optional[QAPISourceInfo],
+                           json_type: str) -> None:
         self._gen_tree(name, 'builtin', {'json-type': json_type}, [], None)
 
-    def visit_enum_type(self, name, info, ifcond, features, members, prefix):
+    def visit_enum_type(self, name: str, info: QAPISourceInfo,
+                        ifcond: List[str], features: List[QAPISchemaFeature],
+                        members: List[QAPISchemaEnumMember],
+                        prefix: Optional[str]) -> None:
         self._gen_tree(name, 'enum',
                        {'values': [Node(m.name, m.ifcond) for m in members]},
                        ifcond, features)
 
-    def visit_array_type(self, name, info, ifcond, element_type):
+    def visit_array_type(self, name: str, info: Optional[QAPISourceInfo],
+                         ifcond: List[str],
+                         element_type: QAPISchemaType) -> None:
         element = self._use_type(element_type)
         self._gen_tree('[' + element + ']', 'array', {'element-type': element},
                        ifcond, None)
 
-    def visit_object_type_flat(self, name, info, ifcond, features,
-                               members, variants):
+    def visit_object_type_flat(self, name: str, info: Optional[QAPISourceInfo],
+                               ifcond: List[str],
+                               features: List[QAPISchemaFeature],
+                               members: Sequence[QAPISchemaObjectTypeMember],
+                               variants: Optional[QAPISchemaVariants]) -> None:
         obj = {'members': [self._gen_member(m) for m in members]}
         if variants:
             obj.update(self._gen_variants(variants.tag_member.name,
@@ -227,7 +265,10 @@ def visit_object_type_flat(self, name, info, ifcond, features,
 
         self._gen_tree(name, 'object', obj, ifcond, features)
 
-    def visit_alternate_type(self, name, info, ifcond, features, variants):
+    def visit_alternate_type(self, name: str, info: QAPISourceInfo,
+                             ifcond: List[str],
+                             features: List[QAPISchemaFeature],
+                             variants: QAPISchemaVariants) -> None:
         self._gen_tree(name, 'alternate',
                        {'members': [
                            Node({'type': self._use_type(m.type)}, m.ifcond)
@@ -235,24 +276,32 @@ def visit_alternate_type(self, name, info, ifcond, features, variants):
                        ]},
                        ifcond, features)
 
-    def visit_command(self, name, info, ifcond, features,
-                      arg_type, ret_type, gen, success_response, boxed,
-                      allow_oob, allow_preconfig):
+    def visit_command(self, name: str, info: QAPISourceInfo, ifcond: List[str],
+                      features: List[QAPISchemaFeature],
+                      arg_type: QAPISchemaObjectType,
+                      ret_type: Optional[QAPISchemaObjectType], gen: bool,
+                      success_response: bool, boxed: bool, allow_oob: bool,
+                      allow_preconfig: bool) -> None:
         arg_type = arg_type or self._schema.the_empty_object_type
         ret_type = ret_type or self._schema.the_empty_object_type
-        obj = {'arg-type': self._use_type(arg_type),
-               'ret-type': self._use_type(ret_type)}
+        obj: Dict[str, Any] = {
+            'arg-type': self._use_type(arg_type),
+            'ret-type': self._use_type(ret_type)
+        }
         if allow_oob:
             obj['allow-oob'] = allow_oob
         self._gen_tree(name, 'command', obj, ifcond, features)
 
-    def visit_event(self, name, info, ifcond, features, arg_type, boxed):
+    def visit_event(self, name: str, info: QAPISourceInfo,
+                    ifcond: List[str], features: List[QAPISchemaFeature],
+                    arg_type: QAPISchemaObjectType, boxed: bool) -> None:
         arg_type = arg_type or self._schema.the_empty_object_type
         self._gen_tree(name, 'event', {'arg-type': self._use_type(arg_type)},
                        ifcond, features)
 
 
-def gen_introspect(schema, output_dir, prefix, opt_unmask):
+def gen_introspect(schema: QAPISchema, output_dir: str, prefix: str,
+                   opt_unmask: bool) -> None:
     vis = QAPISchemaGenIntrospectVisitor(prefix, opt_unmask)
     schema.visit(vis)
     vis.write(output_dir)
diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
index dbfeda748c..9ce8b56f22 100644
--- a/scripts/qapi/mypy.ini
+++ b/scripts/qapi/mypy.ini
@@ -19,11 +19,6 @@ disallow_untyped_defs = False
 disallow_incomplete_defs = False
 check_untyped_defs = False
 
-[mypy-qapi.introspect]
-disallow_untyped_defs = False
-disallow_incomplete_defs = False
-check_untyped_defs = False
-
 [mypy-qapi.parser]
 disallow_untyped_defs = False
 disallow_incomplete_defs = False
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index bb0cd717f1..3023bab44b 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -28,7 +28,7 @@
 class QAPISchemaEntity:
     meta: Optional[str] = None
 
-    def __init__(self, name, info, doc, ifcond=None, features=None):
+    def __init__(self, name: str, info, doc, ifcond=None, features=None):
         assert name is None or isinstance(name, str)
         for f in features or []:
             assert isinstance(f, QAPISchemaFeature)
-- 
2.26.2


