Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DA3C432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:59:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D148207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D148207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCmI6-0002qv-AV
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 10:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCksA-0000Q3-3H
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCkrx-0001UZ-Ar
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41348)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCkrw-0001T9-JJ
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 481B83061423;
 Tue, 24 Sep 2019 13:28:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC2FF6012D;
 Tue, 24 Sep 2019 13:28:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 90BA711384D8; Tue, 24 Sep 2019 15:28:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/25] qapi: Move context-sensitive checking to the proper
 place
Date: Tue, 24 Sep 2019 15:28:21 +0200
Message-Id: <20190924132830.15835-17-armbru@redhat.com>
In-Reply-To: <20190924132830.15835-1-armbru@redhat.com>
References: <20190924132830.15835-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 24 Sep 2019 13:28:39 +0000 (UTC)
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

When we introduced the QAPISchema intermediate representation (commit
ac88219a6c7), we took a shortcut: we left check_exprs() & friends
alone instead of moving semantic checks into the
QAPISchemaFOO.check().  The .check() assert check_exprs() did its job.

Time to finish the conversion job.  Move exactly the context-sensitive
checks to the .check().  They replace assertions there.  Context-free
checks stay put.

Fixes the misleading optional tag error demonstrated by test
flat-union-optional-discriminator.

A few other error message improve.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py                        | 422 ++++++++----------
 tests/qapi-schema/alternate-any.err           |   2 +-
 .../alternate-conflict-bool-string.err        |   2 +-
 tests/qapi-schema/alternate-conflict-dict.err |   2 +-
 .../alternate-conflict-enum-bool.err          |   2 +-
 .../alternate-conflict-enum-int.err           |   2 +-
 .../alternate-conflict-num-string.err         |   2 +-
 .../qapi-schema/alternate-conflict-string.err |   2 +-
 tests/qapi-schema/alternate-nested.err        |   2 +-
 tests/qapi-schema/alternate-unknown.err       |   2 +-
 tests/qapi-schema/args-alternate.err          |   2 +-
 tests/qapi-schema/args-any.err                |   2 +-
 tests/qapi-schema/args-array-unknown.err      |   2 +-
 tests/qapi-schema/args-boxed-string.err       |   2 +-
 tests/qapi-schema/args-int.err                |   2 +-
 tests/qapi-schema/args-member-unknown.err     |   2 +-
 tests/qapi-schema/args-union.err              |   2 +-
 tests/qapi-schema/args-unknown.err            |   2 +-
 tests/qapi-schema/bad-base.err                |   2 +-
 tests/qapi-schema/command-int.err             |   2 +-
 tests/qapi-schema/flat-union-base-any.err     |   2 +-
 tests/qapi-schema/flat-union-base-union.err   |   2 +-
 .../flat-union-discriminator-bad-name.err     |   2 +-
 .../flat-union-discriminator-bad-name.json    |   1 -
 tests/qapi-schema/flat-union-empty.err        |   2 +-
 tests/qapi-schema/flat-union-int-branch.err   |   2 +-
 .../flat-union-invalid-branch-key.err         |   2 +-
 .../flat-union-invalid-if-discriminator.err   |   2 +-
 .../flat-union-optional-discriminator.err     |   2 +-
 .../flat-union-optional-discriminator.json    |   1 -
 .../flat-union-string-discriminator.err       |   2 +-
 tests/qapi-schema/redefined-builtin.err       |   2 +-
 tests/qapi-schema/redefined-type.err          |   2 +-
 tests/qapi-schema/returns-alternate.err       |   2 +-
 tests/qapi-schema/returns-unknown.err         |   2 +-
 tests/qapi-schema/returns-whitelist.err       |   2 +-
 tests/qapi-schema/union-empty.err             |   2 +-
 tests/qapi-schema/union-invalid-base.err      |   2 +-
 tests/qapi-schema/union-unknown.err           |   2 +-
 tests/qapi-schema/union-unknown.json          |   2 +-
 40 files changed, 228 insertions(+), 270 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index f5599559ac..ac4c898e51 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -21,25 +21,6 @@ import string
 import sys
 from collections import OrderedDict
=20
-builtin_types =3D {
-    'null':     'QTYPE_QNULL',
-    'str':      'QTYPE_QSTRING',
-    'int':      'QTYPE_QNUM',
-    'number':   'QTYPE_QNUM',
-    'bool':     'QTYPE_QBOOL',
-    'int8':     'QTYPE_QNUM',
-    'int16':    'QTYPE_QNUM',
-    'int32':    'QTYPE_QNUM',
-    'int64':    'QTYPE_QNUM',
-    'uint8':    'QTYPE_QNUM',
-    'uint16':   'QTYPE_QNUM',
-    'uint32':   'QTYPE_QNUM',
-    'uint64':   'QTYPE_QNUM',
-    'size':     'QTYPE_QNUM',
-    'any':      None,           # any QType possible, actually
-    'QType':    'QTYPE_QSTRING',
-}
-
 # Are documentation comments required?
 doc_required =3D False
=20
@@ -49,11 +30,6 @@ returns_whitelist =3D []
 # Whitelist of entities allowed to violate case conventions
 name_case_whitelist =3D []
=20
-enum_types =3D {}
-struct_types =3D {}
-union_types =3D {}
-all_names =3D {}
-
=20
 #
 # Parsing the schema into expressions
@@ -670,34 +646,9 @@ class QAPISchemaParser(object):
=20
=20
 #
-# Semantic analysis of schema expressions
-# TODO fold into QAPISchema
-# TODO catching name collisions in generated code would be nice
+# Check (context-free) schema expression structure
 #
=20
-
-def find_base_members(base):
-    if isinstance(base, dict):
-        return base
-    base_struct_define =3D struct_types.get(base)
-    if not base_struct_define:
-        return None
-    return base_struct_define['data']
-
-
-# Return the qtype of an alternate branch, or None on error.
-def find_alternate_member_qtype(qapi_type):
-    if qapi_type in builtin_types:
-        return builtin_types[qapi_type]
-    elif qapi_type in struct_types:
-        return 'QTYPE_QDICT'
-    elif qapi_type in enum_types:
-        return 'QTYPE_QSTRING'
-    elif qapi_type in union_types:
-        return 'QTYPE_QDICT'
-    return None
-
-
 # Names must be letters, numbers, -, and _.  They must start with letter=
,
 # except for downstream extensions which must start with __RFQDN_.
 # Dots are only valid in the downstream extension prefix.
@@ -747,16 +698,6 @@ def check_defn_name_str(name, info, meta):
                            % (meta, name, name[-4:]))
=20
=20
-def add_name(name, info, meta):
-    global all_names
-    # FIXME should reject names that differ only in '_' vs. '.'
-    # vs. '-', because they're liable to clash in generated C.
-    if name in all_names:
-        raise QAPISemError(info, "%s '%s' is already defined"
-                           % (all_names[name], name))
-    all_names[name] =3D meta
-
-
 def check_if(expr, info):
=20
     def check_if_str(ifcond, info):
