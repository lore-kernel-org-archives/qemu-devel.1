Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EE2C4346E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 450EF2076B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GrwJb2n1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 450EF2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLcDA-0003pJ-3D
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 21:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLbcg-0001SB-2S
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:30:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24989)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLbcO-0000EZ-2W
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:30:01 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600993783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f3I4s027hY+ozWCqvcEkSGKNZAS5AIhk2nyKtWVfHo8=;
 b=GrwJb2n1MUhtBg0/PYYwJhKWAIAmi7c9SOHpVUCvzQ1zCr6llOpcSWn3X5FneRnQfrGCPo
 SHOorIdwJHJ2ycvKmGTuzFJHbd1xdnQNzr/s97aB9kIm+0v347mrOk8bvZ7khyx4jqdVLj
 Wv/AC46cCDTOYauKbAAGRVJpNWZrOuU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-uPPyDh2rOuWkHOWhPlDIdQ-1; Thu, 24 Sep 2020 20:29:41 -0400
X-MC-Unique: uPPyDh2rOuWkHOWhPlDIdQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF2BA1008548
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 00:29:40 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CDA2E5D9DD;
 Fri, 25 Sep 2020 00:29:39 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 43/47] qapi/types.py: add type hint annotations
Date: Thu, 24 Sep 2020 20:28:56 -0400
Message-Id: <20200925002900.465855-44-jsnow@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
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

Annotations do not change runtime behavior.
This commit *only* adds annotations.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/qapi/mypy.ini |  5 ---
 scripts/qapi/types.py | 86 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 64 insertions(+), 27 deletions(-)

diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
index 9ce8b56f22..3babc380a8 100644
--- a/scripts/qapi/mypy.ini
+++ b/scripts/qapi/mypy.ini
@@ -29,11 +29,6 @@ disallow_untyped_defs = False
 disallow_incomplete_defs = False
 check_untyped_defs = False
 
