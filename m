Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CD2CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:48:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1095A2087F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dc6Tqps/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1095A2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPP30-0006Wv-7b
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 06:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iPOeZ-000632-65
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:23:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iPOeX-0001XX-0Y
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:23:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29523
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iPOeW-0001Wj-TH
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572344584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jqNMt4RSIpJPAGi/jqfj8UinKDuq7x/cW6NIANBam4g=;
 b=Dc6Tqps/uB059zrGjPsr90/p7ISDG2S87faflWJhmF4dRcQUYRUGoOX6iuYjMfyMKgHHsy
 jrnFEbKK/iQZf037VXgc0HofD4HvcE/34Hfxsdv1push/WiPbj9QNVhhPTmLUrP1qI+jho
 npzStbOWA2Ompll6M5a94egbRp2H0r0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-UAAretzaNOmOeNmU5pdJzg-1; Tue, 29 Oct 2019 06:23:01 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 026EB5E4
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 10:23:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C4A5A1001B08
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 10:23:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 957C31132B56; Tue, 29 Oct 2019 11:22:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/19] qapi: Split .connect_doc(), .check_doc() off .check()
Date: Tue, 29 Oct 2019 11:22:17 +0100
Message-Id: <20191029102228.20740-9-armbru@redhat.com>
In-Reply-To: <20191029102228.20740-1-armbru@redhat.com>
References: <20191029102228.20740-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: UAAretzaNOmOeNmU5pdJzg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

Splitting documentation checking off the .check() methods makes them a
bit more focused, which is welcome, as some of them are pretty big.
It also prepares the ground for the following commits.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20191024110237.30963-9-armbru@redhat.com>
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


