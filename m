Received: from eggs.gnu.org ([2001:4830:134:3::10]:46952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dpanL-0001mn-52
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 09:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dpanF-0003qr-LB
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 09:55:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dpanF-0003qR-Fi
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 09:55:01 -0400
Date: Wed, 6 Sep 2017 09:55:00 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <219850500.9239913.1504706100152.JavaMail.zimbra@redhat.com>
In-Reply-To: <87efrk54kf.fsf@dusky.pond.sub.org>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-29-marcandre.lureau@redhat.com>
	<87bmmphwdz.fsf@dusky.pond.sub.org>
	<622608851.9114372.1504699766400.JavaMail.zimbra@redhat.com>
	<87efrk54kf.fsf@dusky.pond.sub.org>
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

Hi

----- Original Message -----
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
> > ----- Original Message -----
> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> >>=20
> >> > The C standard has the initial value at 0 and the subsequent values
> >> > incremented by 1. No need to set this explicitely.
> >> >
> >> > This will prevent from artificial "gaps" when compiling out some enu=
m
> >> > values and having unnecessarily large MAX values & enums arrays.
> >>=20
> >> Yes, but it also risks entertaining mishaps like compiling this one
> >>=20
> >>     typedef enum Color {
> >>         COLOR_WHITE,
> >> #if defined(NEED_CPU_H)
> >> #if defined(TARGET_S390X)
> >>         COLOR_BLUE,
> >> #endif /* defined(TARGET_S390X) */
> >> #endif /* defined(NEED_CPU_H) */
> >>         COLOR_BLACK,
> >>     } Color;
> >>=20
> >> in s390x-code (COLOR_BLACK =3D 2) and in target-independent code
> >> (COLOR_BLACK =3D 1), then linking the two together.
> >
> > This is also true with other kind of types, like struct.
> >
> > One of the main reason why we should have schemas for target-only and t=
he
> > NEED_CPU_H is a temporary working hack.
>=20
> A temporary hack that's ugly or occasionally breaks in an obvious way is
> okay, but this is an open deathtrap.  I'm afraid we need to rethink our
> short term conditional code generation strategy.
>=20
> Stupidest solution that could possibly work: apply conditionals *only*
> to qmp-introspect.c, leave everything unconditional elsewhere.  What do
> you think?

That's not what I had in mind when I started. My first 45 loc approach woul=
d have saved us a lot of troubles :)

I would rather fix this, and split the schema. I'll investigate.
