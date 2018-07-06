Received: from eggs.gnu.org ([2001:4830:134:3::10]:58278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbORB-00085W-4C
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbOR9-0007Cm-Lf
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36376 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fbOR9-0007Ak-GA
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B9EDE9002
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 10:58:03 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  6 Jul 2018 12:57:30 +0200
Message-Id: <20180706105753.26700-5-marcandre.lureau@redhat.com>
In-Reply-To: <20180706105753.26700-1-marcandre.lureau@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 04/27] qapi: Fix some pycodestyle-3
 complaints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

From: Markus Armbruster <armbru@redhat.com>

Fix the following issues:

    common.py:873:13: E129 visually indented line with same indent as nex=
t logical line
    common.py:1766:5: E741 ambiguous variable name 'l'
    common.py:1784:1: E305 expected 2 blank lines after class or function=
 definition, found 1
    common.py:1833:1: E305 expected 2 blank lines after class or function=
 definition, found 1
    common.py:1843:1: E305 expected 2 blank lines after class or function=
 definition, found 1
    visit.py:181:18: E127 continuation line over-indented for visual inde=
nt

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180621083551.775-1-armbru@redhat.com>
[Fixup squashed in:]
Message-ID: <871sd0nzw9.fsf@dusky.pond.sub.org>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 scripts/qapi/common.py         | 15 +++++++++------
 scripts/qapi/visit.py          |  2 +-
 tests/qapi-schema/test-qapi.py | 13 +++++++------
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 9230a2a3e8..02c5c6767a 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -884,12 +884,12 @@ def check_keys(expr_elem, meta, required, optional=3D=
[]):
         if key not in required and key not in optional:
             raise QAPISemError(info, "Unknown key '%s' in %s '%s'"
                                % (key, meta, name))
-        if (key =3D=3D 'gen' or key =3D=3D 'success-response') and value=
 is not False:
+        if key in ['gen', 'success-response'] and value is not False:
             raise QAPISemError(info,
                                "'%s' of %s '%s' should only use false va=
lue"
                                % (key, meta, name))
-        if (key =3D=3D 'boxed' or key =3D=3D 'allow-oob' or
-            key =3D=3D 'allow-preconfig') and value is not True:
+        if (key in ['boxed', 'allow-oob', 'allow-preconfig']
+                and value is not True):
             raise QAPISemError(info,
                                "'%s' of %s '%s' should only use true val=
ue"
                                % (key, meta, name))
@@ -1845,12 +1845,12 @@ def camel_to_upper(value):
         return c_fun_str
=20
     new_name =3D ''
-    l =3D len(c_fun_str)
-    for i in range(l):
+    length =3D len(c_fun_str)
+    for i in range(length):
         c =3D c_fun_str[i]
         # When c is upper and no '_' appears before, do more checks
         if c.isupper() and (i > 0) and c_fun_str[i - 1] !=3D '_':
-            if i < l - 1 and c_fun_str[i + 1].islower():
+            if i < length - 1 and c_fun_str[i + 1].islower():
                 new_name +=3D '_'
             elif c_fun_str[i - 1].isdigit():
                 new_name +=3D '_'
@@ -1863,6 +1863,7 @@ def c_enum_const(type_name, const_name, prefix=3DNo=
ne):
         type_name =3D prefix
     return camel_to_upper(type_name) + '_' + c_name(const_name, False).u=
pper()
=20
+
 if hasattr(str, 'maketrans'):
     c_name_trans =3D str.maketrans('.-', '__')
 else:
@@ -1912,6 +1913,7 @@ def c_name(name, protect=3DTrue):
         return 'q_' + name
     return name
=20
+
 eatspace =3D '\033EATSPACE.'
 pointer_suffix =3D ' *' + eatspace
=20
@@ -1922,6 +1924,7 @@ def genindent(count):
         ret +=3D ' '
     return ret
=20
+
 indent_level =3D 0
=20
=20
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index dd5034a66a..460cf12989 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -187,7 +187,7 @@ void visit_type_%(c_name)s(Visitor *v, const char *na=
me, %(c_name)s **obj, Error
     }
     switch ((*obj)->type) {
 ''',
-                 c_name=3Dc_name(name))
+                c_name=3Dc_name(name))
=20
     for var in variants.variants:
         ret +=3D mcgen('''
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index f514fe71e4..cea21c773a 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -34,8 +34,8 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         if base:
             print('    base %s' % base.name)
         for m in members:
-            print('    member %s: %s optional=3D%s' % \
-                  (m.name, m.type.name, m.optional))
+            print('    member %s: %s optional=3D%s'
+                  % (m.name, m.type.name, m.optional))
         self._print_variants(variants)
         self._print_if(ifcond)
=20
@@ -46,10 +46,11 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
=20
     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
                       success_response, boxed, allow_oob, allow_preconfi=
g):
-        print('command %s %s -> %s' % \
-              (name, arg_type and arg_type.name, ret_type and ret_type.n=
ame))
-        print('   gen=3D%s success_response=3D%s boxed=3D%s oob=3D%s pre=
config=3D%s' % \
-              (gen, success_response, boxed, allow_oob, allow_preconfig)=
)
+        print('command %s %s -> %s'
+              % (name, arg_type and arg_type.name,
+                 ret_type and ret_type.name))
+        print('   gen=3D%s success_response=3D%s boxed=3D%s oob=3D%s pre=
config=3D%s'
+              % (gen, success_response, boxed, allow_oob, allow_preconfi=
g))
         self._print_if(ifcond)
=20
     def visit_event(self, name, info, ifcond, arg_type, boxed):
--=20
2.18.0.rc1
