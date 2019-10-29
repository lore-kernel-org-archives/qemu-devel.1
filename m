Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B799CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:33:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A8720874
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJYd4ksp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A8720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPOo6-0008Kh-9z
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 06:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iPOeA-0005TY-Bw
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iPOe7-00017a-Lz
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28662
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iPOe7-00016c-CW
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572344558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6clcLZCh8AgNCQzhxRb7905oBBUjO8EbBiZIFBOzXr0=;
 b=KJYd4kspHmM/8jpULRxw6XrPWGSg+EEXfo+R3ZhPQr1baEJEsGIPZdi7ylH0GkXkyiZUiv
 4bTxrV2Bi9hqUkW3Y7Oov9J4ApYsLHOk6aYwqp2YeGC/UXbaDxhOE15/WXtCoYo1Bejllg
 KFJW1p5fgCKYDx+NKzORof6VjagYtoc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-ZRVT2bkVO0-t5bRJk_iP4A-1; Tue, 29 Oct 2019 06:22:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D1E4801E64
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 10:22:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 13E0360863
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 10:22:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 805DF1136447; Tue, 29 Oct 2019 11:22:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/19] tests/qapi-schema: Demonstrate feature and enum doc
 comment bugs
Date: Tue, 29 Oct 2019 11:22:10 +0100
Message-Id: <20191029102228.20740-2-armbru@redhat.com>
In-Reply-To: <20191029102228.20740-1-armbru@redhat.com>
References: <20191029102228.20740-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ZRVT2bkVO0-t5bRJk_iP4A-1
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

Add negative tests doc-bad-enum-member and doc-bad-feature to cover
documentation for nonexistent enum members and features, and test
doc-undoc-feature to cover features lacking documentation.  None of
them works.  To be fixed later in this series.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20191024110237.30963-2-armbru@redhat.com>
---
 tests/Makefile.include                     |  3 +++
 tests/qapi-schema/doc-bad-enum-member.err  |  0
 tests/qapi-schema/doc-bad-enum-member.json |  9 +++++++++
 tests/qapi-schema/doc-bad-enum-member.out  | 21 +++++++++++++++++++++
 tests/qapi-schema/doc-bad-feature.err      |  0
 tests/qapi-schema/doc-bad-feature.json     | 10 ++++++++++
 tests/qapi-schema/doc-bad-feature.out      | 17 +++++++++++++++++
 tests/qapi-schema/doc-undoc-feature.err    |  0
 tests/qapi-schema/doc-undoc-feature.json   | 10 ++++++++++
 tests/qapi-schema/doc-undoc-feature.out    | 19 +++++++++++++++++++
 10 files changed, 89 insertions(+)
 create mode 100644 tests/qapi-schema/doc-bad-enum-member.err
 create mode 100644 tests/qapi-schema/doc-bad-enum-member.json
 create mode 100644 tests/qapi-schema/doc-bad-enum-member.out
 create mode 100644 tests/qapi-schema/doc-bad-feature.err
 create mode 100644 tests/qapi-schema/doc-bad-feature.json
 create mode 100644 tests/qapi-schema/doc-bad-feature.out
 create mode 100644 tests/qapi-schema/doc-undoc-feature.err
 create mode 100644 tests/qapi-schema/doc-undoc-feature.json
 create mode 100644 tests/qapi-schema/doc-undoc-feature.out

diff --git a/tests/Makefile.include b/tests/Makefile.include
index fde8a0c5ef..ca2a0cb84f 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -342,6 +342,8 @@ qapi-schema +=3D command-int.json
 qapi-schema +=3D comments.json
 qapi-schema +=3D doc-bad-alternate-member.json
 qapi-schema +=3D doc-bad-command-arg.json
+qapi-schema +=3D doc-bad-enum-member.json
+qapi-schema +=3D doc-bad-feature.json
 qapi-schema +=3D doc-bad-section.json
 qapi-schema +=3D doc-bad-symbol.json
 qapi-schema +=3D doc-bad-union-member.json