@@ -780,13 +721,11 @@ def check_if(expr, info):
=20
=20
 def check_type(value, info, source,
-               allow_array=3DFalse, allow_dict=3DFalse, allow_metas=3D[]=
):
-    global all_names
-
+               allow_array=3DFalse, allow_dict=3DFalse):
     if value is None:
         return
=20
-    # Check if array type for value is okay
+    # Array type
     if isinstance(value, list):
         if not allow_array:
             raise QAPISemError(info, "%s cannot be an array" % source)
@@ -794,19 +733,14 @@ def check_type(value, info, source,
             raise QAPISemError(info,
                                "%s: array type must contain single type =
name" %
                                source)
-        check_type(value[0], info, source, allow_metas=3Dallow_metas)
         return
=20
-    # Check if type name for value is okay
+    # Type name
     if isinstance(value, str):
-        if value not in all_names:
-            raise QAPISemError(info, "%s uses unknown type '%s'"
-                               % (source, value))
-        if not all_names[value] in allow_metas:
-            raise QAPISemError(info, "%s cannot use %s type '%s'" %
-                               (source, all_names[value], value))
         return
=20
+    # Anonymous type
+
     if not allow_dict:
         raise QAPISemError(info, "%s should be a type name" % source)
=20
@@ -828,43 +762,28 @@ def check_type(value, info, source,
         check_if(arg, info)
         normalize_if(arg)
         check_type(arg['type'], info, "member '%s' of %s" % (key, source=
),
-                   allow_array=3DTrue,
-                   allow_metas=3D['built-in', 'union', 'alternate', 'str=
uct',
-                                'enum'])
+                   allow_array=3DTrue)
=20
=20
 def check_command(expr, info):
     name =3D expr['command']
     boxed =3D expr.get('boxed', False)
=20
-    args_meta =3D ['struct']
-    if boxed:
-        args_meta +=3D ['union']
     check_type(expr.get('data'), info,
                "'data' for command '%s'" % name,
-               allow_dict=3Dnot boxed, allow_metas=3Dargs_meta)
-    returns_meta =3D ['union', 'struct']
-    if name in returns_whitelist:
-        returns_meta +=3D ['built-in', 'alternate', 'enum']
+               allow_dict=3Dnot boxed)
     check_type(expr.get('returns'), info,
                "'returns' for command '%s'" % name,
-               allow_array=3DTrue, allow_metas=3Dreturns_meta)
+               allow_array=3DTrue)
=20
=20
 def check_event(expr, info):
     name =3D expr['event']
     boxed =3D expr.get('boxed', False)
=20
-    meta =3D ['struct']
-    if boxed:
-        meta +=3D ['union']
     check_type(expr.get('data'), info,
                "'data' for event '%s'" % name,
-               allow_dict=3Dnot boxed, allow_metas=3Dmeta)
-
-
-def enum_get_names(expr):
-    return [e['name'] for e in expr['data']]
+               allow_dict=3Dnot boxed)
=20
=20
 def check_union(expr, info):
@@ -873,55 +792,18 @@ def check_union(expr, info):
     discriminator =3D expr.get('discriminator')
     members =3D expr['data']
=20
-    # Two types of unions, determined by discriminator.
-
-    # With no discriminator it is a simple union.
-    if discriminator is None:
-        enum_values =3D members.keys()
-        allow_metas =3D ['built-in', 'union', 'alternate', 'struct', 'en=
um']
+    if discriminator is None:   # simple union
         if base is not None:
             raise QAPISemError(
                 info, "simple union '%s' must not have a base" % name)
-
-    # Else, it's a flat union.
-    else:
-        # The object must have a string or dictionary 'base'.
+    else:                       # flat union
         check_type(base, info, "'base' for union '%s'" % name,
-                   allow_dict=3Dname, allow_metas=3D['struct'])
+                   allow_dict=3Dname)
         if not base:
             raise QAPISemError(info, "flat union '%s' must have a base"
                                % name)
-        base_members =3D find_base_members(base)
-        assert base_members is not None
-
-        # The value of member 'discriminator' must name a non-optional
-        # member of the base struct.
         check_name_is_str(discriminator, info,
                           "discriminator of flat union '%s'" % name)
-        check_name_str(discriminator, info,
-                       "discriminator of flat union '%s'" % name)
-        discriminator_value =3D base_members.get(discriminator)
-        if not discriminator_value:
-            raise QAPISemError(info,
-                               "discriminator '%s' is not a member of 'b=
ase'"
-                               % discriminator)
-        if discriminator_value.get('if'):
-            raise QAPISemError(
-                info,
-                "the discriminator '%s' for union %s must not be conditi=
onal"
-                % (discriminator, name))
-        enum_define =3D enum_types.get(discriminator_value['type'])
-        # Do not allow string discriminator
-        if not enum_define:
-            raise QAPISemError(
-                info,
-                "discriminator '%s' must be of enumeration type"
-                % discriminator)
-        enum_values =3D enum_get_names(enum_define)
-        allow_metas =3D ['struct']
-
-    if (len(enum_values) =3D=3D 0):
-        raise QAPISemError(info, "union '%s' has no branches" % name)
=20
     for (key, value) in members.items():
         check_name_str(key, info, "member of union '%s'" % name)
@@ -930,25 +812,14 @@ def check_union(expr, info):
                          ['type'], ['if'])
         check_if(value, info)
         normalize_if(value)
-        # Each value must name a known type
         check_type(value['type'], info,
                    "member '%s' of union '%s'" % (key, name),
-                   allow_array=3Dnot base, allow_metas=3Dallow_metas)
-
-        # If the discriminator names an enum type, then all members
-        # of 'data' must also be members of the enum type.
-        if discriminator is not None:
-            if key not in enum_values:
-                raise QAPISemError(
-                    info,
-                    "discriminator value '%s' is not found in enum '%s'"
-                    % (key, enum_define['enum']))
+                   allow_array=3Dnot base)
=20
=20
 def check_alternate(expr, info):
     name =3D expr['alternate']
     members =3D expr['data']
-    types_seen =3D {}
=20
     if len(members) =3D=3D 0:
         raise QAPISemError(info,
@@ -960,37 +831,8 @@ def check_alternate(expr, info):
                          ['type'], ['if'])
         check_if(value, info)
         normalize_if(value)
-        typ =3D value['type']
-
-        # Ensure alternates have no type conflicts.
-        check_type(typ, info, "member '%s' of alternate '%s'" % (key, na=
me),
-                   allow_metas=3D['built-in', 'union', 'struct', 'enum']=
)
-        qtype =3D find_alternate_member_qtype(typ)
-        if not qtype:
-            raise QAPISemError(
-                info,
-                "alternate '%s' member '%s' cannot use type '%s'"
-                % (name, key, typ))
-        conflicting =3D set([qtype])
-        if qtype =3D=3D 'QTYPE_QSTRING':
-            enum_expr =3D enum_types.get(typ)
-            if enum_expr:
-                for v in enum_get_names(enum_expr):
-                    if v in ['on', 'off']:
-                        conflicting.add('QTYPE_QBOOL')
-                    if re.match(r'[-+0-9.]', v): # lazy, could be tighte=
ned
-                        conflicting.add('QTYPE_QNUM')
-            else:
-                conflicting.add('QTYPE_QNUM')
-                conflicting.add('QTYPE_QBOOL')
-        for qt in conflicting:
-            if qt in types_seen:
-                raise QAPISemError(
-                    info,
-                    "alternate '%s' member '%s' can't be distinguished "
-                    "from member '%s'"
-                    % (name, key, types_seen[qt]))
-            types_seen[qt] =3D key
+        check_type(value['type'], info,
+                   "member '%s' of alternate '%s'" % (key, name))
=20
=20
 def check_enum(expr, info):
