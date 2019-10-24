Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5A4CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:33:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8659220679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KwN6E4ta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8659220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbNE-0003xs-FI
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 07:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNatM-000126-Aw
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNatI-0004uK-JU
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31206
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNatG-0004r0-Kd
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571914968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iOEcPd3gG1rwZDF+O6gIueB0do2koRN51n2cuRDs3gs=;
 b=KwN6E4taA6gl4uPbdc8M9dyZz8W+jWitzJKETKqw6Kyb4Xq9i3WOLJfSvgj25EdwE8yDp2
 rjbXJG3lIeHGdQjxs2pXN9vqjrTe67ox3uBtzp3034Jk3zXylNo+wWPdbE6ka1PO8MItUw
 WLQDdAEmBgS7TwhLnH8hmgYvptbMNa8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-XXu_ikWpORqD9wob7IWzdg-1; Thu, 24 Oct 2019 07:02:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 859735E4;
 Thu, 24 Oct 2019 11:02:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BD5D60BF3;
 Thu, 24 Oct 2019 11:02:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8E311112FB55; Thu, 24 Oct 2019 13:02:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/19] qapi: Check feature documentation against the schema
Date: Thu, 24 Oct 2019 13:02:37 +0200
Message-Id: <20191024110237.30963-20-armbru@redhat.com>
In-Reply-To: <20191024110237.30963-1-armbru@redhat.com>
References: <20191024110237.30963-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: XXu_ikWpORqD9wob7IWzdg-1
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

Commit f3ed93d545 "qapi: Allow documentation for features" neglected
to check documentation against the schema.  Fix that: check them the
same way we check arguments.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/parser.py                   | 31 +++++++++++++++++-------
 scripts/qapi/schema.py                   |  2 ++
 tests/qapi-schema/doc-bad-feature.err    |  1 +
 tests/qapi-schema/doc-bad-feature.json   |  1 -
 tests/qapi-schema/doc-bad-feature.out    | 19 ---------------
 tests/qapi-schema/doc-undoc-feature.err  |  2 ++
 tests/qapi-schema/doc-undoc-feature.json |  1 -
 tests/qapi-schema/doc-undoc-feature.out  | 21 ----------------
 8 files changed, 27 insertions(+), 51 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 6c45a00cf4..342792e410 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -555,18 +555,31 @@ class QAPIDoc(object):
             self.args[member.name] =3D QAPIDoc.ArgSection(member.name)
         self.args[member.name].connect(member)
=20
+    def connect_feature(self, feature):
+        if feature.name not in self.features:
+            raise QAPISemError(feature.info,
+                               "feature '%s' lacks documentation"
+                               % feature.name)
+            self.features[feature.name] =3D QAPIDoc.ArgSection(feature.nam=
e)
+        self.features[feature.name].connect(feature)
+
     def check_expr(self, expr):
         if self.has_section('Returns') and 'command' not in expr:
             raise QAPISemError(self.info,
                                "'Returns:' is only valid for commands")
=20
     def check(self):
-        bogus =3D [name for name, section in self.args.items()
-                 if not section.member]
-        if bogus:
-            raise QAPISemError(
-                self.info,
-                "documented member%s '%s' %s not exist"
-                % ("s" if len(bogus) > 1 else "",
-                   "', '".join(bogus),
-                   "do" if len(bogus) > 1 else "does"))
+
+        def check_args_section(args, info, what):
+            bogus =3D [name for name, section in args.items()
+                     if not section.member]
+            if bogus:
+                raise QAPISemError(
+                    self.info,
+                    "documented member%s '%s' %s not exist"
+                    % ("s" if len(bogus) > 1 else "",
+                       "', '".join(bogus),
+                       "do" if len(bogus) > 1 else "does"))
+
+        check_args_section(self.args, self.info, 'members')
+        check_args_section(self.features, self.info, 'features')
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index bdea9482fc..cf0045f34e 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -56,6 +56,8 @@ class QAPISchemaEntity(object):
         seen =3D {}
         for f in self.features:
             f.check_clash(self.info, seen)
+            if self.doc:
+                self.doc.connect_feature(f)
=20
         self._checked =3D True
=20
diff --git a/tests/qapi-schema/doc-bad-feature.err b/tests/qapi-schema/doc-=
bad-feature.err
index e69de29bb2..e4c62adfa3 100644
--- a/tests/qapi-schema/doc-bad-feature.err
+++ b/tests/qapi-schema/doc-bad-feature.err
@@ -0,0 +1 @@
+doc-bad-feature.json:3: documented member 'a' does not exist
diff --git a/tests/qapi-schema/doc-bad-feature.json b/tests/qapi-schema/doc=
-bad-feature.json
index 2a78e3b1db..3d49b8e607 100644
--- a/tests/qapi-schema/doc-bad-feature.json
+++ b/tests/qapi-schema/doc-bad-feature.json
@@ -1,5 +1,4 @@
 # Features listed in the doc comment must exist in the actual schema
-# BUG: nonexistent @a is not rejected
=20
 ##
 # @foo:
diff --git a/tests/qapi-schema/doc-bad-feature.out b/tests/qapi-schema/doc-=
bad-feature.out
index fef4a3e400..e69de29bb2 100644
--- a/tests/qapi-schema/doc-bad-feature.out
+++ b/tests/qapi-schema/doc-bad-feature.out
@@ -1,19 +0,0 @@
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
-module doc-bad-feature.json
-command foo None -> None
-    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
-doc symbol=3Dfoo
-    body=3D
-
-    feature=3Da
-a
diff --git a/tests/qapi-schema/doc-undoc-feature.err b/tests/qapi-schema/do=
c-undoc-feature.err
index e69de29bb2..62fc82d2b9 100644
--- a/tests/qapi-schema/doc-undoc-feature.err
+++ b/tests/qapi-schema/doc-undoc-feature.err
@@ -0,0 +1,2 @@
+doc-undoc-feature.json: In command 'foo':
+doc-undoc-feature.json:9: feature 'undoc' lacks documentation
diff --git a/tests/qapi-schema/doc-undoc-feature.json b/tests/qapi-schema/d=
oc-undoc-feature.json
index c7650d9974..c52f88e2cd 100644
--- a/tests/qapi-schema/doc-undoc-feature.json
+++ b/tests/qapi-schema/doc-undoc-feature.json
@@ -1,5 +1,4 @@
 # Doc comment must cover all features
-# BUG: missing documentation for @undoc not caught
=20
 ##
 # @foo:
diff --git a/tests/qapi-schema/doc-undoc-feature.out b/tests/qapi-schema/do=
c-undoc-feature.out
index cdb097361f..e69de29bb2 100644
--- a/tests/qapi-schema/doc-undoc-feature.out
+++ b/tests/qapi-schema/doc-undoc-feature.out
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
-module doc-undoc-feature.json
-command foo None -> None
-    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
-    feature undoc
-    feature doc
-doc symbol=3Dfoo
-    body=3D
-
-    feature=3Ddoc
-documented feature
--=20
2.21.0


