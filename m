Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373AEC4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 09:19:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3CA820739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 09:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YmZfowtZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3CA820739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFDoB-0000pJ-1w
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 05:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jFDn9-0007qI-Uj
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 05:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jFDn8-000827-BW
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 05:18:11 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56294)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jFDn8-000818-74
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 05:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584695889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ZEDWYjefeu5Ws2I1asjAQwMJZH/7Vs8pFGmds1C/1s=;
 b=YmZfowtZyVlHR29wt7BYNXyrAxXWxbmYVds7vnFFHcsTXrG14tw/qd/afKwUwK1gZKnwKO
 qYrdM/nl9gfQArAxc0BfuIXDM/7bTnwOMxOkkOqLBgVrDGhsc6fbYWoj8D+9a9jAbUXknx
 Q0Ouq/Tcu5CQp38+aHcvHMCgGylFvr4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-bAD99b00P_-JZzW7KZ268w-1; Fri, 20 Mar 2020 05:18:08 -0400
X-MC-Unique: bAD99b00P_-JZzW7KZ268w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 154A7107ACCA;
 Fri, 20 Mar 2020 09:18:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7998491295;
 Fri, 20 Mar 2020 09:18:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0871F1138405; Fri, 20 Mar 2020 10:18:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] qapi: Reject section markup in definition documentation
Date: Fri, 20 Mar 2020 10:18:04 +0100
Message-Id: <20200320091805.5585-2-armbru@redhat.com>
In-Reply-To: <20200320091805.5585-1-armbru@redhat.com>
References: <20200320091805.5585-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

Section markup in definition documentation makes no sense and can
produce invalid Texinfo.  Reject.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt           |  2 ++
 scripts/qapi/parser.py                 |  5 +++++
 tests/qapi-schema/doc-bad-section.err  |  1 +
 tests/qapi-schema/doc-bad-section.json |  3 +--
 tests/qapi-schema/doc-bad-section.out  | 24 ------------------------
 5 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 1967adfa92..382a672874 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -835,6 +835,8 @@ Double the '=3D' for a subsection title:
=20
     # =3D=3D Subsection title
=20
+Both are only permitted in free-form documentation.
+
 '|' denotes examples:
=20
     # | Text of the example, may span
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index abadacbb0e..f12c67d7d2 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -282,6 +282,11 @@ class QAPISchemaParser:
                 doc.end_comment()
                 self.accept()
                 return doc
+            if self.val.startswith('# =3D'):
+                if doc.symbol:
+                    raise QAPIParseError(
+                        self,
+                        "unexpected '=3D' markup in definition documentati=
on")
             doc.append(self.val)
             self.accept(False)
=20
diff --git a/tests/qapi-schema/doc-bad-section.err b/tests/qapi-schema/doc-=
bad-section.err
index e69de29bb2..785cacc08c 100644
--- a/tests/qapi-schema/doc-bad-section.err
+++ b/tests/qapi-schema/doc-bad-section.err
@@ -0,0 +1 @@
+doc-bad-section.json:5:1: unexpected '=3D' markup in definition documentat=
ion
diff --git a/tests/qapi-schema/doc-bad-section.json b/tests/qapi-schema/doc=
-bad-section.json
index 560df4b087..8175d95867 100644
--- a/tests/qapi-schema/doc-bad-section.json
+++ b/tests/qapi-schema/doc-bad-section.json
@@ -1,9 +1,8 @@
 # =3D section within an expression comment
-# BUG: not rejected
=20
 ##
 # @Enum:
-# =3D=3D Produces *invalid* texinfo
+# =3D=3D No good here
 # @one: The _one_ {and only}
 #
 # @two is undocumented
diff --git a/tests/qapi-schema/doc-bad-section.out b/tests/qapi-schema/doc-=
bad-section.out
index 367e2a1c3e..e69de29bb2 100644
--- a/tests/qapi-schema/doc-bad-section.out
+++ b/tests/qapi-schema/doc-bad-section.out
@@ -1,24 +0,0 @@
-module None
-object q_empty
-enum QType
-    prefix QTYPE
-    member none
-    member qnull
-    member qnum
-    member qstring
-    member qdict
-    member qlist
-    member qbool
-module doc-bad-section.json
-enum Enum
-    member one
-    member two
-doc symbol=3DEnum
-    body=3D
-=3D=3D Produces *invalid* texinfo
-    arg=3Done
-The _one_ {and only}
-    arg=3Dtwo
-
-    section=3DNone
-@two is undocumented
--=20
2.21.1


