Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C560C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 06:52:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DF32208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 06:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF32208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7a0k-0002n5-Ez
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 02:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i7ZmS-0004mz-9D
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 02:37:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i7ZmP-0007kk-El
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 02:37:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47152)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i7ZmP-0007jS-15
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 02:37:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 142052A09C6;
 Tue, 10 Sep 2019 06:37:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E80B6012C;
 Tue, 10 Sep 2019 06:37:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3AFC311655F8; Tue, 10 Sep 2019 08:37:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 08:37:16 +0200
Message-Id: <20190910063724.28470-9-armbru@redhat.com>
In-Reply-To: <20190910063724.28470-1-armbru@redhat.com>
References: <20190910063724.28470-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 10 Sep 2019 06:37:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 08/16] qapi: Permit 'boxed' with empty type
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

We reject empty types with 'boxed': true.  We don't really need that
to work, but making it work is actually simpler than rejecting it, so
do that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-qmp-cmds.c                   |  4 ++++
 scripts/qapi/commands.py                |  4 ++--
 scripts/qapi/common.py                  | 14 ++------------
 scripts/qapi/events.py                  | 10 +++++-----
 tests/Makefile.include                  |  1 -
 tests/qapi-schema/args-boxed-empty.err  |  1 -
 tests/qapi-schema/args-boxed-empty.exit |  1 -
 tests/qapi-schema/args-boxed-empty.json |  3 ---
 tests/qapi-schema/args-boxed-empty.out  |  0
 tests/qapi-schema/qapi-schema-test.json |  2 ++
 tests/qapi-schema/qapi-schema-test.out  |  4 ++++
 11 files changed, 19 insertions(+), 25 deletions(-)
 delete mode 100644 tests/qapi-schema/args-boxed-empty.err
 delete mode 100644 tests/qapi-schema/args-boxed-empty.exit
 delete mode 100644 tests/qapi-schema/args-boxed-empty.json
 delete mode 100644 tests/qapi-schema/args-boxed-empty.out

diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index ab389f42da..36fdf5b115 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -97,6 +97,10 @@ void qmp_boxed_union(UserDefListUnion *arg, Error **er=
rp)
 {
 }
