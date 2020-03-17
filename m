Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4606C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:13:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E1520738
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NiD0NmO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E1520738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEJX0-0002n0-HY
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 17:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEJLI-00030k-M5
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:01:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEJLA-0002tM-5f
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:01:40 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:57052)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEJL9-0002mF-Ph
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584478887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MalPg/P1W9tBsJY86boSi+sMCzBe+UXVQJlO359/TaE=;
 b=NiD0NmO+iVyTFVDbL/w/H9uy17ApJmN6hF0/LyG9f4xjuDfedEZ3MiIBWucxyps1W0Z84i
 xp1vd6Dn/jELsswAYVUgMEINqAHyHjGvGuMb9sHw9YDcT8naAvXjzIK8Qe/cMxJW3FQLOA
 pgtMefJCXtvqNEEIWxpbS7BPyK+a5a4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-FlfWRHHwOWqvDHk6S6o7GQ-1; Tue, 17 Mar 2020 17:01:21 -0400
X-MC-Unique: FlfWRHHwOWqvDHk6S6o7GQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4B54800D50
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 21:01:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 26F1460BE0;
 Tue, 17 Mar 2020 21:01:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5C51411366F7; Tue, 17 Mar 2020 22:01:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/30] qapi: Add feature flags to remaining definitions
Date: Tue, 17 Mar 2020 22:00:58 +0100
Message-Id: <20200317210115.8864-14-armbru@redhat.com>
In-Reply-To: <20200317210115.8864-1-armbru@redhat.com>
References: <20200317210115.8864-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

In v4.1.0, we added feature flags just to struct types (commit
6a8c0b5102^..f3ed93d545), to satisfy an immediate need (commit
c9d4070991 "file-posix: Add dynamic-auto-read-only QAPI feature").  In
v4.2.0, we added them to commands (commit 23394b4c39 "qapi: Add
feature flags to commands") to satisfy another immediate need (commit
d76744e65e "qapi: Allow introspecting fix for savevm's cooperation
with blockdev").

Add them to the remaining definitions: enumeration types, union types,
alternate types, and events.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200317115459.31821-13-armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt            | 54 +++++++++-----
 tests/qapi-schema/doc-good.texi         | 30 ++++++++
 qapi/introspect.json                    | 20 +++---
 tests/test-qmp-cmds.c                   |  6 +-
 scripts/qapi/doc.py                     |  6 +-
 scripts/qapi/events.py                  |  2 +-
 scripts/qapi/expr.py                    | 11 ++-
 scripts/qapi/introspect.py              | 31 ++++----
 scripts/qapi/schema.py                  | 96 ++++++++++++++-----------
 scripts/qapi/types.py                   |  4 +-
 scripts/qapi/visit.py                   |  4 +-
 tests/qapi-schema/alternate-base.err    |  2 +-
 tests/qapi-schema/doc-good.json         | 17 +++++
 tests/qapi-schema/doc-good.out          | 15 ++++
 tests/qapi-schema/qapi-schema-test.json | 29 ++++++--
 tests/qapi-schema/qapi-schema-test.out  | 27 +++++--
 tests/qapi-schema/test-qapi.py          |  9 ++-
 17 files changed, 242 insertions(+), 121 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 300f277f79..43f31b4b63 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -172,7 +172,8 @@ Syntax:
     ENUM =3D { 'enum': STRING,
              'data': [ ENUM-VALUE, ... ],
              '*prefix': STRING,
-             '*if': COND }
+             '*if': COND,
+             '*features': FEATURES }
     ENUM-VALUE =3D STRING
                | { 'name': STRING, '*if': COND }
=20
@@ -207,6 +208,9 @@ the job satisfactorily.
 The optional 'if' member specifies a conditional.  See "Configuring
 the schema" below for more on this.
=20
+The optional 'features' member specifies features.  See "Features"
+below for more on this.
+
=20
 =3D=3D=3D Type references and array types =3D=3D=3D
=20
@@ -279,12 +283,14 @@ below for more on this.
 Syntax:
     UNION =3D { 'union': STRING,
               'data': BRANCHES,
-              '*if': COND }
+              '*if': COND,
+              '*features': FEATURES }
           | { 'union': STRING,
               'data': BRANCHES,
               'base': ( MEMBERS | STRING ),
               'discriminator': STRING,
-              '*if': COND }
+              '*if': COND,
+              '*features': FEATURES }
     BRANCHES =3D { BRANCH, ... }
     BRANCH =3D STRING : TYPE-REF
            | STRING : { 'type': TYPE-REF, '*if': COND }
@@ -391,13 +397,17 @@ is identical on the wire to:
 The optional 'if' member specifies a conditional.  See "Configuring
 the schema" below for more on this.
=20
+The optional 'features' member specifies features.  See "Features"
+below for more on this.
+
=20
 =3D=3D=3D Alternate types =3D=3D=3D
=20
 Syntax:
     ALTERNATE =3D { 'alternate': STRING,
                   'data': ALTERNATIVES,
-                  '*if': COND }
+                  '*if': COND,
+                  '*features': FEATURES }
     ALTERNATIVES =3D { ALTERNATIVE, ... }
     ALTERNATIVE =3D STRING : STRING
                 | STRING : { 'type': STRING, '*if': COND }
@@ -441,6 +451,9 @@ following example objects:
 The optional 'if' member specifies a conditional.  See "Configuring
 the schema" below for more on this.
=20
+The optional 'features' member specifies features.  See "Features"
+below for more on this.
+
=20
 =3D=3D=3D Commands =3D=3D=3D
=20
@@ -584,6 +597,9 @@ started with --preconfig.
 The optional 'if' member specifies a conditional.  See "Configuring
 the schema" below for more on this.
