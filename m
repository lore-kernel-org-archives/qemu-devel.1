Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164C3C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9A9420767
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V524NYvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A9420767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEB2k-0000JF-V1
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 08:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56907)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEAob-0008Fk-QC
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEAoX-0006j4-Ls
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:34874)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEAoX-0006eN-E0
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584446116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TgGX4lIj7YKgm+EM+OXuKQ+G5357jqiXMJoldM3tJc0=;
 b=V524NYvmBbPMzxbjTE48kkPImgwmS1xy/YNaODeth00R60JVY/9Y0iaQ2Y+3XKV7s/uJab
 AFG6u7U9FvT8AmkPV380RaXx6pV9F3Bwc5rqQLti4L4H9BusK7S5Kf1V78yseH7cr8C22f
 +bNe1tXnjhj5gtNYFKh3xTiDS1YeteE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-0cPnYk0lMemdirjy5Z8VbA-1; Tue, 17 Mar 2020 07:55:13 -0400
X-MC-Unique: 0cPnYk0lMemdirjy5Z8VbA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19D11801E66;
 Tue, 17 Mar 2020 11:55:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F25AE9129E;
 Tue, 17 Mar 2020 11:55:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4CD041135A5A; Tue, 17 Mar 2020 12:55:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 17/34] qapi/schema: Reorder classes so related ones are
 together
Date: Tue, 17 Mar 2020 12:54:42 +0100
Message-Id: <20200317115459.31821-18-armbru@redhat.com>
In-Reply-To: <20200317115459.31821-1-armbru@redhat.com>
References: <20200317115459.31821-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

Move QAPISchemaAlternateType up some, so that all QAPISchemaFOOType
are together.  Move QAPISchemaObjectTypeVariants right behind its
users.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/schema.py | 284 ++++++++++++++++++++---------------------
 1 file changed, 142 insertions(+), 142 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 4d8ad67303..0acf8b466f 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -444,82 +444,72 @@ class QAPISchemaObjectType(QAPISchemaType):
             self.members, self.variants)
=20
=20
-class QAPISchemaMember:
-    """ Represents object members, enum members and features """
-    role =3D 'member'
-
-    def __init__(self, name, info, ifcond=3DNone):
-        assert isinstance(name, str)
-        self.name =3D name
-        self.info =3D info
-        self.ifcond =3D ifcond or []
-        self.defined_in =3D None
-
-    def set_defined_in(self, name):
-        assert not self.defined_in
-        self.defined_in =3D name
-
-    def check_clash(self, info, seen):
-        cname =3D c_name(self.name)
-        if cname in seen:
-            raise QAPISemError(
-                info,
-                "%s collides with %s"
-                % (self.describe(info), seen[cname].describe(info)))
-        seen[cname] =3D self
-
-    def describe(self, info):
-        role =3D self.role
-        defined_in =3D self.defined_in
-        assert defined_in
-
-        if defined_in.startswith('q_obj_'):
-            # See QAPISchema._make_implicit_object_type() - reverse the
-            # mapping there to create a nice human-readable description
-            defined_in =3D defined_in[6:]
-            if defined_in.endswith('-arg'):
-                # Implicit type created for a command's dict 'data'
-                assert role =3D=3D 'member'
-                role =3D 'parameter'
-            elif defined_in.endswith('-base'):
-                # Implicit type created for a flat union's dict 'base'
-                role =3D 'base ' + role
-            else:
-                # Implicit type created for a simple union's branch
-                assert defined_in.endswith('-wrapper')
-                # Unreachable and not implemented
-                assert False
-        elif defined_in.endswith('Kind'):
-            # See QAPISchema._make_implicit_enum_type()
-            # Implicit enum created for simple union's branches
-            assert role =3D=3D 'value'
-            role =3D 'branch'
-        elif defined_in !=3D info.defn_name:
-            return "%s '%s' of type '%s'" % (role, self.name, defined_in)
-        return "%s '%s'" % (role, self.name)
-
-
-class QAPISchemaEnumMember(QAPISchemaMember):
-    role =3D 'value'
-
-
-class QAPISchemaFeature(QAPISchemaMember):
-    role =3D 'feature'
-
-
-class QAPISchemaObjectTypeMember(QAPISchemaMember):
-    def __init__(self, name, info, typ, optional, ifcond=3DNone):
-        super().__init__(name, info, ifcond)
-        assert isinstance(typ, str)
-        assert isinstance(optional, bool)
-        self._type_name =3D typ
-        self.type =3D None
-        self.optional =3D optional
+class QAPISchemaAlternateType(QAPISchemaType):
+    meta =3D 'alternate'
+
+    def __init__(self, name, info, doc, ifcond, features, variants):
+        super().__init__(name, info, doc, ifcond, features)
+        assert isinstance(variants, QAPISchemaObjectTypeVariants)
+        assert variants.tag_member
+        variants.set_defined_in(name)
+        variants.tag_member.set_defined_in(self.name)
+        self.variants =3D variants
=20
     def check(self, schema):