-[mypy-qapi.types]
-disallow_untyped_defs = False
-disallow_incomplete_defs = False
-check_untyped_defs = False
-
 [mypy-qapi.visit]
 disallow_untyped_defs = False
 disallow_incomplete_defs = False
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index cc6dad4c89..b65188bac3 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -13,6 +13,8 @@
 # See the COPYING file in the top-level directory.
 """
 
+from typing import List, Optional
+
 from .common import (
     c_enum_const,
     c_name,
@@ -21,14 +23,25 @@
     mcgen,
 )
 from .gen import QAPISchemaModularCVisitor, ifcontext
-from .schema import QAPISchemaEnumMember, QAPISchemaObjectType
+from .schema import (
+    QAPISchema,
+    QAPISchemaEnumMember,
+    QAPISchemaFeature,
+    QAPISchemaObjectType,
+    QAPISchemaObjectTypeMember,
+    QAPISchemaType,
+    QAPISchemaVariants,
+)
+from .source import QAPISourceInfo
 
 # variants must be emitted before their container; track what has already
 # been output
 objects_seen = set()
 
 
-def gen_enum_lookup(name, members, prefix=None):
+def gen_enum_lookup(name: str,
+                    members: List[QAPISchemaEnumMember],
+                    prefix: Optional[str] = None) -> str:
     ret = mcgen('''
 
 const QEnumLookup %(c_name)s_lookup = {
@@ -53,7 +66,9 @@ def gen_enum_lookup(name, members, prefix=None):
     return ret
 
 
-def gen_enum(name, members, prefix=None):
+def gen_enum(name: str,
+             members: List[QAPISchemaEnumMember],
+             prefix: Optional[str] = None) -> str:
     # append automatically generated _MAX value
     enum_members = members + [QAPISchemaEnumMember('_MAX', None)]
 
@@ -87,7 +102,7 @@ def gen_enum(name, members, prefix=None):
     return ret
 
 
-def gen_fwd_object_or_array(name):
+def gen_fwd_object_or_array(name: str) -> str:
     return mcgen('''
 
 typedef struct %(c_name)s %(c_name)s;
@@ -95,7 +110,7 @@ def gen_fwd_object_or_array(name):
                  c_name=c_name(name))
 
 
-def gen_array(name, element_type):
+def gen_array(name: str, element_type: QAPISchemaType) -> str:
     return mcgen('''
 
 struct %(c_name)s {
@@ -106,7 +121,7 @@ def gen_array(name, element_type):
                  c_name=c_name(name), c_type=element_type.c_type())
 
 
-def gen_struct_members(members):
+def gen_struct_members(members: List[QAPISchemaObjectTypeMember]) -> str:
     ret = ''
     for memb in members:
         ret += gen_if(memb.ifcond)
@@ -123,7 +138,10 @@ def gen_struct_members(members):
     return ret
 
 
-def gen_object(name, ifcond, base, members, variants):
+def gen_object(name: str, ifcond: List[str],
+               base: Optional[QAPISchemaObjectType],
+               members: List[QAPISchemaObjectTypeMember],
+               variants: Optional[QAPISchemaVariants]) -> str:
     if name in objects_seen:
         return ''
     objects_seen.add(name)
@@ -177,7 +195,7 @@ def gen_object(name, ifcond, base, members, variants):
     return ret
 
 
-def gen_upcast(name, base):
+def gen_upcast(name: str, base: QAPISchemaObjectType) -> str:
     # C makes const-correctness ugly.  We have to cast away const to let
     # this function work for both const and non-const obj.
     return mcgen('''
@@ -190,7 +208,7 @@ def gen_upcast(name, base):
                  c_name=c_name(name), base=base.c_name())
 
 
-def gen_variants(variants):
+def gen_variants(variants: QAPISchemaVariants) -> str:
     ret = mcgen('''
     union { /* union tag is @%(c_name)s */
 ''',
@@ -214,7 +232,7 @@ def gen_variants(variants):
     return ret
 
 
-def gen_type_cleanup_decl(name):
+def gen_type_cleanup_decl(name: str) -> str:
     ret = mcgen('''
 
 void qapi_free_%(c_name)s(%(c_name)s *obj);
@@ -224,7 +242,7 @@ def gen_type_cleanup_decl(name):
     return ret
 
 
-def gen_type_cleanup(name):
+def gen_type_cleanup(name: str) -> str:
     ret = mcgen('''
 
 void qapi_free_%(c_name)s(%(c_name)s *obj)
@@ -246,12 +264,12 @@ def gen_type_cleanup(name):
 
 class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisitor):
 
-    def __init__(self, prefix):
+    def __init__(self, prefix: str):
         super().__init__(
             prefix, 'qapi-types', ' * Schema-defined QAPI types',
             ' * Built-in QAPI types', __doc__)
 
-    def _begin_system_module(self, name):
+    def _begin_system_module(self, name: None) -> None:
         self._genc.preamble_add(mcgen('''
 #include "qemu/osdep.h"
 #include "qapi/dealloc-visitor.h"
@@ -262,7 +280,7 @@ def _begin_system_module(self, name):
 #include "qapi/util.h"
 '''))
 
-    def _begin_user_module(self, name):
+    def _begin_user_module(self, name: str) -> None:
         types = self._module_basename('qapi-types', name)
         visit = self._module_basename('qapi-visit', name)
         self._genc.preamble_add(mcgen('''
@@ -276,27 +294,43 @@ def _begin_user_module(self, name):
 #include "qapi/qapi-builtin-types.h"
 '''))
 
-    def visit_begin(self, schema):
+    def visit_begin(self, schema: QAPISchema) -> None:
         # gen_object() is recursive, ensure it doesn't visit the empty type
         objects_seen.add(schema.the_empty_object_type.name)
 
-    def _gen_type_cleanup(self, name):
+    def _gen_type_cleanup(self, name: str) -> None:
         self._genh.add(gen_type_cleanup_decl(name))
         self._genc.add(gen_type_cleanup(name))
 
-    def visit_enum_type(self, name, info, ifcond, features, members, prefix):
+    def visit_enum_type(self,
+                        name: str,
+                        info: Optional[QAPISourceInfo],
+                        ifcond: List[str],
+                        features: List[QAPISchemaFeature],
+                        members: List[QAPISchemaEnumMember],
+                        prefix: Optional[str]) -> None:
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.preamble_add(gen_enum(name, members, prefix))
             self._genc.add(gen_enum_lookup(name, members, prefix))
 
-    def visit_array_type(self, name, info, ifcond, element_type):
+    def visit_array_type(self,
+                         name: str,
+                         info: Optional[QAPISourceInfo],
+                         ifcond: List[str],
+                         element_type: QAPISchemaType) -> None:
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.preamble_add(gen_fwd_object_or_array(name))
             self._genh.add(gen_array(name, element_type))
             self._gen_type_cleanup(name)
 
-    def visit_object_type(self, name, info, ifcond, features,
-                          base, members, variants):
+    def visit_object_type(self,
+                          name: str,
+                          info: Optional[QAPISourceInfo],
+                          ifcond: List[str],
+                          features: List[QAPISchemaFeature],
+                          base: Optional[QAPISchemaObjectType],
+                          members: List[QAPISchemaObjectTypeMember],
+                          variants: Optional[QAPISchemaVariants]) -> None:
         # Nothing to do for the special empty builtin
         if name == 'q_empty':
             return
@@ -312,7 +346,12 @@ def visit_object_type(self, name, info, ifcond, features,
                 # implicit types won't be directly allocated/freed
                 self._gen_type_cleanup(name)
 
-    def visit_alternate_type(self, name, info, ifcond, features, variants):
+    def visit_alternate_type(self,
+                             name: str,
+                             info: QAPISourceInfo,
+                             ifcond: List[str],
+                             features: List[QAPISchemaFeature],
+                             variants: QAPISchemaVariants) -> None:
         with ifcontext(ifcond, self._genh):
             self._genh.preamble_add(gen_fwd_object_or_array(name))
         self._genh.add(gen_object(name, ifcond, None,
@@ -321,7 +360,10 @@ def visit_alternate_type(self, name, info, ifcond, features, variants):
             self._gen_type_cleanup(name)
 
 
-def gen_types(schema, output_dir, prefix, opt_builtins):
+def gen_types(schema: QAPISchema,
+              output_dir: str,
+              prefix: str,
+              opt_builtins: bool) -> None:
     vis = QAPISchemaGenTypeVisitor(prefix)
     schema.visit(vis)
     vis.write(output_dir, opt_builtins)
-- 
2.26.2


