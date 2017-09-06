Received: from eggs.gnu.org ([2001:4830:134:3::10]:38354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dpZ9B-0004KW-M4
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:09:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dpZ96-0007Qz-Vi
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:09:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dpZ96-0007Qg-P9
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:09:28 -0400
Date: Wed, 6 Sep 2017 08:09:26 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <622608851.9114372.1504699766400.JavaMail.zimbra@redhat.com>
In-Reply-To: <87bmmphwdz.fsf@dusky.pond.sub.org>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-29-marcandre.lureau@redhat.com>
	<87bmmphwdz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 28/54] qapi: do not define enumeration
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
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>



----- Original Message -----
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
> > The C standard has the initial value at 0 and the subsequent values
> > incremented by 1. No need to set this explicitely.
> >
> > This will prevent from artificial "gaps" when compiling out some enum
> > values and having unnecessarily large MAX values & enums arrays.
>=20
> Yes, but it also risks entertaining mishaps like compiling this one
>=20
>     typedef enum Color {
>         COLOR_WHITE,
> #if defined(NEED_CPU_H)
> #if defined(TARGET_S390X)
>         COLOR_BLUE,
> #endif /* defined(TARGET_S390X) */
> #endif /* defined(NEED_CPU_H) */
>         COLOR_BLACK,
>     } Color;
>=20
> in s390x-code (COLOR_BLACK =3D 2) and in target-independent code
> (COLOR_BLACK =3D 1), then linking the two together.

This is also true with other kind of types, like struct.

One of the main reason why we should have schemas for target-only and the N=
EED_CPU_H is a temporary working hack.

>=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  scripts/qapi.py | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/scripts/qapi.py b/scripts/qapi.py
> > index 52099332f1..9d075440d3 100644
> > --- a/scripts/qapi.py
> > +++ b/scripts/qapi.py
> > @@ -1979,14 +1979,11 @@ typedef enum %(c_name)s {
> >  ''',
> >                  c_name=3Dc_name(name))
> > =20
> > -    i =3D 0
> >      for value in enum_values:
> >          ret +=3D mcgen('''
> > -    %(c_enum)s =3D %(i)d,
> > +    %(c_enum)s,
> >  ''',
> > -                     c_enum=3Dc_enum_const(name, value, prefix),
> > -                     i=3Di)
> > -        i +=3D 1
> > +                     c_enum=3Dc_enum_const(name, value, prefix))
> > =20
> >      ret +=3D mcgen('''
> >  } %(c_name)s;
>=20