=20
+The optional 'features' member specifies features.  See "Features"
+below for more on this.
+
=20
 =3D=3D=3D Events =3D=3D=3D
=20
@@ -595,7 +611,8 @@ Syntax:
               'data': STRING,
               'boxed': true,
               )
-              '*if': COND }
+              '*if': COND,
+              '*features': FEATURES }
=20
 Member 'event' names the event.  This is the event name used in the
 Client JSON Protocol.
@@ -628,6 +645,9 @@ complex type.  See section "Code generated for events" =
for examples.
 The optional 'if' member specifies a conditional.  See "Configuring
 the schema" below for more on this.
=20
+The optional 'features' member specifies features.  See "Features"
+below for more on this.
+
=20
 =3D=3D=3D Features =3D=3D=3D
=20
@@ -966,8 +986,9 @@ schema, along with the SchemaInfo type.  This text atte=
mpts to give an
 overview how things work.  For details you need to consult the QAPI
 schema.
=20
-SchemaInfo objects have common members "name", "meta-type", and
-additional variant members depending on the value of meta-type.
+SchemaInfo objects have common members "name", "meta-type",
+"features", and additional variant members depending on the value of
+meta-type.
=20
 Each SchemaInfo object describes a wire ABI entity of a certain
 meta-type: a command, event or one of several kinds of type.
@@ -980,19 +1001,21 @@ not.  Therefore, the SchemaInfo for types have auto-=
generated
 meaningless names.  For readability, the examples in this section use
 meaningful type names instead.
=20
+Optional member "features" exposes the entity's feature strings as a
+JSON array of strings.
+
 To examine a type, start with a command or event using it, then follow
 references by name.
=20
 QAPI schema definitions not reachable that way are omitted.
=20
 The SchemaInfo for a command has meta-type "command", and variant
-members "arg-type", "ret-type", "allow-oob", and "features".  On the
-wire, the "arguments" member of a client's "execute" command must
-conform to the object type named by "arg-type".  The "return" member
-that the server passes in a success response conforms to the type
-named by "ret-type".  When "allow-oob" is true, it means the command
-supports out-of-band execution.  It defaults to false.  "features"
-exposes the command's feature strings as a JSON array of strings.
+members "arg-type", "ret-type" and "allow-oob".  On the wire, the
+"arguments" member of a client's "execute" command must conform to the
+object type named by "arg-type".  The "return" member that the server
+passes in a success response conforms to the type named by "ret-type".
+When "allow-oob" is true, it means the command supports out-of-band
+execution.  It defaults to false.
=20
 If the command takes no arguments, "arg-type" names an object type
 without members.  Likewise, if the command returns nothing, "ret-type"
@@ -1027,8 +1050,7 @@ Example: the SchemaInfo for EVENT_C from section Even=
ts
=20
 The SchemaInfo for struct and union types has meta-type "object".
=20
-The SchemaInfo for a struct type has variant members "members" and
-"features".
+The SchemaInfo for a struct type has variant member "members".
=20
 The SchemaInfo for a union type additionally has variant members "tag"
 and "variants".
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good.t=
exi
index d4b15dabf0..76b396dae6 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -88,6 +88,12 @@ The @emph{one} @{and only@}
 @item @code{two}
 Not documented
 @end table
+
+@b{Features:}
+@table @asis
+@item @code{enum-feat}
+Also @emph{one} @{and only@}
+@end table
 @code{two} is undocumented
=20
 @b{If:} @code{defined(IFCOND)}
@@ -151,6 +157,12 @@ a feature
 @item The members of @code{Variant2} when @code{base1} is @t{"two"} (@b{If=
:} @code{IFTWO})
 @end table
=20
+@b{Features:}
+@table @asis
+@item @code{union-feat1}
+a feature
+@end table
+
 @end deftp
=20
=20
@@ -167,6 +179,12 @@ One of @t{"one"}, @t{"two"}
 @item @code{data: Variant2} when @code{type} is @t{"two"} (@b{If:} @code{I=
FTWO})
 @end table
=20
+@b{Features:}
+@table @asis
+@item @code{union-feat2}
+a feature
+@end table
+
 @end deftp
=20
=20
@@ -184,6 +202,12 @@ an integer
 Not documented
 @end table
=20
+@b{Features:}
+@table @asis
+@item @code{alt-feat}
+a feature
+@end table
+
 @end deftp
=20
=20
@@ -283,5 +307,11 @@ another feature
=20
 @b{Arguments:} the members of @code{Object}
=20
+@b{Features:}
+@table @asis
+@item @code{feat3}
+a feature
+@end table
+
 @end deftypefn
=20
diff --git a/qapi/introspect.json b/qapi/introspect.json
index 8756e7920e..da3e176899 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -89,12 +89,18 @@
 #
 # @meta-type: the entity's meta type, inherited from @base.
 #
+# @features: names of features associated with the entity, in no
+#            particular order.
+#            (since 4.1 for object types, 4.2 for commands, 5.0 for
+#            the rest)
+#
 # Additional members depend on the value of @meta-type.
 #
 # Since: 2.5
 ##
 { 'union': 'SchemaInfo',
-  'base': { 'name': 'str', 'meta-type': 'SchemaMetaType' },
+  'base': { 'name': 'str', 'meta-type': 'SchemaMetaType',
+            '*features': [ 'str' ] },
   'discriminator': 'meta-type',
   'data': {
       'builtin': 'SchemaInfoBuiltin',
@@ -174,9 +180,6 @@
 #            and may even differ from the order of the values of the
 #            enum type of the @tag.
 #
-# @features: names of features associated with the type, in no particular
-#            order. (since: 4.1)
-#
 # Values of this type are JSON object on the wire.
 #
 # Since: 2.5
@@ -184,8 +187,7 @@
 { 'struct': 'SchemaInfoObject',
   'data': { 'members': [ 'SchemaInfoObjectMember' ],
             '*tag': 'str',
-            '*variants': [ 'SchemaInfoObjectVariant' ],
-            '*features': [ 'str' ] } }
+            '*variants': [ 'SchemaInfoObjectVariant' ] } }
=20
 ##
 # @SchemaInfoObjectMember:
