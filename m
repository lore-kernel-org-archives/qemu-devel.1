Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E640C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:52:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E79E1207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79E1207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCmB4-0003xR-Si
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 10:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCks4-0000Jk-WA
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCkru-0001SN-K5
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33377)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCkru-0001RI-0i
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3A4923C928;
 Tue, 24 Sep 2019 13:28:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D3B465C219;
 Tue, 24 Sep 2019 13:28:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 897C611384A9; Tue, 24 Sep 2019 15:28:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/25] qapi: Plumb info to the QAPISchemaMember
Date: Tue, 24 Sep 2019 15:28:19 +0200
Message-Id: <20190924132830.15835-15-armbru@redhat.com>
In-Reply-To: <20190924132830.15835-1-armbru@redhat.com>
References: <20190924132830.15835-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 24 Sep 2019 13:28:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Future commits will need info in the .check() methods of
QAPISchemaMember and its descendants.  Get it there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py | 76 +++++++++++++++++++++++-------------------
 scripts/qapi/events.py |  2 +-
 2 files changed, 43 insertions(+), 35 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 07cf72e72c..2dd794dfe7 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1569,9 +1569,10 @@ class QAPISchemaMember(object):
     """ Represents object members, enum members and features """
     role =3D 'member'
=20
-    def __init__(self, name, ifcond=3DNone):
+    def __init__(self, name, info, ifcond=3DNone):
         assert isinstance(name, str)
         self.name =3D name
+        self.info =3D info
         self.ifcond =3D ifcond or []
         self.defined_in =3D None
=20
@@ -1627,8 +1628,8 @@ class QAPISchemaFeature(QAPISchemaMember):
=20
=20
 class QAPISchemaObjectTypeMember(QAPISchemaMember):
-    def __init__(self, name, typ, optional, ifcond=3DNone):
-        QAPISchemaMember.__init__(self, name, ifcond)
+    def __init__(self, name, info, typ, optional, ifcond=3DNone):
+        QAPISchemaMember.__init__(self, name, info, ifcond)
         assert isinstance(typ, str)
         assert isinstance(optional, bool)
         self._type_name =3D typ
@@ -1642,7 +1643,7 @@ class QAPISchemaObjectTypeMember(QAPISchemaMember):
=20
=20
 class QAPISchemaObjectTypeVariants(object):
-    def __init__(self, tag_name, tag_member, variants):
+    def __init__(self, tag_name, info, tag_member, variants):
         # Flat unions pass tag_name but not tag_member.
         # Simple unions and alternates pass tag_member but not tag_name.
         # After check(), tag_member is always set, and tag_name remains
@@ -1653,6 +1654,7 @@ class QAPISchemaObjectTypeVariants(object):
         for v in variants:
             assert isinstance(v, QAPISchemaObjectTypeVariant)
         self._tag_name =3D tag_name
+        self.info =3D info
         self.tag_member =3D tag_member
         self.variants =3D variants
=20
@@ -1672,8 +1674,8 @@ class QAPISchemaObjectTypeVariants(object):
             cases =3D set([v.name for v in self.variants])
             for m in self.tag_member.type.members:
                 if m.name not in cases:
-                    v =3D QAPISchemaObjectTypeVariant(m.name, 'q_empty',
-                                                    m.ifcond)
+                    v =3D QAPISchemaObjectTypeVariant(m.name, self.info,
+                                                    'q_empty', m.ifcond)
                     v.set_defined_in(self.tag_member.defined_in)
                     self.variants.append(v)
         assert self.variants
@@ -1697,8 +1699,9 @@ class QAPISchemaObjectTypeVariants(object):
 class QAPISchemaObjectTypeVariant(QAPISchemaObjectTypeMember):
     role =3D 'branch'
=20
-    def __init__(self, name, typ, ifcond=3DNone):
-        QAPISchemaObjectTypeMember.__init__(self, name, typ, False, ifco=
nd)
+    def __init__(self, name, info, typ, ifcond=3DNone):
+        QAPISchemaObjectTypeMember.__init__(self, name, info, typ,
+                                            False, ifcond)
=20
=20
 class QAPISchemaAlternateType(QAPISchemaType):
@@ -1874,23 +1877,26 @@ class QAPISchema(object):
=20
         qtypes =3D ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist'=
,
                   'qbool']
-        qtype_values =3D self._make_enum_members([{'name': n} for n in q=
types])
+        qtype_values =3D self._make_enum_members(
+            [{'name': n} for n in qtypes], None)
=20
         self._def_entity(QAPISchemaEnumType('QType', None, None, None,
                                             qtype_values, 'QTYPE'))
=20
-    def _make_features(self, features):
-        return [QAPISchemaFeature(f['name'], f.get('if')) for f in featu=
res]
+    def _make_features(self, features, info):
+        return [QAPISchemaFeature(f['name'], info, f.get('if'))
+                for f in features]
=20
-    def _make_enum_members(self, values):
-        return [QAPISchemaEnumMember(v['name'], v.get('if'))
+    def _make_enum_members(self, values, info):
+        return [QAPISchemaEnumMember(v['name'], info, v.get('if'))
                 for v in values]
=20
     def _make_implicit_enum_type(self, name, info, ifcond, values):
         # See also QAPISchemaObjectTypeMember.describe()
         name =3D name + 'Kind'    # reserved by check_defn_name_str()
         self._def_entity(QAPISchemaEnumType(
-            name, info, None, ifcond, self._make_enum_members(values), N=
one))
+            name, info, None, ifcond, self._make_enum_members(values, in=
fo),
+            None))
         return name
