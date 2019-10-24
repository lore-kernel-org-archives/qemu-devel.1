Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5A5CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:19:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B4E20679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fXkov4kR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B4E20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNc5E-0000MG-O1
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNatG-0000se-Pr
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNatE-0004pr-Bs
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21513
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNatE-0004mg-4T
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571914965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NFlwmeBX9B2cG4o8rnjmFvP8JunKYpofIzrKPz+Y4nk=;
 b=fXkov4kRk50o2eqmqe8p/LxfDkFjP/22zq6icTs86wanhExIMxoWWyB6F4gGsJeS+B16Tj
 UiQJhAHfPlNbkGEvGbYEpYe1Sb5TL+k54KiI6/c3w61mlP9c8ltc9w3itD6U40j10fM4Js
 97w5TOsqqDRLIc05KegBavD9tVlcxEU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-l3N0B6ZhOfWaoRnv9QKKbw-1; Thu, 24 Oct 2019 07:02:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AED501800E00;
 Thu, 24 Oct 2019 11:02:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C3405C21E;
 Thu, 24 Oct 2019 11:02:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 53DA21132989; Thu, 24 Oct 2019 13:02:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/19] qapi: Split .connect_doc(), .check_doc() off .check()
Date: Thu, 24 Oct 2019 13:02:26 +0200
Message-Id: <20191024110237.30963-9-armbru@redhat.com>
In-Reply-To: <20191024110237.30963-1-armbru@redhat.com>
References: <20191024110237.30963-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: l3N0B6ZhOfWaoRnv9QKKbw-1
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Splitting documentation checking off the .check() methods makes them a
bit more focused, which is welcome, as some of them are pretty big.
It also prepares the ground for the following commits.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/schema.py | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index f7d68a35f4..9b62c8d74d 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -51,6 +51,12 @@ class QAPISchemaEntity(object):
                                            os.path.dirname(schema.fname))
         self._checked =3D True
=20
+    def connect_doc(self):
+        pass
+
+    def check_doc(self):
+        pass
+
     @property
     def ifcond(self):
         assert self._checked
@@ -217,7 +223,10 @@ class QAPISchemaEnumType(QAPISchemaType):
         seen =3D {}
         for m in self.members:
             m.check_clash(self.info, seen)
-            if self.doc:
+
+    def connect_doc(self):
+        if self.doc:
+            for m in self.members:
                 self.doc.connect_member(m)
=20
     def is_implicit(self):
@@ -345,8 +354,6 @@ class QAPISchemaObjectType(QAPISchemaType):
         for m in self.local_members:
             m.check(schema)
             m.check_clash(self.info, seen)
-            if self.doc:
-                self.doc.connect_member(m)
         members =3D seen.values()
=20
         if self.variants:
@@ -358,9 +365,6 @@ class QAPISchemaObjectType(QAPISchemaType):
         for f in self.features:
             f.check_clash(self.info, seen)
=20
-        if self.doc:
-            self.doc.check()
-
         self.members =3D members  # mark completed
=20
     # Check that the members of this type do not cause duplicate JSON memb=
ers,
@@ -372,6 +376,15 @@ class QAPISchemaObjectType(QAPISchemaType):
         for m in self.members:
             m.check_clash(info, seen)
=20
+    def connect_doc(self):
+        if self.doc:
+            for m in self.local_members:
+                self.doc.connect_member(m)
+
+    def check_doc(self):
+        if self.doc:
+            self.doc.check()
+
     @property
     def ifcond(self):
         assert self._checked
@@ -639,8 +652,13 @@ class QAPISchemaAlternateType(QAPISchemaType):
                         "%s can't be distinguished from '%s'"
                         % (v.describe(self.info), types_seen[qt]))
                 types_seen[qt] =3D v.name
-            if self.doc:
+
+    def connect_doc(self):
+        if self.doc:
+            for v in self.variants.variants:
                 self.doc.connect_member(v)
+
+    def check_doc(self):
         if self.doc:
             self.doc.check()
=20
@@ -1043,6 +1061,8 @@ class QAPISchema(object):
     def check(self):
         for ent in self._entity_list:
             ent.check(self)
+            ent.connect_doc()
+            ent.check_doc()
=20
     def visit(self, visitor):
         visitor.visit_begin(self)
--=20
2.21.0


