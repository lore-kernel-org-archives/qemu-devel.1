Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB8DCA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:27:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 595AB2087E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSoXGENW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595AB2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPOif-0002F9-H2
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 06:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iPOeA-0005TZ-CQ
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iPOe7-00017k-O9
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20091
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iPOe7-000169-Br
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572344557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S17zb9VJmJXU5JrsFlbS3HbNlldujxxBtBQrqUOHXGU=;
 b=QSoXGENWk9nJua8NIcHy6y4UgGpZcqPt73l0kqFmWpx7KmDGW9DxET6PHdmwOzFigQ4pcu
 x4NgjnwFN9Sgp9scFMHyU4xuK83hIkwhgA94YdOdRmnidflLfR/VBicbVD7bkdWOtl8HsF
 k+oQ2QTIVUan9iKcJCnWlekaLg1KNcg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-IKtUQSiGMBGZW8z9_tC1-Q-1; Tue, 29 Oct 2019 06:22:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72DF5801E6F
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 10:22:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1841E5D6C3
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 10:22:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 832A61133023; Tue, 29 Oct 2019 11:22:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/19] tests/qapi-schema: Demonstrate command and event doc
 comment bugs
Date: Tue, 29 Oct 2019 11:22:11 +0100
Message-Id: <20191029102228.20740-3-armbru@redhat.com>
In-Reply-To: <20191029102228.20740-1-armbru@redhat.com>
References: <20191029102228.20740-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: IKtUQSiGMBGZW8z9_tC1-Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

Add negative tests doc-bad-boxed-command-arg and doc-bad-event-arg to
cover boxed and no arguments.  They demonstrate insufficient doc
comment checking.

Update positive test doc-good to cover boxed event arguments.  It
demonstrates the generated doc comment misses arguments.

These bugs will be fixed later in this series.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20191024110237.30963-3-armbru@redhat.com>
---
 tests/qapi-schema/doc-good.texi               |  8 ++++++
 tests/Makefile.include                        |  2 ++
 .../qapi-schema/doc-bad-boxed-command-arg.err |  0
 .../doc-bad-boxed-command-arg.json            | 15 +++++++++++
 .../qapi-schema/doc-bad-boxed-command-arg.out | 26 +++++++++++++++++++
 tests/qapi-schema/doc-bad-event-arg.err       |  0
 tests/qapi-schema/doc-bad-event-arg.json      |  8 ++++++
 tests/qapi-schema/doc-bad-event-arg.out       | 19 ++++++++++++++
 tests/qapi-schema/doc-good.json               |  7 +++++
 tests/qapi-schema/doc-good.out                |  5 ++++
 10 files changed, 90 insertions(+)
 create mode 100644 tests/qapi-schema/doc-bad-boxed-command-arg.err
 create mode 100644 tests/qapi-schema/doc-bad-boxed-command-arg.json
 create mode 100644 tests/qapi-schema/doc-bad-boxed-command-arg.out
 create mode 100644 tests/qapi-schema/doc-bad-event-arg.err
 create mode 100644 tests/qapi-schema/doc-bad-event-arg.json
 create mode 100644 tests/qapi-schema/doc-bad-event-arg.out

diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good.t=
exi
index 2ce8b883c9..d6ecdac94f 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -258,3 +258,11 @@ another feature
=20
 @end deftypefn
=20
+
+
+@deftypefn Event {} EVT-BOXED
+
+BUG: generated doc misses arguments
+
+@end deftypefn
+
diff --git a/tests/Makefile.include b/tests/Makefile.include
index ca2a0cb84f..237e5acd27 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -341,8 +341,10 @@ qapi-schema +=3D base-cycle-indirect.json
 qapi-schema +=3D command-int.json
 qapi-schema +=3D comments.json
 qapi-schema +=3D doc-bad-alternate-member.json
+qapi-schema +=3D doc-bad-boxed-command-arg.json
 qapi-schema +=3D doc-bad-command-arg.json
 qapi-schema +=3D doc-bad-enum-member.json
+qapi-schema +=3D doc-bad-event-arg.json
 qapi-schema +=3D doc-bad-feature.json
 qapi-schema +=3D doc-bad-section.json
 qapi-schema +=3D doc-bad-symbol.json
diff --git a/tests/qapi-schema/doc-bad-boxed-command-arg.err b/tests/qapi-s=
chema/doc-bad-boxed-command-arg.err
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/doc-bad-boxed-command-arg.json b/tests/qapi-=
schema/doc-bad-boxed-command-arg.json
new file mode 100644
index 0000000000..2c265d2ca3
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-boxed-command-arg.json
@@ -0,0 +1,15 @@
+# Boxed arguments are not to be documented with the command
+# BUG: not rejected
+
+##
+# @Args:
+# @a: an argument
+##
+{ 'struct': 'Args', 'data': { 'a': 'int' } }
+
+##
+# @cmd-boxed:
+# @a: bogus
+##
+{ 'command': 'cmd-boxed', 'boxed': true,
+  'data': 'Args' }
diff --git a/tests/qapi-schema/doc-bad-boxed-command-arg.out b/tests/qapi-s=
chema/doc-bad-boxed-command-arg.out
new file mode 100644
index 0000000000..4ccd788253
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-boxed-command-arg.out
@@ -0,0 +1,26 @@
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
+module doc-bad-boxed-command-arg.json
+object Args
+    member a: int optional=3DFalse
+command cmd-boxed Args -> None
+    gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse preconfig=
=3DFalse
+doc symbol=3DArgs
+    body=3D
+
+    arg=3Da
+an argument
+doc symbol=3Dcmd-boxed
+    body=3D
+
+    arg=3Da
+bogus
diff --git a/tests/qapi-schema/doc-bad-event-arg.err b/tests/qapi-schema/do=
c-bad-event-arg.err
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/doc-bad-event-arg.json b/tests/qapi-schema/d=
oc-bad-event-arg.json
new file mode 100644
index 0000000000..80d4e1240b
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-event-arg.json
@@ -0,0 +1,8 @@
+# Arguments listed in the doc comment must exist in the actual schema
+# BUG: nonexistent @a is not rejected
+
+##
+# @FOO:
+# @a: a
+##
+{ 'event': 'FOO' }
diff --git a/tests/qapi-schema/doc-bad-event-arg.out b/tests/qapi-schema/do=
c-bad-event-arg.out
new file mode 100644
index 0000000000..ad0367cd45
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-event-arg.out
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
+module doc-bad-event-arg.json
+event FOO None
+    boxed=3DFalse
+doc symbol=3DFOO
+    body=3D
+
+    arg=3Da
+a
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.j=
son
index 7dc21e58a3..1ae6c3a9da 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -149,3 +149,10 @@
 { 'command': 'cmd-boxed', 'boxed': true,
   'data': 'Object',
   'features': [ 'cmd-feat1', 'cmd-feat2' ] }
+
+##
+# @EVT-BOXED:
+# BUG: generated doc misses arguments
+##
+{ 'event': 'EVT-BOXED',  'boxed': true,
+  'data': 'Object' }
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.ou=
t
index f78fdef6a9..a8fc39d288 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -54,6 +54,8 @@ command cmd-boxed Object -> None
     gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse preconfig=
=3DFalse
     feature cmd-feat1
     feature cmd-feat2
+event EVT-BOXED Object
+    boxed=3DTrue
 doc freeform
     body=3D
 =3D Section
@@ -170,3 +172,6 @@ If you're bored enough to read this, go see a video of =
boxed cats
 -> in
=20
 <- out
+doc symbol=3DEVT-BOXED
+    body=3D
+BUG: generated doc misses arguments
--=20
2.21.0


