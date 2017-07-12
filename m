Received: from eggs.gnu.org ([2001:4830:134:3::10]:36579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVKCu-0001T2-7j
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVKCr-0003DR-H6
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:09:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dVKCr-0003CV-7o
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:09:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 585EE3345AF
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 16:09:40 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 12 Jul 2017 18:09:36 +0200
Message-Id: <1499875776-12688-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1499875776-12688-1-git-send-email-armbru@redhat.com>
References: <1499875776-12688-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/3] scripts: use build_ prefix for string not
 piped through cgen()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The gen_ prefix is awkward.  Generated C should go through cgen()
exactly once (see commit 1f9a7a1).  The common way to get this wrong is
passing a foo=3Dgen_foo() keyword argument to mcgen().  I'd like us to
adopt a naming convention where gen_ means "something that's been piped
through cgen(), and thus must not be passed to cgen() or mcgen()".
Requires renaming gen_params(), gen_marshal_proto() and
gen_event_send_proto().

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170601124143.10915-1-marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi-commands.py |  8 ++++----
 scripts/qapi-event.py    | 12 ++++++------
 scripts/qapi.py          |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index 1943de4..974d0a4 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi-commands.py
@@ -21,7 +21,7 @@ def gen_command_decl(name, arg_type, boxed, ret_type):
 ''',
                  c_type=3D(ret_type and ret_type.c_type()) or 'void',
                  c_name=3Dc_name(name),
-                 params=3Dgen_params(arg_type, boxed, 'Error **errp'))
+                 params=3Dbuild_params(arg_type, boxed, 'Error **errp'))
=20
=20
 def gen_call(name, arg_type, boxed, ret_type):
@@ -82,7 +82,7 @@ static void qmp_marshal_output_%(c_name)s(%(c_type)s re=
t_in, QObject **ret_out,
                  c_type=3Dret_type.c_type(), c_name=3Dret_type.c_name())
=20
=20
-def gen_marshal_proto(name):
+def build_marshal_proto(name):
     return ('void qmp_marshal_%s(QDict *args, QObject **ret, Error **err=
p)'
             % c_name(name))
=20
@@ -91,7 +91,7 @@ def gen_marshal_decl(name):
     return mcgen('''
 %(proto)s;
 ''',
-                 proto=3Dgen_marshal_proto(name))
+                 proto=3Dbuild_marshal_proto(name))
=20
=20
 def gen_marshal(name, arg_type, boxed, ret_type):
@@ -103,7 +103,7 @@ def gen_marshal(name, arg_type, boxed, ret_type):
 {
     Error *err =3D NULL;
 ''',
-                proto=3Dgen_marshal_proto(name))
+                proto=3Dbuild_marshal_proto(name))
=20
     if ret_type:
         ret +=3D mcgen('''
diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
index 0485e39..bcbef10 100644
--- a/scripts/qapi-event.py
+++ b/scripts/qapi-event.py
@@ -14,10 +14,10 @@
 from qapi import *
=20
=20
-def gen_event_send_proto(name, arg_type, boxed):
+def build_event_send_proto(name, arg_type, boxed):
     return 'void qapi_event_send_%(c_name)s(%(param)s)' % {
         'c_name': c_name(name.lower()),
-        'param': gen_params(arg_type, boxed, 'Error **errp')}
+        'param': build_params(arg_type, boxed, 'Error **errp')}
=20
=20
 def gen_event_send_decl(name, arg_type, boxed):
@@ -25,10 +25,10 @@ def gen_event_send_decl(name, arg_type, boxed):
=20
 %(proto)s;
 ''',
-                 proto=3Dgen_event_send_proto(name, arg_type, boxed))
+                 proto=3Dbuild_event_send_proto(name, arg_type, boxed))
=20
=20
-# Declare and initialize an object 'qapi' using parameters from gen_para=
ms()
+# Declare and initialize an object 'qapi' using parameters from build_pa=
rams()
 def gen_param_var(typ):
     assert not typ.variants
     ret =3D mcgen('''
@@ -42,7 +42,7 @@ def gen_param_var(typ):
         if memb.optional:
             ret +=3D 'has_' + c_name(memb.name) + sep
         if memb.type.name =3D=3D 'str':
-            # Cast away const added in gen_params()
+            # Cast away const added in build_params()
             ret +=3D '(char *)'
         ret +=3D c_name(memb.name)
     ret +=3D mcgen('''
@@ -72,7 +72,7 @@ def gen_event_send(name, arg_type, boxed):
     Error *err =3D NULL;
     QMPEventFuncEmit emit;
 ''',
-                proto=3Dgen_event_send_proto(name, arg_type, boxed))
+                proto=3Dbuild_event_send_proto(name, arg_type, boxed))
=20
     if arg_type and not arg_type.is_empty():
         ret +=3D mcgen('''
diff --git a/scripts/qapi.py b/scripts/qapi.py
index 0de809f..84e2eb4 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1897,7 +1897,7 @@ extern const char *const %(c_name)s_lookup[];
     return ret
=20
=20
-def gen_params(arg_type, boxed, extra):
+def build_params(arg_type, boxed, extra):
     if not arg_type:
         assert not boxed
         return extra
--=20
2.7.5
