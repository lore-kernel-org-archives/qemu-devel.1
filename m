Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534B7C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:02:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26CF52064A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CF52064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iClOz-0006Cl-MI
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 10:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCks2-0000Fz-75
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCkrx-0001UT-Al
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35966)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCkrw-0001Sj-HT
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A982D300D1C8;
 Tue, 24 Sep 2019 13:28:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 29B4360852;
 Tue, 24 Sep 2019 13:28:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 75B5B113860E; Tue, 24 Sep 2019 15:28:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/25] qapi: Reorder check_FOO() parameters for consistency
Date: Tue, 24 Sep 2019 15:28:13 +0200
Message-Id: <20190924132830.15835-9-armbru@redhat.com>
In-Reply-To: <20190924132830.15835-1-armbru@redhat.com>
References: <20190924132830.15835-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 24 Sep 2019 13:28:38 +0000 (UTC)
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

Most check_FOO() take the thing being checked as first argument.
check_name(), check_type(), check_known_keys() don't.  Clean that up.

While there, drop a "Todo" comment that should have been dropped in
commit 87adbbffd4 "qapi: add a dictionary form for TYPE".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py | 80 ++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 41 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 749490c517..25818b0ea0 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -705,7 +705,7 @@ valid_name =3D re.compile(r'^(__[a-zA-Z0-9.-]+_)?'
                         '[a-zA-Z][a-zA-Z0-9_-]*$')
