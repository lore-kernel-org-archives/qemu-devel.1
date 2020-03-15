Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9966AC2BB1D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 15:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6995420578
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 15:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IWO4zqAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6995420578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDV90-0001Dj-Dg
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 11:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jDUXl-0005b9-FU
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jDUXj-0002WZ-DN
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27393
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jDUXh-0002JH-Fi
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584283621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n1HqyLD6rk59tvtYUaeAdJOCL9KoOmIHIAgN65bXvxM=;
 b=IWO4zqAsAJYHpPadeNWlsjuz7KjzA8o3TKMJg9tAKO70byfmPLwtp29ciBOqLKHNA66u1S
 UbGO6mCRBkDUDctX/XmRk9UgRGNJe62CsIJzriJFgw3LGuUoJK+k0yL8QSjsYrT70hNDV9
 Zs+PiP0+zCjnaMx/+KHVVV5CUb4soCU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-O4DP2V7EOgKfYMwgX8THRw-1; Sun, 15 Mar 2020 10:46:57 -0400
X-MC-Unique: O4DP2V7EOgKfYMwgX8THRw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4046107ACC7;
 Sun, 15 Mar 2020 14:46:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-49.ams2.redhat.com
 [10.36.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A61C68AC36;
 Sun, 15 Mar 2020 14:46:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 97BAE11366F2; Sun, 15 Mar 2020 15:46:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/34] qapi/schema: Clean up around
 QAPISchemaEntity.connect_doc()
Date: Sun, 15 Mar 2020 15:46:30 +0100
Message-Id: <20200315144653.22660-12-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-1-armbru@redhat.com>
References: <20200315144653.22660-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QAPISchemaEntity calls doc.connect_feature() in .check().  Improper
since commit ee1e6a1f6c8 split .connect_doc() off .check().  Move the
call.  Requires making the children call super().connect_doc() as they
should.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/schema.py | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index d759308b4e..2a2b495987 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -53,13 +53,13 @@ class QAPISchemaEntity:
         seen =3D {}
         for f in self.features:
             f.check_clash(self.info, seen)
-            if self.doc:
-                self.doc.connect_feature(f)
-
         self._checked =3D True
=20
     def connect_doc(self, doc=3DNone):
-        pass
+        doc =3D doc or self.doc
+        if doc:
+            for f in self.features:
+                doc.connect_feature(f)
=20
     def check_doc(self):
         if self.doc:
@@ -250,6 +250,7 @@ class QAPISchemaEnumType(QAPISchemaType):
             m.check_clash(self.info, seen)
=20
     def connect_doc(self, doc=3DNone):
+        super().connect_doc(doc)
         doc =3D doc or self.doc
         if doc:
             for m in self.members:
@@ -392,6 +393,7 @@ class QAPISchemaObjectType(QAPISchemaType):
             m.check_clash(info, seen)
=20
     def connect_doc(self, doc=3DNone):
+        super().connect_doc(doc)
         doc =3D doc or self.doc
         if doc:
             if self.base and self.base.is_implicit():
@@ -667,6 +669,7 @@ class QAPISchemaAlternateType(QAPISchemaType):
                 types_seen[qt] =3D v.name
=20
     def connect_doc(self, doc=3DNone):
+        super().connect_doc(doc)
         doc =3D doc or self.doc
         if doc:
             for v in self.variants.variants:
@@ -733,6 +736,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
                         % self.ret_type.describe())
=20
     def connect_doc(self, doc=3DNone):
+        super().connect_doc(doc)
         doc =3D doc or self.doc
         if doc:
             if self.arg_type and self.arg_type.is_implicit():
@@ -775,6 +779,7 @@ class QAPISchemaEvent(QAPISchemaEntity):
                     % self.arg_type.describe())
=20
     def connect_doc(self, doc=3DNone):
+        super().connect_doc(doc)
         doc =3D doc or self.doc
         if doc:
             if self.arg_type and self.arg_type.is_implicit():
--=20
2.21.1


