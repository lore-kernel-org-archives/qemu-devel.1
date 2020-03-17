Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5EFC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B29C2073C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ePF4nUxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B29C2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEB21-0006uX-CS
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 08:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEAoc-0008Ge-C1
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEAoY-0006lA-5e
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:22 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:54058)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEAoX-0006jV-Vp
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584446117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p3qAHO5W0XR5q6Vn93COHS6lD/G1Y2D7BotBFtVbssw=;
 b=ePF4nUxSFbrQBWfaN3+2hfM1Q9LwG4zc+uC0QvdMKv2a7eSZdDVJ8hm7S6eMte7+jHI/n6
 NNeREDKkkiirWxa0MCdX8yFWRSH0hf/vqsTWrc/Ep5hYE59YAOMhwnSORpRZ8/aiwrbGkm
 5oy9ThLmlgLjniMx723fLUcFS7chxKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-YJ_gNIhhPbuSLr_X_5Pbvw-1; Tue, 17 Mar 2020 07:55:14 -0400
X-MC-Unique: YJ_gNIhhPbuSLr_X_5Pbvw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B6221922966;
 Tue, 17 Mar 2020 11:55:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5372194949;
 Tue, 17 Mar 2020 11:55:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 33DA111366F7; Tue, 17 Mar 2020 12:55:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 13/34] qapi: Consistently put @features parameter right
 after @ifcond
Date: Tue, 17 Mar 2020 12:54:38 +0100
Message-Id: <20200317115459.31821-14-armbru@redhat.com>
In-Reply-To: <20200317115459.31821-1-armbru@redhat.com>
References: <20200317115459.31821-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: marcandre.lureau@gmail.com, mdroth@linux.vnet.ibm.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/commands.py       |  6 +++---
 scripts/qapi/doc.py            | 10 +++++-----
 scripts/qapi/introspect.py     | 10 +++++-----
 scripts/qapi/schema.py         | 36 ++++++++++++++++------------------
 scripts/qapi/types.py          |  4 ++--
 scripts/qapi/visit.py          |  4 ++--
 tests/qapi-schema/test-qapi.py | 10 +++++-----
 7 files changed, 39 insertions(+), 41 deletions(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 0e13e82989..bc30876c88 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -283,9 +283,9 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds)=
;
                                       prefix=3Dself._prefix))
         self._genc.add(gen_registry(self._regy.get_content(), self._prefix=
))
=20
-    def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
-                      success_response, boxed, allow_oob, allow_preconfig,
-                      features):
+    def visit_command(self, name, info, ifcond, features,
+                      arg_type, ret_type, gen, success_response, boxed,
+                      allow_oob, allow_preconfig):
         if not gen:
             return
         # FIXME: If T is a user-defined type, the user is responsible
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 36e823338b..92f584edcf 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -249,8 +249,8 @@ class QAPISchemaGenDocVisitor(QAPISchemaVisitor):
                                 texi_members(doc, 'Values',
                                              member_func=3Dtexi_enum_value=
)))
=20
-    def visit_object_type(self, name, info, ifcond, base, members, variant=
s,
-                          features):
+    def visit_object_type(self, name, info, ifcond, features,
+                          base, members, variants):
         doc =3D self.cur_doc
         if base and base.is_implicit():
             base =3D None
@@ -262,9 +262,9 @@ class QAPISchemaGenDocVisitor(QAPISchemaVisitor):
         self._gen.add(texi_type('Alternate', doc, ifcond,
                                 texi_members(doc, 'Members')))
