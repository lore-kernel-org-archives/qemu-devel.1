Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FA8CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:37:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E38420874
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHqeQ5tT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E38420874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPOsh-0005YF-AP
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 06:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iPOeG-0005Zc-R5
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iPOeF-0001F9-8z
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33146
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iPOeF-0001Da-3x
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572344565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v0sDzd1QgfzfoduOKf+MrIaSH480l27auLMgWPhFZOU=;
 b=RHqeQ5tTbMkGXxflvw9YVvA4Y5Rl2DLCH66gd8ndmtf/9njGUviFhUAQusW67wHwltbN39
 LseBdMMUvXGYz4YlOqWDhz8zOVqEvJ4Ue9ytcBiXkNexu6RNliHKkLcaSLCHgtDxi5d+yU
 bnckImPO1b/hbm2U2d47hmMljYkSkS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-cULfyEMmPciLtnwKqlsYJg-1; Tue, 29 Oct 2019 06:22:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F9E885B6EE
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 10:22:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C9C815C1B2
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 10:22:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9B6381132A09; Tue, 29 Oct 2019 11:22:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/19] qapi: Clean up doc comment checking for implicit union
 base
Date: Tue, 29 Oct 2019 11:22:19 +0100
Message-Id: <20191029102228.20740-11-armbru@redhat.com>
In-Reply-To: <20191029102228.20740-1-armbru@redhat.com>
References: <20191029102228.20740-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: cULfyEMmPciLtnwKqlsYJg-1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

An object type's doc comment describes the type's members, less the
ones defined in a named base type.  Cases:

* Struct: the members are defined in 'data' and inherited from 'base'.
  Since the base type cannot be implicit, the doc comment describes
  just 'data'.

* Simple union: the only member is the implicit tag member @type, and
  the doc comment describes it.

* Flat union with implicit base type: the members are defined in
  'base', and the doc comment describes it.

* Flat union with named base type: the members are inherited from
  'base'.  The doc comment describes no members.

Before we can check a doc comment with .check_doc(), we need
.connect_doc() connect each of its "argument sections" to the member
it documents.

For structs and simple unions, this is straightforward: the members in
question are in .local_members, and .connect_doc() connects them.

For flat unions with a named base type, it's trivial: .local_members
is empty, and .connect_doc() does nothing.

For flat unions with an implicit base type, it's tricky.  We have
QAPISchema._make_implicit_object_type() forward the union's doc
comment to the implicit base type, so that the base type's
.connect_doc() connects the members.  The union's .connect_doc() does
nothing, as .local_members is empty.

Dirt effect: we check the doc comment twice, once for the union type,
and once for the implicit base type.

This is needlessly brittle and hard to understand.  Clean up as
follows.  Make the union's .connect_doc() connect an implicit base's
members itself.  Do not forward the union's doc comment to its
implicit base type.

Requires extending .connect_doc() so it can work with a doc comment
other than self.doc.  Add an optional argument for that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20191024110237.30963-11-armbru@redhat.com>
---
 scripts/qapi/schema.py | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 0381e3cb40..c16dce1fe0 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -51,7 +51,7 @@ class QAPISchemaEntity(object):
                                            os.path.dirname(schema.fname))
         self._checked =3D True
=20
-    def connect_doc(self):
+    def connect_doc(self, doc=3DNone):
         pass
=20
     def check_doc(self):
@@ -224,10 +224,11 @@ class QAPISchemaEnumType(QAPISchemaType):
         for m in self.members:
             m.check_clash(self.info, seen)
=20
-    def connect_doc(self):
-        if self.doc:
+    def connect_doc(self, doc=3DNone):
+        doc =3D doc or self.doc
+        if doc:
             for m in self.members:
-                self.doc.connect_member(m)
+                doc.connect_member(m)
=20
     def check_doc(self):
         if self.doc:
@@ -380,10 +381,13 @@ class QAPISchemaObjectType(QAPISchemaType):
         for m in self.members:
             m.check_clash(info, seen)
=20
-    def connect_doc(self):
-        if self.doc:
+    def connect_doc(self, doc=3DNone):
+        doc =3D doc or self.doc
+        if doc:
+            if self.base and self.base.is_implicit():
+                self.base.connect_doc(doc)
             for m in self.local_members:
-                self.doc.connect_member(m)
+                doc.connect_member(m)
=20
     def check_doc(self):
         if self.doc:
@@ -657,10 +661,11 @@ class QAPISchemaAlternateType(QAPISchemaType):
                         % (v.describe(self.info), types_seen[qt]))
                 types_seen[qt] =3D v.name
=20
-    def connect_doc(self):
-        if self.doc:
+    def connect_doc(self, doc=3DNone):
+        doc =3D doc or self.doc
+        if doc:
             for v in self.variants.variants:
-                self.doc.connect_member(v)
+                doc.connect_member(v)
=20
     def check_doc(self):
         if self.doc:
@@ -974,7 +979,7 @@ class QAPISchema(object):
         tag_member =3D None
         if isinstance(base, dict):
             base =3D self._make_implicit_object_type(
-                name, info, doc, ifcond,
+                name, info, None, ifcond,
                 'base', self._make_members(base, info))
         if tag_name:
             variants =3D [self._make_variant(key, value['type'],
--=20
2.21.0


