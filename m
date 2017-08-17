Received: from eggs.gnu.org ([2001:4830:134:3::10]:47899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1diU3D-0000si-0o
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:18:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1diU3B-000125-I2
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:18:07 -0400
Received: from mail-ua0-x231.google.com ([2607:f8b0:400c:c08::231]:38276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1diU3B-00011w-Cb
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:18:05 -0400
Received: by mail-ua0-x231.google.com with SMTP id y36so30444433uac.5
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 16:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
	<20170727154126.11339-2-marcandre.lureau@redhat.com>
	<87zib0j3n7.fsf@dusky.pond.sub.org>
In-Reply-To: <87zib0j3n7.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 17 Aug 2017 23:17:53 +0000
Message-ID: <CAJ+F1CJbjFejyUA_P6ZO5_kEJKXjoiF2AE7oL4C06dsoPTWQYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/26] qapi: fix type_seen key error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

On Tue, Aug 15, 2017 at 4:41 PM Markus Armbruster <armbru@redhat.com> wrote=
:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > The type_seen member can be of a different type than the 'qtype' being
> > checked, since a string create several conflicts. Lookup the real
> > conflicting type in the conflict set, that one must be present in
> > type_seen.
> >
> > This fixes the following error, reproducible with the modified test:
> >
> > Traceback (most recent call last):
> >   File "/home/elmarco/src/qq/tests/qapi-schema/test-qapi.py", line 56,
> in <module>
> >     schema =3D QAPISchema(sys.argv[1])
> >   File "/home/elmarco/src/qq/scripts/qapi.py", line 1470, in __init__
> >     self.exprs =3D check_exprs(parser.exprs)
> >   File "/home/elmarco/src/qq/scripts/qapi.py", line 959, in check_exprs
> >     check_alternate(expr, info)
> >   File "/home/elmarco/src/qq/scripts/qapi.py", line 831, in
> check_alternate
> >     % (name, key, types_seen[qtype]))
> > KeyError: 'QTYPE_QSTRING'
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  scripts/qapi.py                                  | 4 +++-
> >  tests/qapi-schema/alternate-conflict-string.json | 4 ++--
> >  2 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/scripts/qapi.py b/scripts/qapi.py
> > index 8aa2775f12..4ecc19e944 100644
> > --- a/scripts/qapi.py
> > +++ b/scripts/qapi.py
> > @@ -825,7 +825,9 @@ def check_alternate(expr, info):
> >              else:
> >                  conflicting.add('QTYPE_QNUM')
> >                  conflicting.add('QTYPE_QBOOL')
> > -        if conflicting & set(types_seen):
> > +        conflict =3D conflicting & set(types_seen)
> > +        if conflict:
> > +            qtype =3D list(conflict)[0]
> >              raise QAPISemError(info, "Alternate '%s' member '%s' can't=
 "
> >                                 "be distinguished from member '%s'"
> >                                 % (name, key, types_seen[qtype]))
>
> I see.
>
> The fix is uninvasive, but I'm not thrilled by repurposing @qtype, and
> the meaning of list(dict) is less obvious than dict.keys().  What about
>

it's list(set) here


>
>            conflict =3D conflicting & set(types_seen)
>            if conflict:
>                conflicting_member_name =3D conflict.keys()[0]
>

so that doesn't work


>                raise QAPISemError(info, "Alternate '%s' member '%s' can't=
 "
>                                   "be distinguished from member '%s'"
>                                   % (name, key, conflicting_member_name))
>
> Alternatively, list all conflicting names (I wouldn't bother).
>

That would be less accurate than today, and it's just a single qtype
assignment away. Let's call it conflict_qtype if you prefer.


>
> > diff --git a/tests/qapi-schema/alternate-conflict-string.json
> b/tests/qapi-schema/alternate-conflict-string.json
> > index 85adbd4adc..bb2702978e 100644
> > --- a/tests/qapi-schema/alternate-conflict-string.json
> > +++ b/tests/qapi-schema/alternate-conflict-string.json
> > @@ -1,4 +1,4 @@
> >  # alternate branches of 'str' type conflict with all scalar types
> >  { 'alternate': 'Alt',
> > -  'data': { 'one': 'str',
> > -            'two': 'int' } }
> > +  'data': { 'one': 'int',
> > +            'two': 'str' } }
>
> I had to think for several minutes to convince myself that this is a
> better test, not just a test that happens to demonstrate a particular
> bug.  It's hot, I'm slow :)
>
> --
Marc-Andr=C3=A9 Lureau
