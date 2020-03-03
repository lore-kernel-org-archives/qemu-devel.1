Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D5EC3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 16:42:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80FE520838
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 16:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GEEJKZkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FE520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Ach-0001gB-NG
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 11:42:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j9AVs-0004JQ-RA
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 11:35:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j9AVr-00031S-Fo
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 11:35:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22060
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j9AVr-000319-CI
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 11:35:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583253319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fbo5JhnnTf0I02ZkCG4yrI4+5qo3vdDLrEPTR8T/fbg=;
 b=GEEJKZkLOWVl0iPvjgMyIY1L9wkhwxapgvd7FgG4w1OwApgGc/+2nqvqxh97nZsF0K5TBP
 QqHK0QWHTqKXILDbndoRpsYwlYRq3Pnflt75Ol8Ok8idZtuGLassCzRP8IvPWvAUef8sNz
 xE5eQbyb4QyBG4OoYSIsSMZVv7WsMIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-EgChiYy8PQSgAnMDA3R2_A-1; Tue, 03 Mar 2020 11:35:12 -0500
X-MC-Unique: EgChiYy8PQSgAnMDA3R2_A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01F0918CA247;
 Tue,  3 Mar 2020 16:35:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC6E61001920;
 Tue,  3 Mar 2020 16:35:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D29581133013; Tue,  3 Mar 2020 17:35:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/30] qapi/schema: Clean up around
 QAPISchemaEntity.connect_doc()
Date: Tue,  3 Mar 2020 17:34:46 +0100
Message-Id: <20200303163505.32041-12-armbru@redhat.com>
In-Reply-To: <20200303163505.32041-1-armbru@redhat.com>
References: <20200303163505.32041-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: libvir-list@redhat.com, berrange@redhat.com, mdroth@linux.vnet.ibm.com
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
index cfbb9758c4..1c8d126441 100644
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
@@ -668,6 +670,7 @@ class QAPISchemaAlternateType(QAPISchemaType):
                 types_seen[qt] =3D v.name
=20
     def connect_doc(self, doc=3DNone):
+        super().connect_doc(doc)
         doc =3D doc or self.doc
         if doc:
             for v in self.variants.variants:
@@ -734,6 +737,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
                         % self.ret_type.describe())
=20
     def connect_doc(self, doc=3DNone):
+        super().connect_doc(doc)
         doc =3D doc or self.doc
         if doc:
             if self.arg_type and self.arg_type.is_implicit():
@@ -776,6 +780,7 @@ class QAPISchemaEvent(QAPISchemaEntity):
                     % self.arg_type.describe())
=20
     def connect_doc(self, doc=3DNone):
+        super().connect_doc(doc)
         doc =3D doc or self.doc
         if doc:
             if self.arg_type and self.arg_type.is_implicit():
--=20
2.21.1


