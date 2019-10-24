Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A47ACA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:17:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03C5F2084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jB/7zJqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C5F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNb7o-0002xF-3Y
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 07:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNatK-0000yk-F7
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNatI-0004uZ-QM
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31475
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNatI-0004tA-M9
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571914970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mPYIhZn6+9mdslr9fxABZgfdncQ8mFnhSckQXSTPOew=;
 b=jB/7zJqhOa6M0A1cQUFalyjO2NkxAU1Y+qc+coAA4jmy1H1HWC3yzw6fkdbHG3s4RtNUqU
 S4W05AlQqKkPIVDmFUa6l1afBEogz6r42YK1MxAUpIi4kDFVCE7gi8wPm3MaEWPjOmTs8y
 4HeoxXw88zX51qXb2G1y8YzI1bgco54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-UwY8DTMiNzyV6uNNWHTixA-1; Thu, 24 Oct 2019 07:02:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6E99800D54;
 Thu, 24 Oct 2019 11:02:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 795455C1D4;
 Thu, 24 Oct 2019 11:02:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5028B1132986; Thu, 24 Oct 2019 13:02:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/19] qapi: De-duplicate entity documentation generation code
Date: Thu, 24 Oct 2019 13:02:25 +0200
Message-Id: <20191024110237.30963-8-armbru@redhat.com>
In-Reply-To: <20191024110237.30963-1-armbru@redhat.com>
References: <20191024110237.30963-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: UwY8DTMiNzyV6uNNWHTixA-1
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

QAPISchemaGenDocVisitor.visit_command() duplicates texi_entity() for
its boxed arguments case.  The previous commit added another copy in
.visit_event().

Replace texi_entity() by texi_type() and texi_msg().  Use texi_msg()
for the boxed arguments case as well.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/doc.py | 82 ++++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 42 deletions(-)

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index f2462c9877..c8c4bda153 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -12,7 +12,7 @@ from qapi.gen import QAPIGenDoc, QAPISchemaVisitor
 MSG_FMT =3D """
 @deftypefn {type} {{}} {name}
=20
-{body}
+{body}{members}{features}{sections}
 @end deftypefn
=20
 """.format
@@ -20,7 +20,7 @@ MSG_FMT =3D """
 TYPE_FMT =3D """
 @deftp {{{type}}} {name}
=20
-{body}
+{body}{members}{features}{sections}
 @end deftp