@@ -266,17 +268,13 @@
 # @allow-oob: whether the command allows out-of-band execution,
 #             defaults to false (Since: 2.12)
 #
-# @features: names of features associated with the command, in no particul=
ar
-#            order. (since 4.2)
-#
 # TODO: @success-response (currently irrelevant, because it's QGA, not QMP=
)
 #
 # Since: 2.5
 ##
 { 'struct': 'SchemaInfoCommand',
   'data': { 'arg-type': 'str', 'ret-type': 'str',
-            '*allow-oob': 'bool',
-            '*features': [ 'str' ] } }
+            '*allow-oob': 'bool' } }
=20
 ##
 # @SchemaInfoEvent:
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 99013ff37b..d12ff47e26 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -45,7 +45,7 @@ void qmp_user_def_cmd1(UserDefOne * ud1, Error **errp)
 {
 }
=20
-void qmp_test_features(FeatureStruct0 *fs0, FeatureStruct1 *fs1,
+void qmp_test_features0(FeatureStruct0 *fs0, FeatureStruct1 *fs1,
                        FeatureStruct2 *fs2, FeatureStruct3 *fs3,
                        FeatureStruct4 *fs4, CondFeatureStruct1 *cfs1,
                        CondFeatureStruct2 *cfs2, CondFeatureStruct3 *cfs3,
@@ -53,10 +53,6 @@ void qmp_test_features(FeatureStruct0 *fs0, FeatureStruc=
t1 *fs1,
 {
 }
=20
-void qmp_test_command_features0(Error **errp)
-{
-}
-
 void qmp_test_command_features1(Error **errp)
 {
 }
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 1787a53d91..36e823338b 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -243,7 +243,7 @@ class QAPISchemaGenDocVisitor(QAPISchemaVisitor):
     def write(self, output_dir):
         self._gen.write(output_dir)
=20
-    def visit_enum_type(self, name, info, ifcond, members, prefix):
+    def visit_enum_type(self, name, info, ifcond, features, members, prefi=
x):
         doc =3D self.cur_doc
         self._gen.add(texi_type('Enum', doc, ifcond,
                                 texi_members(doc, 'Values',
@@ -257,7 +257,7 @@ class QAPISchemaGenDocVisitor(QAPISchemaVisitor):
         self._gen.add(texi_type('Object', doc, ifcond,
                                 texi_members(doc, 'Members', base, variant=
s)))
=20
-    def visit_alternate_type(self, name, info, ifcond, variants):
+    def visit_alternate_type(self, name, info, ifcond, features, variants)=
:
         doc =3D self.cur_doc
         self._gen.add(texi_type('Alternate', doc, ifcond,
                                 texi_members(doc, 'Members')))
@@ -270,7 +270,7 @@ class QAPISchemaGenDocVisitor(QAPISchemaVisitor):
                                texi_arguments(doc,
                                               arg_type if boxed else None)=
))
=20
-    def visit_event(self, name, info, ifcond, arg_type, boxed):
+    def visit_event(self, name, info, ifcond, features, arg_type, boxed):
         doc =3D self.cur_doc
         self._gen.add(texi_msg('Event', doc, ifcond,
                                texi_arguments(doc,
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index a98b9f5099..b544af5a1c 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -189,7 +189,7 @@ void %(event_emit)s(%(event_enum)s event, QDict *qdict)=
;
                              event_emit=3Dself._event_emit_name,
                              event_enum=3Dself._event_enum_name))
=20
-    def visit_event(self, name, info, ifcond, arg_type, boxed):
+    def visit_event(self, name, info, ifcond, features, arg_type, boxed):
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.add(gen_event_send_decl(name, arg_type, boxed))
             self._genc.add(gen_event_send(name, arg_type, boxed,
diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index fecf466fa7..f9c4448980 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -219,7 +219,6 @@ def check_struct(expr, info):
=20
     check_type(members, info, "'data'", allow_dict=3Dname)
     check_type(expr.get('base'), info, "'base'")
-    check_features(expr.get('features'), info)
=20
=20
 def check_union(expr, info):
@@ -267,7 +266,6 @@ def check_command(expr, info):
         raise QAPISemError(info, "'boxed': true requires 'data'")
     check_type(args, info, "'data'", allow_dict=3Dnot boxed)
     check_type(rets, info, "'returns'", allow_array=3DTrue)
-    check_features(expr.get('features'), info)
=20
=20
 def check_event(expr, info):
@@ -319,18 +317,18 @@ def check_exprs(exprs):
=20
         if meta =3D=3D 'enum':
             check_keys(expr, info, meta,
-                       ['enum', 'data'], ['if', 'prefix'])
+                       ['enum', 'data'], ['if', 'features', 'prefix'])
             check_enum(expr, info)
         elif meta =3D=3D 'union':
             check_keys(expr, info, meta,
                        ['union', 'data'],
-                       ['base', 'discriminator', 'if'])
+                       ['base', 'discriminator', 'if', 'features'])
             normalize_members(expr.get('base'))
             normalize_members(expr['data'])
             check_union(expr, info)
         elif meta =3D=3D 'alternate':
             check_keys(expr, info, meta,
-                       ['alternate', 'data'], ['if'])
+                       ['alternate', 'data'], ['if', 'features'])
             normalize_members(expr['data'])
             check_alternate(expr, info)
         elif meta =3D=3D 'struct':
@@ -348,13 +346,14 @@ def check_exprs(exprs):
             check_command(expr, info)
         elif meta =3D=3D 'event':
             check_keys(expr, info, meta,
-                       ['event'], ['data', 'boxed', 'if'])
+                       ['event'], ['data', 'boxed', 'if', 'features'])
             normalize_members(expr.get('data'))
             check_event(expr, info)
         else:
             assert False, 'unexpected meta type'
=20
         check_if(expr, info, meta)
+        check_features(expr.get('features'), info)
         check_flags(expr, info)
=20
     return exprs
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index b5537eddc0..2e9e00aa1f 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -144,7 +144,7 @@ const QLitObject %(c_name)s =3D %(c_string)s;
             return '[' + self._use_type(typ.element_type) + ']'
         return self._name(typ.name)
=20
-    def _gen_qlit(self, name, mtype, obj, ifcond):
+    def _gen_qlit(self, name, mtype, obj, ifcond, features):
         extra =3D {}
         if mtype not in ('command', 'event', 'builtin', 'array'):
             if not self._unmask:
@@ -154,6 +154,8 @@ const QLitObject %(c_name)s =3D %(c_string)s;
             name =3D self._name(name)
         obj['name'] =3D name
         obj['meta-type'] =3D mtype
+        if features:
+            obj['features'] =3D [(f.name, {'if': f.ifcond}) for f in featu=
res]
         if ifcond:
             extra['if'] =3D ifcond
         if extra:
@@ -178,18 +180,18 @@ const QLitObject %(c_name)s =3D %(c_string)s;
                 {'if': variant.ifcond})
=20
     def visit_builtin_type(self, name, info, json_type):
-        self._gen_qlit(name, 'builtin', {'json-type': json_type}, [])
+        self._gen_qlit(name, 'builtin', {'json-type': json_type}, [], None=
)
=20
-    def visit_enum_type(self, name, info, ifcond, members, prefix):
+    def visit_enum_type(self, name, info, ifcond, features, members, prefi=
x):
         self._gen_qlit(name, 'enum',
                        {'values':
                         [(m.name, {'if': m.ifcond}) for m in members]},
-                       ifcond)
+                       ifcond, features)
=20
     def visit_array_type(self, name, info, ifcond, element_type):
         element =3D self._use_type(element_type)
         self._gen_qlit('[' + element + ']', 'array', {'element-type': elem=
ent},
-                       ifcond)
+                       ifcond, None)
=20
     def visit_object_type_flat(self, name, info, ifcond, members, variants=
,
                                features):
