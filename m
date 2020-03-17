Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70ACC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9179B2073C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="giCwWzPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9179B2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEB1C-0005SS-N5
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 08:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEAoc-0008HG-Ng
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEAoa-0006xg-9o
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:22 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:27021)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEAoa-0006tf-1h
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584446119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FBfqP4hIPTb5VFxn3RgdzfQuJ8b0Cqp1te5HxvWNdPg=;
 b=giCwWzPdH5ZhbBHNbay5TBGvOWTW0XSk3wrhp1X6bUt8RDjbhbXlxSf3JIkIV9x6XS0qk/
 9aZa4x43HCWzWHUbVJ8HsWyBU2RdEO4j6evFtKr06pCIk1rSL+jPVIeYnFyWeVOmeMdhro
 VRBqFol9GcZgnclrcgRF+z1dNg/HnYc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-BHfKcf89OIm2WFtKGZJOLw-1; Tue, 17 Mar 2020 07:55:17 -0400
X-MC-Unique: BHfKcf89OIm2WFtKGZJOLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB153100DFDE;
 Tue, 17 Mar 2020 11:55:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0818519757;
 Tue, 17 Mar 2020 11:55:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 564EA1135A64; Tue, 17 Mar 2020 12:55:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 19/34] qapi/schema: Call QAPIDoc.connect_member() in just
 one place
Date: Tue, 17 Mar 2020 12:54:44 +0100
Message-Id: <20200317115459.31821-20-armbru@redhat.com>
In-Reply-To: <20200317115459.31821-1-armbru@redhat.com>
References: <20200317115459.31821-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

The .connect_doc() of classes that have QAPISchemaMember connect them
to their documentation.  Change them to delegate the actual work to
new QAPISchemaMember.connect_doc().  Matches the .connect_doc() that
already exist.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/schema.py | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 033c84c4a0..59e1f5a395 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -252,9 +252,8 @@ class QAPISchemaEnumType(QAPISchemaType):
     def connect_doc(self, doc=3DNone):
         super().connect_doc(doc)
         doc =3D doc or self.doc
-        if doc:
-            for m in self.members:
-                doc.connect_member(m)
+        for m in self.members:
+            m.connect_doc(doc)
=20
     def is_implicit(self):
         # See QAPISchema._make_implicit_enum_type() and ._def_predefineds(=
)
@@ -396,11 +395,10 @@ class QAPISchemaObjectType(QAPISchemaType):
     def connect_doc(self, doc=3DNone):
         super().connect_doc(doc)
         doc =3D doc or self.doc
-        if doc:
-            if self.base and self.base.is_implicit():
-                self.base.connect_doc(doc)
-            for m in self.local_members:
-                doc.connect_member(m)
+        if self.base and self.base.is_implicit():
+            self.base.connect_doc(doc)
+        for m in self.local_members:
+            m.connect_doc(doc)
=20
     @property
     def ifcond(self):
@@ -496,9 +494,8 @@ class QAPISchemaAlternateType(QAPISchemaType):
     def connect_doc(self, doc=3DNone):
         super().connect_doc(doc)
         doc =3D doc or self.doc
-        if doc:
-            for v in self.variants.variants:
-                doc.connect_member(v)
+        for v in self.variants.variants:
+            v.connect_doc(doc)
=20
     def c_type(self):
         return c_name(self.name) + pointer_suffix
@@ -627,6 +624,10 @@ class QAPISchemaMember:
                 % (self.describe(info), seen[cname].describe(info)))
         seen[cname] =3D self
=20
+    def connect_doc(self, doc):
+        if doc:
+            doc.connect_member(self)
+
     def describe(self, info):
         role =3D self.role
         defined_in =3D self.defined_in
--=20
2.21.1


