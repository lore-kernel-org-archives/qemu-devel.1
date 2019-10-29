Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE94CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:45:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1095821479
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OnDHmknC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1095821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPP02-0003G8-7Y
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 06:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iPOeN-0005lS-UU
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iPOeM-0001O2-94
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48549
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iPOeM-0001NR-4t
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572344573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6PdSov71UGXpNm7DJ43bZBDSsa0rrhme+3USYG+Ez+I=;
 b=OnDHmknCv+qVGFOP6I7RT5+r9yOd+dSyGz9IVZlANyvyYzj75TP6HxMihyDXsdHEWKXgCb
 y1E8v/l1tThkXKtL8R3SXkDVxkBoS57b3UWtXD28cKmke+pN8NDG6ApuyhSFTakIGXLUFv
 YoMNR7mJ0NiHqHvZ5eEvDJiQu0LU/WQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-2uUfjVWxPd6Jwk0b-kir_Q-1; Tue, 29 Oct 2019 06:22:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 017FA180496F
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 10:22:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BD87194BE
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 10:22:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B04EB11326EC; Tue, 29 Oct 2019 11:22:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/19] qapi: Lift features into QAPISchemaEntity
Date: Tue, 29 Oct 2019 11:22:26 +0100
Message-Id: <20191029102228.20740-18-armbru@redhat.com>
In-Reply-To: <20191029102228.20740-1-armbru@redhat.com>
References: <20191029102228.20740-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 2uUfjVWxPd6Jwk0b-kir_Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 6a8c0b5102 "qapi: Add feature flags to struct types" added
features to QAPISchemaObjectType.  Commit a95daa5093 "qapi: Add
feature flags to commands in qapi" added them to QAPISchemaCommand,
duplicating the code.  Tolerable, but the duplication will only get
worse as we add features to more definitions.

To de-duplicate, lift features from QAPISchemaObjectType and
QAPISchemaCommand into QAPISchemaEntity.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20191024110237.30963-18-armbru@redhat.com>
---
 scripts/qapi/schema.py | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index ee510f129b..bdea9482fc 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -27,8 +27,11 @@ from qapi.parser import QAPISchemaParser
 class QAPISchemaEntity(object):
     meta =3D None
=20
-    def __init__(self, name, info, doc, ifcond=3DNone):
+    def __init__(self, name, info, doc, ifcond=3DNone, features=3DNone):
         assert name is None or isinstance(name, str)
+        for f in features or []:
+            assert isinstance(f, QAPISchemaFeature)
+            f.set_defined_in(name)
         self.name =3D name
         self._module =3D None
         # For explicitly defined entities, info points to the (explicit)
@@ -39,6 +42,7 @@ class QAPISchemaEntity(object):
         self.info =3D info
         self.doc =3D doc
         self._ifcond =3D ifcond or []
+        self.features =3D features or []
         self._checked =3D False
=20
     def c_name(self):
@@ -49,6 +53,10 @@ class QAPISchemaEntity(object):
         if self.info:
             self._module =3D os.path.relpath(self.info.fname,
                                            os.path.dirname(schema.fname))
+        seen =3D {}
+        for f in self.features:
+            f.check_clash(self.info, seen)
+
         self._checked =3D True
=20
     def connect_doc(self, doc=3DNone):
@@ -307,7 +315,7 @@ class QAPISchemaObjectType(QAPISchemaType):
         # struct has local_members, optional base, and no variants
         # flat union has base, variants, and no local_members
         # simple union has local_members, variants, and no base
-        QAPISchemaType.__init__(self, name, info, doc, ifcond)
+        QAPISchemaType.__init__(self, name, info, doc, ifcond, features)
         self.meta =3D 'union' if variants else 'struct'
         assert base is None or isinstance(base, str)
         for m in local_members:
@@ -316,15 +324,11 @@ class QAPISchemaObjectType(QAPISchemaType):
         if variants is not None:
             assert isinstance(variants, QAPISchemaObjectTypeVariants)
             variants.set_defined_in(name)
-        for f in features:
-            assert isinstance(f, QAPISchemaFeature)
-            f.set_defined_in(name)
         self._base_name =3D base
         self.base =3D None
         self.local_members =3D local_members
         self.variants =3D variants
         self.members =3D None
-        self.features =3D features
=20
     def check(self, schema):
         # This calls another type T's .check() exactly when the C
@@ -362,11 +366,6 @@ class QAPISchemaObjectType(QAPISchemaType):
             self.variants.check(schema, seen)
             self.variants.check_clash(self.info, seen)
=20
-        # Features are in a name space separate from members
-        seen =3D {}
-        for f in self.features:
-            f.check_clash(self.info, seen)
-
         self.members =3D members  # mark completed
=20
     # Check that the members of this type do not cause duplicate JSON memb=
ers,
@@ -678,12 +677,9 @@ class QAPISchemaCommand(QAPISchemaEntity):
     def __init__(self, name, info, doc, ifcond, arg_type, ret_type,
                  gen, success_response, boxed, allow_oob, allow_preconfig,
                  features):
-        QAPISchemaEntity.__init__(self, name, info, doc, ifcond)
+        QAPISchemaEntity.__init__(self, name, info, doc, ifcond, features)
         assert not arg_type or isinstance(arg_type, str)
         assert not ret_type or isinstance(ret_type, str)
-        for f in features:
-            assert isinstance(f, QAPISchemaFeature)
-            f.set_defined_in(name)
         self._arg_type_name =3D arg_type
         self.arg_type =3D None
         self._ret_type_name =3D ret_type
@@ -693,7 +689,6 @@ class QAPISchemaCommand(QAPISchemaEntity):
         self.boxed =3D boxed
         self.allow_oob =3D allow_oob
         self.allow_preconfig =3D allow_preconfig
-        self.features =3D features
=20
     def check(self, schema):
         QAPISchemaEntity.check(self, schema)
@@ -723,11 +718,6 @@ class QAPISchemaCommand(QAPISchemaEntity):
                         "command's 'returns' cannot take %s"
                         % self.ret_type.describe())
=20
-        # Features are in a name space separate from members
-        seen =3D {}
-        for f in self.features:
-            f.check_clash(self.info, seen)
-
     def connect_doc(self, doc=3DNone):
         doc =3D doc or self.doc
         if doc:
--=20
2.21.0


