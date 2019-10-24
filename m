Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DF9CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:13:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EBA120684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdXauqCY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBA120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNb3F-0002DY-Nx
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 07:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNatK-0000za-RS
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNatE-0004qr-NE
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52275
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNatE-0004mU-Bh
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571914965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OUZuu+rScb/e+4Yjh+6Cjp8MnfwVLWwWLKBrppf6bhk=;
 b=ZdXauqCYSA9eY0G2IP1ky5HgbPbufckqwPuQ9/ZlUeNx0F88BK5zvmU6A3YyElyw/qc3G9
 KDixkl1FIdVq4NAKmv4NzEGNZuXK/wAnHKmdtfQf0uXIdmUpBKWdF4ClD51LfTYUvjRylS
 5ME+vyTM4WycBeBOCbAkrmdj3U1gACs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-Zdo6mxc_PM2OzVnlnC6dBQ-1; Thu, 24 Oct 2019 07:02:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 858D41005516;
 Thu, 24 Oct 2019 11:02:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53174608C1;
 Thu, 24 Oct 2019 11:02:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4C59411329CF; Thu, 24 Oct 2019 13:02:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/19] qapi: Implement boxed event argument documentation
Date: Thu, 24 Oct 2019 13:02:24 +0200
Message-Id: <20191024110237.30963-7-armbru@redhat.com>
In-Reply-To: <20191024110237.30963-1-armbru@redhat.com>
References: <20191024110237.30963-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Zdo6mxc_PM2OzVnlnC6dBQ-1
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

Generate a reference "Arguments: the members of ...", just like we do
for commands since commit c2dd311cb7 "qapi2texi: Implement boxed
argument documentation".

No change to generated QMP documentation; we don't yet use boxed
events outside tests/.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qapi-schema/doc-good.texi |  4 +++-
 scripts/qapi/doc.py             | 10 +++++++++-
 tests/qapi-schema/doc-good.json |  1 -
 tests/qapi-schema/doc-good.out  |  2 +-
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good.t=
exi
index 98aa78e1fb..d4b15dabf0 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -279,7 +279,9 @@ another feature
=20
 @deftypefn Event {} EVT-BOXED
=20
-BUG: generated doc misses arguments
+
+
+@b{Arguments:} the members of @code{Object}
=20
 @end deftypefn
=20
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 6d5726cf6e..f2462c9877 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -266,9 +266,17 @@ class QAPISchemaGenDocVisitor(QAPISchemaVisitor):
=20
     def visit_event(self, name, info, ifcond, arg_type, boxed):
         doc =3D self.cur_doc
+        if boxed:
+            body =3D texi_body(doc)
+            body +=3D ('\n@b{Arguments:} the members of @code{%s}\n'
+                     % arg_type.name)
+            body +=3D texi_features(doc)
+            body +=3D texi_sections(doc, ifcond)
+        else:
+            body =3D texi_entity(doc, 'Arguments', ifcond)
         self._gen.add(MSG_FMT(type=3D'Event',
                               name=3Ddoc.symbol,
-                              body=3Dtexi_entity(doc, 'Arguments', ifcond)=
))
+                              body=3Dbody))
=20
     def symbol(self, doc, entity):
         if self._gen._body:
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.j=
son
index df50a877e3..d992e713d9 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -160,7 +160,6 @@
=20
 ##
 # @EVT-BOXED:
-# BUG: generated doc misses arguments
 ##
 { 'event': 'EVT-BOXED',  'boxed': true,
   'data': 'Object' }
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.ou=
t
index 8cc29fce50..4c9406a464 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -196,4 +196,4 @@ another feature
 <- out
 doc symbol=3DEVT-BOXED
     body=3D
-BUG: generated doc misses arguments
+
--=20
2.21.0