@@ -197,16 +199,15 @@ const QLitObject %(c_name)s =3D %(c_string)s;
         if variants:
             obj.update(self._gen_variants(variants.tag_member.name,
                                           variants.variants))
-        if features:
-            obj['features'] =3D [(f.name, {'if': f.ifcond}) for f in featu=
res]
=20
-        self._gen_qlit(name, 'object', obj, ifcond)
+        self._gen_qlit(name, 'object', obj, ifcond, features)
=20
-    def visit_alternate_type(self, name, info, ifcond, variants):
+    def visit_alternate_type(self, name, info, ifcond, features, variants)=
:
         self._gen_qlit(name, 'alternate',
                        {'members': [
                            ({'type': self._use_type(m.type)}, {'if': m.ifc=
ond})
-                           for m in variants.variants]}, ifcond)
+                           for m in variants.variants]},
+                       ifcond, features)
=20
     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
                       success_response, boxed, allow_oob, allow_preconfig,
@@ -217,16 +218,12 @@ const QLitObject %(c_name)s =3D %(c_string)s;
                'ret-type': self._use_type(ret_type)}
         if allow_oob:
             obj['allow-oob'] =3D allow_oob
+        self._gen_qlit(name, 'command', obj, ifcond, features)
=20
-        if features:
-            obj['features'] =3D [(f.name, {'if': f.ifcond}) for f in featu=
res]
-
-        self._gen_qlit(name, 'command', obj, ifcond)
-
-    def visit_event(self, name, info, ifcond, arg_type, boxed):
+    def visit_event(self, name, info, ifcond, features, arg_type, boxed):
         arg_type =3D arg_type or self._schema.the_empty_object_type
         self._gen_qlit(name, 'event', {'arg-type': self._use_type(arg_type=
)},
-                       ifcond)
+                       ifcond, features)
=20
=20
 def gen_introspect(schema, output_dir, prefix, opt_unmask):
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 2a2b495987..22238005ff 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -109,7 +109,7 @@ class QAPISchemaVisitor:
     def visit_builtin_type(self, name, info, json_type):
         pass
=20
-    def visit_enum_type(self, name, info, ifcond, members, prefix):
+    def visit_enum_type(self, name, info, ifcond, features, members, prefi=
x):
         pass
=20
     def visit_array_type(self, name, info, ifcond, element_type):
@@ -123,7 +123,7 @@ class QAPISchemaVisitor:
                                features):
         pass
=20
-    def visit_alternate_type(self, name, info, ifcond, variants):
+    def visit_alternate_type(self, name, info, ifcond, features, variants)=
:
         pass
=20
     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
@@ -131,7 +131,7 @@ class QAPISchemaVisitor:
                       features):
         pass
=20
-    def visit_event(self, name, info, ifcond, arg_type, boxed):
+    def visit_event(self, name, info, ifcond, features, arg_type, boxed):
         pass
=20
=20
@@ -234,8 +234,8 @@ class QAPISchemaBuiltinType(QAPISchemaType):
 class QAPISchemaEnumType(QAPISchemaType):
     meta =3D 'enum'
=20
-    def __init__(self, name, info, doc, ifcond, members, prefix):
-        super().__init__(name, info, doc, ifcond)
+    def __init__(self, name, info, doc, ifcond, features, members, prefix)=
:
+        super().__init__(name, info, doc, ifcond, features)
         for m in members:
             assert isinstance(m, QAPISchemaEnumMember)
             m.set_defined_in(name)