=20
+void qmp_boxed_empty(Empty1 *arg, Error **errp)
+{
+}
+
 __org_qemu_x_Union1 *qmp___org_qemu_x_command(__org_qemu_x_EnumList *a,
                                               __org_qemu_x_StructList *b=
,
                                               __org_qemu_x_Union2 *c,
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index b929e07be4..7e3dd1068a 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -30,7 +30,7 @@ def gen_call(name, arg_type, boxed, ret_type):
=20
     argstr =3D ''
     if boxed:
-        assert arg_type and not arg_type.is_empty()
+        assert arg_type
         argstr =3D '&arg, '
     elif arg_type:
         assert not arg_type.variants
@@ -96,7 +96,7 @@ def gen_marshal_decl(name):
=20
=20
 def gen_marshal(name, arg_type, boxed, ret_type):
-    have_args =3D arg_type and not arg_type.is_empty()
+    have_args =3D boxed or (arg_type and not arg_type.is_empty())
=20
     ret =3D mcgen('''
=20
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index f5583d3eac..6e25479939 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1684,12 +1684,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
             self.arg_type =3D schema.lookup_type(self._arg_type_name)
             assert isinstance(self.arg_type, QAPISchemaObjectType)
             self.arg_type.check(schema)
-            if self.boxed:
-                if self.arg_type.is_empty():
-                    raise QAPISemError(self.info,
-                                       "Cannot use 'boxed' with empty ty=
pe")
-            else:
-                assert not self.arg_type.variants
+            assert not self.arg_type.variants or self.boxed
         elif self.boxed:
             raise QAPISemError(self.info, "Use of 'boxed' requires 'data=
'")
         if self._ret_type_name:
@@ -1718,12 +1713,7 @@ class QAPISchemaEvent(QAPISchemaEntity):
             self.arg_type =3D schema.lookup_type(self._arg_type_name)
             assert isinstance(self.arg_type, QAPISchemaObjectType)
             self.arg_type.check(schema)
-            if self.boxed:
-                if self.arg_type.is_empty():
-                    raise QAPISemError(self.info,
-                                       "Cannot use 'boxed' with empty ty=
pe")
-            else:
-                assert not self.arg_type.variants
+            assert not self.arg_type.variants or self.boxed
         elif self.boxed:
             raise QAPISemError(self.info, "Use of 'boxed' requires 'data=
'")
=20
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index b732581046..e0abfef7b0 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -65,6 +65,8 @@ def gen_event_send(name, arg_type, boxed, event_enum_na=
me, event_emit):
     # practice, we can rename our local variables with a leading _ prefi=
x,
     # or split the code into a wrapper function that creates a boxed
     # 'param' object then calls another to do the real work.
+    have_args =3D boxed or (arg_type and not arg_type.is_empty())
+
     ret =3D mcgen('''
=20
 %(proto)s
@@ -73,15 +75,13 @@ def gen_event_send(name, arg_type, boxed, event_enum_=
name, event_emit):
 ''',
                 proto=3Dbuild_event_send_proto(name, arg_type, boxed))
=20
-    if arg_type and not arg_type.is_empty():
+    if have_args:
         ret +=3D mcgen('''
     QObject *obj;
     Visitor *v;
 ''')
         if not boxed:
             ret +=3D gen_param_var(arg_type)
-    else:
-        assert not boxed
=20
     ret +=3D mcgen('''
=20
@@ -90,7 +90,7 @@ def gen_event_send(name, arg_type, boxed, event_enum_na=
me, event_emit):
 ''',
                  name=3Dname)
=20
-    if arg_type and not arg_type.is_empty():
+    if have_args:
         ret +=3D mcgen('''
     v =3D qobject_output_visitor_new(&obj);
 ''')
@@ -121,7 +121,7 @@ def gen_event_send(name, arg_type, boxed, event_enum_=
name, event_emit):
                  event_emit=3Devent_emit,
                  c_enum=3Dc_enum_const(event_enum_name, name))
=20
-    if arg_type and not arg_type.is_empty():
+    if have_args:
         ret +=3D mcgen('''
     visit_free(v);
 ''')
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3723496959..f653a1172d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -312,7 +312,6 @@ qapi-schema +=3D args-array-empty.json
 qapi-schema +=3D args-array-unknown.json
 qapi-schema +=3D args-bad-boxed.json
 qapi-schema +=3D args-boxed-anon.json
-qapi-schema +=3D args-boxed-empty.json
 qapi-schema +=3D args-boxed-string.json
 qapi-schema +=3D args-int.json
 qapi-schema +=3D args-invalid.json
diff --git a/tests/qapi-schema/args-boxed-empty.err b/tests/qapi-schema/a=
rgs-boxed-empty.err
deleted file mode 100644
index 039603e85c..0000000000
--- a/tests/qapi-schema/args-boxed-empty.err
+++ /dev/null
@@ -1 +0,0 @@
-tests/qapi-schema/args-boxed-empty.json:3: Cannot use 'boxed' with empty=
 type
diff --git a/tests/qapi-schema/args-boxed-empty.exit b/tests/qapi-schema/=
args-boxed-empty.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/args-boxed-empty.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/args-boxed-empty.json b/tests/qapi-schema/=
args-boxed-empty.json
deleted file mode 100644
index 52717e065f..0000000000
--- a/tests/qapi-schema/args-boxed-empty.json
+++ /dev/null
@@ -1,3 +0,0 @@
-# 'boxed' requires a non-empty type
-{ 'struct': 'Empty', 'data': {} }
-{ 'command': 'foo', 'boxed': true, 'data': 'Empty' }
diff --git a/tests/qapi-schema/args-boxed-empty.out b/tests/qapi-schema/a=
rgs-boxed-empty.out
deleted file mode 100644
index e69de29bb2..0000000000
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index 0fadb4ddd7..e6dbbbd328 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -149,6 +149,7 @@
 { 'command': 'guest-sync', 'data': { 'arg': 'any' }, 'returns': 'any' }
 { 'command': 'boxed-struct', 'boxed': true, 'data': 'UserDefZero' }
 { 'command': 'boxed-union', 'data': 'UserDefListUnion', 'boxed': true }
+{ 'command': 'boxed-empty', 'boxed': true, 'data': 'Empty1' }
=20
 # Smoke test on out-of-band and allow-preconfig-test
 { 'command': 'test-flags-command', 'allow-oob': true, 'allow-preconfig':=
 true }
@@ -181,6 +182,7 @@
   'data': { 'a' : 'EventStructOne', 'b' : 'str', '*c': 'str', '*enum3': =
'EnumOne' } }
 { 'event': 'EVENT_E', 'boxed': true, 'data': 'UserDefZero' }
 { 'event': 'EVENT_F', 'boxed': true, 'data': 'UserDefFlatUnion' }
+{ 'event': 'EVENT_G', 'boxed': true, 'data': 'Empty1' }
=20
 # test that we correctly compile downstream extensions, as well as munge
 # ticklish names
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 5470a525f5..fb00a21996 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -221,6 +221,8 @@ command boxed-struct UserDefZero -> None
    gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse preconfig=
=3DFalse
 command boxed-union UserDefListUnion -> None
    gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse preconfig=
=3DFalse
+command boxed-empty Empty1 -> None
+   gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse preconfig=
=3DFalse
 command test-flags-command None -> None
    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DTrue preconfig=
=3DTrue
 object UserDefOptions
@@ -254,6 +256,8 @@ event EVENT_E UserDefZero
    boxed=3DTrue
 event EVENT_F UserDefFlatUnion
    boxed=3DTrue
+event EVENT_G Empty1
+   boxed=3DTrue
 enum __org.qemu_x-Enum
     member __org.qemu_x-value
 object __org.qemu_x-Base
--=20
2.21.0


