Received: from eggs.gnu.org ([2001:4830:134:3::10]:59137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpFEI-0003yz-Ow
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:53:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpFEE-0003BP-0D
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:53:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dpFED-0003Au-Nl
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:53:25 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-24-marcandre.lureau@redhat.com>
Date: Tue, 05 Sep 2017 16:53:17 +0200
In-Reply-To: <20170822132255.23945-24-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 22 Aug 2017
	15:22:24 +0200")
Message-ID: <874lshp57m.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 23/54] qapi-commands: add #if conditions
 to commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Wrap generated code with #if/#endif using the ifcond_decorator.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi-commands.py  | 2 ++
>  tests/test-qmp-commands.c | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
> index 5eb96b2d95..db45415c41 100644
> --- a/scripts/qapi-commands.py
> +++ b/scripts/qapi-commands.py
> @@ -228,6 +228,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
>          self.defn =3D None
>          self._regy =3D None
>          self._visited_ret_types =3D None
> +        self.if_members =3D ['decl', 'defn', '_regy']
>=20=20
>      def visit_begin(self, schema):
>          self.decl =3D ''
> @@ -240,6 +241,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
>          self._regy =3D None
>          self._visited_ret_types =3D None
>=20=20
> +    @ifcond_decorator
>      def visit_command(self, name, info, arg_type, ret_type,
>                        gen, success_response, boxed, ifcond):
>          if not gen:
> diff --git a/tests/test-qmp-commands.c b/tests/test-qmp-commands.c
> index 9b9a7ffee7..ad7b6e4e1d 100644
> --- a/tests/test-qmp-commands.c
> +++ b/tests/test-qmp-commands.c
> @@ -10,11 +10,11 @@
>=20=20
>  static QmpCommandList qmp_commands;
>=20=20
> -/* #if defined(TEST_IF_CMD) */
> +#if defined(TEST_IF_CMD)
>  void qmp_TestIfCmd(TestIfStruct *foo, Error **errp)
>  {
>  }
> -/* #endif */
> +#endif
>=20=20
>  void qmp_user_def_cmd(Error **errp)
>  {

To find out whether the clever decorator is worth its keep, I replaced
it with the dumbest, most obvious code I could think of (appended).
Does this make visit_command() easier or harder to understand?



diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index db45415c41..13d37d2ac2 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi-commands.py
@@ -228,7 +228,6 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
         self.defn =3D None
         self._regy =3D None
         self._visited_ret_types =3D None
-        self.if_members =3D ['decl', 'defn', '_regy']
=20
     def visit_begin(self, schema):
         self.decl =3D ''
@@ -241,18 +240,21 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
         self._regy =3D None
         self._visited_ret_types =3D None
=20
-    @ifcond_decorator
     def visit_command(self, name, info, arg_type, ret_type,
                       gen, success_response, boxed, ifcond):
         if not gen:
             return
-        self.decl +=3D gen_command_decl(name, arg_type, boxed, ret_type)
+        decl =3D gen_command_decl(name, arg_type, boxed, ret_type)
+        defn =3D ''
         if ret_type and ret_type not in self._visited_ret_types:
             self._visited_ret_types.add(ret_type)
-            self.defn +=3D gen_marshal_output(ret_type)
-        self.decl +=3D gen_marshal_decl(name)
-        self.defn +=3D gen_marshal(name, arg_type, boxed, ret_type)
-        self._regy +=3D gen_register_command(name, success_response)
+            defn +=3D gen_marshal_output(ret_type)
+        decl +=3D gen_marshal_decl(name)
+        defn +=3D gen_marshal(name, arg_type, boxed, ret_type)
+        self.decl +=3D gen_ifcond(ifcond, decl)
+        self.defn +=3D gen_ifcond(ifcond, defn)
+        self._regy +=3D gen_ifcond(ifcond,
+                                 gen_register_command(name, success_respon=
se))
=20
=20
 (input_file, output_dir, do_c, do_h, prefix, opts) =3D parse_command_line()
diff --git a/scripts/qapi.py b/scripts/qapi.py
index 52099332f1..3de5b8b8f0 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1918,29 +1918,10 @@ def gen_endif(ifcond):
     return ret
=20
=20
-# Wrap a method to add #if / #endif to generated code, only if some
-# code was generated.
-# self must have 'if_members' listing the attributes to wrap.
-# The last argument of the wrapped function must be the 'ifcond'.
-def ifcond_decorator(func):
-
-    def func_wrapper(self, *args, **kwargs):
-        ifcond =3D args[-1]
-        save =3D {}
-        for mem in self.if_members:
-            save[mem] =3D getattr(self, mem)
-        func(self, *args, **kwargs)
-        for mem, val in save.items():
-            newval =3D getattr(self, mem)
-            if newval !=3D val:
-                assert newval.startswith(val)
-                newval =3D newval[len(val):]
-                val +=3D gen_if(ifcond)
-                val +=3D newval
-                val +=3D gen_endif(ifcond)
-            setattr(self, mem, val)
-
-    return func_wrapper
+def gen_ifcond(ifcond, ctext):
+    if ifcond:
+        return gen_if(ifcond) + ctext + gen_endif(ifcond)
+    return ctext
=20
=20
 def gen_enum_lookup(name, values, prefix=3DNone):