=20
-    def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
-                      success_response, boxed, allow_oob, allow_preconfig,
-                      features):
+    def visit_command(self, name, info, ifcond, features,
+                      arg_type, ret_type, gen, success_response, boxed,
+                      allow_oob, allow_preconfig):
         doc =3D self.cur_doc
         self._gen.add(texi_msg('Command', doc, ifcond,
                                texi_arguments(doc,
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 2e9e00aa1f..b54910510d 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -193,8 +193,8 @@ const QLitObject %(c_name)s =3D %(c_string)s;
         self._gen_qlit('[' + element + ']', 'array', {'element-type': elem=
ent},
                        ifcond, None)
=20
-    def visit_object_type_flat(self, name, info, ifcond, members, variants=
,
-                               features):
+    def visit_object_type_flat(self, name, info, ifcond, features,
+                               members, variants):
         obj =3D {'members': [self._gen_member(m) for m in members]}
         if variants:
             obj.update(self._gen_variants(variants.tag_member.name,
@@ -209,9 +209,9 @@ const QLitObject %(c_name)s =3D %(c_string)s;
                            for m in variants.variants]},
                        ifcond, features)
=20
-    def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
-                      success_response, boxed, allow_oob, allow_preconfig,
-                      features):
+    def visit_command(self, name, info, ifcond, features,
+                      arg_type, ret_type, gen, success_response, boxed,
+                      allow_oob, allow_preconfig):
         arg_type =3D arg_type or self._schema.the_empty_object_type
         ret_type =3D ret_type or self._schema.the_empty_object_type
         obj =3D {'arg-type': self._use_type(arg_type),
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 22238005ff..958756ecd6 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -115,20 +115,20 @@ class QAPISchemaVisitor:
     def visit_array_type(self, name, info, ifcond, element_type):
         pass
=20
-    def visit_object_type(self, name, info, ifcond, base, members, variant=
s,
-                          features):
+    def visit_object_type(self, name, info, ifcond, features,
+                          base, members, variants):
         pass
=20
-    def visit_object_type_flat(self, name, info, ifcond, members, variants=
,
-                               features):
+    def visit_object_type_flat(self, name, info, ifcond, features,
+                               members, variants):
         pass
=20
     def visit_alternate_type(self, name, info, ifcond, features, variants)=
:
         pass
=20
-    def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
-                      success_response, boxed, allow_oob, allow_preconfig,
-                      features):
+    def visit_command(self, name, info, ifcond, features,
+                      arg_type, ret_type, gen, success_response, boxed,
+                      allow_oob, allow_preconfig):
         pass
=20
     def visit_event(self, name, info, ifcond, features, arg_type, boxed):
@@ -436,12 +436,12 @@ class QAPISchemaObjectType(QAPISchemaType):
=20
     def visit(self, visitor):
         super().visit(visitor)
-        visitor.visit_object_type(self.name, self.info, self.ifcond,
-                                  self.base, self.local_members, self.vari=
ants,
-                                  self.features)
-        visitor.visit_object_type_flat(self.name, self.info, self.ifcond,
-                                       self.members, self.variants,
-                                       self.features)
+        visitor.visit_object_type(
+            self.name, self.info, self.ifcond, self.features,
+            self.base, self.local_members, self.variants)
+        visitor.visit_object_type_flat(
+            self.name, self.info, self.ifcond, self.features,
+            self.members, self.variants)
=20
=20
 class QAPISchemaMember:
@@ -745,12 +745,10 @@ class QAPISchemaCommand(QAPISchemaEntity):
=20
     def visit(self, visitor):
         super().visit(visitor)
-        visitor.visit_command(self.name, self.info, self.ifcond,
-                              self.arg_type, self.ret_type,
-                              self.gen, self.success_response,
-                              self.boxed, self.allow_oob,
-                              self.allow_preconfig,
-                              self.features)
+        visitor.visit_command(
+            self.name, self.info, self.ifcond, self.features,
+            self.arg_type, self.ret_type, self.gen, self.success_response,
+            self.boxed, self.allow_oob, self.allow_preconfig)
=20
=20
 class QAPISchemaEvent(QAPISchemaEntity):
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index d0d5c03646..3ad33af4ee 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -289,8 +289,8 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisito=
r):
             self._genh.add(gen_array(name, element_type))
             self._gen_type_cleanup(name)
=20
-    def visit_object_type(self, name, info, ifcond, base, members, variant=
s,
-                          features):
+    def visit_object_type(self, name, info, ifcond, features,
+                          base, members, variants):
         # Nothing to do for the special empty builtin
         if name =3D=3D 'q_empty':
             return
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 6e5ed781d7..23d9194aa4 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -326,8 +326,8 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVisit=
or):
             self._genh.add(gen_visit_decl(name))
             self._genc.add(gen_visit_list(name, element_type))
=20
-    def visit_object_type(self, name, info, ifcond, base, members, variant=
s,
-                          features):
+    def visit_object_type(self, name, info, ifcond, features,
+                          base, members, variants):
         # Nothing to do for the special empty builtin
         if name =3D=3D 'q_empty':
             return
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.p=
y
index af5b57a0b1..8e09e54edb 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -46,8 +46,8 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         print('array %s %s' % (name, element_type.name))
         self._print_if(ifcond)
=20
-    def visit_object_type(self, name, info, ifcond, base, members, variant=
s,
-                          features):
+    def visit_object_type(self, name, info, ifcond, features,
+                          base, members, variants):
         print('object %s' % name)
         if base:
             print('    base %s' % base.name)
@@ -65,9 +65,9 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         self._print_if(ifcond)
         self._print_features(features)
=20
-    def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
-                      success_response, boxed, allow_oob, allow_preconfig,
-                      features):
+    def visit_command(self, name, info, ifcond, features,
+                      arg_type, ret_type, gen, success_response, boxed,
+                      allow_oob, allow_preconfig):
         print('command %s %s -> %s'
               % (name, arg_type and arg_type.name,
                  ret_type and ret_type.name))
--=20
2.21.1


