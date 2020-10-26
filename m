Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA272C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:04:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 417AA21707
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IPSrFs5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 417AA21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX8iy-00047P-Ak
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 16:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kX8P5-00076K-UW
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:43:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23601)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kX8P0-0003BP-ND
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603741412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UaqX6zes8fWQJvF4SbWTPdN5ymaHgrMpHYX+2Td93/I=;
 b=IPSrFs5URf5zBG7C5Ci7Zn0nIms5EcI3GRYe/oo7EyXAnkTBiyWjJFDUZHozhfGTEJlxtM
 Z5mO118QWem2ny4zRBz4cKDEDbEn5uK9RWdwIROdm6ChuMDGWlQul3K8lbZhqKIEF2+fMA
 Ox9Qqo3/RkHUCoGvLZ8bhb13SDz+aJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-Y5RdwOAlNqqRUiJaOeeLmg-1; Mon, 26 Oct 2020 15:43:17 -0400
X-MC-Unique: Y5RdwOAlNqqRUiJaOeeLmg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7F48192AB97
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 19:43:12 +0000 (UTC)
Received: from scv.redhat.com (ovpn-118-238.rdu2.redhat.com [10.10.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 00FC45B4AE;
 Mon, 26 Oct 2020 19:43:11 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 05/11] qapi/introspect.py: add preliminary type hint
 annotations
Date: Mon, 26 Oct 2020 15:42:45 -0400
Message-Id: <20201026194251.11075-6-jsnow@redhat.com>
In-Reply-To: <20201026194251.11075-1-jsnow@redhat.com>
References: <20201026194251.11075-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
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
Cc: John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The typing of _make_tree and friends is a bit involved, but it can be
done with some stubbed out types and a bit of elbow grease. The
forthcoming patches attempt to make some simplifications, but having the
type hints in advance may aid in review of subsequent patches.


Some notes on the abstract types used at this point, and what they
represent:

- TreeValue represents any object in the type tree. _make_tree is an
  optional call -- not every node in the final type tree will have been
  passed to _make_tree, so this type encompasses not only what is passed
  to _make_tree (dicts, strings) or returned from it (dicts, strings, a
  2-tuple), but any recursive value for any of the dicts passed to
  _make_tree -- which includes lists, strings, integers, null constants,
  and so on.

- _DObject is a type alias I use to mean "A JSON-style object,
  represented as a Python dict." There is no "JSON" type in Python, they
  are converted natively to recursively nested dicts and lists, with
  leaf values of str, int, float, None, True/False and so on. This type
  structure is not possible to accurately portray in mypy yet, so a
  placeholder is used.

  In this case, _DObject is being used to refer to SchemaInfo-like
  structures as defined in qapi/introspect.json, OR any sub-object
  values they may reference. We don't have strong typing available for
  those, so a generic alternative is used.

- Extra refers explicitly to the dict containing "extra" information
  about a node in the tree. mypy does not offer per-key typing for dicts
  in Python 3.6, so this is the best we can do here.

- Annotated refers to (one of) the return types of _make_tree:
  It represents a 2-tuple of (TreeValue, Extra).


Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/introspect.py | 157 ++++++++++++++++++++++++++++---------
 scripts/qapi/mypy.ini      |   5 --
 scripts/qapi/schema.py     |   2 +-
 3 files changed, 121 insertions(+), 43 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 63f721ebfb6..803288a64e7 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -10,7 +10,16 @@
 See the COPYING file in the top-level directory.
 """
 
-from typing import Optional, Sequence, cast
+from typing import (
+    Any,
+    Dict,
+    List,
+    Optional,
+    Sequence,
+    Tuple,
+    Union,
+    cast,
+)
 
 from .common import (
     c_name,
@@ -20,13 +29,56 @@
 )
 from .gen import QAPISchemaMonolithicCVisitor
 from .schema import (
+    QAPISchema,
     QAPISchemaArrayType,
     QAPISchemaBuiltinType,
+    QAPISchemaEntity,
+    QAPISchemaEnumMember,
+    QAPISchemaFeature,
+    QAPISchemaObjectType,
+    QAPISchemaObjectTypeMember,
     QAPISchemaType,
+    QAPISchemaVariant,
+    QAPISchemaVariants,
 )
+from .source import QAPISourceInfo
 
 
-def _make_tree(obj, ifcond, features, extra=None):
+# This module constructs a tree-like data structure that is used to
+# generate the introspection information for QEMU. It behaves similarly
+# to a JSON value.
+#
+# A complexity over JSON is that our values may or may not be annotated.
+#
+# Un-annotated values may be:
+#     Scalar: str, bool, None.
+#     Non-scalar: List, Dict
+# _Value = Union[str, bool, None, Dict[str, Value], List[Value]]
+#
+# With optional annotations, the type of all values is:
+# TreeValue = Union[_Value, Annotated[_Value]]
+#
+# Sadly, mypy does not support recursive types, so we must approximate this.
+_stub = Any
+_scalar = Union[str, bool, None]
+_nonscalar = Union[Dict[str, _stub], List[_stub]]
+_value = Union[_scalar, _nonscalar]
+TreeValue = Union[_value, 'Annotated']
+
+# This is just an alias for an object in the structure described above:
+_DObject = Dict[str, object]
+
+# Represents the annotations themselves:
+Annotations = Dict[str, object]
+
+# Represents an annotated node (of some kind).
+Annotated = Tuple[_value, Annotations]
+
+
+def _make_tree(obj: Union[_DObject, str], ifcond: List[str],
+               features: List[QAPISchemaFeature],
+               extra: Optional[Annotations] = None
+               ) -> TreeValue:
     if extra is None:
         extra = {}
     if ifcond:
@@ -39,9 +91,11 @@ def _make_tree(obj, ifcond, features, extra=None):
     return obj
 
 
-def _tree_to_qlit(obj, level=0, suppress_first_indent=False):
+def _tree_to_qlit(obj: TreeValue,
+                  level: int = 0,
+                  suppress_first_indent: bool = False) -> str:
 
-    def indent(level):
+    def indent(level: int) -> str:
         return level * 4 * ' '
 
     if isinstance(obj, tuple):
@@ -91,21 +145,20 @@ def indent(level):
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
+        self._trees: List[TreeValue] = []
+        self._used_types: List[QAPISchemaType] = []
+        self._name_map: Dict[str, str] = {}
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "%(prefix)sqapi-introspect.h"
@@ -113,10 +166,10 @@ def __init__(self, prefix, unmask):
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
@@ -138,18 +191,18 @@ def visit_end(self):
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
@@ -168,8 +221,10 @@ def _use_type(self, typ):
             return '[' + self._use_type(typ.element_type) + ']'
         return self._name(typ.name)
 
-    def _gen_tree(self, name, mtype, obj, ifcond, features):
-        extra = None
+    def _gen_tree(self, name: str, mtype: str, obj: _DObject,
+                  ifcond: List[str],
+                  features: Optional[List[QAPISchemaFeature]]) -> None:
+        extra: Optional[Annotations] = None
         if mtype not in ('command', 'event', 'builtin', 'array'):
             if not self._unmask:
                 # Output a comment to make it easy to map masked names
@@ -180,44 +235,64 @@ def _gen_tree(self, name, mtype, obj, ifcond, features):
         obj['meta-type'] = mtype
         self._trees.append(_make_tree(obj, ifcond, features, extra))
 
-    def _gen_member(self, member):
-        obj = {'name': member.name, 'type': self._use_type(member.type)}
+    def _gen_member(self,
+                    member: QAPISchemaObjectTypeMember) -> TreeValue:
+        obj: _DObject = {
+            'name': member.name,
+            'type': self._use_type(member.type)
+        }
         if member.optional:
             obj['default'] = None
         return _make_tree(obj, member.ifcond, member.features)
 
-    def _gen_variants(self, tag_name, variants):
+    def _gen_variants(self, tag_name: str,
+                      variants: List[QAPISchemaVariant]) -> _DObject:
         return {'tag': tag_name,
                 'variants': [self._gen_variant(v) for v in variants]}
 
-    def _gen_variant(self, variant):
-        obj = {'case': variant.name, 'type': self._use_type(variant.type)}
+    def _gen_variant(self, variant: QAPISchemaVariant) -> TreeValue:
+        obj: _DObject = {
+            'case': variant.name,
+            'type': self._use_type(variant.type)
+        }
         return _make_tree(obj, variant.ifcond, None)
 
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
                        {'values': [_make_tree(m.name, m.ifcond, None)
                                    for m in members]},
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
-        obj = {'members': [self._gen_member(m) for m in members]}
+    def visit_object_type_flat(self, name: str, info: Optional[QAPISourceInfo],
+                               ifcond: List[str],
+                               features: List[QAPISchemaFeature],
+                               members: Sequence[QAPISchemaObjectTypeMember],
+                               variants: Optional[QAPISchemaVariants]) -> None:
+        obj: _DObject = {'members': [self._gen_member(m) for m in members]}
         if variants:
             obj.update(self._gen_variants(variants.tag_member.name,
                                           variants.variants))
 
         self._gen_tree(name, 'object', obj, ifcond, features)
 
-    def visit_alternate_type(self, name, info, ifcond, features, variants):
+    def visit_alternate_type(self, name: str, info: QAPISourceInfo,
+                             ifcond: List[str],
+                             features: List[QAPISchemaFeature],
+                             variants: QAPISchemaVariants) -> None:
         self._gen_tree(name, 'alternate',
                        {'members': [
                            _make_tree({'type': self._use_type(m.type)},
@@ -225,24 +300,32 @@ def visit_alternate_type(self, name, info, ifcond, features, variants):
                            for m in variants.variants]},
                        ifcond, features)
 
-    def visit_command(self, name, info, ifcond, features,
-                      arg_type, ret_type, gen, success_response, boxed,
-                      allow_oob, allow_preconfig, coroutine):
+    def visit_command(self, name: str, info: QAPISourceInfo, ifcond: List[str],
+                      features: List[QAPISchemaFeature],
+                      arg_type: QAPISchemaObjectType,
+                      ret_type: Optional[QAPISchemaType], gen: bool,
+                      success_response: bool, boxed: bool, allow_oob: bool,
+                      allow_preconfig: bool, coroutine: bool) -> None:
         arg_type = arg_type or self._schema.the_empty_object_type
         ret_type = ret_type or self._schema.the_empty_object_type
-        obj = {'arg-type': self._use_type(arg_type),
-               'ret-type': self._use_type(ret_type)}
+        obj: _DObject = {
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
index 74fc6c82153..c0f2a58306d 100644
--- a/scripts/qapi/mypy.ini
+++ b/scripts/qapi/mypy.ini
@@ -14,11 +14,6 @@ disallow_untyped_defs = False
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
index 720449feee4..e91b77fadc3 100644
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


