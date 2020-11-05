Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1633BC00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:39:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28D662078E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMccdlYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D662078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaeXi-0005fN-VX
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 07:39:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kaeOM-0002fH-1Y
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 07:29:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47283)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kaeOI-0004lb-LG
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 07:29:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604579361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Spo+RgywywX3Din/S1DiOh5u/fjN3QvL3eBBxau6rW0=;
 b=IMccdlYf1bIsm8uSMpUvwd9opqaq2IqnjxhHkRGfSRercFaq31VINc8EMzAmtejhf6YA3S
 LUVbz6eowFy9wDMPWjDcU0Eb/vo+8f97eVdE7CXWfZ7ef83VOktsAIHEvebO3CRpWeaECK
 1UL45E1k3oGbTwexQtgcfpE53zcAdVE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-laP9b6fvNfWusyZmcF60IA-1; Thu, 05 Nov 2020 07:29:18 -0500
X-MC-Unique: laP9b6fvNfWusyZmcF60IA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B7D98030B1;
 Thu,  5 Nov 2020 12:29:17 +0000 (UTC)
Received: from localhost (unknown [10.36.110.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B40919C4F;
 Thu,  5 Nov 2020 12:29:08 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/9] qapi: move gen_if/gen_endif to QAPIIfSchema
Date: Thu,  5 Nov 2020 16:28:01 +0400
Message-Id: <20201105122808.1182973-3-marcandre.lureau@redhat.com>
In-Reply-To: <20201105122808.1182973-1-marcandre.lureau@redhat.com>
References: <20201105122808.1182973-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

Move the generating function to the QAPIIfClass class.
(avoid cluttering and potential missuse of global functions, allow
access to private members etc - later could be replaced by a visitor?)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py     | 20 +-------------------
 scripts/qapi/gen.py        |  6 ++----
 scripts/qapi/introspect.py | 11 +++--------
 scripts/qapi/schema.py     | 18 +++++++++++++++++-
 scripts/qapi/types.py      | 28 +++++++++++-----------------
 scripts/qapi/visit.py      | 14 ++++++--------
 6 files changed, 40 insertions(+), 57 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 11b86beeab..6ee72956b5 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -12,7 +12,7 @@
 # See the COPYING file in the top-level directory.
 
 import re
-from typing import Optional, Sequence
+from typing import Optional
 
 
 #: Magic string that gets removed along with all space to its right.
@@ -192,21 +192,3 @@ def guardend(name: str) -> str:
 #endif /* %(name)s */
 ''',
                  name=c_fname(name).upper())
-
-
-def gen_if(ifcond: Sequence[str]) -> str:
-    ret = ''
-    for ifc in ifcond:
-        ret += mcgen('''
-#if %(cond)s
-''', cond=ifc)
-    return ret
-
-
-def gen_endif(ifcond: Sequence[str]) -> str:
-    ret = ''
-    for ifc in reversed(ifcond):
-        ret += mcgen('''
-#endif /* %(cond)s */
-''', cond=ifc)
-    return ret
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index b857bb7d5c..ae3ffb9ced 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -24,8 +24,6 @@ from typing import (
 from .common import (
     c_fname,
     c_name,
-    gen_endif,
-    gen_if,
     guardend,
     guardstart,
     mcgen,
@@ -94,9 +92,9 @@ def _wrap_ifcond(ifcond: QAPISchemaIf, before: str, after: str) -> str:
     if added[0] == '\n':
         out += '\n'
         added = added[1:]
-    out += gen_if(ifcond.ifcond)
+    out += ifcond.gen_if()
     out += added
-    out += gen_endif(ifcond.ifcond)
+    out += ifcond.gen_endif()
     return out
 
 
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 58e8433682..891575cfdf 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -22,12 +22,7 @@ from typing import (
     Union,
 )
 
-from .common import (
-    c_name,
-    gen_endif,
-    gen_if,
-    mcgen,
-)
+from .common import c_name, mcgen
 from .gen import QAPISchemaMonolithicCVisitor
 from .schema import (
     QAPISchema,
@@ -99,10 +94,10 @@ def _tree_to_qlit(obj: TreeValue, level: int = 0,
         if obj.comment:
             ret += indent(level) + '/* %s */\n' % obj.comment
         if obj.ifcond:
-            ret += gen_if(obj.ifcond.ifcond)
+            ret += obj.ifcond.gen_if()
         ret += _tree_to_qlit(obj.value, level)
         if obj.ifcond:
-            ret += '\n' + gen_endif(obj.ifcond.ifcond)
+            ret += '\n' + obj.ifcond.gen_endif()
         return ret
 
     ret = ''
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 05763008ae..92961aedcf 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -70,7 +70,7 @@ from typing import (
     overload,
 )
 
-from .common import POINTER_SUFFIX, c_name
+from .common import POINTER_SUFFIX, c_name, mcgen
 from .error import QAPISemError, QAPISourceError
 from .expr import check_exprs
 from .parser import ParsedExpression, QAPIDoc, QAPISchemaParser
@@ -89,6 +89,22 @@ class QAPISchemaIf:
     def __init__(self, ifcond: Optional[Sequence[str]] = None):
         self.ifcond = ifcond or []
 
+    def gen_if(self) -> str:
+        ret = ''
+        for ifc in self.ifcond:
+            ret += mcgen('''
+#if %(cond)s
+''', cond=ifc)
+        return ret
+
+    def gen_endif(self) -> str:
+        ret = ''
+        for ifc in reversed(self.ifcond):
+            ret += mcgen('''
+#endif /* %(cond)s */
+''', cond=ifc)
+        return ret
+
     def __bool__(self) -> bool:
         return bool(self.ifcond)
 
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 9618ad0640..a8d73290b3 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -15,13 +15,7 @@ This work is licensed under the terms of the GNU GPL, version 2.
 
 from typing import List, Optional
 
-from .common import (
-    c_enum_const,
-    c_name,
-    gen_endif,
-    gen_if,
-    mcgen,
-)
+from .common import c_enum_const, c_name, mcgen
 from .gen import QAPISchemaModularCVisitor, ifcontext
 from .schema import (
     QAPISchema,
@@ -51,13 +45,13 @@ const QEnumLookup %(c_name)s_lookup = {
 ''',
                 c_name=c_name(name))
     for memb in members:
