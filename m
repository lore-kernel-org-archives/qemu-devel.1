Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6840AC4332E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 09:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3058120739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 09:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1H30z9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3058120739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFDoC-0000sP-Cu
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 05:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jFDnA-0007rf-T4
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 05:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jFDn9-000848-OS
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 05:18:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:48310)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jFDn9-000835-Ka
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 05:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584695891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UXTKpzyVZjeOnymPgoD+aEVLEuJzcg/IuAjr4kXReDM=;
 b=g1H30z9YgyKcQUwUEBuVPA0NjM337EyX+ecdIIdBmgIw0Mus1ZZB8NJhbi3TxB2uiIKrF6
 fD8f8VML1ExN3mK5cyC8/a1H7EoYijSPr7o2+fmR3+glWPfNxXAiJDq5j84S6jPYrmd+iL
 xsroAEboztff91FdrB72FYYQb8dr+As=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-pOu8xsLsPf6nS18YXgzabQ-1; Fri, 20 Mar 2020 05:18:07 -0400
X-MC-Unique: pOu8xsLsPf6nS18YXgzabQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3DB3189F763;
 Fri, 20 Mar 2020 09:18:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AE00CFD2;
 Fri, 20 Mar 2020 09:18:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0C75211366CC; Fri, 20 Mar 2020 10:18:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 2/2] qapi: Make section headings start a new doc comment
 block
Date: Fri, 20 Mar 2020 10:18:05 +0100
Message-Id: <20200320091805.5585-3-armbru@redhat.com>
In-Reply-To: <20200320091805.5585-1-armbru@redhat.com>
References: <20200320091805.5585-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: peter.maydell@linaro.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Our current QAPI doc-comment markup allows section headers (introduced
with a leading '=3D' or '=3D=3D') anywhere in a free-form documentation
comment.  This works for Texinfo because the generator simply prints a
Texinfo section command at that point in the output stream.  For rST
generation, since we're assembling a tree of docutils nodes, this is
awkward because a new section implies starting a new section node at
the top level of the tree and generating text into there.

Make section headers start a new free-form documentation block, so the
future rST document generator doesn't have to look at every line in
free-form blocks and handle headings in odd places.

This change makes no difference to the generated Texinfo.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/parser.py         | 21 +++++++++++++--------
 tests/qapi-schema/doc-good.out |  3 ++-
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index f12c67d7d2..165925ca72 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -52,8 +52,8 @@ class QAPISchemaParser:
             info =3D self.info
             if self.tok =3D=3D '#':
                 self.reject_expr_doc(cur_doc)
-                cur_doc =3D self.get_doc(info)
-                self.docs.append(cur_doc)
+                for cur_doc in self.get_doc(info):
+                    self.docs.append(cur_doc)
                 continue
=20
             expr =3D self.get_expr(False)
@@ -270,7 +270,8 @@ class QAPISchemaParser:
             raise QAPIParseError(
                 self, "junk after '##' at start of documentation comment")
=20
-        doc =3D QAPIDoc(self, info)
+        docs =3D []
+        cur_doc =3D QAPIDoc(self, info)
         self.accept(False)
         while self.tok =3D=3D '#':
             if self.val.startswith('##'):
@@ -279,15 +280,20 @@ class QAPISchemaParser:
                     raise QAPIParseError(
                         self,
                         "junk after '##' at end of documentation comment")
-                doc.end_comment()
+                cur_doc.end_comment()
+                docs.append(cur_doc)
                 self.accept()
-                return doc
+                return docs
             if self.val.startswith('# =3D'):
-                if doc.symbol:
+                if cur_doc.symbol:
                     raise QAPIParseError(
                         self,
                         "unexpected '=3D' markup in definition documentati=
on")
-            doc.append(self.val)
+                if cur_doc.body.text:
+                    cur_doc.end_comment()
+                    docs.append(cur_doc)
+                    cur_doc =3D QAPIDoc(self, info)
+            cur_doc.append(self.val)
             self.accept(False)
=20
         raise QAPIParseError(self, "documentation comment must end with '#=
#'")
@@ -316,7 +322,6 @@ class QAPIDoc:
         def __init__(self, name=3DNone):
             # optional section name (argument/member or section name)
             self.name =3D name
-            # the list of lines for this section
             self.text =3D ''
=20
         def append(self, line):
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.ou=
t
index 6757dd26a2..d78a424cd9 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -69,7 +69,8 @@ event EVT-BOXED Object
 doc freeform
     body=3D
 =3D Section
-
+doc freeform
+    body=3D
 =3D=3D Subsection
=20
 *strong* _with emphasis_
--=20
2.21.1