-        assert self.defined_in
-        self.type =3D schema.resolve_type(self._type_name, self.info,
-                                        self.describe)
+        super().check(schema)
+        self.variants.tag_member.check(schema)
+        # Not calling self.variants.check_clash(), because there's nothing
+        # to clash with
+        self.variants.check(schema, {})
+        # Alternate branch names have no relation to the tag enum values;
+        # so we have to check for potential name collisions ourselves.
+        seen =3D {}
+        types_seen =3D {}
+        for v in self.variants.variants:
+            v.check_clash(self.info, seen)
+            qtype =3D v.type.alternate_qtype()
+            if not qtype:
+                raise QAPISemError(
+                    self.info,
+                    "%s cannot use %s"
+                    % (v.describe(self.info), v.type.describe()))
+            conflicting =3D set([qtype])
+            if qtype =3D=3D 'QTYPE_QSTRING':
+                if isinstance(v.type, QAPISchemaEnumType):
+                    for m in v.type.members:
+                        if m.name in ['on', 'off']:
+                            conflicting.add('QTYPE_QBOOL')
+                        if re.match(r'[-+0-9.]', m.name):
+                            # lazy, could be tightened
+                            conflicting.add('QTYPE_QNUM')
+                else:
+                    conflicting.add('QTYPE_QNUM')
+                    conflicting.add('QTYPE_QBOOL')
+            for qt in conflicting:
+                if qt in types_seen:
+                    raise QAPISemError(
+                        self.info,
+                        "%s can't be distinguished from '%s'"
+                        % (v.describe(self.info), types_seen[qt]))
+                types_seen[qt] =3D v.name
+
+    def connect_doc(self, doc=3DNone):
+        super().connect_doc(doc)
+        doc =3D doc or self.doc
+        if doc:
+            for v in self.variants.variants:
+                doc.connect_member(v)
+
+    def c_type(self):
+        return c_name(self.name) + pointer_suffix
+
+    def json_type(self):
+        return 'value'
+
+    def visit(self, visitor):
+        super().visit(visitor)
+        visitor.visit_alternate_type(
+            self.name, self.info, self.ifcond, self.features, self.variant=
s)
=20
=20
 class QAPISchemaObjectTypeVariants:
@@ -613,6 +603,84 @@ class QAPISchemaObjectTypeVariants:
             v.type.check_clash(info, dict(seen))
