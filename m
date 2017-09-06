Received: from eggs.gnu.org ([2001:4830:134:3::10]:49796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dpauJ-00050G-LH
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dpauA-0000LK-93
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:02:19 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:37261)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dpauA-0000KC-3Y
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:02:10 -0400
Received: by mail-oi0-x244.google.com with SMTP id h70so4482926oic.4
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 07:02:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87fuc11nxs.fsf@dusky.pond.sub.org>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-21-marcandre.lureau@redhat.com>
	<87fuc11nxs.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 6 Sep 2017 16:02:07 +0200
Message-ID: <CAJ+F1CLNcMYkYvA0ZO+oN7z=nmYEMmLajCnU1uuG1+DocFQzvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 20/54] qapi-introspect: modify to_qlit()
 to take an optional suffix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Tue, Sep 5, 2017 at 11:42 AM, Markus Armbruster <armbru@redhat.com> wrot=
e:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> The following patch is going to break list entries with #if/#endif, so
>> they should have the trailing ',' as suffix.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  scripts/qapi-introspect.py | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
>> index 4c437d60ec..dfb6d2ded4 100644
>> --- a/scripts/qapi-introspect.py
>> +++ b/scripts/qapi-introspect.py
>> @@ -16,7 +16,7 @@ def to_c_string(s):
>>      return '"' + s.replace('\\', r'\\').replace('"', r'\"') + '"'
>>
>>
>> -def to_qlit(obj, level=3D0, first_indent=3DTrue):
>> +def to_qlit(obj, level=3D0, first_indent=3DTrue, suffix=3D''):
>>
>>      def indent(level):
>>          return level * 4 * ' '
>> @@ -29,11 +29,11 @@ def to_qlit(obj, level=3D0, first_indent=3DTrue):
>>      elif isinstance(obj, str):
>>          ret +=3D 'QLIT_QSTR(' + to_c_string(obj) + ')'
>>      elif isinstance(obj, list):
>> -        elts =3D [to_qlit(elt, level + 1)
>> +        elts =3D [to_qlit(elt, level + 1, suffix=3D',')
>>                  for elt in obj]
>>          elts.append(indent(level + 1) + "{}")
>>          ret +=3D 'QLIT_QLIST(((QLitObject[]) {\n'
>> -        ret +=3D ',\n'.join(elts) + '\n'
>> +        ret +=3D '\n'.join(elts) + '\n'
>>          ret +=3D indent(level) + '}))'
>>      elif isinstance(obj, dict):
>>          elts =3D []
>> @@ -46,7 +46,7 @@ def to_qlit(obj, level=3D0, first_indent=3DTrue):
>>          ret +=3D indent(level) + '}))'
>>      else:
>>          assert False                # not implemented
>> -    return ret
>> +    return ret + suffix
>>
>>
>>  class QAPISchemaGenIntrospectVisitor(QAPISchemaVisitor):
>
> Hmm.  I wonder the appended simpler patch would do.

It works, thanks for the suggestion

>
> diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
> index 4c437d60ec..73edb55cd5 100644
> --- a/scripts/qapi-introspect.py
> +++ b/scripts/qapi-introspect.py
> @@ -33,7 +33,7 @@ def to_qlit(obj, level=3D0, first_indent=3DTrue):
>                  for elt in obj]
>          elts.append(indent(level + 1) + "{}")
>          ret +=3D 'QLIT_QLIST(((QLitObject[]) {\n'
> -        ret +=3D ',\n'.join(elts) + '\n'
> +        ret +=3D '\n'.join(elts) + '\n'
>          ret +=3D indent(level) + '}))'
>      elif isinstance(obj, dict):
>          elts =3D []
> @@ -46,6 +46,8 @@ def to_qlit(obj, level=3D0, first_indent=3DTrue):
>          ret +=3D indent(level) + '}))'
>      else:
>          assert False                # not implemented
> +    if level > 0:
> +        ret +=3D ','
>      return ret
>
>
>



--=20
Marc-Andr=C3=A9 Lureau
