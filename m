Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E81C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:55:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E903206CA
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgB91sSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E903206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT6Xb-0004yq-SE
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 12:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kT6VL-00036D-3q
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:53:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20958)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kT6VI-0001WO-RW
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602780803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xYpymDkGf3DkVnqKu28Cu3ciHcdts5cGa4LEARgxQZ0=;
 b=HgB91sSEsJeGvedN82c4oDyg392hP0MVv6RCir+rvBjr1lZPwev8iQYdCM5fCgpMS8Yt1B
 SOyV/Stt4qz4336G3oHzOawYJc1UQKmZAkcmEEdiBVoPkare86AJ6CrfsZ8s26hUvxN9t4
 XEDmsnXK6B5uNgMN8nrJN/1pK1XHLkE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-MPyF2GcxOk-xRMbNObGwog-1; Thu, 15 Oct 2020 12:53:20 -0400
X-MC-Unique: MPyF2GcxOk-xRMbNObGwog-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3CA5101962A;
 Thu, 15 Oct 2020 16:53:19 +0000 (UTC)
Received: from localhost (unknown [10.36.110.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 946A610013C1;
 Thu, 15 Oct 2020 16:53:15 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 2/9] qapi: move gen_if/gen_endif to IfCond
Date: Thu, 15 Oct 2020 20:52:48 +0400
Message-Id: <20201015165255.1573897-3-marcandre.lureau@redhat.com>
In-Reply-To: <20201015165255.1573897-1-marcandre.lureau@redhat.com>
References: <20201015165255.1573897-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Move the generating function to the IfCond class.
(avoid cluttering and potential missuse of global functions, allow
access to private members etc)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py     | 22 ++++++++++------------
 scripts/qapi/gen.py        |  6 ++----
 scripts/qapi/introspect.py |  6 ++----
 scripts/qapi/types.py      | 22 ++++++++++------------
 scripts/qapi/visit.py      | 14 ++++++--------
 5 files changed, 30 insertions(+), 40 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 59e6a400da..58ddec3bc5 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -209,20 +209,18 @@ class IfCond:
             return NotImplemented
         return self.ifcond == other.ifcond
 
-
-def gen_if(c: IfCond) -> str:
-    ret = ''
-    for ifc in c.ifcond:
-        ret += mcgen('''
+    def gen_if(self) -> str:
+        ret = ''
+        for ifc in self.ifcond:
+            ret += mcgen('''
 #if %(cond)s
 ''', cond=ifc)
-    return ret
-
+        return ret
 
-def gen_endif(c: IfCond) -> str:
-    ret = ''
-    for ifc in reversed(c.ifcond):
-        ret += mcgen('''
+    def gen_endif(self) -> str:
+        ret = ''
+        for ifc in reversed(self.ifcond):
+            ret += mcgen('''
 #endif /* %(cond)s */
 ''', cond=ifc)
-    return ret
+        return ret
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index b35ccb201f..5a8c66e628 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -26,8 +26,6 @@ from .common import (
     IfCond,
     c_fname,
     c_name,
-    gen_endif,
-    gen_if,
     guardend,
     guardstart,
     mcgen,
@@ -92,9 +90,9 @@ def _wrap_ifcond(ifcond: IfCond, before: str, after: str) -> str:
     if added[0] == '\n':
         out += '\n'
         added = added[1:]
-    out += gen_if(ifcond)
+    out += ifcond.gen_if()
     out += added
-    out += gen_endif(ifcond)
+    out += ifcond.gen_endif()
     return out
 
 
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 103b8515eb..d97dea8e4e 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -23,8 +23,6 @@ from typing import (
 from .common import (
     IfCond,
     c_name,
-    gen_endif,
-    gen_if,
     mcgen,
 )
 from .gen import QAPISchemaMonolithicCVisitor
@@ -77,10 +75,10 @@ def _tree_to_qlit(obj: TreeNode, level: int = 0,
         if obj.comment:
             ret += indent(level) + '/* %s */\n' % obj.comment
         if obj.ifcond:
-            ret += gen_if(obj.ifcond)
+            ret += obj.ifcond.gen_if()
         ret += _tree_to_qlit(obj.data, level)
         if obj.ifcond:
-            ret += '\n' + gen_endif(obj.ifcond)
+            ret += '\n' + obj.ifcond.gen_endif()
         return ret
 
     ret = ''
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index c15613d13b..66ba2f62e4 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -19,8 +19,6 @@ from .common import (
     IfCond,
     c_enum_const,
     c_name,
-    gen_endif,
-    gen_if,
     mcgen,
 )
 from .gen import QAPISchemaModularCVisitor, ifcontext
@@ -51,13 +49,13 @@ const QEnumLookup %(c_name)s_lookup = {
 ''',
                 c_name=c_name(name))
     for memb in members:
-        ret += gen_if(memb.ifcond)
+        ret += memb.ifcond.gen_if()
         index = c_enum_const(name, memb.name, prefix)
         ret += mcgen('''
         [%(index)s] = "%(name)s",
 ''',
                      index=index, name=memb.name)
-        ret += gen_endif(memb.ifcond)
+        ret += memb.ifcond.gen_endif()
 
     ret += mcgen('''
     },
@@ -81,12 +79,12 @@ typedef enum %(c_name)s {
                 c_name=c_name(name))
 
     for memb in enum_members:
-        ret += gen_if(memb.ifcond)
+        ret += memb.ifcond.gen_if()
         ret += mcgen('''
     %(c_enum)s,
 ''',
                      c_enum=c_enum_const(name, memb.name, prefix))
-        ret += gen_endif(memb.ifcond)
+        ret += memb.ifcond.gen_endif()
 
     ret += mcgen('''
 } %(c_name)s;
@@ -126,7 +124,7 @@ struct %(c_name)s {
 def gen_struct_members(members: List[QAPISchemaObjectTypeMember]) -> str:
     ret = ''
     for memb in members:
-        ret += gen_if(memb.ifcond)
+        ret += memb.ifcond.gen_if()
         if memb.optional:
             ret += mcgen('''
     bool has_%(c_name)s;
@@ -136,7 +134,7 @@ def gen_struct_members(members: List[QAPISchemaObjectTypeMember]) -> str:
     %(c_type)s %(c_name)s;
 ''',
                      c_type=memb.type.c_type(), c_name=c_name(memb.name))
-        ret += gen_endif(memb.ifcond)
+        ret += memb.ifcond.gen_endif()
     return ret
 
 
@@ -159,7 +157,7 @@ def gen_object(name: str, ifcond: IfCond,
     ret += mcgen('''
 
 ''')
-    ret += gen_if(ifcond)
+    ret += ifcond.gen_if()
     ret += mcgen('''
 struct %(c_name)s {
 ''',
@@ -193,7 +191,7 @@ struct %(c_name)s {
     ret += mcgen('''
 };
 ''')
-    ret += gen_endif(ifcond)
+    ret += ifcond.gen_endif()
 
     return ret
 
@@ -220,13 +218,13 @@ def gen_variants(variants: QAPISchemaVariants) -> str:
     for var in variants.variants:
         if var.type.name == 'q_empty':
             continue
-        ret += gen_if(var.ifcond)
+        ret += var.ifcond.gen_if()
         ret += mcgen('''
         %(c_type)s %(c_name)s;
 ''',
                      c_type=var.type.c_unboxed_type(),
                      c_name=c_name(var.name))
-        ret += gen_endif(var.ifcond)
+        ret += var.ifcond.gen_endif()
 
     ret += mcgen('''
     } u;
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index d10840bf7b..b199e75946 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -19,8 +19,6 @@ from .common import (
     IfCond,
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
-        ret += gen_if(memb.ifcond)
+        ret += memb.ifcond.gen_if()
         if memb.optional:
             ret += mcgen('''
     if (visit_optional(v, "%(name)s", &obj->has_%(c_name)s)) {
@@ -97,7 +95,7 @@ bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
             ret += mcgen('''
     }
 ''')
-        ret += gen_endif(memb.ifcond)
+        ret += memb.ifcond.gen_endif()
 
     if variants:
         tag_member = variants.tag_member
@@ -111,7 +109,7 @@ bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
         for var in variants.variants:
             case_str = c_enum_const(tag_member.type.name, var.name,
                                     tag_member.type.prefix)
-            ret += gen_if(var.ifcond)
+            ret += var.ifcond.gen_if()
             if var.type.name == 'q_empty':
                 # valid variant and nothing to do
                 ret += mcgen('''
@@ -127,7 +125,7 @@ bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
                              case=case_str,
                              c_type=var.type.c_name(), c_name=c_name(var.name))
 
-            ret += gen_endif(var.ifcond)
+            ret += var.ifcond.gen_endif()
         ret += mcgen('''
     default:
         abort();
@@ -213,7 +211,7 @@ bool visit_type_%(c_name)s(Visitor *v, const char *name,
                 c_name=c_name(name))
 
     for var in variants.variants:
-        ret += gen_if(var.ifcond)
+        ret += var.ifcond.gen_if()
         ret += mcgen('''
     case %(case)s:
 ''',
@@ -239,7 +237,7 @@ bool visit_type_%(c_name)s(Visitor *v, const char *name,
         ret += mcgen('''
         break;
 ''')
-        ret += gen_endif(var.ifcond)
+        ret += var.ifcond.gen_endif()
 
     ret += mcgen('''
     case QTYPE_NONE:
-- 
2.28.0