@@ -1023,8 +865,7 @@ def check_struct(expr, info):
=20
     check_type(members, info, "'data' for struct '%s'" % name,
                allow_dict=3Dname)
-    check_type(expr.get('base'), info, "'base' for struct '%s'" % name,
-               allow_metas=3D['struct'])
+    check_type(expr.get('base'), info, "'base' for struct '%s'" % name)
=20
     if features:
         if not isinstance(features, list):
@@ -1106,13 +947,6 @@ def normalize_if(expr):
=20
=20
 def check_exprs(exprs):
-    global all_names
-
-    # Populate name table with names of built-in types
-    for builtin in builtin_types.keys():
-        all_names[builtin] =3D 'built-in'
-
-    # Learn the types and check for valid expression keys
     for expr_elem in exprs:
         expr =3D expr_elem['expr']
         info =3D expr_elem['info']
@@ -1129,14 +963,12 @@ def check_exprs(exprs):
             meta =3D 'enum'
             check_keys(expr, info, 'enum', ['data'], ['if', 'prefix'])
             normalize_enum(expr)
-            enum_types[expr[meta]] =3D expr
         elif 'union' in expr:
             meta =3D 'union'
             check_keys(expr, info, 'union', ['data'],
                        ['base', 'discriminator', 'if'])
             normalize_members(expr.get('base'))
             normalize_members(expr['data'])
-            union_types[expr[meta]] =3D expr
         elif 'alternate' in expr:
             meta =3D 'alternate'
             check_keys(expr, info, 'alternate', ['data'], ['if'])
@@ -1147,7 +979,6 @@ def check_exprs(exprs):
                        ['base', 'if', 'features'])
             normalize_members(expr['data'])
             normalize_features(expr.get('features'))