=20
=20
+class QAPISchemaMember:
+    """ Represents object members, enum members and features """
+    role =3D 'member'
+
+    def __init__(self, name, info, ifcond=3DNone):
+        assert isinstance(name, str)
+        self.name =3D name
+        self.info =3D info
+        self.ifcond =3D ifcond or []
+        self.defined_in =3D None
+
+    def set_defined_in(self, name):
+        assert not self.defined_in
+        self.defined_in =3D name
+
+    def check_clash(self, info, seen):
+        cname =3D c_name(self.name)
+        if cname in seen:
+            raise QAPISemError(
+                info,
+                "%s collides with %s"
+                % (self.describe(info), seen[cname].describe(info)))
+        seen[cname] =3D self
+
+    def describe(self, info):
+        role =3D self.role
+        defined_in =3D self.defined_in
+        assert defined_in
+
+        if defined_in.startswith('q_obj_'):
+            # See QAPISchema._make_implicit_object_type() - reverse the
+            # mapping there to create a nice human-readable description
+            defined_in =3D defined_in[6:]
+            if defined_in.endswith('-arg'):
+                # Implicit type created for a command's dict 'data'
+                assert role =3D=3D 'member'
+                role =3D 'parameter'
+            elif defined_in.endswith('-base'):
+                # Implicit type created for a flat union's dict 'base'
+                role =3D 'base ' + role
+            else:
+                # Implicit type created for a simple union's branch
+                assert defined_in.endswith('-wrapper')
+                # Unreachable and not implemented
+                assert False
+        elif defined_in.endswith('Kind'):
+            # See QAPISchema._make_implicit_enum_type()
+            # Implicit enum created for simple union's branches
+            assert role =3D=3D 'value'
+            role =3D 'branch'
+        elif defined_in !=3D info.defn_name:
+            return "%s '%s' of type '%s'" % (role, self.name, defined_in)
+        return "%s '%s'" % (role, self.name)
+
+
+class QAPISchemaEnumMember(QAPISchemaMember):
+    role =3D 'value'
+
+
+class QAPISchemaFeature(QAPISchemaMember):
+    role =3D 'feature'
+
+
+class QAPISchemaObjectTypeMember(QAPISchemaMember):
+    def __init__(self, name, info, typ, optional, ifcond=3DNone):
+        super().__init__(name, info, ifcond)
+        assert isinstance(typ, str)
+        assert isinstance(optional, bool)
+        self._type_name =3D typ
+        self.type =3D None
+        self.optional =3D optional
+
+    def check(self, schema):
+        assert self.defined_in
+        self.type =3D schema.resolve_type(self._type_name, self.info,
+                                        self.describe)
+
+
 class QAPISchemaObjectTypeVariant(QAPISchemaObjectTypeMember):
     role =3D 'branch'
=20
@@ -620,74 +688,6 @@ class QAPISchemaObjectTypeVariant(QAPISchemaObjectType=
Member):
         super().__init__(name, info, typ, False, ifcond)
=20
=20
-class QAPISchemaAlternateType(QAPISchemaType):
-    meta =3D 'alternate'
-
-    def __init__(self, name, info, doc, ifcond, features, variants):
-        super().__init__(name, info, doc, ifcond, features)
-        assert isinstance(variants, QAPISchemaObjectTypeVariants)
-        assert variants.tag_member
-        variants.set_defined_in(name)
-        variants.tag_member.set_defined_in(self.name)
-        self.variants =3D variants
-
-    def check(self, schema):
-        super().check(schema)
-        self.variants.tag_member.check(schema)
-        # Not calling self.variants.check_clash(), because there's nothing
-        # to clash with
-        self.variants.check(schema, {})
-        # Alternate branch names have no relation to the tag enum values;
-        # so we have to check for potential name collisions ourselves.
-        seen =3D {}
-        types_seen =3D {}
-        for v in self.variants.variants:
-            v.check_clash(self.info, seen)
-            qtype =3D v.type.alternate_qtype()
-            if not qtype:
-                raise QAPISemError(
-                    self.info,
-                    "%s cannot use %s"
-                    % (v.describe(self.info), v.type.describe()))
-            conflicting =3D set([qtype])
-            if qtype =3D=3D 'QTYPE_QSTRING':
-                if isinstance(v.type, QAPISchemaEnumType):
-                    for m in v.type.members:
-                        if m.name in ['on', 'off']:
-                            conflicting.add('QTYPE_QBOOL')
-                        if re.match(r'[-+0-9.]', m.name):
-                            # lazy, could be tightened
-                            conflicting.add('QTYPE_QNUM')
-                else:
-                    conflicting.add('QTYPE_QNUM')
-                    conflicting.add('QTYPE_QBOOL')
-            for qt in conflicting:
-                if qt in types_seen:
-                    raise QAPISemError(
-                        self.info,
-                        "%s can't be distinguished from '%s'"
-                        % (v.describe(self.info), types_seen[qt]))
-                types_seen[qt] =3D v.name
-
-    def connect_doc(self, doc=3DNone):
-        super().connect_doc(doc)
-        doc =3D doc or self.doc
-        if doc:
-            for v in self.variants.variants:
-                doc.connect_member(v)
-
-    def c_type(self):
-        return c_name(self.name) + pointer_suffix
-
-    def json_type(self):
-        return 'value'
-
-    def visit(self, visitor):
-        super().visit(visitor)
-        visitor.visit_alternate_type(
-            self.name, self.info, self.ifcond, self.features, self.variant=
s)
-
-
 class QAPISchemaCommand(QAPISchemaEntity):
     meta =3D 'command'
=20
--=20
2.21.1