=20
=20
-def check_name(info, source, name,
+def check_name(name, info, source,
                allow_optional=3DFalse, enum_member=3DFalse, permit_upper=
=3DFalse):
     global valid_name
     membername =3D name
@@ -733,7 +733,7 @@ def check_name(info, source, name,
=20
 def add_name(name, info, meta):
     global all_names
-    check_name(info, "'%s'" % meta, name, permit_upper=3DTrue)
+    check_name(name, info, "'%s'" % meta, permit_upper=3DTrue)
     # FIXME should reject names that differ only in '_' vs. '.'
     # vs. '-', because they're liable to clash in generated C.
     if name in all_names:
@@ -767,7 +767,7 @@ def check_if(expr, info):
         check_if_str(ifcond, info)
=20
=20
-def check_type(info, source, value,
+def check_type(value, info, source,
                allow_array=3DFalse, allow_dict=3DFalse, allow_metas=3D[]=
):
     global all_names
=20
@@ -805,19 +805,17 @@ def check_type(info, source, value,
=20
     # value is a dictionary, check that each member is okay
     for (key, arg) in value.items():
-        check_name(info, "member of %s" % source, key,
+        check_name(key, info, "member of %s" % source,
                    allow_optional=3DTrue, permit_upper=3Dpermit_upper)
         if c_name(key, False) =3D=3D 'u' or c_name(key, False).startswit=
h('has_'):
             raise QAPISemError(
                 info, "member of %s uses reserved name '%s'" % (source, =
key))
-        # Todo: allow dictionaries to represent default values of
-        # an optional argument.
-        check_known_keys(info, "member '%s' of %s" % (key, source),
-                         arg, ['type'], ['if'])
+        check_known_keys(arg, info, "member '%s' of %s" % (key, source),
+                         ['type'], ['if'])
         check_if(arg, info)
         normalize_if(arg)
-        check_type(info, "member '%s' of %s" % (key, source),
-                   arg['type'], allow_array=3DTrue,
+        check_type(arg['type'], info, "member '%s' of %s" % (key, source=
),
+                   allow_array=3DTrue,
                    allow_metas=3D['built-in', 'union', 'alternate', 'str=
uct',
                                 'enum'])
=20
@@ -829,15 +827,15 @@ def check_command(expr, info):
     args_meta =3D ['struct']
     if boxed:
         args_meta +=3D ['union']
-    check_type(info, "'data' for command '%s'" % name,
-               expr.get('data'), allow_dict=3Dnot boxed,
-               allow_metas=3Dargs_meta)
+    check_type(expr.get('data'), info,
+               "'data' for command '%s'" % name,
+               allow_dict=3Dnot boxed, allow_metas=3Dargs_meta)
     returns_meta =3D ['union', 'struct']
     if name in returns_whitelist:
         returns_meta +=3D ['built-in', 'alternate', 'enum']
-    check_type(info, "'returns' for command '%s'" % name,
-               expr.get('returns'), allow_array=3DTrue,
-               allow_metas=3Dreturns_meta)
+    check_type(expr.get('returns'), info,
+               "'returns' for command '%s'" % name,
+               allow_array=3DTrue, allow_metas=3Dreturns_meta)
=20
=20
 def check_event(expr, info):
@@ -847,9 +845,9 @@ def check_event(expr, info):
     meta =3D ['struct']
     if boxed:
         meta +=3D ['union']
-    check_type(info, "'data' for event '%s'" % name,
-               expr.get('data'), allow_dict=3Dnot boxed,
-               allow_metas=3Dmeta)
+    check_type(expr.get('data'), info,
+               "'data' for event '%s'" % name,
+               allow_dict=3Dnot boxed, allow_metas=3Dmeta)
=20
=20
 def enum_get_names(expr):
@@ -875,9 +873,8 @@ def check_union(expr, info):
     # Else, it's a flat union.
     else:
         # The object must have a string or dictionary 'base'.
-        check_type(info, "'base' for union '%s'" % name,
-                   base, allow_dict=3Dname,
-                   allow_metas=3D['struct'])
+        check_type(base, info, "'base' for union '%s'" % name,
+                   allow_dict=3Dname, allow_metas=3D['struct'])
         if not base:
             raise QAPISemError(info, "flat union '%s' must have a base"
                                % name)
@@ -886,8 +883,8 @@ def check_union(expr, info):
=20
         # The value of member 'discriminator' must name a non-optional
         # member of the base struct.
-        check_name(info, "discriminator of flat union '%s'" % name,
-                   discriminator)
+        check_name(discriminator, info,
+                   "discriminator of flat union '%s'" % name)
         discriminator_value =3D base_members.get(discriminator)
         if not discriminator_value:
             raise QAPISemError(info,
@@ -912,15 +909,16 @@ def check_union(expr, info):
         raise QAPISemError(info, "union '%s' has no branches" % name)
=20
     for (key, value) in members.items():
-        check_name(info, "member of union '%s'" % name, key)
+        check_name(key, info, "member of union '%s'" % name)
=20
-        check_known_keys(info, "member '%s' of union '%s'" % (key, name)=
,
-                         value, ['type'], ['if'])
+        check_known_keys(value, info,
+                         "member '%s' of union '%s'" % (key, name),
+                         ['type'], ['if'])
         check_if(value, info)
         normalize_if(value)
         # Each value must name a known type
-        check_type(info, "member '%s' of union '%s'" % (key, name),
-                   value['type'],
+        check_type(value['type'], info,
+                   "member '%s' of union '%s'" % (key, name),
                    allow_array=3Dnot base, allow_metas=3Dallow_metas)
=20
         # If the discriminator names an enum type, then all members
@@ -942,16 +940,16 @@ def check_alternate(expr, info):
         raise QAPISemError(info,
                            "alternate '%s' cannot have empty 'data'" % n=
ame)
     for (key, value) in members.items():
-        check_name(info, "member of alternate '%s'" % name, key)
-        check_known_keys(info,
+        check_name(key, info, "member of alternate '%s'" % name)
+        check_known_keys(value, info,
                          "member '%s' of alternate '%s'" % (key, name),
-                         value, ['type'], ['if'])
+                         ['type'], ['if'])
         check_if(value, info)
         normalize_if(value)
         typ =3D value['type']
=20
         # Ensure alternates have no type conflicts.
-        check_type(info, "member '%s' of alternate '%s'" % (key, name), =
typ,
+        check_type(typ, info, "member '%s' of alternate '%s'" % (key, na=
me),
                    allow_metas=3D['built-in', 'union', 'struct', 'enum']=
)
         qtype =3D find_alternate_member_qtype(typ)
         if not qtype:
@@ -996,11 +994,11 @@ def check_enum(expr, info):
     permit_upper =3D name in name_case_whitelist
=20
     for member in members:
-        check_known_keys(info, "member of enum '%s'" % name, member,
+        check_known_keys(member, info, "member of enum '%s'" % name,
                          ['name'], ['if'])
         check_if(member, info)
         normalize_if(member)
-        check_name(info, "member of enum '%s'" % name, member['name'],
+        check_name(member['name'], info, "member of enum '%s'" % name,
                    enum_member=3DTrue, permit_upper=3Dpermit_upper)
=20
=20
@@ -1009,9 +1007,9 @@ def check_struct(expr, info):
     members =3D expr['data']
     features =3D expr.get('features')
=20
-    check_type(info, "'data' for struct '%s'" % name, members,
+    check_type(members, info, "'data' for struct '%s'" % name,
                allow_dict=3Dname)
-    check_type(info, "'base' for struct '%s'" % name, expr.get('base'),
+    check_type(expr.get('base'), info, "'base' for struct '%s'" % name,
                allow_metas=3D['struct'])
=20
     if features:
@@ -1020,15 +1018,15 @@ def check_struct(expr, info):
                 info, "struct '%s' requires an array for 'features'" % n=
ame)
         for f in features:
             assert isinstance(f, dict)
-            check_known_keys(info, "feature of struct %s" % name, f,
+            check_known_keys(f, info, "feature of struct %s" % name,
                              ['name'], ['if'])
=20
             check_if(f, info)
             normalize_if(f)
-            check_name(info, "feature of struct %s" % name, f['name'])
+            check_name(f['name'], info, "feature of struct %s" % name)
=20
=20
-def check_known_keys(info, source, value, required, optional):
+def check_known_keys(value, info, source, required, optional):
=20
     def pprint(elems):
         return ', '.join("'" + e + "'" for e in sorted(elems))
@@ -1052,7 +1050,7 @@ def check_keys(expr, info, meta, required, optional=
=3D[]):
         raise QAPISemError(info, "'%s' key must have a string value" % m=
eta)
     required =3D required + [meta]
     source =3D "%s '%s'" % (meta, name)
-    check_known_keys(info, source, expr, required, optional)
+    check_known_keys(expr, info, source, required, optional)
     for (key, value) in expr.items():
         if key in ['gen', 'success-response'] and value is not False:
             raise QAPISemError(info,
--=20
2.21.0


