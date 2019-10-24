Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98226CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:44:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F7920679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIPbMgUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F7920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdQ6-0007lp-AU
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 09:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNcKm-00043P-3l
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNcKk-0006D7-5s
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55788
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNcKk-0006CS-0H
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571920517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=isHjpUvn/iUK1K1nf4w+2NkSPn5cX3hNfUlLTgszW2c=;
 b=jIPbMgUngVtfb7q0gYQfRk7CdE8tag18Q0cp7eh0SO1kHYQ443rL6+ET3tH7SkMSDj0vNk
 /HKTOOIHKAuEEzFMD5Ccpy9IS7rGNxtaDIquJmWNHtN7njDoEnAuC3Ot/FaKcJArIHhNQU
 KU6dUz8cmgEpQ7sp6uEy221msd2cZjw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-pNP7UHTLO3OL1NHpS2BVaw-1; Thu, 24 Oct 2019 08:35:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA5EA800D4C;
 Thu, 24 Oct 2019 12:35:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A0F1C60BE0;
 Thu, 24 Oct 2019 12:35:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 149921132989; Thu, 24 Oct 2019 14:34:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 08/19] qapi: Consistently put @features parameter right
 after @ifcond
Date: Thu, 24 Oct 2019 14:34:47 +0200
Message-Id: <20191024123458.13505-9-armbru@redhat.com>
In-Reply-To: <20191024123458.13505-1-armbru@redhat.com>
References: <20191024123458.13505-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: pNP7UHTLO3OL1NHpS2BVaw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: libvir-list@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
index ab98e504f3..11e9a6c095 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -276,9 +276,9 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds)=
;
                        c_prefix=3Dc_name(self._prefix, protect=3DFalse)))
         genc.add(gen_registry(self._regy.get_content(), self._prefix))
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
index 53a1f8e952..55c4892a1e 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -250,8 +250,8 @@ class QAPISchemaGenDocVisitor(QAPISchemaVisitor):
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
@@ -263,9 +263,9 @@ class QAPISchemaGenDocVisitor(QAPISchemaVisitor):
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
index ba493977cf..f71b984d3b 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -195,8 +195,8 @@ const QLitObject %(c_name)s =3D %(c_string)s;
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
@@ -211,9 +211,9 @@ const QLitObject %(c_name)s =3D %(c_string)s;
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
index f13f442896..639140fceb 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -115,20 +115,20 @@ class QAPISchemaVisitor(object):
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
+    def visit_object_type_flat(self, name, info, features, ifcond,
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
@@ -422,12 +422,12 @@ class QAPISchemaObjectType(QAPISchemaType):
=20
     def visit(self, visitor):
         QAPISchemaType.visit(self, visitor)
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
 class QAPISchemaMember(object):
@@ -729,12 +729,10 @@ class QAPISchemaCommand(QAPISchemaEntity):
=20
     def visit(self, visitor):
         QAPISchemaEntity.visit(self, visitor)
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
index 2a108b6911..9dc07f6308 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -288,8 +288,8 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisito=
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
index b21e1340a2..4db94e5e80 100644
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
index 078fc63f97..9ee8993f8d 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -51,8 +51,8 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
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
@@ -70,9 +70,9 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
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
2.21.0


