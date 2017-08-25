Received: from eggs.gnu.org ([2001:4830:134:3::10]:58221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dlEAx-0002A2-IR
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 08:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dlEAt-0000mI-NG
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 08:57:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dlEAt-0000lw-EK
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 08:57:23 -0400
Date: Fri, 25 Aug 2017 09:57:18 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170825125718.GG15315@localhost.localdomain>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-2-marcandre.lureau@redhat.com>
	<8760dc4231.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <8760dc4231.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

On Fri, Aug 25, 2017 at 08:02:26AM +0200, Markus Armbruster wrote:
> Conflicts with Eduardo's "[PATCH v2] qapi: Fix error handling code on
> alternate conflict".
> Message-Id: <20170717180926.14924-1-ehabkost@redhat.com>
>=20
> Marc-Andr=E9, could you have a look?  You can rebase your fix on top of
> Eduardo's, or merge the two into one commit.

Both patches seem to be fixing the same bug.

>=20
> Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
> > The type_seen member can be of a different type than the 'qtype' bein=
g
> > checked, since a string create several conflicts. Lookup the real
> > conflicting type in the conflict set, that one must be present in
> > type_seen.
> >
> > This fixes the following error, reproducible with the modified test:
> >
> > Traceback (most recent call last):
> >   File "/home/elmarco/src/qq/tests/qapi-schema/test-qapi.py", line 56=
, in <module>
> >     schema =3D QAPISchema(sys.argv[1])
> >   File "/home/elmarco/src/qq/scripts/qapi.py", line 1470, in __init__
> >     self.exprs =3D check_exprs(parser.exprs)
> >   File "/home/elmarco/src/qq/scripts/qapi.py", line 959, in check_exp=
rs
> >     check_alternate(expr, info)
> >   File "/home/elmarco/src/qq/scripts/qapi.py", line 831, in check_alt=
ernate
> >     % (name, key, types_seen[qtype]))
> > KeyError: 'QTYPE_QSTRING'
> >
> > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  scripts/qapi.py                                  | 6 ++++--
> >  tests/qapi-schema/alternate-conflict-string.json | 4 ++--
> >  2 files changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/scripts/qapi.py b/scripts/qapi.py
> > index 8aa2775f12..a3ac799535 100644
> > --- a/scripts/qapi.py
> > +++ b/scripts/qapi.py
> > @@ -825,10 +825,12 @@ def check_alternate(expr, info):
> >              else:
> >                  conflicting.add('QTYPE_QNUM')
> >                  conflicting.add('QTYPE_QBOOL')
> > -        if conflicting & set(types_seen):
> > +        conflict =3D conflicting & set(types_seen)
> > +        if conflict:
> > +            conflict_qtype =3D list(conflict)[0]
> >              raise QAPISemError(info, "Alternate '%s' member '%s' can=
't "
> >                                 "be distinguished from member '%s'"
> > -                               % (name, key, types_seen[qtype]))
> > +                               % (name, key, types_seen[conflict_qty=
pe]))
> >          for qt in conflicting:
> >              types_seen[qt] =3D key
> > =20
> > diff --git a/tests/qapi-schema/alternate-conflict-string.json b/tests=
/qapi-schema/alternate-conflict-string.json
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

--=20
Eduardo
