Return-Path: <SRS0=JFFZ=XX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C58C4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 19:01:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27BE42082F
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 19:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27BE42082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEHy7-0004bH-Jw
	for qemu-devel@archiver.kernel.org; Sat, 28 Sep 2019 15:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iEHd8-0008Pk-H3
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 14:39:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iEHd5-0003t5-1C
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 14:39:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56366)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iEHd4-0003rJ-OW
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 14:39:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E6FCD3082DDD
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2019 18:39:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9162F60BF7;
 Sat, 28 Sep 2019 18:39:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 45746113860E; Sat, 28 Sep 2019 20:39:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/27] qapi: Improve reporting of member name clashes
Date: Sat, 28 Sep 2019 20:39:15 +0200
Message-Id: <20190928183934.12459-9-armbru@redhat.com>
In-Reply-To: <20190928183934.12459-1-armbru@redhat.com>
References: <20190928183934.12459-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Sat, 28 Sep 2019 18:39:37 +0000 (UTC)
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We report name clashes like this:

    struct-base-clash.json: In struct 'Sub':
    struct-base-clash.json:5: 'name' (member of Sub) collides with 'name'=
 (member of Base)

The "(member of Sub)" is redundant with "In struct 'Sub'".  Comes from
QAPISchemaMember.describe().  Pass info to it, so it can detect the
redundancy and avoid it.  Result:

    struct-base-clash.json: In struct 'Sub':
    struct-base-clash.json:5: member 'name' collides with member 'name' o=
f type 'Base'

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190927134639.4284-8-armbru@redhat.com>
---
 scripts/qapi/common.py                        | 36 ++++++++++++-------
 tests/qapi-schema/alternate-clash.err         |  2 +-
 tests/qapi-schema/args-name-clash.err         |  2 +-
 tests/qapi-schema/enum-clash-member.err       |  2 +-
 tests/qapi-schema/features-duplicate-name.err |  2 +-
 tests/qapi-schema/flat-union-bad-base.err     |  2 +-
 tests/qapi-schema/flat-union-clash-member.err |  2 +-
 tests/qapi-schema/struct-base-clash-deep.err  |  2 +-
 tests/qapi-schema/struct-base-clash.err       |  2 +-
 tests/qapi-schema/union-clash-branches.err    |  2 +-
 10 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 3d73332487..14d1e34c2c 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1575,31 +1575,41 @@ class QAPISchemaMember(object):
     def check_clash(self, info, seen):
         cname =3D c_name(self.name)
         if cname in seen:
-            raise QAPISemError(info, "%s collides with %s" %
-                               (self.describe(), seen[cname].describe())=
)
+            raise QAPISemError(
+                info,
+                "%s collides with %s"
+                % (self.describe(info), seen[cname].describe(info)))
         seen[cname] =3D self
=20
-    def _pretty_defined_in(self):
+    def describe(self, info):
+        role =3D self.role
         defined_in =3D self.defined_in
+        assert defined_in
+
         if defined_in.startswith('q_obj_'):
             # See QAPISchema._make_implicit_object_type() - reverse the
             # mapping there to create a nice human-readable description
             defined_in =3D defined_in[6:]
             if defined_in.endswith('-arg'):
-                return '(parameter of %s)' % defined_in[:-4]
+                # Implicit type created for a command's dict 'data'
+                assert role =3D=3D 'member'
+                role =3D 'parameter'
             elif defined_in.endswith('-base'):
-                return '(base of %s)' % defined_in[:-5]
+                # Implicit type created for a flat union's dict 'base'
+                role =3D 'base ' + role
             else:
+                # Implicit type created for a simple union's branch
                 assert defined_in.endswith('-wrapper')
                 # Unreachable and not implemented
                 assert False
-        if defined_in.endswith('Kind'):
+        elif defined_in.endswith('Kind'):
             # See QAPISchema._make_implicit_enum_type()
-            return '(branch of %s)' % defined_in[:-4]
-        return '(%s of %s)' % (self.role, defined_in)
-
-    def describe(self):
-        return "'%s' %s" % (self.name, self._pretty_defined_in())
+            # Implicit enum created for simple union's branches
+            assert role =3D=3D 'value'
+            role =3D 'branch'
+        elif defined_in !=3D info.defn_name:
+            return "%s '%s' of type '%s'" % (role, self.name, defined_in=
)
+        return "%s '%s'" % (role, self.name)
=20
=20
 class QAPISchemaEnumMember(QAPISchemaMember):
@@ -1871,7 +1881,7 @@ class QAPISchema(object):
                 for v in values]
=20
     def _make_implicit_enum_type(self, name, info, ifcond, values):
-        # See also QAPISchemaObjectTypeMember._pretty_defined_in()
+        # See also QAPISchemaObjectTypeMember.describe()
         name =3D name + 'Kind'   # Use namespace reserved by add_name()
         self._def_entity(QAPISchemaEnumType(
             name, info, None, ifcond, self._make_enum_members(values), N=
one))
@@ -1887,7 +1897,7 @@ class QAPISchema(object):
                                    role, members):
         if not members:
             return None
-        # See also QAPISchemaObjectTypeMember._pretty_defined_in()
+        # See also QAPISchemaObjectTypeMember.describe()
         name =3D 'q_obj_%s-%s' % (name, role)
         typ =3D self.lookup_entity(name, QAPISchemaObjectType)
         if typ:
diff --git a/tests/qapi-schema/alternate-clash.err b/tests/qapi-schema/al=
ternate-clash.err
index 426ff6a7c4..73a52d69d1 100644
--- a/tests/qapi-schema/alternate-clash.err
+++ b/tests/qapi-schema/alternate-clash.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/alternate-clash.json: In alternate 'Alt1':
-tests/qapi-schema/alternate-clash.json:7: 'a_b' (branch of Alt1) collide=
s with 'a-b' (branch of Alt1)
+tests/qapi-schema/alternate-clash.json:7: branch 'a_b' collides with bra=
nch 'a-b'
diff --git a/tests/qapi-schema/args-name-clash.err b/tests/qapi-schema/ar=
gs-name-clash.err
index eeb4e1b4dd..c5916a80fb 100644
--- a/tests/qapi-schema/args-name-clash.err
+++ b/tests/qapi-schema/args-name-clash.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/args-name-clash.json: In command 'oops':
-tests/qapi-schema/args-name-clash.json:4: 'a_b' (parameter of oops) coll=
ides with 'a-b' (parameter of oops)
+tests/qapi-schema/args-name-clash.json:4: parameter 'a_b' collides with =
parameter 'a-b'
diff --git a/tests/qapi-schema/enum-clash-member.err b/tests/qapi-schema/=
enum-clash-member.err
index 26944f5e06..84e02db82c 100644
--- a/tests/qapi-schema/enum-clash-member.err
+++ b/tests/qapi-schema/enum-clash-member.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/enum-clash-member.json: In enum 'MyEnum':
-tests/qapi-schema/enum-clash-member.json:2: 'one_two' (value of MyEnum) =
collides with 'one-two' (value of MyEnum)
+tests/qapi-schema/enum-clash-member.json:2: value 'one_two' collides wit=
h value 'one-two'
diff --git a/tests/qapi-schema/features-duplicate-name.err b/tests/qapi-s=
chema/features-duplicate-name.err
index 0ebec8e4b0..a99bbde737 100644
--- a/tests/qapi-schema/features-duplicate-name.err
+++ b/tests/qapi-schema/features-duplicate-name.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/features-duplicate-name.json: In struct 'FeatureStruct=
0':
-tests/qapi-schema/features-duplicate-name.json:1: 'foo' (feature of Feat=
ureStruct0) collides with 'foo' (feature of FeatureStruct0)
+tests/qapi-schema/features-duplicate-name.json:1: feature 'foo' collides=
 with feature 'foo'
diff --git a/tests/qapi-schema/flat-union-bad-base.err b/tests/qapi-schem=
a/flat-union-bad-base.err
index ae8adc3947..5da7602c20 100644
--- a/tests/qapi-schema/flat-union-bad-base.err
+++ b/tests/qapi-schema/flat-union-bad-base.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/flat-union-bad-base.json: In union 'TestUnion':
-tests/qapi-schema/flat-union-bad-base.json:8: 'string' (member of TestTy=
peA) collides with 'string' (base of TestUnion)
+tests/qapi-schema/flat-union-bad-base.json:8: member 'string' of type 'T=
estTypeA' collides with base member 'string'
diff --git a/tests/qapi-schema/flat-union-clash-member.err b/tests/qapi-s=
chema/flat-union-clash-member.err
index 48e939db19..40f10681f8 100644
--- a/tests/qapi-schema/flat-union-clash-member.err
+++ b/tests/qapi-schema/flat-union-clash-member.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/flat-union-clash-member.json: In union 'TestUnion':
-tests/qapi-schema/flat-union-clash-member.json:11: 'name' (member of Bra=
nch1) collides with 'name' (member of Base)
+tests/qapi-schema/flat-union-clash-member.json:11: member 'name' of type=
 'Branch1' collides with member 'name' of type 'Base'
diff --git a/tests/qapi-schema/struct-base-clash-deep.err b/tests/qapi-sc=
hema/struct-base-clash-deep.err
index 53e9bb108e..2b12b3c07f 100644
--- a/tests/qapi-schema/struct-base-clash-deep.err
+++ b/tests/qapi-schema/struct-base-clash-deep.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/struct-base-clash-deep.json: In struct 'Sub':
-tests/qapi-schema/struct-base-clash-deep.json:10: 'name' (member of Sub)=
 collides with 'name' (member of Base)
+tests/qapi-schema/struct-base-clash-deep.json:10: member 'name' collides=
 with member 'name' of type 'Base'
diff --git a/tests/qapi-schema/struct-base-clash.err b/tests/qapi-schema/=
struct-base-clash.err
index bf94eee8b3..8c3ee1c435 100644
--- a/tests/qapi-schema/struct-base-clash.err
+++ b/tests/qapi-schema/struct-base-clash.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/struct-base-clash.json: In struct 'Sub':
-tests/qapi-schema/struct-base-clash.json:5: 'name' (member of Sub) colli=
des with 'name' (member of Base)
+tests/qapi-schema/struct-base-clash.json:5: member 'name' collides with =
member 'name' of type 'Base'
diff --git a/tests/qapi-schema/union-clash-branches.err b/tests/qapi-sche=
ma/union-clash-branches.err
index 145efebd9f..931399f076 100644
--- a/tests/qapi-schema/union-clash-branches.err
+++ b/tests/qapi-schema/union-clash-branches.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/union-clash-branches.json: In union 'TestUnion':
-tests/qapi-schema/union-clash-branches.json:4: 'a_b' (branch of TestUnio=
n) collides with 'a-b' (branch of TestUnion)
+tests/qapi-schema/union-clash-branches.json:4: branch 'a_b' collides wit=
h branch 'a-b'
--=20
2.21.0


