Received: from eggs.gnu.org ([2001:4830:134:3::10]:55837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1faL6B-0008Id-T8
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 09:12:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1faL65-0007Te-TP
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 09:12:03 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:44265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1faL65-0007SP-Lq
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 09:11:57 -0400
Received: by mail-wr0-x244.google.com with SMTP id p12-v6so1921319wrn.11
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 06:11:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87efgkbjwc.fsf@dusky.pond.sub.org>
References: <20180627163551.31610-1-marcandre.lureau@redhat.com>
	<20180627163551.31610-10-marcandre.lureau@redhat.com>
	<87efgkbjwc.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 3 Jul 2018 15:11:55 +0200
Message-ID: <CAJ+F1C+7PNgM=Qq4d4HmG6VfneML6WGPbhh68WwReUicE1B_JA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 09/15] qapi-introspect: add preprocessor
 conditions to generated QLit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi

On Tue, Jul 3, 2018 at 2:09 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> The generator will take (obj, condition) tuples to wrap generated QLit
>> objects for 'obj' with #if/#endif conditions.
>>
>> This commit adds 'ifcond' condition to top-level QLit objects.
>>
>> See generated tests/test-qmp-introspect.c. Example diff after this patch=
:
>>
>>     --- before        2018-01-08 11:55:24.757083654 +0100
>>     +++ tests/test-qmp-introspect.c   2018-01-08 13:08:44.477641629 +010=
0
>>     @@ -51,6 +51,8 @@
>>              { "name", QLIT_QSTR("EVENT_F"), },
>>              {}
>>          })),
>>     +#if defined(TEST_IF_CMD)
>>     +#if defined(TEST_IF_STRUCT)
>>          QLIT_QDICT(((QLitDictEntry[]) {
>>              { "arg-type", QLIT_QSTR("5"), },
>>              { "meta-type", QLIT_QSTR("command"), },
>>     @@ -58,12 +60,16 @@
>>              { "ret-type", QLIT_QSTR("0"), },
>>              {}
>>          })),
>>     +#endif /* defined(TEST_IF_STRUCT) */
>>     +#endif /* defined(TEST_IF_CMD) */
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  scripts/qapi/introspect.py | 31 +++++++++++++++++++++----------
>>  1 file changed, 21 insertions(+), 10 deletions(-)
>>
>> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
>> index bd7e1219be..71d4a779ce 100644
>> --- a/scripts/qapi/introspect.py
>> +++ b/scripts/qapi/introspect.py
>> @@ -18,6 +18,15 @@ def to_qlit(obj, level=3D0, suppress_first_indent=3DF=
alse):
>>      def indent(level):
>>          return level * 4 * ' '
>>
>> +    if isinstance(obj, tuple):
>> +        ifobj, ifcond =3D obj
>> +        ret =3D gen_if(ifcond)
>> +        ret +=3D to_qlit(ifobj, level)
>> +        endif =3D gen_endif(ifcond)
>> +        if endif:
>> +            ret +=3D '\n' + endif
>> +        return ret
>> +
>>      ret =3D ''
>>      if not suppress_first_indent:
>>          ret +=3D indent(level)
>
> @obj represents a JSON object.  It consists of dictionaries, lists,
> strings, booleans and None.  Numbers aren't implemented.  Your patch
> splices in tuples to represent conditionals at any level.
>
> So far, tuples occur only as elements of the outermost list (see
> ._gen_qlit() below), but to_qlit() supports them anywhere.  I figure
> that will be needed later.  Can you point me to such a later use?

It's added in the introspect.py part from "qapi: add #if conditions to
generated code members"




--=20
Marc-Andr=C3=A9 Lureau
