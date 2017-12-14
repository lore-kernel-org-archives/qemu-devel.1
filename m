Received: from eggs.gnu.org ([2001:4830:134:3::10]:50410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ePU3c-00051J-IA
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:00:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ePU3b-00030y-Cq
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:00:16 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:40765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ePU3a-0002ys-NI
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:00:15 -0500
Received: by mail-wm0-x22a.google.com with SMTP id f206so11553396wmf.5
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 06:00:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87zi6lza7i.fsf@dusky.pond.sub.org>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-42-marcandre.lureau@redhat.com>
	<87zi6lza7i.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 14 Dec 2017 15:00:12 +0100
Message-ID: <CAJ+F1CLe-=UOtVSN+Pnou1uOVF+sDqus3KUdJfNO5oa+VZt2=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 41/50] qapi: add a 'unit' pragma
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

Hi

On Thu, Dec 14, 2017 at 2:54 PM, Markus Armbruster <armbru@redhat.com> wrot=
e:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Add a pragma that allows to tag the following expressions with a unit
>> name. By default, an expression has no unit name.
>
> Please explain the unit name's intended purpose.
>

It's syccintly explained in the doc.

>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  scripts/qapi.py              | 9 ++++++++-
>>  docs/devel/qapi-code-gen.txt | 3 +++
>>  2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/qapi.py b/scripts/qapi.py
>> index eb4ffdc06d..1d0defd638 100644
>> --- a/scripts/qapi.py
>> +++ b/scripts/qapi.py
>> @@ -279,10 +279,12 @@ class QAPISchemaParser(object):
>>          self.docs =3D []
>>          self.cur_doc =3D None
>>          self.accept()
>> +        self.unit =3D None
>>
>>          while self.tok is not None:
>>              info =3D {'file': fname, 'line': self.line,
>> -                    'parent': self.incl_info}
>> +                    'parent': self.incl_info,
>> +                    'unit': self.unit}
>>              if self.tok =3D=3D '#':
>>                  self.reject_expr_doc()
>>                  self.cur_doc =3D self.get_doc(info)
>> @@ -371,6 +373,11 @@ class QAPISchemaParser(object):
>>                                     "Pragma name-case-whitelist must be"
>>                                     " a list of strings")
>>              name_case_whitelist =3D value
>> +        elif name =3D=3D 'unit':
>> +            if not isinstance(value, str):
>> +                raise QAPISemError(info,
>> +                                   "Pragma 'unit' must be string")
>> +            self.unit =3D value
>>          else:
>>              raise QAPISemError(info, "Unknown pragma '%s'" % name)
>>
>> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
>> index 24fc6f74ee..37a27cd9d7 100644
>> --- a/docs/devel/qapi-code-gen.txt
>> +++ b/docs/devel/qapi-code-gen.txt
>> @@ -326,6 +326,9 @@ violate the rules on permitted return types.  Defaul=
t is none.
>>  Pragma 'name-case-whitelist' takes a list of names that may violate
>>  rules on use of upper- vs. lower-case letters.  Default is none.
>>
>> +Pragma 'unit' takes a string value. It will set the unit name for the
>> +following expressions in the schema. Most code generator can filter
>> +based on a unit name. Default is none.
>
> Do you mean "most code generators"?

The qapi code/doc generators.

>
> What does "filtering" mean?

To be able to select a subset of expressions based on the unit name.

>>
>>  =3D=3D=3D Struct types =3D=3D=3D
>
> Humor me: put two spaces after a sentence-ending period.
>

I don't get what you mean.

thanks

--=20
Marc-Andr=C3=A9 Lureau
