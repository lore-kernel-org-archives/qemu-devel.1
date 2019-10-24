Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9641CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:22:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4F5520679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PgwrojAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F5520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNc8O-0006ui-6D
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59318)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNatJ-0000xs-SL
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNatE-0004pz-Cb
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48566
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNatE-0004mM-5O
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571914964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gc72DB3ktvCd+EH3FWWbD4YDmcljHhXyoV+5dXesYzQ=;
 b=PgwrojAk5bR8THfgyNSf0qFPJ3XOIiI2mwzaRgAJkWsKV+J1mZMwGApLuMrmd24Q4XFHDd
 AqSsXkgXJmBCyQzhMxfJ8RkR63Sc9UaOKzzhrdAjtiHV+a8Iki9WavCPRe2TX/AX6JRHyr
 tgtmZWPmGoVuo0y0mCXe3awTkKBez7Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-wmMy2xy-PDCyM_DXA99Jzw-1; Thu, 24 Oct 2019 07:02:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C2D2800D4C;
 Thu, 24 Oct 2019 11:02:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C758760624;
 Thu, 24 Oct 2019 11:02:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4560F1132A05; Thu, 24 Oct 2019 13:02:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/19] tests/qapi-schema: Fix feature documentation testing
Date: Thu, 24 Oct 2019 13:02:22 +0200
Message-Id: <20191024110237.30963-5-armbru@redhat.com>
In-Reply-To: <20191024110237.30963-1-armbru@redhat.com>
References: <20191024110237.30963-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: wmMy2xy-PDCyM_DXA99Jzw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 8aa3a33e44 "tests/qapi-schema: Test for good feature lists in
structs" made test-qapi.py show features, but neglected to show their
documentation.  Fix that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qapi-schema/doc-bad-feature.out   |  2 ++
 tests/qapi-schema/doc-good.out          | 10 ++++++++++
 tests/qapi-schema/doc-undoc-feature.out |  2 ++
 tests/qapi-schema/test-qapi.py          |  2 ++
 4 files changed, 16 insertions(+)

diff --git a/tests/qapi-schema/doc-bad-feature.out b/tests/qapi-schema/doc-=
bad-feature.out
index 4670be3a72..fef4a3e400 100644
--- a/tests/qapi-schema/doc-bad-feature.out
+++ b/tests/qapi-schema/doc-bad-feature.out
@@ -15,3 +15,5 @@ command foo None -> None
 doc symbol=3Dfoo
     body=3D
=20
+    feature=3Da
+a
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.ou=
t
index b0e99f2110..8cc29fce50 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -126,6 +126,8 @@ A paragraph
 Another paragraph (but no @var: line)
     arg=3Dvar1
=20
+    feature=3Dvariant1-feat
+a feature
 doc symbol=3DVariant2
     body=3D
=20
@@ -158,6 +160,10 @@ the second
 argument
     arg=3Darg3
=20
+    feature=3Dcmd-feat1
+a feature
+    feature=3Dcmd-feat2
+another feature
     section=3DNote
 @arg3 is undocumented
     section=3DReturns
@@ -180,6 +186,10 @@ Duis aute irure dolor
 doc symbol=3Dcmd-boxed
     body=3D
 If you're bored enough to read this, go see a video of boxed cats
+    feature=3Dcmd-feat1
+a feature
+    feature=3Dcmd-feat2
+another feature
     section=3DExample
 -> in
=20
diff --git a/tests/qapi-schema/doc-undoc-feature.out b/tests/qapi-schema/do=
c-undoc-feature.out
index faae777f0d..cdb097361f 100644
--- a/tests/qapi-schema/doc-undoc-feature.out
+++ b/tests/qapi-schema/doc-undoc-feature.out
@@ -17,3 +17,5 @@ command foo None -> None
 doc symbol=3Dfoo
     body=3D
=20
+    feature=3Ddoc
+documented feature
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.p=
y
index 2bd9fd8742..bad14edb47 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -117,6 +117,8 @@ def test_frontend(fname):
         print('    body=3D\n%s' % doc.body.text)
         for arg, section in doc.args.items():
             print('    arg=3D%s\n%s' % (arg, section.text))
+        for feat, section in doc.features.items():
+            print('    feature=3D%s\n%s' % (feat, section.text))
         for section in doc.sections:
             print('    section=3D%s\n%s' % (section.name, section.text))
=20
--=20
2.21.0


