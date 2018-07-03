Received: from eggs.gnu.org ([2001:4830:134:3::10]:55184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faMvn-0007zT-5B
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:09:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faMvj-0003S3-4J
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:09:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35282 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faMvi-0003Ro-UO
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:09:23 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180627163551.31610-1-marcandre.lureau@redhat.com>
	<20180627163551.31610-11-marcandre.lureau@redhat.com>
	<87va9w8jnb.fsf@dusky.pond.sub.org>
Date: Tue, 03 Jul 2018 17:09:18 +0200
In-Reply-To: <87va9w8jnb.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Tue, 03 Jul 2018 16:43:20 +0200")
Message-ID: <87po0473vl.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, "Dr.
	David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Markus Armbruster <armbru@redhat.com> writes:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Wrap generated code with #if/#endif using an 'ifcontext' on
>> QAPIGenCSnippet objects.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  scripts/qapi/commands.py | 21 ++++++++++++---------
>>  tests/test-qmp-cmds.c    |  5 +++--
>>  2 files changed, 15 insertions(+), 11 deletions(-)
>>
>> diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
>> index dcc03c7859..72749c7fc5 100644
>> --- a/scripts/qapi/commands.py
>> +++ b/scripts/qapi/commands.py
>> @@ -239,7 +239,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaModularC=
Visitor):
>>          QAPISchemaModularCVisitor.__init__(
>>              self, prefix, 'qapi-commands',
>>              ' * Schema-defined QAPI/QMP commands', __doc__)
>> -        self._regy =3D ''
>> +        self._regy =3D QAPIGenCCode()
>>          self._visited_ret_types =3D {}
>>=20=20
>>      def _begin_module(self, name):
>> @@ -275,20 +275,23 @@ class QAPISchemaGenCommandVisitor(QAPISchemaModula=
rCVisitor):
>>  void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
>>  ''',
>>                         c_prefix=3Dc_name(self._prefix, protect=3DFalse)=
))
>> -        genc.add(gen_registry(self._regy, self._prefix))
>> +        genc.add(gen_registry(self._regy.get_content(), self._prefix))
>>=20=20
>>      def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
>>                        success_response, boxed, allow_oob, allow_preconf=
ig):
>>          if not gen:
>>              return
>> -        self._genh.add(gen_command_decl(name, arg_type, boxed, ret_type=
))
>> -        if ret_type and ret_type not in self._visited_ret_types[self._g=
enc]:
>> +        if ret_type and \
>> +           ret_type not in self._visited_ret_types[self._genc]:
>
> PEP8 prefers parenthesis over backslash.  Can touch this up when I
> apply.
>
>>              self._visited_ret_types[self._genc].add(ret_type)
>> -            self._genc.add(gen_marshal_output(ret_type))
>> -        self._genh.add(gen_marshal_decl(name))
>> -        self._genc.add(gen_marshal(name, arg_type, boxed, ret_type))
>> -        self._regy +=3D gen_register_command(name, success_response, al=
low_oob,
>> -                                           allow_preconfig)
>> +            with ifcontext(ret_type.ifcond, self._genh, self._genc, sel=
f._regy):
>> +                self._genc.add(gen_marshal_output(ret_type))
>> +        with ifcontext(ifcond, self._genh, self._genc, self._regy):
>> +            self._genh.add(gen_command_decl(name, arg_type, boxed, ret_=
type))
>> +            self._genh.add(gen_marshal_decl(name))
>> +            self._genc.add(gen_marshal(name, arg_type, boxed, ret_type))
>> +            self._regy.add(gen_register_command(name, success_response,
>> +                                                allow_oob, allow_precon=
fig))
>
> Okay, now it falls apart differently :)  Let's step through the code
> real slow.
>
> The first time we visit a command C returning type T...
>
>         if ret_type and \
>            ret_type not in self._visited_ret_types[self._genc]:
>             self._visited_ret_types[self._genc].add(ret_type)
>             with ifcontext(ret_type.ifcond, self._genh, self._genc, self.=
_regy):
>                 self._genc.add(gen_marshal_output(ret_type))
>
> ... we generate qmp_marshal_output_T() wrapped in T's condition.
>
>         with ifcontext(ifcond, self._genh, self._genc, self._regy):
>             self._genh.add(gen_command_decl(name, arg_type, boxed, ret_ty=
pe))
>             self._genh.add(gen_marshal_decl(name))
>             self._genc.add(gen_marshal(name, arg_type, boxed, ret_type))
>             self._regy.add(gen_register_command(name, success_response,
>                                                 allow_oob, allow_preconfi=
g))
>
> We generate qmp_marshal_C() wrapped in C's condition.  This is what
> calls qmp_marshal_output_T().
>
> If T is a user-defined type, the user is responsible for making this
> work, i.e. to make T's condition the conjunction of the T-returning
> commands' conditions.
>
> If T is a built-in type, this isn't possible: the qmp_marshal_output_T()
> will be generated unconditionally.
>
> I append a crude patch to provide test coverage (crude because it
> removes coverage of another case).  With it applied, make check dies
> with
>
>     tests/test-qapi-commands.c:470:13: warning: =E2=80=98qmp_marshal_outp=
ut_str=E2=80=99 defined but not used [-Wunused-function]
>
> I think the issue is obscure enough to justify postponing a proper fix,
> and just add a FIXME here now.  I can do that when I apply.

With the PEP8 tweak and a suitable FIXME
Reviewed-by: Markus Armbruster <armbru@redhat.com>