@@ -365,6 +367,7 @@ qapi-schema +=3D doc-missing-expr.json
 qapi-schema +=3D doc-missing-space.json
 qapi-schema +=3D doc-missing.json
 qapi-schema +=3D doc-no-symbol.json
+qapi-schema +=3D doc-undoc-feature.json
 qapi-schema +=3D double-type.json
 qapi-schema +=3D duplicate-key.json
 qapi-schema +=3D empty.json
diff --git a/tests/qapi-schema/doc-bad-enum-member.err b/tests/qapi-schema/=
doc-bad-enum-member.err
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/doc-bad-enum-member.json b/tests/qapi-schema=
/doc-bad-enum-member.json
new file mode 100644
index 0000000000..9f32fe64b4
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-enum-member.json
@@ -0,0 +1,9 @@
+# Members listed in the doc comment must exist in the actual schema
+# BUG: nonexistent @a is not rejected
+
+##
+# @Foo:
+# @a: a
+# @b: b
+##
+{ 'enum': 'Foo', 'data': [ 'b' ] }
diff --git a/tests/qapi-schema/doc-bad-enum-member.out b/tests/qapi-schema/=
doc-bad-enum-member.out
new file mode 100644
index 0000000000..6ca31c1e9b
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-enum-member.out
@@ -0,0 +1,21 @@
+module None
+object q_empty
+enum QType
+    prefix QTYPE
+    member none
+    member qnull
+    member qnum
+    member qstring
+    member qdict
+    member qlist
+    member qbool
+module doc-bad-enum-member.json
+enum Foo
+    member b
+doc symbol=3DFoo
+    body=3D
+
+    arg=3Da
+a
+    arg=3Db
+b
diff --git a/tests/qapi-schema/doc-bad-feature.err b/tests/qapi-schema/doc-=
bad-feature.err
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/doc-bad-feature.json b/tests/qapi-schema/doc=
-bad-feature.json
new file mode 100644
index 0000000000..2a78e3b1db
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-feature.json
@@ -0,0 +1,10 @@
+# Features listed in the doc comment must exist in the actual schema
+# BUG: nonexistent @a is not rejected
+
+##
+# @foo:
+#
+# Features:
+# @a: a
+##
+{ 'command': 'foo' }
diff --git a/tests/qapi-schema/doc-bad-feature.out b/tests/qapi-schema/doc-=
bad-feature.out
new file mode 100644
index 0000000000..4670be3a72
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-feature.out
@@ -0,0 +1,17 @@
+module None
+object q_empty
+enum QType
+    prefix QTYPE
+    member none
+    member qnull
+    member qnum
+    member qstring
+    member qdict
+    member qlist
+    member qbool
+module doc-bad-feature.json
+command foo None -> None
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
+doc symbol=3Dfoo
+    body=3D
+
diff --git a/tests/qapi-schema/doc-undoc-feature.err b/tests/qapi-schema/do=
c-undoc-feature.err
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/doc-undoc-feature.json b/tests/qapi-schema/d=
oc-undoc-feature.json
new file mode 100644
index 0000000000..c7650d9974
--- /dev/null
+++ b/tests/qapi-schema/doc-undoc-feature.json
@@ -0,0 +1,10 @@
+# Doc comment must cover all features
+# BUG: missing documentation for @undoc not caught
+
+##
+# @foo:
+#
+# Features:
+# @doc: documented feature
+##
+{ 'command': 'foo', 'features': ['undoc', 'doc'] }
diff --git a/tests/qapi-schema/doc-undoc-feature.out b/tests/qapi-schema/do=
c-undoc-feature.out
new file mode 100644
index 0000000000..faae777f0d
--- /dev/null
+++ b/tests/qapi-schema/doc-undoc-feature.out
@@ -0,0 +1,19 @@
+module None
+object q_empty
+enum QType
+    prefix QTYPE
+    member none
+    member qnull
+    member qnum
+    member qstring
+    member qdict
+    member qlist
+    member qbool
+module doc-undoc-feature.json
+command foo None -> None
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
+    feature undoc
+    feature doc
+doc symbol=3Dfoo
+    body=3D
+
--=20
2.21.0


