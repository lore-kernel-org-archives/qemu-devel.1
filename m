Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE4ECA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:14:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A17A20856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YciLBqVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A17A20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNc0R-0001r7-QA
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNatG-0000sX-Nm
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNatE-0004q6-DU
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54142
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNatE-0004oY-5r
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571914966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BXnSVx7Vzt0JuFqita9BC2V6+56l9afuz3z9CJAcVTI=;
 b=YciLBqVCp4nOet18OWPA0Nk/9h+zvXKqjgcXTnmWmhrmHV1gaAwmfEJe3Mp1c6UO7BWK2g
 LLw6suP/oJCTPcpZzzk/Gk4BfwcqpyJprL3U4IpLbTpkkajvwjP4Llt5jmgjH0KBOJ+JHu
 Jq7xvXGJH4ZR+X50DYrxJkEtfP6FjTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-jsWVxz7KOnigqHoOmHG3Tw-1; Thu, 24 Oct 2019 07:02:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15874107AD33;
 Thu, 24 Oct 2019 11:02:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D1A1A10027A9;
 Thu, 24 Oct 2019 11:02:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6FFDE11328AA; Thu, 24 Oct 2019 13:02:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/19] qapi: Eliminate .check_doc() overrides
Date: Thu, 24 Oct 2019 13:02:31 +0200
Message-Id: <20191024110237.30963-14-armbru@redhat.com>
In-Reply-To: <20191024110237.30963-1-armbru@redhat.com>
References: <20191024110237.30963-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: jsWVxz7KOnigqHoOmHG3Tw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

All sub-classes of QAPISchemaEntity now override .check_doc() the same
way, except for QAPISchemaType and and QAPISchemaArrayType.

Put the overrides' code in QAPISchemaEntity.check_doc(), and drop the
overrides.  QAPISchemaType doesn't care because it's abstract.
QAPISchemaArrayType doesn't care because its .doc is always None.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/schema.py | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 27da4e0f7d..ee510f129b 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -55,7 +55,8 @@ class QAPISchemaEntity(object):
         pass
=20
     def check_doc(self):
-        pass
+        if self.doc:
+            self.doc.check()
=20
     @property
     def ifcond(self):
@@ -230,10 +231,6 @@ class QAPISchemaEnumType(QAPISchemaType):
             for m in self.members:
                 doc.connect_member(m)
=20
-    def check_doc(self):
-        if self.doc:
-            self.doc.check()
-
     def is_implicit(self):
         # See QAPISchema._make_implicit_enum_type() and ._def_predefineds(=
)
         return self.name.endswith('Kind') or self.name =3D=3D 'QType'
@@ -389,10 +386,6 @@ class QAPISchemaObjectType(QAPISchemaType):
             for m in self.local_members:
                 doc.connect_member(m)
=20
-    def check_doc(self):
-        if self.doc:
-            self.doc.check()
-
     @property
     def ifcond(self):
         assert self._checked
@@ -667,10 +660,6 @@ class QAPISchemaAlternateType(QAPISchemaType):
             for v in self.variants.variants:
                 doc.connect_member(v)
=20
-    def check_doc(self):
-        if self.doc:
-            self.doc.check()
-
     def c_type(self):
         return c_name(self.name) + pointer_suffix
=20
@@ -745,10 +734,6 @@ class QAPISchemaCommand(QAPISchemaEntity):
             if self.arg_type and self.arg_type.is_implicit():
                 self.arg_type.connect_doc(doc)
=20
-    def check_doc(self):
-        if self.doc:
-            self.doc.check()
-
     def visit(self, visitor):
         QAPISchemaEntity.visit(self, visitor)
         visitor.visit_command(self.name, self.info, self.ifcond,
@@ -791,10 +776,6 @@ class QAPISchemaEvent(QAPISchemaEntity):
             if self.arg_type and self.arg_type.is_implicit():
                 self.arg_type.connect_doc(doc)
=20
-    def check_doc(self):
-        if self.doc:
-            self.doc.check()
-
     def visit(self, visitor):
         QAPISchemaEntity.visit(self, visitor)
         visitor.visit_event(self.name, self.info, self.ifcond,
--=20
2.21.0


