Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C7ECA9EBC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF52A2166E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLWxCr3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF52A2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbIa-0003Jm-BO
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 07:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNatK-0000zk-UY
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNatE-0004qN-Fb
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53603
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNatE-0004oF-8D
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571914966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OPBd4x/97RP023wsihC+zq3VLAl/9PZbaQaixKkNOCU=;
 b=SLWxCr3anMIxvDGhTi7mfPZh3FXf674TH1rkBngXSqxRYTiq8t7W+y3flKRXs+VyrmyMwx
 Agvx/pV+2Y95zFY5z3XnMQonfosZccA9RiPMnrzUxukTTNRAcumvGQO4MdEaJv2UbCI60N
 NaZyyL7jzdhm1e1lNQusKU6hLpH5NfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-PUB9gDmxPZCTX_6Z8-QMnw-1; Thu, 24 Oct 2019 07:02:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 676E31800E04;
 Thu, 24 Oct 2019 11:02:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 33D84600C4;
 Thu, 24 Oct 2019 11:02:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5C878113292F; Thu, 24 Oct 2019 13:02:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/19] qapi: Fix enum doc comment checking
Date: Thu, 24 Oct 2019 13:02:27 +0200
Message-Id: <20191024110237.30963-10-armbru@redhat.com>
In-Reply-To: <20191024110237.30963-1-armbru@redhat.com>
References: <20191024110237.30963-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: PUB9gDmxPZCTX_6Z8-QMnw-1
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

Enumeration type documentation comments are not checked, as
demonstrated by test doc-bad-enum-member.  This is because we neglect
to call self.doc.check() for enumeration types.  Messed up in
816a57cd6e "qapi: Fix detection of bogus member documentation".  Fix
it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/schema.py                     |  4 ++++
 tests/qapi-schema/doc-bad-enum-member.err  |  1 +
 tests/qapi-schema/doc-bad-enum-member.json |  1 -
 tests/qapi-schema/doc-bad-enum-member.out  | 21 ---------------------
 4 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 9b62c8d74d..0381e3cb40 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -229,6 +229,10 @@ class QAPISchemaEnumType(QAPISchemaType):
             for m in self.members:
                 self.doc.connect_member(m)
=20
+    def check_doc(self):
+        if self.doc:
+            self.doc.check()
+
     def is_implicit(self):
         # See QAPISchema._make_implicit_enum_type() and ._def_predefineds(=
)
         return self.name.endswith('Kind') or self.name =3D=3D 'QType'
diff --git a/tests/qapi-schema/doc-bad-enum-member.err b/tests/qapi-schema/=
doc-bad-enum-member.err
index e69de29bb2..dfa1e786d7 100644
--- a/tests/qapi-schema/doc-bad-enum-member.err
+++ b/tests/qapi-schema/doc-bad-enum-member.err
@@ -0,0 +1 @@
+doc-bad-enum-member.json:3: the following documented members are not in th=
e declaration: a
diff --git a/tests/qapi-schema/doc-bad-enum-member.json b/tests/qapi-schema=
/doc-bad-enum-member.json
index 9f32fe64b4..9cab35c6e8 100644
--- a/tests/qapi-schema/doc-bad-enum-member.json
+++ b/tests/qapi-schema/doc-bad-enum-member.json
@@ -1,5 +1,4 @@
 # Members listed in the doc comment must exist in the actual schema
-# BUG: nonexistent @a is not rejected
=20
 ##
 # @Foo:
diff --git a/tests/qapi-schema/doc-bad-enum-member.out b/tests/qapi-schema/=
doc-bad-enum-member.out
index 6ca31c1e9b..e69de29bb2 100644
--- a/tests/qapi-schema/doc-bad-enum-member.out
+++ b/tests/qapi-schema/doc-bad-enum-member.out
@@ -1,21 +0,0 @@
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
-module doc-bad-enum-member.json
-enum Foo
-    member b
-doc symbol=3DFoo
-    body=3D
-
-    arg=3Da
-a
-    arg=3Db
-b
--=20
2.21.0


