Received: from eggs.gnu.org ([2001:4830:134:3::10]:44534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ej28z-0005JH-1I
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:14:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ej28u-0003FM-2q
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:14:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ej28t-0003Et-Qs
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:14:32 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
	<20180111213250.16511-7-marcandre.lureau@redhat.com>
	<874lmue89l.fsf@dusky.pond.sub.org>
	<CAJ+F1CKqrfDRHNqEGm6vVZ0kePPw4=4k1EC-v3rqhaqP+TxQKA@mail.gmail.com>
Date: Tue, 06 Feb 2018 13:14:29 +0100
In-Reply-To: <CAJ+F1CKqrfDRHNqEGm6vVZ0kePPw4=4k1EC-v3rqhaqP+TxQKA@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 6 Feb 2018
	12:06:18 +0100")
Message-ID: <87k1vqb9i2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Tue, Feb 6, 2018 at 11:12 AM, Markus Armbruster <armbru@redhat.com> wr=
ote:
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>>> Built-in objects remain unconditional.  Explicitly defined objects
>>> use the condition specified in the schema.  Implicitly defined
>>> objects inherit their condition from their users.  For most of them,
>>> there is exactly one user, so the condition to use is obvious.  The
>>> exception is the wrapped type's generated for simple union variants,
>>> which can be shared by any number of simple unions.  The tight
>>> condition would be the disjunction of the conditions of these simple
>>> unions.  For now, use wrapped type's condition instead.  Much
>>> simpler and good enough for now.
>>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>  scripts/qapi.py | 98 ++++++++++++++++++++++++++++++++++++++-----------=
--------
>>>  1 file changed, 66 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/scripts/qapi.py b/scripts/qapi.py
>>> index 27df0fcf48..8f54dead8d 100644
>>> --- a/scripts/qapi.py
>>> +++ b/scripts/qapi.py
>>> @@ -991,8 +991,17 @@ def check_exprs(exprs):
>>>  # Schema compiler frontend
>>>  #
>>>
>>> +def listify_cond(ifcond):
>>> +    if not ifcond:
>>> +        return []
>>> +    elif not isinstance(ifcond, list):
>>> +        return [ifcond]
>>> +    else:
>>> +        return ifcond
>>
>> pylint complains:
>>
>>     R:995, 4: Unnecessary "else" after "return" (no-else-return)
>>
>> Matter of taste.  Mine happens to agree with pylint's.  Suggest:
>>
>>    def listify_cond(ifcond):
>>        if not ifcond:
>>            return []
>>        if not isinstance(ifcond, list):
>>            return [ifcond]
>>        return ifcond
>>
>
> There are so many errors with pylint, that I don't bother running it.

pylint reports lots of stuff that is actually just fine.

> How did you notice? you run diff of error output between commits?

Yes.

> pycodestyle --diff is more convenient, and silent on this code.

Formerly known as pep8.  Confusingly, Fedora 26 packages both
separately.  Thanks for the pointer.

> Feel free to touch if you pick the patch.

Okay.

>>> +
>>> +
>>>  class QAPISchemaEntity(object):
>>> -    def __init__(self, name, info, doc):
>>> +    def __init__(self, name, info, doc, ifcond=3DNone):
>>>          assert isinstance(name, str)
>>>          self.name =3D name
>>>          # For explicitly defined entities, info points to the (explici=
t)
>> [...]
>>