-            struct_types[expr[meta]] =3D expr
         elif 'command' in expr:
             meta =3D 'command'
             check_keys(expr, info, 'command', [],
@@ -1161,36 +992,29 @@ def check_exprs(exprs):
         else:
             raise QAPISemError(info, "expression is missing metatype")
         normalize_if(expr)
+
         name =3D expr[meta]
         check_name_is_str(name, info, "'%s'" % meta)
         info.set_defn(meta, name)
         check_defn_name_str(name, info, meta)
-        add_name(name, info, meta)
+
         if doc and doc.symbol !=3D name:
             raise QAPISemError(
                 info,
                 "definition of '%s' follows documentation for '%s'"
                 % (name, doc.symbol))
=20
-    # Validate that exprs make sense
-    for expr_elem in exprs:
-        expr =3D expr_elem['expr']
-        info =3D expr_elem['info']
-        doc =3D expr_elem.get('doc')
-
-        if 'include' in expr:
-            continue
-        if 'enum' in expr:
+        if meta =3D=3D 'enum':
             check_enum(expr, info)
-        elif 'union' in expr:
+        elif meta =3D=3D 'union':
             check_union(expr, info)
-        elif 'alternate' in expr:
+        elif meta =3D=3D 'alternate':
             check_alternate(expr, info)
-        elif 'struct' in expr:
+        elif meta =3D=3D 'struct':
             check_struct(expr, info)
-        elif 'command' in expr:
+        elif meta =3D=3D 'command':
             check_command(expr, info)
-        elif 'event' in expr:
+        elif meta =3D=3D 'event':
             check_event(expr, info)
         else:
             assert False, 'unexpected meta type'
@@ -1203,9 +1027,12 @@ def check_exprs(exprs):
=20
 #
 # Schema compiler frontend
+# TODO catching name collisions in generated code would be nice
 #
=20
 class QAPISchemaEntity(object):
+    meta =3D None
+
     def __init__(self, name, info, doc, ifcond=3DNone):
         assert name is None or isinstance(name, str)
         self.name =3D name
@@ -1246,6 +1073,10 @@ class QAPISchemaEntity(object):
     def visit(self, visitor):
         assert self._checked
=20
+    def describe(self):
+        assert self.meta
+        return "%s '%s'" % (self.meta, self.name)
+
=20
 class QAPISchemaVisitor(object):
     def visit_begin(self, schema):
@@ -1336,8 +1167,14 @@ class QAPISchemaType(QAPISchemaEntity):
             return None
         return self.name
=20
+    def describe(self):
+        assert self.meta
+        return "%s type '%s'" % (self.meta, self.name)
+
=20
 class QAPISchemaBuiltinType(QAPISchemaType):
+    meta =3D 'built-in'
+
     def __init__(self, name, json_type, c_type):
         QAPISchemaType.__init__(self, name, None, None)
         assert not c_type or isinstance(c_type, str)
@@ -1369,6 +1206,8 @@ class QAPISchemaBuiltinType(QAPISchemaType):
=20
=20
 class QAPISchemaEnumType(QAPISchemaType):
+    meta =3D 'enum'
+
     def __init__(self, name, info, doc, ifcond, members, prefix):
         QAPISchemaType.__init__(self, name, info, doc, ifcond)
         for m in members:
@@ -1406,6 +1245,8 @@ class QAPISchemaEnumType(QAPISchemaType):
=20
=20
 class QAPISchemaArrayType(QAPISchemaType):
+    meta =3D 'array'
+
     def __init__(self, name, info, element_type):
         QAPISchemaType.__init__(self, name, info, None, None)
         assert isinstance(element_type, str)
@@ -1414,8 +1255,9 @@ class QAPISchemaArrayType(QAPISchemaType):
=20
     def check(self, schema):
         QAPISchemaType.check(self, schema)
-        self.element_type =3D schema.lookup_type(self._element_type_name=
)
-        assert self.element_type
+        self.element_type =3D schema.resolve_type(
+            self._element_type_name, self.info,
+            self.info and self.info.defn_meta)
         assert not isinstance(self.element_type, QAPISchemaArrayType)
=20
     @property
@@ -1448,6 +1290,10 @@ class QAPISchemaArrayType(QAPISchemaType):
         visitor.visit_array_type(self.name, self.info, self.ifcond,
                                  self.element_type)
=20
+    def describe(self):
+        assert self.meta
+        return "%s type ['%s']" % (self.meta, self._element_type_name)
+
=20
 class QAPISchemaObjectType(QAPISchemaType):
     def __init__(self, name, info, doc, ifcond,
@@ -1456,6 +1302,7 @@ class QAPISchemaObjectType(QAPISchemaType):
         # flat union has base, variants, and no local_members
         # simple union has local_members, variants, and no base
         QAPISchemaType.__init__(self, name, info, doc, ifcond)
+        self.meta =3D 'union' if variants else 'struct'
         assert base is None or isinstance(base, str)
         for m in local_members:
             assert isinstance(m, QAPISchemaObjectTypeMember)
@@ -1490,8 +1337,14 @@ class QAPISchemaObjectType(QAPISchemaType):
=20
         seen =3D OrderedDict()
         if self._base_name:
-            self.base =3D schema.lookup_type(self._base_name)
-            assert isinstance(self.base, QAPISchemaObjectType)
+            self.base =3D schema.resolve_type(self._base_name, self.info=
,
+                                            "'base'")
+            if (not isinstance(self.base, QAPISchemaObjectType)
+                    or self.base.variants):
+                raise QAPISemError(
+                    self.info,
+                    "'base' requires a struct type, %s isn't"
+                    % self.base.describe())
             self.base.check(schema)
             self.base.check_clash(self.info, seen)
         for m in self.local_members:
@@ -1503,7 +1356,6 @@ class QAPISchemaObjectType(QAPISchemaType):
=20
         if self.variants:
             self.variants.check(schema, seen)
-            assert self.variants.tag_member in members
             self.variants.check_clash(self.info, seen)
=20
         # Features are in a name space separate from members
@@ -1640,8 +1492,8 @@ class QAPISchemaObjectTypeMember(QAPISchemaMember):
=20
     def check(self, schema):
         assert self.defined_in
-        self.type =3D schema.lookup_type(self._type_name)
-        assert self.type
+        self.type =3D schema.resolve_type(self._type_name, self.info,
+                                        self.describe)
=20
=20
 class QAPISchemaObjectTypeVariants(object):
@@ -1665,12 +1517,40 @@ class QAPISchemaObjectTypeVariants(object):
             v.set_defined_in(name)
=20
     def check(self, schema, seen):
-        if not self.tag_member:    # flat union
-            self.tag_member =3D seen[c_name(self._tag_name)]
-            assert self._tag_name =3D=3D self.tag_member.name
-        assert isinstance(self.tag_member.type, QAPISchemaEnumType)
-        assert not self.tag_member.optional
-        assert self.tag_member.ifcond =3D=3D []
+        if not self.tag_member: # flat union
+            self.tag_member =3D seen.get(c_name(self._tag_name))
+            base =3D "'base'"
+            # Pointing to the base type when not implicit would be
+            # nice, but we don't know it here
+            if not self.tag_member or self._tag_name !=3D self.tag_membe=
r.name:
+                raise QAPISemError(
+                    self.info,
+                    "discriminator '%s' is not a member of %s"
+                    % (self._tag_name, base))
+            # Here we do:
+            base_type =3D schema.lookup_type(self.tag_member.defined_in)
+            assert base_type
+            if not base_type.is_implicit():
+                base =3D "base type '%s'" % self.tag_member.defined_in
+            if not isinstance(self.tag_member.type, QAPISchemaEnumType):
+                raise QAPISemError(
+                    self.info,
+                    "discriminator member '%s' of %s must be of enum typ=
e"
+                    % (self._tag_name, base))
+            if self.tag_member.optional:
+                raise QAPISemError(
+                    self.info,
+                    "discriminator member '%s' of %s must not be optiona=
l"
+                    % (self._tag_name, base))
+            if self.tag_member.ifcond:
+                raise QAPISemError(
+                    self.info,
+                    "discriminator member '%s' of %s must not be conditi=
onal"
+                    % (self._tag_name, base))
+        else:                   # simple union
+            assert isinstance(self.tag_member.type, QAPISchemaEnumType)
+            assert not self.tag_member.optional
+            assert self.tag_member.ifcond =3D=3D []
         if self._tag_name:    # flat union
             # branches that are not explicitly covered get an empty type
             cases =3D set([v.name for v in self.variants])
@@ -1680,15 +1560,23 @@ class QAPISchemaObjectTypeVariants(object):
                                                     'q_empty', m.ifcond)
                     v.set_defined_in(self.tag_member.defined_in)
                     self.variants.append(v)
-        assert self.variants
+        if not self.variants:
+            raise QAPISemError(self.info, "union has no branches")
         for v in self.variants:
             v.check(schema)
             # Union names must match enum values; alternate names are
             # checked separately. Use 'seen' to tell the two apart.
             if seen:
-                assert v.name in self.tag_member.type.member_names()
-                assert (isinstance(v.type, QAPISchemaObjectType)
-                        and not v.type.variants)
+                if v.name not in self.tag_member.type.member_names():
+                    raise QAPISemError(
+                        self.info,
+                        "branch '%s' is not a value of %s"
+                        % (v.name, self.tag_member.type.describe()))
+                if (not isinstance(v.type, QAPISchemaObjectType)
+                        or v.type.variants):
+                    raise QAPISemError(
+                        self.info, "%s cannot use %s"
+                        % (v.describe(self.info), v.type.describe()))
                 v.type.check(schema)
=20
     def check_clash(self, info, seen):
@@ -1707,6 +1595,8 @@ class QAPISchemaObjectTypeVariant(QAPISchemaObjectT=
ypeMember):
=20
=20
 class QAPISchemaAlternateType(QAPISchemaType):
+    meta =3D 'alternate'
+
     def __init__(self, name, info, doc, ifcond, variants):
         QAPISchemaType.__init__(self, name, info, doc, ifcond)
         assert isinstance(variants, QAPISchemaObjectTypeVariants)
@@ -1724,9 +1614,33 @@ class QAPISchemaAlternateType(QAPISchemaType):
         # Alternate branch names have no relation to the tag enum values=
;
         # so we have to check for potential name collisions ourselves.
         seen =3D {}
+        types_seen =3D {}
         for v in self.variants.variants:
             v.check_clash(self.info, seen)
-            # TODO check conflicting qtypes
+            qtype =3D v.type.alternate_qtype()
+            if not qtype:
+                raise QAPISemError(
+                    self.info, "%s cannot use %s"
+                    % (v.describe(self.info), v.type.describe()))
+            conflicting =3D set([qtype])
+            if qtype =3D=3D 'QTYPE_QSTRING':
+                if isinstance(v.type, QAPISchemaEnumType):
+                    for m in v.type.members:
+                        if m.name in ['on', 'off']:
+                            conflicting.add('QTYPE_QBOOL')
+                        if re.match(r'[-+0-9.]', m.name):
+                            # lazy, could be tightened
+                            conflicting.add('QTYPE_QNUM')
+                else:
+                    conflicting.add('QTYPE_QNUM')
+                    conflicting.add('QTYPE_QBOOL')
+            for qt in conflicting:
+                if qt in types_seen:
+                    raise QAPISemError(
+                        self.info,
+                        "%s can't be distinguished from '%s'"
+                        % (v.describe(self.info), types_seen[qt]))
+                types_seen[qt] =3D v.name
             if self.doc:
                 self.doc.connect_member(v)
         if self.doc:
@@ -1745,6 +1659,8 @@ class QAPISchemaAlternateType(QAPISchemaType):
=20
=20
 class QAPISchemaCommand(QAPISchemaEntity):
+    meta =3D 'command'
+
     def __init__(self, name, info, doc, ifcond, arg_type, ret_type,
                  gen, success_response, boxed, allow_oob, allow_preconfi=
g):
         QAPISchemaEntity.__init__(self, name, info, doc, ifcond)
@@ -1763,14 +1679,32 @@ class QAPISchemaCommand(QAPISchemaEntity):
     def check(self, schema):
         QAPISchemaEntity.check(self, schema)
         if self._arg_type_name:
-            self.arg_type =3D schema.lookup_type(self._arg_type_name)
-            assert isinstance(self.arg_type, QAPISchemaObjectType)
-            assert not self.arg_type.variants or self.boxed
+            self.arg_type =3D schema.resolve_type(
+                self._arg_type_name, self.info, "command's 'data'")
+            if not isinstance(self.arg_type, QAPISchemaObjectType):
+                raise QAPISemError(
+                    self.info,
+                    "command's 'data' cannot take %s"
+                    % self.arg_type.describe())
+            if self.arg_type.variants and not self.boxed:
+                raise QAPISemError(
+                    self.info,
+                    "command's 'data' can take %s only with 'boxed': tru=
e"
+                    % self.arg_type.describe())
         elif self.boxed:
             raise QAPISemError(self.info, "use of 'boxed' requires 'data=
'")
         if self._ret_type_name:
-            self.ret_type =3D schema.lookup_type(self._ret_type_name)
-            assert isinstance(self.ret_type, QAPISchemaType)
+            self.ret_type =3D schema.resolve_type(
+                self._ret_type_name, self.info, "command's 'returns'")
+            if self.name not in returns_whitelist:
+                if not (isinstance(self.ret_type, QAPISchemaObjectType)
+                        or (isinstance(self.ret_type, QAPISchemaArrayTyp=
e)
+                            and isinstance(self.ret_type.element_type,
+                                           QAPISchemaObjectType))):
+                    raise QAPISemError(
+                        self.info,
+                        "command's 'returns' cannot take %s"
+                        % self.ret_type.describe())
=20
     def visit(self, visitor):
         QAPISchemaEntity.visit(self, visitor)
@@ -1782,6 +1716,8 @@ class QAPISchemaCommand(QAPISchemaEntity):
=20
=20
 class QAPISchemaEvent(QAPISchemaEntity):
+    meta =3D 'event'
+
     def __init__(self, name, info, doc, ifcond, arg_type, boxed):
         QAPISchemaEntity.__init__(self, name, info, doc, ifcond)
         assert not arg_type or isinstance(arg_type, str)
@@ -1792,9 +1728,18 @@ class QAPISchemaEvent(QAPISchemaEntity):
     def check(self, schema):
         QAPISchemaEntity.check(self, schema)
         if self._arg_type_name:
-            self.arg_type =3D schema.lookup_type(self._arg_type_name)
-            assert isinstance(self.arg_type, QAPISchemaObjectType)
-            assert not self.arg_type.variants or self.boxed
+            self.arg_type =3D schema.resolve_type(
+                self._arg_type_name, self.info, "event's 'data'")
+            if not isinstance(self.arg_type, QAPISchemaObjectType):
+                raise QAPISemError(
+                    self.info,
+                    "event's 'data' cannot take %s"
+                    % self.arg_type.describe())
+            if self.arg_type.variants and not self.boxed:
+                raise QAPISemError(
+                    self.info,
+                    "event's 'data' can take %s only with 'boxed': true"
+                    % self.arg_type.describe())
         elif self.boxed:
             raise QAPISemError(self.info, "use of 'boxed' requires 'data=
'")
=20
@@ -1825,10 +1770,16 @@ class QAPISchema(object):
     def _def_entity(self, ent):
         # Only the predefined types are allowed to not have info
         assert ent.info or self._predefining
-        assert ent.name is None or ent.name not in self._entity_dict
         self._entity_list.append(ent)
-        if ent.name is not None:
-            self._entity_dict[ent.name] =3D ent
+        if ent.name is None:
+            return
+        # TODO reject names that differ only in '_' vs. '.'  vs. '-',
+        # because they're liable to clash in generated C.
+        other_ent =3D self._entity_dict.get(ent.name)
+        if other_ent:
+            raise QAPISemError(
+                ent.info, "%s is already defined" % other_ent.describe()=
)
+        self._entity_dict[ent.name] =3D ent
=20
     def lookup_entity(self, name, typ=3DNone):
         ent =3D self._entity_dict.get(name)
@@ -1839,6 +1790,15 @@ class QAPISchema(object):
     def lookup_type(self, name):
         return self.lookup_entity(name, QAPISchemaType)
=20
+    def resolve_type(self, name, info, what):
+        typ =3D self.lookup_type(name)
+        if not typ:
+            if callable(what):
+                what =3D what(info)
+            raise QAPISemError(
+                info, "%s uses unknown type '%s'" % (what, name))
+        return typ
+
     def _def_include(self, expr, info, doc):
         include =3D expr['include']
         assert doc is None
@@ -1924,7 +1884,7 @@ class QAPISchema(object):
             # But it's not tight: the disjunction need not imply it.  We
             # may end up compiling useless wrapper types.
             # TODO kill simple unions or implement the disjunction
-            assert ifcond =3D=3D typ._ifcond # pylint: disable=3Dprotect=
ed-access
+            assert (ifcond or []) =3D=3D typ._ifcond # pylint: disable=3D=
protected-access
         else:
             self._def_entity(QAPISchemaObjectType(name, info, doc, ifcon=
d,
                                                   None, members, None, [=
]))
diff --git a/tests/qapi-schema/alternate-any.err b/tests/qapi-schema/alte=
rnate-any.err
index 5314760775..03aaf29506 100644
--- a/tests/qapi-schema/alternate-any.err
+++ b/tests/qapi-schema/alternate-any.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/alternate-any.json: In alternate 'Alt':
-tests/qapi-schema/alternate-any.json:2: alternate 'Alt' member 'one' can=
not use type 'any'
+tests/qapi-schema/alternate-any.json:2: branch 'one' cannot use built-in=
 type 'any'
diff --git a/tests/qapi-schema/alternate-conflict-bool-string.err b/tests=
/qapi-schema/alternate-conflict-bool-string.err
index e2b89f3cac..f7513b9cbe 100644
--- a/tests/qapi-schema/alternate-conflict-bool-string.err
+++ b/tests/qapi-schema/alternate-conflict-bool-string.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/alternate-conflict-bool-string.json: In alternate 'Alt=
':
-tests/qapi-schema/alternate-conflict-bool-string.json:2: alternate 'Alt'=
 member 'two' can't be distinguished from member 'one'
+tests/qapi-schema/alternate-conflict-bool-string.json:2: branch 'two' ca=
n't be distinguished from 'one'
diff --git a/tests/qapi-schema/alternate-conflict-dict.err b/tests/qapi-s=
chema/alternate-conflict-dict.err
index e3f7d9072d..e5b42d04c9 100644
--- a/tests/qapi-schema/alternate-conflict-dict.err
+++ b/tests/qapi-schema/alternate-conflict-dict.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/alternate-conflict-dict.json: In alternate 'Alt':
-tests/qapi-schema/alternate-conflict-dict.json:6: alternate 'Alt' member=
 'two' can't be distinguished from member 'one'
+tests/qapi-schema/alternate-conflict-dict.json:6: branch 'two' can't be =
distinguished from 'one'
diff --git a/tests/qapi-schema/alternate-conflict-enum-bool.err b/tests/q=
api-schema/alternate-conflict-enum-bool.err
index d0fe1433fc..3d23aeba51 100644
--- a/tests/qapi-schema/alternate-conflict-enum-bool.err
+++ b/tests/qapi-schema/alternate-conflict-enum-bool.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/alternate-conflict-enum-bool.json: In alternate 'Alt':
-tests/qapi-schema/alternate-conflict-enum-bool.json:4: alternate 'Alt' m=
ember 'two' can't be distinguished from member 'one'
+tests/qapi-schema/alternate-conflict-enum-bool.json:4: branch 'two' can'=
t be distinguished from 'one'
diff --git a/tests/qapi-schema/alternate-conflict-enum-int.err b/tests/qa=
pi-schema/alternate-conflict-enum-int.err
index 866428b1d1..b72768caa4 100644
--- a/tests/qapi-schema/alternate-conflict-enum-int.err
+++ b/tests/qapi-schema/alternate-conflict-enum-int.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/alternate-conflict-enum-int.json: In alternate 'Alt':
-tests/qapi-schema/alternate-conflict-enum-int.json:4: alternate 'Alt' me=
mber 'two' can't be distinguished from member 'one'
+tests/qapi-schema/alternate-conflict-enum-int.json:4: branch 'two' can't=
 be distinguished from 'one'
diff --git a/tests/qapi-schema/alternate-conflict-num-string.err b/tests/=
qapi-schema/alternate-conflict-num-string.err
index d00975453e..b8a2bb1829 100644
--- a/tests/qapi-schema/alternate-conflict-num-string.err
+++ b/tests/qapi-schema/alternate-conflict-num-string.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/alternate-conflict-num-string.json: In alternate 'Alt'=
:
-tests/qapi-schema/alternate-conflict-num-string.json:2: alternate 'Alt' =
member 'two' can't be distinguished from member 'one'
+tests/qapi-schema/alternate-conflict-num-string.json:2: branch 'two' can=
't be distinguished from 'one'
diff --git a/tests/qapi-schema/alternate-conflict-string.err b/tests/qapi=
-schema/alternate-conflict-string.err
index 0231f4fed1..3edec51911 100644
--- a/tests/qapi-schema/alternate-conflict-string.err
+++ b/tests/qapi-schema/alternate-conflict-string.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/alternate-conflict-string.json: In alternate 'Alt':
-tests/qapi-schema/alternate-conflict-string.json:2: alternate 'Alt' memb=
er 'two' can't be distinguished from member 'one'
+tests/qapi-schema/alternate-conflict-string.json:2: branch 'two' can't b=
e distinguished from 'one'
diff --git a/tests/qapi-schema/alternate-nested.err b/tests/qapi-schema/a=
lternate-nested.err
index 03fb9fb212..cd7a076ce5 100644
--- a/tests/qapi-schema/alternate-nested.err
+++ b/tests/qapi-schema/alternate-nested.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/alternate-nested.json: In alternate 'Alt2':
-tests/qapi-schema/alternate-nested.json:4: member 'nested' of alternate =
'Alt2' cannot use alternate type 'Alt1'
+tests/qapi-schema/alternate-nested.json:4: branch 'nested' cannot use al=
ternate type 'Alt1'
diff --git a/tests/qapi-schema/alternate-unknown.err b/tests/qapi-schema/=
alternate-unknown.err
index 7a533b2b74..df05860bba 100644
--- a/tests/qapi-schema/alternate-unknown.err
+++ b/tests/qapi-schema/alternate-unknown.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/alternate-unknown.json: In alternate 'Alt':
-tests/qapi-schema/alternate-unknown.json:2: member 'unknown' of alternat=
e 'Alt' uses unknown type 'MissingType'
+tests/qapi-schema/alternate-unknown.json:2: branch 'unknown' uses unknow=
n type 'MissingType'
diff --git a/tests/qapi-schema/args-alternate.err b/tests/qapi-schema/arg=
s-alternate.err
index 915f5d463b..852b81b89c 100644
--- a/tests/qapi-schema/args-alternate.err
+++ b/tests/qapi-schema/args-alternate.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/args-alternate.json: In command 'oops':
-tests/qapi-schema/args-alternate.json:3: 'data' for command 'oops' canno=
t use alternate type 'Alt'
+tests/qapi-schema/args-alternate.json:3: command's 'data' cannot take al=
ternate type 'Alt'
diff --git a/tests/qapi-schema/args-any.err b/tests/qapi-schema/args-any.=
err
index 8c4f9aeef4..04e11df29f 100644
--- a/tests/qapi-schema/args-any.err
+++ b/tests/qapi-schema/args-any.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/args-any.json: In command 'oops':
-tests/qapi-schema/args-any.json:2: 'data' for command 'oops' cannot use =
built-in type 'any'
+tests/qapi-schema/args-any.json:2: command's 'data' cannot take built-in=
 type 'any'
diff --git a/tests/qapi-schema/args-array-unknown.err b/tests/qapi-schema=
/args-array-unknown.err
index 57b0d8972e..218fc4bf9a 100644
--- a/tests/qapi-schema/args-array-unknown.err
+++ b/tests/qapi-schema/args-array-unknown.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/args-array-unknown.json: In command 'oops':
-tests/qapi-schema/args-array-unknown.json:2: member 'array' of 'data' fo=
r command 'oops' uses unknown type 'NoSuchType'
+tests/qapi-schema/args-array-unknown.json:2: command uses unknown type '=
NoSuchType'
diff --git a/tests/qapi-schema/args-boxed-string.err b/tests/qapi-schema/=
args-boxed-string.err
index f284406f0f..dc2b00f217 100644
--- a/tests/qapi-schema/args-boxed-string.err
+++ b/tests/qapi-schema/args-boxed-string.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/args-boxed-string.json: In command 'foo':
-tests/qapi-schema/args-boxed-string.json:2: 'data' for command 'foo' can=
not use built-in type 'str'
+tests/qapi-schema/args-boxed-string.json:2: command's 'data' cannot take=
 built-in type 'str'
diff --git a/tests/qapi-schema/args-int.err b/tests/qapi-schema/args-int.=
err
index 419268186e..81b6f86b66 100644
--- a/tests/qapi-schema/args-int.err
+++ b/tests/qapi-schema/args-int.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/args-int.json: In command 'oops':
-tests/qapi-schema/args-int.json:2: 'data' for command 'oops' cannot use =
built-in type 'int'
+tests/qapi-schema/args-int.json:2: command's 'data' cannot take built-in=
 type 'int'
diff --git a/tests/qapi-schema/args-member-unknown.err b/tests/qapi-schem=
a/args-member-unknown.err
index 168e24a4b8..0626e1209d 100644
--- a/tests/qapi-schema/args-member-unknown.err
+++ b/tests/qapi-schema/args-member-unknown.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/args-member-unknown.json: In command 'oops':
-tests/qapi-schema/args-member-unknown.json:2: member 'member' of 'data' =
for command 'oops' uses unknown type 'NoSuchType'
+tests/qapi-schema/args-member-unknown.json:2: parameter 'member' uses un=
known type 'NoSuchType'
diff --git a/tests/qapi-schema/args-union.err b/tests/qapi-schema/args-un=
ion.err
index 30a1534b4c..3a77b2863f 100644
--- a/tests/qapi-schema/args-union.err
+++ b/tests/qapi-schema/args-union.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/args-union.json: In command 'oops':
-tests/qapi-schema/args-union.json:3: 'data' for command 'oops' cannot us=
e union type 'Uni'
+tests/qapi-schema/args-union.json:3: command's 'data' can take union typ=
e 'Uni' only with 'boxed': true
diff --git a/tests/qapi-schema/args-unknown.err b/tests/qapi-schema/args-=
unknown.err
index cb835d7489..6857d6bf48 100644
--- a/tests/qapi-schema/args-unknown.err
+++ b/tests/qapi-schema/args-unknown.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/args-unknown.json: In command 'oops':
-tests/qapi-schema/args-unknown.json:2: 'data' for command 'oops' uses un=
known type 'NoSuchType'
+tests/qapi-schema/args-unknown.json:2: command's 'data' uses unknown typ=
e 'NoSuchType'
diff --git a/tests/qapi-schema/bad-base.err b/tests/qapi-schema/bad-base.=
err
index fdfd288f5c..039678a364 100644
--- a/tests/qapi-schema/bad-base.err
+++ b/tests/qapi-schema/bad-base.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/bad-base.json: In struct 'MyType':
-tests/qapi-schema/bad-base.json:3: 'base' for struct 'MyType' cannot use=
 union type 'Union'
+tests/qapi-schema/bad-base.json:3: 'base' requires a struct type, union =
type 'Union' isn't
diff --git a/tests/qapi-schema/command-int.err b/tests/qapi-schema/comman=
d-int.err
index 56b45bf656..3523d50a79 100644
--- a/tests/qapi-schema/command-int.err
+++ b/tests/qapi-schema/command-int.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/command-int.json: In command 'int':
-tests/qapi-schema/command-int.json:2: built-in 'int' is already defined
+tests/qapi-schema/command-int.json:2: built-in type 'int' is already def=
ined
diff --git a/tests/qapi-schema/flat-union-base-any.err b/tests/qapi-schem=
a/flat-union-base-any.err
index 039b9a68b9..7ab3402396 100644
--- a/tests/qapi-schema/flat-union-base-any.err
+++ b/tests/qapi-schema/flat-union-base-any.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/flat-union-base-any.json: In union 'TestUnion':
-tests/qapi-schema/flat-union-base-any.json:8: 'base' for union 'TestUnio=
n' cannot use built-in type 'any'
+tests/qapi-schema/flat-union-base-any.json:8: 'base' requires a struct t=
ype, built-in type 'any' isn't
diff --git a/tests/qapi-schema/flat-union-base-union.err b/tests/qapi-sch=
ema/flat-union-base-union.err
index 93ab91378f..5db7b1e404 100644
--- a/tests/qapi-schema/flat-union-base-union.err
+++ b/tests/qapi-schema/flat-union-base-union.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/flat-union-base-union.json: In union 'TestUnion':
-tests/qapi-schema/flat-union-base-union.json:14: 'base' for union 'TestU=
nion' cannot use union type 'UnionBase'
+tests/qapi-schema/flat-union-base-union.json:14: 'base' requires a struc=
t type, union type 'UnionBase' isn't
diff --git a/tests/qapi-schema/flat-union-discriminator-bad-name.err b/te=
sts/qapi-schema/flat-union-discriminator-bad-name.err
index 44e41883b1..2a0deb6a0e 100644
--- a/tests/qapi-schema/flat-union-discriminator-bad-name.err
+++ b/tests/qapi-schema/flat-union-discriminator-bad-name.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/flat-union-discriminator-bad-name.json: In union 'MyUn=
ion':
-tests/qapi-schema/flat-union-discriminator-bad-name.json:7: discriminato=
r of flat union 'MyUnion' uses invalid name '*switch'
+tests/qapi-schema/flat-union-discriminator-bad-name.json:6: discriminato=
r '*switch' is not a member of 'base'
diff --git a/tests/qapi-schema/flat-union-discriminator-bad-name.json b/t=
ests/qapi-schema/flat-union-discriminator-bad-name.json
index ea84b75cac..3ae8c06a89 100644
--- a/tests/qapi-schema/flat-union-discriminator-bad-name.json
+++ b/tests/qapi-schema/flat-union-discriminator-bad-name.json
@@ -1,5 +1,4 @@
 # discriminator '*switch' isn't a member of base, 'switch' is
-# reports "uses invalid name", which is good enough
 { 'enum': 'Enum', 'data': [ 'one', 'two' ] }
 { 'struct': 'Base',
   'data': { '*switch': 'Enum' } }
diff --git a/tests/qapi-schema/flat-union-empty.err b/tests/qapi-schema/f=
lat-union-empty.err
index 96fe46b918..91a5b57f5d 100644
--- a/tests/qapi-schema/flat-union-empty.err
+++ b/tests/qapi-schema/flat-union-empty.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/flat-union-empty.json: In union 'Union':
-tests/qapi-schema/flat-union-empty.json:4: union 'Union' has no branches
+tests/qapi-schema/flat-union-empty.json:4: union has no branches
diff --git a/tests/qapi-schema/flat-union-int-branch.err b/tests/qapi-sch=
ema/flat-union-int-branch.err
index 2bbb8bf22e..416b696c8f 100644
--- a/tests/qapi-schema/flat-union-int-branch.err
+++ b/tests/qapi-schema/flat-union-int-branch.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/flat-union-int-branch.json: In union 'TestUnion':
-tests/qapi-schema/flat-union-int-branch.json:8: member 'value1' of union=
 'TestUnion' cannot use built-in type 'int'
+tests/qapi-schema/flat-union-int-branch.json:8: branch 'value1' cannot u=
se built-in type 'int'
diff --git a/tests/qapi-schema/flat-union-invalid-branch-key.err b/tests/=
qapi-schema/flat-union-invalid-branch-key.err
index da4377be69..6997b3387d 100644
--- a/tests/qapi-schema/flat-union-invalid-branch-key.err
+++ b/tests/qapi-schema/flat-union-invalid-branch-key.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/flat-union-invalid-branch-key.json: In union 'TestUnio=
n':
-tests/qapi-schema/flat-union-invalid-branch-key.json:13: discriminator v=
alue 'value_wrong' is not found in enum 'TestEnum'
+tests/qapi-schema/flat-union-invalid-branch-key.json:13: branch 'value_w=
rong' is not a value of enum type 'TestEnum'
diff --git a/tests/qapi-schema/flat-union-invalid-if-discriminator.err b/=
tests/qapi-schema/flat-union-invalid-if-discriminator.err
index be770d6baa..d2b35be9ae 100644
--- a/tests/qapi-schema/flat-union-invalid-if-discriminator.err
+++ b/tests/qapi-schema/flat-union-invalid-if-discriminator.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/flat-union-invalid-if-discriminator.json: In union 'Te=
stUnion':
-tests/qapi-schema/flat-union-invalid-if-discriminator.json:10: the discr=
iminator 'enum1' for union TestUnion must not be conditional
+tests/qapi-schema/flat-union-invalid-if-discriminator.json:10: discrimin=
ator member 'enum1' of 'base' must not be conditional
diff --git a/tests/qapi-schema/flat-union-optional-discriminator.err b/te=
sts/qapi-schema/flat-union-optional-discriminator.err
index 536ac775e2..49fbf5b04d 100644
--- a/tests/qapi-schema/flat-union-optional-discriminator.err
+++ b/tests/qapi-schema/flat-union-optional-discriminator.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/flat-union-optional-discriminator.json: In union 'MyUn=
ion':
-tests/qapi-schema/flat-union-optional-discriminator.json:7: discriminato=
r 'switch' is not a member of 'base'
+tests/qapi-schema/flat-union-optional-discriminator.json:6: discriminato=
r member 'switch' of base type 'Base' must not be optional
diff --git a/tests/qapi-schema/flat-union-optional-discriminator.json b/t=
ests/qapi-schema/flat-union-optional-discriminator.json
index 143ab23a0d..2e7f766f60 100644
--- a/tests/qapi-schema/flat-union-optional-discriminator.json
+++ b/tests/qapi-schema/flat-union-optional-discriminator.json
@@ -1,5 +1,4 @@
 # we require the discriminator to be non-optional
-# FIXME reports "discriminator 'switch' is not a member of base struct '=
Base'"
 { 'enum': 'Enum', 'data': [ 'one', 'two' ] }
 { 'struct': 'Base',
   'data': { '*switch': 'Enum' } }
diff --git a/tests/qapi-schema/flat-union-string-discriminator.err b/test=
s/qapi-schema/flat-union-string-discriminator.err
index f5635a5774..fb499188aa 100644
--- a/tests/qapi-schema/flat-union-string-discriminator.err
+++ b/tests/qapi-schema/flat-union-string-discriminator.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/flat-union-string-discriminator.json: In union 'TestUn=
ion':
-tests/qapi-schema/flat-union-string-discriminator.json:13: discriminator=
 'kind' must be of enumeration type
+tests/qapi-schema/flat-union-string-discriminator.json:13: discriminator=
 member 'kind' of base type 'TestBase' must be of enum type
diff --git a/tests/qapi-schema/redefined-builtin.err b/tests/qapi-schema/=
redefined-builtin.err
index 67775fdb41..47c8933759 100644
--- a/tests/qapi-schema/redefined-builtin.err
+++ b/tests/qapi-schema/redefined-builtin.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/redefined-builtin.json: In struct 'size':
-tests/qapi-schema/redefined-builtin.json:2: built-in 'size' is already d=
efined
+tests/qapi-schema/redefined-builtin.json:2: built-in type 'size' is alre=
ady defined
diff --git a/tests/qapi-schema/redefined-type.err b/tests/qapi-schema/red=
efined-type.err
index 89acc82c2d..39f51c14ea 100644
--- a/tests/qapi-schema/redefined-type.err
+++ b/tests/qapi-schema/redefined-type.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/redefined-type.json: In enum 'foo':
-tests/qapi-schema/redefined-type.json:3: struct 'foo' is already defined
+tests/qapi-schema/redefined-type.json:3: struct type 'foo' is already de=
fined
diff --git a/tests/qapi-schema/returns-alternate.err b/tests/qapi-schema/=
returns-alternate.err
index b98cf84cef..c1caf98c47 100644
--- a/tests/qapi-schema/returns-alternate.err
+++ b/tests/qapi-schema/returns-alternate.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/returns-alternate.json: In command 'oops':
-tests/qapi-schema/returns-alternate.json:3: 'returns' for command 'oops'=
 cannot use alternate type 'Alt'
+tests/qapi-schema/returns-alternate.json:3: command's 'returns' cannot t=
ake alternate type 'Alt'
diff --git a/tests/qapi-schema/returns-unknown.err b/tests/qapi-schema/re=
turns-unknown.err
index cbece00bd2..f0a989a175 100644
--- a/tests/qapi-schema/returns-unknown.err
+++ b/tests/qapi-schema/returns-unknown.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/returns-unknown.json: In command 'oops':
-tests/qapi-schema/returns-unknown.json:2: 'returns' for command 'oops' u=
ses unknown type 'NoSuchType'
+tests/qapi-schema/returns-unknown.json:2: command's 'returns' uses unkno=
wn type 'NoSuchType'
diff --git a/tests/qapi-schema/returns-whitelist.err b/tests/qapi-schema/=
returns-whitelist.err
index 1ccd7d8de2..5b0285220f 100644
--- a/tests/qapi-schema/returns-whitelist.err
+++ b/tests/qapi-schema/returns-whitelist.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/returns-whitelist.json: In command 'no-way-this-will-g=
et-whitelisted':
-tests/qapi-schema/returns-whitelist.json:14: 'returns' for command 'no-w=
ay-this-will-get-whitelisted' cannot use built-in type 'int'
+tests/qapi-schema/returns-whitelist.json:14: command's 'returns' cannot =
take array type ['int']
diff --git a/tests/qapi-schema/union-empty.err b/tests/qapi-schema/union-=
empty.err
index 522b19e7ae..35c0d62eb0 100644
--- a/tests/qapi-schema/union-empty.err
+++ b/tests/qapi-schema/union-empty.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/union-empty.json: In union 'Union':
-tests/qapi-schema/union-empty.json:2: union 'Union' has no branches
+tests/qapi-schema/union-empty.json:2: union has no branches
diff --git a/tests/qapi-schema/union-invalid-base.err b/tests/qapi-schema=
/union-invalid-base.err
index be908709d2..10fecf0b56 100644
--- a/tests/qapi-schema/union-invalid-base.err
+++ b/tests/qapi-schema/union-invalid-base.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/union-invalid-base.json: In union 'TestUnion':
-tests/qapi-schema/union-invalid-base.json:8: 'base' for union 'TestUnion=
' cannot use built-in type 'int'
+tests/qapi-schema/union-invalid-base.json:8: 'base' requires a struct ty=
pe, built-in type 'int' isn't
diff --git a/tests/qapi-schema/union-unknown.err b/tests/qapi-schema/unio=
n-unknown.err
index 5d4fdd2857..a7f340ddca 100644
--- a/tests/qapi-schema/union-unknown.err
+++ b/tests/qapi-schema/union-unknown.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/union-unknown.json: In union 'Union':
-tests/qapi-schema/union-unknown.json:2: member 'unknown' of union 'Union=
' uses unknown type 'MissingType'
+tests/qapi-schema/union-unknown.json:2: union uses unknown type 'Missing=
Type'
diff --git a/tests/qapi-schema/union-unknown.json b/tests/qapi-schema/uni=
on-unknown.json
index aa7e8143d8..64d3666176 100644
--- a/tests/qapi-schema/union-unknown.json
+++ b/tests/qapi-schema/union-unknown.json
@@ -1,3 +1,3 @@
 # we reject a union with unknown type in branch
 { 'union': 'Union',
-  'data': { 'unknown': 'MissingType' } }
+  'data': { 'unknown': ['MissingType'] } }
--=20
2.21.0


