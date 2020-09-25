Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEDDC4346E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:12:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A9B820791
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PNzwIPDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9B820791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLcHT-0002V5-5J
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 21:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLbco-0001a0-KS
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:30:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58024)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLbcj-0000Jc-AY
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:30:10 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600993803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c4feM44XQc0TAE09TT5lNOmorTyE+zBWAge5h2hgu+Q=;
 b=PNzwIPDa7yhvgn/2ke0ACxkCfmc21SMJJhVBUYhQFyVhnubFdR7N9w/+CNeooJLW7gi8Db
 tLZRhkVK/9sRvy+PoB7JkLdxmmipDshpbNjCj6hxv+EoNL9dvfBM9eteW38nS8nc07GDTe
 4nlxBkESuBGdJnwSzn/5/rgD1KxveZw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-6k3vV8uUNR2QaF5mM8sQTA-1; Thu, 24 Sep 2020 20:29:40 -0400
X-MC-Unique: 6k3vV8uUNR2QaF5mM8sQTA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5EA21008550
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 00:29:39 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A16F25D9DD;
 Fri, 25 Sep 2020 00:29:38 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 42/47] qapi/introspect.py: create a typed 'Node' data
 structure
Date: Thu, 24 Sep 2020 20:28:55 -0400
Message-Id: <20200925002900.465855-43-jsnow@redhat.com>
In-Reply-To: <20200925002900.465855-1-jsnow@redhat.com>
References: <20200925002900.465855-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This replaces _make_tree with Node.__init__(), effectively. By creating
it as a generic container, we can more accurately describe the exact
nature of this particular Node.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/introspect.py | 77 +++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 39 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index c444214090..3832edaf9d 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -12,11 +12,12 @@
 
 from typing import (
     Dict,
+    Generic,
+    Iterable,
     List,
     Optional,
     Sequence,
-    Tuple,
-    Union,
+    TypeVar,
 )
 
 from .common import (
@@ -42,42 +43,42 @@
 from .source import QAPISourceInfo
 
 # The correct type for TreeNode is actually:
-# Union[AnnotatedNode, List[TreeNode], Dict[str, TreeNode], str, bool]
+# Union[Node[TreeNode], List[TreeNode], Dict[str, TreeNode], str, bool]
 # but mypy does not support recursive types yet.
 TreeNode = object
+_NodeType = TypeVar('_NodeType', bound=TreeNode)
 _DObject = Dict[str, object]
-Extra = Dict[str, object]
-AnnotatedNode = Tuple[TreeNode, Extra]
 
 
-def _make_tree(obj: Union[_DObject, str], ifcond: List[str],
-               comment: Optional[str] = None) -> AnnotatedNode:
-    extra: Extra = {
-        'if': ifcond,
-        'comment': comment,
-    }
-    return (obj, extra)
+class Node(Generic[_NodeType]):
+    """
+    Node generally contains a SchemaInfo-like type (as a dict),
+    But it also used to wrap comments/ifconds around leaf value types.
+    """
+    # Remove after 3.7 adds @dataclass:
+    # pylint: disable=too-few-public-methods
+    def __init__(self, data: _NodeType, ifcond: Iterable[str],
+                 comment: Optional[str] = None):
+        self.data = data
+        self.comment: Optional[str] = comment
+        self.ifcond: Sequence[str] = tuple(ifcond)
 
 
-def _tree_to_qlit(obj: TreeNode,
-                  level: int = 0,
+def _tree_to_qlit(obj: TreeNode, level: int = 0,
                   suppress_first_indent: bool = False) -> str:
 
     def indent(level: int) -> str:
         return level * 4 * ' '
 
-    if isinstance(obj, tuple):
-        ifobj, extra = obj
-        ifcond = extra.get('if')
-        comment = extra.get('comment')
+    if isinstance(obj, Node):
         ret = ''
-        if comment:
-            ret += indent(level) + '/* %s */\n' % comment
-        if ifcond:
-            ret += gen_if(ifcond)
-        ret += _tree_to_qlit(ifobj, level)
-        if ifcond:
-            ret += '\n' + gen_endif(ifcond)
+        if obj.comment:
+            ret += indent(level) + '/* %s */\n' % obj.comment
+        if obj.ifcond:
+            ret += gen_if(obj.ifcond)
+        ret += _tree_to_qlit(obj.data, level)
+        if obj.ifcond:
+            ret += '\n' + gen_endif(obj.ifcond)
         return ret
 
     ret = ''
@@ -124,7 +125,7 @@ def __init__(self, prefix: str, unmask: bool):
             ' * QAPI/QMP schema introspection', __doc__)
         self._unmask = unmask
         self._schema: Optional[QAPISchema] = None
-        self._trees: List[AnnotatedNode] = []
+        self._trees: List[Node[_DObject]] = []
         self._used_types: List[QAPISchemaType] = []
         self._name_map: Dict[str, str] = {}
         self._genc.add(mcgen('''
@@ -191,9 +192,8 @@ def _use_type(self, typ: QAPISchemaType) -> str:
 
     @classmethod
     def _gen_features(cls,
-                      features: List[QAPISchemaFeature]
-                      ) -> List[AnnotatedNode]:
-        return [_make_tree(f.name, f.ifcond) for f in features]
+                      features: List[QAPISchemaFeature]) -> List[Node[str]]:
+        return [Node(f.name, f.ifcond) for f in features]
 
     def _gen_tree(self, name: str, mtype: str, obj: _DObject,
                   ifcond: List[str],
@@ -209,10 +209,10 @@ def _gen_tree(self, name: str, mtype: str, obj: _DObject,
         obj['meta-type'] = mtype
         if features:
             obj['features'] = self._gen_features(features)
-        self._trees.append(_make_tree(obj, ifcond, comment))
+        self._trees.append(Node(obj, ifcond, comment))
 
     def _gen_member(self,
-                    member: QAPISchemaObjectTypeMember) -> AnnotatedNode:
+                    member: QAPISchemaObjectTypeMember) -> Node[_DObject]:
         obj: _DObject = {
             'name': member.name,
             'type': self._use_type(member.type)
@@ -221,19 +221,19 @@ def _gen_member(self,
             obj['default'] = None
         if member.features:
             obj['features'] = self._gen_features(member.features)
-        return _make_tree(obj, member.ifcond)
+        return Node(obj, member.ifcond)
 
     def _gen_variants(self, tag_name: str,
                       variants: List[QAPISchemaVariant]) -> _DObject:
         return {'tag': tag_name,
                 'variants': [self._gen_variant(v) for v in variants]}
 
-    def _gen_variant(self, variant: QAPISchemaVariant) -> AnnotatedNode:
+    def _gen_variant(self, variant: QAPISchemaVariant) -> Node[_DObject]:
         obj: _DObject = {
             'case': variant.name,
             'type': self._use_type(variant.type)
         }
-        return _make_tree(obj, variant.ifcond)
+        return Node(obj, variant.ifcond)
 
     def visit_builtin_type(self, name: str, info: Optional[QAPISourceInfo],
                            json_type: str) -> None:
@@ -244,8 +244,7 @@ def visit_enum_type(self, name: str, info: QAPISourceInfo,
                         members: List[QAPISchemaEnumMember],
                         prefix: Optional[str]) -> None:
         self._gen_tree(name, 'enum',
-                       {'values': [_make_tree(m.name, m.ifcond, None)
-                                   for m in members]},
+                       {'values': [Node(m.name, m.ifcond) for m in members]},
                        ifcond, features)
 
     def visit_array_type(self, name: str, info: Optional[QAPISourceInfo],
@@ -273,9 +272,9 @@ def visit_alternate_type(self, name: str, info: QAPISourceInfo,
                              variants: QAPISchemaVariants) -> None:
         self._gen_tree(name, 'alternate',
                        {'members': [
-                           _make_tree({'type': self._use_type(m.type)},
-                                      m.ifcond, None)
-                           for m in variants.variants]},
+                           Node({'type': self._use_type(m.type)}, m.ifcond)
+                           for m in variants.variants
+                       ]},
                        ifcond, features)
 
     def visit_command(self, name: str, info: QAPISourceInfo, ifcond: List[str],
-- 
2.26.2