-        ret += gen_if(memb.ifcond.ifcond)
+        ret += memb.ifcond.gen_if()
         index = c_enum_const(name, memb.name, prefix)
         ret += mcgen('''
         [%(index)s] = "%(name)s",
 ''',
                      index=index, name=memb.name)
-        ret += gen_endif(memb.ifcond.ifcond)
+        ret += memb.ifcond.gen_endif()
 
     ret += mcgen('''
     },
@@ -81,12 +75,12 @@ typedef enum %(c_name)s {
                 c_name=c_name(name))
 
     for memb in enum_members:
-        ret += gen_if(memb.ifcond.ifcond)
+        ret += memb.ifcond.gen_if()
         ret += mcgen('''
     %(c_enum)s,
 ''',
                      c_enum=c_enum_const(name, memb.name, prefix))
-        ret += gen_endif(memb.ifcond.ifcond)
+        ret += memb.ifcond.gen_endif()
 
     ret += mcgen('''
 } %(c_name)s;
@@ -126,7 +120,7 @@ struct %(c_name)s {
 def gen_struct_members(members: List[QAPISchemaObjectTypeMember]) -> str:
     ret = ''
     for memb in members:
-        ret += gen_if(memb.ifcond.ifcond)
+        ret += memb.ifcond.gen_if()
         if memb.optional:
             ret += mcgen('''
     bool has_%(c_name)s;
@@ -136,7 +130,7 @@ def gen_struct_members(members: List[QAPISchemaObjectTypeMember]) -> str:
     %(c_type)s %(c_name)s;
 ''',
                      c_type=memb.type.c_type(), c_name=c_name(memb.name))
-        ret += gen_endif(memb.ifcond.ifcond)
+        ret += memb.ifcond.gen_endif()
     return ret
 
 
@@ -159,7 +153,7 @@ def gen_object(name: str, ifcond: QAPISchemaIf,
     ret += mcgen('''
 
 ''')
-    ret += gen_if(ifcond.ifcond)
+    ret += ifcond.gen_if()
     ret += mcgen('''
 struct %(c_name)s {
 ''',
@@ -193,7 +187,7 @@ struct %(c_name)s {
     ret += mcgen('''
 };
 ''')
-    ret += gen_endif(ifcond.ifcond)
+    ret += ifcond.gen_endif()
 
     return ret
 
@@ -220,13 +214,13 @@ def gen_variants(variants: QAPISchemaVariants) -> str:
     for var in variants.variants:
         if var.type.name == 'q_empty':
             continue
-        ret += gen_if(var.ifcond.ifcond)
+        ret += var.ifcond.gen_if()
         ret += mcgen('''
         %(c_type)s %(c_name)s;
 ''',
                      c_type=var.type.c_unboxed_type(),
                      c_name=c_name(var.name))
-        ret += gen_endif(var.ifcond.ifcond)
+        ret += var.ifcond.gen_endif()
 
     ret += mcgen('''
     } u;
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index d72a749190..a5159f16fb 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -18,8 +18,6 @@ from typing import List, Optional
 from .common import (
     c_enum_const,
     c_name,
-    gen_endif,
-    gen_if,
     indent,
     mcgen,
 )
@@ -78,7 +76,7 @@ bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
                      c_type=base.c_name())
 
     for memb in members:
-        ret += gen_if(memb.ifcond.ifcond)
+        ret += memb.ifcond.gen_if()
         if memb.optional:
             ret += mcgen('''
     if (visit_optional(v, "%(name)s", &obj->has_%(c_name)s)) {
@@ -97,7 +95,7 @@ bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
             ret += mcgen('''
     }
 ''')
-        ret += gen_endif(memb.ifcond.ifcond)
+        ret += memb.ifcond.gen_endif()
 
     if variants:
         tag_member = variants.tag_member
@@ -111,7 +109,7 @@ bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
         for var in variants.variants:
             case_str = c_enum_const(tag_member.type.name, var.name,
                                     tag_member.type.prefix)
-            ret += gen_if(var.ifcond.ifcond)
+            ret += var.ifcond.gen_if()
             if var.type.name == 'q_empty':
                 # valid variant and nothing to do
                 ret += mcgen('''
@@ -127,7 +125,7 @@ bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
                              case=case_str,
                              c_type=var.type.c_name(), c_name=c_name(var.name))
 
-            ret += gen_endif(var.ifcond.ifcond)
+            ret += var.ifcond.gen_endif()
         ret += mcgen('''
     default:
         abort();
@@ -213,7 +211,7 @@ bool visit_type_%(c_name)s(Visitor *v, const char *name,
                 c_name=c_name(name))
 
     for var in variants.variants:
-        ret += gen_if(var.ifcond.ifcond)
+        ret += var.ifcond.gen_if()
         ret += mcgen('''
     case %(case)s:
 ''',
@@ -239,7 +237,7 @@ bool visit_type_%(c_name)s(Visitor *v, const char *name,
         ret += mcgen('''
         break;
 ''')
-        ret += gen_endif(var.ifcond.ifcond)
+        ret += var.ifcond.gen_endif()
 
     ret += mcgen('''
     case QTYPE_NONE:
-- 
2.29.0


