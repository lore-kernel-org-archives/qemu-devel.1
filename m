Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD45CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:28:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24CD92087E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOQFMywz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24CD92087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPOjZ-0003Jd-Sy
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 06:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iPOeF-0005Wz-9g
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iPOeE-0001Dj-1b
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28908
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iPOeD-0001DS-To
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572344565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ndEainXywempsWUxg5D0tGL2kVdPa3byjMpawz38sI=;
 b=AOQFMywz1JHEzJ9S27DKSRwstnHvOF93F5pvW83C21gIVob/ml8y6fzZg8i0TTWmf3XT9k
 2/E5q8iLIByINEUQ8R2vcvjpnFMyMawl9YbQ8kSnQ2XU5+nzpLRBUYUrkgE7Uy/WXLCY9d
 xvN+yhgMEbuUPRYyND6BedSHXxYbPBI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-til2AhEPPqCfoKmxAiBQHA-1; Tue, 29 Oct 2019 06:22:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1E7681A334
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 10:22:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A1C7A5D6C3
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 10:22:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A45A711328C1; Tue, 29 Oct 2019 11:22:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/19] qapi: Eliminate .check_doc() overrides
Date: Tue, 29 Oct 2019 11:22:22 +0100
Message-Id: <20191029102228.20740-14-armbru@redhat.com>
In-Reply-To: <20191029102228.20740-1-armbru@redhat.com>
References: <20191029102228.20740-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: til2AhEPPqCfoKmxAiBQHA-1
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

All sub-classes of QAPISchemaEntity now override .check_doc() the same
way, except for QAPISchemaType and and QAPISchemaArrayType.

Put the overrides' code in QAPISchemaEntity.check_doc(), and drop the
overrides.  QAPISchemaType doesn't care because it's abstract.
QAPISchemaArrayType doesn't care because its .doc is always None.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20191024110237.30963-14-armbru@redhat.com>
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


