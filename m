Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBAFC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:15:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4694720735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8oaecmA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4694720735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60061 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEB7g-0000hq-Cf
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 08:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEAoq-0000GN-VM
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEAop-0008JG-Ei
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:36 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:46945)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEAop-0008Gd-98
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584446134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=93Rwp/6Y0/ev1Q+rHH85YoKP9imLZBHWRL9X2s+GWiY=;
 b=E8oaecmAymIJIzcutlO+Npr2hLXZ3qt1b8kiT/HSKT1QRLikVEN+PDIv9bUAf11X0XhH7M
 nDU2F946rSQZSgq7nZo57956fFtEw+kFaUQ3g2GNddwPDFP+7E4WsJdyjyaLoWp8U6P7Kn
 m7kZAAp5GWIJyYPw2gBbg9Ikcg9oUVE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-TYtK9f7CNgyINIfIAsQ6iQ-1; Tue, 17 Mar 2020 07:55:10 -0400
X-MC-Unique: TYtK9f7CNgyINIfIAsQ6iQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C56051005513;
 Tue, 17 Mar 2020 11:55:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 560E110027A8;
 Tue, 17 Mar 2020 11:55:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3E4B9113639C; Tue, 17 Mar 2020 12:55:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 14/34] qapi/introspect: Rename *qlit* to reduce confusion
Date: Tue, 17 Mar 2020 12:54:39 +0100
Message-Id: <20200317115459.31821-15-armbru@redhat.com>
In-Reply-To: <20200317115459.31821-1-armbru@redhat.com>
References: <20200317115459.31821-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

We generate the value of qmp_schema_qlit from an expression tree.  The
function doing that is named to_qlit(), and its inputs are accumulated
in QAPISchemaGenIntrospectVisitor._qlits.  We call both its input and
its output "qlit".  This is confusing.

Use "tree" for input, and "qlit" only for output: rename to_qlit() to
_tree_to_qlit(), ._qlits to ._trees, ._gen_qlit() to ._gen_tree().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/introspect.py | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index b54910510d..e4fc9d90f1 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -16,7 +16,7 @@ from qapi.schema import (QAPISchemaArrayType, QAPISchemaB=
uiltinType,
                          QAPISchemaType)
=20
=20
-def to_qlit(obj, level=3D0, suppress_first_indent=3DFalse):
+def _tree_to_qlit(obj, level=3D0, suppress_first_indent=3DFalse):
=20
     def indent(level):
         return level * 4 * ' '
@@ -30,7 +30,7 @@ def to_qlit(obj, level=3D0, suppress_first_indent=3DFalse=
):
             ret +=3D indent(level) + '/* %s */\n' % comment
         if ifcond:
             ret +=3D gen_if(ifcond)
-        ret +=3D to_qlit(ifobj, level)
+        ret +=3D _tree_to_qlit(ifobj, level)
         if ifcond:
             ret +=3D '\n' + gen_endif(ifcond)
         return ret
@@ -43,7 +43,7 @@ def to_qlit(obj, level=3D0, suppress_first_indent=3DFalse=
):
     elif isinstance(obj, str):
         ret +=3D 'QLIT_QSTR(' + to_c_string(obj) + ')'
     elif isinstance(obj, list):
-        elts =3D [to_qlit(elt, level + 1).strip('\n')
+        elts =3D [_tree_to_qlit(elt, level + 1).strip('\n')
                 for elt in obj]
         elts.append(indent(level + 1) + "{}")
         ret +=3D 'QLIT_QLIST(((QLitObject[]) {\n'
@@ -53,7 +53,8 @@ def to_qlit(obj, level=3D0, suppress_first_indent=3DFalse=
):
         elts =3D []
         for key, value in sorted(obj.items()):
             elts.append(indent(level + 1) + '{ %s, %s }' %
-                        (to_c_string(key), to_qlit(value, level + 1, True)=
))
+                        (to_c_string(key),
+                         _tree_to_qlit(value, level + 1, True)))
         elts.append(indent(level + 1) + '{}')
         ret +=3D 'QLIT_QDICT(((QLitDictEntry[]) {\n'
         ret +=3D ',\n'.join(elts) + '\n'
