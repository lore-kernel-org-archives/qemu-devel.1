Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A381C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:05:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9FA020736
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQAwenG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9FA020736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEAyN-0007dL-Ti
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 08:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEAoa-0008CR-48
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEAoY-0006ky-4Z
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:55690)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEAoX-0006iO-U1
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584446117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=une4xGgZT160EAMFqaHMHMGsITsc/Uj+p02OpPoV6pY=;
 b=RQAwenG/uqiPCWshO3x4uca2GTmNWZ39YauQS7jhQ+sP8uzoHyVHnpxxLZe4zeLUOdkf70
 wLOmaR4Re0pxURP8XAQhrptnDl2UhfbBMZGR8tjWceTX7ODn6vCLsDO/3heG2knWKmv9Zo
 idUooCJmCyJMVoG6Z62gZKwe4NBM6jg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-LxPzqZIdMuWAKNfUjF0xrw-1; Tue, 17 Mar 2020 07:55:15 -0400
X-MC-Unique: LxPzqZIdMuWAKNfUjF0xrw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4CBF149CC;
 Tue, 17 Mar 2020 11:55:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 035091E4;
 Tue, 17 Mar 2020 11:55:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 519041135A63; Tue, 17 Mar 2020 12:55:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 18/34] qapi/schema: Rename QAPISchemaObjectType{Variant,
 Variants}
Date: Tue, 17 Mar 2020 12:54:43 +0100
Message-Id: <20200317115459.31821-19-armbru@redhat.com>
In-Reply-To: <20200317115459.31821-1-armbru@redhat.com>
References: <20200317115459.31821-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

QAPISchemaObjectTypeVariants represents both object type and alternate
type variants.  Rename to QAPISchemaVariants.

Rename QAPISchemaObjectTypeVariant the same way.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/schema.py | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 0acf8b466f..033c84c4a0 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -338,7 +338,7 @@ class QAPISchemaObjectType(QAPISchemaType):
             assert isinstance(m, QAPISchemaObjectTypeMember)
             m.set_defined_in(name)
         if variants is not None:
-            assert isinstance(variants, QAPISchemaObjectTypeVariants)
+            assert isinstance(variants, QAPISchemaVariants)
             variants.set_defined_in(name)
         self._base_name =3D base
         self.base =3D None
@@ -449,7 +449,7 @@ class QAPISchemaAlternateType(QAPISchemaType):
=20
     def __init__(self, name, info, doc, ifcond, features, variants):
         super().__init__(name, info, doc, ifcond, features)
-        assert isinstance(variants, QAPISchemaObjectTypeVariants)
+        assert isinstance(variants, QAPISchemaVariants)
         assert variants.tag_member
         variants.set_defined_in(name)
         variants.tag_member.set_defined_in(self.name)
@@ -512,7 +512,7 @@ class QAPISchemaAlternateType(QAPISchemaType):
             self.name, self.info, self.ifcond, self.features, self.variant=
s)
=20
=20
-class QAPISchemaObjectTypeVariants:
+class QAPISchemaVariants:
     def __init__(self, tag_name, info, tag_member, variants):
         # Flat unions pass tag_name but not tag_member.
         # Simple unions and alternates pass tag_member but not tag_name.
@@ -522,7 +522,7 @@ class QAPISchemaObjectTypeVariants:
         assert (isinstance(tag_name, str) or
                 isinstance(tag_member, QAPISchemaObjectTypeMember))
         for v in variants:
-            assert isinstance(v, QAPISchemaObjectTypeVariant)
+            assert isinstance(v, QAPISchemaVariant)
         self._tag_name =3D tag_name
         self.info =3D info
         self.tag_member =3D tag_member
@@ -572,8 +572,8 @@ class QAPISchemaObjectTypeVariants:
             cases =3D {v.name for v in self.variants}
             for m in self.tag_member.type.members:
                 if m.name not in cases:
-                    v =3D QAPISchemaObjectTypeVariant(m.name, self.info,
-                                                    'q_empty', m.ifcond)
+                    v =3D QAPISchemaVariant(m.name, self.info,
+                                          'q_empty', m.ifcond)
                     v.set_defined_in(self.tag_member.defined_in)
                     self.variants.append(v)
         if not self.variants:
@@ -681,7 +681,7 @@ class QAPISchemaObjectTypeMember(QAPISchemaMember):
                                         self.describe)
=20
=20
-class QAPISchemaObjectTypeVariant(QAPISchemaObjectTypeMember):
+class QAPISchemaVariant(QAPISchemaObjectTypeMember):
     role =3D 'branch'
=20
     def __init__(self, name, info, typ, ifcond=3DNone):
@@ -987,7 +987,7 @@ class QAPISchema:
             None))
=20
     def _make_variant(self, case, typ, ifcond, info):
-        return QAPISchemaObjectTypeVariant(case, info, typ, ifcond)
+        return QAPISchemaVariant(case, info, typ, ifcond)
=20
     def _make_simple_variant(self, case, typ, ifcond, info):
         if isinstance(typ, list):
@@ -996,7 +996,7 @@ class QAPISchema:
         typ =3D self._make_implicit_object_type(
             typ, info, self.lookup_type(typ),
             'wrapper', [self._make_member('data', typ, None, info)])
-        return QAPISchemaObjectTypeVariant(case, info, typ, ifcond)
+        return QAPISchemaVariant(case, info, typ, ifcond)
=20
     def _def_union_type(self, expr, info, doc):
         name =3D expr['union']
@@ -1026,7 +1026,7 @@ class QAPISchema:
         self._def_entity(
             QAPISchemaObjectType(name, info, doc, ifcond, features,
                                  base, members,
-                                 QAPISchemaObjectTypeVariants(
+                                 QAPISchemaVariants(
                                      tag_name, info, tag_member, variants)=
))
=20
     def _def_alternate_type(self, expr, info, doc):
@@ -1040,7 +1040,7 @@ class QAPISchema:
         tag_member =3D QAPISchemaObjectTypeMember('type', info, 'QType', F=
alse)
         self._def_entity(
             QAPISchemaAlternateType(name, info, doc, ifcond, features,
-                                    QAPISchemaObjectTypeVariants(
+                                    QAPISchemaVariants(
                                         None, info, tag_member, variants))=
)
=20
     def _def_command(self, expr, info, doc):
--=20
2.21.1


