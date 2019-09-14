Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA84C4CEC7
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 15:51:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 535D420830
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 15:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535D420830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9AKs-00057G-PJ
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 11:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54452)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i9A5E-000540-QH
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 11:35:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i9A5B-0004zU-5S
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 11:35:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42898)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i9A5A-0004sP-5d
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 11:35:29 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 90A1B85536;
 Sat, 14 Sep 2019 15:35:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 315A81053B1C;
 Sat, 14 Sep 2019 15:35:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A63B411384D8; Sat, 14 Sep 2019 17:35:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 14 Sep 2019 17:34:56 +0200
Message-Id: <20190914153506.2151-10-armbru@redhat.com>
In-Reply-To: <20190914153506.2151-1-armbru@redhat.com>
References: <20190914153506.2151-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Sat, 14 Sep 2019 15:35:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 09/19] qapi: Remove null from schema language
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
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We represent the parse tree as OrderedDict.  We fetch optional dict
members with .get().  So far, so good.

We represent null literals as None.  .get() returns None both for
"absent" and for "present, value is the null literal".  Uh-oh.

Test features-if-invalid exposes this bug: "'if': null" is
misinterpreted as absent "if".

We added null to the schema language to "allow [...] an explicit
default value" (commit e53188ada5 "qapi: Allow true, false and null in
schema json", v2.4.0).  Hasn't happened; null is still unused except
as generic invalid value in tests/.

To fix, we'd have to replace .get() by something more careful, or
represent null differently.  Feasible, but we got more and bigger fish
to fry right now.  Remove the null literal from the schema language.
Replace null in tests by another invalid value.

Test features-if-invalid now behaves as it should.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt                       |  4 ++--
 scripts/qapi/common.py                             |  4 ----
 tests/qapi-schema/features-if-invalid.err          |  1 +
 tests/qapi-schema/features-if-invalid.exit         |  2 +-
 tests/qapi-schema/features-if-invalid.json         |  3 +--
 tests/qapi-schema/features-if-invalid.out          | 14 --------------
 .../pragma-name-case-whitelist-crap.json           |  2 +-
 7 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 94f3054898..b4df31813d 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -52,7 +52,7 @@ Differences:
 * Strings are restricted to printable ASCII, and escape sequences to
   just '\\'.
=20
-* Numbers are not supported.
+* Numbers and null are not supported.
=20
 A second layer of syntax defines the sequences of JSON texts that are
 a correctly structured QAPI schema.  We provide a grammar for this
@@ -67,7 +67,7 @@ syntax in an EBNF-like notation:
   expression A separated by ,
 * Grouping: expression ( A ) matches expression A
 * JSON's structural characters are terminals: { } [ ] : ,
-* JSON's literal names are terminals: false true null
+* JSON's literal names are terminals: false true
 * String literals enclosed in 'single quotes' are terminal, and match
   this JSON string, with a leading '*' stripped off
 * When JSON object member's name starts with '*', the member is
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index b3383b17ef..ef7c7be4fd 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -548,10 +548,6 @@ class QAPISchemaParser(object):
                 self.val =3D False
                 self.cursor +=3D 4
                 return
-            elif self.src.startswith('null', self.pos):
-                self.val =3D None
-                self.cursor +=3D 3
-                return
             elif self.tok =3D=3D '\n':
                 if self.cursor =3D=3D len(self.src):
                     self.tok =3D None
diff --git a/tests/qapi-schema/features-if-invalid.err b/tests/qapi-schem=
a/features-if-invalid.err
index e69de29bb2..295800b4fc 100644
--- a/tests/qapi-schema/features-if-invalid.err
+++ b/tests/qapi-schema/features-if-invalid.err
@@ -0,0 +1 @@
+tests/qapi-schema/features-if-invalid.json:2: 'if' condition must be a s=
tring or a list of strings
diff --git a/tests/qapi-schema/features-if-invalid.exit b/tests/qapi-sche=
ma/features-if-invalid.exit
index 573541ac97..d00491fd7e 100644
--- a/tests/qapi-schema/features-if-invalid.exit
+++ b/tests/qapi-schema/features-if-invalid.exit
@@ -1 +1 @@
-0
+1
diff --git a/tests/qapi-schema/features-if-invalid.json b/tests/qapi-sche=
ma/features-if-invalid.json
index e6a524196d..89c2a6c234 100644
--- a/tests/qapi-schema/features-if-invalid.json
+++ b/tests/qapi-schema/features-if-invalid.json
@@ -1,5 +1,4 @@
 # Cover feature with invalid 'if'
-# FIXME not rejected, misinterpreded as unconditional
 { 'struct': 'Stru',
   'data': {},
-  'features': [{'name': 'f', 'if': null }] }
+  'features': [{'name': 'f', 'if': false }] }
diff --git a/tests/qapi-schema/features-if-invalid.out b/tests/qapi-schem=
a/features-if-invalid.out
index 9c2637baa3..e69de29bb2 100644
--- a/tests/qapi-schema/features-if-invalid.out
+++ b/tests/qapi-schema/features-if-invalid.out
@@ -1,14 +0,0 @@
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
-module features-if-invalid.json
-object Stru
-    feature f
diff --git a/tests/qapi-schema/pragma-name-case-whitelist-crap.json b/tes=
ts/qapi-schema/pragma-name-case-whitelist-crap.json
index 58382bf4e4..734e1c617b 100644
--- a/tests/qapi-schema/pragma-name-case-whitelist-crap.json
+++ b/tests/qapi-schema/pragma-name-case-whitelist-crap.json
@@ -1,3 +1,3 @@
 # 'name-case-whitelist' must be list of strings
=20
-{ 'pragma': { 'name-case-whitelist': null } }
+{ 'pragma': { 'name-case-whitelist': false } }
--=20
2.21.0


