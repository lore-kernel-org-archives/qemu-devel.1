Received: from eggs.gnu.org ([2001:4830:134:3::10]:40432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eihwq-0008E0-GE
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:40:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eihwm-0001JO-EJ
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:40:44 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:35452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eihwm-0001JA-90
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:40:40 -0500
Received: by mail-qt0-f181.google.com with SMTP id g14so39856779qti.2
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 06:40:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87mv0nv73y.fsf@dusky.pond.sub.org>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-15-armbru@redhat.com>
	<CAMxuvayFe8fU5PMyX00k2tM=2-=ZQqsxd1PwMUxAFAx26chFRA@mail.gmail.com>
	<87mv0nv73y.fsf@dusky.pond.sub.org>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Mon, 5 Feb 2018 15:40:39 +0100
Message-ID: <CAMxuvaw7i8UssX=-kCSRAPaq7b74pY2++aWk4AgD3kwv3C0yKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 14/21] qapi: Generate in source order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: marcandre <marcandre.lureau@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, mdroth@linux.vnet.ibm.com

On Mon, Feb 5, 2018 at 3:33 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Marc-Andre Lureau <mlureau@redhat.com> writes:
>
>> On Fri, Feb 2, 2018 at 2:03 PM, Markus Armbruster <armbru@redhat.com> wr=
ote:
>>> The generators' conversion to visitors (merge commit 9e72681d16)
>>> changed the processing order of entities from source order to
>>> alphabetical order.  The next commit needs source order, so change it
>>> back.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>  scripts/qapi/common.py                   |   4 +-
>>>  tests/qapi-schema/comments.out           |   2 +-
>>>  tests/qapi-schema/doc-bad-section.out    |   4 +-
>>>  tests/qapi-schema/doc-good.out           |  32 ++--
>>>  tests/qapi-schema/empty.out              |   2 +-
>>>  tests/qapi-schema/event-case.out         |   2 +-
>>>  tests/qapi-schema/ident-with-escape.out  |   6 +-
>>>  tests/qapi-schema/include-relpath.out    |   2 +-
>>>  tests/qapi-schema/include-repetition.out |   2 +-
>>>  tests/qapi-schema/include-simple.out     |   2 +-
>>>  tests/qapi-schema/indented-expr.out      |   2 +-
>>>  tests/qapi-schema/qapi-schema-test.out   | 320 +++++++++++++++--------=
--------
>>>  12 files changed, 191 insertions(+), 189 deletions(-)
>>>
>>> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
>>> index d5b93e7381..3b97bf8702 100644
>>> --- a/scripts/qapi/common.py
>>> +++ b/scripts/qapi/common.py
>>> @@ -1471,6 +1471,7 @@ class QAPISchema(object):
>>>          parser =3D QAPISchemaParser(open(fname, 'r'))
>>>          exprs =3D check_exprs(parser.exprs)
>>>          self.docs =3D parser.docs
>>> +        self._entity_list =3D []
>>>          self._entity_dict =3D {}
>>>          self._predefining =3D True
>>>          self._def_predefineds()
>>> @@ -1482,6 +1483,7 @@ class QAPISchema(object):
>>>          # Only the predefined types are allowed to not have info
>>>          assert ent.info or self._predefining
>>>          assert ent.name not in self._entity_dict
>>> +        self._entity_list.append(ent)
>>>          self._entity_dict[ent.name] =3D ent
>>
>> Why not use the OrderedDict instead?
>
> Fair question!  However, the next patch will create anonymous entities,
> which get added only to ._entity_list, not _entity_dict.

I see, something we could improve or clarify, but that's ok to me as is:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>
> [...]
