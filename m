Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFBCC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 15:02:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 721B9206B1
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 15:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eACBJKei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721B9206B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDUmH-0001Hh-FD
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 11:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jDUXk-0005Zs-RE
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jDUXi-0002VB-T1
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55265
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jDUXh-0002Kq-9Z
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584283622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a3qjY7+p4peJo1CtCwQlVcIKqwi1Iv2xAENQMXkoKCc=;
 b=eACBJKei3GJTR5eSpr07EO2S4qfRP4MRVGuCxaeD9M6hK9ywmENGnek7HhIWyUDDI3B2Jt
 W9JX/aMm33keiwTLhNZgEh5R6hNmc/v+h8xfTQBqrC7MhauO9na2ZcKsboVLLx1QYqFu1d
 d4KVEzbKVHbt+QrvJNHkdXErl6qY8g0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-ndfEF5AfNQaR3afLVTbkEA-1; Sun, 15 Mar 2020 10:46:59 -0400
X-MC-Unique: ndfEF5AfNQaR3afLVTbkEA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B1B313EA;
 Sun, 15 Mar 2020 14:46:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-49.ams2.redhat.com
 [10.36.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A5B25DA7B;
 Sun, 15 Mar 2020 14:46:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B17DC1135A64; Sun, 15 Mar 2020 15:46:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 19/34] qapi/schema: Call QAPIDoc.connect_member() in just
 one place
Date: Sun, 15 Mar 2020 15:46:38 +0100
Message-Id: <20200315144653.22660-20-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-1-armbru@redhat.com>
References: <20200315144653.22660-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

The .connect_doc() of classes that have QAPISchemaMember connect them
to their documentation.  Change them to delegate the actual work to
new QAPISchemaMember.connect_doc().  Matches the .connect_doc() that
already exist.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
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