=20
     def _make_array_type(self, element_type, info):
@@ -1929,7 +1935,7 @@ class QAPISchema(object):
         ifcond =3D expr.get('if')
         self._def_entity(QAPISchemaEnumType(
             name, info, doc, ifcond,
-            self._make_enum_members(data), prefix))
+            self._make_enum_members(data, info), prefix))
=20
     def _make_member(self, name, typ, ifcond, info):
         optional =3D False
@@ -1939,7 +1945,7 @@ class QAPISchema(object):
         if isinstance(typ, list):
             assert len(typ) =3D=3D 1
             typ =3D self._make_array_type(typ[0], info)
-        return QAPISchemaObjectTypeMember(name, typ, optional, ifcond)
+        return QAPISchemaObjectTypeMember(name, info, typ, optional, ifc=
ond)
=20
     def _make_members(self, data, info):
         return [self._make_member(key, value['type'], value.get('if'), i=
nfo)
@@ -1951,13 +1957,14 @@ class QAPISchema(object):
         data =3D expr['data']
         ifcond =3D expr.get('if')
         features =3D expr.get('features', [])
-        self._def_entity(QAPISchemaObjectType(name, info, doc, ifcond, b=
ase,
-                                              self._make_members(data, i=
nfo),
-                                              None,
-                                              self._make_features(featur=
es)))
+        self._def_entity(QAPISchemaObjectType(
+            name, info, doc, ifcond, base,
+            self._make_members(data, info),
+            None,
+            self._make_features(features, info)))
=20
-    def _make_variant(self, case, typ, ifcond):
-        return QAPISchemaObjectTypeVariant(case, typ, ifcond)
+    def _make_variant(self, case, typ, ifcond, info):
+        return QAPISchemaObjectTypeVariant(case, info, typ, ifcond)
=20
     def _make_simple_variant(self, case, typ, ifcond, info):
         if isinstance(typ, list):
@@ -1966,7 +1973,7 @@ class QAPISchema(object):
         typ =3D self._make_implicit_object_type(
             typ, info, None, self.lookup_type(typ),
             'wrapper', [self._make_member('data', typ, None, info)])
-        return QAPISchemaObjectTypeVariant(case, typ, ifcond)
+        return QAPISchemaObjectTypeVariant(case, info, typ, ifcond)
=20
     def _def_union_type(self, expr, info, doc):
         name =3D expr['union']
@@ -1980,7 +1987,8 @@ class QAPISchema(object):
                 name, info, doc, ifcond,
                 'base', self._make_members(base, info))
         if tag_name:
-            variants =3D [self._make_variant(key, value['type'], value.g=
et('if'))
+            variants =3D [self._make_variant(key, value['type'],
+                                           value.get('if'), info)
                         for (key, value) in data.items()]
             members =3D []
         else:
@@ -1989,26 +1997,26 @@ class QAPISchema(object):
                         for (key, value) in data.items()]
             enum =3D [{'name': v.name, 'if': v.ifcond} for v in variants=
]
             typ =3D self._make_implicit_enum_type(name, info, ifcond, en=
um)
-            tag_member =3D QAPISchemaObjectTypeMember('type', typ, False=
)
+            tag_member =3D QAPISchemaObjectTypeMember('type', info, typ,=
 False)
             members =3D [tag_member]
         self._def_entity(
             QAPISchemaObjectType(name, info, doc, ifcond, base, members,
-                                 QAPISchemaObjectTypeVariants(tag_name,
-                                                              tag_member=
,
-                                                              variants),=
 []))
+                                 QAPISchemaObjectTypeVariants(
+                                     tag_name, info, tag_member, variant=
s),
+                                 []))
=20
     def _def_alternate_type(self, expr, info, doc):
         name =3D expr['alternate']
         data =3D expr['data']
         ifcond =3D expr.get('if')
-        variants =3D [self._make_variant(key, value['type'], value.get('=
if'))
+        variants =3D [self._make_variant(key, value['type'], value.get('=
if'),
+                                       info)
                     for (key, value) in data.items()]
-        tag_member =3D QAPISchemaObjectTypeMember('type', 'QType', False=
)
+        tag_member =3D QAPISchemaObjectTypeMember('type', info, 'QType',=
 False)
         self._def_entity(
             QAPISchemaAlternateType(name, info, doc, ifcond,
-                                    QAPISchemaObjectTypeVariants(None,
-                                                                 tag_mem=
ber,
-                                                                 variant=
s)))
+                                    QAPISchemaObjectTypeVariants(
+                                        None, info, tag_member, variants=
)))
=20
     def _def_command(self, expr, info, doc):
         name =3D expr['command']
@@ -2300,7 +2308,7 @@ const QEnumLookup %(c_name)s_lookup =3D {
=20
 def gen_enum(name, members, prefix=3DNone):
     # append automatically generated _MAX value
-    enum_members =3D members + [QAPISchemaEnumMember('_MAX')]
+    enum_members =3D members + [QAPISchemaEnumMember('_MAX', None)]
=20
     ret =3D mcgen('''
=20
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index 7062553cf3..7308e8e589 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -194,7 +194,7 @@ void %(event_emit)s(%(event_enum)s event, QDict *qdic=
t);
                                           self._event_emit_name))
         # Note: we generate the enum member regardless of @ifcond, to
         # keep the enumeration usable in target-independent code.
-        self._event_enum_members.append(QAPISchemaEnumMember(name))
+        self._event_enum_members.append(QAPISchemaEnumMember(name, None)=
)
=20
=20
 def gen_events(schema, output_dir, prefix):
--=20
2.21.0


