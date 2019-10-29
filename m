Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2717DCA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:46:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E881B2054F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XIsOUWT6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E881B2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPP1U-0004RK-4T
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 06:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iPOeP-0005oP-OG
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:23:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iPOeM-0001Nn-3b
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39448
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iPOeM-0001NX-07
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572344573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JKwVICVyptStW+1H5B2+rYomcxxf79KECgmCJBaCaSc=;
 b=XIsOUWT6XJvMA9pPxs0g+ZoByngunReeyPKW8ZJkyqkUG/NWAp3usQoR/Rbxqaj/lCBPmx
 jtOzyMTCQUSrF0VPgRyrASDuZIGimhgjKKn6SV0663R1bF9OH97QyBrNDXRrU8pFx4FyN9
 Iq/xUio3/hMxEdc2drStGsRfHUjLuWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-4WQltdnqOGut6TUF6gkNDg-1; Tue, 29 Oct 2019 06:22:47 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8BB61005500
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 10:22:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F76D1001B08
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 10:22:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B6C5911326F2; Tue, 29 Oct 2019 11:22:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/19] qapi: Check feature documentation against the schema
Date: Tue, 29 Oct 2019 11:22:28 +0100
Message-Id: <20191029102228.20740-20-armbru@redhat.com>
In-Reply-To: <20191029102228.20740-1-armbru@redhat.com>
References: <20191029102228.20740-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 4WQltdnqOGut6TUF6gkNDg-1
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

Commit f3ed93d545 "qapi: Allow documentation for features" neglected
to check documentation against the schema.  Fix that: check them the
same way we check arguments.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20191024110237.30963-20-armbru@redhat.com>
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