=20
 """.format
@@ -149,7 +149,8 @@ def texi_member(member, desc, suffix):
         suffix, desc, texi_if(member.ifcond, prefix=3D'@*'))
=20
=20
-def texi_members(doc, what, base, variants, member_func):
+def texi_members(doc, what, base=3DNone, variants=3DNone,
+                 member_func=3Dtexi_member):
     """Format the table of members"""
     items =3D ''
     for section in doc.args.values():
@@ -182,6 +183,13 @@ def texi_members(doc, what, base, variants, member_fun=
c):
     return '\n@b{%s:}\n@table @asis\n%s@end table\n' % (what, items)
=20
=20
+def texi_arguments(doc, boxed_arg_type):
+    if boxed_arg_type:
+        return ('\n@b{Arguments:} the members of @code{%s}\n'
+                % boxed_arg_type.name)
+    return texi_members(doc, 'Arguments')
+
+
 def texi_features(doc):
     """Format the table of features"""
     items =3D ''
@@ -208,12 +216,22 @@ def texi_sections(doc, ifcond):
     return body
=20
=20
-def texi_entity(doc, what, ifcond, base=3DNone, variants=3DNone,
-                member_func=3Dtexi_member):
-    return (texi_body(doc)
-            + texi_members(doc, what, base, variants, member_func)
-            + texi_features(doc)
-            + texi_sections(doc, ifcond))
+def texi_type(typ, doc, ifcond, members):
+    return TYPE_FMT(type=3Dtyp,
+                    name=3Ddoc.symbol,
+                    body=3Dtexi_body(doc),
+                    members=3Dmembers,
+                    features=3Dtexi_features(doc),
+                    sections=3Dtexi_sections(doc, ifcond))
+
+
+def texi_msg(typ, doc, ifcond, members):
+    return MSG_FMT(type=3Dtyp,
+                   name=3Ddoc.symbol,
+                   body=3Dtexi_body(doc),
+                   members=3Dmembers,
+                   features=3Dtexi_features(doc),
+                   sections=3Dtexi_sections(doc, ifcond))
=20
=20
 class QAPISchemaGenDocVisitor(QAPISchemaVisitor):
@@ -227,56 +245,36 @@ class QAPISchemaGenDocVisitor(QAPISchemaVisitor):
=20
     def visit_enum_type(self, name, info, ifcond, members, prefix):
         doc =3D self.cur_doc
-        self._gen.add(TYPE_FMT(type=3D'Enum',
-                               name=3Ddoc.symbol,
-                               body=3Dtexi_entity(doc, 'Values', ifcond,
-                                                member_func=3Dtexi_enum_va=
lue)))
+        self._gen.add(texi_type('Enum', doc, ifcond,
+                                texi_members(doc, 'Values',
+                                             member_func=3Dtexi_enum_value=
)))
=20
     def visit_object_type(self, name, info, ifcond, base, members, variant=
s,
                           features):
         doc =3D self.cur_doc
         if base and base.is_implicit():
             base =3D None
-        self._gen.add(TYPE_FMT(type=3D'Object',
-                               name=3Ddoc.symbol,
-                               body=3Dtexi_entity(doc, 'Members', ifcond,
-                                                base, variants)))
+        self._gen.add(texi_type('Object', doc, ifcond,
+                                texi_members(doc, 'Members', base, variant=
s)))
=20
     def visit_alternate_type(self, name, info, ifcond, variants):
         doc =3D self.cur_doc
-        self._gen.add(TYPE_FMT(type=3D'Alternate',
-                               name=3Ddoc.symbol,
-                               body=3Dtexi_entity(doc, 'Members', ifcond))=
)
+        self._gen.add(texi_type('Alternate', doc, ifcond,
+                                texi_members(doc, 'Members')))
=20
     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
                       success_response, boxed, allow_oob, allow_preconfig,
                       features):
         doc =3D self.cur_doc
-        if boxed:
-            body =3D texi_body(doc)
-            body +=3D ('\n@b{Arguments:} the members of @code{%s}\n'
-                     % arg_type.name)
-            body +=3D texi_features(doc)
-            body +=3D texi_sections(doc, ifcond)
-        else:
-            body =3D texi_entity(doc, 'Arguments', ifcond)
-        self._gen.add(MSG_FMT(type=3D'Command',
-                              name=3Ddoc.symbol,
-                              body=3Dbody))
+        self._gen.add(texi_msg('Command', doc, ifcond,
+                               texi_arguments(doc,
+                                              arg_type if boxed else None)=
))
=20
     def visit_event(self, name, info, ifcond, arg_type, boxed):
         doc =3D self.cur_doc
-        if boxed:
-            body =3D texi_body(doc)
-            body +=3D ('\n@b{Arguments:} the members of @code{%s}\n'
-                     % arg_type.name)
-            body +=3D texi_features(doc)
-            body +=3D texi_sections(doc, ifcond)
-        else:
-            body =3D texi_entity(doc, 'Arguments', ifcond)
-        self._gen.add(MSG_FMT(type=3D'Event',
-                              name=3Ddoc.symbol,
-                              body=3Dbody))
+        self._gen.add(texi_msg('Event', doc, ifcond,
+                               texi_arguments(doc,
+                                              arg_type if boxed else None)=
))
=20
     def symbol(self, doc, entity):
         if self._gen._body:
--=20
2.21.0


