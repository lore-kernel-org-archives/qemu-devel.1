Received: from eggs.gnu.org ([2001:4830:134:3::10]:57505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkCE3-0003R0-Pc
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 12:40:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkCE0-0006VS-KU
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 12:40:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dkCE0-0006Uz-BU
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 12:40:20 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-2-marcandre.lureau@redhat.com>
	<87h8wz8x5u.fsf@dusky.pond.sub.org>
	<494634424.1900896.1503417013134.JavaMail.zimbra@redhat.com>
Date: Tue, 22 Aug 2017 18:40:15 +0200
In-Reply-To: <494634424.1900896.1503417013134.JavaMail.zimbra@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 22 Aug 2017
	11:50:13 -0400 (EDT)")
Message-ID: <87pobnfte8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/54] qapi: fix type_seen key error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> ----- Original Message -----
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>=20
>> > The type_seen member can be of a different type than the 'qtype' being
>> > checked, since a string create several conflicts. Lookup the real
>> > conflicting type in the conflict set, that one must be present in
>> > type_seen.
>> >
>> > This fixes the following error, reproducible with the modified test:
>> >
>> > Traceback (most recent call last):
>> >   File "/home/elmarco/src/qq/tests/qapi-schema/test-qapi.py", line 56,=
 in
>> >   <module>
>> >     schema =3D QAPISchema(sys.argv[1])
>> >   File "/home/elmarco/src/qq/scripts/qapi.py", line 1470, in __init__
>> >     self.exprs =3D check_exprs(parser.exprs)
>> >   File "/home/elmarco/src/qq/scripts/qapi.py", line 959, in check_exprs
>> >     check_alternate(expr, info)
>> >   File "/home/elmarco/src/qq/scripts/qapi.py", line 831, in check_alte=
rnate
>> >     % (name, key, types_seen[qtype]))
>> > KeyError: 'QTYPE_QSTRING'
>> >
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >  scripts/qapi.py                                  | 6 ++++--
>> >  tests/qapi-schema/alternate-conflict-string.json | 4 ++--
>> >  2 files changed, 6 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/scripts/qapi.py b/scripts/qapi.py
>> > index 8aa2775f12..a3ac799535 100644
>> > --- a/scripts/qapi.py
>> > +++ b/scripts/qapi.py
>> > @@ -825,10 +825,12 @@ def check_alternate(expr, info):
>> >              else:
>> >                  conflicting.add('QTYPE_QNUM')
>> >                  conflicting.add('QTYPE_QBOOL')
>> > -        if conflicting & set(types_seen):
>> > +        conflict =3D conflicting & set(types_seen)
>> > +        if conflict:
>> > +            conflict_qtype =3D list(conflict)[0]
>>=20
>> Converting from set to list just to extract an element is clumsly.
>> Let's use conflict.pop(), and eliminate the variable.  Can do on commit.
>
> I didn't realize that. thanks

I didn't know about .pop() either, but I went "there's *got* to be a
better way!" and searched the docs for it :)

[...]
