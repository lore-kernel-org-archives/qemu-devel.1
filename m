Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F261C4CEC7
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 15:40:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E89D220717
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 15:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E89D220717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9A9q-0001vG-DT
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 11:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i9A59-0004xW-VZ
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 11:35:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i9A57-0004xO-TF
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 11:35:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51098)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i9A55-0004sR-RH
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 11:35:25 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 995F130833A8;
 Sat, 14 Sep 2019 15:35:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DFC42655F;
 Sat, 14 Sep 2019 15:35:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AFCDE1136445; Sat, 14 Sep 2019 17:35:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 14 Sep 2019 17:34:59 +0200
Message-Id: <20190914153506.2151-13-armbru@redhat.com>
In-Reply-To: <20190914153506.2151-1-armbru@redhat.com>
References: <20190914153506.2151-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Sat, 14 Sep 2019 15:35:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 12/19] qapi: Fix missing 'if' checks in struct,
 union, alternate 'data'
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

Commit 87adbbffd4..3e270dcacc "qapi: Add 'if' to (implicit
struct|union|alternate) members" (v4.0.0) neglected test coverage, and
promptly failed to check the conditions.  Review fail.

Recent commit "tests/qapi-schema: Demonstrate insufficient 'if'
checking" added test coverage, demonstrating the bug.  Fix it by add
the missing check_if().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py                        |  3 +++
 .../alternate-branch-if-invalid.err           |  1 +
 .../alternate-branch-if-invalid.exit          |  2 +-
 .../alternate-branch-if-invalid.json          |  1 -
 .../alternate-branch-if-invalid.out           | 16 -------------
 .../qapi-schema/struct-member-if-invalid.err  |  1 +
 .../qapi-schema/struct-member-if-invalid.exit |  2 +-
 .../qapi-schema/struct-member-if-invalid.json |  1 -
 .../qapi-schema/struct-member-if-invalid.out  | 15 ------------
 tests/qapi-schema/union-branch-if-invalid.err |  1 +
 .../qapi-schema/union-branch-if-invalid.exit  |  2 +-
 .../qapi-schema/union-branch-if-invalid.json  |  1 -
 tests/qapi-schema/union-branch-if-invalid.out | 23 -------------------
 13 files changed, 9 insertions(+), 60 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 2b46164854..cacee9b8bb 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -803,6 +803,7 @@ def check_type(info, source, value,
         # an optional argument.
         check_known_keys(info, "member '%s' of %s" % (key, source),
                          arg, ['type'], ['if'])
+        check_if(arg, info)
         check_type(info, "Member '%s' of %s" % (key, source),
                    arg['type'], allow_array=3DTrue,
                    allow_metas=3D['built-in', 'union', 'alternate', 'str=
uct',
@@ -902,6 +903,7 @@ def check_union(expr, info):
=20
         check_known_keys(info, "member '%s' of union '%s'" % (key, name)=
,
                          value, ['type'], ['if'])
+        check_if(value, info)
         # Each value must name a known type
         check_type(info, "Member '%s' of union '%s'" % (key, name),
                    value['type'],
@@ -930,6 +932,7 @@ def check_alternate(expr, info):
         check_known_keys(info,
                          "member '%s' of alternate '%s'" % (key, name),
                          value, ['type'], ['if'])
+        check_if(value, info)
         typ =3D value['type']
=20
         # Ensure alternates have no type conflicts.
diff --git a/tests/qapi-schema/alternate-branch-if-invalid.err b/tests/qa=
pi-schema/alternate-branch-if-invalid.err
index e69de29bb2..f1d6c10e00 100644
--- a/tests/qapi-schema/alternate-branch-if-invalid.err
+++ b/tests/qapi-schema/alternate-branch-if-invalid.err
@@ -0,0 +1 @@
+tests/qapi-schema/alternate-branch-if-invalid.json:2: 'if' condition ' '=
 makes no sense
diff --git a/tests/qapi-schema/alternate-branch-if-invalid.exit b/tests/q=
api-schema/alternate-branch-if-invalid.exit
index 573541ac97..d00491fd7e 100644
--- a/tests/qapi-schema/alternate-branch-if-invalid.exit
+++ b/tests/qapi-schema/alternate-branch-if-invalid.exit
@@ -1 +1 @@
-0
+1
diff --git a/tests/qapi-schema/alternate-branch-if-invalid.json b/tests/q=
api-schema/alternate-branch-if-invalid.json
index 6497f53475..fea6d9080c 100644
--- a/tests/qapi-schema/alternate-branch-if-invalid.json
+++ b/tests/qapi-schema/alternate-branch-if-invalid.json
@@ -1,4 +1,3 @@
 # Cover alternative with invalid 'if'
-# FIXME not rejected, would generate '#if  \n'
 { 'alternate': 'Alt',
   'data': { 'branch': { 'type': 'int', 'if': ' ' } } }
diff --git a/tests/qapi-schema/alternate-branch-if-invalid.out b/tests/qa=
pi-schema/alternate-branch-if-invalid.out
index 89305d7f21..e69de29bb2 100644
--- a/tests/qapi-schema/alternate-branch-if-invalid.out
+++ b/tests/qapi-schema/alternate-branch-if-invalid.out
@@ -1,16 +0,0 @@
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
-module alternate-branch-if-invalid.json
-alternate Alt
-    tag type
-    case branch: int
-        if [' ']
diff --git a/tests/qapi-schema/struct-member-if-invalid.err b/tests/qapi-=
schema/struct-member-if-invalid.err
index e69de29bb2..bfd65db97b 100644
--- a/tests/qapi-schema/struct-member-if-invalid.err
+++ b/tests/qapi-schema/struct-member-if-invalid.err
@@ -0,0 +1 @@
+tests/qapi-schema/struct-member-if-invalid.json:2: 'if' condition must b=
e a string or a list of strings
diff --git a/tests/qapi-schema/struct-member-if-invalid.exit b/tests/qapi=
-schema/struct-member-if-invalid.exit
index 573541ac97..d00491fd7e 100644
--- a/tests/qapi-schema/struct-member-if-invalid.exit
+++ b/tests/qapi-schema/struct-member-if-invalid.exit
@@ -1 +1 @@
-0
+1
diff --git a/tests/qapi-schema/struct-member-if-invalid.json b/tests/qapi=
-schema/struct-member-if-invalid.json
index 73987e04fc..35078bd660 100644
--- a/tests/qapi-schema/struct-member-if-invalid.json
+++ b/tests/qapi-schema/struct-member-if-invalid.json
@@ -1,4 +1,3 @@
 # Cover member with invalid 'if'
-# FIXME not rejected, would generate '#if True\n'
 { 'struct': 'Stru',
   'data': { 'member': { 'type': 'int', 'if': true } } }
diff --git a/tests/qapi-schema/struct-member-if-invalid.out b/tests/qapi-=
schema/struct-member-if-invalid.out
index 8fbb97985c..e69de29bb2 100644
--- a/tests/qapi-schema/struct-member-if-invalid.out
+++ b/tests/qapi-schema/struct-member-if-invalid.out
@@ -1,15 +0,0 @@
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
-module struct-member-if-invalid.json
-object Stru
-    member member: int optional=3DFalse
-        if [True]
diff --git a/tests/qapi-schema/union-branch-if-invalid.err b/tests/qapi-s=
chema/union-branch-if-invalid.err
index e69de29bb2..607edee382 100644
--- a/tests/qapi-schema/union-branch-if-invalid.err
+++ b/tests/qapi-schema/union-branch-if-invalid.err
@@ -0,0 +1 @@
+tests/qapi-schema/union-branch-if-invalid.json:4: 'if' condition '' make=
s no sense
diff --git a/tests/qapi-schema/union-branch-if-invalid.exit b/tests/qapi-=
schema/union-branch-if-invalid.exit
index 573541ac97..d00491fd7e 100644
--- a/tests/qapi-schema/union-branch-if-invalid.exit
+++ b/tests/qapi-schema/union-branch-if-invalid.exit
@@ -1 +1 @@
-0
+1
diff --git a/tests/qapi-schema/union-branch-if-invalid.json b/tests/qapi-=
schema/union-branch-if-invalid.json
index 859b63b610..46d4239af6 100644
--- a/tests/qapi-schema/union-branch-if-invalid.json
+++ b/tests/qapi-schema/union-branch-if-invalid.json
@@ -1,5 +1,4 @@
 # Cover branch with invalid 'if'
-# FIXME not rejected, would generate '#if \n'
 { 'enum': 'Branches', 'data': ['branch1'] }
 { 'struct': 'Stru', 'data': { 'member': 'str' } }
 { 'union': 'Uni',
diff --git a/tests/qapi-schema/union-branch-if-invalid.out b/tests/qapi-s=
chema/union-branch-if-invalid.out
index 2ed43218af..e69de29bb2 100644
--- a/tests/qapi-schema/union-branch-if-invalid.out
+++ b/tests/qapi-schema/union-branch-if-invalid.out
@@ -1,23 +0,0 @@
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
-module union-branch-if-invalid.json
-enum Branches
-    member branch1
-object Stru
-    member member: str optional=3DFalse
-object q_obj_Uni-base
-    member tag: Branches optional=3DFalse
-object Uni
-    base q_obj_Uni-base
-    tag tag
-    case branch1: Stru
-        if ['']
--=20
2.21.0