@@ -79,7 +80,7 @@ class QAPISchemaGenIntrospectVisitor(QAPISchemaMonolithic=
CVisitor):
             ' * QAPI/QMP schema introspection', __doc__)
         self._unmask =3D unmask
         self._schema =3D None
-        self._qlits =3D []
+        self._trees =3D []
         self._used_types =3D []
         self._name_map =3D {}
         self._genc.add(mcgen('''
@@ -108,9 +109,9 @@ extern const QLitObject %(c_name)s;
 const QLitObject %(c_name)s =3D %(c_string)s;
 ''',
                              c_name=3Dc_name(name),
-                             c_string=3Dto_qlit(self._qlits)))
+                             c_string=3D_tree_to_qlit(self._trees)))
         self._schema =3D None
-        self._qlits =3D []
+        self._trees =3D []
         self._used_types =3D []
         self._name_map =3D {}
=20
@@ -144,7 +145,7 @@ const QLitObject %(c_name)s =3D %(c_string)s;
             return '[' + self._use_type(typ.element_type) + ']'
         return self._name(typ.name)
=20
-    def _gen_qlit(self, name, mtype, obj, ifcond, features):
+    def _gen_tree(self, name, mtype, obj, ifcond, features):
         extra =3D {}
         if mtype not in ('command', 'event', 'builtin', 'array'):
             if not self._unmask:
@@ -159,9 +160,9 @@ const QLitObject %(c_name)s =3D %(c_string)s;
         if ifcond:
             extra['if'] =3D ifcond
         if extra:
-            self._qlits.append((obj, extra))
+            self._trees.append((obj, extra))
         else:
-            self._qlits.append(obj)
+            self._trees.append(obj)
=20
     def _gen_member(self, member):
         ret =3D {'name': member.name, 'type': self._use_type(member.type)}
@@ -180,17 +181,17 @@ const QLitObject %(c_name)s =3D %(c_string)s;
                 {'if': variant.ifcond})
=20
     def visit_builtin_type(self, name, info, json_type):
-        self._gen_qlit(name, 'builtin', {'json-type': json_type}, [], None=
)
+        self._gen_tree(name, 'builtin', {'json-type': json_type}, [], None=
)
=20
     def visit_enum_type(self, name, info, ifcond, features, members, prefi=
x):
-        self._gen_qlit(name, 'enum',
+        self._gen_tree(name, 'enum',
                        {'values':
                         [(m.name, {'if': m.ifcond}) for m in members]},
                        ifcond, features)
=20
     def visit_array_type(self, name, info, ifcond, element_type):
         element =3D self._use_type(element_type)
-        self._gen_qlit('[' + element + ']', 'array', {'element-type': elem=
ent},
+        self._gen_tree('[' + element + ']', 'array', {'element-type': elem=
ent},
                        ifcond, None)
=20
     def visit_object_type_flat(self, name, info, ifcond, features,
@@ -200,10 +201,10 @@ const QLitObject %(c_name)s =3D %(c_string)s;
             obj.update(self._gen_variants(variants.tag_member.name,
                                           variants.variants))
=20
-        self._gen_qlit(name, 'object', obj, ifcond, features)
+        self._gen_tree(name, 'object', obj, ifcond, features)
=20
     def visit_alternate_type(self, name, info, ifcond, features, variants)=
:
-        self._gen_qlit(name, 'alternate',
+        self._gen_tree(name, 'alternate',
                        {'members': [
                            ({'type': self._use_type(m.type)}, {'if': m.ifc=
ond})
                            for m in variants.variants]},
@@ -218,11 +219,11 @@ const QLitObject %(c_name)s =3D %(c_string)s;
                'ret-type': self._use_type(ret_type)}
         if allow_oob:
             obj['allow-oob'] =3D allow_oob
-        self._gen_qlit(name, 'command', obj, ifcond, features)
+        self._gen_tree(name, 'command', obj, ifcond, features)
=20
     def visit_event(self, name, info, ifcond, features, arg_type, boxed):
         arg_type =3D arg_type or self._schema.the_empty_object_type
-        self._gen_qlit(name, 'event', {'arg-type': self._use_type(arg_type=
)},
+        self._gen_tree(name, 'event', {'arg-type': self._use_type(arg_type=
)},
                        ifcond, features)
=20
=20
--=20
2.21.1