@@ -271,15 +271,16 @@ class QAPISchemaEnumType(QAPISchemaType):
=20
     def visit(self, visitor):
         super().visit(visitor)
-        visitor.visit_enum_type(self.name, self.info, self.ifcond,
-                                self.members, self.prefix)
+        visitor.visit_enum_type(
+            self.name, self.info, self.ifcond, self.features,
+            self.members, self.prefix)
=20
=20
 class QAPISchemaArrayType(QAPISchemaType):
     meta =3D 'array'
=20
     def __init__(self, name, info, element_type):
-        super().__init__(name, info, None, None)
+        super().__init__(name, info, None)
         assert isinstance(element_type, str)
         self._element_type_name =3D element_type
         self.element_type =3D None
@@ -325,8 +326,8 @@ class QAPISchemaArrayType(QAPISchemaType):
=20
=20
 class QAPISchemaObjectType(QAPISchemaType):
-    def __init__(self, name, info, doc, ifcond,
-                 base, local_members, variants, features):
+    def __init__(self, name, info, doc, ifcond, features,
+                 base, local_members, variants):
         # struct has local_members, optional base, and no variants
         # flat union has base, variants, and no local_members
         # simple union has local_members, variants, and no base
@@ -622,8 +623,8 @@ class QAPISchemaObjectTypeVariant(QAPISchemaObjectTypeM=
ember):
 class QAPISchemaAlternateType(QAPISchemaType):
     meta =3D 'alternate'
=20
-    def __init__(self, name, info, doc, ifcond, variants):
-        super().__init__(name, info, doc, ifcond)
+    def __init__(self, name, info, doc, ifcond, features, variants):
+        super().__init__(name, info, doc, ifcond, features)
         assert isinstance(variants, QAPISchemaObjectTypeVariants)
         assert variants.tag_member
         variants.set_defined_in(name)
@@ -683,16 +684,16 @@ class QAPISchemaAlternateType(QAPISchemaType):
=20
     def visit(self, visitor):
         super().visit(visitor)
-        visitor.visit_alternate_type(self.name, self.info, self.ifcond,
-                                     self.variants)
+        visitor.visit_alternate_type(
+            self.name, self.info, self.ifcond, self.features, self.variant=
s)
=20
=20
 class QAPISchemaCommand(QAPISchemaEntity):
     meta =3D 'command'
=20
-    def __init__(self, name, info, doc, ifcond, arg_type, ret_type,
-                 gen, success_response, boxed, allow_oob, allow_preconfig,
-                 features):
+    def __init__(self, name, info, doc, ifcond, features,
+                 arg_type, ret_type,
+                 gen, success_response, boxed, allow_oob, allow_preconfig)=
:
         super().__init__(name, info, doc, ifcond, features)
         assert not arg_type or isinstance(arg_type, str)
         assert not ret_type or isinstance(ret_type, str)
@@ -755,8 +756,8 @@ class QAPISchemaCommand(QAPISchemaEntity):
 class QAPISchemaEvent(QAPISchemaEntity):
     meta =3D 'event'
=20
-    def __init__(self, name, info, doc, ifcond, arg_type, boxed):
-        super().__init__(name, info, doc, ifcond)
+    def __init__(self, name, info, doc, ifcond, features, arg_type, boxed)=
:
+        super().__init__(name, info, doc, ifcond, features)
         assert not arg_type or isinstance(arg_type, str)
         self._arg_type_name =3D arg_type
         self.arg_type =3D None
@@ -787,8 +788,9 @@ class QAPISchemaEvent(QAPISchemaEntity):
=20
     def visit(self, visitor):
         super().visit(visitor)
-        visitor.visit_event(self.name, self.info, self.ifcond,
-                            self.arg_type, self.boxed)
+        visitor.visit_event(
+            self.name, self.info, self.ifcond, self.features,
+            self.arg_type, self.boxed)
=20
=20
 class QAPISchema:
@@ -893,7 +895,7 @@ class QAPISchema:
                   ('null',   'null',    'QNull' + pointer_suffix)]:
             self._def_builtin_type(*t)
         self.the_empty_object_type =3D QAPISchemaObjectType(
-            'q_empty', None, None, None, None, [], None, [])
+            'q_empty', None, None, None, None, None, [], None)
         self._def_entity(self.the_empty_object_type)
=20
         qtypes =3D ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist',
@@ -901,10 +903,11 @@ class QAPISchema:
         qtype_values =3D self._make_enum_members(
             [{'name': n} for n in qtypes], None)
