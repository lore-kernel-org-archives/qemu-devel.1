Received: from eggs.gnu.org ([2001:4830:134:3::10]:49281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faMWg-0000YN-6M
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:43:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faMWd-0004Hm-1Q
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:43:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48644 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faMWc-0004Hb-RR
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:43:26 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180627163551.31610-1-marcandre.lureau@redhat.com>
	<20180627163551.31610-11-marcandre.lureau@redhat.com>
Date: Tue, 03 Jul 2018 16:43:20 +0200
In-Reply-To: <20180627163551.31610-11-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 27 Jun 2018
	18:35:46 +0200")
Message-ID: <87va9w8jnb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 10/15] qapi/commands: add #if conditions
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
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Wrap generated code with #if/#endif using an 'ifcontext' on
> QAPIGenCSnippet objects.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi/commands.py | 21 ++++++++++++---------
>  tests/test-qmp-cmds.c    |  5 +++--
>  2 files changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
> index dcc03c7859..72749c7fc5 100644
> --- a/scripts/qapi/commands.py
> +++ b/scripts/qapi/commands.py
> @@ -239,7 +239,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaModularCV=
isitor):
>          QAPISchemaModularCVisitor.__init__(
>              self, prefix, 'qapi-commands',
>              ' * Schema-defined QAPI/QMP commands', __doc__)
> -        self._regy =3D ''
> +        self._regy =3D QAPIGenCCode()
>          self._visited_ret_types =3D {}
>=20=20
>      def _begin_module(self, name):
> @@ -275,20 +275,23 @@ class QAPISchemaGenCommandVisitor(QAPISchemaModular=
CVisitor):
>  void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
>  ''',
>                         c_prefix=3Dc_name(self._prefix, protect=3DFalse)))
> -        genc.add(gen_registry(self._regy, self._prefix))
> +        genc.add(gen_registry(self._regy.get_content(), self._prefix))
>=20=20
>      def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
>                        success_response, boxed, allow_oob, allow_preconfi=
g):
>          if not gen:
>              return
> -        self._genh.add(gen_command_decl(name, arg_type, boxed, ret_type))
> -        if ret_type and ret_type not in self._visited_ret_types[self._ge=
nc]:
> +        if ret_type and \
> +           ret_type not in self._visited_ret_types[self._genc]:

PEP8 prefers parenthesis over backslash.  Can touch this up when I
apply.

>              self._visited_ret_types[self._genc].add(ret_type)
> -            self._genc.add(gen_marshal_output(ret_type))
> -        self._genh.add(gen_marshal_decl(name))
> -        self._genc.add(gen_marshal(name, arg_type, boxed, ret_type))
> -        self._regy +=3D gen_register_command(name, success_response, all=
ow_oob,
> -                                           allow_preconfig)
> +            with ifcontext(ret_type.ifcond, self._genh, self._genc, self=
._regy):
> +                self._genc.add(gen_marshal_output(ret_type))
> +        with ifcontext(ifcond, self._genh, self._genc, self._regy):
> +            self._genh.add(gen_command_decl(name, arg_type, boxed, ret_t=
ype))
> +            self._genh.add(gen_marshal_decl(name))
> +            self._genc.add(gen_marshal(name, arg_type, boxed, ret_type))
> +            self._regy.add(gen_register_command(name, success_response,
> +                                                allow_oob, allow_preconf=
ig))

Okay, now it falls apart differently :)  Let's step through the code
real slow.

The first time we visit a command C returning type T...

        if ret_type and \
           ret_type not in self._visited_ret_types[self._genc]:
            self._visited_ret_types[self._genc].add(ret_type)
            with ifcontext(ret_type.ifcond, self._genh, self._genc, self._r=
egy):
                self._genc.add(gen_marshal_output(ret_type))

... we generate qmp_marshal_output_T() wrapped in T's condition.

        with ifcontext(ifcond, self._genh, self._genc, self._regy):
            self._genh.add(gen_command_decl(name, arg_type, boxed, ret_type=
))
            self._genh.add(gen_marshal_decl(name))
            self._genc.add(gen_marshal(name, arg_type, boxed, ret_type))
            self._regy.add(gen_register_command(name, success_response,
                                                allow_oob, allow_preconfig))

We generate qmp_marshal_C() wrapped in C's condition.  This is what
calls qmp_marshal_output_T().

If T is a user-defined type, the user is responsible for making this
work, i.e. to make T's condition the conjunction of the T-returning
commands' conditions.

If T is a built-in type, this isn't possible: the qmp_marshal_output_T()
will be generated unconditionally.

I append a crude patch to provide test coverage (crude because it
removes coverage of another case).  With it applied, make check dies
with

    tests/test-qapi-commands.c:470:13: warning: =E2=80=98qmp_marshal_output=
_str=E2=80=99 defined but not used [-Wunused-function]

I think the issue is obscure enough to justify postponing a proper fix,
and just add a FIXME here now.  I can do that when I apply.

>=20=20
>=20=20
>  def gen_commands(schema, output_dir, prefix):
> diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
> index 840530b84c..bd27353908 100644
> --- a/tests/test-qmp-cmds.c
> +++ b/tests/test-qmp-cmds.c
> @@ -12,12 +12,13 @@
>=20=20
>  static QmpCommandList qmp_commands;
>=20=20
> -/* #if defined(TEST_IF_STRUCT) && defined(TEST_IF_CMD) */
> +#if defined(TEST_IF_STRUCT) && defined(TEST_IF_CMD)
>  UserDefThree *qmp_TestIfCmd(TestIfStruct *foo, Error **errp)
> +void qmp_TestIfCmd(TestIfStruct *foo, Error **errp)

Whoops!

Not caught by make check since it compiles with none of the conditionals
defined.  Improvement welcome, but not necessary to get this series in.
I can fix the editing accident when I apply.

>  {
>      return NULL;
>  }
> -/* #endif */
> +#endif
>=20=20
>  UserDefThree *qmp_TestCmdReturnDefThree(Error **errp)
>  {


diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qa=
pi-schema-test.json
index 16209b57b3..4dd1ce3703 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -8,7 +8,8 @@
     # Commands allowed to return a non-dictionary:
     'returns-whitelist': [
         'guest-get-time',
-        'guest-sync' ] } }
+        'guest-sync',
+        'TestIfCmd' ] } }
=20
 { 'struct': 'TestStruct',
   'data': { 'integer': 'int', 'boolean': 'bool', 'string': 'str' } }
@@ -56,9 +57,6 @@
   'data': { 'string0': 'str',
             'dict1': 'UserDefTwoDict' } }
=20
-{ 'struct': 'UserDefThree',
-  'data': { 'string0': 'str' } }
-
 # dummy struct to force generation of array types not otherwise mentioned
 { 'struct': 'ForceArrays',
   'data': { 'unused1':['UserDefOne'], 'unused2':['UserDefTwo'],
@@ -212,10 +210,8 @@
   'if': 'defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)' }
=20
 { 'command': 'TestIfCmd', 'data': { 'foo': 'TestIfStruct' },
-  'returns': 'UserDefThree',
+  'returns': 'str',
   'if': ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)'] }
=20
-{ 'command': 'TestCmdReturnDefThree', 'returns': 'UserDefThree' }
-
 { 'event': 'TestIfEvent', 'data': { 'foo': 'TestIfStruct' },
   'if': 'defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)' }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qap=
i-schema-test.out
index 0da92455da..aafa40c226 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -36,8 +36,6 @@ object UserDefTwoDict
 object UserDefTwo
     member string0: str optional=3DFalse
     member dict1: UserDefTwoDict optional=3DFalse
-object UserDefThree
-    member string0: str optional=3DFalse
 object ForceArrays
     member unused1: UserDefOneList optional=3DFalse
     member unused2: UserDefTwoList optional=3DFalse
@@ -257,11 +255,9 @@ alternate TestIfAlternate
 object q_obj_TestIfCmd-arg
     member foo: TestIfStruct optional=3DFalse
     if ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)']
-command TestIfCmd q_obj_TestIfCmd-arg -> UserDefThree
+command TestIfCmd q_obj_TestIfCmd-arg -> str
    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
     if ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)']
-command TestCmdReturnDefThree None -> UserDefThree
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
 object q_obj_TestIfEvent-arg
     member foo: TestIfStruct optional=3DFalse
     if ['defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)']
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index bd27353908..6ba73fd53c 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -13,18 +13,12 @@
 static QmpCommandList qmp_commands;
=20
 #if defined(TEST_IF_STRUCT) && defined(TEST_IF_CMD)
-UserDefThree *qmp_TestIfCmd(TestIfStruct *foo, Error **errp)
-void qmp_TestIfCmd(TestIfStruct *foo, Error **errp)
+char *qmp_TestIfCmd(TestIfStruct *foo, Error **errp)
 {
     return NULL;
 }
 #endif
=20
-UserDefThree *qmp_TestCmdReturnDefThree(Error **errp)
-{
-    return NULL;
-}
-
 void qmp_user_def_cmd(Error **errp)
 {
 }
