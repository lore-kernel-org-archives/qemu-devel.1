Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57006C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 15:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C5F3205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 15:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C5F3205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDsVU-00083j-Sg
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 11:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iDqaF-0001Ky-Uh
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:47:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iDqa9-00065a-3J
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:46:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24486)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iDqa8-00063y-Hy
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:46:48 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3FAD810CC1F4;
 Fri, 27 Sep 2019 13:46:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B8C61194B6;
 Fri, 27 Sep 2019 13:46:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AC5971136422; Fri, 27 Sep 2019 15:46:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 22/26] qapi: Improve reporting of invalid 'if' further
Date: Fri, 27 Sep 2019 15:46:35 +0200
Message-Id: <20190927134639.4284-23-armbru@redhat.com>
In-Reply-To: <20190927134639.4284-1-armbru@redhat.com>
References: <20190927134639.4284-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Fri, 27 Sep 2019 13:46:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

check_if()'s errors don't point to the offending part of the
expression.  For instance:

    tests/qapi-schema/alternate-branch-if-invalid.json:2: 'if' condition =
' ' makes no sense

Other check_FOO() do, with the help of a @source argument.  Make
check_if() do that, too.  The example above improves to:

    tests/qapi-schema/alternate-branch-if-invalid.json:2: 'if' condition =
' ' of 'data' member 'branch' makes no sense

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py                        | 27 +++++++++++--------
 .../alternate-branch-if-invalid.err           |  2 +-
 tests/qapi-schema/bad-if-empty-list.err       |  2 +-
 tests/qapi-schema/bad-if-empty.err            |  2 +-
 tests/qapi-schema/bad-if-list.err             |  2 +-
 tests/qapi-schema/bad-if.err                  |  2 +-
 tests/qapi-schema/enum-if-invalid.err         |  2 +-
 tests/qapi-schema/features-if-invalid.err     |  2 +-
 .../qapi-schema/struct-member-if-invalid.err  |  2 +-
 tests/qapi-schema/union-branch-if-invalid.err |  2 +-
 10 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 81c217cd60..4bc8c807aa 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -692,22 +692,27 @@ def check_defn_name_str(name, info, meta):
             info, "%s name should not end in '%s'" % (meta, name[-4:]))
=20
=20
-def check_if(expr, info):
+def check_if(expr, info, source):
=20
     def check_if_str(ifcond, info):
         if not isinstance(ifcond, str):
             raise QAPISemError(
-                info, "'if' condition must be a string or a list of stri=
ngs")
+                info,
+                "'if' condition of %s must be a string or a list of stri=
ngs"
+                % source)
         if ifcond.strip() =3D=3D '':
-            raise QAPISemError(info, "'if' condition '%s' makes no sense=
"
-                               % ifcond)
+            raise QAPISemError(
+                info,
+                "'if' condition '%s' of %s makes no sense"
+                % (ifcond, source))
=20
     ifcond =3D expr.get('if')
     if ifcond is None:
         return
     if isinstance(ifcond, list):
         if ifcond =3D=3D []:
-            raise QAPISemError(info, "'if' condition [] is useless")
+            raise QAPISemError(
+                info, "'if' condition [] of %s is useless" % source)
         for elt in ifcond:
             check_if_str(elt, info)
     else:
@@ -752,7 +757,7 @@ def check_type(value, info, source,
         if c_name(key, False) =3D=3D 'u' or c_name(key, False).startswit=
h('has_'):
             raise QAPISemError(info, "%s uses reserved name" % key_sourc=
e)
         check_known_keys(arg, info, key_source, ['type'], ['if'])
-        check_if(arg, info)
+        check_if(arg, info, key_source)
         normalize_if(arg)
         check_type(arg['type'], info, key_source, allow_array=3DTrue)
=20
@@ -796,7 +801,7 @@ def check_union(expr, info):
         source =3D "'data' member '%s'" % key
         check_name_str(key, info, source)
         check_known_keys(value, info, source, ['type'], ['if'])
-        check_if(value, info)
+        check_if(value, info, source)
         normalize_if(value)
         check_type(value['type'], info, source, allow_array=3Dnot base)
=20
@@ -810,7 +815,7 @@ def check_alternate(expr, info):
         source =3D "'data' member '%s'" % key
         check_name_str(key, info, source)
         check_known_keys(value, info, source, ['type'], ['if'])
-        check_if(value, info)
+        check_if(value, info, source)
         normalize_if(value)
         check_type(value['type'], info, source)
=20
@@ -834,7 +839,7 @@ def check_enum(expr, info):
         source =3D "%s '%s'" % (source, member['name'])
         check_name_str(member['name'], info, source,
                        enum_member=3DTrue, permit_upper=3Dpermit_upper)
-        check_if(member, info)
+        check_if(member, info, source)
         normalize_if(member)
=20
=20
@@ -856,7 +861,7 @@ def check_struct(expr, info):
             check_name_is_str(f['name'], info, source)
             source =3D "%s '%s'" % (source, f['name'])
             check_name_str(f['name'], info, source)
-            check_if(f, info)
+            check_if(f, info, source)
             normalize_if(f)
=20
=20
@@ -994,7 +999,7 @@ def check_exprs(exprs):
             assert False, 'unexpected meta type'
=20
         normalize_if(expr)
-        check_if(expr, info)
+        check_if(expr, info, meta)
         check_flags(expr, info)
=20
         if doc:
diff --git a/tests/qapi-schema/alternate-branch-if-invalid.err b/tests/qa=
pi-schema/alternate-branch-if-invalid.err
index 8684829aca..6c68e5a922 100644
--- a/tests/qapi-schema/alternate-branch-if-invalid.err
+++ b/tests/qapi-schema/alternate-branch-if-invalid.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/alternate-branch-if-invalid.json: In alternate 'Alt':
-tests/qapi-schema/alternate-branch-if-invalid.json:2: 'if' condition ' '=
 makes no sense
+tests/qapi-schema/alternate-branch-if-invalid.json:2: 'if' condition ' '=
 of 'data' member 'branch' makes no sense
diff --git a/tests/qapi-schema/bad-if-empty-list.err b/tests/qapi-schema/=
bad-if-empty-list.err
index 2218c9279b..517519f500 100644
--- a/tests/qapi-schema/bad-if-empty-list.err
+++ b/tests/qapi-schema/bad-if-empty-list.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/bad-if-empty-list.json: In struct 'TestIfStruct':
-tests/qapi-schema/bad-if-empty-list.json:2: 'if' condition [] is useless
+tests/qapi-schema/bad-if-empty-list.json:2: 'if' condition [] of struct =
is useless
diff --git a/tests/qapi-schema/bad-if-empty.err b/tests/qapi-schema/bad-i=
f-empty.err
index a3fdb3009d..5f1767388e 100644
--- a/tests/qapi-schema/bad-if-empty.err
+++ b/tests/qapi-schema/bad-if-empty.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/bad-if-empty.json: In struct 'TestIfStruct':
-tests/qapi-schema/bad-if-empty.json:2: 'if' condition '' makes no sense
+tests/qapi-schema/bad-if-empty.json:2: 'if' condition '' of struct makes=
 no sense
diff --git a/tests/qapi-schema/bad-if-list.err b/tests/qapi-schema/bad-if=
-list.err
index e03bf0fc3a..e5d72b2f39 100644
--- a/tests/qapi-schema/bad-if-list.err
+++ b/tests/qapi-schema/bad-if-list.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/bad-if-list.json: In struct 'TestIfStruct':
-tests/qapi-schema/bad-if-list.json:2: 'if' condition ' ' makes no sense
+tests/qapi-schema/bad-if-list.json:2: 'if' condition ' ' of struct makes=
 no sense
diff --git a/tests/qapi-schema/bad-if.err b/tests/qapi-schema/bad-if.err
index 190216c109..65d8efd7e4 100644
--- a/tests/qapi-schema/bad-if.err
+++ b/tests/qapi-schema/bad-if.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/bad-if.json: In struct 'TestIfStruct':
-tests/qapi-schema/bad-if.json:2: 'if' condition must be a string or a li=
st of strings
+tests/qapi-schema/bad-if.json:2: 'if' condition of struct must be a stri=
ng or a list of strings
diff --git a/tests/qapi-schema/enum-if-invalid.err b/tests/qapi-schema/en=
um-if-invalid.err
index db9eb45b25..30c1f0e91c 100644
--- a/tests/qapi-schema/enum-if-invalid.err
+++ b/tests/qapi-schema/enum-if-invalid.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/enum-if-invalid.json: In enum 'TestIfEnum':
-tests/qapi-schema/enum-if-invalid.json:2: 'if' condition must be a strin=
g or a list of strings
+tests/qapi-schema/enum-if-invalid.json:2: 'if' condition of 'data' membe=
r 'bar' must be a string or a list of strings
diff --git a/tests/qapi-schema/features-if-invalid.err b/tests/qapi-schem=
a/features-if-invalid.err
index 90f4119ae7..ffb39378af 100644
--- a/tests/qapi-schema/features-if-invalid.err
+++ b/tests/qapi-schema/features-if-invalid.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/features-if-invalid.json: In struct 'Stru':
-tests/qapi-schema/features-if-invalid.json:2: 'if' condition must be a s=
tring or a list of strings
+tests/qapi-schema/features-if-invalid.json:2: 'if' condition of 'feature=
s' member 'f' must be a string or a list of strings
diff --git a/tests/qapi-schema/struct-member-if-invalid.err b/tests/qapi-=
schema/struct-member-if-invalid.err
index e8ad02b9fc..4c5983674b 100644
--- a/tests/qapi-schema/struct-member-if-invalid.err
+++ b/tests/qapi-schema/struct-member-if-invalid.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/struct-member-if-invalid.json: In struct 'Stru':
-tests/qapi-schema/struct-member-if-invalid.json:2: 'if' condition must b=
e a string or a list of strings
+tests/qapi-schema/struct-member-if-invalid.json:2: 'if' condition of 'da=
ta' member 'member' must be a string or a list of strings
diff --git a/tests/qapi-schema/union-branch-if-invalid.err b/tests/qapi-s=
chema/union-branch-if-invalid.err
index b49cf9b664..14819bf8b8 100644
--- a/tests/qapi-schema/union-branch-if-invalid.err
+++ b/tests/qapi-schema/union-branch-if-invalid.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/union-branch-if-invalid.json: In union 'Uni':
-tests/qapi-schema/union-branch-if-invalid.json:4: 'if' condition '' make=
s no sense
+tests/qapi-schema/union-branch-if-invalid.json:4: 'if' condition '' of '=
data' member 'branch1' makes no sense
--=20
2.21.0