=20
-        self._def_entity(QAPISchemaEnumType('QType', None, None, None,
+        self._def_entity(QAPISchemaEnumType('QType', None, None, None, Non=
e,
                                             qtype_values, 'QTYPE'))
=20
-    def _make_features(self, features, info):
+    def _make_features(self, expr, info):
+        features =3D expr.get('features', [])
         return [QAPISchemaFeature(f['name'], info, f.get('if'))
                 for f in features]
=20
@@ -916,7 +919,8 @@ class QAPISchema:
         # See also QAPISchemaObjectTypeMember.describe()
         name =3D name + 'Kind'    # reserved by check_defn_name_str()
         self._def_entity(QAPISchemaEnumType(
-            name, info, None, ifcond, self._make_enum_members(values, info=
),
+            name, info, None, ifcond, None,
+            self._make_enum_members(values, info),
             None))
         return name
=20
@@ -944,8 +948,8 @@ class QAPISchema:
             # TODO kill simple unions or implement the disjunction
             assert (ifcond or []) =3D=3D typ._ifcond # pylint: disable=3Dp=
rotected-access
         else:
-            self._def_entity(QAPISchemaObjectType(name, info, None, ifcond=
,
-                                                  None, members, None, [])=
)
+            self._def_entity(QAPISchemaObjectType(
+                name, info, None, ifcond, None, None, members, None))
         return name
=20
     def _def_enum_type(self, expr, info, doc):
@@ -953,8 +957,9 @@ class QAPISchema:
         data =3D expr['data']
         prefix =3D expr.get('prefix')
         ifcond =3D expr.get('if')
+        features =3D self._make_features(expr, info)
         self._def_entity(QAPISchemaEnumType(
-            name, info, doc, ifcond,
+            name, info, doc, ifcond, features,
             self._make_enum_members(data, info), prefix))
=20
     def _make_member(self, name, typ, ifcond, info):
@@ -976,12 +981,11 @@ class QAPISchema:
         base =3D expr.get('base')
         data =3D expr['data']
         ifcond =3D expr.get('if')
-        features =3D expr.get('features', [])
+        features =3D self._make_features(expr, info)
         self._def_entity(QAPISchemaObjectType(
-            name, info, doc, ifcond, base,
+            name, info, doc, ifcond, features, base,
             self._make_members(data, info),
-            None,
-            self._make_features(features, info)))
+            None))
=20
     def _make_variant(self, case, typ, ifcond, info):
         return QAPISchemaObjectTypeVariant(case, info, typ, ifcond)
@@ -1000,6 +1004,7 @@ class QAPISchema:
         data =3D expr['data']
         base =3D expr.get('base')
         ifcond =3D expr.get('if')
+        features =3D self._make_features(expr, info)
         tag_name =3D expr.get('discriminator')
         tag_member =3D None
         if isinstance(base, dict):
@@ -1020,21 +1025,22 @@ class QAPISchema:
             tag_member =3D QAPISchemaObjectTypeMember('type', info, typ, F=
alse)
             members =3D [tag_member]
         self._def_entity(
-            QAPISchemaObjectType(name, info, doc, ifcond, base, members,
+            QAPISchemaObjectType(name, info, doc, ifcond, features,
+                                 base, members,
                                  QAPISchemaObjectTypeVariants(
-                                     tag_name, info, tag_member, variants)=
,
-                                 []))
+                                     tag_name, info, tag_member, variants)=
))
=20
     def _def_alternate_type(self, expr, info, doc):
         name =3D expr['alternate']
         data =3D expr['data']
         ifcond =3D expr.get('if')
+        features =3D self._make_features(expr, info)
         variants =3D [self._make_variant(key, value['type'], value.get('if=
'),
                                        info)
                     for (key, value) in data.items()]
         tag_member =3D QAPISchemaObjectTypeMember('type', info, 'QType', F=
alse)
         self._def_entity(
-            QAPISchemaAlternateType(name, info, doc, ifcond,
+            QAPISchemaAlternateType(name, info, doc, ifcond, features,
                                     QAPISchemaObjectTypeVariants(
                                         None, info, tag_member, variants))=
)
=20
@@ -1048,27 +1054,31 @@ class QAPISchema:
         allow_oob =3D expr.get('allow-oob', False)
         allow_preconfig =3D expr.get('allow-preconfig', False)
         ifcond =3D expr.get('if')
-        features =3D expr.get('features', [])
+        features =3D self._make_features(expr, info)
         if isinstance(data, OrderedDict):
             data =3D self._make_implicit_object_type(
-                name, info, ifcond, 'arg', self._make_members(data, info))
+                name, info, ifcond,
+                'arg', self._make_members(data, info))
         if isinstance(rets, list):
             assert len(rets) =3D=3D 1
             rets =3D self._make_array_type(rets[0], info)
-        self._def_entity(QAPISchemaCommand(name, info, doc, ifcond, data, =
rets,
+        self._def_entity(QAPISchemaCommand(name, info, doc, ifcond, featur=
es,
+                                           data, rets,
                                            gen, success_response,
-                                           boxed, allow_oob, allow_preconf=
ig,
-                                           self._make_features(features, i=
nfo)))
+                                           boxed, allow_oob, allow_preconf=
ig))
=20
     def _def_event(self, expr, info, doc):
         name =3D expr['event']
         data =3D expr.get('data')
         boxed =3D expr.get('boxed', False)
         ifcond =3D expr.get('if')
+        features =3D self._make_features(expr, info)
         if isinstance(data, OrderedDict):
             data =3D self._make_implicit_object_type(
-                name, info, ifcond, 'arg', self._make_members(data, info))
-        self._def_entity(QAPISchemaEvent(name, info, doc, ifcond, data, bo=
xed))
+                name, info, ifcond,
+                'arg', self._make_members(data, info))
+        self._def_entity(QAPISchemaEvent(name, info, doc, ifcond, features=
,
+                                         data, boxed))
=20
     def _def_exprs(self, exprs):
         for expr_elem in exprs:
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 3c83b6e4be..d0d5c03646 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -278,7 +278,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisito=
r):
         self._genh.add(gen_type_cleanup_decl(name))
         self._genc.add(gen_type_cleanup(name))
=20
-    def visit_enum_type(self, name, info, ifcond, members, prefix):
+    def visit_enum_type(self, name, info, ifcond, features, members, prefi=
x):
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.preamble_add(gen_enum(name, members, prefix))
             self._genc.add(gen_enum_lookup(name, members, prefix))
@@ -306,7 +306,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisito=
r):
                 # implicit types won't be directly allocated/freed
                 self._gen_type_cleanup(name)
