Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A4AC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:15:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60BB220735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDw3FaX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60BB220735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEB8U-0002hU-Fs
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 08:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEAop-0000Da-JI
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEAoo-0008Bh-6j
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:35 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:25018)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEAoo-00088A-1G
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584446133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bBypn0WmvXJtvIQptVIylzIgB0vIczmMxB341Fjd2io=;
 b=WDw3FaX2cOEeeQ5pzJ1THgWWcFhVKYz7sVOIRnimLhny3xpr4vNSw8hkD33OMKQOeTjB2a
 RiSq4Qa1Q4LKzqlQ3ysIK06R4CDhu3fJ9FYRKQfZnknOXoBaMy6S8psgrBbCl+yW3OZk0X
 hDog3fY8p2edomstcwC/ln+hVwb/EjM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170--MrmuDgPOx6XBG97CtHW5g-1; Tue, 17 Mar 2020 07:55:18 -0400
X-MC-Unique: -MrmuDgPOx6XBG97CtHW5g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6527E8024F4;
 Tue, 17 Mar 2020 11:55:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B257E92D5C;
 Tue, 17 Mar 2020 11:55:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 432191135A56; Tue, 17 Mar 2020 12:55:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 15/34] qapi/introspect: Factor out _make_tree()
Date: Tue, 17 Mar 2020 12:54:40 +0100
Message-Id: <20200317115459.31821-16-armbru@redhat.com>
In-Reply-To: <20200317115459.31821-1-armbru@redhat.com>
References: <20200317115459.31821-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

The value of @qmp_schema_qlit is generated from an expression tree.
Tree nodes are created in several places.  Factor out the common code
into _make_tree().  This isn't much of a win now.  It will pay off
when we add feature flags in the next few commits.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/introspect.py | 44 +++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index e4fc9d90f1..a3fa9865db 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -16,6 +16,18 @@ from qapi.schema import (QAPISchemaArrayType, QAPISchema=
BuiltinType,
                          QAPISchemaType)
=20
=20
+def _make_tree(obj, ifcond, features, extra=3DNone):
+    if extra is None:
+        extra =3D {}
+    if ifcond:
+        extra['if'] =3D ifcond
+    if features:
+        obj['features'] =3D [(f.name, {'if': f.ifcond}) for f in features]
+    if extra:
+        return (obj, extra)
+    return obj
+
+
 def _tree_to_qlit(obj, level=3D0, suppress_first_indent=3DFalse):
=20
     def indent(level):
@@ -146,47 +158,38 @@ const QLitObject %(c_name)s =3D %(c_string)s;
         return self._name(typ.name)
=20
     def _gen_tree(self, name, mtype, obj, ifcond, features):
-        extra =3D {}
+        extra =3D None
         if mtype not in ('command', 'event', 'builtin', 'array'):
             if not self._unmask:
                 # Output a comment to make it easy to map masked names
                 # back to the source when reading the generated output.
-                extra['comment'] =3D '"%s" =3D %s' % (self._name(name), na=
me)
+                extra =3D {'comment': '"%s" =3D %s' % (self._name(name), n=
ame)}
             name =3D self._name(name)
         obj['name'] =3D name
         obj['meta-type'] =3D mtype
-        if features:
-            obj['features'] =3D [(f.name, {'if': f.ifcond}) for f in featu=
res]
-        if ifcond:
-            extra['if'] =3D ifcond
-        if extra:
-            self._trees.append((obj, extra))
-        else:
-            self._trees.append(obj)
+        self._trees.append(_make_tree(obj, ifcond, features, extra))
=20
     def _gen_member(self, member):
-        ret =3D {'name': member.name, 'type': self._use_type(member.type)}
+        obj =3D {'name': member.name, 'type': self._use_type(member.type)}
         if member.optional:
-            ret['default'] =3D None
-        if member.ifcond:
-            ret =3D (ret, {'if': member.ifcond})
-        return ret
+            obj['default'] =3D None
+        return _make_tree(obj, member.ifcond, None)
=20
     def _gen_variants(self, tag_name, variants):
         return {'tag': tag_name,
                 'variants': [self._gen_variant(v) for v in variants]}
=20
     def _gen_variant(self, variant):
-        return ({'case': variant.name, 'type': self._use_type(variant.type=
)},
-                {'if': variant.ifcond})
+        obj =3D {'case': variant.name, 'type': self._use_type(variant.type=
)}
+        return _make_tree(obj, variant.ifcond, None)
=20
     def visit_builtin_type(self, name, info, json_type):
         self._gen_tree(name, 'builtin', {'json-type': json_type}, [], None=
)
=20
     def visit_enum_type(self, name, info, ifcond, features, members, prefi=
x):
         self._gen_tree(name, 'enum',
-                       {'values':
-                        [(m.name, {'if': m.ifcond}) for m in members]},
+                       {'values': [_make_tree(m.name, m.ifcond, None)
+                                   for m in members]},
                        ifcond, features)
=20
     def visit_array_type(self, name, info, ifcond, element_type):
@@ -206,7 +209,8 @@ const QLitObject %(c_name)s =3D %(c_string)s;
     def visit_alternate_type(self, name, info, ifcond, features, variants)=
:
         self._gen_tree(name, 'alternate',
                        {'members': [
-                           ({'type': self._use_type(m.type)}, {'if': m.ifc=
ond})
+                           _make_tree({'type': self._use_type(m.type)},
+                                      m.ifcond, None)
                            for m in variants.variants]},
                        ifcond, features)
=20
--=20
2.21.1


