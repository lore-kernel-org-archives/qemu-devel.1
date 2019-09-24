Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEEDC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:49:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51B1221655
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B1221655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCm7o-00089z-Kp
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 10:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCks9-0000PI-8U
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCkrx-0001Ue-Aw
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33514)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCkrw-0001Sw-L6
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C5730116BB23;
 Tue, 24 Sep 2019 13:28:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC47960E3E;
 Tue, 24 Sep 2019 13:28:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A80461136421; Tue, 24 Sep 2019 15:28:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 21/25] qapi: Avoid redundant definition references in error
 messages
Date: Tue, 24 Sep 2019 15:28:26 +0200
Message-Id: <20190924132830.15835-22-armbru@redhat.com>
In-Reply-To: <20190924132830.15835-1-armbru@redhat.com>
References: <20190924132830.15835-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Tue, 24 Sep 2019 13:28:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

Many error messages refer to the offending definition even though
they're preceded by an "in definition" line.  Rephrase them.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py                        | 113 +++++++-----------
 tests/qapi-schema/alternate-array.err         |   2 +-
 tests/qapi-schema/alternate-base.err          |   2 +-
 tests/qapi-schema/alternate-empty.err         |   2 +-
 tests/qapi-schema/alternate-invalid-dict.err  |   2 +-
 tests/qapi-schema/args-array-empty.err        |   2 +-
 tests/qapi-schema/args-boxed-anon.err         |   2 +-
 tests/qapi-schema/args-invalid.err            |   2 +-
 tests/qapi-schema/args-member-array-bad.err   |   2 +-
 tests/qapi-schema/args-member-case.err        |   2 +-
 tests/qapi-schema/bad-data.err                |   2 +-
 tests/qapi-schema/doc-bad-symbol.err          |   2 +-
 tests/qapi-schema/double-type.err             |   2 +-
 tests/qapi-schema/enum-bad-member.err         |   2 +-
 tests/qapi-schema/enum-bad-name.err           |   2 +-
 tests/qapi-schema/enum-bad-prefix.err         |   2 +-
 .../qapi-schema/enum-dict-member-unknown.err  |   2 +-
 tests/qapi-schema/enum-member-case.err        |   2 +-
 tests/qapi-schema/enum-missing-data.err       |   2 +-
 tests/qapi-schema/enum-wrong-data.err         |   2 +-
 .../qapi-schema/event-member-invalid-dict.err |   2 +-
 tests/qapi-schema/event-nest-struct.err       |   2 +-
 tests/qapi-schema/features-bad-type.err       |   2 +-
 tests/qapi-schema/features-missing-name.err   |   2 +-
 tests/qapi-schema/features-name-bad-type.err  |   2 +-
 tests/qapi-schema/features-no-list.err        |   2 +-
 tests/qapi-schema/features-unknown-key.err    |   2 +-
 tests/qapi-schema/flat-union-array-branch.err |   2 +-
 .../flat-union-bad-discriminator.err          |   2 +-
 .../flat-union-inline-invalid-dict.err        |   2 +-
 tests/qapi-schema/flat-union-inline.err       |   2 +-
 tests/qapi-schema/flat-union-no-base.err      |   2 +-
 .../nested-struct-data-invalid-dict.err       |   2 +-
 tests/qapi-schema/nested-struct-data.err      |   2 +-
 tests/qapi-schema/reserved-enum-q.err         |   2 +-
 tests/qapi-schema/reserved-member-has.err     |   2 +-
 tests/qapi-schema/reserved-member-q.err       |   2 +-
 tests/qapi-schema/reserved-member-u.err       |   2 +-
 .../reserved-member-underscore.err            |   2 +-
 tests/qapi-schema/reserved-type-kind.err      |   2 +-
 tests/qapi-schema/reserved-type-list.err      |   2 +-
 tests/qapi-schema/returns-array-bad.err       |   2 +-
 tests/qapi-schema/returns-dict.err            |   2 +-
 tests/qapi-schema/struct-data-invalid.err     |   2 +-
 .../struct-member-invalid-dict.err            |   2 +-
 tests/qapi-schema/struct-member-invalid.err   |   2 +-
 .../union-base-no-discriminator.err           |   2 +-
 tests/qapi-schema/union-branch-case.err       |   2 +-
 .../qapi-schema/union-branch-invalid-dict.err |   2 +-
 tests/qapi-schema/union-optional-branch.err   |   2 +-
 tests/qapi-schema/unknown-expr-key.err        |   2 +-
 51 files changed, 92 insertions(+), 121 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 297b82db4c..3e9c5ae127 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -694,8 +694,8 @@ def check_name_str(name, info, source,
 def check_defn_name_str(name, info, meta):
     check_name_str(name, info, meta, permit_upper=3DTrue)
     if name.endswith('Kind') or name.endswith('List'):
-        raise QAPISemError(info, "%s '%s' should not end in '%s'"
-                           % (meta, name, name[-4:]))
+        raise QAPISemError(info, "%s name should not end in '%s'"
+                           % (meta, name[-4:]))
=20
=20
 def check_if(expr, info):
@@ -752,42 +752,34 @@ def check_type(value, info, source,
=20
     # value is a dictionary, check that each member is okay
     for (key, arg) in value.items():
-        check_name_str(key, info, "member of %s" % source,
+        key_source =3D "%s member '%s'" % (source, key)
+        check_name_str(key, info, key_source,
                        allow_optional=3DTrue, permit_upper=3Dpermit_uppe=
r)
         if c_name(key, False) =3D=3D 'u' or c_name(key, False).startswit=
h('has_'):
-            raise QAPISemError(
-                info, "member of %s uses reserved name '%s'" % (source, =
key))
-        check_known_keys(arg, info, "member '%s' of %s" % (key, source),
-                         ['type'], ['if'])
+            raise QAPISemError(info, "%s uses reserved name" % key_sourc=
e)
+        check_known_keys(arg, info, key_source, ['type'], ['if'])
         check_if(arg, info)
         normalize_if(arg)
-        check_type(arg['type'], info, "member '%s' of %s" % (key, source=
),
-                   allow_array=3DTrue)
+        check_type(arg['type'], info, key_source, allow_array=3DTrue)
=20
=20
 def check_command(expr, info):
-    name =3D expr['command']
     args =3D expr.get('data')
     boxed =3D expr.get('boxed', False)
=20
     if boxed and args is None:
         raise QAPISemError(info, "'boxed': true requires 'data'")
-    check_type(args, info, "'data' for command '%s'" % name,
-               allow_dict=3Dnot boxed)
-    check_type(expr.get('returns'), info,
-               "'returns' for command '%s'" % name,
-               allow_array=3DTrue)
+    check_type(expr.get('data'), info, "'data'", allow_dict=3Dnot boxed)
+    check_type(expr.get('returns'), info, "'returns'", allow_array=3DTru=
e)
=20
=20
 def check_event(expr, info):
-    name =3D expr['event']
     args =3D expr.get('data')
     boxed =3D expr.get('boxed', False)
=20
     if boxed and args is None:
         raise QAPISemError(info, "'boxed': true requires 'data'")
-    check_type(args, info, "'data' for event '%s'" % name,
-               allow_dict=3Dnot boxed)
+    check_type(expr.get('data'), info, "'data'", allow_dict=3Dnot boxed)
=20
=20
 def check_union(expr, info):
@@ -798,45 +790,34 @@ def check_union(expr, info):
=20
     if discriminator is None:   # simple union
         if base is not None:
-            raise QAPISemError(
-                info, "simple union '%s' must not have a base" % name)
+            raise QAPISemError(info, "'base' requires 'discriminator'")
     else:                       # flat union
-        check_type(base, info, "'base' for union '%s'" % name,
-                   allow_dict=3Dname)
+        check_type(base, info, "'base'", allow_dict=3Dname)
         if not base:
-            raise QAPISemError(info, "flat union '%s' must have a base"
-                               % name)
-        check_name_is_str(discriminator, info,
-                          "discriminator of flat union '%s'" % name)
+            raise QAPISemError(info, "'discriminator' requires 'base'")
+        check_name_is_str(discriminator, info, "'discriminator'")
=20
     for (key, value) in members.items():
-        check_name_str(key, info, "member of union '%s'" % name)
-        check_known_keys(value, info,
-                         "member '%s' of union '%s'" % (key, name),
-                         ['type'], ['if'])
+        source =3D "'data' member '%s'" % key
+        check_name_str(key, info, source)
+        check_known_keys(value, info, source, ['type'], ['if'])
         check_if(value, info)
         normalize_if(value)
-        check_type(value['type'], info,
-                   "member '%s' of union '%s'" % (key, name),
-                   allow_array=3Dnot base)
+        check_type(value['type'], info, source, allow_array=3Dnot base)
=20
=20
 def check_alternate(expr, info):
-    name =3D expr['alternate']
     members =3D expr['data']
=20
     if len(members) =3D=3D 0:
-        raise QAPISemError(info,
-                           "alternate '%s' cannot have empty 'data'" % n=
ame)
+        raise QAPISemError(info, "'data' must not be empty")
     for (key, value) in members.items():
-        check_name_str(key, info, "member of alternate '%s'" % name)
-        check_known_keys(value, info,
-                         "member '%s' of alternate '%s'" % (key, name),
-                         ['type'], ['if'])
+        source =3D "'data' member '%s'" % key
+        check_name_str(key, info, source)
+        check_known_keys(value, info, source, ['type'], ['if'])
         check_if(value, info)
         normalize_if(value)
-        check_type(value['type'], info,
-                   "member '%s' of alternate '%s'" % (key, name))
+        check_type(value['type'], info, source)
=20
=20
 def check_enum(expr, info):
@@ -845,20 +826,18 @@ def check_enum(expr, info):
     prefix =3D expr.get('prefix')
=20
     if not isinstance(members, list):
-        raise QAPISemError(info,
-                           "enum '%s' requires an array for 'data'" % na=
me)
+        raise QAPISemError(info, "'data' must be an array")
     if prefix is not None and not isinstance(prefix, str):
-        raise QAPISemError(info,
-                           "enum '%s' requires a string for 'prefix'" % =
name)
+        raise QAPISemError(info, "'prefix' must be a string")
=20
     permit_upper =3D name in name_case_whitelist
=20
     for member in members:
-        check_known_keys(member, info, "member of enum '%s'" % name,
-                         ['name'], ['if'])
+        source =3D "'data' member"
+        check_known_keys(member, info, source, ['name'], ['if'])
         check_if(member, info)
         normalize_if(member)
-        check_name(member['name'], info, "member of enum '%s'" % name,
+        check_name(member['name'], info, source,
                    enum_member=3DTrue, permit_upper=3Dpermit_upper)
=20
=20
@@ -867,22 +846,19 @@ def check_struct(expr, info):
     members =3D expr['data']
     features =3D expr.get('features')
=20
-    check_type(members, info, "'data' for struct '%s'" % name,
-               allow_dict=3Dname)
-    check_type(expr.get('base'), info, "'base' for struct '%s'" % name)
+    check_type(members, info, "'data'", allow_dict=3Dname)
+    check_type(expr.get('base'), info, "'base'")
=20
     if features:
         if not isinstance(features, list):
-            raise QAPISemError(
-                info, "struct '%s' requires an array for 'features'" % n=
ame)
+            raise QAPISemError(info, "'features' must be an array")
         for f in features:
+            source =3D "'features' member"
             assert isinstance(f, dict)
-            check_known_keys(f, info, "feature of struct %s" % name,
-                             ['name'], ['if'])
-
+            check_known_keys(f, info, source, ['name'], ['if'])
             check_if(f, info)
             normalize_if(f)
-            check_name(f['name'], info, "feature of struct %s" % name)
+            check_name(f['name'], info, source)
=20
=20
 def check_known_keys(value, info, source, required, optional):
@@ -892,22 +868,19 @@ def check_known_keys(value, info, source, required,=
 optional):
=20
     missing =3D set(required) - set(value)
     if missing:
-        raise QAPISemError(info, "key%s %s %s missing from %s"
-                           % ('s' if len(missing) > 1 else '', pprint(mi=
ssing),
-                              'are' if len(missing) > 1 else 'is', sourc=
e))
+        raise QAPISemError(info, "%s misses key%s %s"
+                           % (source, 's' if len(missing) > 1 else '',
+                              pprint(missing)))
     allowed =3D set(required + optional)
     unknown =3D set(value) - allowed
     if unknown:
-        raise QAPISemError(info, "unknown key%s %s in %s\nValid keys are=
 %s."
-                           % ('s' if len(unknown) > 1 else '', pprint(un=
known),
-                              source, pprint(allowed)))
+        raise QAPISemError(info, "%s has unknown key%s %s\nValid keys ar=
e %s."
+                           % (source, 's' if len(unknown) > 1 else '',
+                              pprint(unknown), pprint(allowed)))
=20
=20
 def check_keys(expr, info, meta, required, optional=3D[]):
-    name =3D expr[meta]
-    required =3D required + [meta]
-    source =3D "%s '%s'" % (meta, name)
-    check_known_keys(expr, info, source, required, optional)
+    check_known_keys(expr, info, meta, required + [meta], optional)
=20
=20
 def check_flags(expr, info):
@@ -982,9 +955,7 @@ def check_exprs(exprs):
=20
         if doc and doc.symbol !=3D name:
             raise QAPISemError(
-                info,
-                "definition of '%s' follows documentation for '%s'"
-                % (name, doc.symbol))
+                info, "documentation comment is for '%s'" % doc.symbol)
=20
         if meta =3D=3D 'enum':
             check_keys(expr, info, 'enum', ['data'], ['if', 'prefix'])
diff --git a/tests/qapi-schema/alternate-array.err b/tests/qapi-schema/al=
ternate-array.err
index a72e4b274d..dfbe3ee998 100644
--- a/tests/qapi-schema/alternate-array.err
+++ b/tests/qapi-schema/alternate-array.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/alternate-array.json: In alternate 'Alt':
-tests/qapi-schema/alternate-array.json:5: member 'two' of alternate 'Alt=
' cannot be an array
+tests/qapi-schema/alternate-array.json:5: 'data' member 'two' cannot be =
an array
diff --git a/tests/qapi-schema/alternate-base.err b/tests/qapi-schema/alt=
ernate-base.err
index 6290665ac2..04cea97e5c 100644
--- a/tests/qapi-schema/alternate-base.err
+++ b/tests/qapi-schema/alternate-base.err
@@ -1,3 +1,3 @@
 tests/qapi-schema/alternate-base.json: In alternate 'Alt':
-tests/qapi-schema/alternate-base.json:4: unknown key 'base' in alternate=
 'Alt'
+tests/qapi-schema/alternate-base.json:4: alternate has unknown key 'base=
'
 Valid keys are 'alternate', 'data', 'if'.
diff --git a/tests/qapi-schema/alternate-empty.err b/tests/qapi-schema/al=
ternate-empty.err
index db92d70f10..908c309518 100644
--- a/tests/qapi-schema/alternate-empty.err
+++ b/tests/qapi-schema/alternate-empty.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/alternate-empty.json: In alternate 'Alt':
-tests/qapi-schema/alternate-empty.json:2: alternate 'Alt' cannot have em=
pty 'data'
+tests/qapi-schema/alternate-empty.json:2: 'data' must not be empty
diff --git a/tests/qapi-schema/alternate-invalid-dict.err b/tests/qapi-sc=
hema/alternate-invalid-dict.err
index f85b941750..d6a18a294b 100644
--- a/tests/qapi-schema/alternate-invalid-dict.err
+++ b/tests/qapi-schema/alternate-invalid-dict.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/alternate-invalid-dict.json: In alternate 'Alt':
-tests/qapi-schema/alternate-invalid-dict.json:2: key 'type' is missing f=
rom member 'two' of alternate 'Alt'
+tests/qapi-schema/alternate-invalid-dict.json:2: 'data' member 'two' mis=
ses key 'type'
diff --git a/tests/qapi-schema/args-array-empty.err b/tests/qapi-schema/a=
rgs-array-empty.err
index fe1480671b..c7d367730e 100644
--- a/tests/qapi-schema/args-array-empty.err
+++ b/tests/qapi-schema/args-array-empty.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/args-array-empty.json: In command 'oops':
-tests/qapi-schema/args-array-empty.json:2: member 'empty' of 'data' for =
command 'oops': array type must contain single type name
+tests/qapi-schema/args-array-empty.json:2: 'data' member 'empty': array =
type must contain single type name
diff --git a/tests/qapi-schema/args-boxed-anon.err b/tests/qapi-schema/ar=
gs-boxed-anon.err
index 27460e6c07..5e0c2979b7 100644
--- a/tests/qapi-schema/args-boxed-anon.err
+++ b/tests/qapi-schema/args-boxed-anon.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/args-boxed-anon.json: In command 'foo':
-tests/qapi-schema/args-boxed-anon.json:2: 'data' for command 'foo' shoul=
d be a type name
+tests/qapi-schema/args-boxed-anon.json:2: 'data' should be a type name
diff --git a/tests/qapi-schema/args-invalid.err b/tests/qapi-schema/args-=
invalid.err
index 212c2076fc..c4971e1399 100644
--- a/tests/qapi-schema/args-invalid.err
+++ b/tests/qapi-schema/args-invalid.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/args-invalid.json: In command 'foo':
-tests/qapi-schema/args-invalid.json:1: 'data' for command 'foo' should b=
e an object or type name
+tests/qapi-schema/args-invalid.json:1: 'data' should be an object or typ=
e name
diff --git a/tests/qapi-schema/args-member-array-bad.err b/tests/qapi-sch=
ema/args-member-array-bad.err
index 89b8b1ce01..f95ac01372 100644
--- a/tests/qapi-schema/args-member-array-bad.err
+++ b/tests/qapi-schema/args-member-array-bad.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/args-member-array-bad.json: In command 'oops':
-tests/qapi-schema/args-member-array-bad.json:2: member 'member' of 'data=
' for command 'oops': array type must contain single type name
+tests/qapi-schema/args-member-array-bad.json:2: 'data' member 'member': =
array type must contain single type name
diff --git a/tests/qapi-schema/args-member-case.err b/tests/qapi-schema/a=
rgs-member-case.err
index faa8168d36..7f10c829de 100644
--- a/tests/qapi-schema/args-member-case.err
+++ b/tests/qapi-schema/args-member-case.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/args-member-case.json: In command 'no-way-this-will-ge=
t-whitelisted':
-tests/qapi-schema/args-member-case.json:2: member of 'data' for command =
'no-way-this-will-get-whitelisted' uses uppercase in name 'Arg'
+tests/qapi-schema/args-member-case.json:2: 'data' member 'Arg' uses uppe=
rcase in name 'Arg'
diff --git a/tests/qapi-schema/bad-data.err b/tests/qapi-schema/bad-data.=
err
index 8ef6bbd2b5..5227bdce7e 100644
--- a/tests/qapi-schema/bad-data.err
+++ b/tests/qapi-schema/bad-data.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/bad-data.json: In command 'oops':
-tests/qapi-schema/bad-data.json:2: 'data' for command 'oops' cannot be a=
n array
+tests/qapi-schema/bad-data.json:2: 'data' cannot be an array
diff --git a/tests/qapi-schema/doc-bad-symbol.err b/tests/qapi-schema/doc=
-bad-symbol.err
index 205d0ed619..b23e99d160 100644
--- a/tests/qapi-schema/doc-bad-symbol.err
+++ b/tests/qapi-schema/doc-bad-symbol.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/doc-bad-symbol.json: In command 'foo':
-tests/qapi-schema/doc-bad-symbol.json:6: definition of 'foo' follows doc=
umentation for 'food'
+tests/qapi-schema/doc-bad-symbol.json:6: documentation comment is for 'f=
ood'
diff --git a/tests/qapi-schema/double-type.err b/tests/qapi-schema/double=
-type.err
index ddb22af638..23f88aae99 100644
--- a/tests/qapi-schema/double-type.err
+++ b/tests/qapi-schema/double-type.err
@@ -1,3 +1,3 @@
 tests/qapi-schema/double-type.json: In struct 'bar':
-tests/qapi-schema/double-type.json:2: unknown key 'command' in struct 'b=
ar'
+tests/qapi-schema/double-type.json:2: struct has unknown key 'command'
 Valid keys are 'base', 'data', 'features', 'if', 'struct'.
diff --git a/tests/qapi-schema/enum-bad-member.err b/tests/qapi-schema/en=
um-bad-member.err
index 1e59d42fca..2b1b4f98d0 100644
--- a/tests/qapi-schema/enum-bad-member.err
+++ b/tests/qapi-schema/enum-bad-member.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/enum-bad-member.json: In enum 'MyEnum':
-tests/qapi-schema/enum-bad-member.json:2: member of enum 'MyEnum' requir=
es a string name
+tests/qapi-schema/enum-bad-member.json:2: 'data' member requires a strin=
g name
diff --git a/tests/qapi-schema/enum-bad-name.err b/tests/qapi-schema/enum=
-bad-name.err
index ed2d608098..c4525411cf 100644
--- a/tests/qapi-schema/enum-bad-name.err
+++ b/tests/qapi-schema/enum-bad-name.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/enum-bad-name.json: In enum 'MyEnum':
-tests/qapi-schema/enum-bad-name.json:3: member of enum 'MyEnum' uses inv=
alid name 'not\possible'
+tests/qapi-schema/enum-bad-name.json:3: 'data' member uses invalid name =
'not\possible'
diff --git a/tests/qapi-schema/enum-bad-prefix.err b/tests/qapi-schema/en=
um-bad-prefix.err
index 4f92736e52..933e33aa18 100644
--- a/tests/qapi-schema/enum-bad-prefix.err
+++ b/tests/qapi-schema/enum-bad-prefix.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/enum-bad-prefix.json: In enum 'MyEnum':
-tests/qapi-schema/enum-bad-prefix.json:2: enum 'MyEnum' requires a strin=
g for 'prefix'
+tests/qapi-schema/enum-bad-prefix.json:2: 'prefix' must be a string
diff --git a/tests/qapi-schema/enum-dict-member-unknown.err b/tests/qapi-=
schema/enum-dict-member-unknown.err
index 79062729a1..5df0236343 100644
--- a/tests/qapi-schema/enum-dict-member-unknown.err
+++ b/tests/qapi-schema/enum-dict-member-unknown.err
@@ -1,3 +1,3 @@
 tests/qapi-schema/enum-dict-member-unknown.json: In enum 'MyEnum':
-tests/qapi-schema/enum-dict-member-unknown.json:2: unknown key 'bad-key'=
 in member of enum 'MyEnum'
+tests/qapi-schema/enum-dict-member-unknown.json:2: 'data' member has unk=
nown key 'bad-key'
 Valid keys are 'if', 'name'.
diff --git a/tests/qapi-schema/enum-member-case.err b/tests/qapi-schema/e=
num-member-case.err
index c3c6f8d709..b327c41528 100644
--- a/tests/qapi-schema/enum-member-case.err
+++ b/tests/qapi-schema/enum-member-case.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/enum-member-case.json: In enum 'NoWayThisWillGetWhitel=
isted':
-tests/qapi-schema/enum-member-case.json:4: member of enum 'NoWayThisWill=
GetWhitelisted' uses uppercase in name 'Value'
+tests/qapi-schema/enum-member-case.json:4: 'data' member uses uppercase =
in name 'Value'
diff --git a/tests/qapi-schema/enum-missing-data.err b/tests/qapi-schema/=
enum-missing-data.err
index ffde1082c3..4809b01f34 100644
--- a/tests/qapi-schema/enum-missing-data.err
+++ b/tests/qapi-schema/enum-missing-data.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/enum-missing-data.json: In enum 'MyEnum':
-tests/qapi-schema/enum-missing-data.json:2: key 'data' is missing from e=
num 'MyEnum'
+tests/qapi-schema/enum-missing-data.json:2: enum misses key 'data'
diff --git a/tests/qapi-schema/enum-wrong-data.err b/tests/qapi-schema/en=
um-wrong-data.err
index ab9af5e995..ad5f0ce46f 100644
--- a/tests/qapi-schema/enum-wrong-data.err
+++ b/tests/qapi-schema/enum-wrong-data.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/enum-wrong-data.json: In enum 'MyEnum':
-tests/qapi-schema/enum-wrong-data.json:2: enum 'MyEnum' requires an arra=
y for 'data'
+tests/qapi-schema/enum-wrong-data.json:2: 'data' must be an array
diff --git a/tests/qapi-schema/event-member-invalid-dict.err b/tests/qapi=
-schema/event-member-invalid-dict.err
index 8bf89b7a3a..8406c43df7 100644
--- a/tests/qapi-schema/event-member-invalid-dict.err
+++ b/tests/qapi-schema/event-member-invalid-dict.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/event-member-invalid-dict.json: In event 'EVENT_A':
-tests/qapi-schema/event-member-invalid-dict.json:1: key 'type' is missin=
g from member 'a' of 'data' for event 'EVENT_A'
+tests/qapi-schema/event-member-invalid-dict.json:1: 'data' member 'a' mi=
sses key 'type'
diff --git a/tests/qapi-schema/event-nest-struct.err b/tests/qapi-schema/=
event-nest-struct.err
index 8900052e83..1a3254a73c 100644
--- a/tests/qapi-schema/event-nest-struct.err
+++ b/tests/qapi-schema/event-nest-struct.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/event-nest-struct.json: In event 'EVENT_A':
-tests/qapi-schema/event-nest-struct.json:1: member 'a' of 'data' for eve=
nt 'EVENT_A' should be a type name
+tests/qapi-schema/event-nest-struct.json:1: 'data' member 'a' should be =
a type name
diff --git a/tests/qapi-schema/features-bad-type.err b/tests/qapi-schema/=
features-bad-type.err
index 2182c3ec75..30deb8b624 100644
--- a/tests/qapi-schema/features-bad-type.err
+++ b/tests/qapi-schema/features-bad-type.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/features-bad-type.json: In struct 'FeatureStruct0':
-tests/qapi-schema/features-bad-type.json:1: feature of struct FeatureStr=
uct0 requires a string name
+tests/qapi-schema/features-bad-type.json:1: 'features' member requires a=
 string name
diff --git a/tests/qapi-schema/features-missing-name.err b/tests/qapi-sch=
ema/features-missing-name.err
index 8cbf1ef3f0..b8db328acc 100644
--- a/tests/qapi-schema/features-missing-name.err
+++ b/tests/qapi-schema/features-missing-name.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/features-missing-name.json: In struct 'FeatureStruct0'=
:
-tests/qapi-schema/features-missing-name.json:1: key 'name' is missing fr=
om feature of struct FeatureStruct0
+tests/qapi-schema/features-missing-name.json:1: 'features' member misses=
 key 'name'
diff --git a/tests/qapi-schema/features-name-bad-type.err b/tests/qapi-sc=
hema/features-name-bad-type.err
index 19a7b61214..86db2c0ea2 100644
--- a/tests/qapi-schema/features-name-bad-type.err
+++ b/tests/qapi-schema/features-name-bad-type.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/features-name-bad-type.json: In struct 'FeatureStruct0=
':
-tests/qapi-schema/features-name-bad-type.json:1: feature of struct Featu=
reStruct0 requires a string name
+tests/qapi-schema/features-name-bad-type.json:1: 'features' member requi=
res a string name
diff --git a/tests/qapi-schema/features-no-list.err b/tests/qapi-schema/f=
eatures-no-list.err
index 28f91824bd..e493f85057 100644
--- a/tests/qapi-schema/features-no-list.err
+++ b/tests/qapi-schema/features-no-list.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/features-no-list.json: In struct 'FeatureStruct0':
-tests/qapi-schema/features-no-list.json:1: struct 'FeatureStruct0' requi=
res an array for 'features'
+tests/qapi-schema/features-no-list.json:1: 'features' must be an array
diff --git a/tests/qapi-schema/features-unknown-key.err b/tests/qapi-sche=
ma/features-unknown-key.err
index 78e63c8cf7..22f5dcf4b0 100644
--- a/tests/qapi-schema/features-unknown-key.err
+++ b/tests/qapi-schema/features-unknown-key.err
@@ -1,3 +1,3 @@
 tests/qapi-schema/features-unknown-key.json: In struct 'FeatureStruct0':
-tests/qapi-schema/features-unknown-key.json:1: unknown key 'colour' in f=
eature of struct FeatureStruct0
+tests/qapi-schema/features-unknown-key.json:1: 'features' member has unk=
nown key 'colour'
 Valid keys are 'if', 'name'.
diff --git a/tests/qapi-schema/flat-union-array-branch.err b/tests/qapi-s=
chema/flat-union-array-branch.err
index 323d79737c..de07a7b32a 100644
--- a/tests/qapi-schema/flat-union-array-branch.err
+++ b/tests/qapi-schema/flat-union-array-branch.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/flat-union-array-branch.json: In union 'TestUnion':
-tests/qapi-schema/flat-union-array-branch.json:8: member 'value1' of uni=
on 'TestUnion' cannot be an array
+tests/qapi-schema/flat-union-array-branch.json:8: 'data' member 'value1'=
 cannot be an array
diff --git a/tests/qapi-schema/flat-union-bad-discriminator.err b/tests/q=
api-schema/flat-union-bad-discriminator.err
index 27a6c9f3fb..c1b4209ffd 100644
--- a/tests/qapi-schema/flat-union-bad-discriminator.err
+++ b/tests/qapi-schema/flat-union-bad-discriminator.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/flat-union-bad-discriminator.json: In union 'TestUnion=
':
-tests/qapi-schema/flat-union-bad-discriminator.json:11: discriminator of=
 flat union 'TestUnion' requires a string name
+tests/qapi-schema/flat-union-bad-discriminator.json:11: 'discriminator' =
requires a string name
diff --git a/tests/qapi-schema/flat-union-inline-invalid-dict.err b/tests=
/qapi-schema/flat-union-inline-invalid-dict.err
index 85739c2733..d353bdd338 100644
--- a/tests/qapi-schema/flat-union-inline-invalid-dict.err
+++ b/tests/qapi-schema/flat-union-inline-invalid-dict.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/flat-union-inline-invalid-dict.json: In union 'TestUni=
on':
-tests/qapi-schema/flat-union-inline-invalid-dict.json:7: key 'type' is m=
issing from member 'value1' of union 'TestUnion'
+tests/qapi-schema/flat-union-inline-invalid-dict.json:7: 'data' member '=
value1' misses key 'type'
diff --git a/tests/qapi-schema/flat-union-inline.err b/tests/qapi-schema/=
flat-union-inline.err
index 33a8d6e3bd..95b1e8c1b7 100644
--- a/tests/qapi-schema/flat-union-inline.err
+++ b/tests/qapi-schema/flat-union-inline.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/flat-union-inline.json: In union 'TestUnion':
-tests/qapi-schema/flat-union-inline.json:7: member 'value1' of union 'Te=
stUnion' should be a type name
+tests/qapi-schema/flat-union-inline.json:7: 'data' member 'value1' shoul=
d be a type name
diff --git a/tests/qapi-schema/flat-union-no-base.err b/tests/qapi-schema=
/flat-union-no-base.err
index c845259824..a16f3231f1 100644
--- a/tests/qapi-schema/flat-union-no-base.err
+++ b/tests/qapi-schema/flat-union-no-base.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/flat-union-no-base.json: In union 'TestUnion':
-tests/qapi-schema/flat-union-no-base.json:9: flat union 'TestUnion' must=
 have a base
+tests/qapi-schema/flat-union-no-base.json:9: 'discriminator' requires 'b=
ase'
diff --git a/tests/qapi-schema/nested-struct-data-invalid-dict.err b/test=
s/qapi-schema/nested-struct-data-invalid-dict.err
index f2c7a8096c..ed42d6323e 100644
--- a/tests/qapi-schema/nested-struct-data-invalid-dict.err
+++ b/tests/qapi-schema/nested-struct-data-invalid-dict.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/nested-struct-data-invalid-dict.json: In command 'foo'=
:
-tests/qapi-schema/nested-struct-data-invalid-dict.json:2: key 'type' is =
missing from member 'a' of 'data' for command 'foo'
+tests/qapi-schema/nested-struct-data-invalid-dict.json:2: 'data' member =
'a' misses key 'type'
diff --git a/tests/qapi-schema/nested-struct-data.err b/tests/qapi-schema=
/nested-struct-data.err
index b5e136674c..b0ec410eb7 100644
--- a/tests/qapi-schema/nested-struct-data.err
+++ b/tests/qapi-schema/nested-struct-data.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/nested-struct-data.json: In command 'foo':
-tests/qapi-schema/nested-struct-data.json:2: member 'a' of 'data' for co=
mmand 'foo' should be a type name
+tests/qapi-schema/nested-struct-data.json:2: 'data' member 'a' should be=
 a type name
diff --git a/tests/qapi-schema/reserved-enum-q.err b/tests/qapi-schema/re=
served-enum-q.err
index d9c0af5a05..32618a955c 100644
--- a/tests/qapi-schema/reserved-enum-q.err
+++ b/tests/qapi-schema/reserved-enum-q.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/reserved-enum-q.json: In enum 'Foo':
-tests/qapi-schema/reserved-enum-q.json:4: member of enum 'Foo' uses inva=
lid name 'q-Unix'
+tests/qapi-schema/reserved-enum-q.json:4: 'data' member uses invalid nam=
e 'q-Unix'
diff --git a/tests/qapi-schema/reserved-member-has.err b/tests/qapi-schem=
a/reserved-member-has.err
index 6f405ec2a9..c7ad721ad1 100644
--- a/tests/qapi-schema/reserved-member-has.err
+++ b/tests/qapi-schema/reserved-member-has.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/reserved-member-has.json: In command 'oops':
-tests/qapi-schema/reserved-member-has.json:5: member of 'data' for comma=
nd 'oops' uses reserved name 'has-a'
+tests/qapi-schema/reserved-member-has.json:5: 'data' member 'has-a' uses=
 reserved name
diff --git a/tests/qapi-schema/reserved-member-q.err b/tests/qapi-schema/=
reserved-member-q.err
index ece2664005..a65f38e0ce 100644
--- a/tests/qapi-schema/reserved-member-q.err
+++ b/tests/qapi-schema/reserved-member-q.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/reserved-member-q.json: In struct 'Foo':
-tests/qapi-schema/reserved-member-q.json:4: member of 'data' for struct =
'Foo' uses invalid name 'q-unix'
+tests/qapi-schema/reserved-member-q.json:4: 'data' member 'q-unix' uses =
invalid name 'q-unix'
diff --git a/tests/qapi-schema/reserved-member-u.err b/tests/qapi-schema/=
reserved-member-u.err
index e812a1e404..2e92c11ba5 100644
--- a/tests/qapi-schema/reserved-member-u.err
+++ b/tests/qapi-schema/reserved-member-u.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/reserved-member-u.json: In struct 'Oops':
-tests/qapi-schema/reserved-member-u.json:7: member of 'data' for struct =
'Oops' uses reserved name 'u'
+tests/qapi-schema/reserved-member-u.json:7: 'data' member 'u' uses reser=
ved name
diff --git a/tests/qapi-schema/reserved-member-underscore.err b/tests/qap=
i-schema/reserved-member-underscore.err
index e1d54f0a27..476a57ba1e 100644
--- a/tests/qapi-schema/reserved-member-underscore.err
+++ b/tests/qapi-schema/reserved-member-underscore.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/reserved-member-underscore.json: In struct 'Oops':
-tests/qapi-schema/reserved-member-underscore.json:4: member of 'data' fo=
r struct 'Oops' uses invalid name '_oops'
+tests/qapi-schema/reserved-member-underscore.json:4: 'data' member '_oop=
s' uses invalid name '_oops'
diff --git a/tests/qapi-schema/reserved-type-kind.err b/tests/qapi-schema=
/reserved-type-kind.err
index 8d21479000..f8112cf92e 100644
--- a/tests/qapi-schema/reserved-type-kind.err
+++ b/tests/qapi-schema/reserved-type-kind.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/reserved-type-kind.json: In enum 'UnionKind':
-tests/qapi-schema/reserved-type-kind.json:2: enum 'UnionKind' should not=
 end in 'Kind'
+tests/qapi-schema/reserved-type-kind.json:2: enum name should not end in=
 'Kind'
diff --git a/tests/qapi-schema/reserved-type-list.err b/tests/qapi-schema=
/reserved-type-list.err
index 2bdd7d8a06..c6eee0585c 100644
--- a/tests/qapi-schema/reserved-type-list.err
+++ b/tests/qapi-schema/reserved-type-list.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/reserved-type-list.json: In struct 'FooList':
-tests/qapi-schema/reserved-type-list.json:5: struct 'FooList' should not=
 end in 'List'
+tests/qapi-schema/reserved-type-list.json:5: struct name should not end =
in 'List'
diff --git a/tests/qapi-schema/returns-array-bad.err b/tests/qapi-schema/=
returns-array-bad.err
index 6295ba89c0..1b86777d8f 100644
--- a/tests/qapi-schema/returns-array-bad.err
+++ b/tests/qapi-schema/returns-array-bad.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/returns-array-bad.json: In command 'oops':
-tests/qapi-schema/returns-array-bad.json:2: 'returns' for command 'oops'=
: array type must contain single type name
+tests/qapi-schema/returns-array-bad.json:2: 'returns': array type must c=
ontain single type name
diff --git a/tests/qapi-schema/returns-dict.err b/tests/qapi-schema/retur=
ns-dict.err
index 7329b9526f..52e4f3ad71 100644
--- a/tests/qapi-schema/returns-dict.err
+++ b/tests/qapi-schema/returns-dict.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/returns-dict.json: In command 'oops':
-tests/qapi-schema/returns-dict.json:2: 'returns' for command 'oops' shou=
ld be a type name
+tests/qapi-schema/returns-dict.json:2: 'returns' should be a type name
diff --git a/tests/qapi-schema/struct-data-invalid.err b/tests/qapi-schem=
a/struct-data-invalid.err
index a88754869f..aa868bf974 100644
--- a/tests/qapi-schema/struct-data-invalid.err
+++ b/tests/qapi-schema/struct-data-invalid.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/struct-data-invalid.json: In struct 'foo':
-tests/qapi-schema/struct-data-invalid.json:1: 'data' for struct 'foo' sh=
ould be an object or type name
+tests/qapi-schema/struct-data-invalid.json:1: 'data' should be an object=
 or type name
diff --git a/tests/qapi-schema/struct-member-invalid-dict.err b/tests/qap=
i-schema/struct-member-invalid-dict.err
index 0c770bb1e8..46ec991c28 100644
--- a/tests/qapi-schema/struct-member-invalid-dict.err
+++ b/tests/qapi-schema/struct-member-invalid-dict.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/struct-member-invalid-dict.json: In struct 'foo':
-tests/qapi-schema/struct-member-invalid-dict.json:2: key 'type' is missi=
ng from member '*a' of 'data' for struct 'foo'
+tests/qapi-schema/struct-member-invalid-dict.json:2: 'data' member '*a' =
misses key 'type'
diff --git a/tests/qapi-schema/struct-member-invalid.err b/tests/qapi-sch=
ema/struct-member-invalid.err
index e5a19fc8af..92d4973832 100644
--- a/tests/qapi-schema/struct-member-invalid.err
+++ b/tests/qapi-schema/struct-member-invalid.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/struct-member-invalid.json: In struct 'foo':
-tests/qapi-schema/struct-member-invalid.json:1: member 'a' of 'data' for=
 struct 'foo' should be a type name
+tests/qapi-schema/struct-member-invalid.json:1: 'data' member 'a' should=
 be a type name
diff --git a/tests/qapi-schema/union-base-no-discriminator.err b/tests/qa=
pi-schema/union-base-no-discriminator.err
index 883a98866b..f4c16a2c14 100644
--- a/tests/qapi-schema/union-base-no-discriminator.err
+++ b/tests/qapi-schema/union-base-no-discriminator.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/union-base-no-discriminator.json: In union 'TestUnion'=
:
-tests/qapi-schema/union-base-no-discriminator.json:11: simple union 'Tes=
tUnion' must not have a base
+tests/qapi-schema/union-base-no-discriminator.json:11: 'base' requires '=
discriminator'
diff --git a/tests/qapi-schema/union-branch-case.err b/tests/qapi-schema/=
union-branch-case.err
index f111210281..cf55c085ec 100644
--- a/tests/qapi-schema/union-branch-case.err
+++ b/tests/qapi-schema/union-branch-case.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/union-branch-case.json: In union 'Uni':
-tests/qapi-schema/union-branch-case.json:2: member of union 'Uni' uses u=
ppercase in name 'Branch'
+tests/qapi-schema/union-branch-case.json:2: 'data' member 'Branch' uses =
uppercase in name 'Branch'
diff --git a/tests/qapi-schema/union-branch-invalid-dict.err b/tests/qapi=
-schema/union-branch-invalid-dict.err
index d11a739674..2967cd6260 100644
--- a/tests/qapi-schema/union-branch-invalid-dict.err
+++ b/tests/qapi-schema/union-branch-invalid-dict.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/union-branch-invalid-dict.json: In union 'UnionInvalid=
Branch':
-tests/qapi-schema/union-branch-invalid-dict.json:2: key 'type' is missin=
g from member 'integer' of union 'UnionInvalidBranch'
+tests/qapi-schema/union-branch-invalid-dict.json:2: 'data' member 'integ=
er' misses key 'type'
diff --git a/tests/qapi-schema/union-optional-branch.err b/tests/qapi-sch=
ema/union-optional-branch.err
index 8e9b18d7c6..779d3d4969 100644
--- a/tests/qapi-schema/union-optional-branch.err
+++ b/tests/qapi-schema/union-optional-branch.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/union-optional-branch.json: In union 'Union':
-tests/qapi-schema/union-optional-branch.json:2: member of union 'Union' =
uses invalid name '*a'
+tests/qapi-schema/union-optional-branch.json:2: 'data' member '*a' uses =
invalid name '*a'
diff --git a/tests/qapi-schema/unknown-expr-key.err b/tests/qapi-schema/u=
nknown-expr-key.err
index e401efe148..be9f99c4ef 100644
--- a/tests/qapi-schema/unknown-expr-key.err
+++ b/tests/qapi-schema/unknown-expr-key.err
@@ -1,3 +1,3 @@
 tests/qapi-schema/unknown-expr-key.json: In struct 'bar':
-tests/qapi-schema/unknown-expr-key.json:2: unknown keys 'bogus', 'phony'=
 in struct 'bar'
+tests/qapi-schema/unknown-expr-key.json:2: struct has unknown keys 'bogu=
s', 'phony'
 Valid keys are 'base', 'data', 'features', 'if', 'struct'.
--=20
2.21.0


