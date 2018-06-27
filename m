Received: from eggs.gnu.org ([2001:4830:134:3::10]:39389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fY9Jo-0007Tq-71
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:13:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fY9Jn-0005Ww-7M
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:13:04 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:39471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fY9Jm-0005WA-Ve
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:13:03 -0400
Received: by mail-wr0-x242.google.com with SMTP id b8-v6so1806848wro.6
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 05:13:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87zhzndz12.fsf@dusky.pond.sub.org>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
	<20180321115211.17937-16-marcandre.lureau@redhat.com>
	<87zhzndz12.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 27 Jun 2018 14:13:01 +0200
Message-ID: <CAJ+F1CJAGPY6dbt-T50ERmO0=wVY2PrSPz0tZnWDZuabMiG8+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 15/49] qapi: do not define enumeration
 value explicitely
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Fri, Jun 22, 2018 at 10:08 AM, Markus Armbruster <armbru@redhat.com> wro=
te:
> Subject: explicitly
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> The C standard has the initial value at 0 and the subsequent values
>> incremented by 1. No need to set this explicitely.
>>
>> This will prevent from artificial "gaps" when compiling out some enum
>> values and having unnecessarily large MAX values & enums arrays.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  scripts/qapi/common.py | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
>> index 60c1d0a783..68a567f53f 100644
>> --- a/scripts/qapi/common.py
>> +++ b/scripts/qapi/common.py
>> @@ -2032,14 +2032,11 @@ typedef enum %(c_name)s {
>>  ''',
>>                  c_name=3Dc_name(name))
>>
>> -    i =3D 0
>>      for value in enum_values:
>>          ret +=3D mcgen('''
>> -    %(c_enum)s =3D %(i)d,
>> +    %(c_enum)s,
>>  ''',
>> -                     c_enum=3Dc_enum_const(name, value, prefix),
>> -                     i=3Di)
>> -        i +=3D 1
>> +                     c_enum=3Dc_enum_const(name, value, prefix))
>>
>>      ret +=3D mcgen('''
>>  } %(c_name)s;
>
> What excactly in your series depends on this?
>
> What safeguards do you propose to ensure an enumeration with
> conditionals is compiled only with the exact same conditionals within
> the same program?
>
> Example of the kind of deathtrap to guard against: compile
>
>     typedef enum Color {
>         COLOR_WHITE,
> #if defined(NEED_CPU_H)
> #if defined(TARGET_S390X)
>         COLOR_BLUE,
> #endif /* defined(TARGET_S390X) */
> #endif /* defined(NEED_CPU_H) */
>         COLOR_BLACK,
>     } Color;
>
> in s390x-code (COLOR_BLACK =3D 2) and in target-independent code
> (COLOR_BLACK =3D 1), then linking the two together.

This was a trick used in previous iterations. Now that we have a
separate target schema and generated code/headers, and since we have
poisoned identifiers, this should never happen.

> Yes, I know a similar deathtrap will be set up for struct and union
> types.  No excuse for ignoring either of the two.

Having gaps in the enums makes it harder to iterate over all values,
and we use more memory than necessary when allocating based on MAX
value.

It's not a big problem, but I consider this more important than this
artificially made up broken build example.

--=20
Marc-Andr=C3=A9 Lureau
