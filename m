Received: from eggs.gnu.org ([2001:4830:134:3::10]:55540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ej14y-0000rX-8q
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:06:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ej14u-0001UA-6a
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:06:24 -0500
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:47023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ej14t-0001To-Vk
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:06:20 -0500
Received: by mail-wr0-x229.google.com with SMTP id 35so1434723wrb.13
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 03:06:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <874lmue89l.fsf@dusky.pond.sub.org>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
	<20180111213250.16511-7-marcandre.lureau@redhat.com>
	<874lmue89l.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 6 Feb 2018 12:06:18 +0100
Message-ID: <CAJ+F1CKqrfDRHNqEGm6vVZ0kePPw4=4k1EC-v3rqhaqP+TxQKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 06/51] qapi: pass 'if' condition into
 QAPISchemaEntity objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>, QEMU <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

Hi

On Tue, Feb 6, 2018 at 11:12 AM, Markus Armbruster <armbru@redhat.com> wrot=
e:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Built-in objects remain unconditional.  Explicitly defined objects
>> use the condition specified in the schema.  Implicitly defined
>> objects inherit their condition from their users.  For most of them,
>> there is exactly one user, so the condition to use is obvious.  The
>> exception is the wrapped type's generated for simple union variants,
>> which can be shared by any number of simple unions.  The tight
>> condition would be the disjunction of the conditions of these simple
>> unions.  For now, use wrapped type's condition instead.  Much
>> simpler and good enough for now.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  scripts/qapi.py | 98 ++++++++++++++++++++++++++++++++++++++------------=
-------
>>  1 file changed, 66 insertions(+), 32 deletions(-)
>>
>> diff --git a/scripts/qapi.py b/scripts/qapi.py
>> index 27df0fcf48..8f54dead8d 100644
>> --- a/scripts/qapi.py
>> +++ b/scripts/qapi.py
>> @@ -991,8 +991,17 @@ def check_exprs(exprs):
>>  # Schema compiler frontend
>>  #
>>
>> +def listify_cond(ifcond):
>> +    if not ifcond:
>> +        return []
>> +    elif not isinstance(ifcond, list):
>> +        return [ifcond]
>> +    else:
>> +        return ifcond
>
> pylint complains:
>
>     R:995, 4: Unnecessary "else" after "return" (no-else-return)
>
> Matter of taste.  Mine happens to agree with pylint's.  Suggest:
>
>    def listify_cond(ifcond):
>        if not ifcond:
>            return []
>        if not isinstance(ifcond, list):
>            return [ifcond]
>        return ifcond
>

There are so many errors with pylint, that I don't bother running it.
How did you notice? you run diff of error output between commits?

pycodestyle --diff is more convenient, and silent on this code.

Feel free to touch if you pick the patch.

>> +
>> +
>>  class QAPISchemaEntity(object):
>> -    def __init__(self, name, info, doc):
>> +    def __init__(self, name, info, doc, ifcond=3DNone):
>>          assert isinstance(name, str)
>>          self.name =3D name
>>          # For explicitly defined entities, info points to the (explicit=
)
> [...]
>



--=20
Marc-Andr=C3=A9 Lureau