=20
-    def visit_alternate_type(self, name, info, ifcond, variants):
+    def visit_alternate_type(self, name, info, ifcond, features, variants)=
:
         with ifcontext(ifcond, self._genh):
             self._genh.preamble_add(gen_fwd_object_or_array(name))
         self._genh.add(gen_object(name, ifcond, None,
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 421e5bd8cd..6e5ed781d7 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -316,7 +316,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVisit=
or):
 ''',
                                       types=3Dtypes))
=20
-    def visit_enum_type(self, name, info, ifcond, members, prefix):
+    def visit_enum_type(self, name, info, ifcond, features, members, prefi=
x):
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.add(gen_visit_decl(name, scalar=3DTrue))
             self._genc.add(gen_visit_enum(name))
@@ -342,7 +342,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVisit=
or):
                 self._genh.add(gen_visit_decl(name))
                 self._genc.add(gen_visit_object(name, base, members, varia=
nts))
=20
-    def visit_alternate_type(self, name, info, ifcond, variants):
+    def visit_alternate_type(self, name, info, ifcond, features, variants)=
:
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.add(gen_visit_decl(name))
             self._genc.add(gen_visit_alternate(name, variants))
diff --git a/tests/qapi-schema/alternate-base.err b/tests/qapi-schema/alter=
nate-base.err
index 31ebe56bbf..970a08ab26 100644
--- a/tests/qapi-schema/alternate-base.err
+++ b/tests/qapi-schema/alternate-base.err
@@ -1,3 +1,3 @@
 alternate-base.json: In alternate 'Alt':
 alternate-base.json:4: alternate has unknown key 'base'
-Valid keys are 'alternate', 'data', 'if'.
+Valid keys are 'alternate', 'data', 'features', 'if'.
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.j=
son
index d992e713d9..457b8b2cdf 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -53,10 +53,14 @@
 # @Enum:
 # @one: The _one_ {and only}
 #
+# Features:
+# @enum-feat: Also _one_ {and only}
+#
 # @two is undocumented
 ##
 { 'enum': 'Enum', 'data':
   [ { 'name': 'one', 'if': 'defined(IFONE)' }, 'two' ],
+  'features': [ 'enum-feat' ],
   'if': 'defined(IFCOND)' }
=20
 ##
@@ -86,24 +90,34 @@
=20
 ##
 # @Object:
+# Features:
+# @union-feat1: a feature
 ##
 { 'union': 'Object',
+  'features': [ 'union-feat1' ],
   'base': 'Base',
   'discriminator': 'base1',
   'data': { 'one': 'Variant1', 'two': { 'type': 'Variant2', 'if': 'IFTWO' =
} } }
=20
 ##
 # @SugaredUnion:
+# Features:
+# @union-feat2: a feature
 ##
 { 'union': 'SugaredUnion',
+  'features': [ 'union-feat2' ],
   'data': { 'one': 'Variant1', 'two': { 'type': 'Variant2', 'if': 'IFTWO' =
} } }
=20
 ##
 # @Alternate:
 # @i: an integer
 # @b is undocumented
+#
+# Features:
+# @alt-feat: a feature
 ##
 { 'alternate': 'Alternate',
+  'features': [ 'alt-feat' ],
   'data': { 'i': 'int', 'b': 'bool' } }
=20
 ##
@@ -160,6 +174,9 @@
=20
 ##
 # @EVT-BOXED:
+# Features:
+# @feat3: a feature
 ##
 { 'event': 'EVT-BOXED',  'boxed': true,
+  'features': [ 'feat3' ],
   'data': 'Object' }
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.ou=
t
index 4c9406a464..9bcb2b3e91 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -15,6 +15,7 @@ enum Enum
         if ['defined(IFONE)']
     member two
     if ['defined(IFCOND)']
+    feature enum-feat
 object Base
     member base1: Enum optional=3DFalse
 object Variant1
@@ -28,6 +29,7 @@ object Object
     case one: Variant1
     case two: Variant2
         if ['IFTWO']
+    feature union-feat1
 object q_obj_Variant1-wrapper
     member data: Variant1 optional=3DFalse
 object q_obj_Variant2-wrapper
@@ -42,10 +44,12 @@ object SugaredUnion
     case one: q_obj_Variant1-wrapper
     case two: q_obj_Variant2-wrapper
         if ['IFTWO']
+    feature union-feat2
 alternate Alternate
     tag type
     case i: int
     case b: bool
+    feature alt-feat
 object q_obj_cmd-arg
     member arg1: int optional=3DFalse
     member arg2: str optional=3DTrue
@@ -60,6 +64,7 @@ command cmd-boxed Object -> None
     feature cmd-feat2
 event EVT-BOXED Object
     boxed=3DTrue
+    feature feat3
 doc freeform
     body=3D
 =3D Section
@@ -112,6 +117,8 @@ doc symbol=3DEnum
 The _one_ {and only}
     arg=3Dtwo
=20
+    feature=3Denum-feat
+Also _one_ {and only}
     section=3DNone
 @two is undocumented
 doc symbol=3DBase
@@ -134,11 +141,15 @@ doc symbol=3DVariant2
 doc symbol=3DObject
     body=3D
=20
+    feature=3Dunion-feat1
+a feature
 doc symbol=3DSugaredUnion
     body=3D
=20
     arg=3Dtype
=20
+    feature=3Dunion-feat2
+a feature
 doc symbol=3DAlternate
     body=3D
=20
@@ -147,6 +158,8 @@ an integer
 @b is undocumented
     arg=3Db
=20
+    feature=3Dalt-feat
+a feature
 doc freeform
     body=3D
 =3D=3D Another subsection
@@ -197,3 +210,5 @@ another feature
 doc symbol=3DEVT-BOXED
     body=3D
=20
+    feature=3Dfeat3
+a feature
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qa=
pi-schema-test.json
index 9abf175fe0..fa4f3a15da 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -252,7 +252,7 @@
     'bar': { 'type': ['TestIfEnum'], 'if': 'defined(TEST_IF_EVT_BAR)' } },
   'if': 'defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)' }
=20
-# test 'features' for structs
+# test 'features'
=20
 { 'struct': 'FeatureStruct0',
   'data': { 'foo': 'int' },
@@ -281,7 +281,22 @@
   'data': { 'foo': 'int' },
   'features': [ { 'name': 'feature1', 'if': [ 'defined(TEST_IF_COND_1)',
                                               'defined(TEST_IF_COND_2)'] }=
 ] }
-{ 'command': 'test-features',
+
+{ 'enum': 'FeatureEnum1',
+  'data': [ 'eins', 'zwei', 'drei' ],
+  'features': [ 'feature1' ] }
+
+{ 'union': 'FeatureUnion1',
+  'base': { 'tag': 'FeatureEnum1' },
+  'discriminator': 'tag',
+  'data': { 'eins': 'FeatureStruct1' },
+  'features': [ 'feature1' ] }
+
+{ 'alternate': 'FeatureAlternate1',
+  'data': { 'eins': 'FeatureStruct1' },
+  'features': [ 'feature1' ] }
+
+{ 'command': 'test-features0',
   'data': { 'fs0': 'FeatureStruct0',
             'fs1': 'FeatureStruct1',
             'fs2': 'FeatureStruct2',
@@ -289,12 +304,9 @@
             'fs4': 'FeatureStruct4',
             'cfs1': 'CondFeatureStruct1',
             'cfs2': 'CondFeatureStruct2',
-            'cfs3': 'CondFeatureStruct3' } }
-
-# test 'features' for command
-
-{ 'command': 'test-command-features0',
+            'cfs3': 'CondFeatureStruct3' },
   'features': [] }
+
 { 'command': 'test-command-features1',
   'features': [ 'feature1' ] }
 { 'command': 'test-command-features3',
@@ -308,3 +320,6 @@
 { 'command': 'test-command-cond-features3',
   'features': [ { 'name': 'feature1', 'if': [ 'defined(TEST_IF_COND_1)',
                                               'defined(TEST_IF_COND_2)'] }=
 ] }
+
+{ 'event': 'TEST-EVENT-FEATURES1',
+  'features': [ 'feature1' ] }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qap=
i-schema-test.out
index 9bd3c4a490..1cbd0802b3 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -387,7 +387,25 @@ object CondFeatureStruct3
     member foo: int optional=3DFalse
     feature feature1
         if ['defined(TEST_IF_COND_1)', 'defined(TEST_IF_COND_2)']
-object q_obj_test-features-arg
+enum FeatureEnum1
+    member eins
+    member zwei
+    member drei
+    feature feature1
+object q_obj_FeatureUnion1-base
+    member tag: FeatureEnum1 optional=3DFalse
+object FeatureUnion1
+    base q_obj_FeatureUnion1-base
+    tag tag
+    case eins: FeatureStruct1
+    case zwei: q_empty
+    case drei: q_empty
+    feature feature1
+alternate FeatureAlternate1
+    tag type
+    case eins: FeatureStruct1
+    feature feature1
+object q_obj_test-features0-arg
     member fs0: FeatureStruct0 optional=3DFalse
     member fs1: FeatureStruct1 optional=3DFalse
     member fs2: FeatureStruct2 optional=3DFalse
@@ -396,9 +414,7 @@ object q_obj_test-features-arg
     member cfs1: CondFeatureStruct1 optional=3DFalse
     member cfs2: CondFeatureStruct2 optional=3DFalse
     member cfs3: CondFeatureStruct3 optional=3DFalse
-command test-features q_obj_test-features-arg -> None
-    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
-command test-command-features0 None -> None
+command test-features0 q_obj_test-features0-arg -> None
     gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
 command test-command-features1 None -> None
     gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
@@ -421,6 +437,9 @@ command test-command-cond-features3 None -> None
     gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
     feature feature1
         if ['defined(TEST_IF_COND_1)', 'defined(TEST_IF_COND_2)']
+event TEST-EVENT-FEATURES1 None
+    boxed=3DFalse
+    feature feature1
 module include/sub-module.json
 include sub-sub-module.json
 object SecondArrayRef
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.p=
y
index bee18ee344..af5b57a0b1 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -30,7 +30,7 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
     def visit_include(self, name, info):
         print('include %s' % name)
=20
-    def visit_enum_type(self, name, info, ifcond, members, prefix):
+    def visit_enum_type(self, name, info, ifcond, features, members, prefi=
x):
         print('enum %s' % name)
         if prefix:
             print('    prefix %s' % prefix)
@@ -38,6 +38,7 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
             print('    member %s' % m.name)
             self._print_if(m.ifcond, indent=3D8)
         self._print_if(ifcond)
+        self._print_features(features)
=20
     def visit_array_type(self, name, info, ifcond, element_type):
         if not info:
@@ -58,10 +59,11 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         self._print_if(ifcond)
         self._print_features(features)
=20
-    def visit_alternate_type(self, name, info, ifcond, variants):
+    def visit_alternate_type(self, name, info, ifcond, features, variants)=
:
         print('alternate %s' % name)
         self._print_variants(variants)
         self._print_if(ifcond)
+        self._print_features(features)
=20
     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
                       success_response, boxed, allow_oob, allow_preconfig,
@@ -74,10 +76,11 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         self._print_if(ifcond)
         self._print_features(features)
=20
-    def visit_event(self, name, info, ifcond, arg_type, boxed):
+    def visit_event(self, name, info, ifcond, features, arg_type, boxed):
         print('event %s %s' % (name, arg_type and arg_type.name))
         print('    boxed=3D%s' % boxed)
         self._print_if(ifcond)
+        self._print_features(features)
=20
     @staticmethod
     def _print_variants(variants):
--=20
2.21.1


