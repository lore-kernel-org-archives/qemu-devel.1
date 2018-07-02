Received: from eggs.gnu.org ([2001:4830:134:3::10]:33145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa3na-0000XH-B7
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa3nX-0008Vc-8R
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:43:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51160 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fa3nX-0008VF-2G
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:43:39 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180629195544.34263-1-eblake@redhat.com>
	<20180629195544.34263-2-eblake@redhat.com>
	<ed5d831b-2035-74b5-b12a-01f443c8a896@redhat.com>
Date: Mon, 02 Jul 2018 20:43:34 +0200
In-Reply-To: <ed5d831b-2035-74b5-b12a-01f443c8a896@redhat.com> (Eric Blake's
	message of "Fri, 29 Jun 2018 15:09:06 -0500")
Message-ID: <87va9x8omh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] qapi: Add comments to aid debugging
 generated introspection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, armbru@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>

Eric Blake <eblake@redhat.com> writes:

> On 06/29/2018 02:55 PM, Eric Blake wrote:
>> We consciously chose in commit 1a9a507b to hide QAPI type names
>> from the generated introspection output, but added a command line
>> option -u to unmask the type name when doing a debug build.  At
>> that time, we generated a monolithic C string, so there was no
>> better way to do things (we could not really inject comments).
>>
>> Later, in commit 7d0f982b, we switched the generation to output
>> a QLit object, in part to make it easier for future addition of
>> conditional compilation.  But this switch has also made it easier
>> to interject strategic comments.  That commit also forgot to
>> delete some now-stale comments about long generated line lengths.
>>
>> For now, type name debug aid comments are only output once per
>> meta-type, rather than at all uses of the number used to encode
>> the type to the introspection data.  But this is still a lot
>> more convenient than having to regenerate the file with the
>> unmask operation temporarily turned on.
> ...
>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>   scripts/qapi/introspect.py | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>
> Misses a change to docs/devel/qapi-code.gen.tx:
>
> diff --git i/docs/devel/qapi-code-gen.txt w/docs/devel/qapi-code-gen.txt
> index 88a70e4d451..0c98c7d7b6c 100644
> --- i/docs/devel/qapi-code-gen.txt
> +++ w/docs/devel/qapi-code-gen.txt
> @@ -1392,6 +1392,7 @@ Example:
>              { }
>          })),
>          QLIT_QDICT(((QLitDictEntry[]) {
> +            /* q_empty */
>              { "members", QLIT_QLIST(((QLitObject[]) {
>                  { }
>              })) },

Yes.

>> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
>> index 6ad198ae5b5..b37160292bc 100644
>> --- a/scripts/qapi/introspect.py
>> +++ b/scripts/qapi/introspect.py
>> @@ -35,10 +35,14 @@ def to_qlit(obj, level=3D0, suppress_first_indent=3D=
False):
>>      elif isinstance(obj, dict):
>>          elts =3D []
>>          for key, value in sorted(obj.items()):
>> +            if key =3D=3D 'comment':
>> +                continue
>>              elts.append(indent(level + 1) + '{ %s, %s }' %
>>                          (to_c_string(key), to_qlit(value, level + 1, Tr=
ue)))
>>          elts.append(indent(level + 1) + '{}')
>>          ret +=3D 'QLIT_QDICT(((QLitDictEntry[]) {\n'
>> +        if obj.get('comment'):
>> +            ret +=3D indent(level + 1) + '/* %s */\n' % obj['comment']
>>          ret +=3D ',\n'.join(elts) + '\n'
>>          ret +=3D indent(level) + '}))'
>>      elif isinstance(obj, bool):

to_qlit() converts from a natural representation of JSON in Python to
JSON text.

Your patch breaks it for JSON objects that have a member named
'comment'.

Related work: Marc-Andr=C3=A9's "[PATCH v6 09/15] qapi-introspect: add
preprocessor conditions to generated QLit" uses tuples to augment JSON.
He uses them for conditionals, but the technique could be generalized,
say from his (jobj, ifcond) to (jobj, { 'if': ifcond, '#': comment }.

>> @@ -78,7 +82,6 @@ class QAPISchemaGenIntrospectVisitor(QAPISchemaMonolit=
hicCVisitor):
>>          for typ in self._used_types:
>>              typ.visit(self)
>>          # generate C
>> -        # TODO can generate awfully long lines
>>          name =3D c_name(self._prefix, protect=3DFalse) + 'qmp_schema_ql=
it'
>>          self._genh.add(mcgen('''
>>  #include "qapi/qmp/qlit.h"
>> @@ -118,8 +121,8 @@ const QLitObject %(c_name)s =3D %(c_string)s;
>>           if typ not in self._used_types:
>>               self._used_types.append(typ)
>>          # Clients should examine commands and events, not types.  Hide
>> -        # type names to reduce the temptation.  Also saves a few
>> -        # characters.
>> +        # type names as integers to reduce the temptation, but provide
>> +        # comments for debugging aid.
>
> When I wrote the patch, I assumed the final sentence of the comment
> was talking about fewer characters in the generated .c file (I nuked
> it, since adding comments makes for a longer, not shorter, generated
> .c file); but now that I'm writing this email, I see it could also
> refer to fewer characters sent over the wire in the QMP command (which

Yes, that was my intent.

> length is unchanged by this patch, but was a 13KiB savings compared to
> the unmasked version, per commit 1a9a507b).  So feel free to bikeshed
> this comment.

I think I'd merely clarify the comment's last sentence by adding "on the
wire", ...

>>          if isinstance(typ, QAPISchemaBuiltinType):
>>              return typ.name
>>          if isinstance(typ, QAPISchemaArrayType):
>> @@ -128,6 +131,8 @@ const QLitObject %(c_name)s =3D %(c_string)s;
>>=20
>>      def _gen_qlit(self, name, mtype, obj):
>>          if mtype not in ('command', 'event', 'builtin', 'array'):
>> +            if not self._unmask:

... and perhaps briefly explain here why we generate a comment.

>> +                obj['comment'] =3D name
>>              name =3D self._name(name)
>>          obj['name'] =3D name
>>          obj['meta-type'] =3D mtype
