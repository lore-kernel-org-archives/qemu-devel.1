Received: from eggs.gnu.org ([2001:4830:134:3::10]:35349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fXRLE-0002Jr-1H
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fXRL9-0002ul-V7
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:15:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33292 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fXRL9-0002ub-QS
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:15:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 72ABD7C6A9
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 13:15:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
	<20180321115211.17937-12-marcandre.lureau@redhat.com>
	<87sh5fdxth.fsf@dusky.pond.sub.org>
Date: Mon, 25 Jun 2018 15:15:30 +0200
In-Reply-To: <87sh5fdxth.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Fri, 22 Jun 2018 10:34:18 +0200")
Message-ID: <87o9fzror1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 11/49] qapi/commands: add #if conditions
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
Cc: qemu-devel@nongnu.org

Markus Armbruster <armbru@redhat.com> writes:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Wrap generated code with #if/#endif using an 'ifcontext' on
>> QAPIGenCSnippet objects.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  scripts/qapi/commands.py | 19 ++++++++++---------
>>  tests/test-qmp-cmds.c    |  4 ++--
>>  2 files changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
>> index e2366b4801..40bb680b7c 100644
>> --- a/scripts/qapi/commands.py
>> +++ b/scripts/qapi/commands.py
>> @@ -237,7 +237,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaModularC=
Visitor):
>>          QAPISchemaModularCVisitor.__init__(
>>              self, prefix, 'qapi-commands',
>>              ' * Schema-defined QAPI/QMP commands', __doc__)
>> -        self._regy =3D ''
>> +        self._regy =3D QAPIGenCSnippet()
>>          self._visited_ret_types =3D {}
>>=20=20
>>      def _begin_module(self, name):
>> @@ -273,19 +273,20 @@ class QAPISchemaGenCommandVisitor(QAPISchemaModula=
rCVisitor):
>>  void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
>>  ''',
>>                         c_prefix=3Dc_name(self._prefix, protect=3DFalse)=
))
>> -        genc.add(gen_registry(self._regy, self._prefix))
>> +        genc.add(gen_registry(self._regy.get_content(), self._prefix))
>>=20=20
>>      def visit_command(self, name, info, ifcond, arg_type, ret_type,
>>                        gen, success_response, boxed, allow_oob):
>>          if not gen:
>>              return
>> -        self._genh.add(gen_command_decl(name, arg_type, boxed, ret_type=
))
>> -        if ret_type and ret_type not in self._visited_ret_types[self._g=
enc]:
>> -            self._visited_ret_types[self._genc].add(ret_type)
>> -            self._genc.add(gen_marshal_output(ret_type))
>> -        self._genh.add(gen_marshal_decl(name))
>> -        self._genc.add(gen_marshal(name, arg_type, boxed, ret_type))
>> -        self._regy +=3D gen_register_command(name, success_response, al=
low_oob)
>> +        with ifcontext(ifcond, self._genh, self._genc, self._regy):
>> +            self._genh.add(gen_command_decl(name, arg_type, boxed, ret_=
type))
>> +            if ret_type and ret_type not in self._visited_ret_types[sel=
f._genc]:
>> +                self._visited_ret_types[self._genc].add(ret_type)
>> +                self._genc.add(gen_marshal_output(ret_type))
>
> I'm afraid this falls apart when multiple commands with different
> conditions share a return type.

If you'd rather fix this later, we can consider just documenting the bug
for now.

> That case needs test coverage.

Needed regardless.

[...]
