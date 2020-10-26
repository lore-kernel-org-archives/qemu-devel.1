Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1079C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:00:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44A7420795
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hAtnWDSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A7420795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX8fk-0000vk-2d
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 16:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kX8P5-000760-Da
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:43:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51832)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kX8P3-0003Bl-2t
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603741416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=92mglJF7EP28EAbroH+YcEyPHAhA2QfdRodb5cb2HGU=;
 b=hAtnWDSSqU6PpSi75o8umSWl3w9G2ogIR9DF7q9yPJdJl3zCl1Clok0Xbce766xZGCRYz+
 /Q6MZaulr12+Nrtv0ntozaiQ89qqth0duwwH+c5BMQuEXgzPd9kDHDfu5ij6p5HTR6bUod
 IWMNw/4ajVaLMHS6DDE/F/q4GeTOo3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-yR8N5U-pM6Cpvwhf3cQGnQ-1; Mon, 26 Oct 2020 15:43:29 -0400
X-MC-Unique: yR8N5U-pM6Cpvwhf3cQGnQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EF4FAE572
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 19:43:16 +0000 (UTC)
Received: from scv.redhat.com (ovpn-118-238.rdu2.redhat.com [10.10.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CAC545B4AE;
 Mon, 26 Oct 2020 19:43:15 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 09/11] qapi/introspect.py: create a typed 'Annotated' data
 strutcure
Date: Mon, 26 Oct 2020 15:42:49 -0400
Message-Id: <20201026194251.11075-10-jsnow@redhat.com>
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

This replaces _make_tree with Annotated(). By creating it as a generic
container, we can more accurately describe the exact nature of this
particular value. i.e., each Annotated object is actually an
Annotated<T>, describing its contained value.

This adds stricter typing to Annotated nodes and extra annotated
information. It also replaces a check of "isinstance tuple" with the
much more explicit "isinstance Annotated" which is guaranteed not to
break if a tuple is accidentally introduced into the type tree. (Perhaps
as a result of a bad conversion from a list.)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/introspect.py | 97 +++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 49 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index a0978cb3adb..a261e402d69 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -13,12 +13,13 @@
 from typing import (
     Any,
     Dict,
+    Generic,
+    Iterable,
     List,
     Optional,
     Sequence,
-    Tuple,
+    TypeVar,
     Union,
-    cast,
 )
 
 from .common import (
@@ -63,50 +64,48 @@
 _scalar = Union[str, bool, None]
 _nonscalar = Union[Dict[str, _stub], List[_stub]]
 _value = Union[_scalar, _nonscalar]
-TreeValue = Union[_value, 'Annotated']
+TreeValue = Union[_value, 'Annotated[_value]']
 
 # This is just an alias for an object in the structure described above:
 _DObject = Dict[str, object]
 
-# Represents the annotations themselves:
-Annotations = Dict[str, object]
 
-# Represents an annotated node (of some kind).
-Annotated = Tuple[_value, Annotations]
+_AnnoType = TypeVar('_AnnoType', bound=TreeValue)
 
 
-def _make_tree(obj: Union[_DObject, str], ifcond: List[str],
-               comment: Optional[str] = None) -> Annotated:
-    extra: Annotations = {
-        'if': ifcond,
-        'comment': comment,
-    }
-    return (obj, extra)
+class Annotated(Generic[_AnnoType]):
+    """
+    Annotated generally contains a SchemaInfo-like type (as a dict),
+    But it also used to wrap comments/ifconds around scalar leaf values,
+    for the benefit of features and enums.
+    """
+    # Remove after 3.7 adds @dataclass:
+    # pylint: disable=too-few-public-methods
+    def __init__(self, value: _AnnoType, ifcond: Iterable[str],
+                 comment: Optional[str] = None):
+        self.value = value
+        self.comment: Optional[str] = comment
+        self.ifcond: Sequence[str] = tuple(ifcond)
 
 
-def _tree_to_qlit(obj: TreeValue,
-                  level: int = 0,
+def _tree_to_qlit(obj: TreeValue, level: int = 0,
                   suppress_first_indent: bool = False) -> str:
 
     def indent(level: int) -> str:
         return level * 4 * ' '
 
-    if isinstance(obj, tuple):
-        ifobj, extra = obj
-        ifcond = cast(Optional[Sequence[str]], extra.get('if'))
-        comment = extra.get('comment')
-
+    if isinstance(obj, Annotated):
         msg = "Comments and Conditionals not implemented for dict values"
-        assert not (suppress_first_indent and (ifcond or comment)), msg
+        assert not (suppress_first_indent and (obj.comment or obj.ifcond)), msg
 
         ret = ''
-        if comment:
-            ret += indent(level) + '/* %s */\n' % comment
-        if ifcond:
-            ret += gen_if(ifcond)
-        ret += _tree_to_qlit(ifobj, level, suppress_first_indent)
-        if ifcond:
-            ret += '\n' + gen_endif(ifcond)
+        if obj.comment:
+            ret += indent(level) + '/* %s */\n' % obj.comment
+        if obj.ifcond:
+            ret += gen_if(obj.ifcond)
+        ret += _tree_to_qlit(obj.value, level, suppress_first_indent)
+        if obj.ifcond:
+            ret += '\n' + gen_endif(obj.ifcond)
         return ret
 
     ret = ''
@@ -153,7 +152,7 @@ def __init__(self, prefix: str, unmask: bool):
             ' * QAPI/QMP schema introspection', __doc__)
         self._unmask = unmask
         self._schema: Optional[QAPISchema] = None
-        self._trees: List[Annotated] = []
+        self._trees: List[Annotated[_DObject]] = []
         self._used_types: List[QAPISchemaType] = []
         self._name_map: Dict[str, str] = {}
         self._genc.add(mcgen('''
@@ -219,10 +218,9 @@ def _use_type(self, typ: QAPISchemaType) -> str:
         return self._name(typ.name)
 
     @classmethod
-    def _gen_features(cls,
-                      features: List[QAPISchemaFeature]
-                      ) -> List[Annotated]:
-        return [_make_tree(f.name, f.ifcond) for f in features]
+    def _gen_features(
+            cls, features: List[QAPISchemaFeature]) -> List[Annotated[str]]:
+        return [Annotated(f.name, f.ifcond) for f in features]
 
     def _gen_tree(self, name: str, mtype: str, obj: _DObject,
                   ifcond: List[str],
@@ -238,10 +236,10 @@ def _gen_tree(self, name: str, mtype: str, obj: _DObject,
         obj['meta-type'] = mtype
         if features:
             obj['features'] = self._gen_features(features)
-        self._trees.append(_make_tree(obj, ifcond, comment))
+        self._trees.append(Annotated(obj, ifcond, comment))
 
     def _gen_member(self,
-                    member: QAPISchemaObjectTypeMember) -> Annotated:
+                    member: QAPISchemaObjectTypeMember) -> Annotated[_DObject]:
         obj: _DObject = {
             'name': member.name,
             'type': self._use_type(member.type)
@@ -250,19 +248,19 @@ def _gen_member(self,
             obj['default'] = None
         if member.features:
             obj['features'] = self._gen_features(member.features)
-        return _make_tree(obj, member.ifcond)
+        return Annotated(obj, member.ifcond)
 
     def _gen_variants(self, tag_name: str,
                       variants: List[QAPISchemaVariant]) -> _DObject:
         return {'tag': tag_name,
                 'variants': [self._gen_variant(v) for v in variants]}
 
-    def _gen_variant(self, variant: QAPISchemaVariant) -> Annotated:
+    def _gen_variant(self, variant: QAPISchemaVariant) -> Annotated[_DObject]:
         obj: _DObject = {
             'case': variant.name,
             'type': self._use_type(variant.type)
         }
-        return _make_tree(obj, variant.ifcond)
+        return Annotated(obj, variant.ifcond)
 
     def visit_builtin_type(self, name: str, info: Optional[QAPISourceInfo],
                            json_type: str) -> None:
@@ -272,10 +270,11 @@ def visit_enum_type(self, name: str, info: QAPISourceInfo,
                         ifcond: List[str], features: List[QAPISchemaFeature],
                         members: List[QAPISchemaEnumMember],
                         prefix: Optional[str]) -> None:
-        self._gen_tree(name, 'enum',
-                       {'values': [_make_tree(m.name, m.ifcond, None)
-                                   for m in members]},
-                       ifcond, features)
+        self._gen_tree(
+            name, 'enum',
+            {'values': [Annotated(m.name, m.ifcond) for m in members]},
+            ifcond, features
+        )
 
     def visit_array_type(self, name: str, info: Optional[QAPISourceInfo],
                          ifcond: List[str],
@@ -300,12 +299,12 @@ def visit_alternate_type(self, name: str, info: QAPISourceInfo,
                              ifcond: List[str],
                              features: List[QAPISchemaFeature],
                              variants: QAPISchemaVariants) -> None:
-        self._gen_tree(name, 'alternate',
-                       {'members': [
-                           _make_tree({'type': self._use_type(m.type)},
-                                      m.ifcond, None)
-                           for m in variants.variants]},
-                       ifcond, features)
+        self._gen_tree(
+            name, 'alternate',
+            {'members': [Annotated({'type': self._use_type(m.type)}, m.ifcond)
+                         for m in variants.variants]},
+            ifcond, features
+        )
 
     def visit_command(self, name: str, info: QAPISourceInfo, ifcond: List[str],
                       features: List[QAPISchemaFeature],
-- 
2.26.2


